/*******************************************************************************************
Juarez Yelamos, Fausto - 39732397
*******************************************************************************************/
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema DNI39732397
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `DNI39732397` ;

-- -----------------------------------------------------
-- Schema DNI39732397
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `DNI39732397` DEFAULT CHARACTER SET utf8 ;
USE `DNI39732397` ;

-- -----------------------------------------------------
-- Table `DNI39732397`.`Productos`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DNI39732397`.`Productos` ;

CREATE TABLE IF NOT EXISTS `DNI39732397`.`Productos` (
  `idProducto` INT NOT NULL,
  `nombre` VARCHAR(150) NOT NULL,
  `precio` FLOAT NOT NULL CHECK (precio > 0.0),
  PRIMARY KEY (`idProducto`))
ENGINE = InnoDB;

CREATE INDEX `INDEX_nombre` ON `DNI39732397`.`Productos` (`nombre` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `DNI39732397`.`Clientes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DNI39732397`.`Clientes` ;

CREATE TABLE IF NOT EXISTS `DNI39732397`.`Clientes` (
  `idCliente` INT NOT NULL,
  `apellidos` VARCHAR(50) NOT NULL,
  `nombres` VARCHAR(50) NOT NULL,
  `dni` VARCHAR(10) NOT NULL,
  `domicilio` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`idCliente`))
ENGINE = InnoDB;

CREATE INDEX `IX_dni` ON `DNI39732397`.`Clientes` (`dni` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `DNI39732397`.`Pedidos`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DNI39732397`.`Pedidos` ;

