-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema parcial_2021_3
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `parcial_2021_3` ;

-- -----------------------------------------------------
-- Schema parcial_2021_3
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `parcial_2021_3` DEFAULT CHARACTER SET utf8 ;
USE `parcial_2021_3` ;

-- -----------------------------------------------------
-- Table `parcial_2021_3`.`Generos`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `parcial_2021_3`.`Generos` ;

CREATE TABLE IF NOT EXISTS `parcial_2021_3`.`Generos` (
  `idGenero` CHAR(10) NOT NULL,
  `nombre` VARCHAR(25) NOT NULL,
  PRIMARY KEY (`idGenero`))
ENGINE = InnoDB;

CREATE UNIQUE INDEX `nombre_UNIQUE` ON `parcial_2021_3`.`Generos` (`nombre` ASC) VISIBLE;
-- -----------------------------------------------------
-- Table `parcial_2021_3`.`Peliculas`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `parcial_2021_3`.`Peliculas` ;

CREATE TABLE IF NOT EXISTS `parcial_2021_3`.`Peliculas` (
  `idPelicula` INT NOT NULL,
  `titulo` VARCHAR(128) NOT NULL,
  `estreno` INT NULL,
  `duracion` INT NULL,
  `clasificacion` VARCHAR(10) NOT NULL DEFAULT 'G' CHECK (`clasificacion` IN ('G','PG','PG-13','R','NC-17')),
  PRIMARY KEY (`idPelicula`))
ENGINE = InnoDB;
CREATE UNIQUE INDEX `titulo_UNIQUE` ON `parcial_2021_3`.`Peliculas` (`titulo` ASC) VISIBLE;

-- -----------------------------------------------------
-- Table `parcial_2021_3`.`Direcciones`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `parcial_2021_3`.`Direcciones` ;

CREATE TABLE IF NOT EXISTS `parcial_2021_3`.`Direcciones` (
  `idDireccion` INT NOT NULL,
  `calleYNumero` VARCHAR(50) NOT NULL,
  `municipio` VARCHAR(20) NOT NULL,
  `codigoPostal` VARCHAR(10) NULL,
  `telefono` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`idDireccion`))
ENGINE = InnoDB;

CREATE UNIQUE INDEX `calleYNumero_UNIQUE` ON `parcial_2021_3`.`Direcciones` (`calleYNumero` ASC) VISIBLE;
-- -----------------------------------------------------
-- Table `parcial_2021_3`.`Personal`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `parcial_2021_3`.`Personal` ;

