/* 1) Según el modelo lógico de la figura, crear los objetos necesarios. Las posibles
clases de trabajadores pueden ser únicamente “Oficinista” o “Cartero”. Los tipos de
paquetes sólo pueden ser “El usuario lo prepara” o “La agencia lo prepara”. Las
clases de correspondencias sólo pueden ser “Simple”, “Certificada” o “Express”. El
sello puede tomar los valores “Negro” o “Rojo”. No puede haber 2 trabajadores con
el mismo documento. Deberá haber índices por las claves primarias y propagadas.
Finalmente, ejecutar el script Datos.sql para poblar la base de datos.*/

-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema parcial2020_2
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `parcial2020_2` ;

-- -----------------------------------------------------
-- Schema parcial2020_2
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `parcial2020_2` DEFAULT CHARACTER SET utf8 ;
USE `parcial2020_2` ;

-- -----------------------------------------------------
-- Table `parcial2020_2`.`Usuarios`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `parcial2020_2`.`Usuarios` ;

CREATE TABLE IF NOT EXISTS `parcial2020_2`.`Usuarios` (
  `IDUsuario` INT NOT NULL,
  `Apellidos` VARCHAR(45) NOT NULL,
  `Nombres` VARCHAR(45) NOT NULL,
  `Domicilio` VARCHAR(45) NOT NULL,
  `Localidad` VARCHAR(45) NOT NULL,
  `CP` VARCHAR(8) NOT NULL,
  PRIMARY KEY (`IDUsuario`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `parcial2020_2`.`Agencias`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `parcial2020_2`.`Agencias` ;

CREATE TABLE IF NOT EXISTS `parcial2020_2`.`Agencias` (
  `IDAgencia` INT NOT NULL,
  `Direccion` VARCHAR(45) NOT NULL,
  `Localidad` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`IDAgencia`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `parcial2020_2`.`Trabajadores`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `parcial2020_2`.`Trabajadores` ;

CREATE TABLE IF NOT EXISTS `parcial2020_2`.`Trabajadores` (
  `Legajo` INT NOT NULL,
  `Documento` INT NOT NULL,
  `Nombres` VARCHAR(45) NOT NULL,
  `Apellidos` VARCHAR(45) NOT NULL,
  `Ingreso` DATE NOT NULL,
  `Clase` VARCHAR(14) NOT NULL CHECK(`Clase` IN ('Oficinista','Cartero')),
  `IDAgencia` INT NOT NULL,
  PRIMARY KEY (`Legajo`),
  CONSTRAINT `fk_Trabajadores_Agencias1`
    FOREIGN KEY (`IDAgencia`)
    REFERENCES `parcial2020_2`.`Agencias` (`IDAgencia`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Trabajadores_Agencias1_idx` ON `parcial2020_2`.`Trabajadores` (`IDAgencia` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `parcial2020_2`.`Pedidos`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `parcial2020_2`.`Pedidos` ;

CREATE TABLE IF NOT EXISTS `parcial2020_2`.`Pedidos` (
  `IDPedido` VARCHAR(20) NOT NULL,
  `Remitente` INT NOT NULL,
  `Destinatario` INT NOT NULL,
  `Legajo` INT NOT NULL,
  `Costo` DECIMAL(5,2) NOT NULL,
  PRIMARY KEY (`IDPedido`),
  CONSTRAINT `fk_Pedidos_Usuario`
    FOREIGN KEY (`Remitente`)
    REFERENCES `parcial2020_2`.`Usuarios` (`IDUsuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Pedidos_Usuario1`
    FOREIGN KEY (`Destinatario`)
    REFERENCES `parcial2020_2`.`Usuarios` (`IDUsuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Pedidos_Trabajadores1`
    FOREIGN KEY (`Legajo`)
    REFERENCES `parcial2020_2`.`Trabajadores` (`Legajo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Pedidos_Usuario_idx` ON `parcial2020_2`.`Pedidos` (`Remitente` ASC) VISIBLE;

CREATE INDEX `fk_Pedidos_Usuario1_idx` ON `parcial2020_2`.`Pedidos` (`Destinatario` ASC) VISIBLE;

CREATE INDEX `fk_Pedidos_Trabajadores1_idx` ON `parcial2020_2`.`Pedidos` (`Legajo` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `parcial2020_2`.`Correspondencias`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `parcial2020_2`.`Correspondencias` ;

CREATE TABLE IF NOT EXISTS `parcial2020_2`.`Correspondencias` (
  `IDPedido` VARCHAR(20) NOT NULL,
  `Clase` VARCHAR(12) NOT NULL CHECK(`Clase` IN ('Simple','Certificada','Express')),
  `Sello` VARCHAR(5) NOT NULL CHECK(`Sello` IN ('Negro','Rojo')),
  CONSTRAINT `fk_Correspondencias_Pedidos1`
    FOREIGN KEY (`IDPedido`)
    REFERENCES `parcial2020_2`.`Pedidos` (`IDPedido`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Correspondencias_Pedidos1_idx` ON `parcial2020_2`.`Correspondencias` (`IDPedido` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `parcial2020_2`.`Paquetes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `parcial2020_2`.`Paquetes` ;

CREATE TABLE IF NOT EXISTS `parcial2020_2`.`Paquetes` (
  `IDPedido` VARCHAR(20) NOT NULL,
  `Tipo` VARCHAR(40) NOT NULL CHECK(`Tipo` IN ('El usuario lo prepara','La agencia lo prepara')),
  CONSTRAINT `fk_Paquetes_Pedidos1`
    FOREIGN KEY (`IDPedido`)
    REFERENCES `parcial2020_2`.`Pedidos` (`IDPedido`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Paquetes_Pedidos1_idx` ON `parcial2020_2`.`Paquetes` (`IDPedido` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `parcial2020_2`.`PedidosPorAgencias`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `parcial2020_2`.`PedidosPorAgencias` ;

CREATE TABLE IF NOT EXISTS `parcial2020_2`.`PedidosPorAgencias` (
  `IDAgencia` INT NOT NULL,
  `IDPedido` VARCHAR(20) NOT NULL,
  `FechaYHora` DATETIME NOT NULL,
  PRIMARY KEY (`IDAgencia`, `IDPedido`),
  CONSTRAINT `fk_Pedidos_has_Agencias_Agencias1`
    FOREIGN KEY (`IDAgencia`)
    REFERENCES `parcial2020_2`.`Agencias` (`IDAgencia`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PedidosPorAgencias_Pedidos1`
    FOREIGN KEY (`IDPedido`)
    REFERENCES `parcial2020_2`.`Pedidos` (`IDPedido`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Pedidos_has_Agencias_Agencias1_idx` ON `parcial2020_2`.`PedidosPorAgencias` (`IDAgencia` ASC) VISIBLE;

CREATE INDEX `fk_PedidosPorAgencias_Pedidos1_idx` ON `parcial2020_2`.`PedidosPorAgencias` (`IDPedido` ASC) VISIBLE;

USE parcial2020_2;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

INSERT INTO `Usuarios` VALUES (1, 'Rosino', 'Rubén', 'San Lorenzo 4700', 'San Miguel de Tucumán', '4000');
INSERT INTO `Usuarios` VALUES (2, 'Masclef', 'Gabriel', 'Aconquija 600', 'Yerba Buena', '4107');
INSERT INTO `Usuarios` VALUES (3, 'Chavanne', 'Luciana', 'Lucas Córdoba 403', 'Bariloche', '3000');
INSERT INTO `Usuarios` VALUES (4, 'MaxFois', 'Mariana', 'Leandro Além 303', 'Usuahia', '2000');
INSERT INTO `Usuarios` VALUES (5, 'Cólzera', 'Horacio', 'Córdoba 4403', 'Santa Rosa', '3000');
INSERT INTO `Usuarios` VALUES (6, 'Monardi', 'Mauricio', 'Neuquén 888', 'Rawson', '2500');
INSERT INTO `Usuarios` VALUES (7, 'Razzotti', 'Helena', 'Italia 190', 'Rawson', '2500');
INSERT INTO `Usuarios` VALUES (8, 'Medina', 'Cecilia', 'Julio Argentino Roca 123', 'Santa Rosa', '3000');
INSERT INTO `Usuarios` VALUES (9, 'Medicci', 'Graciela', 'San Juan 2033', 'Bariloche', '3000');
INSERT INTO `Usuarios` VALUES (10, 'García', 'Paola', 'Jujuy 1803', 'Bariloche', '3000');
INSERT INTO `Usuarios` VALUES (11, 'Bianchi', 'Rodrigo', 'Tucumán 254', 'Bariloche', '3000');
INSERT INTO `Usuarios` VALUES (12, 'Leal', 'Raúl', 'España 1600', 'Usuahia', '2000');
INSERT INTO `Usuarios` VALUES (13, 'Muñoz', 'Miguel', 'San Martín 232', 'Bariloche', '3000');
INSERT INTO `Usuarios` VALUES (14, 'Hawk', 'Luis', 'Bs As 1500', 'Bariloche', '3000');
INSERT INTO `Usuarios` VALUES (15, 'Valiente', 'Luciana', 'Sarmiento 765', 'Rawson', '2500');
INSERT INTO `Usuarios` VALUES (16, 'Ezquer', 'Ezequiel', 'Catamarca 151', 'Rawson', '2500');
INSERT INTO `Usuarios` VALUES (17, 'Barbosa', 'Mariano', 'Gral. Manuel Belgrano 652', 'Rawson', '2500');
INSERT INTO `Usuarios` VALUES (18, 'Guerra', 'Carlos', 'Alem 538', 'San Miguel de Tucumán', '4000');
INSERT INTO `Usuarios` VALUES (19, 'Koukas', 'Esteban', 'Pelegrini 245', 'San Miguel de Tucumán', '4000');
INSERT INTO `Usuarios` VALUES (20, 'Esquel', 'Juan', 'Independencia 500', 'Salta', '5000');
INSERT INTO `Usuarios` VALUES (21, 'Guevara', 'Adriana', 'La Paz 228', 'San Salvador de Jujuy', '6000');
INSERT INTO `Usuarios` VALUES (22, 'Gutierrez', 'Estela', 'Bolivia 1328', 'Misiones', '7000');
INSERT INTO `Usuarios` VALUES (23, 'Walsh', 'Rodolfo', '25 de Mayo 458', 'San Salvador del V. de Catamarca', '8000');
INSERT INTO `Usuarios` VALUES (24, 'Perez', 'Alejandro', 'Batalla de Chacabuco 1534', 'San Salvador de Jujuy', '6000');
INSERT INTO `Usuarios` VALUES (25, 'Sanchez', 'Pablo', 'Batalla de Ayacucho 221', 'La Rioja', '9000');
INSERT INTO `Usuarios` VALUES (26, 'Chavez', 'Paula', 'San Lorenzo 2228', 'Misiones', '7000');
INSERT INTO `Usuarios` VALUES (27, 'Ceballos', 'Daniel', 'Chile 228', 'Tartagal', '6010');
INSERT INTO `Usuarios` VALUES (28, 'Aguirre', 'Marta', 'Don Bosco 923', 'Tinogasta', '8900');
INSERT INTO `Usuarios` VALUES (29, 'Segovia', 'Bibiana', 'Laprida 108', 'Belen', '8300');
INSERT INTO `Usuarios` VALUES (30, 'Perez', 'Enzo', 'Uruguay 318', 'Londres', '8200');
INSERT INTO `Usuarios` VALUES (31, 'Juncos', 'Pierino', 'Mitre 2228', 'Joaquin V. Gonalez', '5200');
INSERT INTO `Usuarios` VALUES (32, 'Rubio', 'Paulina', 'Mate de Luna 1228', 'General Mosconi', '5300');


INSERT INTO `Agencias` VALUES (1, 'Av. Rivadavia 3976', 'Almagro');
INSERT INTO `Agencias` VALUES (2, 'Av. Corrientes 3876', 'Almagro');
INSERT INTO `Agencias` VALUES (3, 'Av. Rivadavia 4225', 'Almagro');
INSERT INTO `Agencias` VALUES (4, 'AV. LA PLATA 1045', 'Boedo');
INSERT INTO `Agencias` VALUES (5, 'AV. SAN JUAN 3668', 'Boedo');
INSERT INTO `Agencias` VALUES (6, 'MAZA 1730', 'Boedo');
INSERT INTO `Agencias` VALUES (7, 'VILLEGAS 837', 'Catamarca');
INSERT INTO `Agencias` VALUES (8, 'RIVADAVIA 632', 'Catamarca');
INSERT INTO `Agencias` VALUES (9, 'AV. COLÓN Y AV. E. OCAMPO', 'Catamarca');
INSERT INTO `Agencias` VALUES (10, 'SAN MARTÍN 764', 'Catamarca');
INSERT INTO `Agencias` VALUES (11, 'RIVADAVIA 747', 'Catamarca');
INSERT INTO `Agencias` VALUES (12, 'BELGRANO 481', 'Santa María');
INSERT INTO `Agencias` VALUES (13, '25 DE MAYO Y PINO', 'Tinogasta');
INSERT INTO `Agencias` VALUES (14, 'RIVADAVIA 150', 'Comodoro Rivadia');
INSERT INTO `Agencias` VALUES (15, 'ANÍBAL FORCADAS 678', 'Comodoro Rivadia');
INSERT INTO `Agencias` VALUES (16, 'MITRE 777', 'Esquel');
INSERT INTO `Agencias` VALUES (17, 'BELGRANO 742', 'Puerto Madryn');
INSERT INTO `Agencias` VALUES (18, 'MOSCONI 187', 'Puerto Madryn');
INSERT INTO `Agencias` VALUES (19, 'AV. GALES 824', 'Puerto Madryn');
INSERT INTO `Agencias` VALUES (20, 'MARACAIBO 48', 'Córdoba');
INSERT INTO `Agencias` VALUES (21, 'ALVEAR 84', 'Córdoba');
INSERT INTO `Agencias` VALUES (22, 'LA RIOJA 1142 / 44', 'Córdoba');
INSERT INTO `Agencias` VALUES (23, 'BOULEVARD ROCA 380', 'Alejandro Roca');
INSERT INTO `Agencias` VALUES (24, 'TUCUMÁN 410', 'Alicia');
INSERT INTO `Agencias` VALUES (25, 'SAN MARTÍN 276/78', 'Jujuy');
INSERT INTO `Agencias` VALUES (26, '25 DE MAYO 70', 'La Quiaca');
INSERT INTO `Agencias` VALUES (27, 'AV. SAN MARTÍN 33', 'Palpalá');
INSERT INTO `Agencias` VALUES (28, 'AV. RIVADAVIA 350', 'La Rioja');
INSERT INTO `Agencias` VALUES (29, 'SAN NICOLÁS DE BARI (O) 540', 'La Rioja');
INSERT INTO `Agencias` VALUES (30, 'AV. ESPAÑA 1028', 'Mendoza');
INSERT INTO `Agencias` VALUES (31, ' JUAN B. JUSTO 130', 'Mendoza');
INSERT INTO `Agencias` VALUES (32, ' CASEROS 1332', 'Salta');
INSERT INTO `Agencias` VALUES (33, 'SANTIAGO DEL ESTERO 541', 'Salta');
INSERT INTO `Agencias` VALUES (34, 'CASEROS 650', 'Salta');
INSERT INTO `Agencias` VALUES (35, 'JUJUY 238 / 240', 'San Miguel de Tucumán');
INSERT INTO `Agencias` VALUES (36, 'JUNÍN Y MARCOS PAZ', 'San Miguel de Tucumán');
INSERT INTO `Agencias` VALUES (37, ' AV. MITRE 859', 'San Miguel de Tucumán');
INSERT INTO `Agencias` VALUES (38, 'AV. SIRIA 2202', 'San Miguel de Tucumán');
INSERT INTO `Agencias` VALUES (39, ' CARIOLA 42', 'Yerba Buena');
INSERT INTO `Agencias` VALUES (40, '25 DE MAYO 260', 'Monteros');
INSERT INTO `Agencias` VALUES (41, 'CALLE 9 N° 1048 ENTRE 29 Y 30', '25 de Mayo');
INSERT INTO `Agencias` VALUES (42, 'AV. ITALIA 1137', 'Resistencia');
INSERT INTO `Agencias` VALUES (43, '15 DE SETIEMBRE Y GREGORIO MAYO', 'Rawson');
INSERT INTO `Agencias` VALUES (44, 'MENDOZA 1330', 'Corrientes');
INSERT INTO `Agencias` VALUES (45, 'ALMAFUERTE 1504', 'Paraná');
INSERT INTO `Agencias` VALUES (46, 'SAAVEDRA 518', 'Formosa');
INSERT INTO `Agencias` VALUES (47, 'DANTE ALIGHIERI 1346', 'Santa Rosa');
INSERT INTO `Agencias` VALUES (48, 'AYACUCHO 2242', 'Posadas');
INSERT INTO `Agencias` VALUES (49, 'SAN MARTÍN 196', 'Neuquén');
INSERT INTO `Agencias` VALUES (50, 'GÜEMES 495', 'Viedma');
INSERT INTO `Agencias` VALUES (51, 'MENDOZA 2778', 'San Juan');
INSERT INTO `Agencias` VALUES (52, ' AV. DEL SOL Y CARLOS PELLEGRINI', 'Merlo');
INSERT INTO `Agencias` VALUES (53, 'SUREDA 99', 'Rio Gallegos');
INSERT INTO `Agencias` VALUES (54, 'MENDOZA 3343', 'Santa Fe');
INSERT INTO `Agencias` VALUES (55, 'HIPÓLITO YRIGOYEN 950', 'Santiago del Estero');
INSERT INTO `Agencias` VALUES (56, 'MAIPÚ 790', 'Ushuaia');


INSERT INTO `Trabajadores` VALUES (10001, 31275626, 'Gerónimo', 'Hidalgo', '2002-07-13', 'Cartero', 1);
INSERT INTO `Trabajadores` VALUES (10002, 26513425, 'Adriana', 'Arce', '2003-03-12', 'Oficinista', 1);
INSERT INTO `Trabajadores` VALUES (10003, 20189224, 'Arturo', 'Diaz', '1992-10-25', 'Cartero', 1);
INSERT INTO `Trabajadores` VALUES (10004, 30153220, 'Adolfo', 'Ale', '2000-10-25', 'Oficinista', 1);
INSERT INTO `Trabajadores` VALUES (10005, 27823477, 'Antonio', 'Arce', '2007-01-17', 'Cartero', 1);
INSERT INTO `Trabajadores` VALUES (20001, 31221566, 'Adela', 'Maza', '2000-02-02', 'Cartero', 2);
INSERT INTO `Trabajadores` VALUES (20002, 34231566, 'Adelina', 'Merced', '2000-02-02', 'Cartero', 2);
INSERT INTO `Trabajadores` VALUES (20003, 34655781, 'Adriana', 'Cajal', '1994-11-03', 'Oficinista', 2);
INSERT INTO `Trabajadores` VALUES (20004, 31123449, 'Ana María', 'Wolf', '1999-03-20', 'Oficinista', 2);
INSERT INTO `Trabajadores` VALUES (20005, 30217571, 'Angel', 'Cáceres', '2008-06-23', 'Cartero', 2);
INSERT INTO `Trabajadores` VALUES (30001, 29221566, 'Estela', 'Maris', '2001-02-24', 'Cartero', 3);
INSERT INTO `Trabajadores` VALUES (30002, 30221101, 'Florencia', 'García', '2000-03-21', 'Oficinista', 3);
INSERT INTO `Trabajadores` VALUES (30003, 30178992, 'Adela', 'García', '2000-03-21', 'Oficinista', 3);
INSERT INTO `Trabajadores` VALUES (40001, 33224136, 'Héctor', 'Príada', '1992-12-02', 'Oficinista', 4);
INSERT INTO `Trabajadores` VALUES (40002, 29356906, 'Alfonso', 'Guerra', '2001-05-07', 'Oficinista', 4);
INSERT INTO `Trabajadores` VALUES (40003, 35756766, 'Alfredo', 'Menendez', '2008-08-08', 'Cartero', 4);
INSERT INTO `Trabajadores` VALUES (40004, 27131806, 'Angela', 'Meridia', '2000-09-12', 'Cartero', 4);
INSERT INTO `Trabajadores` VALUES (50001, 30299106, 'Gabriel', 'Gonzalez', '2001-11-21', 'Oficinista', 5);
INSERT INTO `Trabajadores` VALUES (50002, 34031666, 'Francisco', 'Rodriguez', '2001-03-11', 'Cartero', 5);
INSERT INTO `Trabajadores` VALUES (50003, 29435221, 'Álvaro', 'Vega', '1993-12-01', 'Cartero', 5);
INSERT INTO `Trabajadores` VALUES (60001, 33431296, 'Nelsón', 'Martinez', '2009-08-12', 'Oficinista', 6);
INSERT INTO `Trabajadores` VALUES (60002, 31271596, 'Josefina', 'Galarza', '2007-12-21', 'Cartero', 6);
INSERT INTO `Trabajadores` VALUES (60003, 34098991, 'José Hernán', 'Cuevas', '2000-10-14', 'Cartero', 6);
INSERT INTO `Trabajadores` VALUES (70001, 34598211, 'José María', 'Galarza', '2001-01-11', 'Oficinista', 7);
INSERT INTO `Trabajadores` VALUES (70002, 24298593, 'Juan', 'Chavez', '2011-10-01', 'Cartero', 7);
INSERT INTO `Trabajadores` VALUES (70003, 30951972, 'Andrea', 'Zossi', '1998-05-07', 'Cartero', 7);
INSERT INTO `Trabajadores` VALUES (80001, 31255355, 'Marta', 'Rosso', '1999-03-07', 'Oficinista', 8);
INSERT INTO `Trabajadores` VALUES (80002, 30712447, 'Germán', 'Sanchez', '2003-11-21', 'Cartero', 8);
INSERT INTO `Trabajadores` VALUES (80003, 31751979, 'Leandro', 'Estevez', '2000-03-12', 'Cartero', 8);
INSERT INTO `Trabajadores` VALUES (90001, 32951972, 'Luis', 'Diaz', '1999-09-09', 'Oficinista', 9);
INSERT INTO `Trabajadores` VALUES (90002, 35751933, 'Andrés', 'Raya', '1998-05-07', 'Cartero', 9);
INSERT INTO `Trabajadores` VALUES (100001, 34001233, 'Sofia', 'Alderete', '1999-09-09', 'Oficinista', 10);
INSERT INTO `Trabajadores` VALUES (100002, 37094566, 'Lisandro', 'Funes', '1994-03-21', 'Cartero', 10);
INSERT INTO `Trabajadores` VALUES (110001, 30096431, 'Domingo', 'Sarmiento', '2003-01-01', 'Oficinista', 11);
INSERT INTO `Trabajadores` VALUES (110002, 33567902, 'Cristina', 'Perez', '1999-09-09', 'Cartero', 11);
INSERT INTO `Trabajadores` VALUES (120001, 36231172, 'Amanda', 'Peralta', '2003-07-15', 'Oficinista', 12);
INSERT INTO `Trabajadores` VALUES (120002, 30123672, 'Edgardo', 'Dominguez', '1992-01-19', 'Cartero', 12);
INSERT INTO `Trabajadores` VALUES (130001, 35334551, 'Facundo', 'Pondal', '2000-05-01', 'Oficinista', 13);
INSERT INTO `Trabajadores` VALUES (130002, 30111982, 'Gabriel', 'Parodi', '2007-01-19', 'Cartero', 13);
INSERT INTO `Trabajadores` VALUES (140001, 33781092, 'Jorge Ezequiel', 'Bravo Cordoba', '2007-03-09', 'Oficinista', 14);
INSERT INTO `Trabajadores` VALUES (140002, 34355120, 'Juan Pablo', 'Abuin', '2008-03-12', 'Cartero', 14);
INSERT INTO `Trabajadores` VALUES (150001, 30145123, 'Luis', 'Remis', '2009-09-09', 'Oficinista', 15);
INSERT INTO `Trabajadores` VALUES (150002, 33977977, 'Pablo', 'Alcorta', '2000-01-24', 'Cartero', 15);
INSERT INTO `Trabajadores` VALUES (160001, 39002901, 'Luis', 'Arce', '2010-10-13', 'Oficinista', 16);
INSERT INTO `Trabajadores` VALUES (160002, 30664941, 'Alejandra', 'Maza', '1993-11-01', 'Cartero', 16);
INSERT INTO `Trabajadores` VALUES (170001, 31923912, 'Cecilia', 'Alamo', '1999-09-09', 'Oficinista', 17);
INSERT INTO `Trabajadores` VALUES (170002, 37754183, 'Noelia', 'Juarez', '2000-03-17', 'Cartero', 17);
INSERT INTO `Trabajadores` VALUES (180001, 32297878, 'Laura', 'Juarez', '1993-11-09', 'Oficinista', 18);
INSERT INTO `Trabajadores` VALUES (180002, 34551189, 'Elisa', 'Apaza', '1993-09-09', 'Cartero', 18);
INSERT INTO `Trabajadores` VALUES (190001, 34099451, 'Leandro', 'Ceballos', '2003-10-19', 'Oficinista', 19);
INSERT INTO `Trabajadores` VALUES (190002, 30045988, 'Pamela', 'Anderson', '2000-01-12', 'Cartero', 19);
INSERT INTO `Trabajadores` VALUES (200001, 39771324, 'Victor', 'Cardenas', '2013-09-11', 'Oficinista', 20);
INSERT INTO `Trabajadores` VALUES (200002, 33641812, 'Noelia', 'Salado', '2012-11-12', 'Cartero', 20);
INSERT INTO `Trabajadores` VALUES (210001, 30223160, 'Estefania', 'Diaz', '1993-01-18', 'Oficinista', 21);
INSERT INTO `Trabajadores` VALUES (210002, 31551899, 'Nicolas', 'Padilla', '1999-11-23', 'Cartero', 21);
INSERT INTO `Trabajadores` VALUES (220001, 302333771, 'Daniel', 'Cohen', '1994-07-07', 'Oficinista', 22);
INSERT INTO `Trabajadores` VALUES (220002, 39923900, 'Julio Argentino', 'Roca', '1994-03-14', 'Cartero', 22);
INSERT INTO `Trabajadores` VALUES (230001, 34596411, 'Eva', 'Lopez', '2003-06-01', 'Oficinista', 23);
INSERT INTO `Trabajadores` VALUES (230002, 35923917, 'Luis', 'Aguilar', '2001-01-15', 'Cartero', 23);
INSERT INTO `Trabajadores` VALUES (240001, 30881177, 'Umberto', 'Lopez', '2003-01-09', 'Oficinista', 24);
INSERT INTO `Trabajadores` VALUES (240002, 36955433, 'Luisa', 'Cascales', '2002-01-23', 'Cartero', 24);
INSERT INTO `Trabajadores` VALUES (250001, 20951972, 'Andrea', 'Rodríguez', '1998-05-08', 'Cartero', 25);
INSERT INTO `Trabajadores` VALUES (250002, 20951222, 'Andrés', 'Rodríguez', '1998-04-08', 'Oficinista', 25);
INSERT INTO `Trabajadores` VALUES (260001, 20921971, 'José', 'Rodríguez', '1992-05-08', 'Cartero', 26);
INSERT INTO `Trabajadores` VALUES (260002, 23921221, 'Manuel', 'Rodríguez', '1992-05-08', 'Oficinista', 26);
INSERT INTO `Trabajadores` VALUES (270001, 20221271, 'José', 'Amato', '1992-03-08', 'Cartero', 27);
INSERT INTO `Trabajadores` VALUES (270002, 23925321, 'Ramón', 'Massa', '1992-11-04', 'Oficinista', 27);
INSERT INTO `Trabajadores` VALUES (280001, 20331274, 'Luis', 'Germain', '1995-07-08', 'Cartero', 28);
INSERT INTO `Trabajadores` VALUES (280002, 23925361, 'Ramón', 'Mesa', '1994-12-04', 'Oficinista', 28);
INSERT INTO `Trabajadores` VALUES (290001, 20344474, 'Luis', 'Pedraza', '1997-07-23', 'Cartero', 29);
INSERT INTO `Trabajadores` VALUES (290002, 23234561, 'Luciana', 'Salazar', '1994-02-23', 'Oficinista', 29);
INSERT INTO `Trabajadores` VALUES (300001, 27331674, 'Luis', 'Hoyos', '1996-07-08', 'Cartero', 30);
INSERT INTO `Trabajadores` VALUES (300002, 23966366, 'Ramón', 'Vie', '1992-12-04', 'Oficinista', 30);
INSERT INTO `Trabajadores` VALUES (310001, 20322234, 'Luis', 'Geri', '1993-07-08', 'Cartero', 31);
INSERT INTO `Trabajadores` VALUES (310002, 23923231, 'Leonardo', 'Messi', '1997-12-04', 'Oficinista', 31);
INSERT INTO `Trabajadores` VALUES (320001, 22224545, 'Luisina', 'Montalvano', '1995-07-18', 'Cartero', 32);
INSERT INTO `Trabajadores` VALUES (320002, 22222333, 'Ramón', 'De la Rosa', '1999-11-03', 'Oficinista', 32);
INSERT INTO `Trabajadores` VALUES (330001, 20333344, 'Leonardo', 'Turtle', '1995-04-08', 'Cartero', 33);
INSERT INTO `Trabajadores` VALUES (330002, 23933364, 'Ramiro', 'Re', '1994-01-04', 'Oficinista', 33);
INSERT INTO `Trabajadores` VALUES (340001, 24333334, 'Luis', 'Gasol', '1995-11-11', 'Cartero', 34);
INSERT INTO `Trabajadores` VALUES (340002, 25928981, 'Ramón', 'Manzana', '1994-11-04', 'Oficinista', 34);
INSERT INTO `Trabajadores` VALUES (350001, 24331274, 'Roberto', 'García', '1995-02-18', 'Cartero', 35);
INSERT INTO `Trabajadores` VALUES (350002, 27925361, 'Nina', 'Williams', '1990-10-22', 'Oficinista', 35);
INSERT INTO `Trabajadores` VALUES (360001, 28331123, 'Anna', 'Curuchet', '1997-02-08', 'Cartero', 36);
INSERT INTO `Trabajadores` VALUES (360002, 21923411, 'Sergio', 'Buljubasich', '1994-02-04', 'Oficinista', 36);
INSERT INTO `Trabajadores` VALUES (370001, 21123474, 'Victor', 'Puentes', '1993-12-08', 'Cartero', 37);
INSERT INTO `Trabajadores` VALUES (370002, 23921322, 'José', 'Hernández', '1994-06-06', 'Oficinista', 37);
INSERT INTO `Trabajadores` VALUES (380001, 20323274, 'Chun', 'Li', '1992-04-06', 'Cartero', 38);
INSERT INTO `Trabajadores` VALUES (380002, 23925333, 'Rafael', 'Ternero', '1994-11-24', 'Oficinista', 38);
INSERT INTO `Trabajadores` VALUES (390001, 20342158, 'Ezequiel', 'Zottola', '1993-12-18', 'Cartero', 39);
INSERT INTO `Trabajadores` VALUES (390002, 22456821, 'Ramón', 'Mesa', '1996-10-14', 'Oficinista', 39);
INSERT INTO `Trabajadores` VALUES (400001, 27774274, 'Michelle', 'Lionheart', '1999-07-08', 'Cartero', 40);
INSERT INTO `Trabajadores` VALUES (400002, 29643361, 'Charlotte', 'La Fleur', '1999-12-04', 'Oficinista', 40);
INSERT INTO `Trabajadores` VALUES (410001, 32332771, 'Saúl', 'Salas', '2012-10-28', 'Oficinista', 41);
INSERT INTO `Trabajadores` VALUES (410002, 31672921, 'Gerardo', 'Aragón', '2011-04-13', 'Cartero', 41);
INSERT INTO `Trabajadores` VALUES (420001, 30511662, 'Mariana', 'Escobar', '2014-01-10', 'Oficinista', 42);
INSERT INTO `Trabajadores` VALUES (420002, 34901901, 'Germán', 'Sanchez', '2013-09-23', 'Cartero', 42);
INSERT INTO `Trabajadores` VALUES (430001, 35004267, 'Edgardo', 'Guerra', '2000-11-12', 'Oficinista', 43);
INSERT INTO `Trabajadores` VALUES (430002, 34089531, 'Agustina', 'Peralta', '2003-04-13', 'Cartero', 43);
INSERT INTO `Trabajadores` VALUES (440001, 34551004, 'Florencia', 'Donke', '2013-04-21', 'Oficinista', 44);
INSERT INTO `Trabajadores` VALUES (440002, 33601844, 'Celina', 'Juarez', '2012-05-30', 'Cartero', 44);
INSERT INTO `Trabajadores` VALUES (450001, 35300719, 'Graciela', 'Funes', '2014-11-22', 'Oficinista', 45);
INSERT INTO `Trabajadores` VALUES (450002, 31544909, 'Andrés', 'Reverso', '2014-09-01', 'Cartero', 45);
INSERT INTO `Trabajadores` VALUES (460001, 31401569, 'Sebastian', 'Avellaneda', '2005-11-09', 'Oficinista', 46);
INSERT INTO `Trabajadores` VALUES (460002, 39672921, 'Noelia', 'Pelikan', '2001-11-09', 'Cartero', 46);
INSERT INTO `Trabajadores` VALUES (470001, 34032791, 'Rubén', 'Saracho', '2013-04-19', 'Oficinista', 47);
INSERT INTO `Trabajadores` VALUES (470002, 31672109, 'Charlie', 'Parra', '2011-04-13', 'Cartero', 47);
INSERT INTO `Trabajadores` VALUES (480001, 30109347, 'Gustavo', 'Córdoba', '2010-10-10', 'Oficinista', 48);
INSERT INTO `Trabajadores` VALUES (480002, 37301911, 'Sandra', 'Aster', '2011-05-10', 'Cartero', 48);
INSERT INTO `Trabajadores` VALUES (490001, 34935100, 'Sabrina', 'Cedrón', '2012-10-28', 'Oficinista', 49);
INSERT INTO `Trabajadores` VALUES (490002, 34601209, 'Nicolas', 'Robles', '2011-04-13', 'Cartero', 49);
INSERT INTO `Trabajadores` VALUES (500001, 30162177, 'Luciana', 'Muñoz', '2003-01-09', 'Oficinista', 50);
INSERT INTO `Trabajadores` VALUES (500002, 32442188, 'Marcelo', 'Espinoza', '2011-04-13', 'Cartero', 50);
INSERT INTO `Trabajadores` VALUES (510001, 34661110, 'Jeremias', 'Lazarte', '2014-01-22', 'Oficinista', 51);
INSERT INTO `Trabajadores` VALUES (510002, 33204859, 'Miguel', 'Santucho', '2011-05-27', 'Cartero', 51);
INSERT INTO `Trabajadores` VALUES (520001, 36884290, 'Clara', 'Sffer', '2013-02-28', 'Oficinista', 52);
INSERT INTO `Trabajadores` VALUES (520002, 33450902, 'Lucia', 'Pondal', '2013-04-13', 'Cartero', 52);
INSERT INTO `Trabajadores` VALUES (530001, 32991402, 'Fernanda', 'Ale', '2014-09-10', 'Oficinista', 53);
INSERT INTO `Trabajadores` VALUES (530002, 34020581, 'Zacarías', 'Zenithar', '2014-11-13', 'Cartero', 53);
INSERT INTO `Trabajadores` VALUES (540001, 34282156, 'Saúl', 'Esperanto', '2012-10-28', 'Oficinista', 54);
INSERT INTO `Trabajadores` VALUES (540002, 34600407, 'Anibal', 'Barca', '2011-04-13', 'Cartero', 54);
INSERT INTO `Trabajadores` VALUES (550001, 30361767, 'Zenón', 'Santillan', '2012-10-28', 'Oficinista', 55);
INSERT INTO `Trabajadores` VALUES (550002, 35120907, 'Estela', 'Di Pinto', '2011-04-13', 'Cartero', 55);
INSERT INTO `Trabajadores` VALUES (560001, 34884193, 'Esteban', 'Ross', '2010-05-13', 'Oficinista', 56);
INSERT INTO `Trabajadores` VALUES (560002, 37733206, 'Manuel', 'Mitre', '2004-09-26', 'Cartero', 56);


INSERT INTO `Pedidos` VALUES ('a10', 5, 20, 320001, 0.00);
INSERT INTO `Pedidos` VALUES ('a11', 7, 10, 500002, 0.00);
INSERT INTO `Pedidos` VALUES ('a12', 12, 19, 350001, 50.99);
INSERT INTO `Pedidos` VALUES ('a13', 4, 23, 70003, 32.50);
INSERT INTO `Pedidos` VALUES ('a14', 10, 15, 430002, 100.50);
INSERT INTO `Pedidos` VALUES ('a15', 3, 7, 430002, 100.50);
INSERT INTO `Pedidos` VALUES ('a16', 20, 25, 280001, 43.70);
INSERT INTO `Pedidos` VALUES ('a2', 12, 2, 390001, 250.00);
INSERT INTO `Pedidos` VALUES ('a3', 21, 22, 480002, 0.00);
INSERT INTO `Pedidos` VALUES ('a4', 30, 29, 120002, 200.70);
INSERT INTO `Pedidos` VALUES ('a5', 5, 7, 430002, 60.39);
INSERT INTO `Pedidos` VALUES ('a6', 25, 22, 480002, 20.25);
INSERT INTO `Pedidos` VALUES ('a7', 12, 15, 430002, 70.50);
INSERT INTO `Pedidos` VALUES ('a8', 9, 15, 430002, 50.99);
INSERT INTO `Pedidos` VALUES ('a9', 9, 16, 430002, 350.00);
INSERT INTO `Pedidos` VALUES ('b1', 5, 7, 430002, 200.89);
INSERT INTO `Pedidos` VALUES ('b10', 12, 17, 430002, 200.50);
INSERT INTO `Pedidos` VALUES ('b11', 25, 27, 340001, 200.50);
INSERT INTO `Pedidos` VALUES ('b12', 16, 6, 430002, 200.50);
INSERT INTO `Pedidos` VALUES ('b13', 9, 1, 350001, 190.35);
INSERT INTO `Pedidos` VALUES ('b14', 8, 18, 350001, 120.50);
INSERT INTO `Pedidos` VALUES ('b15', 12, 13, 500002, 90.75);
INSERT INTO `Pedidos` VALUES ('b2', 5, 13, 500002, 60.00);
INSERT INTO `Pedidos` VALUES ('b3', 5, 21, 260001, 260.00);
INSERT INTO `Pedidos` VALUES ('b4', 6, 7, 430002, 60.00);
INSERT INTO `Pedidos` VALUES ('b5', 26, 27, 320001, 150.75);
INSERT INTO `Pedidos` VALUES ('b6', 17, 2, 390001, 190.35);
INSERT INTO `Pedidos` VALUES ('b7', 15, 17, 390001, 60.00);
INSERT INTO `Pedidos` VALUES ('b8', 9, 7, 430002, 120.00);
INSERT INTO `Pedidos` VALUES ('b9', 21, 4, 560002, 560.00);


INSERT INTO `Correspondencias` VALUES ('a10', 'Simple', 'Negro');
INSERT INTO `Correspondencias` VALUES ('a11', 'Certificada', 'Negro');
INSERT INTO `Correspondencias` VALUES ('a12', 'Express', 'Rojo');
INSERT INTO `Correspondencias` VALUES ('a13', 'Express', 'Rojo');
INSERT INTO `Correspondencias` VALUES ('a16', 'Certificada', 'Rojo');
INSERT INTO `Correspondencias` VALUES ('a3', 'Express', 'Negro');
INSERT INTO `Correspondencias` VALUES ('a6', 'Simple', 'Rojo');
INSERT INTO `Correspondencias` VALUES ('a8', 'Express', 'Rojo');



INSERT INTO `Paquetes` VALUES ('a2', 'La agencia lo prepara');
INSERT INTO `Paquetes` VALUES ('b1', 'El usuario lo prepara');
INSERT INTO `Paquetes` VALUES ('b10', 'El usuario lo prepara');
INSERT INTO `Paquetes` VALUES ('b11', 'La agencia lo prepara');
INSERT INTO `Paquetes` VALUES ('b12', 'El usuario lo prepara');
INSERT INTO `Paquetes` VALUES ('b2', 'El usuario lo prepara');
INSERT INTO `Paquetes` VALUES ('b3', 'La agencia lo prepara');
INSERT INTO `Paquetes` VALUES ('b4', 'El usuario lo prepara');
INSERT INTO `Paquetes` VALUES ('b5', 'El usuario lo prepara');
INSERT INTO `Paquetes` VALUES ('b6', 'La agencia lo prepara');
INSERT INTO `Paquetes` VALUES ('b7', 'El usuario lo prepara');
INSERT INTO `Paquetes` VALUES ('b9', 'La agencia lo prepara');



INSERT INTO `PedidosPorAgencias` VALUES (20, 'a10', '2014-01-23 08:30:00');
INSERT INTO `PedidosPorAgencias` VALUES (32, 'a10', '2014-01-24 20:43:00');
INSERT INTO `PedidosPorAgencias` VALUES (35, 'a10', '2014-01-24 09:01:00');
INSERT INTO `PedidosPorAgencias` VALUES (43, 'a11', '2010-11-22 13:21:00');
INSERT INTO `PedidosPorAgencias` VALUES (50, 'a11', '2010-11-21 09:22:00');
INSERT INTO `PedidosPorAgencias` VALUES (21, 'a12', '1999-09-05 08:02:00');
INSERT INTO `PedidosPorAgencias` VALUES (35, 'a12', '1999-09-06 18:52:00');
INSERT INTO `PedidosPorAgencias` VALUES (41, 'a12', '1999-09-04 13:31:00');
INSERT INTO `PedidosPorAgencias` VALUES (47, 'a12', '1999-09-03 11:59:00');
INSERT INTO `PedidosPorAgencias` VALUES (53, 'a12', '1999-09-02 10:12:00');
INSERT INTO `PedidosPorAgencias` VALUES (55, 'a12', '1999-09-06 09:20:00');
INSERT INTO `PedidosPorAgencias` VALUES (56, 'a12', '1999-09-01 08:27:00');
INSERT INTO `PedidosPorAgencias` VALUES (7, 'a13', '2013-05-07 10:19:00');
INSERT INTO `PedidosPorAgencias` VALUES (21, 'a13', '2013-05-06 18:41:00');
INSERT INTO `PedidosPorAgencias` VALUES (47, 'a13', '2013-05-05 09:53:00');
INSERT INTO `PedidosPorAgencias` VALUES (53, 'a13', '2013-05-04 11:13:00');
INSERT INTO `PedidosPorAgencias` VALUES (56, 'a13', '2013-05-03 08:01:00');
INSERT INTO `PedidosPorAgencias` VALUES (43, 'a14', '2012-06-13 20:07:00');
INSERT INTO `PedidosPorAgencias` VALUES (50, 'a14', '2012-06-13 08:00:00');
INSERT INTO `PedidosPorAgencias` VALUES (50, 'a15', '2014-06-20 08:20:00');
INSERT INTO `PedidosPorAgencias` VALUES (53, 'a15', '2014-06-21 10:28:00');
INSERT INTO `PedidosPorAgencias` VALUES (10, 'a16', '2014-05-22 08:20:00');
INSERT INTO `PedidosPorAgencias` VALUES (28, 'a16', '2014-05-22 08:20:00');
INSERT INTO `PedidosPorAgencias` VALUES (32, 'a16', '2014-05-22 08:20:00');
INSERT INTO `PedidosPorAgencias` VALUES (21, 'a2', '2014-05-26 14:53:00');
INSERT INTO `PedidosPorAgencias` VALUES (39, 'a2', '2014-05-28 18:21:00');
INSERT INTO `PedidosPorAgencias` VALUES (41, 'a2', '2014-05-25 13:20:00');
INSERT INTO `PedidosPorAgencias` VALUES (47, 'a2', '2014-05-24 18:24:00');
INSERT INTO `PedidosPorAgencias` VALUES (53, 'a2', '2014-05-23 11:09:00');
INSERT INTO `PedidosPorAgencias` VALUES (55, 'a2', '2014-05-27 08:17:00');
INSERT INTO `PedidosPorAgencias` VALUES (56, 'a2', '2014-05-22 09:11:00');
INSERT INTO `PedidosPorAgencias` VALUES (26, 'a3', '2014-01-11 08:20:00');
INSERT INTO `PedidosPorAgencias` VALUES (32, 'a3', '2014-01-12 10:12:00');
INSERT INTO `PedidosPorAgencias` VALUES (42, 'a3', '2014-01-13 13:54:00');
INSERT INTO `PedidosPorAgencias` VALUES (44, 'a3', '2014-01-14 08:31:00');
INSERT INTO `PedidosPorAgencias` VALUES (48, 'a3', '2014-01-14 20:22:00');
INSERT INTO `PedidosPorAgencias` VALUES (12, 'a4', '2010-11-13 08:20:00');
INSERT INTO `PedidosPorAgencias` VALUES (43, 'a5', '1992-10-15 13:49:00');
INSERT INTO `PedidosPorAgencias` VALUES (47, 'a5', '1992-10-13 08:20:00');
INSERT INTO `PedidosPorAgencias` VALUES (50, 'a5', '1992-10-14 09:20:00');
INSERT INTO `PedidosPorAgencias` VALUES (28, 'a6', '2001-01-01 08:01:00');
INSERT INTO `PedidosPorAgencias` VALUES (32, 'a6', '2001-01-01 18:24:00');
INSERT INTO `PedidosPorAgencias` VALUES (42, 'a6', '2001-01-02 10:11:00');
INSERT INTO `PedidosPorAgencias` VALUES (44, 'a6', '2001-01-03 09:33:00');
INSERT INTO `PedidosPorAgencias` VALUES (48, 'a6', '2001-01-04 11:41:00');
INSERT INTO `PedidosPorAgencias` VALUES (43, 'a7', '2001-01-02 18:53:00');
INSERT INTO `PedidosPorAgencias` VALUES (50, 'a7', '2001-01-03 09:22:00');
INSERT INTO `PedidosPorAgencias` VALUES (53, 'a7', '2001-01-02 10:01:00');
INSERT INTO `PedidosPorAgencias` VALUES (56, 'a7', '2001-01-01 13:12:00');
INSERT INTO `PedidosPorAgencias` VALUES (43, 'a8', '1991-11-22 09:17:00');
INSERT INTO `PedidosPorAgencias` VALUES (50, 'a8', '1991-11-22 20:05:00');
INSERT INTO `PedidosPorAgencias` VALUES (53, 'a8', '1991-11-21 18:10:00');
INSERT INTO `PedidosPorAgencias` VALUES (56, 'a8', '1991-11-21 08:30:00');
INSERT INTO `PedidosPorAgencias` VALUES (43, 'a9', '2011-09-14 17:33:00');
INSERT INTO `PedidosPorAgencias` VALUES (50, 'a9', '2011-09-15 10:07:00');
INSERT INTO `PedidosPorAgencias` VALUES (53, 'a9', '2011-09-14 09:02:00');
INSERT INTO `PedidosPorAgencias` VALUES (56, 'a9', '2011-09-13 08:34:00');
INSERT INTO `PedidosPorAgencias` VALUES (43, 'b1', '2014-08-09 13:10:00');
INSERT INTO `PedidosPorAgencias` VALUES (47, 'b1', '2014-08-07 08:58:00');
INSERT INTO `PedidosPorAgencias` VALUES (50, 'b1', '2014-08-08 20:01:00');
INSERT INTO `PedidosPorAgencias` VALUES (43, 'b10', '2014-09-04 20:27:00');
INSERT INTO `PedidosPorAgencias` VALUES (53, 'b10', '2014-09-04 10:49:00');
INSERT INTO `PedidosPorAgencias` VALUES (56, 'b10', '2014-09-03 08:13:00');
INSERT INTO `PedidosPorAgencias` VALUES (7, 'b11', '2008-03-21 10:15:00');
INSERT INTO `PedidosPorAgencias` VALUES (28, 'b11', '2008-03-20 16:40:00');
INSERT INTO `PedidosPorAgencias` VALUES (32, 'b11', '2008-03-22 13:40:00');
INSERT INTO `PedidosPorAgencias` VALUES (43, 'b12', '2011-07-15 09:16:00');
INSERT INTO `PedidosPorAgencias` VALUES (21, 'b13', '2013-05-18 14:36:00');
INSERT INTO `PedidosPorAgencias` VALUES (35, 'b13', '2013-05-20 13:44:00');
INSERT INTO `PedidosPorAgencias` VALUES (41, 'b13', '2013-05-17 10:51:00');
INSERT INTO `PedidosPorAgencias` VALUES (47, 'b13', '2013-05-16 19:01:00');
INSERT INTO `PedidosPorAgencias` VALUES (50, 'b13', '2013-05-15 09:16:00');
INSERT INTO `PedidosPorAgencias` VALUES (55, 'b13', '2013-05-19 09:52:00');
INSERT INTO `PedidosPorAgencias` VALUES (21, 'b14', '2014-03-21 09:18:00');
INSERT INTO `PedidosPorAgencias` VALUES (35, 'b14', '2014-03-23 12:14:00');
INSERT INTO `PedidosPorAgencias` VALUES (41, 'b14', '2014-03-20 20:40:00');
INSERT INTO `PedidosPorAgencias` VALUES (47, 'b14', '2014-03-20 10:10:00');
INSERT INTO `PedidosPorAgencias` VALUES (55, 'b14', '2014-03-22 13:31:00');
INSERT INTO `PedidosPorAgencias` VALUES (14, 'b15', '2014-04-07 13:52:00');
INSERT INTO `PedidosPorAgencias` VALUES (50, 'b15', '2014-04-08 11:37:00');
INSERT INTO `PedidosPorAgencias` VALUES (53, 'b15', '2014-04-06 08:13:00');
INSERT INTO `PedidosPorAgencias` VALUES (56, 'b15', '2014-04-05 09:29:00');
INSERT INTO `PedidosPorAgencias` VALUES (47, 'b2', '2014-05-14 09:29:00');
INSERT INTO `PedidosPorAgencias` VALUES (50, 'b2', '2014-05-14 19:04:00');
INSERT INTO `PedidosPorAgencias` VALUES (20, 'b3', '2010-07-21 15:10:00');
INSERT INTO `PedidosPorAgencias` VALUES (25, 'b3', '2010-07-24 08:00:00');
INSERT INTO `PedidosPorAgencias` VALUES (33, 'b3', '2010-07-23 16:29:00');
INSERT INTO `PedidosPorAgencias` VALUES (47, 'b3', '2010-07-20 09:29:00');
INSERT INTO `PedidosPorAgencias` VALUES (55, 'b3', '2010-07-22 10:12:00');
INSERT INTO `PedidosPorAgencias` VALUES (43, 'b4', '2011-08-11 09:01:00');
INSERT INTO `PedidosPorAgencias` VALUES (34, 'b5', '2013-10-12 14:16:00');
INSERT INTO `PedidosPorAgencias` VALUES (42, 'b5', '2013-10-11 10:21:00');
INSERT INTO `PedidosPorAgencias` VALUES (44, 'b5', '2013-10-10 20:17:00');
INSERT INTO `PedidosPorAgencias` VALUES (48, 'b5', '2013-10-10 08:57:00');
INSERT INTO `PedidosPorAgencias` VALUES (21, 'b6', '1998-11-04 10:11:00');
INSERT INTO `PedidosPorAgencias` VALUES (39, 'b6', '1998-11-06 11:59:00');
INSERT INTO `PedidosPorAgencias` VALUES (43, 'b6', '1998-11-01 08:31:00');
INSERT INTO `PedidosPorAgencias` VALUES (47, 'b6', '1998-11-03 09:43:00');
INSERT INTO `PedidosPorAgencias` VALUES (50, 'b6', '1998-11-02 13:10:00');
INSERT INTO `PedidosPorAgencias` VALUES (55, 'b6', '1998-11-05 16:37:00');
INSERT INTO `PedidosPorAgencias` VALUES (43, 'b7', '2009-02-14 17:05:00');
INSERT INTO `PedidosPorAgencias` VALUES (43, 'b8', '2014-06-17 10:59:00');
INSERT INTO `PedidosPorAgencias` VALUES (50, 'b8', '2014-06-17 08:31:00');
INSERT INTO `PedidosPorAgencias` VALUES (22, 'b9', '2014-09-22 17:23:00');
INSERT INTO `PedidosPorAgencias` VALUES (25, 'b9', '2014-09-18 08:31:00');
INSERT INTO `PedidosPorAgencias` VALUES (32, 'b9', '2014-09-19 13:12:00');
INSERT INTO `PedidosPorAgencias` VALUES (35, 'b9', '2014-09-20 11:47:00');
INSERT INTO `PedidosPorAgencias` VALUES (43, 'b9', '2014-09-25 09:25:00');
INSERT INTO `PedidosPorAgencias` VALUES (47, 'b9', '2014-09-23 10:39:00');
INSERT INTO `PedidosPorAgencias` VALUES (50, 'b9', '2014-09-24 12:12:00');
INSERT INTO `PedidosPorAgencias` VALUES (53, 'b9', '2014-09-26 10:36:00');
INSERT INTO `PedidosPorAgencias` VALUES (55, 'b9', '2014-09-21 08:45:00');
INSERT INTO `PedidosPorAgencias` VALUES (56, 'b9', '2014-09-27 17:03:00');

/* 2) Realizar un procedimiento almacenado, llamado BorrarTrabajador , para borrar un
trabajador. El mismo deberá incluir el control de errores lógicos y mensajes de error
necesarios. Incluir el código con la llamada al procedimiento probando todos los
casos con datos incorrectos y uno con datos correctos.*/

/*******************************************************
 Procedimiento Almacenado para borrar un trabajador 
*******************************************************/
DROP PROCEDURE IF EXISTS BorrarTrabajador;

DELIMITER //

CREATE PROCEDURE BorrarTrabajador(
  IN trabajadorId INT
)
BEGIN
  DECLARE v_trabajadorCount INT;

  -- Verificar si el trabajador existe
  SELECT COUNT(*) INTO v_trabajadorCount FROM Trabajadores WHERE Legajo = trabajadorId;
  
  IF v_trabajadorCount = 0 THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: El trabajador no existe.';
  ELSE
    -- Borrar el trabajador
    DELETE FROM Trabajadores WHERE Legajo = trabajadorId;
    
    SELECT 'Trabajador borrado exitosamente.' AS Message;
  END IF;
END //

DELIMITER ;

SELECT * FROM Trabajadores;

CALL BorrarTrabajador(10001); -- Intentar borrar el trabajador con ID 1 (caso válido)
CALL BorrarTrabajador(10007); -- Intentar borrar el trabajador con ID 1 (caso inválido)

-- Trigger para borrar trabajador 
/*DROP TRIGGER IF EXISTS BorrarTrabajador;

DELIMITER //

CREATE TRIGGER BorrarTrabajador
BEFORE DELETE ON Trabajadores
FOR EACH ROW
BEGIN
  DECLARE v_trabajadorCount INT;

  -- Verificar si el trabajador existe
  SELECT COUNT(*) INTO v_trabajadorCount FROM Trabajadores WHERE Legajo = OLD.Legajo;
  
  IF v_trabajadorCount = 0 THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: El trabajador no existe.';
  ELSE
    -- Borrar el trabajador
    DELETE FROM Trabajadores WHERE Legajo = OLD.Legajo;
  END IF;
END //

DELIMITER ;

SELECT * FROM Trabajadores;
-- Caso válido: Borrar un trabajador existente
DELETE FROM Trabajadores WHERE Legajo = 1001;

-- Casos inválidos: Borrar trabajadores no existentes
DELETE FROM Trabajadores WHERE Legajo = 1006; -- El trabajador con Legajo 100 no existe
DELETE FROM Trabajadores WHERE Legajo = 1006; -- El trabajador con Legajo 200 no existe */

/*****************************************************************************************
3)Realizar un procedimiento almacenado, llamado RankingUsuariosPorPedidos ,
para que muestre un ranking con los usuarios que más pedidos realizan (por costo)
entre un rango de fechas. [15]
*****************************************************************************************/

DROP PROCEDURE IF EXISTS RankingUsuariosPorPedidos;

DELIMITER //

CREATE PROCEDURE RankingUsuariosPorPedidos(
	IN pfechaInicio DATE,
    IN pfechaFin DATE
)
BEGIN
    SELECT
        U.IDUsuario,
        U.Apellidos,
        U.Nombres,
        COUNT(P.IDPedido) AS TotalPedidos,
        SUM(P.Costo) AS Costo
    FROM
        Usuarios U
        JOIN Pedidos P ON U.IDUsuario = P.Remitente
        JOIN PedidosPorAgencias PPA ON P.IDPedido = PPA.IDPedido
    WHERE
        PPA.FechaYHora BETWEEN pfechaInicio AND pfechaFin
    GROUP BY
        U.IDUsuario,
        U.Apellidos,
        U.Nombres
    ORDER BY
        SUM(P.Costo) DESC;
END //

DELIMITER ;

SELECT * FROM PedidosPorAgencias;
CALL RankingUsuariosPorPedidos('1991-01-01', '2014-06-30');


DROP PROCEDURE IF EXISTS RankingUsuariosPorPedidos;

DELIMITER //
CREATE PROCEDURE `RankingUsuariosPorPedidos`(pFechaInicio DATE, pFechaFin DATE, OUT Mensaje VARCHAR(120))
BEGIN

DECLARE pAux date;
	    -- Ordenamos las fechas cruzadas.
    IF pFechaInicio > pFechaFin THEN
		SET pAux = pFechaInicio;
        SET pFechaInicio = pFechaFin;
        SET pFechaFin = pAux;
	END IF;
    
	IF (pFechaInicio IS NULL OR pFechaFin IS NULL)THEN
		SET Mensaje = "Los datos no son validos";
	ELSEIF NOT EXISTS (SELECT * FROM Usuarios) THEN
		SET Mensaje = "No se encuentran Usuarios";

	ELSE
	DROP TEMPORARY TABLE IF EXISTS tmp;
	CREATE TEMPORARY TABLE tmp AS
	(SELECT IDPedido, MIN(FechaYHora) AS `FechaYHora` FROM PedidosPorAgencias GROUP BY IDPedido);
	SELECT concat_ws(' ',Usuarios.Apellidos, Usuarios.Nombres) AS "Usuario", SUM(p.Costo) AS Costo, COUNT(p.IDPedido) AS "Nº de Pedidos" FROM Usuarios 
	INNER JOIN Pedidos p ON Usuarios.IdUsuario = p.Remitente
	INNER JOIN tmp ON p.IDPedido = tmp.IDPedido
	WHERE DATE(tmp.FechaYHora) BETWEEN pFechaInicio AND pFechaFin
	GROUP BY IdUsuario, Apellidos, Nombres
	ORDER BY Costo DESC;
    SET Mensaje = "Busqueda exitosa";
	END IF;
END//
DELIMITER ;

CALL RankingUsuariosPorPedidos("2019-01-01 00:00:00","2021-01-10 00:00:00",@mensaje);
SELECT @mensaje;

CALL RankingUsuariosPorPedidos(NULL,"2014-01-10 00:00:00",@mensaje);
SELECT @mensaje;

CALL RankingUsuariosPorPedidos("2010-01-01 00:00:00",NULL,@mensaje);
SELECT @mensaje;

CALL RankingUsuariosPorPedidos(NULL,NULL,@mensaje);
SELECT @mensaje;

/*********************************************************************************************
4) Crear una vista, llamada RutaPaquete , para que muestre toda la ruta de un paquete
determinado. Se deberá mostrar el número de pedido, dirección y localidad de la
agencia, fecha y hora por la que pasa por la agencia, apellido y nombre del
remitente, apellido y nombre del destinatario. El listado deberá estar ordenado
descendentemente por fecha y hora.
**********************************************************************************************/
DROP VIEW IF EXISTS RutaPaquete;
CREATE VIEW RutaPaquete AS
	SELECT P.IDPedido, A.Direccion, A.Localidad, PPA.FechaYHora, 
		   R.Apellidos AS RemitenteApellido, R.Nombres AS RemitenteNombre, 
		   D.Apellidos AS DestinatarioApellido, D.Nombres AS DestinatarioNombre
	FROM Pedidos P
	JOIN PedidosPorAgencias PPA ON P.IDPedido = PPA.IDPedido
	JOIN Agencias A ON PPA.IDAgencia = A.IDAgencia
	JOIN Usuarios R ON P.Remitente = R.IDUsuario
	JOIN Usuarios D ON P.Destinatario = D.IDUsuario

ORDER BY P.IDPedido,PPA.FechaYHora DESC;

SELECT * FROM RutaPaquete;

SELECT * FROM Pedidos;
SELECT * FROM PedidosPorAgencias;

/***********************************************************************************************
5) Implementar la lógica para llevar una auditoría para la operación del apartado 2. Se
deberá auditar el usuario que la hizo, la fecha y hora de la operación, la máquina
desde donde se la hizo y toda la información necesaria para la auditoría.
*************************************************************************************************/
DROP TABLE IF EXISTS `AuditoriaTrabajadores` ;

CREATE TABLE IF NOT EXISTS `AuditoriaTrabajadores` (
  -- Add up the columns of the table I want to audit
  `ID` INT NOT NULL AUTO_INCREMENT,
  `Legajo` INT NOT NULL,
  `Documento` INT NOT NULL,
  `Nombres` VARCHAR(45) NOT NULL,
  `Apellidos` VARCHAR(45) NOT NULL,
  `Ingreso` DATE NOT NULL,
  `Clase` VARCHAR(14)  NOT NULL CHECK(`Clase` IN ('Oficinista','Cartero')),
  `IDAgencia` INT NOT NULL,
    -- Add up the columns of the table user deleting
  `Tipo` CHAR(2) NOT NULL, -- tipo de operación (I: Inserción, B: Borrado, M: Modificación)
  `Usuario` VARCHAR(45) NOT NULL,  
  `Maquina` VARCHAR(45) NOT NULL,  
  `Fecha` DATETIME NOT NULL,
  PRIMARY KEY (`ID`)
   -- create index of the table i want to audit
    -- remove examples
);

DROP TRIGGER IF EXISTS `Trig_Trabajadores_Borrado` 

DELIMITER //
CREATE TRIGGER `Trig_Trabajadores_Borrado` 
AFTER DELETE ON `Trabajadores` FOR EACH ROW
BEGIN
	INSERT INTO AuditoriaTrabajadores VALUES (
		DEFAULT,
		OLD.Legajo,
		OLD.Documento,
        OLD.Nombres,
        OLD.Apellidos,
        OLD.Ingreso,
        OLD.Clase,
        OLD.IDAgencia,
		'B', 
		SUBSTRING_INDEX(USER(), '@', 1), 
		SUBSTRING_INDEX(USER(), '@', -1), 
		NOW()
	);
END //
DELIMITER ;



SELECT * FROM Trabajadores;
CALL BorrarTrabajador(10002);

SELECT * FROM AuditoriaTrabajadores;

INSERT INTO Trabajos (idTrabajo, titulo, area,duracion, fechaPresentacionn, fechaAprobacion, fechaFinalizacion)
VALUES (10000,'asdsad','Hardware',22,'2020-2-2','2023-2-2',NULL);

INSERT INTO Trabajos (idTrabajo, titulo, area,duracion, fechaPresentacionn, fechaAprobacion, fechaFinalizacion)
VALUES (10002,'asds123123ad','Hardware',22,'2020-2-2','2023-2-2',NULL);

INSERT INTO Trabajos (idTrabajo, titulo, area,duracion, fechaPresentacionn, fechaAprobacion, fechaFinalizacion)
VALUES (10003,'asds1231asd23ad','Hardware',7,'2020-2-2','2023-2-2',NULL);

INSERT INTO Trabajos (idTrabajo, titulo, area,duracion, fechaPresentacionn, fechaAprobacion, fechaFinalizacion)
VALUES (100203,'asds1231asadsd23ad','Hardware',2,'2020-2-2','2023-2-2',NULL);