CREATE TABLE IF NOT EXISTS `DNI39732397`.`Pedidos` (
  `idPedido` INT NOT NULL,
  `idCliente` INT NOT NULL,
  `fecha` DATETIME NOT NULL,
  PRIMARY KEY (`idPedido`),
  CONSTRAINT `fk_Pedidos_Clientes1`
    FOREIGN KEY (`idCliente`)
    REFERENCES `DNI39732397`.`Clientes` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Pedidos_Clientes1_idx` ON `DNI39732397`.`Pedidos` (`idCliente` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `DNI39732397`.`BandasHorarias`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DNI39732397`.`BandasHorarias` ;

CREATE TABLE IF NOT EXISTS `DNI39732397`.`BandasHorarias` (
  `idBandasHoraria` INT NOT NULL,
  `nombre` CHAR(13) NOT NULL,
  PRIMARY KEY (`idBandasHoraria`))
ENGINE = InnoDB;

CREATE INDEX `IX_nombre` ON `DNI39732397`.`BandasHorarias` (`nombre` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `DNI39732397`.`Sucursales`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DNI39732397`.`Sucursales` ;

CREATE TABLE IF NOT EXISTS `DNI39732397`.`Sucursales` (
  `idSucursal` INT NOT NULL,
  `nombre` VARCHAR(100) NOT NULL,
  `domicilio` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`idSucursal`))
ENGINE = InnoDB;

CREATE INDEX `IX_nombre` ON `DNI39732397`.`Sucursales` (`nombre` ASC) INVISIBLE;

CREATE INDEX `IX_domicilio` ON `DNI39732397`.`Sucursales` (`domicilio` ASC) INVISIBLE;


-- -----------------------------------------------------
-- Table `DNI39732397`.`Entregas`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DNI39732397`.`Entregas` ;

CREATE TABLE IF NOT EXISTS `DNI39732397`.`Entregas` (
  `idEntrega` INT NOT NULL,
  `idSucursal` INT NOT NULL,
  `idPedido` INT NOT NULL,
  `fecha` DATETIME NOT NULL,
  `idBandasHoraria` INT NOT NULL,
  PRIMARY KEY (`idEntrega`),
  CONSTRAINT `fk_Entregas_Pedidos1`
    FOREIGN KEY (`idPedido`)
    REFERENCES `DNI39732397`.`Pedidos` (`idPedido`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Entregas_BandasHorarias1`
    FOREIGN KEY (`idBandasHoraria`)
    REFERENCES `DNI39732397`.`BandasHorarias` (`idBandasHoraria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Entregas_Sucursales1`
    FOREIGN KEY (`idSucursal`)
    REFERENCES `DNI39732397`.`Sucursales` (`idSucursal`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Entregas_Pedidos1_idx` ON `DNI39732397`.`Entregas` (`idPedido` ASC) VISIBLE;

CREATE INDEX `fk_Entregas_BandasHorarias1_idx` ON `DNI39732397`.`Entregas` (`idBandasHoraria` ASC) VISIBLE;

CREATE INDEX `fk_Entregas_Sucursales1_idx` ON `DNI39732397`.`Entregas` (`idSucursal` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `DNI39732397`.`ProductoDelPedido`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DNI39732397`.`ProductoDelPedido` ;

CREATE TABLE IF NOT EXISTS `DNI39732397`.`ProductoDelPedido` (
  `idPedido` INT NOT NULL,
  `idProducto` INT NOT NULL,
  `cantidad` FLOAT NOT NULL,
  `precio` FLOAT NOT NULL CHECK (precio > 0.0),
  PRIMARY KEY (`idPedido`, `idProducto`),
  CONSTRAINT `fk_Productos_has_Pedidos_Productos`
    FOREIGN KEY (`idProducto`)
    REFERENCES `DNI39732397`.`Productos` (`idProducto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Productos_has_Pedidos_Pedidos1`
    FOREIGN KEY (`idPedido`)
    REFERENCES `DNI39732397`.`Pedidos` (`idPedido`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Productos_has_Pedidos_Pedidos1_idx` ON `DNI39732397`.`ProductoDelPedido` (`idPedido` ASC) VISIBLE;

CREATE INDEX `fk_Productos_has_Pedidos_Productos_idx` ON `DNI39732397`.`ProductoDelPedido` (`idProducto` ASC) VISIBLE;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

/************************************************************************************************
2) Crear una vista llamada VEntregas que muestre por cada sucursal su nombre, el
identificador del pedido que entregó, la fecha en la que se hizo el pedido, la fecha en la que
fue entregado junto con la banda horaria, y el cliente que hizo el pedido. La salida, mostrada
en la siguiente tabla, deberá estar ordenada ascendentemente según el nombre de la
sucursal, fecha del pedido y fecha de entrega (tener en cuenta las sucursales que pudieran
no tener entregas). Incluir el código con la consulta a la vista.
*************************************************************************************************/
DROP VIEW IF EXISTS VEntregas;
CREATE VIEW VEntregas AS
SELECT 	S.nombre AS 'Sucursal',
		P.idPedido AS 'Pedido',
        P.fecha AS 'F. pedido',
        E.fecha AS 'F. entrega',
        BH.nombre AS 'Banda',
        CONCAT(C.apellidos, ', ', C.nombres, ' (', C.dni, ')') AS 'Cliente'
        
FROM Sucursales S
JOIN Entregas E ON S.idSucursal = E.idSucursal
JOIN BandasHorarias BH ON BH.idBandasHoraria = E.idBandasHoraria
JOIN Pedidos P ON P.idPedido = E.idPedido
JOIN Clientes C ON C.idCliente = P.idCliente
WHERE  S.idSucursal = E.idSucursal
GROUP BY S.nombre,P.idPedido,P.fecha, E.fecha, BH.nombre
ORDER BY S.nombre, P.fecha,E.fecha ASC;

SELECT * FROM VEntregas;

/*****************************************************************************************
3) Realizar un procedimiento almacenado llamado NuevoProducto para dar de alta un
producto, incluyendo el control de errores lógicos y mensajes de error necesarios
(implementar la lógica del manejo de errores empleando parámetros de salida). Incluir el
código con la llamada al procedimiento probando todos los casos con datos incorrectos y
uno con datos correctos.
*******************************************************************************************/
DROP PROCEDURE IF EXISTS NuevoProducto;

DELIMITER //

CREATE PROCEDURE NuevoProducto(
   IN pidProducto INT,
   IN pnombre VARCHAR(150), 
   IN pprecio FLOAT,
    OUT pMensaje VARCHAR(256))
FINAL:
BEGIN
    -- Descripcion
    
    -- Declaraciones
    DECLARE vCount INT;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION -- lo puedo cambiar por el numero de la exception
    BEGIN
	         -- SHOW ERRORS;
            SET pMensaje = 'Error en la transacción. Contáctese con el administrador.';
            ROLLBACK;
    END;

	IF pidProducto IS NULL OR  pnombre IS NULL OR pprecio IS NULL THEN
        SET pMensaje = 'Error: idProducto,nombre y precio no pueden ser nulos';
        LEAVE FINAL;
    END IF;

    START TRANSACTION;
    
    INSERT INTO Productos (idProducto, nombre,precio)

    VALUES (pidProducto, pnombre, pprecio);
    
    SET pMensaje = 'Inserción exitosa';
    COMMIT;

END //

DELIMITER ; 


-- INSERT INTO Productos VALUES (1, 'iPhone 12', 999);
SELECT * FROM Productos;


CALL NuevoProducto(22, 'Samsung S24', 1000, @pMensaje);
SELECT @pMensaje;
CALL NuevoProducto(NULL, 'Samsung S24', 1000, @pMensaje);
SELECT @pMensaje;
CALL NuevoProducto(23, NULL, 1000, @pMensaje);
SELECT @pMensaje;
CALL NuevoProducto(23, 'Samsung S24', NULL, @pMensaje);
SELECT @pMensaje;
/**********************************************************************************************
4) Realizar un procedimiento almacenado llamado BuscarPedidos que reciba el
identificador de un pedido y muestre los datos del mismo. Por cada pedido mostrará el
identificador del producto, nombre, precio de lista, cantidad, precio de venta y total. Además
en la última fila mostrará los datos del pedido (fecha, cliente y total del pedido). La salida,
mostrada en la siguiente tabla, deberá estar ordenada alfabéticamente según el nombre del
producto. Incluir en el código la llamada al procedimiento.
***********************************************************************************************/

DROP PROCEDURE IF EXISTS BuscarPedidos;
DELIMITER //

CREATE PROCEDURE BuscarPedidos(IN pedidoID INT)
BEGIN
    DECLARE totalPedido FLOAT;
    
    -- Total del pedido
    SELECT SUM(pd.precio * pd.cantidad) INTO totalPedido
    FROM ProductoDelPedido pd
    WHERE pd.idPedido = pedidoID;
    -- Datos del pedido
    (SELECT p.idProducto, p.nombre, p.precio AS 'precio lista', pd.cantidad, pd.precio AS 'precio venta' ,pd.precio * pd.cantidad AS total
    FROM ProductoDelPedido pd
    INNER JOIN Productos p ON pd.idProducto = p.idProducto
    WHERE pd.idPedido = pedidoID
    ORDER BY p.nombre ASC)

    UNION

    -- Datos generales del pedido
    (SELECT 'Fecha:',pe.fecha AS 'Fecha','Cliente:', CONCAT(C.apellidos, ', ', C.nombres) AS 'Cliente', 'Total',totalPedido AS 'total'
    FROM Pedidos pe
    INNER JOIN Clientes c ON pe.idCliente = c.idCliente
    WHERE pe.idPedido = pedidoID);
END //

DELIMITER ;

SELECT * FROM Pedidos;
CALL BuscarPedidos(1);


/**********************************************************************************************
5)Utilizando triggers, implementar la lógica para que en caso que se quiera borrar un
producto incluido en un pedido se informe mediante un mensaje de error que no se puede.
Incluir el código con los borrados de un producto no incluido en ningún pedido, y otro de uno
que sí.
************************************************************************************************/
DROP TRIGGER IF EXISTS Productos_before_delete;
DELIMITER //
CREATE TRIGGER Productos_before_delete
    BEFORE DELETE
    ON Productos
    FOR EACH ROW
BEGIN
    IF EXISTS(SELECT * FROM Pedidos P
			  JOIN ProductoDelPedido PDP ON P.idPedido = PDP.idPedido
              JOIN Productos PRO ON PRO.idProducto = PDP.idProducto
              WHERE PRO.idProducto = OLD.idProducto) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: Un pedido tiene como referencia el Producto que se desea eliminar';
    END IF;

END //
DELIMITER ;

SELECT * FROM Pedidos P
			  JOIN ProductoDelPedido PDP ON P.idPedido = PDP.idPedido
              JOIN Productos PRO ON PRO.idProducto = PDP.idProducto;
DELETE FROM Productos WHERE idProducto='5';
INSERT INTO Productos VALUES (25, 'Samsung S24', 999);
DELETE FROM Productos WHERE idProducto='25';
