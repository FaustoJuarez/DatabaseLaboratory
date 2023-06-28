-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Parcial2020_3
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `Parcial2020_3` ;

-- -----------------------------------------------------
-- Schema Parcial2020_3
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Parcial2020_3` DEFAULT CHARACTER SET utf8 ;
USE `Parcial2020_3` ;

-- -----------------------------------------------------
-- Table `Parcial2020_3`.`Clases`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Parcial2020_3`.`Clases` ;

CREATE TABLE IF NOT EXISTS `Parcial2020_3`.`Clases` (
  `IDClase` INT NOT NULL,
  `Nombre` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`IDClase`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Parcial2020_3`.`Magnitudes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Parcial2020_3`.`Magnitudes` ;

CREATE TABLE IF NOT EXISTS `Parcial2020_3`.`Magnitudes` (
  `IDMagnitud` INT NOT NULL,
  `Nombre` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`IDMagnitud`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Parcial2020_3`.`Recetas`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Parcial2020_3`.`Recetas` ;

CREATE TABLE IF NOT EXISTS `Parcial2020_3`.`Recetas` (
  `IDReceta` INT NOT NULL,
  `Nombre` VARCHAR(35) NOT NULL,
  `Rendimiento` FLOAT NOT NULL CHECK (`Rendimiento`>0.0),
  `Clase` INT NOT NULL,
  `Magnitud` INT NOT NULL,
  `Procedimiento` VARCHAR(1000) NOT NULL,
  PRIMARY KEY (`IDReceta`),
  CONSTRAINT `fk_Recetas_Clases`
    FOREIGN KEY (`Clase`)
    REFERENCES `Parcial2020_3`.`Clases` (`IDClase`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Recetas_Magnitudes1`
    FOREIGN KEY (`Magnitud`)
    REFERENCES `Parcial2020_3`.`Magnitudes` (`IDMagnitud`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Recetas_Clases_idx` ON `Parcial2020_3`.`Recetas` (`Clase` ASC) VISIBLE;

CREATE INDEX `fk_Recetas_Magnitudes1_idx` ON `Parcial2020_3`.`Recetas` (`Magnitud` ASC) VISIBLE;

CREATE UNIQUE INDEX `Nombre_UNIQUE` ON `Parcial2020_3`.`Recetas` (`Nombre` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `Parcial2020_3`.`RecetaEnRecetas`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Parcial2020_3`.`RecetaEnRecetas` ;

CREATE TABLE IF NOT EXISTS `Parcial2020_3`.`RecetaEnRecetas` (
  `IDReceta` INT NOT NULL,
  `IDComponente` INT NOT NULL,
  `Medida` FLOAT NOT NULL CHECK (`Medida`>0.0),
  PRIMARY KEY (`IDReceta`, `IDComponente`),
  CONSTRAINT `fk_RecetaEnRecetas_Recetas1`
    FOREIGN KEY (`IDReceta`)
    REFERENCES `Parcial2020_3`.`Recetas` (`IDReceta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_RecetaEnRecetas_Recetas2`
    FOREIGN KEY (`IDComponente`)
    REFERENCES `Parcial2020_3`.`Recetas` (`IDReceta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_RecetaEnRecetas_Recetas2_idx` ON `Parcial2020_3`.`RecetaEnRecetas` (`IDComponente` ASC) VISIBLE;
CREATE INDEX `fk_RecetaEnRecetas_Recetas3_idx` ON `Parcial2020_3`.`RecetaEnRecetas` (`IDReceta` ASC) VISIBLE;

-- -----------------------------------------------------
-- Table `Parcial2020_3`.`Ingrediente`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Parcial2020_3`.`Ingrediente` ;

CREATE TABLE IF NOT EXISTS `Parcial2020_3`.`Ingrediente` (
  `IDIngrediente` INT NOT NULL,
  `Nombre` VARCHAR(35) NOT NULL,
  `Precio` FLOAT NOT NULL CHECK (`Precio`>0.0),
  `Magnitud` INT NOT NULL,
  PRIMARY KEY (`IDIngrediente`),
  CONSTRAINT `fk_Ingrediente_Magnitudes1`
    FOREIGN KEY (`Magnitud`)
    REFERENCES `Parcial2020_3`.`Magnitudes` (`IDMagnitud`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Ingrediente_Magnitudes1_idx` ON `Parcial2020_3`.`Ingrediente` (`Magnitud` ASC) VISIBLE;

CREATE UNIQUE INDEX `Nombre_UNIQUE` ON `Parcial2020_3`.`Ingrediente` (`Nombre` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `Parcial2020_3`.`Composicion`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Parcial2020_3`.`Composicion` ;

CREATE TABLE IF NOT EXISTS `Parcial2020_3`.`Composicion` (
  `IDReceta` INT NOT NULL,
  `IDIngrediente` INT NOT NULL,
  `Medida` FLOAT NOT NULL CHECK (`Medida`>0.0),
  PRIMARY KEY (`IDReceta`, `IDIngrediente`),
  CONSTRAINT `fk_Composicion_Recetas1`
    FOREIGN KEY (`IDReceta`)
    REFERENCES `Parcial2020_3`.`Recetas` (`IDReceta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Composicion_Ingrediente1`
    FOREIGN KEY (`IDIngrediente`)
    REFERENCES `Parcial2020_3`.`Ingrediente` (`IDIngrediente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Composicion_Ingrediente1_idx` ON `Parcial2020_3`.`Composicion` (`IDIngrediente` ASC) VISIBLE;
CREATE INDEX `fk_Composicion_Ingrediente2_idx` ON `Parcial2020_3`.`Composicion` (`IDReceta` ASC) VISIBLE;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;



INSERT INTO `Clases` (`IDClase`, `Nombre`) VALUES (1, 'Tartas');
INSERT INTO `Clases` (`IDClase`, `Nombre`) VALUES (2, 'Cremas Frías');
INSERT INTO `Clases` (`IDClase`, `Nombre`) VALUES (3, 'Masas bases');
INSERT INTO `Clases` (`IDClase`, `Nombre`) VALUES (4, 'Postres');
INSERT INTO `Clases` (`IDClase`, `Nombre`) VALUES (5, 'Coberturas');
INSERT INTO `Clases` (`IDClase`, `Nombre`) VALUES (6, 'Rellenos');
INSERT INTO `Clases` (`IDClase`, `Nombre`) VALUES (7,'Decoraciones');

INSERT INTO `Magnitudes` (`IDMagnitud`, `Nombre`) VALUES (1, 'g');
INSERT INTO `Magnitudes` (`IDMagnitud`, `Nombre`) VALUES (2, 'cc');
INSERT INTO `Magnitudes` (`IDMagnitud`, `Nombre`) VALUES (3, 'u');
INSERT INTO `Magnitudes` (`IDMagnitud`, `Nombre`) VALUES (4, 'porciones');

INSERT INTO `Ingrediente` (`IDIngrediente`, `Nombre`, `Precio`, `Magnitud`) VALUES (1, 'Manteca', 5.06, 1);
INSERT INTO `Ingrediente` (`IDIngrediente`, `Nombre`, `Precio`, `Magnitud`) VALUES (2, 'Azúcar', 4.0065, 1);
INSERT INTO `Ingrediente` (`IDIngrediente`, `Nombre`, `Precio`, `Magnitud`) VALUES (3, 'Huevos', 13.34, 3);
INSERT INTO `Ingrediente` (`IDIngrediente`, `Nombre`, `Precio`, `Magnitud`) VALUES (4, 'Leche', 11.0, 2);
INSERT INTO `Ingrediente` (`IDIngrediente`, `Nombre`, `Precio`, `Magnitud`) VALUES (5, 'Chocolate para taza', 10.1, 1);
INSERT INTO `Ingrediente` (`IDIngrediente`, `Nombre`, `Precio`, `Magnitud`) VALUES (6, 'Harina', 10.0055, 1);
INSERT INTO `Ingrediente` (`IDIngrediente`, `Nombre`, `Precio`, `Magnitud`) VALUES (7, 'Polvo para hornear', 20.06, 1);
INSERT INTO `Ingrediente` (`IDIngrediente`, `Nombre`, `Precio`, `Magnitud`) VALUES (8, 'Bicarbonato de sodio', 10.06, 1);
INSERT INTO `Ingrediente` (`IDIngrediente`, `Nombre`, `Precio`, `Magnitud`) VALUES (9, 'Coñac', 82.0, 2);
INSERT INTO `Ingrediente` (`IDIngrediente`, `Nombre`, `Precio`, `Magnitud`) VALUES (10, 'Escencia de vainilla', 15.0, 2);
INSERT INTO `Ingrediente` (`IDIngrediente`, `Nombre`, `Precio`, `Magnitud`) VALUES (11, 'Yemas', 28.0, 1);
INSERT INTO `Ingrediente` (`IDIngrediente`, `Nombre`, `Precio`, `Magnitud`) VALUES (12, 'Almidón de maíz', 15.0, 1);
INSERT INTO `Ingrediente` (`IDIngrediente`, `Nombre`, `Precio`, `Magnitud`) VALUES (13, 'Jugo de limón', 10.04, 2);
INSERT INTO `Ingrediente` (`IDIngrediente`, `Nombre`, `Precio`, `Magnitud`) VALUES (14, 'Claras', 28.0, 1);
INSERT INTO `Ingrediente` (`IDIngrediente`, `Nombre`, `Precio`, `Magnitud`) VALUES (15, 'Chocolate cobertura', 125, 1);
INSERT INTO `Ingrediente` (`IDIngrediente`, `Nombre`, `Precio`, `Magnitud`) VALUES (16, 'Nueces', 10.2, 1);
INSERT INTO `Ingrediente` (`IDIngrediente`, `Nombre`, `Precio`, `Magnitud`) VALUES (17, 'Dulce de leche', 18, 1);
INSERT INTO `Ingrediente` (`IDIngrediente`, `Nombre`, `Precio`, `Magnitud`) VALUES (18, 'Agua', 10.5, 2);

INSERT INTO `Recetas` (`IDReceta`, `Nombre`, `Rendimiento`, `Magnitud`, `Clase`, `Procedimiento`) VALUES(1, 'Merengue', 500.0, 1, 5, 'Batir ...');
INSERT INTO `Recetas` (`IDReceta`, `Nombre`, `Rendimiento`, `Magnitud`, `Clase`, `Procedimiento`) VALUES(2, 'Masa frola', 10.0, 4, 3, 'Mezclar ...');
INSERT INTO `Recetas` (`IDReceta`, `Nombre`, `Rendimiento`, `Magnitud`, `Clase`, `Procedimiento`) VALUES(3, 'Lemon Pie', 3.0, 4, 1, 'Armar ...');
INSERT INTO `Recetas` (`IDReceta`, `Nombre`, `Rendimiento`, `Magnitud`, `Clase`, `Procedimiento`) VALUES(4, 'Bizcochuelo', 6.0, 4, 3, 'Mezclar ...');

INSERT INTO `Composicion` (`IDReceta`, `IDIngrediente`, `Medida`) VALUES ('4', '3', 2);
INSERT INTO `Composicion` (`IDReceta`, `IDIngrediente`, `Medida`) VALUES ('4', '2', 60);
INSERT INTO `Composicion` (`IDReceta`, `IDIngrediente`, `Medida`) VALUES ('4', '6', 60);
INSERT INTO `Composicion` (`IDReceta`, `IDIngrediente`, `Medida`) VALUES ('4', '10', 10);
INSERT INTO `Composicion` (`IDReceta`, `IDIngrediente`, `Medida`) VALUES ('1', '2', 340);
INSERT INTO `Composicion` (`IDReceta`, `IDIngrediente`, `Medida`) VALUES ('1', '14', 150);
INSERT INTO `Composicion` (`IDReceta`, `IDIngrediente`, `Medida`) VALUES ('2', '1', 150);
INSERT INTO `Composicion` (`IDReceta`, `IDIngrediente`, `Medida`) VALUES ('2', '2', 150);
INSERT INTO `Composicion` (`IDReceta`, `IDIngrediente`, `Medida`) VALUES ('2', '11', 80);
INSERT INTO `Composicion` (`IDReceta`, `IDIngrediente`, `Medida`) VALUES ('2', '6', 300);
INSERT INTO `Composicion` (`IDReceta`, `IDIngrediente`, `Medida`) VALUES ('2', '7', 5);
INSERT INTO `Composicion` (`IDReceta`, `IDIngrediente`, `Medida`) VALUES ('2', '10', 10);
INSERT INTO `Composicion` (`IDReceta`, `IDIngrediente`, `Medida`) VALUES ('3', '11', 80);
INSERT INTO `Composicion` (`IDReceta`, `IDIngrediente`, `Medida`) VALUES ('3', '2', 100);
INSERT INTO `Composicion` (`IDReceta`, `IDIngrediente`, `Medida`) VALUES ('3', '12', 40);
INSERT INTO `Composicion` (`IDReceta`, `IDIngrediente`, `Medida`) VALUES ('3', '14', 200);
INSERT INTO `Composicion` (`IDReceta`, `IDIngrediente`, `Medida`) VALUES ('3', '13', 60);
INSERT INTO `Composicion` (`IDReceta`, `IDIngrediente`, `Medida`) VALUES ('3', '10', 10);
INSERT INTO `Composicion` (`IDReceta`, `IDIngrediente`, `Medida`) VALUES ('4', '14', 250);

INSERT INTO `RecetaEnRecetas` (`IDReceta`, `IDComponente`, `Medida`) VALUES ('3', '1', '650');
INSERT INTO `RecetaEnRecetas` (`IDReceta`, `IDComponente`, `Medida`) VALUES ('3', '2', '10');
INSERT INTO `RecetaEnRecetas` (`IDReceta`, `IDComponente`, `Medida`) VALUES ('3', '3', '12');
INSERT INTO `RecetaEnRecetas` (`IDReceta`, `IDComponente`, `Medida`) VALUES ('4', '3', '6');
INSERT INTO `RecetaEnRecetas` (`IDReceta`, `IDComponente`, `Medida`) VALUES ('4', '1', '750');

/*********************************************************************************
2) Realizar un procedimiento almacenado, llamado NuevaReceta , para crear una
receta. El mismo deberá incluir el control de errores lógicos y mensajes de error
necesarios. Incluir el código con la llamada al procedimiento probando todos los
casos con datos incorrectos y uno con datos correctos.
**********************************************************************************/
DROP PROCEDURE IF EXISTS NuevaReceta;

DELIMITER //

CREATE PROCEDURE NuevaReceta(
    pIDReceta INT,
    pNombre VARCHAR(35), 
    pRendimiento FLOAT,
    pClase INT,
    pMagnitud INT,
    pProcedimiento VARCHAR(1000),
    OUT pMensaje VARCHAR(256))
FINAL:
BEGIN
    -- Descripcion
    
    -- Declaraciones
    DECLARE EXIT HANDLER FOR SQLEXCEPTION -- lo puedo cambiar por el numero de la exception
       BEGIN
            SHOW ERRORS;
            SET pMensaje = 'Error en la transacción. Contáctese con el administrador.';
            ROLLBACK;
        END;

    IF pIDReceta IS NULL OR  pRendimiento IS NULL OR pNombre IS NULL OR TRIM(pnombre) = '' OR 
    pClase IS NULL OR pMagnitud IS NULL THEN
        SET pMensaje = 'Error: ID,Nombre, rendimiento,clase, o magnitud no pueden ser nulos';
        LEAVE FINAL;
    END IF;

    IF EXISTS (SELECT Nombre FROM Recetas WHERE Nombre = pNombre) THEN
        SET pMensaje = 'Error: No puede haber nombres de recetas repetidos';
        LEAVE FINAL;
    END IF;

    START TRANSACTION;
    
    INSERT INTO Recetas (IDReceta, Nombre, Rendimiento, Clase, Magnitud, Procedimiento)
    VALUES (pIDReceta, pNombre, pRendimiento, pClase, pMagnitud,pProcedimiento);
    
    SET pMensaje = 'Inserción exitosa';
    COMMIT;

END //

DELIMITER ; 


SELECT * FROM Recetas;
-- INSERT INTO `Recetas` (`IDReceta`, `Nombre`, `Rendimiento`, `Magnitud`, `Clase`, `Procedimiento`) VALUES(1, 'Merengue', 500.0, 1, 5, 'Batir ...');

CALL NuevaReceta(6,'Panettone',1000.0,1,4,"Batir...", @pMensaje);
SELECT @pMensaje;
/*************************************************************************************
3) Realizar una vista, llamada VerRecetas , para que muestre las recetas. Se deberá
mostrar el nombre, rendimiento, magnitud, clase, composición, medida (tanto de
ingredientes como de otra receta que forme parte de la misma) y procedimiento. Al
mostrar la composición (tanto de un ingrediente como de otra receta) mostrar el
nombre del ingrediente o de la receta.
**************************************************************************************/
DROP VIEW IF EXISTS VerRecetas;
CREATE VIEW VerRecetas AS
-- nombre, rendimiento, magnitud, clase, composición, medida (tanto de ingredientes como de otra receta que forme parte de la misma) y procedimiento.
	SELECT R.Nombre AS 'Nombre de Receta', R.Rendimiento AS 'Rendimiento de Receta', CL.Nombre AS 'Clase de receta',
   C.Medida, I.Nombre AS Ingrediente, R.Procedimiento, RER.Medida AS 'Medida en recetas'
		   
	FROM Recetas R
	JOIN Composicion C ON C.IDReceta = R.IDReceta
	JOIN RecetaEnRecetas RER ON RER.IDReceta = R.IDReceta
    JOIN Clases CL  ON R.Clase = CL.IDClase
    JOIN Ingrediente I ON C.IDIngrediente = I.IDIngrediente;
    
SELECT * FROM VerRecetas;

/*********************************************************************************
4) Crear una vista, llamada RankingIngredientes , para que muestre un ranking con
los ingredientes que se emplean en menor cantidad en las distintas recetas. 
*********************************************************************************/

DROP VIEW IF EXISTS RankingIngredientes;

DELIMITER //

CREATE VIEW RankingIngredientes AS
SELECT
		R.Nombre 		AS 	'Nombre Receta',
        I.Nombre 		AS      'Nombre Ingrediente',
        SUM(C.Medida) 	AS CantidadTotal        
    FROM
        Recetas R
        JOIN Composicion C ON C.IDReceta = R.IDReceta
        JOIN Ingrediente I ON I.IDIngrediente = C.IDIngrediente
        
    GROUP BY
        R.Nombre,
        I.Nombre
    ORDER BY
		CantidadTotal   ASC;
END //

DELIMITER ;

SELECT * FROM RankingIngredientes;

/**************************************************************************************
5)Implementar la lógica para llevar una auditoría para la operación del apartado 2. Se
deberá auditar el usuario que la hizo, la fecha y hora de la operación, la máquina
desde donde se la hizo y toda la información necesaria para la auditoría.
**************************************************************************************/
DROP TABLE IF EXISTS `AuditoriaRecetas` ;

CREATE TABLE IF NOT EXISTS `AuditoriaRecetas` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `IDReceta` INT,
  `Nombre` VARCHAR(35), 
  `Rendimiento` FLOAT,
  `Clase` INT,
  `Procedimiento` VARCHAR(1000),
  `TipoOp` CHAR(1) NOT NULL, -- tipo de operación (I: Inserción, B: Borrado, M: Modificación)
  `Usuario` VARCHAR(45) NOT NULL,  
  `Maquina` VARCHAR(45) NOT NULL,  
  `Fecha` DATETIME NOT NULL,
  PRIMARY KEY (`ID`)
);

DROP TRIGGER IF EXISTS AuditarRecetas;
DELIMITER //
CREATE TRIGGER `AuditarRecetas` 
AFTER INSERT ON `Recetas` FOR EACH ROW
BEGIN
	INSERT INTO AuditoriaRecetas VALUES (
			DEFAULT, 
			NEW.IDReceta,
			NEW.Nombre, 
			NEW.Rendimiento,
			NEW.Clase,
			NEW.Procedimiento,
			'I', 
			SUBSTRING_INDEX(USER(), '@', 1), 
			SUBSTRING_INDEX(USER(), '@', -1), 
			NOW()
	  );
END //
DELIMITER ;

SELECT * FROM Recetas;
SELECT * FROM AuditoriaRecetas;



CALL NuevaReceta(6,'Sanguche', 100.0, 1, 4, 'Mezclar...', @pMensaje);
SELECT @pMensaje;
