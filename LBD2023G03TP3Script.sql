--
-- Año: 2023 
-- Grupo Nro: 03 
-- Integrantes: Juarez Yelamos Fausto, Ruiz Francisco Mauricio
-- Tema: LyMInternet
-- Nombre del Esquema: LBD2023G03
-- Plataforma (SO + Versión): Windows 10
-- Motor y Versión: MySQL Server 8.0.31
-- GitHub Repositorio: LBD2023G03
-- GitHub Usuario: FaustoJuarez, mauruiz20

/* --------------------------------------------------------------------- */
/* 1. Auditoria para creacion, modificacion y borrado de usuarios. */
/* --------------------------------------------------------------------- */
DROP TABLE IF EXISTS `AuditoriaVendedores` ;

CREATE TABLE IF NOT EXISTS `AuditoriaVendedores` (
	`IdUsuario`      INT UNSIGNED    AUTO_INCREMENT,
	`Apellidos`      VARCHAR(60)     NOT NULL,
	`Nombres`        VARCHAR(60)     NOT NULL,
	`CUIL`           VARCHAR(11)     NOT NULL,
	`DNI`            VARCHAR(10)     NOT NULL,
	`Email`          VARCHAR(100)    NOT NULL,
	`Telefono`       VARCHAR(15)     NOT NULL,
	`Domicilio`      VARCHAR(100)    NOT NULL,
	`Cuenta`         VARCHAR(20)     NOT NULL,
	`Contrasenia`    CHAR(60)        NOT NULL,
	`Tipo` CHAR(2) NOT NULL, -- tipo de operación (I: Inserción, B: Borrado, M: Modificación)
	`Usuario` VARCHAR(45) NOT NULL,  
	`Maquina` VARCHAR(45) NOT NULL,  
	`Fecha` DATETIME NOT NULL,
  PRIMARY KEY (`IdUsuario`)
);
/* --------------------------------------------------------------------- */
/* 2. Trigger para que no pueda borrarse la Tabla de Auditorias */
/* --------------------------------------------------------------------- */
DROP TRIGGER IF EXISTS `Trig_AuditoriaVendedores_Borrado2`;

DELIMITER //
CREATE TRIGGER `Trig_AuditoriaVendedores_Borrado2` 
BEFORE DELETE ON `AuditoriaVendedores` FOR EACH ROW
BEGIN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: no se puede borrar de la tabla AuditoriaContadores';
END //
DELIMITER ;

/* -------------------------------------------------------------------------------- */
/* 3. Trigger creacion usuario vendedor */
/* -------------------------------------------------------------------------------- */

DROP TRIGGER IF EXISTS Trig_vendedor_insercion;

DELIMITER //
CREATE TRIGGER `Trig_vendedor_insercion` 
AFTER INSERT ON `vendedores` FOR EACH ROW
BEGIN
	INSERT INTO AuditoriaVendedores (`IdUsuario`,`Nombre`,`Apellido`,`CUIL`,`DNI`,`Email`,`Telefono`,`Domicilio`,`Cuenta`,`Contrasenia`,`Tipo`,`Usuario`,`Maquina`,`Fecha`) VALUES (
		DEFAULT,
		NEW.Nombre,
        NEW.Apellido,
        NEW.CUIL,
        NEW.DNI,
        NEW.Email,
        NEW.Telefono,
        NEW.Domicilio,
        NEW.Cuenta,
        NEW.Contrasenia,
		'I', 
		SUBSTRING_INDEX(USER(), '@', 1), 
		SUBSTRING_INDEX(USER(), '@', -1), 
		NOW()
  );
END //
DELIMITER ;

/* 4. Trigger modificacion usuario vendedor */
/* -------------------------------------------------------------------------------- */

DROP TRIGGER IF EXISTS Trig_vendedor_modificacion;