CREATE TABLE IF NOT EXISTS `parcial_2021_3`.`Personal` (
  `idPersonal` INT NOT NULL,
  `nombres` VARCHAR(45) NOT NULL,
  `apellidos` VARCHAR(45) NOT NULL,
  `idDireccion` INT NOT NULL,
  `correo` VARCHAR(50) NULL,
  `estado` CHAR(1) NOT NULL DEFAULT 'E',
  
  PRIMARY KEY (`idPersonal`),
  CONSTRAINT `fk_Personal_Direcciones1`
    FOREIGN KEY (`idDireccion`)
    REFERENCES `parcial_2021_3`.`Direcciones` (`idDireccion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Personal_Direcciones1_idx` ON `parcial_2021_3`.`Personal` (`idDireccion` ASC) VISIBLE;
CREATE UNIQUE INDEX `correo_UNIQUE` ON `parcial_2021_3`.`Personal` (`correo` ASC) VISIBLE;


ALTER TABLE `parcial_2021_3`.`Personal`
ADD CONSTRAINT `Personal_chk_1`
CHECK (`estado` IN ('D','E'));

-- -----------------------------------------------------
-- Table `parcial_2021_3`.`Sucursales`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `parcial_2021_3`.`Sucursales` ;

CREATE TABLE IF NOT EXISTS `parcial_2021_3`.`Sucursales` (
  `idSucursal` CHAR(10) NOT NULL,
  `idGerente` INT NOT NULL,
  `idDireccion` INT NOT NULL,
  PRIMARY KEY (`idSucursal`),
  CONSTRAINT `fk_Sucursales_Direcciones1`
    FOREIGN KEY (`idDireccion`)
    REFERENCES `parcial_2021_3`.`Direcciones` (`idDireccion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Sucursales_Personal1`
    FOREIGN KEY (`idGerente`)
    REFERENCES `parcial_2021_3`.`Personal` (`idPersonal`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Sucursales_Direcciones1_idx` ON `parcial_2021_3`.`Sucursales` (`idDireccion` ASC) VISIBLE;

CREATE INDEX `fk_Sucursales_Personal1_idx` ON `parcial_2021_3`.`Sucursales` (`idGerente` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `parcial_2021_3`.`Inventario`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `parcial_2021_3`.`Inventario` ;

CREATE TABLE IF NOT EXISTS `parcial_2021_3`.`Inventario` (
  `idInventario` INT NOT NULL,
  `idPelicula` INT NOT NULL,
  `idSucursal` CHAR(10) NOT NULL,
  PRIMARY KEY (`idInventario`),
  CONSTRAINT `fk_Inventario_Sucursales1`
    FOREIGN KEY (`idSucursal`)
    REFERENCES `parcial_2021_3`.`Sucursales` (`idSucursal`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Inventario_Peliculas1`
    FOREIGN KEY (`idPelicula`)
    REFERENCES `parcial_2021_3`.`Peliculas` (`idPelicula`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Inventario_Sucursales1_idx` ON `parcial_2021_3`.`Inventario` (`idSucursal` ASC) VISIBLE;

CREATE INDEX `fk_Inventario_Peliculas1_idx` ON `parcial_2021_3`.`Inventario` (`idPelicula` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `parcial_2021_3`.`GenerosDePeliculas`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `parcial_2021_3`.`GenerosDePeliculas` ;

CREATE TABLE IF NOT EXISTS `parcial_2021_3`.`GenerosDePeliculas` (
  `idPelicula` INT NOT NULL,
  `idGenero` CHAR(10) NOT NULL,
  PRIMARY KEY (`idPelicula`, `idGenero`),
  CONSTRAINT `fk_GenerosDePeliculas_Generos`
    FOREIGN KEY (`idGenero`)
    REFERENCES `parcial_2021_3`.`Generos` (`idGenero`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_GenerosDePeliculas_Peliculas1`
    FOREIGN KEY (`idPelicula`)
    REFERENCES `parcial_2021_3`.`Peliculas` (`idPelicula`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_GenerosDePeliculas_Peliculas1_idx` ON `parcial_2021_3`.`GenerosDePeliculas` (`idPelicula` ASC) VISIBLE;

CREATE INDEX `fk_GenerosDePeliculas_Generos_idx` ON `parcial_2021_3`.`GenerosDePeliculas` (`idGenero` ASC) VISIBLE;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

/*Crear una vista llamada VCantidadPeliculas que muestre por cada película su código,
título y la cantidad total entre las distintas sucursales. La salida deberá estar ordenada
alfabéticamente según el título de las películas. Incluir el código con la consulta a la vista.*/
DROP VIEW IF EXISTS VCantidadPeliculas;
CREATE VIEW VCantidadPeliculas AS
SELECT 
	   P.idPelicula AS 'Codigo',
       P.titulo AS 'Titulo',
       COUNT(P.idPelicula)
       
FROM Peliculas P
JOIN Inventario I ON P.idPelicula = I.idPelicula
JOIN Sucursales S ON I.idSucursal = S.idSucursal

GROUP BY P.idPelicula, P.titulo
ORDER BY P.idPelicula,P.titulo DESC;

SELECT * FROM VCantidadPeliculas;

/*Realizar un procedimiento almacenado llamado NuevaDireccion para dar de alta una
dirección, incluyendo el control de errores lógicos y mensajes de error necesarios
(implementar la lógica del manejo de errores empleando parámetros de salida). Incluir el
código con la llamada al procedimiento probando todos los casos con datos incorrectos y
uno con datos correctos.*/

DROP PROCEDURE IF EXISTS NuevaDireccion;


DELIMITER //

CREATE PROCEDURE NuevaDireccion(
   IN pidDireccion INT,
   IN pcalleYNumero VARCHAR(50), 
   IN pmunicipio VARCHAR(20),
   IN pcodigoPostal VARCHAR(10),
   IN ptelefono VARCHAR(20),
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

	-- Verificar existencia del código de rastreo en la tabla Envios
    /*SELECT COUNT(*) INTO vCount FROM Sucursales WHERE CodigoRastreo = pCodigoRastreo;
    
    IF vCount = 0 THEN
        SET pMensaje = 'Error: El código de rastreo no existe en la tabla Envios';
        LEAVE FINAL;
    END IF; 
    
    IF pCodigoRastreo IS NULL OR  pTipo IS NULL OR pSellado  THEN
        SET pMensaje = 'Error: Codigo de rastreo, Tipo, Sellado no pueden ser nulos';
        LEAVE FINAL;
    END IF; */
	IF pidDireccion IS NULL OR  pcalleYNumero IS NULL OR pmunicipio IS NULL OR ptelefono IS NULL  THEN
        SET pMensaje = 'Error: idDireccion,calle y numero, municipio,o telefono no pueden ser nulos';
        LEAVE FINAL;
    END IF;

    START TRANSACTION;
    
    INSERT INTO Direcciones (idDireccion, calleYNumero,municipio,codigoPostal,telefono)

    VALUES (pidDireccion, pcalleYNumero, pmunicipio,pcodigoPostal,ptelefono);
    
    SET pMensaje = 'Inserción exitosa';
    COMMIT;

END //

DELIMITER ; 
-- INSERT INTO `Cartas` VALUES ('a10', 'Simple', 'Negro');
SELECT * FROM Direcciones;
-- VALUES (1,'47 MySakila Drive','Alberta','-','-')

CALL NuevaDireccion(6, '47 Calle 1', 'Tucuman', '-', '456327', @pMensaje);
SELECT @pMensaje;

/*Realizar un procedimiento almacenado llamado BuscarPeliculasPorGenero que reciba
el código de un género y muestre sucursal por sucursal, película por película, la cantidad
con el mismo. Por cada película del género especificado se deberá mostrar su código y
título, el código de la sucursal, la cantidad y la calle y número de la sucursal. La salida
deberá estar ordenada alfabéticamente según el título de las películas. Incluir en el código
la llamada al procedimiento.*/
DROP PROCEDURE IF EXISTS `BuscarPeliculasPorGenero`;
DELIMITER //

CREATE PROCEDURE `BuscarPeliculasPorGenero`(pidGenero CHAR(10))
FINAL:
BEGIN
    -- Descripcion
    /*

    */
    -- Declaraciones

    SELECT p.idPelicula, p.titulo, S.idSucursal, COUNT(idInventario) AS 'Cantidad', D.calleYNumero
    FROM Peliculas p
             JOIN GenerosDePeliculas GDP ON p.idPelicula = GDP.idPelicula
             JOIN Inventario I ON p.idPelicula = I.idPelicula
             JOIN Sucursales S ON S.idSucursal = I.idSucursal
             JOIN Direcciones D ON D.idDireccion = S.idDireccion
             JOIN Generos G ON G.idGenero = GDP.idGenero
    WHERE G.idGenero = pidGenero
    GROUP BY p.idPelicula, p.titulo, S.idSucursal, D.calleYNumero
    ORDER BY p.titulo;
    
END //
DELIMITER ;

SELECT * FROM Generos;

CALL BuscarPeliculasPorGenero(6);

CALL BuscarPeliculasPorGenero('10');

/*Utilizando triggers, implementar la lógica para que en caso que se quiera borrar una
dirección referenciada por una sucursal o un personal se informe mediante un mensaje de
error que no se puede. Incluir el código con los borrados de una dirección para la cual no
hay sucursales ni personal, y otro para la que sí.*/

DROP TRIGGER IF EXISTS BorrarDireccion;

DELIMITER //
CREATE TRIGGER BorrarDireccion
    BEFORE DELETE
    ON Direcciones
    FOR EACH ROW
BEGIN
    IF EXISTS(SELECT Sucursales.idDireccion FROM Sucursales WHERE Sucursales.idDireccion = OLD.idDireccion) OR
       EXISTS(SELECT Personal.idDireccion FROM Personal WHERE Personal.idDireccion = OLD.idDireccion) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error sucursal o personal tiene como referencia la direccion que se desea eliminar';
    END IF;

END //
DELIMITER ;


-- Luego de definir el trigger, realiza la eliminación en otra sentencia aparte
DELETE FROM Direcciones WHERE idDireccion = 100;



SELECT * FROM Direcciones D 
		 JOIN Sucursales S on S.idDireccion = D.idDireccion ;
-- Caso válido: Borrar un direccion existente sin ref
DELETE FROM Direcciones WHERE idDireccion = 5;

-- Casos inválidos: Borrar direccion no existentes
DELETE FROM Direcciones WHERE idDireccion = 1000; -- La direccion con idDireccion 100 no existe

-- Casos inválidos: Borrar direccion con ref 
DELETE FROM Direcciones WHERE idDireccion = 2; -- La trabajador con idDireccion 200 no existe */
