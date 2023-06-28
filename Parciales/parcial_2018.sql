-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Parcial_2018
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `Parcial_2018` ;

-- -----------------------------------------------------
-- Schema Parcial_2018
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Parcial_2018` DEFAULT CHARACTER SET utf8 ;
USE `Parcial_2018` ;

-- -----------------------------------------------------
-- Table `Parcial_2018`.`Trabajos`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Parcial_2018`.`Trabajos` ;

CREATE TABLE IF NOT EXISTS `Parcial_2018`.`Trabajos` (
  `idTrabajo` INT NOT NULL,
  `titulo` VARCHAR(100) NOT NULL,
  `duracion` INT NOT NULL DEFAULT 6,
  `area` VARCHAR(10) NOT NULL,
  `fechaPresentacion` DATE NOT NULL,
  `fechaAprobacion` DATE NOT NULL,
  `fechaFinalizacion` DATE NULL,
  PRIMARY KEY (`idTrabajo`))
ENGINE = InnoDB;

CREATE UNIQUE INDEX `titulo_UNIQUE` ON `Parcial_2018`.`Trabajos` (`titulo` ASC) VISIBLE;

ALTER TABLE `Parcial_2018`.`Trabajos`
ADD CONSTRAINT `Empleados_chk_1`
CHECK (`area` IN ('Hardware','Redes','Software'));
-- -----------------------------------------------------
-- Table `Parcial_2018`.`Personas`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Parcial_2018`.`Personas` ;

CREATE TABLE IF NOT EXISTS `Parcial_2018`.`Personas` (
  `dni` INT NOT NULL,
  `apellidos` VARCHAR(40) NOT NULL,
  `nombres` VARCHAR(40) NOT NULL,
  PRIMARY KEY (`dni`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Parcial_2018`.`Cargos`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Parcial_2018`.`Cargos` ;

CREATE TABLE IF NOT EXISTS `Parcial_2018`.`Cargos` (
  `idCargo` INT NOT NULL,
  `cargo` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`idCargo`))
ENGINE = InnoDB;

CREATE UNIQUE INDEX `cargo_UNIQUE` ON `Parcial_2018`.`Cargos` (`cargo` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `Parcial_2018`.`Profesores`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Parcial_2018`.`Profesores` ;