DELIMITER //
CREATE TRIGGER `Trig_vendedor_modificacion` 
AFTER INSERT ON `vendedores` FOR EACH ROW
BEGIN
    -- valores viejos
	INSERT INTO AuditoriaVendedores VALUES (
		DEFAULT,
		OLD.Nombre,
        OLD.Apellido,
        OLD.CUIL,
        OLD.DNI,
        OLD.Email,
        OLD.Telefono,
        OLD.Domicilio,
        OLD.Cuenta,
        OLD.Contrasenia,
		'MV', 
		SUBSTRING_INDEX(USER(), '@', 1), 
		SUBSTRING_INDEX(USER(), '@', -1), 
		NOW()
  );
  -- valores nuevos
  INSERT INTO AuditoriaVendedores VALUES (
		DEFAULT,
		NEW.Nombre,
        NEW.Apellido,
        NEW.CUIL,
        NEW.DNI,
        NEW.Email,
        NEW.Telefono,
        NEW.Domicilio,
        NEW.Cuenta,
        NEW.Contrasenia,
		'MN', 
		SUBSTRING_INDEX(USER(), '@', 1), 
		SUBSTRING_INDEX(USER(), '@', -1), 
		NOW()
   );
END //
DELIMITER ;

/* ----------------------------------------------------------------------------------------------------------------------------------------------------- */
/* 5.Trigger de Borrado de un Vendedor */
/* ----------------------------------------------------------------------------------------------------------------------------------------------------- */
DELIMITER //
CREATE TRIGGER `Trig_vendedores_borrado` 
AFTER DELETE ON `contadores` FOR EACH ROW
BEGIN
	INSERT INTO AuditoriaVendedores VALUES (
		DEFAULT,
		-- completar   
		'B', 
		SUBSTRING_INDEX(USER(), '@', 1), 
		SUBSTRING_INDEX(USER(), '@', -1), 
		NOW()
	);
END //
DELIMITER ;

/* ----------------------------------------------------------------------------------------------------------------------------------------------------- */
/* 6.Procedimiento almacenado para la Creación de un vendedor. */
/* ----------------------------------------------------------------------------------------------------------------------------------------------------- */
DROP PROCEDURE IF EXISTS CrearVendedor;

DELIMITER //
CREATE PROCEDURE CrearVendedor(
    pIdUsuario      INT UNSIGNED,
    pApellidos      VARCHAR(60),
    pNombres        VARCHAR(60),
    pCUIL           VARCHAR(11),
    pDNI            VARCHAR(10),
    pEmail          VARCHAR(100),
    pTelefono       VARCHAR(15),
    pDomicilio      VARCHAR(100),
    pCuenta         VARCHAR(20),
    pContrasenia    CHAR(60), 
   OUT Mensaje VARCHAR(100))
   
   
-- Crea un vendedor siempre y cuando no haya otro vendedor con el mismo CUIL 
BEGIN  
	IF (pApellidos IS NULL) OR (pNombres IS NULL) OR (pCUIL IS NULL) OR (pDNI IS NULL) OR (pEmail IS NULL)
    OR (pTelefono IS NULL) OR (pDomicilio IS NULL) OR (pCuenta IS NULL) OR (pContrasenia IS NULL) THEN
		SET Mensaje = 'Error en los datos del Vendedor';
	ELSEIF EXISTS (SELECT * FROM vendedores WHERE CUIL = pCUIL) THEN
		SET Mensaje = 'Ya existe un vendedor con ese CUIL';
	ELSE
		START TRANSACTION;
			INSERT INTO usuarios VALUES (pIdUsuario,pApellidos,pNombres,pCUIL,pDNI,pEmail,pTelefono,pDomicilio,pCuenta,pContrasenia);
			INSERT INTO vendedores VALUES (pIdUsuario);
		COMMIT;
		SET Mensaje = 'Vendedores creado';
    END IF;
END //
DELIMITER ;

/* ----------------------------------------------------------------------------------------------------------------------------------------------------- */
/* 7.Procedimiento almacenado para la Modificacion de un vendedor. */
/* ----------------------------------------------------------------------------------------------------------------------------------------------------- */
DROP PROCEDURE IF EXISTS ModificarVendedor;

DELIMITER //
CREATE PROCEDURE ModificarVendedor(pCUIL BIGINT(11),
   pIdUsuario      INT UNSIGNED,
    pApellidos      VARCHAR(60),
    pNombres        VARCHAR(60),
    pCUIL           VARCHAR(11),
    pDNI            VARCHAR(10),
    pEmail          VARCHAR(100),
    pTelefono       VARCHAR(15),
    pDomicilio      VARCHAR(100),
    pCuenta         VARCHAR(20),
    pContrasenia    CHAR(60), 
   OUT Mensaje VARCHAR(100))
   
-- Modifica un vendedor siempre y cuando no se inserten valores NULL en los atributos que no lo permiten
-- siempre que exista el vendedor con dicho CUIL 

