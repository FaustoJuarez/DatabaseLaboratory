-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema parcial2022
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `parcial2022` ;

-- -----------------------------------------------------
-- Schema parcial2022
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `parcial2022` DEFAULT CHARACTER SET utf8 ;
USE `parcial2022` ;

/*********************************************************************
Según el modelo lógico de la figura, crear los objetos necesarios. Los nombres de las
editoriales y tiendas deben ser únicos. El teléfono de un autor puede tomar el valor
‘UNKNOWN’ por defecto. El país de una editorial puede tomar el valor ‘USA’ por defecto. El
género y fecha de publicación de un título pueden tomar los valores ‘UNDECIDED’ y fecha
actual por defecto respectivamente. Tanto el precio de venta de un título (si tiene) como la
cantidad que se vende del mismo debe ser un número positivo. Deberá haber índices por
las claves primarias y propagadas. Finalmente, ejecutar el script Datos.sql.
**********************************************************************/
-- -----------------------------------------------------
-- Table `parcial2022`.`Autores`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `parcial2022`.`Autores` ;

CREATE TABLE IF NOT EXISTS `parcial2022`.`Autores` (
  `idAutor` VARCHAR(11) NOT NULL,
  `apellido` VARCHAR(40) NOT NULL,
  `nombre` VARCHAR(20) NOT NULL,
  `telefono` CHAR(12) NOT NULL DEFAULT 'UNKNOWN',
  `domicilio` VARCHAR(40) NULL,
  `ciudad` VARCHAR(20) NULL,
  `estado` CHAR(2) NULL,
  `codigoPostal` CHAR(5) NULL,
  PRIMARY KEY (`idAutor`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `parcial2022`.`Editoriales`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `parcial2022`.`Editoriales` ;

CREATE TABLE IF NOT EXISTS `parcial2022`.`Editoriales` (
  `idEditorial` CHAR(4) NOT NULL,
  `nombre` VARCHAR(40) NOT NULL,
  `ciudad` VARCHAR(20) NULL,
  `estado` CHAR(2) NULL,
  `pais` VARCHAR(30) NOT NULL DEFAULT 'USA',
  PRIMARY KEY (`idEditorial`))
ENGINE = InnoDB;

CREATE UNIQUE INDEX `nombre_UNIQUE` ON `parcial2022`.`Editoriales` (`nombre` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `parcial2022`.`Titulos`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `parcial2022`.`Titulos` ;

CREATE TABLE IF NOT EXISTS `parcial2022`.`Titulos` (
  `idTitulo` VARCHAR(11) NOT NULL,
  `titulo` VARCHAR(80) NOT NULL,
  `genero` CHAR(12) NOT NULL DEFAULT 'UNDECIDED',
  `idEditorial` CHAR(4) NOT NULL,
  `precio` DECIMAL(8,2) NULL,
  `sinopsis` VARCHAR(200) NULL,
  `fechaPublicacion` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idTitulo`),
  CONSTRAINT `fk_Titulos_Editoriales1`
    FOREIGN KEY (`idEditorial`)
    REFERENCES `parcial2022`.`Editoriales` (`idEditorial`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Titulos_Editoriales1_idx` ON `parcial2022`.`Titulos` (`idEditorial` ASC) VISIBLE;

ALTER TABLE `Parcial2022`.`Titulos`
ADD CONSTRAINT `Titulos_chk_1`
CHECK (`precio` > 0);
-- -----------------------------------------------------
-- Table `parcial2022`.`Tiendas`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `parcial2022`.`Tiendas` ;

CREATE TABLE IF NOT EXISTS `parcial2022`.`Tiendas` (
  `idTienda` CHAR(4) NOT NULL,
  `nombre` VARCHAR(40) NOT NULL,
  `domicilio` VARCHAR(40) NULL,
  `ciudad` VARCHAR(20) NULL,
  `estado` CHAR(2) NULL,
  `codigoPostal` CHAR(5) NULL,
  PRIMARY KEY (`idTienda`))
ENGINE = InnoDB;

CREATE UNIQUE INDEX `nombre_UNIQUE` ON `parcial2022`.`Tiendas` (`nombre` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `parcial2022`.`Ventas`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `parcial2022`.`Ventas` ;

CREATE TABLE IF NOT EXISTS `parcial2022`.`Ventas` (
  `codigoVenta` VARCHAR(20) NOT NULL,
  `idTienda` CHAR(4) NOT NULL,
  `fecha` DATETIME NOT NULL,
  `tipo` VARCHAR(12) NOT NULL,
  PRIMARY KEY (`codigoVenta`),
  CONSTRAINT `fk_Ventas_Tiendas1`
    FOREIGN KEY (`idTienda`)
    REFERENCES `parcial2022`.`Tiendas` (`idTienda`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Ventas_Tiendas1_idx` ON `parcial2022`.`Ventas` (`idTienda` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `parcial2022`.`Detalles`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `parcial2022`.`Detalles` ;

CREATE TABLE IF NOT EXISTS `parcial2022`.`Detalles` (
  `idDetalle` INT AUTO_INCREMENT PRIMARY KEY,
  `idTitulo` VARCHAR(11) NOT NULL,
  `codigoVenta` VARCHAR(20) NOT NULL,
  `cantidad` SMALLINT NOT NULL,
  CONSTRAINT `fk_Detalles_Titulos1`
    FOREIGN KEY (`idTitulo`)
    REFERENCES `parcial2022`.`Titulos` (`idTitulo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Detalles_Ventas1`
    FOREIGN KEY (`codigoVenta`)
    REFERENCES `parcial2022`.`Ventas` (`codigoVenta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Detalles_Titulos1_idx` ON `parcial2022`.`Detalles` (`idTitulo` ASC) VISIBLE;

CREATE INDEX `fk_Detalles_Ventas1_idx` ON `parcial2022`.`Detalles` (`codigoVenta` ASC) VISIBLE;

ALTER TABLE `Parcial2022`.`Detalles`
ADD CONSTRAINT `Detalles_chk_1`
CHECK (`cantidad` > 0);
-- -----------------------------------------------------
-- Table `parcial2022`.`TitulosDelAutor`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `parcial2022`.`TitulosDelAutor` ;

CREATE TABLE IF NOT EXISTS `parcial2022`.`TitulosDelAutor` (
  `idAutor` VARCHAR(11) NOT NULL,
  `idTitulo` VARCHAR(11) NOT NULL,
  PRIMARY KEY (`idAutor`, `idTitulo`),
  CONSTRAINT `fk_Autores_has_Titulos_Autores`
    FOREIGN KEY (`idAutor`)
    REFERENCES `parcial2022`.`Autores` (`idAutor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Autores_has_Titulos_Titulos1`
    FOREIGN KEY (`idTitulo`)
    REFERENCES `parcial2022`.`Titulos` (`idTitulo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Autores_has_Titulos_Titulos1_idx` ON `parcial2022`.`TitulosDelAutor` (`idTitulo` ASC) VISIBLE;

CREATE INDEX `fk_Autores_has_Titulos_Autores_idx` ON `parcial2022`.`TitulosDelAutor` (`idAutor` ASC) VISIBLE;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

insert Autores values('409-56-7008', 'Bennet', 'Abraham', '415 658-9932', '6223 Bateman St.', 'Berkeley', 'CA', '94705');
insert Autores values('213-46-8915', 'Green', 'Marjorie', '415 986-7020', '309 63rd St. #411', 'Oakland', 'CA', '94618');
insert Autores values('238-95-7766', 'Carson', 'Cheryl', '415 548-7723', '589 Darwin Ln.', 'Berkeley', 'CA', '94705');
insert Autores values('998-72-3567', 'Ringer', 'Albert', '801 826-0752', '67 Seventh Av.', 'Salt Lake City', 'UT', '84152');
insert Autores values('899-46-2035', 'Ringer', 'Anne', '801 826-0752', '67 Seventh Av.', 'Salt Lake City', 'UT', '84152');
insert Autores values('722-51-5454', 'DeFrance', 'Michel', '219 547-9982', '3 Balding Pl.', 'Gary', 'IN', '46403');
insert Autores values('807-91-6654', 'Panteley', 'Sylvia', '301 946-8853', '1956 Arlington Pl.', 'Rockville', 'MD', '20853');
insert Autores values('893-72-1158', 'McBadden', 'Heather', '707 448-4982', '301 Putnam', 'Vacaville', 'CA', '95688');
insert Autores values('724-08-9931', 'Stringer', 'Dirk', '415 843-2991', '5420 Telegraph Av.', 'Oakland', 'CA', '94609');
insert Autores values('274-80-9391', 'Straight', 'Dean', '415 834-2919', '5420 College Av.', 'Oakland', 'CA', '94609');
insert Autores values('756-30-7391', 'Karsen', 'Livia', '415 534-9219', '5720 McAuley St.', 'Oakland', 'CA', '94609');
insert Autores values('724-80-9391', 'MacFeather', 'Stearns', '415 354-7128', '44 Upland Hts.', 'Oakland', 'CA', '94612');
insert Autores values('427-17-2319', 'Dull', 'Ann', '415 836-7128', '3410 Blonde St.', 'Palo Alto', 'CA', '94301');
insert Autores values('672-71-3249', 'Yokomoto', 'Akiko', '415 935-4228', '3 Silver Ct.', 'Walnut Creek', 'CA', '94595');
insert Autores values('267-41-2394', 'O''Leary', 'Michael', '408 286-2428', '22 Cleveland Av. #14', 'San Jose', 'CA', '95128');
insert Autores values('472-27-2349', 'Gringlesby', 'Burt', '707 938-6445', 'PO Box 792', 'Covelo', 'CA', '95428');
insert Autores values('527-72-3246', 'Greene', 'Morningstar', '615 297-2723', '22 Graybar House Rd.', 'Nashville', 'TN', '37215');
insert Autores values('172-32-1176', 'White', 'Johnson', '408 496-7223', '10932 Bigge Rd.', 'Menlo Park', 'CA', '94025');
insert Autores values('712-45-1867', 'del Castillo', 'Innes', '615 996-8275', '2286 Cram Pl. #86', 'Ann Arbor', 'MI', '48105');
insert Autores values('846-92-7186', 'Hunter', 'Sheryl', '415 836-7128', '3410 Blonde St.', 'Palo Alto', 'CA', '94301');
insert Autores values('486-29-1786', 'Locksley', 'Charlene', '415 585-4620', '18 Broadway Av.', 'San Francisco', 'CA', '94130');
insert Autores values('648-92-1872', 'Blotchet-Halls', 'Reginald', '503 745-6402', '55 Hillsdale Bl.', 'Corvallis', 'OR', '97330');
insert Autores values('341-22-1782', 'Smith', 'Meander', '913 843-0462', '10 Mississippi Dr.', 'Lawrence', 'KS', '66044');

insert Editoriales values('0736', 'New Moon Books', 'Boston', 'MA', 'USA');
insert Editoriales values('0877', 'Binnet & Hardley', 'Washington', 'DC', 'USA');
insert Editoriales values('1389', 'Algodata Infosystems', 'Berkeley', 'CA', 'USA');
insert Editoriales values('9952', 'Scootney Books', 'New York', 'NY', 'USA');
insert Editoriales values('1622', 'Five Lakes Publishing', 'Chicago', 'IL', 'USA');
insert Editoriales values('1756', 'Ramona Editoriales', 'Dallas', 'TX', 'USA');
insert Editoriales values('9901', 'GGG&G', 'Munchen', NULL, 'Germany');
insert Editoriales values('9999', 'Lucerne Publishing', 'Paris', NULL, 'France');

insert Titulos values ('PC8888', 'Secrets of Silicon Valley', 'popular_comp', '1389', 20.00, 'Muckraking reporting on the world''s largest computer hardware and software manufacturers.', '2020-12-06');
insert Titulos values ('BU1032', 'The Busy Executive''s Database Guide', 'business', '1389', 19.99, 'An overview of available database systems with emphasis on common business applications. Illustrated.', '2019-12-06');
insert Titulos values ('PS7777', 'Emotional Security: A New Algorithm', 'psychology', '0736', 7.99, 'Protecting yourself and your loved ones from undue emotional stress in the modern world. Use of computer and nutritional aids emphasized.', '2019-12-06');
insert Titulos values ('PS3333', 'Prolonged Data Deprivation: Four Case Studies', 'psychology', '0736', 19.99, 'What happens when the data runs dry?  Searching evaluations of information-shortage effects.', '2019-12-06');
insert Titulos values ('BU1111', 'Cooking with Computers: Surreptitious Balance Sheets', 'business', '1389', 11.95, 'Helpful hints on how to use your electronic resources to the best advantage.', '2019-12-06');
insert Titulos values ('MC2222', 'Silicon Valley Gastronomic Treats', 'mod_cook', '0877', 19.99, 'Favorite recipes for quick, easy, and elegant meals.', '2019-12-06');
insert Titulos values ('TC7777', 'Sushi, Anyone?', 'trad_cook', '0877', 14.99, 'Detailed instructions on how to make authentic Japanese sushi in your spare time.', '2019-12-06');
insert Titulos values ('TC4203', 'Fifty Years in Buckingham Palace Kitchens', 'trad_cook', '0877', 11.95, 'More anecdotes from the Queen''s favorite cook describing life among English royalty. Recipes, techniques, tender vignettes.', '2019-12-06');
insert Titulos values ('PC1035', 'But Is It User Friendly?', 'popular_comp', '1389', 22.95, 'A survey of software for the naive user, focusing on the ''friendliness'' of each.', '2019-12-06');
insert Titulos values('BU2075', 'You Can Combat Computer Stress!', 'business', '0736', 2.99, 'The latest medical and psychological techniques for living with the electronic office. Easy-to-understand explanations.', '2019-12-06');
insert Titulos values('PS2091', 'Is Anger the Enemy?', 'psychology', '0736', 10.95, 'Carefully researched study of the effects of strong emotions on the body. Metabolic charts included.', '2019-06-15');
insert Titulos values('PS2106', 'Life Without Fear', 'psychology', '0736', 7.00, 'New exercise, meditation, and nutritional techniques that can reduce the shock of daily interactions. Popular audience. Sample menus included, exercise video available separately.', '2019-10-05');
insert Titulos values('MC3021', 'The Gourmet Microwave', 'mod_cook', '0877', 2.99, 'Traditional French gourmet recipes adapted for modern microwave cooking.', '2019-06-18');
insert Titulos values('TC3218', 'Onions, Leeks, and Garlic: Cooking Secrets of the Mediterranean', 'trad_cook', '0877', 20.95, 'Profusely illustrated in color, this makes a wonderful gift book for a cuisine-oriented friend.', '2019-10-21');
insert Titulos (idTitulo, titulo, idEditorial) values('MC3026', 'The Psychology of Computer Cooking', '0877');
insert Titulos values ('BU7832', 'Straight Talk About Computers', 'business', '1389', 19.99, 'Annotated analysis of what computers can do for you: a no-hype guide for the critical user.', '2019-06-22');
insert Titulos values('PS1372', 'Computer Phobic AND Non-Phobic Individuals: Behavior Variations', 'psychology', '0877', 21.59, 'A must for the specialist, this book examines the difference between those who hate and fear computers and those who don''t.', '2019-10-21');
insert Titulos (idTitulo, titulo, genero, idEditorial, sinopsis) values('PC9999', 'Net Etiquette', 'popular_comp', '1389', 'A must-read for computer conferencing.');

insert TitulosDelAutor values('409-56-7008', 'BU1032');
insert TitulosDelAutor values('486-29-1786', 'PS7777');
insert TitulosDelAutor values('486-29-1786', 'PC9999');
insert TitulosDelAutor values('712-45-1867', 'MC2222');
insert TitulosDelAutor values('172-32-1176', 'PS3333');
insert TitulosDelAutor values('213-46-8915', 'BU1032');
insert TitulosDelAutor values('238-95-7766', 'PC1035');
insert TitulosDelAutor values('213-46-8915', 'BU2075');
insert TitulosDelAutor values('998-72-3567', 'PS2091');
insert TitulosDelAutor values('899-46-2035', 'PS2091');
insert TitulosDelAutor values('998-72-3567', 'PS2106');
insert TitulosDelAutor values('722-51-5454', 'MC3021');
insert TitulosDelAutor values('899-46-2035', 'MC3021');
insert TitulosDelAutor values('807-91-6654', 'TC3218');
insert TitulosDelAutor values('274-80-9391', 'BU7832');
insert TitulosDelAutor values('427-17-2319', 'PC8888');
insert TitulosDelAutor values('846-92-7186', 'PC8888');
insert TitulosDelAutor values('756-30-7391', 'PS1372');
insert TitulosDelAutor values('724-80-9391', 'PS1372');
insert TitulosDelAutor values('724-80-9391', 'BU1111');
insert TitulosDelAutor values('267-41-2394', 'BU1111');
insert TitulosDelAutor values('672-71-3249', 'TC7777');
insert TitulosDelAutor values('267-41-2394', 'TC7777');
insert TitulosDelAutor values('472-27-2349', 'TC7777');
insert TitulosDelAutor values('648-92-1872', 'TC4203');

insert Tiendas values('7066','Barnum''s','567 Pasadena Ave.','Tustin','CA','92789');
insert Tiendas values('7067','News & Brews','577 First St.','Los Gatos','CA','96745');
insert Tiendas values('7131','Doc-U-Mat: Quality Laundry and Books', '24-A Avogadro Way','Remulade','WA','98014');
insert Tiendas values('8042','Bookbeat','679 Carson St.','Portland','OR','89076');
insert Tiendas values('6380','Eric the Read Books','788 Catamaugus Ave.', 'Seattle','WA','98056');
insert Tiendas values('7896','Fricative Bookshop','89 Madison St.','Fremont','CA','90019');

insert Ventas values('QA7442.3', '7066', '2022-09-13', 'ON invoice');
insert Ventas values('D4482', '7067', '2022-09-14', 'Net 60');
insert Ventas values('N914008', '7131', '2022-09-14', 'Net 30');
insert Ventas values('N914014', '7131', '2022-09-14', 'Net 30');
insert Ventas values('423LL922', '8042', '2022-09-14', 'ON invoice');
insert Ventas values('423LL930', '8042', '2022-09-14', 'ON invoice');
insert Ventas values('722a', '6380', '2022-09-13', 'Net 60');
insert Ventas values('6871', '6380', '2022-09-14', 'Net 60');
insert Ventas values('P723', '8042', '2021-03-11', 'Net 30');
insert Ventas values('X999', '7896', '2021-02-21', 'ON invoice');
insert Ventas values('QQ2299', '7896', '2021-10-28', 'Net 60');
insert Ventas values('TQ456',  '7896', '2021-12-12', 'Net 60');
insert Ventas values('QA879.1', '8042', '2021-5-22', 'Net 30');
insert Ventas values('A2976', '7066', '2021-5-24', 'Net 30');
insert Ventas values('P3087a', '7131', '2021-5-29', 'Net 60');
insert Ventas values('P2121', '7067', '2020-6-15', 'Net 30');

insert Detalles (codigoVenta, idTitulo, cantidad) values('QA7442.3', 'PS2091', 75);
insert Detalles (codigoVenta, idTitulo, cantidad) values('D4482', 'PS2091', 10);
insert Detalles (codigoVenta, idTitulo, cantidad) values('N914008', 'PS2091', 20);
insert Detalles (codigoVenta, idTitulo, cantidad) values('N914014', 'MC3021', 25);
insert Detalles (codigoVenta, idTitulo, cantidad) values('423LL922', 'MC3021', 15);
insert Detalles (codigoVenta, idTitulo, cantidad) values('423LL930', 'BU1032', 10);
insert Detalles (codigoVenta, idTitulo, cantidad) values('722a', 'PS2091', 3);
insert Detalles (codigoVenta, idTitulo, cantidad) values('6871', 'BU1032', 5);
insert Detalles (codigoVenta, idTitulo, cantidad) values('P723', 'BU1111', 25);
insert Detalles (codigoVenta, idTitulo, cantidad) values('X999', 'BU2075', 35);
insert Detalles (codigoVenta, idTitulo, cantidad) values('QQ2299', 'BU7832', 15);
insert Detalles (codigoVenta, idTitulo, cantidad) values('TQ456',  'MC2222', 10);
insert Detalles (codigoVenta, idTitulo, cantidad) values('QA879.1', 'PC1035', 30);
insert Detalles (codigoVenta, idTitulo, cantidad) values('A2976', 'PC8888', 50);
insert Detalles (codigoVenta, idTitulo, cantidad) values('P3087a', 'PS1372', 20);
insert Detalles (codigoVenta, idTitulo, cantidad) values('P3087a', 'PS2106', 25);
insert Detalles (codigoVenta, idTitulo, cantidad) values('P3087a', 'PS3333', 15);
insert Detalles (codigoVenta, idTitulo, cantidad) values('P3087a', 'PS7777', 25);
insert Detalles (codigoVenta, idTitulo, cantidad) values('P2121', 'TC3218', 40);
insert Detalles (codigoVenta, idTitulo, cantidad) values('P2121', 'TC4203', 20);
insert Detalles (codigoVenta, idTitulo, cantidad) values('P2121', 'TC7777', 20);

-- insert Descuentos (tipo, idTienda, cantidadMinima, descuento) values('Initial Customer', NULL, NULL, 10.5);
-- insert Descuentos (tipo, idTienda, cantidadMinima, descuento) values('Volume Discount', NULL, 100, 6.7);
-- insert Descuentos (tipo, idTienda, cantidadMinima, descuento) values('Customer Discount', '8042', NULL, 5.0);

-- insert Trabajos (descripcion)  values ('New Hire - Job not specified');
-- insert Trabajos (descripcion)  values ('Chief Executive Officer');
-- insert Trabajos (descripcion)  values ('Business Operations Manager');
-- insert Trabajos (descripcion)  values ('Chief Financial Officier');
-- insert Trabajos (descripcion)  values ('Publisher');
-- insert Trabajos (descripcion)  values ('Managing Editor');
-- insert Trabajos (descripcion)  values ('Marketing Manager');
-- insert Trabajos (descripcion)  values ('Public Relations Manager');
-- insert Trabajos (descripcion)  values ('Acquisitions Manager');
-- insert Trabajos (descripcion)  values ('Productions Manager');
-- insert Trabajos (descripcion)  values ('Operations Manager');
-- insert Trabajos (descripcion)  values ('Editor');
-- insert Trabajos (descripcion)  values ('Sales Representative');
-- insert Trabajos (descripcion)  values ('Designer');

-- insert Empleados values ('PTC11962M', 'Philip', 'Cramer', 2, '9952', '1989-11-11');
-- insert Empleados values ('AMD15433F', 'Ann', 'Devon', 3, '9952', '1991-07-16');
-- insert Empleados values ('F-C16315M', 'Francisco', 'Chang', 4, '9952', '1990-11-03');
-- insert Empleados values ('LAL21447M', 'Laurence', 'Lebihan', 5, '0736', '1990-06-03');
-- insert Empleados values ('PXH22250M', 'Paul', 'Henriot', 5, '0877', '1993-08-19');
-- insert Empleados values ('SKO22412M', 'Sven', 'Ottlieb', 5, '1389', '1991-04-05');
-- insert Empleados values ('RBM23061F', 'Rita', 'Muller', 5, '1622', '1993-10-09');
-- insert Empleados values ('MJP25939M', 'Maria', 'Pontes', 5, '1756', '1989-03-01');
-- insert Empleados values ('JYL26161F', 'Janine', 'Labrune', 5, '9901', '1991-05-26');
-- insert Empleados values ('CFH28514M', 'Carlos', 'Hernadez', 5, '9999', '1989-04-21');
-- insert Empleados values ('VPA30890F', 'Victoria', 'Ashworth', 6, '0877', '1990-09-13');
-- insert Empleados values ('L-B31947F', 'Lesley', 'Brown', 7, '0877', '1991-02-13');
-- insert Empleados values ('ARD36773F', 'Anabela', 'Domingues', 8, '0877', '1993-01-27');
-- insert Empleados values ('M-R38834F', 'Martine', 'Rance', 9, '0877', '1992-02-05');
-- insert Empleados values ('PHF38899M', 'Peter', 'Franken', 10, '0877', '1992-05-17');
-- insert Empleados values ('DBT39435M', 'Daniel', 'Tonini', 11, '0877', '1990-01-01');
-- insert Empleados values ('H-B39728F', 'Helen', 'Bennett', 12, '0877', '1989-09-21');
-- insert Empleados values ('PMA42628M', 'Paolo', 'Accorti', 13, '0877', '1992-08-27');
-- insert Empleados values ('ENL44273F', 'Elizabeth', 'Lincoln', 14, '0877', '1990-07-24');
-- insert Empleados values ('MGK44605M', 'Matti', 'Karttunen', 6, '0736', '1994-05-01');
-- insert Empleados values ('PDI47470M', 'Palle', 'Ibsen', 7, '0736', '1993-05-09');
-- insert Empleados values ('MMS49649F', 'Mary', 'Saveley', 8, '0736', '1993-06-29');
-- insert Empleados values ('GHT50241M', 'Gary', 'Thomas', 9, '0736', '1988-08-09');
-- insert Empleados values ('MFS52347M', 'Martin', 'Sommer', 10, '0736', '1990-04-13');
-- insert Empleados values ('R-M53550M', 'Roland', 'Mendel', 11, '0736', '1991-09-05');
-- insert Empleados values ('HAS54740M', 'Howard', 'Snyder', 12, '0736', '1988-11-19');
-- insert Empleados values ('TPO55093M', 'Timothy', 'O''Rourke', 13, '0736', '1988-06-19');
-- insert Empleados values ('KFJ64308F', 'Karin', 'Josephs', 14, '0736', '1992-10-17');
-- insert Empleados values ('DWR65030M', 'Diego', 'Roel', 6, '1389', '1991-12-16');
-- insert Empleados values ('M-L67958F', 'Maria', 'Larsson', 7, '1389', '1992-03-27');
-- insert Empleados values ('PSP68661F', 'Paula', 'Parente', 8, '1389', '1994-01-19');
-- insert Empleados values ('MAS70474F', 'Margaret', 'Smith', 9, '1389', '1988-09-29');
-- insert Empleados values ('A-C71970F', 'Aria', 'Cruz', 10, '1389', '1991-10-26');
-- insert Empleados values ('MAP77183M', 'Miguel', 'Paolino', 11, '1389', '1992-12-07');
-- insert Empleados values ('Y-L77953M', 'Yoshi', 'Latimer', 12, '1389', '1989-06-11');
-- insert Empleados values ('CGS88322F', 'Carine', 'Schmitt', 13, '1389', '1992-07-07');
-- insert Empleados values ('PSA89086M', 'Pedro', 'Afonso', 14, '1389', '1990-12-24');
-- insert Empleados values ('A-R89858F', 'Annette', 'Roulet', 6, '9999', '1990-02-21');
-- insert Empleados values ('HAN90777M', 'Helvetius', 'Nagy', 7, '9999', '1993-03-19');
-- insert Empleados values ('M-P91209M', 'Manuel', 'Pereira', 8, '9999', '1989-01-09');
-- insert Empleados values ('KJJ92907F', 'Karla', 'Jablonski', 9, '9999', '1994-03-11');
-- insert Empleados values ('POK93028M', 'Pirkko', 'Koskitalo', 10, '9999', '1993-11-29');
-- insert Empleados values ('PCM98509F', 'Patricia', 'McKenna', 11, '9999', '1989-08-01');

/************************************************************************************************
2) Crear una vista llamada VCantidadVentas que muestre por cada tienda su código,
cantidad total de ventas y el importe total de todas esas ventas. La salida, mostrada en la
siguiente tabla, deberá estar ordenada descendentemente según la cantidad total de ventas
y el importe de las mismas. Incluir el código con la consulta a la vista.
*************************************************************************************************/
DROP VIEW IF EXISTS VCantidadVentas;

CREATE VIEW VCantidadVentas AS 
SELECT Ventas.idTienda, COUNT(Ventas.idTienda) AS 'Cantidad de Ventas', SUM(Detalles.cantidad * Titulos.Precio) AS 'Importe total de ventas'
FROM Detalles 
	JOIN Titulos ON Titulos.idTitulo = Detalles.idTitulo
	JOIN Ventas ON Ventas.codigoVenta = Detalles.codigoVenta
GROUP BY Ventas.idTienda
ORDER BY `Cantidad de Ventas` DESC;
    
SELECT * FROM VCantidadVentas;

/*****************************************************************************************
3) Realizar un procedimiento almacenado llamado NuevaEditorial para dar de alta una
editorial, incluyendo el control de errores lógicos y mensajes de error necesarios
(implementar la lógica del manejo de errores empleando parámetros de salida). Incluir el
código con la llamada al procedimiento probando todos los casos con datos incorrectos y
uno con datos correctos.
*******************************************************************************************/

DROP PROCEDURE IF EXISTS NuevaEditorial;

DELIMITER //

CREATE PROCEDURE NuevaEditorial(
	IN pidEditorial CHAR(4), 
    IN pnombre VARCHAR(40),
    IN pciudad VARCHAR(20), 
    IN pestado CHAR(2), 
    IN ppais VARCHAR(30), 
    OUT pMensaje VARCHAR(256))
FINAL:
BEGIN

	/*`idEditorial` CHAR(4) NOT NULL,
  `nombre` VARCHAR(40) NOT NULL,
  `ciudad` VARCHAR(20) NULL,
  `estado` CHAR(2) NULL,
  `pais` VARCHAR(30) NOT NULL DEFAULT 'USA',*/
   -- Exception handler
    DECLARE EXIT HANDLER FOR SQLEXCEPTION -- lo puedo cambiar por el numero de la exception
        BEGIN
            SHOW ERRORS;
            SET pMensaje = 'Error en la transacción. Contáctese con el administrador.';
            ROLLBACK;
        END;

    IF pidEditorial IS NULL OR pnombre IS NULL OR trim(pnombre) = '' OR ppais IS NULL THEN
        SET pMensaje = 'Error idEditorial, ni Nombre, ni pais pueden ser nulos';
        LEAVE FINAL;
    END IF;
    
    
    IF EXISTS(SELECT nombre FROM Editoriales WHERE nombre = pnombre) THEN
        SET pMensaje = 'No puede haber nombres de editoriales repetidas';
        LEAVE FINAL;
    END IF;
    
    -- SET vUltimoID = (SELECT COALESCE(MAX(IdEditorial), 1) FROM Productos);

    INSERT INTO Editoriales (idEditorial, nombre, ciudad, estado, pais)
    VALUES (pidEditorial, pnombre, pciudad, pestado, ppais);
    SET pMensaje = 'Insercion exitosa';

END //

DELIMITER ;

-- insert Editoriales values('0736', 'New Moon Books', 'Boston', 'MA', 'USA');
SELECT * FROM Editoriales;

CALL NuevaEditorial('1390', 'New Harry Potter', 'Los Angeles','CA', 'USA',@pMensaje); -- Funciona
CALL NuevaEditorial('1390', 'New Book', 'Los Angeles','CA', 'USA',@pMensaje); -- idEditorial Repetido
CALL NuevaEditorial('1391', 'Binnet & Hardley', 'Los Angeles','CA', 'USA',@pMensaje); -- nombre editorial Repetido
SELECT @pMensaje;
CALL NuevaEditorial(NULL, 'Harry Potter', 'Los Angeles','CA', 'USA',@pMensaje); -- nombre editorial Repetido
SELECT @pMensaje;
CALL NuevaEditorial('1392', NULL, 'Los Angeles','CA', 'USA',@pMensaje); -- nombre editorial Repetido
SELECT @pMensaje;
CALL NuevaEditorial('1392', 'Harry Potter', 'Los Angeles','CA', NULL,@pMensaje); -- nombre editorial Repetido
SELECT @pMensaje;

/*********************************************************************************************
4) Realizar un procedimiento almacenado llamado BuscarTitulosPorAutor que reciba el
código de un autor y muestre los títulos del mismo. Por cada título del autor especificado se
deberá mostrar su código y título, género, nombre de la editorial, precio, sinopsis y fecha de
publicación. La salida, mostrada en la siguiente tabla, deberá estar ordenada
alfabéticamente según el título. Incluir en el código la llamada al procedimiento.
**********************************************************************************************/
DROP PROCEDURE IF EXISTS `BuscarTitulosPorAutor`;
DELIMITER //

CREATE PROCEDURE `BuscarTitulosPorAutor`(pidAutor VARCHAR(11))
FINAL:
BEGIN
    -- Por cada título del autor especificado se deberá mostrar su código y título, género, nombre de la editorial, precio, sinopsis y fecha de publicación
    SELECT T.idTitulo AS 'Codigo', T.titulo AS 'Titulo', T.genero AS 'Genero', E.nombre AS 'Editorial', T.precio AS 'Precio', 
		   T.sinopsis AS 'Sinopsis', DATE(T.fechaPublicacion)
    FROM TitulosDelAutor
             JOIN Titulos T on T.idTitulo = TitulosDelAutor.idTitulo 
             JOIN Editoriales E on  E.idEditorial = T.idEditorial 
    WHERE TitulosDelAutor.idAutor = pidAutor;
END //

DELIMITER ;

SELECT * FROM Autores;
SELECT * FROM Titulos;
CALL BuscarTitulosPorAutor('213-46-8915'); -- Poner comillas respetar atributo del valor que es 
CALL BuscarTitulosPorAutor('409-56-7008');

/************************************************************************************************
5) Utilizando triggers, implementar la lógica para que en caso que se quiera borrar una
editorial referenciada por un título se informe mediante un mensaje de error que no se
puede. Incluir el código con los borrados de una editorial que no tiene títulos, y otro de una
que sí.
************************************************************************************************/
DROP TRIGGER IF EXISTS Editoriales_before_delete;
DELIMITER //
CREATE TRIGGER Editoriales_before_delete
    BEFORE DELETE
    ON Editoriales
    FOR EACH ROW
BEGIN
    IF EXISTS(SELECT Titulos.idEditorial FROM Titulos WHERE Titulos.idEditorial = OLD.idEditorial) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error Editorial o Titulos tiene como referencia la editorial que se desea eliminar';
    END IF;

END //
DELIMITER ;

SELECT * FROM Editoriales;
SELECT * FROM Titulos;
DELETE FROM Editoriales WHERE idEditorial='0736';
DELETE FROM Editoriales WHERE idEditorial='9952';
