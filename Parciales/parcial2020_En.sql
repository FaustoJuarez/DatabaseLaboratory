/*1) Según el modelo lógico de la figura, crear los objetos necesarios. Vendido sólo
puede tomar los valores ‘S’ o ‘N’. No puede haber 2 métodos con el mismo nombre,
2 cuadros con el mismo identificador ni 2 propuestas con el mismo identificador. El
importe en una propuesta debe ser mayor que 0. El precio de un cuadro debe ser
mayor que 0. La fecha de inauguración debe ser anterior a la de clausura. Deberá
haber índices por las claves primarias y propagadas, por fecha en la tabla
Propuestas, por apellidos y nombres en Pintores, por título en Exhibiciones, por la
persona que realiza la propuesta, por título en Cuadros y por fecha en Cuadros.
Finalmente, ejecutar el script Datos.sql para poblar la base de datos*/

-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Parcial2020_En
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `Parcial2020_En` ;

-- -----------------------------------------------------
-- Schema Parcial2020_En
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Parcial2020_En` DEFAULT CHARACTER SET utf8 ;
USE `Parcial2020_En` ;

-- -----------------------------------------------------
-- Table `Parcial2020_En`.`Exhibiciones`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Parcial2020_En`.`Exhibiciones` ;

CREATE TABLE IF NOT EXISTS `Parcial2020_En`.`Exhibiciones` (
  `IDExhibicion` INT NOT NULL,
  `Titulo` VARCHAR(50) NOT NULL,
  `Descripcion` VARCHAR(200) NULL,
  `Inauguracion` DATE NOT NULL,
  `Clausura` DATE NULL,
  PRIMARY KEY (`IDExhibicion`)
) ENGINE = InnoDB;

ALTER TABLE `Parcial2020_En`.`Exhibiciones`
ADD CONSTRAINT `exhibicion_chk_1`
CHECK (`Clausura` IS NULL OR `Inauguracion` < `Clausura`);


CREATE INDEX `IX_Titulo` ON `Parcial2020_En`.`Exhibiciones` (`Titulo` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `Parcial2020_En`.`Pintores`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Parcial2020_En`.`Pintores` ;

CREATE TABLE IF NOT EXISTS `Parcial2020_En`.`Pintores` (
  `IDPintor` INT NOT NULL,
  `Apellidos` VARCHAR(30) NOT NULL,
  `Nombres` VARCHAR(30) NOT NULL,
  `Nacionalidad` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`IDPintor`))
ENGINE = InnoDB;

-- CREATE INDEX `IX_Nombre` ON `Parcial2020_En`.`Pintores` (`Nombres` ASC) INVISIBLE;

-- CREATE INDEX `IX_Apellidos` ON `Parcial2020_En`.`Pintores` (`Apellidos` ASC) VISIBLE;

CREATE INDEX `IX_NomAp` ON `Parcial2020_En`.`Pintores` (`Apellidos` ASC, `Nombres` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `Parcial2020_En`.`Metodos`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Parcial2020_En`.`Metodos` ;

CREATE TABLE IF NOT EXISTS `Parcial2020_En`.`Metodos` (
  `IDMetodo` INT NOT NULL,
  `Metodo` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`IDMetodo`))
ENGINE = InnoDB;