BEGIN  
	IF (pApellidos IS NULL) OR (pNombres IS NULL) OR (pCUIL IS NULL) OR (pDNI IS NULL) OR (pEmail IS NULL)
    OR (pTelefono IS NULL) OR (pDomicilio IS NULL) OR (pCuenta IS NULL) OR (pContrasenia IS NULL) THEN
		SET Mensaje = 'Error en los datos del Vendedor';
	ELSEIF EXISTS (SELECT * FROM vendedores WHERE CUIL = pCUIL) THEN
		SET Mensaje = 'Ya existe un vendedor con ese CUIL';
	ELSE
		START TRANSACTION;
			UPDATE usuarios 
            SET Apellido=pApellido,Nombre=pNombre, CUIL=pCuil ,DNI=pDNI,  Email =pEmail,
            Telefono =pTelefono, Domicilio = pDomicilio, Cuenta = pCuenta, Contrasenia=pContrasenia
			WHERE CUIL = pCUIL; 
		COMMIT;
		SET Mensaje = 'Vendedor modificado';
    END IF;
END //
DELIMITER ;

/*
-- 6) Procedimiento almacenado para el Borrado de un Contador -- 

DROP PROCEDURE IF EXISTS BorrarContador;

DELIMITER //
CREATE PROCEDURE BorrarContador(pCUIL BIGINT(11),OUT Mensaje VARCHAR(100))
   
-- Borra un Contador siempre y cuando el CUIL no sea NULL
-- siempre que exista el Contador con dicho CUIL 

BEGIN  
	IF (pCUIL IS NULL) THEN
		SET Mensaje = 'Los valores ingresados no son validos';
	ELSEIF NOT EXISTS (SELECT * FROM contadores WHERE CUILContador = pCUIL) THEN
		SET Mensaje = 'No existe un contador con ese CUIL';
	ELSEIF ((SELECT COUNT(*) FROM contadores JOIN clientes ON CUILContador = Contador WHERE Contador = pCUIL) != 0) THEN
	SET Mensaje = 'No se puede eliminar con Contador con Clientes';
	ELSE
		START TRANSACTION;
			DELETE FROM contadores
            WHERE CUILContador = pCUIL;
            DELETE FROM personas
            WHERE CUILPers = pCUIL;
		COMMIT;
		SET Mensaje = 'Contador borrado';
    END IF;
END //
DELIMITER ;

CALL BorrarContador(27012345679,@Mensaje);
SELECT @Mensaje; 

SELECT * FROM AuditoriaContadores;

CALL BorrarContador(27458623145,@Mensaje);
SELECT @Mensaje; -- Deberia devolver que no existe un contador con ese CUIL

CALL BorrarContador(NULL,@Mensaje);
SELECT @Mensaje; -- Deberia devolver error pq no se acepta CUIL nulo

CALL BorrarContador(27402757383,@Mensaje);
SELECT @Mensaje; -- Deberia devolver error pq no se puede borrar un contador con clientes

-- 7) Procedimiento almacenado para Buscar un Contador por CUIL -- 

DROP PROCEDURE IF EXISTS BuscarContador;

DELIMITER //
CREATE PROCEDURE BuscarContador(pCUIL BIGINT(11),OUT Mensaje VARCHAR(100))
   
-- Busca un Contador siempre y cuando el CUIL no sea NULL
-- siempre que exista el Contador con dicho CUIL 

BEGIN  
    
	IF (pCUIL IS NULL) THEN
		SET Mensaje =  'El valor ingresado no es valido';
	ELSEIF NOT EXISTS (SELECT * FROM contadores WHERE CUILContador = pCUIL) THEN
		SET Mensaje = 'No existe un contador con ese CUIL';
	ELSE
			SELECT CUILContador AS CUIL, Apellido, Nombre, DNI, CorreoElectronico, Telefono, Domicilio, Localidad, Estado, Tipo, EsDueño AS Dueño FROM contadores JOIN personas ON CUILContador = CUILPers
            WHERE CUILContador = pCUIL;
            SET Mensaje = "Busqueda exitosa";
    END IF;
END //
DELIMITER ;

CALL BuscarContador(27402757383,@Mensaje); 
SELECT @Mensaje;

CALL BuscarContador(23547891254,@Mensaje); -- Deberia fallar pq no encuentra el CUIL
SELECT @Mensaje;

CALL BuscarContador(NULL,@Mensaje); -- Deberia fallar pq envio un NULL
SELECT @Mensaje;

-- 8) Prodecimiento almacenado para listar contadores, ordenados por el criterio que considere más adecuado.
-- Listo los contadores por Nombre y Apellido

DROP PROCEDURE IF EXISTS ListarContadores;

DELIMITER //
CREATE PROCEDURE ListarContadores()
   
BEGIN  
	SELECT concat_ws(' ',Apellido, personas.Nombre) AS 'Contadores'
    FROM contadores JOIN personas ON contadores.CUILContador = personas.CUILPers
    ORDER BY 1;
END //
DELIMITER ;

CALL ListarContadores();


-- 9) Dado un documento, mostrar su historial. El formato deberá ser: nombre del documento,
-- nombre del tipo de documento, apellido y nombre del contador que lo modificó, apellido y
-- nombre del cliente, fecha de la modificación y estado de la modificación. Ordenar por la
-- fecha en el orden cronológico.

DROP PROCEDURE IF EXISTS HistorialDoc;

DELIMITER //
CREATE PROCEDURE HistorialDoc(pIDDoc INT, OUT Mensaje VARCHAR(100))
   
-- El ID del documento no puede ser NULL y debe existir un documento con ese ID

BEGIN  
    
	IF (pIDDoc IS NULL) THEN
		SET Mensaje = 'El valor ingresado no es valido';
	ELSEIF NOT EXISTS (SELECT * FROM documentos WHERE idDocumento = pIDDoc) THEN
		SET Mensaje = 'No existe un documento con ese ID';
	ELSE
			-- Creamos una tabla temporal para obtener los clientes---
			DROP TABLE IF EXISTS tabla8;
            CREATE TEMPORARY TABLE tabla8 
			SELECT Nombre, Apellido, CUILCliente 
			FROM clientes
			JOIN personas ON clientes.CUILCliente=personas.CUILPers;

			-- Consulta para mostrar el historial en orden cronologico
			SELECT documentos.Nombre AS 'Nombre del Documento', tiposdocumento.TiposDocumento 'Tipo de documento', concat_ws(' ' ,personas.Apellido, personas.Nombre) 'Contador',
			concat_ws(' ',tabla8.Apellido, tabla8.Nombre) 'Cliente',HoraFechaModifContador 'Fecha/Hora Modificación',  vinculosdocumentos.Estado
			FROM tiposdocumento
			JOIN documentos ON tiposdocumento.IdTiposDocumento=documentos.TipoDocumento
			JOIN vinculosdocumentos ON documentos.IdDocumento=vinculosdocumentos.Documento
			JOIN contadores ON vinculosdocumentos.contador=contadores.CUILContador
			JOIN personas ON personas.CUILPers=contadores.CUILContador
			JOIN tabla8 ON tabla8.CUILCliente=vinculosdocumentos.cliente
			WHERE documentos.idDocumento=pIDDoc
			ORDER BY 5;
            SET Mensaje = "Historial encontrado";
    END IF;
END //
DELIMITER ;

CALL HistorialDoc(13,@Mensaje);
SELECT @Mensaje; 

CALL HistorialDoc(74,@Mensaje); -- Deberia fallar porque no existe un doc con ese ID
SELECT @Mensaje; 

CALL HistorialDoc(NULL,@Mensaje); -- Deberia fallar porque no se aceptan NULL
SELECT @Mensaje; 

-- 10) Realizar un procedimiento almacenado con alguna funcionalidad que considere de interes.

-- Mostrar un ranking de cuales son los Clientes con más empleados, esta vista sirve para poder determinar
-- cuales clientes poseen mayor cantidad de empleados y lograr una distribución equitativa de clientes a
-- cada contador, de manera que un único contador no tenga siempre los clientes con más empleados (conlleva más trabajo 
-- y el sueldo en el estudio no incluye comisiones).
 
 DROP PROCEDURE IF EXISTS RankingClientes;

DELIMITER //
CREATE PROCEDURE RankingClientes()
   
BEGIN  
	SELECT concat_ws(' ',personas.Apellido, personas.Nombre) 'Cliente', COUNT(*) AS 'N° de Empleados' FROM clientes 
	JOIN empleados ON clientes.CUILCliente=empleados.cliente
	JOIN personas ON clientes.CUILCliente=personas.CUILpers
	GROUP BY Apellido, personas.Nombre
	ORDER BY 2 DESC;
END //
DELIMITER ;

CALL RankingClientes(); */