CREATE TABLE IF NOT EXISTS `Parcial_2018`.`Profesores` (
  `dni` INT NOT NULL,
  `idCargo` INT NOT NULL,
  PRIMARY KEY (`dni`),
  CONSTRAINT `fk_Profesores_Personas`
    FOREIGN KEY (`dni`)
    REFERENCES `Parcial_2018`.`Personas` (`dni`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Profesores_Cargos1`
    FOREIGN KEY (`idCargo`)
    REFERENCES `Parcial_2018`.`Cargos` (`idCargo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Profesores_Cargos1_idx` ON `Parcial_2018`.`Profesores` (`idCargo` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `Parcial_2018`.`Alumnos`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Parcial_2018`.`Alumnos` ;

CREATE TABLE IF NOT EXISTS `Parcial_2018`.`Alumnos` (
  `dni` INT NOT NULL,
  `cx` CHAR(7) NOT NULL,
  PRIMARY KEY (`dni`),
  CONSTRAINT `fk_Alumnos_Personas1`
    FOREIGN KEY (`dni`)
    REFERENCES `Parcial_2018`.`Personas` (`dni`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE UNIQUE INDEX `cx_UNIQUE` ON `Parcial_2018`.`Alumnos` (`cx` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `Parcial_2018`.`RolesEnTrabajos`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Parcial_2018`.`RolesEnTrabajos` ;

CREATE TABLE IF NOT EXISTS `Parcial_2018`.`RolesEnTrabajos` (
  `idTrabajo` INT NOT NULL,
  `dni` INT NOT NULL,
  `rol` VARCHAR(7) NOT NULL,
  `desde` DATE NOT NULL,
  `hasta` DATE NULL,
  `razon` VARCHAR(100) NULL,
  PRIMARY KEY (`idTrabajo`, `dni`),
  CONSTRAINT `fk_Profesores_has_Trabajos_Profesores1`
    FOREIGN KEY (`dni`)
    REFERENCES `Parcial_2018`.`Profesores` (`dni`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Profesores_has_Trabajos_Trabajos1`
    FOREIGN KEY (`idTrabajo`)
    REFERENCES `Parcial_2018`.`Trabajos` (`idTrabajo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Profesores_has_Trabajos_Trabajos1_idx` ON `Parcial_2018`.`RolesEnTrabajos` (`idTrabajo` ASC) VISIBLE;

CREATE INDEX `fk_Profesores_has_Trabajos_Profesores1_idx` ON `Parcial_2018`.`RolesEnTrabajos` (`dni` ASC) VISIBLE;

ALTER TABLE `Parcial_2018`.`RolesEnTrabajos`
ADD CONSTRAINT `RolesEnTrabajos_chk_1`
CHECK (`rol` IN ('Tutor','Cotutor','Jurado'));
-- -----------------------------------------------------
-- Table `Parcial_2018`.`AlumnosEnTrabajos`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Parcial_2018`.`AlumnosEnTrabajos` ;

CREATE TABLE IF NOT EXISTS `Parcial_2018`.`AlumnosEnTrabajos` (
  `idTrabajo` INT NOT NULL,
  `dni` INT NOT NULL,
  `desde` DATE NOT NULL,
  `hasta` DATE NULL,
  `razon` VARCHAR(100) NULL,
  PRIMARY KEY (`idTrabajo`, `dni`),
  CONSTRAINT `fk_Trabajos_has_Alumnos_Trabajos1`
    FOREIGN KEY (`idTrabajo`)
    REFERENCES `Parcial_2018`.`Trabajos` (`idTrabajo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Trabajos_has_Alumnos_Alumnos1`
    FOREIGN KEY (`dni`)
    REFERENCES `Parcial_2018`.`Alumnos` (`dni`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Trabajos_has_Alumnos_Alumnos1_idx` ON `Parcial_2018`.`AlumnosEnTrabajos` (`dni` ASC) VISIBLE;

CREATE INDEX `fk_Trabajos_has_Alumnos_Trabajos1_idx` ON `Parcial_2018`.`AlumnosEnTrabajos` (`idTrabajo` ASC) VISIBLE;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

USE parcial_2018;

-- delete from RolesEnTrabajos;
-- delete from AlumnosEnTrabajos;
-- delete from Profesores;
-- delete from Cargos;
-- delete from Trabajos;
-- delete from Alumnos;
-- delete from Personas;

INSERT INTO Cargos VALUES(1, 'Titular');
INSERT INTO Cargos VALUES(2, 'Asociado');
INSERT INTO Cargos VALUES(3, 'Adjunto');
INSERT INTO Cargos VALUES(4, 'JTP');
INSERT INTO Cargos VALUES(5, 'ADG');

INSERT INTO Personas VALUES(1001, 'Mendiondo', 'Matías');
INSERT INTO Personas VALUES(1002, 'Odstrcil', 'Maximiliano');
INSERT INTO Personas VALUES(1003, 'Nieto', 'Luis');
INSERT INTO Personas VALUES(1004, 'Odstrcil', 'Gabriela');
INSERT INTO Personas VALUES(1005, 'Luccioni', 'Griselda');
INSERT INTO Personas VALUES(1006, 'Saade', 'Sergio');
INSERT INTO Personas VALUES(1007, 'Albaca', 'Carlos');
INSERT INTO Personas VALUES(1008, 'Nahas', 'Romina');
INSERT INTO Personas VALUES(1009, 'Cohen', 'Daniel');
INSERT INTO Personas VALUES(1010, 'Guzmán', 'Fernanda');
INSERT INTO Personas VALUES(1011, 'Sánchez', 'Mariana');
INSERT INTO Personas VALUES(1012, 'Juárez', 'Gustavo');
INSERT INTO Personas VALUES(1013, 'Menéndez', 'Franco');
INSERT INTO Personas VALUES(1014, 'Mitre', 'Marcelo');
INSERT INTO Personas VALUES(1015, 'Ferrao', 'Nilda');
INSERT INTO Personas VALUES(1016, 'Pérez', 'Jorge');
INSERT INTO Personas VALUES(1017, 'Volentini', 'Esteban');
INSERT INTO Personas VALUES(1018, 'Nader', 'Fernando');
INSERT INTO Personas VALUES(1019, 'Rossi', 'Guillermo');
INSERT INTO Personas VALUES(1020, 'Pacheco', 'Fabián');
INSERT INTO Personas VALUES(1021, 'Cardozo', 'Teresa');
INSERT INTO Personas VALUES(1, 'Ortíz', 'Juan Pablo');
INSERT INTO Personas VALUES(2, 'Ledesma', 'Facundo');
INSERT INTO Personas VALUES(3, 'Pary', 'Nélson Guillermo');
INSERT INTO Personas VALUES(4, 'Albarracín', 'María Carolina');
INSERT INTO Personas VALUES(5, 'Bono', 'Gustavo');
INSERT INTO Personas VALUES(6, 'Uezen', 'Héctor');
INSERT INTO Personas VALUES(7, 'Mariné', 'Juan Luis');
INSERT INTO Personas VALUES(8, 'Sfriso', 'Mauricio');
INSERT INTO Personas VALUES(30357705, 'Guanco', 'Juan Marcos');
INSERT INTO Personas VALUES(10, 'Gómez Salas', 'Pablo');
INSERT INTO Personas VALUES(11, 'Ferrari', 'Franco');
INSERT INTO Personas VALUES(12, 'Rodríguez', 'Jorge Luis');
INSERT INTO Personas VALUES(13, 'Córdoba', 'Facundo Sebastián');


INSERT INTO Profesores VALUES(1001, 5);
INSERT INTO Profesores VALUES(1002, 2);
INSERT INTO Profesores VALUES(1003, 2);
INSERT INTO Profesores VALUES(1004, 4);
INSERT INTO Profesores VALUES(1005, 1);
INSERT INTO Profesores VALUES(1006, 1);
INSERT INTO Profesores VALUES(1007, 4);
INSERT INTO Profesores VALUES(1008, 3);
INSERT INTO Profesores VALUES(1009, 1);
INSERT INTO Profesores VALUES(1010, 3);
INSERT INTO Profesores VALUES(1011, 3);
INSERT INTO Profesores VALUES(1012, 2);
INSERT INTO Profesores VALUES(1013, 3);
INSERT INTO Profesores VALUES(1014, 3);
INSERT INTO Profesores VALUES(1015, 2);
INSERT INTO Profesores VALUES(1016, 2);
INSERT INTO Profesores VALUES(1017, 3);
INSERT INTO Profesores VALUES(1018, 3);
INSERT INTO Profesores VALUES(1019, 5);
INSERT INTO Profesores VALUES(1020, 5);
INSERT INTO Profesores VALUES(1021, 4);

INSERT INTO Alumnos VALUES(1, '1414641');
INSERT INTO Alumnos VALUES(2, '1412969');
INSERT INTO Alumnos VALUES(3, '1414822');
INSERT INTO Alumnos VALUES(4, '1408513');
INSERT INTO Alumnos VALUES(5, '1409492');
INSERT INTO Alumnos VALUES(6, '1417417');
INSERT INTO Alumnos VALUES(7, '1413513');
INSERT INTO Alumnos VALUES(8, '1416773');
INSERT INTO Alumnos VALUES(30357705, '0303890');
INSERT INTO Alumnos VALUES(10, '1411805');
INSERT INTO Alumnos VALUES(11, '1411300');
INSERT INTO Alumnos VALUES(12, '1415802');
INSERT INTO Alumnos VALUES(13, '1410486');

INSERT INTO Trabajos VALUES(1, 'Sistema de Gestión de Presupuestación de Obras de Construcción', 6, 'Software', '2018-05-04', '2018-05-24', NULL);
INSERT INTO Trabajos VALUES(2, 'Implementación de políticas de tráfico para enrutamiento con BGP', 6, 'Redes', '2018-05-04', '2018-05-24', NULL);
INSERT INTO Trabajos VALUES(3, 'Sistema de Gestión y Seguimiento de Trabajos de Graduación de Ingeniería en Computación', 9, 'Software', '2015-12-15', '2015-12-15', NULL);
INSERT INTO Trabajos VALUES(4, 'Sistema de gestión y página web para una escuela de cocina', 6, 'Software', '2017-04-03', '2017-04-03', NULL);
INSERT INTO Trabajos VALUES(5, 'Módulo de interfaz de usuario de sistema SCADA', 6, 'Software', '2018-05-09', '2018-05-24', NULL);
INSERT INTO Trabajos VALUES(6, 'Realización de filtros digitales empleando operador delta', 5, 'Software', '2014-04-16', '2014-05-13', NULL);
INSERT INTO Trabajos VALUES(7, 'Sistema de seguimiento de egresados', 6, 'Software', '2018-03-01', '2018-05-24', NULL);
INSERT INTO Trabajos VALUES(8, 'Sistema gestor para farmacia de Centro Asistencia Primaria de Salud (CAPS)', 6, 'Software', '2017-11-29', '2017-11-29', NULL);

INSERT INTO RolesEnTrabajos VALUES(1, 1001, 'Tutor', '2018-05-24', NULL, NULL);
INSERT INTO RolesEnTrabajos VALUES(1, 1002, 'Cotutor', '2018-05-24', NULL, NULL);
INSERT INTO RolesEnTrabajos VALUES(1, 1003, 'Jurado', '2018-05-24', NULL, NULL);
INSERT INTO RolesEnTrabajos VALUES(1, 1004, 'Jurado', '2018-05-24', NULL, NULL);
INSERT INTO RolesEnTrabajos VALUES(1, 1005, 'Jurado', '2018-05-24', NULL, NULL);
INSERT INTO RolesEnTrabajos VALUES(2, 1018, 'Tutor', '2018-05-24', NULL, NULL);
INSERT INTO RolesEnTrabajos VALUES(2, 1006, 'Jurado', '2018-05-24', NULL, NULL);
INSERT INTO RolesEnTrabajos VALUES(2, 1007, 'Jurado', '2018-05-24', NULL, NULL);
INSERT INTO RolesEnTrabajos VALUES(2, 1008, 'Jurado', '2018-05-24', NULL, NULL);
INSERT INTO RolesEnTrabajos VALUES(3, 1012, 'Tutor', '2015-12-15', NULL, NULL);
INSERT INTO RolesEnTrabajos VALUES(3, 1013, 'Cotutor', '2015-12-15', NULL, NULL);
INSERT INTO RolesEnTrabajos VALUES(3, 1003, 'Jurado', '2015-12-15', NULL, NULL);
INSERT INTO RolesEnTrabajos VALUES(3, 1009, 'Jurado', '2015-12-15', NULL, NULL);
INSERT INTO RolesEnTrabajos VALUES(3, 1006, 'Jurado', '2015-12-15', NULL, NULL);
INSERT INTO RolesEnTrabajos VALUES(4, 1007, 'Tutor', '2017-04-03', NULL, NULL);
INSERT INTO RolesEnTrabajos VALUES(4, 1003, 'Jurado', '2017-04-03', NULL, NULL);
INSERT INTO RolesEnTrabajos VALUES(4, 1010, 'Jurado', '2017-04-03', NULL, NULL);
INSERT INTO RolesEnTrabajos VALUES(4, 1011, 'Jurado', '2017-04-03', NULL, NULL);
INSERT INTO RolesEnTrabajos VALUES(5, 1019, 'Tutor', '2018-05-24', NULL, NULL);
INSERT INTO RolesEnTrabajos VALUES(5, 1002, 'Cotutor', '2018-05-24', NULL, NULL);
INSERT INTO RolesEnTrabajos VALUES(5, 1003, 'Jurado', '2018-05-24', NULL, NULL);
INSERT INTO RolesEnTrabajos VALUES(5, 1012, 'Jurado', '2018-05-24', NULL, NULL);
INSERT INTO RolesEnTrabajos VALUES(5, 1014, 'Jurado', '2018-05-24', NULL, NULL);
INSERT INTO RolesEnTrabajos VALUES(6, 1020, 'Tutor', '2014-05-13', NULL, NULL);
INSERT INTO RolesEnTrabajos VALUES(6, 1015, 'Jurado', '2014-05-13', NULL, NULL);
INSERT INTO RolesEnTrabajos VALUES(6, 1016, 'Jurado', '2014-05-13', NULL, NULL);
INSERT INTO RolesEnTrabajos VALUES(6, 1017, 'Jurado', '2014-05-13', NULL, NULL);
INSERT INTO RolesEnTrabajos VALUES(7, 1003, 'Tutor', '2018-05-24', NULL, NULL);
INSERT INTO RolesEnTrabajos VALUES(7, 1009, 'Jurado', '2018-05-24', NULL, NULL);
INSERT INTO RolesEnTrabajos VALUES(7, 1010, 'Jurado', '2018-05-24', NULL, NULL);
INSERT INTO RolesEnTrabajos VALUES(7, 1011, 'Jurado', '2018-05-24', NULL, NULL);
INSERT INTO RolesEnTrabajos VALUES(8, 1010, 'Tutor', '2017-11-29', NULL, NULL);
INSERT INTO RolesEnTrabajos VALUES(8, 1021, 'Cotutor', '2017-11-29', NULL, NULL);
INSERT INTO RolesEnTrabajos VALUES(8, 1003, 'Jurado', '2017-11-29', NULL, NULL);
INSERT INTO RolesEnTrabajos VALUES(8, 1004, 'Jurado', '2017-11-29', NULL, NULL);
INSERT INTO RolesEnTrabajos VALUES(8, 1011, 'Jurado', '2017-11-29', NULL, NULL);

INSERT INTO AlumnosEnTrabajos VALUES(1, 1, '2018-05-24', NULL, NULL);
INSERT INTO AlumnosEnTrabajos VALUES(1, 2, '2018-05-24', NULL, NULL);
INSERT INTO AlumnosEnTrabajos VALUES(2, 3, '2018-05-24', NULL, NULL);
INSERT INTO AlumnosEnTrabajos VALUES(3, 4, '2015-12-15', NULL, NULL);
INSERT INTO AlumnosEnTrabajos VALUES(4, 5, '2017-04-03', NULL, NULL);
INSERT INTO AlumnosEnTrabajos VALUES(4, 6, '2017-04-03', NULL, NULL);
INSERT INTO AlumnosEnTrabajos VALUES(5, 7, '2018-05-24', NULL, NULL);
INSERT INTO AlumnosEnTrabajos VALUES(5, 8, '2018-05-24', NULL, NULL);
INSERT INTO AlumnosEnTrabajos VALUES(6, 30357705, '2014-05-13', NULL, NULL);
INSERT INTO AlumnosEnTrabajos VALUES(7, 10, '2018-05-24', NULL, NULL);
INSERT INTO AlumnosEnTrabajos VALUES(7, 11, '2018-05-24', NULL, NULL);
INSERT INTO AlumnosEnTrabajos VALUES(8, 12, '2017-11-29', NULL, NULL);
INSERT INTO AlumnosEnTrabajos VALUES(6, 13, '2017-11-29', NULL, NULL);

/*******************************************************************************
1) Crear un procedimiento llamado DetalleRoles, que reciba un rango de años y que muestre:
Año, DNI, Apellidos, Nombres, Tutor, Cotutor y Jurado, donde Tutor, Cotutor y Jurado muestran
la cantidad de trabajos en los que un profesor participó en un trabajo con ese rol entre el rango
de fechas especificado. El listado se mostrará ordenado por año, apellidos, nombres y DNI (se
pueden emplear vistas u otras estructuras para lograr la funcionalidad solicitada. Para obtener
el año de una fecha se puede emplear la función YEAR() [30].
********************************************************************************/
DROP PROCEDURE IF EXISTS DetalleRoles;

DELIMITER //

CREATE PROCEDURE DetalleRoles(pDesde DATE, pHasta DATE)
FINAL:
BEGIN

    DECLARE fechaAux DATE;

    IF pHasta IS NULL THEN
        SET pHasta = CURDATE(); -- Asigna la fecha actual si el parámetro pHasta es nulo
    END IF;


    IF pDesde > pHasta AND pDesde IS NOT NULL THEN -- se invierten las fechas
        SET fechaAux = pDesde;
        SET pDesde = pHasta;
        SET pHasta = fechaAux;
    END IF;

    select YEAR(RET.desde)                    
		   Anio,
           P.dni,
           P2.apellidos,
           P2.nombres,
           SUM(IF(RET.rol = 'Tutor', 1, 0))   'Tutor',
           SUM(IF(RET.rol = 'Cotutor', 1, 0)) 'Cotutor',
           SUM(IF(RET.rol = 'Jurado', 1, 0))  'Jurado'
    FROM Profesores P
             join RolesEnTrabajos RET on P.dni = RET.dni
             join Personas P2 on P2.dni = P.dni
    WHERE year(desde) between YEAR(pDesde) AND (YEAR(pHasta)) OR (pDesde IS NULL AND desde < pHasta )
    GROUP BY Anio, P.dni, P2.apellidos, P2.nombres
    ORDER BY Anio, P2.apellidos, P2.nombres;

END //

DELIMITER ;

CALL DetalleRoles('2021-1-1', '2018-1-2'); -- Corregir que reciba anio

/*3. Crear un procedimiento almacenado llamado NuevoTrabajo, para que agregue un trabajo
nuevo. El procedimiento deberá efectuar las comprobaciones necesarias (incluyendo que la
fecha de aprobación sea igual o mayor a la de presentación) y devolver los mensajes
correspondientes (uno por cada condición de error, y otro por el éxito) [15].*/

DROP PROCEDURE IF EXISTS `NuevoTrabajo`;
DELIMITER //

CREATE PROCEDURE `NuevoTrabajo`(pTitulo varchar(100), pDuracion INTEGER, pArea VARCHAR(10), pFechaPresentacion DATE,
                                pFechaAprobacion DATE, out pMensaje varchar(256))
FINAL:
BEGIN
    -- Descripcion
    /*

    */
    -- Declaraciones
    DECLARE vUltimoID INT;

    -- Exception handler
    DECLARE EXIT HANDLER FOR SQLEXCEPTION -- lo puedo cambiar por el numero de la exception
        BEGIN
            -- SHOW ERRORS;
            SET pMensaje = 'Error en la transacción. Contáctese con el administrador.';
            ROLLBACK;
        END;

    IF pTitulo IS NULL OR trim(pTitulo) = '' OR pDuracion IS NULL or pArea IS NULL OR pFechaPresentacion IS NULL OR
       pFechaAprobacion IS NULL THEN
        SET pMensaje = 'Error ningun parametro puede ser nulo';
        LEAVE FINAL;
    END IF;

    IF pFechaPresentacion > pFechaAprobacion THEN
        SET pMensaje = 'Error la fecha de presentacion no puede ser posterior a la fecha de aprobacion';
        LEAVE FINAL;
    END IF;


    IF pDuracion <= 0 THEN
        SET pMensaje = 'La duracion no puede ser menor o igual a cero';
        LEAVE FINAL;
    END IF;

    IF EXISTS(SELECT titulo FROM Trabajos WHERE titulo = pTitulo) THEN
        SET pMensaje = 'No puede haber titulos repetidos';
        LEAVE FINAL;
    END IF;

    IF pArea NOT IN ('Hardware', 'Redes', 'Software') THEN
        SET pMensaje = 'ERROR Area debe ser Hardware, Redes o Software';
        LEAVE FINAL;
    END IF;

    SET vUltimoID = (SELECT COALESCE(MAX(idTrabajo), 1) FROM Trabajos);

    INSERT INTO Trabajos (idTrabajo, titulo,duracion,area, fechaPresentacionn, fechaAprobacion)
    VALUES (vUltimoID + 1, pTitulo, pDuracion,pArea, pFechaPresentacion, pFechaAprobacion);

    SET pMensaje = 'Insercion exitosa';

END //


DELIMITER ;

SELECT * FROM Trabajos;
CALL NuevoTrabajo('Sistema Fausto', 6, 'Software', '2022-06-22', '2023-06-22', NULL, @mensaje);
SELECT @mensaje;
 
SELECT * FROM Trabajos;


-- PUNTO 3

DROP PROCEDURE IF EXISTS NuevoTrabajo;
DELIMITER //

CREATE PROCEDURE NuevoTrabajo(pTitulo varchar(100), pDuracion INTEGER, pArea VARCHAR(10), pFechaPresentacion DATE,
                                pFechaAprobacion DATE, out pMensaje varchar(256))
FINAL:
BEGIN
    -- Descripcion
    
    -- Declaraciones
    DECLARE vUltimoID INT;

    -- Exception handler
    DECLARE EXIT HANDLER FOR SQLEXCEPTION -- lo puedo cambiar por el numero de la exception
        BEGIN
            -- SHOW ERRORS;
            SET pMensaje = 'Error en la transacción. Contáctese con el administrador.';
            ROLLBACK;
        END;

    IF pTitulo IS NULL OR trim(pTitulo) = '' OR pDuracion IS NULL or pArea IS NULL OR pFechaPresentacion IS NULL OR
       pFechaAprobacion IS NULL THEN
        SET pMensaje = 'Error ningun parametro puede ser nulo';
        LEAVE FINAL;
    END IF;

    IF pFechaPresentacion > pFechaAprobacion THEN
        SET pMensaje = 'Error la fecha de presentacion no puede ser posterior a la fecha de aprobacion';
        LEAVE FINAL;
    END IF;


    IF pDuracion <= 0 THEN
        SET pMensaje = 'La duracion no puede ser menor o igual a cero';
        LEAVE FINAL;
    END IF;

    IF EXISTS(SELECT titulo FROM Trabajos WHERE titulo = pTitulo) THEN
        SET pMensaje = 'No puede haber titulos repetidos';
        LEAVE FINAL;
    END IF;

    IF pArea NOT IN ('Hardware', 'Redes', 'Software') THEN
        SET pMensaje = 'ERROR Area debe ser Hardware, Redes o Software';
        LEAVE FINAL;
    END IF;

    SET vUltimoID = (SELECT COALESCE(MAX(idTrabajo), 1) FROM Trabajos);

    INSERT INTO Trabajos (idTrabajo, titulo, area, fechaPresentacion, fechaAprobacion)
    VALUES (vUltimoID + 1, pTitulo, pArea, pFechaPresentacion, pFechaAprobacion);

    SET pMensaje = 'Insercion exitosa';

END //


DELIMITER ; 

CALL NuevoTrabajo('Sistema Fausto', 6, 'Software', '2022-06-22', '2023-06-22', NULL, @mensaje);
SELECT @mensaje;

/**********************************************************************************************/

/* 4.Realizar un trigger, llamado AuditarTrabajos, para que cuando se agregue un trabajo con una
duración superior a los 12 meses, o inferior a 3 meses, registre en una tabla de auditoría los
detalles del trabajo (todos los campos de la tabla Trabajos), el usuario que lo agregó y la fecha
en la que lo hizo [15].*/

DROP TABLE IF EXISTS `AuditoriaTrabajos` ;

CREATE TABLE IF NOT EXISTS `AuditoriaTrabajos` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `IDTrabajo` INT NOT NULL,
  `Titulo` VARCHAR(150) NOT NULL,
  `Duracion` INT NOT NULL,
  `FechaPresentacion` DATETIME NOT NULL,
  `FechaAprobacion` DATETIME NOT NULL,
  `FechaFinalizacion` DATETIME NULL,
  `Tipo` CHAR(1) NOT NULL, -- tipo de operación (I: Inserción, B: Borrado, M: Modificación)
  `Usuario` VARCHAR(45) NOT NULL,  
  `Maquina` VARCHAR(45) NOT NULL,  
  `Fecha` DATETIME NOT NULL,
  PRIMARY KEY (`ID`)
);

DELIMITER //
CREATE TRIGGER `AuditarTrabajos` 
AFTER INSERT ON `Trabajos` FOR EACH ROW
BEGIN
	IF Duracion > 12 OR Duracion < 3 THEN
		INSERT INTO AuditoriaTrabajos VALUES (
			DEFAULT, 
			NEW.IDTrabajo,
			NEW.Titulo, 
			NEW.Duracion,
			NEW.FechaPresentacion,
			NEW.FechaAprobacion,
			NEW.FechaFinalizacion,
			'I', 
			SUBSTRING_INDEX(USER(), '@', 1), 
			SUBSTRING_INDEX(USER(), '@', -1), 
			NOW()
	  );
	END IF;
END //
DELIMITER ;

