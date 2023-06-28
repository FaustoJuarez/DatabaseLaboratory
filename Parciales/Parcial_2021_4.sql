-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Parcial_2021_4
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `Parcial_2021_4` ;

-- -----------------------------------------------------
-- Schema Parcial_2021_4
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Parcial_2021_4` DEFAULT CHARACTER SET utf8 ;
USE `Parcial_2021_4` ;

-- -----------------------------------------------------
-- Table `Parcial_2021_4`.`Direcciones`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Parcial_2021_4`.`Direcciones` ;

CREATE TABLE IF NOT EXISTS `Parcial_2021_4`.`Direcciones` (
  `idDireccion` INT NOT NULL,
  `calleYNumero` VARCHAR(50) NOT NULL,
  `codigoPostal` VARCHAR(10) NULL,
  `telefono` VARCHAR(25) NOT NULL,
  `municipiop` VARCHAR(25) NULL,
  PRIMARY KEY (`idDireccion`))
ENGINE = InnoDB;

CREATE UNIQUE INDEX `calleYNumero_UNIQUE` ON `Parcial_2021_4`.`Direcciones` (`calleYNumero` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `Parcial_2021_4`.`Empleados`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Parcial_2021_4`.`Empleados` ;

CREATE TABLE IF NOT EXISTS `Parcial_2021_4`.`Empleados` (
  `idEmpleado` INT NOT NULL,
  `nombres` VARCHAR(50) NOT NULL,
  `apellidos` VARCHAR(50) NOT NULL,
  `idDireccion` INT NOT NULL,
  `correo` VARCHAR(50) NULL,
  `estado` CHAR(1) NOT NULL DEFAULT 'E' CHECK (`estado` IN ('D','E')),
  PRIMARY KEY (`idEmpleado`),
  CONSTRAINT `fk_Empleados_Direcciones1`
    FOREIGN KEY (`idDireccion`)
    REFERENCES `Parcial_2021_4`.`Direcciones` (`idDireccion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Empleados_Direcciones1_idx` ON `Parcial_2021_4`.`Empleados` (`idDireccion` ASC) VISIBLE;

CREATE UNIQUE INDEX `correo_UNIQUE` ON `Parcial_2021_4`.`Empleados` (`correo` ASC) VISIBLE;

-- -----------------------------------------------------
-- Table `Parcial_2021_4`.`Actores`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Parcial_2021_4`.`Actores` ;

CREATE TABLE IF NOT EXISTS `Parcial_2021_4`.`Actores` (
  `idActor` CHAR(10) NOT NULL,
  `apellidos` VARCHAR(50) NULL,
  `nombres` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`idActor`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Parcial_2021_4`.`Peliculas`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Parcial_2021_4`.`Peliculas` ;

CREATE TABLE IF NOT EXISTS `Parcial_2021_4`.`Peliculas` (
  `idPelicula` INT NOT NULL,
  `titulo` VARCHAR(128) NOT NULL,
  `estreno` INT NULL,
  `duracion` INT NULL,
  `clasificacion` VARCHAR(5) NOT NULL DEFAULT 'G' CHECK (`clasificacion` IN ('G','PG','PG-13','R','NC-17')),
 
  PRIMARY KEY (`idPelicula`))
ENGINE = InnoDB;

CREATE UNIQUE INDEX `titulo_UNIQUE` ON `Parcial_2021_4`.`Peliculas` (`titulo` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `Parcial_2021_4`.`Sucursales`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Parcial_2021_4`.`Sucursales` ;

CREATE TABLE IF NOT EXISTS `Parcial_2021_4`.`Sucursales` (
  `idSucursal` CHAR(10) NOT NULL,
  `idDireccion` INT NOT NULL,
  `idGerente` INT NOT NULL,
  PRIMARY KEY (`idSucursal`),
  CONSTRAINT `fk_Sucursales_Direcciones`
    FOREIGN KEY (`idDireccion`)
    REFERENCES `Parcial_2021_4`.`Direcciones` (`idDireccion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Sucursales_Empleados1`
    FOREIGN KEY (`idGerente`)
    REFERENCES `Parcial_2021_4`.`Empleados` (`idEmpleado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Sucursales_Direcciones_idx` ON `Parcial_2021_4`.`Sucursales` (`idDireccion` ASC) VISIBLE;

CREATE INDEX `fk_Sucursales_Empleados1_idx` ON `Parcial_2021_4`.`Sucursales` (`idGerente` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `Parcial_2021_4`.`Inventario`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Parcial_2021_4`.`Inventario` ;

CREATE TABLE IF NOT EXISTS `Parcial_2021_4`.`Inventario` (
  `idInventario` INT NOT NULL,
  `idSucursal` CHAR(10) NOT NULL,
  `idPelicula` INT NOT NULL,
  PRIMARY KEY (`idInventario`),
  CONSTRAINT `fk_Inventario_Sucursales1`
    FOREIGN KEY (`idSucursal`)
    REFERENCES `Parcial_2021_4`.`Sucursales` (`idSucursal`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Inventario_Peliculas1`
    FOREIGN KEY (`idPelicula`)
    REFERENCES `Parcial_2021_4`.`Peliculas` (`idPelicula`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Inventario_Sucursales1_idx` ON `Parcial_2021_4`.`Inventario` (`idSucursal` ASC) VISIBLE;

CREATE INDEX `fk_Inventario_Peliculas1_idx` ON `Parcial_2021_4`.`Inventario` (`idPelicula` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `Parcial_2021_4`.`ActoresDePeliculas`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Parcial_2021_4`.`ActoresDePeliculas` ;

CREATE TABLE IF NOT EXISTS `Parcial_2021_4`.`ActoresDePeliculas` (
  `idActor` CHAR(10) NOT NULL,
  `idPelicula` INT NOT NULL,
  PRIMARY KEY (`idActor`, `idPelicula`),
  CONSTRAINT `fk_Actores_has_Peliculas_Actores1`
    FOREIGN KEY (`idActor`)
    REFERENCES `Parcial_2021_4`.`Actores` (`idActor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Actores_has_Peliculas_Peliculas1`
    FOREIGN KEY (`idPelicula`)
    REFERENCES `Parcial_2021_4`.`Peliculas` (`idPelicula`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Actores_has_Peliculas_Peliculas1_idx` ON `Parcial_2021_4`.`ActoresDePeliculas` (`idPelicula` ASC) VISIBLE;

CREATE INDEX `fk_Actores_has_Peliculas_Actores1_idx` ON `Parcial_2021_4`.`ActoresDePeliculas` (`idActor` ASC) VISIBLE;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

/*Crear una vista llamada VPeliculasEnSucursales que muestre el título de las películas,
el código de la sucursal donde se encuentra, la calle y número de la sucursal y los datos del
gerente de la sucursal (formato: “apellido, nombre”). La salida deberá estar ordenada
alfabéticamente según el título de las películas. En caso que una misma película aparezca
varias veces en una misma sucursal, en la salida deberá aparecer una única vez. Incluir el
código con la llamada a la vista*/

DROP VIEW IF EXISTS VCantidadPeliculasEnSucursales;
CREATE VIEW VCantidadPeliculasEnSucursales AS
SELECT P.titulo AS 'Titulo',
       S.idSucursal,
       D.calleYNumero AS 'Calle y numero',
       COUNT(*) AS 'Cantidad',
       CONCAT(E.apellidos, ', ', E.nombres) AS 'Gerente'
FROM Peliculas P
JOIN Inventario I ON P.idPelicula = I.idPelicula
JOIN Sucursales S ON I.idSucursal = S.idSucursal
JOIN Direcciones D ON S.idDireccion = D.idDireccion
JOIN Empleados E ON S.idGerente = E.idEmpleado
GROUP BY P.idPelicula, S.idSucursal, D.calleYNumero
ORDER BY P.titulo ASC;

SELECT * FROM VCantidadPeliculasEnSucursales;

/*Realizar un procedimiento almacenado llamado ModificarPelicula para modificar una
película, incluyendo el control de errores lógicos y mensajes de error necesarios
(implementar la lógica del manejo de errores empleando parámetros de salida). Incluir el
código con la llamada al procedimiento probando todos los casos con datos incorrectos y
uno con datos correctos.*/

DROP PROCEDURE IF EXISTS ModificarPelicula;

DELIMITER //
/*`idPelicula` INT NOT NULL,
  `titulo` VARCHAR(128) NOT NULL,
  `estreno` INT NULL,
  `duracion` INT NULL,
  `clasificacion` VARCHAR(5)*/
CREATE PROCEDURE ModificarPelicula(
    pidPelicula INT,
    ptitulo VARCHAR(128), 
    pestreno INT,
    pduracion INT,
    pclasificacion VARCHAR(5),
    OUT pMensaje VARCHAR(256))
FINAL:
BEGIN
    -- Declaraciones
    DECLARE vCount INT;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        SET pMensaje = 'Error en la transacción. Contáctese con el administrador.';
        ROLLBACK;
    END;

    -- Verificar existencia de pelicula en inventario
    SELECT COUNT(*) INTO vCount FROM Inventario WHERE idPelicula = pidPelicula;

    IF vCount = 0 THEN
        SET pMensaje = 'Error: La pelicula no existe en el Inventario';
        LEAVE FINAL;
    END IF;

    IF ptitulo IS NULL OR pclasificacion IS NULL THEN
        SET pMensaje = 'Error: titulo, clasificacion no pueden ser nulos';
        LEAVE FINAL;
    END IF;

    START TRANSACTION;

    UPDATE Peliculas 
    SET idPelicula = pidPelicula, titulo = ptitulo, estreno = pestreno, duracion = pduracion, clasificacion=pclasificacion
    WHERE idPelicula = pidPelicula;

    SET pMensaje = 'Modificacion exitosa';
    COMMIT;

END //

DELIMITER ;

SELECT * FROM Peliculas ;
-- VALUES (1,'ACADEMY DINOSAUR',2006,86,'PG')

CALL ModificarPelicula(1,'Academia Dinosaurio',2006,90,'G',@pMensaje);
SELECT @pMensaje;

/*Realizar un procedimiento almacenado llamado BuscarPeliculasPorAutor que reciba el
código de un actor y muestre sucursal por sucursal, película por película, la cantidad con el
mismo. Por cada película del autor especificado se deberá mostrar su código y título, el
código de la sucursal, la cantidad y la calle y número de la sucursal. La salida deberá estar
ordenada alfabéticamente según el título de las películas. Incluir en el código la llamada al
procedimiento.*/
DROP PROCEDURE IF EXISTS BuscarPeliculasPorAutor;
DELIMITER //

CREATE PROCEDURE BuscarPeliculasPorAutor(IN codigoActor CHAR(10))
BEGIN
    SELECT p.idPelicula, p.titulo, s.idSucursal, COUNT(*) AS cantidad, d.calleYNumero
    FROM ActoresDePeliculas ap
    INNER JOIN Peliculas p ON ap.idPelicula = p.idPelicula
    INNER JOIN Sucursales s ON s.idSucursal = ANY (
        SELECT idSucursal
        FROM Inventario
        WHERE idPelicula = p.idPelicula
    )
    INNER JOIN Direcciones d ON d.idDireccion = s.idDireccion
    WHERE ap.idActor = codigoActor
    GROUP BY p.idPelicula, p.titulo, s.idSucursal, d.calleYNumero
    ORDER BY p.titulo ASC;
END //

DELIMITER ;

-- Llamar al procedimiento BuscarPeliculasPorAutor
CALL BuscarPeliculasPorAutor(140);


SELECT * FROM Peliculas JOIN ActoresDePeliculas JOIN Actores;

DROP PROCEDURE IF EXISTS BuscarPeliculasPorAutor;
DELIMITER //

CREATE PROCEDURE BuscarPeliculasPorAutor(IN pidActor CHAR(10))
BEGIN
    -- Tabla temporal para almacenar los peliculas del actor
    CREATE TEMPORARY TABLE IF NOT EXISTS temp_peliculas (
		idPelicula INT ,
		titulo VARCHAR(128),
		estreno INT ,
		duracion INT ,
		clasificacion VARCHAR(5)
        
    );
    
    -- Insertar todos los cuadros del pintor en la tabla temporal
    INSERT INTO temp_peliculas (idPelicula, titulo, estreno, duracion, clasificacion)
    SELECT P.idPelicula , P.titulo, S.idSucursal ,COUNT(P.idPelicula) AS 'Cantidad', D.calleYNumero AS 'Calle y Número'
        
    FROM Peliculas P
    JOIN ActoresDePeliculas ADP ON ADP.idPelicula = P.idPelicula
    JOIN Actores A ON A.idActor = ADP.idActor
    JOIN Inventario I ON P.idPelicula = I.idPelicula
    JOIN Sucursales S ON I.idSucursal = S.idSucursal
    JOIN Direcciones D ON S.idDireccion = D.idDireccion
    WHERE A.idActor = 137
    GROUP BY P.idPelicula, P.titulo,S.idSucursal,D.calleYNumero
    ORDER BY P.titulo DESC;
    
    -- Mostrar los resultados de la tabla temporal
    SELECT  idPelicula, titulo, estreno, duracion, clasificacion
    FROM temp_peliculas;
    
    -- Eliminar la tabla temporal
    DROP TABLE IF EXISTS temp_cuadros;
END //

DELIMITER ;

/*Utilizando triggers, implementar la lógica para que en caso que se quiera modificar una
dirección especificando la calle y número de otra dirección existente se informe mediante
un mensaje de error que no se puede. Incluir el código con la modificación de la calle y
número de una dirección con un valor distinto a cualquiera de las que ya hubiera definidas y
otro con un valor igual a otra que ya hubiera definida.*/

DROP TRIGGER IF EXISTS Direccion_before_update;
DELIMITER //
CREATE TRIGGER Direccion_before_update
    BEFORE UPDATE
    ON Direcciones
    FOR EACH ROW
BEGIN

    IF EXISTS(SELECT Direccion.idDirecciones FROM Direcciones WHERE Direcciones.calleYNumero = NEW.calleYNumero AND Direcciones.calleYNumero !=NEW.calleYNumero) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error el titulo ya existe';
    END IF;
END //

DELIMITER ;

select * from Direcciones;

update Direcciones
set municipiop = 'Tucuman'
where idDireccion=2;
