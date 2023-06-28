-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Parcial_2021_5
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `Parcial_2021_5` ;

-- -----------------------------------------------------
-- Schema Parcial_2021_5
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Parcial_2021_5` DEFAULT CHARACTER SET utf8 ;
USE `Parcial_2021_5` ;

-- -----------------------------------------------------
-- Table `Parcial_2021_5`.`Peliculas`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Parcial_2021_5`.`Peliculas` ;

CREATE TABLE IF NOT EXISTS `Parcial_2021_5`.`Peliculas` (
  `idPelicula` INT NOT NULL,
  `titulo` VARCHAR(128) NOT NULL,
  `estreno` INT NULL,
  `duracion` INT NULL,
  `clasificacion` VARCHAR(10) NOT NULL DEFAULT 'G' CHECK (`clasificacion` IN ('G','PG','PG-13','R','NC-17')),
  PRIMARY KEY (`idPelicula`))
ENGINE = InnoDB;

CREATE UNIQUE INDEX `titulo_UNIQUE` ON `Parcial_2021_5`.`Peliculas` (`titulo` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `Parcial_2021_5`.`Domicilios`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Parcial_2021_5`.`Domicilios` ;

CREATE TABLE IF NOT EXISTS `Parcial_2021_5`.`Domicilios` (
  `idDomicilio` INT NOT NULL,
  `calleYNumero` VARCHAR(50) NOT NULL,
  `municipio` VARCHAR(20) NOT NULL,
  `codigoPostal` VARCHAR(10) NULL,
  `telefono` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`idDomicilio`))
ENGINE = InnoDB;

CREATE UNIQUE INDEX `calleYNumero_UNIQUE` ON `Parcial_2021_5`.`Domicilios` (`calleYNumero` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `Parcial_2021_5`.`Tiendas`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Parcial_2021_5`.`Tiendas` ;

CREATE TABLE IF NOT EXISTS `Parcial_2021_5`.`Tiendas` (
  `idTienda` INT NOT NULL,
  `idDomicilio` INT NOT NULL,
  PRIMARY KEY (`idTienda`),
  CONSTRAINT `fk_Tiendas_Domicilios1`
    FOREIGN KEY (`idDomicilio`)
    REFERENCES `Parcial_2021_5`.`Domicilios` (`idDomicilio`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Tiendas_Domicilios1_idx` ON `Parcial_2021_5`.`Tiendas` (`idDomicilio` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `Parcial_2021_5`.`Registros`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Parcial_2021_5`.`Registros` ;

CREATE TABLE IF NOT EXISTS `Parcial_2021_5`.`Registros` (
  `idRegistro` INT NOT NULL,
  `idPelicula` INT NOT NULL,
  `idTienda` INT NOT NULL,
  PRIMARY KEY (`idRegistro`),
  CONSTRAINT `fk_Registros_Peliculas`
    FOREIGN KEY (`idPelicula`)
    REFERENCES `Parcial_2021_5`.`Peliculas` (`idPelicula`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Registros_Tiendas1`
    FOREIGN KEY (`idTienda`)
    REFERENCES `Parcial_2021_5`.`Tiendas` (`idTienda`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Registros_Peliculas_idx` ON `Parcial_2021_5`.`Registros` (`idPelicula` ASC) VISIBLE;

CREATE INDEX `fk_Registros_Tiendas1_idx` ON `Parcial_2021_5`.`Registros` (`idTienda` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `Parcial_2021_5`.`Clientes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Parcial_2021_5`.`Clientes` ;
--   `idCliente` `nombres`   `apellidos`  `idDomicilio` `correo`  `                   estado` ,
-- VALUES (1,    'MARY',          'SMITH',        5,     'MARY.SMITH@sakilacustomer.org','E')
CREATE TABLE IF NOT EXISTS `Parcial_2021_5`.`Clientes` (
  `idCliente` INT NOT NULL,
  `nombres` VARCHAR(45) NOT NULL,
  `apellidos` VARCHAR(45) NOT NULL,
  `idDomicilio` INT NOT NULL,
  `correo` VARCHAR(50) NULL,
  `estado` CHAR(1) NOT NULL DEFAULT 'E' CHECK (`estado` IN ('D','E')),
  PRIMARY KEY (`idCliente`),
  CONSTRAINT `fk_Clientes_Domicilios1`
    FOREIGN KEY (`idDomicilio`)
    REFERENCES `Parcial_2021_5`.`Domicilios` (`idDomicilio`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Clientes_Domicilios1_idx` ON `Parcial_2021_5`.`Clientes` (`idDomicilio` ASC) VISIBLE;

CREATE UNIQUE INDEX `correo_UNIQUE` ON `Parcial_2021_5`.`Clientes` (`correo` ASC) VISIBLE;

-- -----------------------------------------------------
-- Table `Parcial_2021_5`.`Alquileres`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Parcial_2021_5`.`Alquileres` ;

CREATE TABLE IF NOT EXISTS `Parcial_2021_5`.`Alquileres` (
  `idAlquiler` INT NOT NULL,
  `fechaAlquiler` DATETIME NOT NULL,
  `idRegistro` INT NOT NULL,
  `idCliente` INT NOT NULL,
  `fechaDevolucion` DATETIME NULL,
  PRIMARY KEY (`idAlquiler`),
  CONSTRAINT `fk_Alquileres_Clientes1`
    FOREIGN KEY (`idCliente`)
    REFERENCES `Parcial_2021_5`.`Clientes` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Alquileres_Registros1`
    FOREIGN KEY (`idRegistro`)
    REFERENCES `Parcial_2021_5`.`Registros` (`idRegistro`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Alquileres_Clientes1_idx` ON `Parcial_2021_5`.`Alquileres` (`idCliente` ASC) VISIBLE;

CREATE INDEX `fk_Alquileres_Registros1_idx` ON `Parcial_2021_5`.`Alquileres` (`idRegistro` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `Parcial_2021_5`.`Pagos`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Parcial_2021_5`.`Pagos` ;

CREATE TABLE IF NOT EXISTS `Parcial_2021_5`.`Pagos` (
  `idPago` INT NOT NULL,
  `idCliente` INT NOT NULL,
  `idAlquiler` INT NOT NULL,
  `importe` DECIMAL(5,2) NOT NULL,
  `fecha` DATETIME NOT NULL,
  PRIMARY KEY (`idPago`),
  CONSTRAINT `fk_Pagos_Alquileres1`
    FOREIGN KEY (`idAlquiler`)
    REFERENCES `Parcial_2021_5`.`Alquileres` (`idAlquiler`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Pagos_Clientes1`
    FOREIGN KEY (`idCliente`)
    REFERENCES `Parcial_2021_5`.`Clientes` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Pagos_Alquileres1_idx` ON `Parcial_2021_5`.`Pagos` (`idAlquiler` ASC) VISIBLE;

CREATE INDEX `fk_Pagos_Clientes1_idx` ON `Parcial_2021_5`.`Pagos` (`idCliente` ASC) VISIBLE;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

/*Crear una vista llamada VCantidadAlquileres que muestre por cada cliente su código,
apellido y nombre (formato: apellido, nombre), y la cantidad de alquileres que realizó. La
salida deberá estar ordenada alfabéticamente según el apellido y nombre del cliente. Incluir
el código con la consulta a la vista.*/

DROP VIEW IF EXISTS VCantidadAlquileres;
CREATE VIEW VCantidadAlquileres AS
SELECT C.idCliente,
       CONCAT(C.apellidos, ', ', C.nombres) AS 'Cliente',
       COUNT(A.idCliente)
       
FROM Clientes C
JOIN Alquileres A ON A.idCliente = C.idCliente
WHERE  A.idCliente = C.idCliente
GROUP BY C.idCliente
ORDER BY C.idCliente DESC;

SELECT * FROM VCantidadAlquileres;

/*Realizar un procedimiento almacenado llamado BorrarDomicilio para borrar un
domicilio, incluyendo el control de errores lógicos y mensajes de error necesarios
(implementar la lógica del manejo de errores empleando parámetros de salida). Incluir el
código con la llamada al procedimiento probando todos los casos con datos incorrectos y
uno con datos correctos.*/

DROP PROCEDURE IF EXISTS BorrarDomicilio;
DELIMITER //

CREATE PROCEDURE BorrarDomicilio(IN pidDomicilio INT)
BEGIN
  DECLARE domicilio_count INT;

  -- Verificar si el cuadro existe
  SELECT COUNT(*) INTO domicilio_count FROM Domicilios WHERE idDomicilio = pidDomicilio;

  -- Si el domicilio tiene tienda o cliente no se puede borrar
  IF EXISTS(SELECT Clientes.idDomicilio FROM Clientes WHERE Clientes.idDomicilio = pidDomicilio) OR 
	 EXISTS(SELECT Tiendas.idDomicilio FROM Tiendas WHERE Tiendas.idDomicilio = pidDomicilio)THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error una tienda o cliente tiene como referencia el domicilio que se desea eliminar';
    END IF;
  -- Si no se encuentra el domicilio, mostrar un mensaje de error
  IF domicilio_count = 0 THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El Domicilio especificado no existe.';
  ELSE
    -- Eliminar el cuadro
    DELETE FROM Domicilios WHERE idDomicilio = pidDomicilio;
    SELECT 'Domicilio eliminado correctamente.';
  END IF;
END //

DELIMITER ;


SELECT * FROM Domicilios D JOIN Clientes JOIN Tiendas order by D.idDomicilio DESC;
CALL BorrarDomicilio(800); -- Intentar borrar un cuadro inexistente
INSERT INTO Domicilios VALUES(606,'23 Calle Tucuman','Alberta','-','14033335568');
CALL BorrarDomicilio(606); -- Borrar un domicilio existente

CALL BorrarDomicilio(1); -- Borrar un domicilio de cliente o tienda


/*Realizar un procedimiento almacenado llamado TotalAlquileres que reciba el código de
un cliente y muestre alquiler por alquiler, película por película, la fecha del alquiler, el título
de la película, la fecha de devolución y la cantidad. La salida deberá estar ordenada en
orden cronológico inverso según la fecha de alquiler (del alquiler más reciente al más
antiguo). Incluir en el código la llamada al procedimiento.*/

DROP PROCEDURE IF EXISTS `TotalAlquileres`;
DELIMITER //

CREATE PROCEDURE `TotalAlquileres`(IN pidCliente INT)
FINAL:
BEGIN
    -- Descripcion
    /*

    */
    -- Declaraciones

    -- Exception handler
    SELECT A.idAlquiler, A.fechaAlquiler,P.titulo, A.fechaDevolucion, COUNT(R.idPelicula) AS Cantidad
	FROM Alquileres A
              JOIN Clientes C ON A.idCliente = C.idCliente
              JOIN Registros R ON A.idRegistro = R.idRegistro
              JOIN Peliculas P ON P.idPelicula = R.idPelicula
    WHERE C.idCliente = pidCliente
	GROUP BY A.idAlquiler,  A.fechaAlquiler,P.titulo, A.fechaDevolucion
    
    ORDER BY A.fechaAlquiler DESC;


END //


DELIMITER ;
SELECT * FROM Clientes;

CALL TotalAlquileres(1);

/*
Utilizando triggers, implementar la lógica para que en caso que se quiera crear un
domicilio ya existente según código y/o calle y número se informe mediante un mensaje de
error que no se puede. Incluir el código con las creaciones de domicilios existentes según
código y/o calle y número y otro inexistente.**/

DROP TRIGGER IF EXISTS Domicilio_before_update;
DELIMITER //
CREATE TRIGGER Domicilio_before_update
    BEFORE UPDATE
    ON Domicilios
    FOR EACH ROW
BEGIN

    IF EXISTS(SELECT Domicilios.idDomicilio FROM D WHERE Domicilios.idDomicilio = NEW.idDomicilio OR Domicilios.calleYNumero =NEW.calleYNumero) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error idDomicilio o calle y numero ya existe';
    END IF;
END //

DELIMITER ;
SELECT * FROM Domicilios;
INSERT INTO `Domicilios` VALUES (1,'47 MySakila Drive','Alberta','-','-');
INSERT INTO `Domicilios` VALUES (1,'Calle 1','Alberta','-','-');
INSERT INTO `Domicilios` VALUES (2,'47 MySakila Drive','Alberta','-','-');
INSERT INTO `Domicilios` VALUES (606,'Moreno','Alberta','-','-');