CREATE UNIQUE INDEX `Metodo_UNIQUE` ON `Parcial2020_En`.`Metodos` (`Metodo` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `Parcial2020_En`.`Cuadros`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Parcial2020_En`.`Cuadros` ;

CREATE TABLE IF NOT EXISTS `Parcial2020_En`.`Cuadros` (
  `IDCuadro` INT NOT NULL,
  `IDPintor` INT NOT NULL,
  `IDMetodo` INT NOT NULL,
  `Titulo` VARCHAR(60) NOT NULL,
  `Fecha` DATE NOT NULL,
  `Precio` DECIMAL(12,2) NOT NULL CHECK(`Precio` > 0.0),
  PRIMARY KEY (`IDCuadro`, `IDPintor`),
  CONSTRAINT `fk_Cuadros_Pintores1`
    FOREIGN KEY (`IDPintor`)
    REFERENCES `Parcial2020_En`.`Pintores` (`IDPintor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Cuadros_Metodos1`
    FOREIGN KEY (`IDMetodo`)
    REFERENCES `Parcial2020_En`.`Metodos` (`IDMetodo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Cuadros_Pintores1_idx` ON `Parcial2020_En`.`Cuadros` (`IDPintor` ASC) VISIBLE;

CREATE INDEX `fk_Cuadros_Metodos1_idx` ON `Parcial2020_En`.`Cuadros` (`IDMetodo` ASC) VISIBLE;

CREATE UNIQUE INDEX `IDCuadro_UNIQUE` ON `Parcial2020_En`.`Cuadros` (`IDCuadro` ASC) VISIBLE;

CREATE INDEX `IX_Titulo` ON `Parcial2020_En`.`Cuadros` (`Titulo` ASC) INVISIBLE;

CREATE INDEX `IX_Fecha` ON `Parcial2020_En`.`Cuadros` (`Fecha` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `Parcial2020_En`.`Certamenes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Parcial2020_En`.`Certamenes` ;

CREATE TABLE IF NOT EXISTS `Parcial2020_En`.`Certamenes` (
  `IDCuadro` INT NOT NULL,
  `IDPintor` INT NOT NULL,
  `IDExhibicion` INT NOT NULL,
  PRIMARY KEY (`IDCuadro`, `IDPintor`, `IDExhibicion`),
  CONSTRAINT `fk_Exhibicion_has_Cuadros_Exhibicion1`
    FOREIGN KEY (`IDExhibicion`)
    REFERENCES `Parcial2020_En`.`Exhibiciones` (`IDExhibicion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Exhibicion_has_Cuadros_Cuadros1`
    FOREIGN KEY (`IDCuadro` , `IDPintor`)
    REFERENCES `Parcial2020_En`.`Cuadros` (`IDCuadro` , `IDPintor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Exhibicion_has_Cuadros_Cuadros1_idx` ON `Parcial2020_En`.`Certamenes` (`IDCuadro` ASC, `IDPintor` ASC) VISIBLE;

CREATE INDEX `fk_Exhibicion_has_Cuadros_Exhibicion1_idx` ON `Parcial2020_En`.`Certamenes` (`IDExhibicion` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `Parcial2020_En`.`Propuestas`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Parcial2020_En`.`Propuestas` ;

CREATE TABLE IF NOT EXISTS `Parcial2020_En`.`Propuestas` (
  `IDPropuestas` INT NOT NULL,
  `IDCuadro` INT NOT NULL,
  `IDPintor` INT NOT NULL,
  `IDExhibicion` INT NOT NULL,
  `Fecha` DATE NULL,
  `Importe` DECIMAL(12,2) NOT NULL CHECK(`Importe` > 0.0), 
  `Persona` VARCHAR(100) NOT NULL,
  `Vendido` CHAR(1) NOT NULL CHECK(`Vendido` IN ('S','N')),
  PRIMARY KEY (`IDPropuestas`, `IDCuadro`, `IDPintor`, `IDExhibicion`),
  CONSTRAINT `fk_Propuestas_Exhibicion_has_Cuadros1`
    FOREIGN KEY (`IDExhibicion` , `IDCuadro` , `IDPintor`)
    REFERENCES `Parcial2020_En`.`Certamenes` (`IDExhibicion` , `IDCuadro` , `IDPintor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Propuestas_Exhibicion_has_Cuadros1_idx` ON `Parcial2020_En`.`Propuestas` (`IDExhibicion` ASC,`IDCuadro` ASC , `IDPintor` ASC) INVISIBLE;
CREATE INDEX `fk_Propuestas_Exhibicion_has_Cuadros2_idx` ON `Parcial2020_En`.`Propuestas` (`IDCuadro` ASC,`IDPintor` ASC) INVISIBLE;
CREATE INDEX `fk_Propuestas_Exhibicion_has_Cuadros3_idx` ON `Parcial2020_En`.`Propuestas` (`IDCuadro` ASC) INVISIBLE;
CREATE INDEX `fk_Propuestas_Exhibicion_has_Cuadros4_idx` ON `Parcial2020_En`.`Propuestas` (`IDPintor` ASC) INVISIBLE;

CREATE UNIQUE INDEX `IDPropuestas_UNIQUE` ON `Parcial2020_En`.`Propuestas` (`IDPropuestas` ASC) INVISIBLE;

CREATE INDEX `IX_Fecha` ON `Parcial2020_En`.`Propuestas` (`Fecha` ASC) VISIBLE;

CREATE INDEX `IX_Persona` ON `Parcial2020_En`.`Propuestas` (`Persona` ASC) VISIBLE;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

INSERT INTO Pintores VALUES(1,'Miró', 'Joan', 'Española');
INSERT INTO Pintores VALUES(2,'Dalí', 'Salvador', 'Española');
INSERT INTO Pintores VALUES(3,'Monet', 'Claude', 'Francesa');
INSERT INTO Pintores VALUES(4,'Escher', 'Maurits', 'Holandesa');
INSERT INTO Pintores VALUES(5,'Spilimbergo', 'Lino', 'Argentina');
INSERT INTO Pintores VALUES(6,'Quinquela Martin', 'Benito', 'Argentina');

INSERT INTO Metodos VALUES(1,'Impresionismo');
INSERT INTO Metodos VALUES(2,'Surrealismo');
INSERT INTO Metodos VALUES(3,'Naturalismo');
INSERT INTO Metodos VALUES(4,'Matemático');
INSERT INTO Metodos VALUES(5,'Realismo');

INSERT INTO Exhibiciones VALUES(1,'Los Surrealistas', 'Renombradas Cuadros de Pintores surrealistas','2009-11-01','2009-12-30');
INSERT INTO Exhibiciones VALUES(2,'Los Españoles', 'Cuadros de pintores españoles','2010-01-01','2010-03-30');
INSERT INTO Exhibiciones VALUES(3,'Los Argentinos', 'Renombradas Cuadros de Pintores argentinos','2010-04-01','2010-05-30');
INSERT INTO Exhibiciones VALUES(4,'Expo Universal', 'Las mejores Cuadros del mundo','2010-06-01','2010-10-30');

INSERT INTO Cuadros VALUES(1,1,2,'Carnaval del Arlequín','1925-01-01',34000000);
INSERT INTO Cuadros VALUES(2,1,2,'Retrato IV','1938-02-11',36000000);
INSERT INTO Cuadros VALUES(3,1,2,'Azul 3','1961-05-01',22000000);
INSERT INTO Cuadros VALUES(4,1,2,'Personaje delante del sol','1968-05-21',46000000);
INSERT INTO Cuadros VALUES(5,1,2,'Tapiz Tarragona','1970-12-15',41000000);
INSERT INTO Cuadros VALUES(6,2,2,'Figura Asomada a la Ventana','1925-10-04',66000000);
INSERT INTO Cuadros VALUES(7,2,2,'El enigma del deseo','1929-05-17',60000000);
INSERT INTO Cuadros VALUES(8,2,2,'El Hombre Invisible','1929-12-14',76000000);
INSERT INTO Cuadros VALUES(9,2,2,'La persistencia de la memoria','1931-06-27',99000000);
INSERT INTO Cuadros VALUES(10,2,2,'Cristo de San Juan de la Cruz','1951-02-06',97000000);
INSERT INTO Cuadros VALUES(11,3,1,'El Desayuno','1865-02-09',77000000);
INSERT INTO Cuadros VALUES(12,3,1,'Mujeres en el Jardín','1866-04-11',96000000);
INSERT INTO Cuadros VALUES(13,3,1,'Impresión, sol naciente','1873-06-01',99000000);
INSERT INTO Cuadros VALUES(14,3,1,'Puente sobre el Sena','1874-07-13',69000000);
INSERT INTO Cuadros VALUES(15,3,1,'Metamorfosis II','1940-02-22',11000000);
INSERT INTO Cuadros VALUES(16,4,4,'Casa de Escaleras','1951-09-01',12000000);
INSERT INTO Cuadros VALUES(17,4,4,'Día y Noche','1939-05-19',21000000);
INSERT INTO Cuadros VALUES(18,4,4,'Reptiles','1943-07-13',9000000);
INSERT INTO Cuadros VALUES(19,4,4,'Manos Dibujando','1948-10-08',30000000);
INSERT INTO Cuadros VALUES(20,4,4,'Cascada','1961-04-23',23000000);
INSERT INTO Cuadros VALUES(21,5,5,'Autorretrato','1917-01-14',1000000);
INSERT INTO Cuadros VALUES(22,5,5,'Canto a la luna','1923-05-11',2000000);
INSERT INTO Cuadros VALUES(23,5,5,'Desnudo de mujer','1926-07-02',3000000);
INSERT INTO Cuadros VALUES(24,5,5,'Acróbata','1927-11-13',1500000);
INSERT INTO Cuadros VALUES(25,5,5,'Paisaje de San Juan','1929-01-26',2500000);
INSERT INTO Cuadros VALUES(26,6,3,'Nocturno','1930-02-20',1300000);
INSERT INTO Cuadros VALUES(27,6,3,'Chimeneas','1930-11-02',3000000);
INSERT INTO Cuadros VALUES(28,6,3,'La Despedida','1936-07-11',5000000);
INSERT INTO Cuadros VALUES(29,6,3,'Desfile del circo','1936-09-15',7000000);
INSERT INTO Cuadros VALUES(30,6,3,'Música y Danza','1936-04-19',3500000);

INSERT INTO Certamenes VALUES(1,1,1);
INSERT INTO Certamenes VALUES(3,1,1);
INSERT INTO Certamenes VALUES(5,1,1);
INSERT INTO Certamenes VALUES(7,2,1);
INSERT INTO Certamenes VALUES(9,2,1);
INSERT INTO Certamenes VALUES(17,4,1);
INSERT INTO Certamenes VALUES(19,4,1);
INSERT INTO Certamenes VALUES(1,1,2);
INSERT INTO Certamenes VALUES(2,1,2);
INSERT INTO Certamenes VALUES(3,1,2);
INSERT INTO Certamenes VALUES(4,1,2);
INSERT INTO Certamenes VALUES(5,1,2);
INSERT INTO Certamenes VALUES(6,2,2);
INSERT INTO Certamenes VALUES(7,2,2);
INSERT INTO Certamenes VALUES(8,2,2);
INSERT INTO Certamenes VALUES(9,2,2);
INSERT INTO Certamenes VALUES(10,2,2);
INSERT INTO Certamenes VALUES(21,5,3);
INSERT INTO Certamenes VALUES(22,5,3);
INSERT INTO Certamenes VALUES(23,5,3);
INSERT INTO Certamenes VALUES(24,5,3);
INSERT INTO Certamenes VALUES(25,5,3);
INSERT INTO Certamenes VALUES(26,6,3);
INSERT INTO Certamenes VALUES(27,6,3);
INSERT INTO Certamenes VALUES(28,6,3);
INSERT INTO Certamenes VALUES(29,6,3);
INSERT INTO Certamenes VALUES(30,6,3);
INSERT INTO Certamenes VALUES(1,1,4);
INSERT INTO Certamenes VALUES(2,1,4);
INSERT INTO Certamenes VALUES(3,1,4);
INSERT INTO Certamenes VALUES(4,1,4);
INSERT INTO Certamenes VALUES(5,1,4);
INSERT INTO Certamenes VALUES(6,2,4);
INSERT INTO Certamenes VALUES(7,2,4);
INSERT INTO Certamenes VALUES(8,2,4);
INSERT INTO Certamenes VALUES(9,2,4);
INSERT INTO Certamenes VALUES(10,2,4);
INSERT INTO Certamenes VALUES(11,3,4);
INSERT INTO Certamenes VALUES(12,3,4);
INSERT INTO Certamenes VALUES(13,3,4);
INSERT INTO Certamenes VALUES(14,3,4);
INSERT INTO Certamenes VALUES(15,3,4);
INSERT INTO Certamenes VALUES(16,4,4);
INSERT INTO Certamenes VALUES(17,4,4);
INSERT INTO Certamenes VALUES(18,4,4);
INSERT INTO Certamenes VALUES(19,4,4);
INSERT INTO Certamenes VALUES(20,4,4);
INSERT INTO Certamenes VALUES(21,5,4);
INSERT INTO Certamenes VALUES(22,5,4);
INSERT INTO Certamenes VALUES(23,5,4);
INSERT INTO Certamenes VALUES(24,5,4);
INSERT INTO Certamenes VALUES(25,5,4);
INSERT INTO Certamenes VALUES(26,6,4);
INSERT INTO Certamenes VALUES(27,6,4);
INSERT INTO Certamenes VALUES(28,6,4);
INSERT INTO Certamenes VALUES(29,6,4);
INSERT INTO Certamenes VALUES(30,6,4);

INSERT INTO Propuestas VALUES(1,1,1,1,'2009-12-01',34000000,'lgonzalez','N');
INSERT INTO Propuestas VALUES(2,1,1,1,'2009-12-02',35000000,'bgates','N');
INSERT INTO Propuestas VALUES(3,1,1,1,'2009-12-04',35500000,'rdeniro','S');
INSERT INTO Propuestas VALUES(4,7,2,1,'2009-12-01',60000000,'kcostner','N');
INSERT INTO Propuestas VALUES(5,7,2,1,'2009-12-06',65000000,'mjordan','S');
INSERT INTO Propuestas VALUES(6,7,2,1,'2009-12-02',63000000,'bgates','N');
INSERT INTO Propuestas VALUES(7,9,2,1,'2009-12-05',99000000,'bgates','N');
INSERT INTO Propuestas VALUES(8,17,4,1,'2009-12-19',21000000,'lgonzalez','N');
INSERT INTO Propuestas VALUES(9,19,4,1,'2009-12-20',30000000,'bgates','N');
INSERT INTO Propuestas VALUES(10,2,1,2,'2010-01-05',36000000,'lgonzalez','N');
INSERT INTO Propuestas VALUES(11,2,1,2,'2010-01-07',38000000,'bgates','N');
INSERT INTO Propuestas VALUES(12,2,1,2,'2010-02-17',40000000,'kcostner','S');
INSERT INTO Propuestas VALUES(13,3,1,2,'2010-01-17',23000000,'mjordan','N');
INSERT INTO Propuestas VALUES(14,3,1,2,'2010-02-03',24000000,'bgates','N');
INSERT INTO Propuestas VALUES(15,4,1,2,'2010-01-03',47000000,'bgates','N');
INSERT INTO Propuestas VALUES(16,8,2,2,'2010-01-05',76000000,'bgates','N');
INSERT INTO Propuestas VALUES(17,8,2,2,'2010-01-15',78000000,'bgates','N');
INSERT INTO Propuestas VALUES(18,8,2,2,'2010-01-23',83000000,'bgates','N');
INSERT INTO Propuestas VALUES(19,8,2,2,'2010-02-05',90000000,'modstrcil','S');
INSERT INTO Propuestas VALUES(20,9,2,2,'2010-02-15',99000000,'bgates','N');
INSERT INTO Propuestas VALUES(21,10,2,2,'2010-03-15',97000000,'rdeniro','N');
INSERT INTO Propuestas VALUES(22,21,5,3,'2010-01-15',1000000,'rdeniro','N');
INSERT INTO Propuestas VALUES(23,21,5,3,'2010-02-01',1200000,'lgonzalez','N');
INSERT INTO Propuestas VALUES(24,22,5,3,'2010-02-01',2000000,'bgates','N');
INSERT INTO Propuestas VALUES(25,22,5,3,'2010-03-11',2100000,'bgates','N');
INSERT INTO Propuestas VALUES(26,23,5,3,'2010-02-21',3000000,'lgonzalez','N');
INSERT INTO Propuestas VALUES(27,30,6,3,'2010-03-11',3600000,'mjordan','N');
INSERT INTO Propuestas VALUES(28,30,6,3,'2010-03-13',3700000,'bgates','N');
INSERT INTO Propuestas VALUES(29,10,2,4,'2010-01-13',97000000,'bgates','N');
INSERT INTO Propuestas VALUES(30,10,2,4,'2010-01-22',99000000,'modstrcil','N');
INSERT INTO Propuestas VALUES(31,13,3,4,'2010-01-17',99000000,'lgonzalez','N');
INSERT INTO Propuestas VALUES(32,13,3,4,'2010-01-17',91000000,'bgates','N');
INSERT INTO Propuestas VALUES(33,16,4,4,'2010-01-02',12000000,'bgates','N');
INSERT INTO Propuestas VALUES(34,16,4,4,'2010-01-03',12500000,'lgozalez','N');
INSERT INTO Propuestas VALUES(35,16,4,4,'2010-01-04',15000000,'mjordan','N');
INSERT INTO Propuestas VALUES(36,16,4,4,'2010-01-14',17000000,'rdeniro','N');
INSERT INTO Propuestas VALUES(37,30,6,4,'2010-01-04',3500000,'rdeniro','N');
INSERT INTO Propuestas VALUES(38,30,6,4,'2010-01-04',3600000,'modstrcil','N');
INSERT INTO Propuestas VALUES(39,30,6,4,'2010-01-11',3800000,'bgates','N');
INSERT INTO Propuestas VALUES(40,30,6,4,'2010-01-24',4200000,'mjordan','N');
INSERT INTO Propuestas VALUES(41,30,6,4,'2010-02-09',5000000,'lgonzalez','S');

/****************************************************************************************
2) Realizar un procedimiento almacenado, llamado BorrarCuadro , para borrar un
cuadro. El mismo deberá incluir el control de errores lógicos y mensajes de error
necesarios. Incluir el código con la llamada al procedimiento probando todos los
casos con datos incorrectos y uno con datos correctos. [15]
****************************************************************************************/
DROP PROCEDURE IF EXISTS BorrarCuadro;
DELIMITER //

CREATE PROCEDURE BorrarCuadro(IN pIDCuadro INT)
BEGIN
  DECLARE cuadro_count INT;

  -- Verificar si el cuadro existe
  SELECT COUNT(*) INTO cuadro_count FROM Cuadros WHERE IDCuadro = pIDCuadro;

  -- Si el cuadro tieen un certamen, no se puede borrar
  IF EXISTS(SELECT Certamenes.IDCuadro FROM Certamenes WHERE Certamenes.IDCuadro = pIDCuadro) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error un Certamen tiene como referencia el cuadro que se desea eliminar';
    END IF;
  -- Si no se encuentra el cuadro, mostrar un mensaje de error
  IF cuadro_count = 0 THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El cuadro especificado no existe.';
  ELSE
    -- Eliminar el cuadro
    DELETE FROM Cuadros WHERE IDCuadro = pIDCuadro;
    SELECT 'Cuadro eliminado correctamente.';
  END IF;
END //

DELIMITER ;


SELECT * FROM Cuadros;
CALL BorrarCuadro(999); -- Intentar borrar un cuadro inexistente
INSERT INTO Cuadros VALUES(32,1,2,'Carnaval OLD','1925-01-01',34000000);
CALL BorrarCuadro(32); -- Borrar un cuadro existente
SELECT * FROM Cuadros;  
SELECT * FROM AuditoriaBorrado;  



/*************************************************************************************
3) Realizar un procedimiento almacenado, llamado EstadoCuadros , para que dado un
pintor, muestre todos sus cuadros junto con su precio, la mejor propuesta recibida, si
fue vendido o no y la ganancia (diferencia entre el importe que se pagó por el cuadro
y el precio del mismo). Se deberán mostrar todos los cuadros, incluso aquellos que
no tienen propuestas (la mejor propuesta será 0). El formato deberá ser: IDCuadro,
Título, Precio, Mejor propuesta, Fue vendido [S|N], Ganancia.
**************************************************************************************/
DROP PROCEDURE IF EXISTS EstadoCuadros;
DELIMITER //

CREATE PROCEDURE EstadoCuadros(IN pPintor VARCHAR(100))
BEGIN
    SELECT c.IDCuadro, c.Titulo, c.Precio,
        COALESCE(MAX(p.Importe), 0) AS MejorPropuesta,
        -- MAX(IF(p.Vendido IS NOT NULL, 'S', 'N')) AS FueVendido,
        (SELECT P.Vendido FROM Propuestas P WHERE P.IDCuadro = C.IDCuadro ORDER BY P.Importe DESC LIMIT 1) AS FueVendido,
        MAX(IF(p.Vendido IS NOT NULL, (p.Importe - c.Precio), 0)) AS Ganancia
    FROM Cuadros c
    LEFT JOIN Propuestas p ON c.IDCuadro = p.IDCuadro
    WHERE c.IDPintor = pPintor
    GROUP BY c.IDCuadro, c.Titulo, c.Precio;
END //

DELIMITER ;

CALL EstadoCuadros(6);



/*SELECT      C.IDCuadro, Titulo, Precio, COALESCE(MAX(Importe), 0) AS 'Mejor propuesta', MAX(Vendido) AS Vendido, MAX(Importe - Precio) AS Ganancia
FROM        Cuadros C
INNER JOIN  Propuestas P on C.IDCuadro = P.IDCuadro
WHERE       P.IDPintor = 1
GROUP BY    C.IDCuadro, Titulo, Precio;*/

DROP PROCEDURE IF EXISTS EstadoCuadros;
DELIMITER //

CREATE PROCEDURE EstadoCuadros(IN pidPintor INT)
BEGIN
    -- Tabla temporal para almacenar los cuadros del pintor
    CREATE TEMPORARY TABLE IF NOT EXISTS temp_cuadros (
        id INT,
        titulo VARCHAR(255),
        precio DECIMAL(10, 2),
        mejor_propuesta DECIMAL(10, 2),
        vendido CHAR(1),
        ganancia DECIMAL(10, 2)
    );
    
    -- Insertar todos los cuadros del pintor en la tabla temporal
    INSERT INTO temp_cuadros (id, titulo, precio, mejor_propuesta, vendido, ganancia)
    SELECT c.IDCuadro, c.Titulo, c.Precio, COALESCE(MAX(p.Importe), 0),
           CASE WHEN MAX(p.Importe) IS NOT NULL THEN 'N' ELSE 'S' END,
           COALESCE(MAX(p.Importe), 0) - c.Precio
    FROM Cuadros c
    LEFT JOIN Propuestas p ON c.IDCuadro = p.IDCuadro
    WHERE c.IDPintor = pidPintor
    GROUP BY c.IDCuadro, c.Titulo, c.Precio;
    
    -- Mostrar los resultados de la tabla temporal
    SELECT id, titulo, precio, mejor_propuesta, vendido, ganancia
    FROM temp_cuadros;
    
    -- Eliminar la tabla temporal
    DROP TABLE IF EXISTS temp_cuadros;
END //

DELIMITER ;
/*************************************************************************************
4) Realizar una vista, llamada VentasCuadros , que muestre un listado de las ventas
de cuadros. Se deberá mostrar el identificador del cuadro, su título, el método con el
que se lo pintó, el identificador de su pintor, apellidos y nombres de su pintor,
identificador de la exhibición donde se vendió el cuadro, el título de la misma, la
fecha en que se realizó la venta, nombre de la persona a la que se vendió el cuadro
y el importe que pagó.
**************************************************************************************/
CREATE VIEW VentasCuadros AS
SELECT C.IDCuadro,
       C.Titulo AS                      TituloCuadro,
       Metodo,
       C.IDPintor,
       CONCAT(Apellidos, ', ', Nombres) Pintor,
       E.IDExhibicion,
       E.Titulo AS                      TituloExhibicion,
       P.Fecha  AS                      FechaVenta,
       Persona  AS                      Comprador,
       Importe                        
FROM Cuadros C
         INNER JOIN Propuestas P on C.IDCuadro = P.IDCuadro AND C.IDPintor = P.IDPintor
         INNER JOIN Metodos M on C.IDMetodo = M.IDMetodo
         INNER JOIN Pintores PI on C.IDPintor = PI.IDPintor
         INNER JOIN Exhibiciones E on P.IDExhibicion = E.IDExhibicion
WHERE Vendido = 'S';
SELECT * FROM VentasCuadros;
 
 /**************************************************************************************************
 5) Implementar la lógica para llevar una auditoría para la operación del apartado 2. Se
deberá auditar el usuario que la hizo, la fecha y hora de la operación, la máquina
desde donde se la hizo y toda la información necesaria para la auditoría
 ***************************************************************************************************/
DROP TABLE IF EXISTS `AuditoriaBorrado` ;

CREATE TABLE IF NOT EXISTS `AuditoriaBorrado` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `IDCuadro` INT NOT NULL,
  `IDPintor` INT NOT NULL,
  `IDMetodo` INT NOT NULL,
  `Titulo` VARCHAR(60) NOT NULL,
  `FechaCuadro` DATE NOT NULL,
  `Precio` DECIMAL(12,2) NOT NULL,
  `Tipo` CHAR(1) NOT NULL, -- tipo de operación (I: Inserción, B: Borrado, M: Modificación)
  `Usuario` VARCHAR(45) NOT NULL,  
  `Maquina` VARCHAR(45) NOT NULL,  
  `Fecha` DATETIME NOT NULL,
  PRIMARY KEY (`ID`)
);

DROP TRIGGER IF EXISTS AuditoriaBorrado;
DELIMITER //
CREATE TRIGGER `AuditoriaBorrado` 
AFTER DELETE ON `Cuadros` FOR EACH ROW
BEGIN
	INSERT INTO AuditoriaBorrado VALUES (
			DEFAULT, 
			OLD.IDCuadro,
			OLD.IDPintor, 
			OLD.IDMetodo,
			OLD.Titulo,
			OLD.Fecha,
			OLD.Precio,
			'B', 
			SUBSTRING_INDEX(USER(), '@', 1), 
			SUBSTRING_INDEX(USER(), '@', -1), 
			NOW()
	  );
END //
DELIMITER ;
