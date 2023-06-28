-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Parcial_2021_2
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `Parcial_2021_2` ;

-- -----------------------------------------------------
-- Schema Parcial_2021_2
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Parcial_2021_2` DEFAULT CHARACTER SET utf8 ;
USE `Parcial_2021_2` ;

-- -----------------------------------------------------
-- Table `Parcial_2021_2`.`Direcciones`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Parcial_2021_2`.`Direcciones` ;

CREATE TABLE IF NOT EXISTS `Parcial_2021_2`.`Direcciones` (
  `idDireccion` INT NOT NULL,
  `calleYNumero` VARCHAR(50) NOT NULL,
  `codigoPostal` VARCHAR(10) NULL,
  `telefono` VARCHAR(25) NOT NULL,
  `municipiop` VARCHAR(25) NULL,
  PRIMARY KEY (`idDireccion`))
ENGINE = InnoDB;

CREATE UNIQUE INDEX `calleYNumero_UNIQUE` ON `Parcial_2021_2`.`Direcciones` (`calleYNumero` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `Parcial_2021_2`.`Empleados`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Parcial_2021_2`.`Empleados` ;

CREATE TABLE IF NOT EXISTS `Parcial_2021_2`.`Empleados` (
  `idEmpleado` INT NOT NULL,
  `apellidos` VARCHAR(50) NOT NULL,
  `nombres` VARCHAR(50) NOT NULL,
  `correo` VARCHAR(50) NULL,
  `estado` CHAR(1) NOT NULL DEFAULT 'E' CHECK (`estado` IN ('D','E')),
  `idDireccion` INT NOT NULL,
  PRIMARY KEY (`idEmpleado`),
  CONSTRAINT `fk_Empleados_Direcciones1`
    FOREIGN KEY (`idDireccion`)
    REFERENCES `Parcial_2021_2`.`Direcciones` (`idDireccion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Empleados_Direcciones1_idx` ON `Parcial_2021_2`.`Empleados` (`idDireccion` ASC) VISIBLE;

CREATE UNIQUE INDEX `correo_UNIQUE` ON `Parcial_2021_2`.`Empleados` (`correo` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `Parcial_2021_2`.`Actores`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Parcial_2021_2`.`Actores` ;

CREATE TABLE IF NOT EXISTS `Parcial_2021_2`.`Actores` (
  `idActor` CHAR(10) NOT NULL,
  `apellidos` VARCHAR(50) NULL,
  `nombres` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`idActor`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Parcial_2021_2`.`Peliculas`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Parcial_2021_2`.`Peliculas` ;

CREATE TABLE IF NOT EXISTS `Parcial_2021_2`.`Peliculas` (
  `idPelicula` INT NOT NULL,
  `titulo` VARCHAR(128) NOT NULL,
  `clasificacion` VARCHAR(5) NOT NULL DEFAULT 'G' CHECK (`clasificacion` IN ('G','PG','PG-13','R','NC-17')),
  `estreno` INT NULL,
  `duracion` INT NULL,
  PRIMARY KEY (`idPelicula`))
ENGINE = InnoDB;

CREATE UNIQUE INDEX `titulo_UNIQUE` ON `Parcial_2021_2`.`Peliculas` (`titulo` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `Parcial_2021_2`.`Sucursales`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Parcial_2021_2`.`Sucursales` ;

CREATE TABLE IF NOT EXISTS `Parcial_2021_2`.`Sucursales` (
  `idSucursal` CHAR(10) NOT NULL,
  `idDireccion` INT NOT NULL,
  `idGerente` INT NOT NULL,
  PRIMARY KEY (`idSucursal`),
  CONSTRAINT `fk_Sucursales_Direcciones`
    FOREIGN KEY (`idDireccion`)
    REFERENCES `Parcial_2021_2`.`Direcciones` (`idDireccion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Sucursales_Empleados1`
    FOREIGN KEY (`idGerente`)
    REFERENCES `Parcial_2021_2`.`Empleados` (`idEmpleado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Sucursales_Direcciones_idx` ON `Parcial_2021_2`.`Sucursales` (`idDireccion` ASC) VISIBLE;

CREATE INDEX `fk_Sucursales_Empleados1_idx` ON `Parcial_2021_2`.`Sucursales` (`idGerente` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `Parcial_2021_2`.`Inventario`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Parcial_2021_2`.`Inventario` ;

CREATE TABLE IF NOT EXISTS `Parcial_2021_2`.`Inventario` (
  `idInventario` INT NOT NULL,
  `idSucursal` CHAR(10) NOT NULL,
  `idPelicula` INT NOT NULL,
  PRIMARY KEY (`idInventario`),
  CONSTRAINT `fk_Inventario_Sucursales1`
    FOREIGN KEY (`idSucursal`)
    REFERENCES `Parcial_2021_2`.`Sucursales` (`idSucursal`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Inventario_Peliculas1`
    FOREIGN KEY (`idPelicula`)
    REFERENCES `Parcial_2021_2`.`Peliculas` (`idPelicula`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Inventario_Sucursales1_idx` ON `Parcial_2021_2`.`Inventario` (`idSucursal` ASC) VISIBLE;

CREATE INDEX `fk_Inventario_Peliculas1_idx` ON `Parcial_2021_2`.`Inventario` (`idPelicula` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `Parcial_2021_2`.`ActoresDePeliculas`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Parcial_2021_2`.`ActoresDePeliculas` ;

CREATE TABLE IF NOT EXISTS `Parcial_2021_2`.`ActoresDePeliculas` (
  `idActor` CHAR(10) NOT NULL,
  `idPelicula` INT NOT NULL,
  PRIMARY KEY (`idActor`, `idPelicula`),
  CONSTRAINT `fk_Actores_has_Peliculas_Actores1`
    FOREIGN KEY (`idActor`)
    REFERENCES `Parcial_2021_2`.`Actores` (`idActor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Actores_has_Peliculas_Peliculas1`
    FOREIGN KEY (`idPelicula`)
    REFERENCES `Parcial_2021_2`.`Peliculas` (`idPelicula`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Actores_has_Peliculas_Peliculas1_idx` ON `Parcial_2021_2`.`ActoresDePeliculas` (`idPelicula` ASC) VISIBLE;

CREATE INDEX `fk_Actores_has_Peliculas_Actores1_idx` ON `Parcial_2021_2`.`ActoresDePeliculas` (`idActor` ASC) VISIBLE;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;


/*Crear una vista llamada VCantidadPeliculasEnSucursales que muestre el título de las
películas, el código de la sucursal donde se encuentra, la calle y número de la sucursal, la
cantidad de películas (por película) y los datos del gerente de la sucursal (formato: “apellido,
nombre”). La salida deberá estar ordenada alfabéticamente según el título de las películas.
Incluir el código con la llamada a la vista

REVISAR*/

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

/*Realizar un procedimiento almacenado llamado ModificarDireccion para modificar una
dirección, incluyendo el control de errores lógicos y mensajes de error necesarios
(implementar la lógica del manejo de errores empleando parámetros de salida). Incluir el
código con la llamada al procedimiento probando todos los casos con datos incorrectos y
uno con datos correctos.*/

DROP PROCEDURE IF EXISTS ModificarDireccion;

DELIMITER //

CREATE PROCEDURE ModificarDireccion(
    pidDireccion INT,
    pcalleYNumero VARCHAR(50), 
    pcodigoPostal VARCHAR(10),
    ptelefono VARCHAR(25),
    pmunicipiop VARCHAR(25),
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

    -- Verificar existencia del código de rastreo en la tabla Envios
    SELECT COUNT(*) INTO vCount FROM Sucursales WHERE idDireccion = pidDireccion;

    IF vCount = 0 THEN
        SET pMensaje = 'Error: La direccion no existe en la tabla Sucursales';
        LEAVE FINAL;
    END IF;

    IF pcalleYNumero IS NULL OR ptelefono IS NULL THEN
        SET pMensaje = 'Error: calleYNumero, telefono no pueden ser nulos';
        LEAVE FINAL;
    END IF;

    START TRANSACTION;

    UPDATE Direcciones 
    SET calleYNumero = pcalleYNumero, codigoPostal = pcodigoPostal, telefono = ptelefono, municipiop = pmunicipiop
    WHERE idDireccion = pidDireccion;

    SET pMensaje = 'Inserción exitosa';
    COMMIT;

END //

DELIMITER ;


SELECT * FROM Direcciones ;
-- INSERT INTO `Direcciones` VALUES (1,'47 MySakila Drive','-','-','Alberta'),(2,'28 MySQL Boulevard','-','-','QLD'),(3,'23 Workhaven Lane','-','14033335568','Alberta'),(4,'1411 Lillydale Drive','-','6172235589','QLD'),(5,'1913 Hanoi Way','35200','28303384290','Nagasaki'),(6,'1121 Loja Avenue','17886','838635286649','California'),(7,'692 Joliet Street','83579','448477190408','Attika'),(8,'1566 Inegl Manor','53561','705814003527','Mandalay'),(9,'53 Idfu Parkway','42399','10655648674','Nantou'),(10,'1795 Santiago de Compostela Way','18743','860452626434','Texas'),(11,'900 Santiago de Compostela Parkway','93896','716571220373','Central Serbia'),(12,'478 Joliet Way','77948','657282285970','Hamilton'),(13,'613 Korolev Drive','45844','380657522649','Masqat'),(14,'1531 Sal Drive','53628','648856936185','Esfahan'),(15,'1542 Tarlac Parkway','1027','635297277345','Kanagawa'),(16,'808 Bhopal Manor','10672','465887807014','Haryana'),(17,'270 Amroha Parkway','29610','695479687538','Osmaniye'),(18,'770 Bydgoszcz Avenue','16266','517338314235','California'),(19,'419 Iligan Lane','72878','990911107354','Madhya Pradesh'),(20,'360 Toulouse Parkway','54308','949312333307','England'),(21,'270 Toulon Boulevard','81766','407752414682','Kalmykia'),(22,'320 Brest Avenue','43331','747791594069','Kaduna'),(23,'1417 Lancaster Avenue','72192','272572357893','Northern Cape'),(24,'1688 Okara Way','21954','144453869132','Nothwest Border Prov'),(25,'262 A Corua (La Corua) Parkway','34418','892775750063','Dhaka'),(26,'28 Charlotte Amalie Street','37551','161968374323','Rabat-Sal-Zammour-Z'),(27,'1780 Hino Boulevard','7716','902731229323','Liepaja'),(28,'96 Tafuna Way','99865','934730187245','Crdoba'),(29,'934 San Felipe de Puerto Plata Street','99780','196495945706','Sind'),(30,'18 Duisburg Boulevard','58327','998009777982',NULL),(31,'217 Botshabelo Place','49521','665356572025','Southern Mindanao'),(32,'1425 Shikarpur Manor','65599','678220867005','Bihar'),(33,'786 Aurora Avenue','65750','18461860151','Yamaguchi'),(34,'1668 Anpolis Street','50199','525255540978','Taipei'),(35,'33 Gorontalo Way','30348','745994947458','West Bengali'),(36,'176 Mandaluyong Place','65213','627705991774','Uttar Pradesh'),(37,'127 Purnea (Purnia) Manor','79388','911872220378','Piemonte'),(38,'61 Tama Street','94065','708403338270','Okayama'),(39,'391 Callao Drive','34021','440512153169','Midi-Pyrnes'),(40,'334 Munger (Monghyr) Lane','38145','481183273622','Markazi'),(41,'1440 Fukuyama Loop','47929','912257250465','Henan'),(42,'269 Cam Ranh Parkway','34689','489783829737','Chisinau'),(43,'306 Antofagasta Place','3989','378318851631','Esprito Santo'),(44,'671 Graz Street','94399','680768868518','Oriental'),(45,'42 Brindisi Place','16744','42384721397','Yerevan'),(46,'1632 Bislig Avenue','61117','471675840679','Nonthaburi'),(47,'1447 Imus Way','48942','539758313890','Tahiti'),(48,'1998 Halifax Drive','76022','177727722820','Lipetsk'),(49,'1718 Valencia Street','37359','675292816413','Antofagasta'),(50,'46 Pjatigorsk Lane','23616','262076994845','Moscow (City)'),(51,'686 Garland Manor','52535','69493378813','Cear'),(52,'909 Garland Manor','69367','705800322606','Tatarstan'),(53,'725 Isesaki Place','74428','876295323994','Mekka'),(54,'115 Hidalgo Parkway','80168','307703950263','Khartum'),(55,'1135 Izumisano Parkway','48150','171822533480','California'),(56,'939 Probolinggo Loop','4166','680428310138','Galicia'),(57,'17 Kabul Boulevard','38594','697760867968','Chiba'),(58,'1964 Allappuzha (Alleppey) Street','48980','920811325222','Yamaguchi'),(59,'1697 Kowloon and New Kowloon Loop','57807','499352017190','Moskova'),(60,'1668 Saint Louis Place','39072','347487831378','Tahiti'),(61,'943 Tokat Street','45428','889318963672','Vaduz'),(62,'1114 Liepaja Street','69226','212869228936','Sarawak'),(63,'1213 Ranchi Parkway','94352','800024380485','Karnataka'),(64,'81 Hodeida Way','55561','250767749542','Rajasthan'),(65,'915 Ponce Place','83980','1395251317','Basel-Stadt'),(66,'1717 Guadalajara Lane','85505','914090181665','Missouri'),(67,'1214 Hanoi Way','67055','491001136577','Nebraska'),(68,'1966 Amroha Avenue','70385','333489324603','Sichuan'),(69,'698 Otsu Street','71110','409983924481','Cayenne'),(70,'1150 Kimchon Manor','96109','663449333709','Skne ln'),(71,'1586 Guaruj Place','5135','947233365992','Hunan'),(72,'57 Arlington Manor','48960','990214419142','Madhya Pradesh'),(73,'1031 Daugavpils Parkway','59025','107137400143','Bchar'),(74,'1124 Buenaventura Drive','6856','407733804223','Mekka'),(75,'492 Cam Ranh Street','50805','565018274456','Eastern Visayas'),(76,'89 Allappuzha (Alleppey) Manor','75444','255800440636','National Capital Reg'),(77,'1947 Poos de Caldas Boulevard','60951','427454485876','Chiayi'),(78,'1206 Dos Quebradas Place','20207','241832790687','So Paulo'),(79,'1551 Rampur Lane','72394','251164340471','Changhwa'),(80,'602 Paarl Street','98889','896314772871','Pavlodar'),(81,'1692 Ede Loop','9223','918711376618','So Paulo'),(82,'936 Salzburg Lane','96709','875756771675','Uttar Pradesh'),(83,'586 Tete Way','1079','18581624103','Kanagawa'),(84,'1888 Kabul Drive','20936','701457319790','Oyo & Osun'),(85,'320 Baiyin Parkway','37307','223664661973','Mahajanga'),(86,'927 Baha Blanca Parkway','9495','821972242086','Krim'),(87,'929 Tallahassee Loop','74671','800716535041','Gauteng'),(88,'125 Citt del Vaticano Boulevard','67912','48417642933','Puebla'),(89,'1557 Ktahya Boulevard','88002','720998247660','England'),(90,'870 Ashqelon Loop','84931','135117278909','Songkhla'),(91,'1740 Portoviejo Avenue','29932','198123170793','Sucre'),(92,'1942 Ciparay Parkway','82624','978987363654','Cheju'),(93,'1926 El Alto Avenue','75543','846225459260','Buenos Aires'),(94,'1952 Chatsworth Drive','25958','991562402283','Guangdong'),(95,'1370 Le Mans Avenue','52163','345679835036','Brunei and Muara'),(96,'984 Effon-Alaiye Avenue','17119','132986892228','Gois'),(97,'832 Nakhon Sawan Manor','49021','275595571388','Inner Mongolia'),(98,'152 Kitwe Parkway','53182','835433605312','Caraga'),(99,'1697 Tanauan Lane','22870','4764773857','Punjab'),(100,'1308 Arecibo Way','30695','6171054059','Georgia'),(101,'1599 Plock Drive','71986','817248913162','Tete'),(102,'669 Firozabad Loop','92265','412903167998','Abu Dhabi'),(103,'588 Vila Velha Manor','51540','333339908719','Kyongsangbuk'),(104,'1913 Kamakura Place','97287','942570536750','Lipetsk'),(105,'733 Mandaluyong Place','77459','196568435814','Asir'),(106,'659 Vaduz Drive','49708','709935135487','Ha Darom'),(107,'1177 Jelets Way','3305','484292626944','Kwara & Kogi'),(108,'1386 Yangor Avenue','80720','449216226468','Provence-Alpes-Cte'),(109,'454 Nakhon Sawan Boulevard','76383','963887147572','Funafuti'),(110,'1867 San Juan Bautista Tuxtepec Avenue','78311','547003310357','Ivanovo'),(111,'1532 Dzerzinsk Way','9599','330838016880','Buenos Aires'),(112,'1002 Ahmadnagar Manor','93026','371490777743','Mxico'),(113,'682 Junan Way','30418','622255216127','North West'),(114,'804 Elista Drive','61069','379804592943','Hubei'),(115,'1378 Alvorada Avenue','75834','272234298332','Distrito Federal'),(116,'793 Cam Ranh Avenue','87057','824370924746','California'),(117,'1079 Tel Aviv-Jaffa Boulevard','10885','358178933857','Sucre'),(118,'442 Rae Bareli Place','24321','886636413768','Nordrhein-Westfalen'),(119,'1107 Nakhon Sawan Avenue','75149','867546627903','Mxico'),(120,'544 Malm Parkway','63502','386759646229','Central Java'),(121,'1967 Sincelejo Place','73644','577812616052','Gujarat'),(122,'333 Goinia Way','78625','909029256431','Texas'),(123,'1987 Coacalco de Berriozbal Loop','96065','787654415858','al-Qalyubiya'),(124,'241 Mosul Lane','76157','765345144779','Risaralda'),(125,'211 Chiayi Drive','58186','665993880048','Uttar Pradesh'),(126,'1175 Tanauan Way','64615','937222955822','Lima'),(127,'117 Boa Vista Way','6804','677976133614','Uttar Pradesh'),(128,'848 Tafuna Manor','45142','614935229095','Ktahya'),(129,'569 Baicheng Lane','60304','490211944645','Gauteng'),(130,'1666 Qomsheh Drive','66255','582835362905','So Paulo'),(131,'801 Hagonoy Drive','8439','237426099212','Smolensk'),(132,'1050 Garden Grove Avenue','4999','973047364353','Slaskie'),(133,'1854 Tieli Street','15819','509492324775','Shandong'),(134,'758 Junan Lane','82639','935448624185','Gois'),(135,'1752 So Leopoldo Parkway','14014','252265130067','Taka-Karpatia'),(136,'898 Belm Manor','49757','707169393853','Free State'),(137,'261 Saint Louis Way','83401','321944036800','Coahuila de Zaragoza'),(138,'765 Southampton Drive','4285','23712411567','al-Qalyubiya'),(139,'943 Johannesburg Avenue','5892','90921003005','Maharashtra'),(140,'788 Atinsk Street','81691','146497509724','Karnataka'),(141,'1749 Daxian Place','11044','963369996279','Gelderland'),(142,'1587 Sullana Lane','85769','468060467018','Inner Mongolia'),(143,'1029 Dzerzinsk Manor','57519','33173584456','Ynlin'),(144,'1666 Beni-Mellal Place','13377','9099941466','Tennessee'),(145,'928 Jaffna Loop','93762','581852137991','Hiroshima'),(146,'483 Ljubertsy Parkway','60562','581174211853','Scotland'),(147,'374 Bat Yam Boulevard','97700','923261616249','Kilis'),(148,'1027 Songkhla Manor','30861','563660187896','Minsk'),(149,'999 Sanaa Loop','3439','918032330119','Gauteng'),(150,'879 Newcastle Way','90732','206841104594','Michigan'),(151,'1337 Lincoln Parkway','99457','597815221267','Saitama'),(152,'1952 Pune Lane','92150','354615066969','Saint-Denis'),(153,'782 Mosul Street','25545','885899703621','Massachusetts'),(154,'781 Shimonoseki Drive','95444','632316273199','Michoacn de Ocampo'),(155,'1560 Jelets Boulevard','77777','189446090264','Shandong'),(156,'1963 Moscow Place','64863','761379480249','Assam'),(157,'456 Escobar Way','36061','719202533520','Jakarta Raya'),(158,'798 Cianjur Avenue','76990','499408708580','Shanxi'),(159,'185 Novi Sad Place','41778','904253967161','Bern'),(160,'1367 Yantai Manor','21294','889538496300','Ondo & Ekiti'),(161,'1386 Nakhon Sawan Boulevard','53502','368899174225','Pyongyang-si'),(162,'369 Papeete Way','66639','170117068815','North Carolina'),(163,'1440 Compton Place','81037','931059836497','North Austria'),(164,'1623 Baha Blanca Manor','81511','149981248346','Moskova'),(165,'97 Shimoga Avenue','44660','177167004331','Tel Aviv'),(166,'1740 Le Mans Loop','22853','168476538960','Pays de la Loire'),(167,'1287 Xiangfan Boulevard','57844','819416131190','Gifu'),(168,'842 Salzburg Lane','3313','697151428760','Adana'),(169,'154 Tallahassee Loop','62250','935508855935','Xinxiang'),(170,'710 San Felipe del Progreso Avenue','76901','843801144113','Lilongwe'),(171,'1540 Wroclaw Drive','62686','182363341674','Maharashtra'),(172,'475 Atinsk Way','59571','201705577290','Gansu'),(173,'1294 Firozabad Drive','70618','161801569569','Jiangxi'),(174,'1877 Ezhou Lane','63337','264541743403','Rajasthan'),(175,'316 Uruapan Street','58194','275788967899','Perak'),(176,'29 Pyongyang Loop','47753','734780743462','Batman'),(177,'1010 Klerksdorp Way','6802','493008546874','Steiermark'),(178,'1848 Salala Boulevard','25220','48265851133','Miranda'),(179,'431 Xiangtan Avenue','4854','230250973122','Kerala'),(180,'757 Rustenburg Avenue','89668','506134035434','Skikda'),(181,'146 Johannesburg Way','54132','953689007081','Tamaulipas'),(182,'1891 Rizhao Boulevard','47288','391065549876','So Paulo'),(183,'1089 Iwatsuki Avenue','35109','866092335135','Kirov'),(184,'1410 Benin City Parkway','29747','104150372603','Risaralda'),(185,'682 Garden Grove Place','67497','72136330362','Tennessee'),(186,'533 al-Ayn Boulevard','8862','662227486184','California'),(187,'1839 Szkesfehrvr Parkway','55709','947468818183','Gois'),(188,'741 Ambattur Manor','43310','302590383819','Noord-Brabant'),(189,'927 Barcelona Street','65121','951486492670','Chaharmahal va Bakht'),(190,'435 0 Way','74750','760171523969','West Bengali'),(191,'140 Chiayi Parkway','38982','855863906434','Sumy'),(192,'1166 Changhwa Street','58852','650752094490','Caraga'),(193,'891 Novi Sad Manor','5379','247646995453','Ontario'),(194,'605 Rio Claro Parkway','49348','352469351088','Tabora'),(195,'1077 San Felipe de Puerto Plata Place','65387','812824036424','Rostov-na-Donu'),(196,'9 San Miguel de Tucumn Manor','90845','956188728558','Uttar Pradesh'),(197,'447 Surakarta Loop','10428','940830176580','Nyanza'),(198,'345 Oshawa Boulevard','32114','104491201771','Tokyo-to'),(199,'1792 Valle de la Pascua Place','15540','419419591240','Nordrhein-Westfalen'),(200,'1074 Binzhou Manor','36490','331132568928','Baden-Wrttemberg'),(201,'817 Bradford Loop','89459','264286442804','Jiangsu'),(202,'955 Bamenda Way','1545','768481779568','Ondo & Ekiti'),(203,'1149 A Corua (La Corua) Boulevard','95824','470884141195','Haiphong'),(204,'387 Mwene-Ditu Drive','8073','764477681869','Ahal'),(205,'68 Molodetno Manor','4662','146640639760','Nordrhein-Westfalen'),(206,'642 Nador Drive','3924','369050085652','Maharashtra'),(207,'1688 Nador Lane','61613','652218196731','Sulawesi Utara'),(208,'1215 Pyongyang Parkway','25238','646237101779','Usak'),(209,'1679 Antofagasta Street','86599','905903574913','Alto Paran'),(210,'1304 s-Hertogenbosch Way','10925','90336226227','Santa Catarina'),(211,'850 Salala Loop','10800','403404780639','Kitaa'),(212,'624 Oshawa Boulevard','89959','49677664184','West Bengali'),(213,'43 Dadu Avenue','4855','95666951770','Rajasthan'),(214,'751 Lima Loop','99405','756460337785','Aden'),(215,'1333 Haldia Street','82161','408304391718','Jilin'),(216,'660 Jedda Boulevard','25053','168758068397','Washington'),(217,'1001 Miyakonojo Lane','67924','584316724815','Taizz'),(218,'226 Brest Manor','2299','785881412500','California'),(219,'1229 Valencia Parkway','99124','352679173732','Haskovo'),(220,'1201 Qomsheh Manor','21464','873492228462','Gois'),(221,'866 Shivapuri Manor','22474','778502731092','Uttar Pradesh'),(222,'1168 Najafabad Parkway','40301','886649065861','Kabol'),(223,'1244 Allappuzha (Alleppey) Place','20657','991802825778','Buenos Aires'),(224,'1842 Luzinia Boulevard','94420','706878974831','Zanzibar West'),(225,'1926 Gingoog Street','22824','469738825391','Sisilia'),(226,'810 Palghat (Palakkad) Boulevard','73431','516331171356','Jaroslavl'),(227,'1820 Maring Parkway','88307','99760893676','Punjab'),(228,'60 Poos de Caldas Street','82338','963063788669','Rajasthan'),(229,'1014 Loja Manor','66851','460795526514','Tamil Nadu'),(230,'201 Effon-Alaiye Way','64344','684192903087','Asuncin'),(231,'430 Alessandria Loop','47446','669828224459','Saarland'),(232,'754 Valencia Place','87911','594319417514','Phnom Penh'),(233,'356 Olomouc Manor','93323','22326410776','Gois'),(234,'1256 Bislig Boulevard','50598','479007229460','Botosani'),(235,'954 Kimchon Place','42420','541327526474','West Bengali'),(236,'885 Yingkou Manor','31390','588964509072','Kaduna'),(237,'1736 Cavite Place','98775','431770603551','Qina'),(238,'346 Skikda Parkway','90628','630424482919','Hawalli'),(239,'98 Stara Zagora Boulevard','76448','610173756082','Valle'),(240,'1479 Rustenburg Boulevard','18727','727785483194','Southern Tagalog'),(241,'647 A Corua (La Corua) Street','36971','792557457753','Chollanam'),(242,'1964 Gijn Manor','14408','918119601885','Karnataka'),(243,'47 Syktyvkar Lane','22236','63937119031','West Java'),(244,'1148 Saarbrcken Parkway','1921','137773001988','Fukushima'),(245,'1103 Bilbays Parkway','87660','279979529227','Hubei'),(246,'1246 Boksburg Parkway','28349','890283544295','Hebei'),(247,'1483 Pathankot Street','37288','686015532180','Tucumn'),(248,'582 Papeete Loop','27722','569868543137','Central Visayas'),(249,'300 Junan Street','81314','890289150158','Kyonggi'),(250,'829 Grand Prairie Way','6461','741070712873','Paran'),(251,'1473 Changhwa Parkway','75933','266798132374','Mxico'),(252,'1309 Weifang Street','57338','435785045362','Florida'),(253,'1760 Oshawa Manor','38140','56257502250','Tianjin'),(254,'786 Stara Zagora Way','98332','716256596301','Oyo & Osun'),(255,'1966 Tonghae Street','36481','567359279425','Anhalt Sachsen'),(256,'1497 Yuzhou Drive','3433','246810237916','England'),(258,'752 Ondo Loop','32474','134673576619','Miyazaki'),(259,'1338 Zalantun Lane','45403','840522972766','Minas Gerais'),(260,'127 Iwakuni Boulevard','20777','987442542471','Central Luzon'),(261,'51 Laredo Avenue','68146','884536620568','Sagaing'),(262,'771 Yaound Manor','86768','245477603573','Sofala'),(263,'532 Toulon Street','69517','46871694740','Santiago'),(264,'1027 Banjul Place','50390','538241037443','West Bengali'),(265,'1158 Mandi Bahauddin Parkway','98484','276555730211','Shanxi'),(266,'862 Xintai Lane','30065','265153400632','Cagayan Valley'),(267,'816 Cayenne Parkway','93629','282874611748','Manab'),(268,'1831 Nam Dinh Loop','51990','322888976727','National Capital Reg'),(269,'446 Kirovo-Tepetsk Lane','19428','303967439816','Osaka'),(270,'682 Halisahar Place','20536','475553436330','Severn Morava'),(271,'1587 Loja Manor','5410','621625204422','Salzburg'),(272,'1762 Paarl Parkway','53928','192459639410','Hunan'),(273,'1519 Ilorin Place','49298','357445645426','Kerala'),(274,'920 Kumbakonam Loop','75090','685010736240','California'),(275,'906 Goinia Way','83565','701767622697','Wielkopolskie'),(276,'1675 Xiangfan Manor','11763','271149517630','Tamil Nadu'),(277,'85 San Felipe de Puerto Plata Drive','46063','170739645687','Shandong'),(278,'144 South Hill Loop','2012','45387294817','Guanajuato'),(279,'1884 Shikarpur Avenue','85548','959949395183','Haryana'),(280,'1980 Kamjanets-Podilskyi Street','89502','874337098891','Illinois'),(281,'1944 Bamenda Way','24645','75975221996','Michigan'),(282,'556 Baybay Manor','55802','363982224739','Oyo & Osun'),(283,'457 Tongliao Loop','56254','880756161823','Bursa'),(284,'600 Bradford Street','96204','117592274996','East Azerbaidzan'),(285,'1006 Santa Brbara dOeste Manor','36229','85059738746','Ondo & Ekiti'),(286,'1308 Sumy Loop','30657','583021225407','Fujian'),(287,'1405 Chisinau Place','8160','62781725285','Ponce'),(288,'226 Halifax Street','58492','790651020929','Xinxiang'),(289,'1279 Udine Parkway','75860','195003555232','Edo & Delta'),(290,'1336 Benin City Drive','46044','341242939532','Shiga'),(291,'1155 Liaocheng Place','22650','558236142492','Oyo & Osun'),(292,'1993 Tabuk Lane','64221','648482415405','Tamil Nadu'),(293,'86 Higashiosaka Lane','33768','957128697225','Guanajuato'),(294,'1912 Allende Manor','58124','172262454487','Kowloon and New Kowl'),(295,'544 Tarsus Boulevard','53145','892523334','Gurico'),(296,'1936 Cuman Avenue','61195','976798660411','Virginia'),(297,'1192 Tongliao Street','19065','350970907017','Sharja'),(298,'44 Najafabad Way','61391','96604821070','Baskimaa'),(299,'32 Pudukkottai Lane','38834','967274728547','Ohio'),(300,'661 Chisinau Lane','8856','816436065431','Pietari'),(301,'951 Stara Zagora Manor','98573','429925609431','Punjab'),(302,'922 Vila Velha Loop','4085','510737228015','Maharashtra'),(303,'898 Jining Lane','40070','161643343536','Pohjois-Pohjanmaa'),(304,'1635 Kuwana Boulevard','52137','710603868323','Hiroshima'),(305,'41 El Alto Parkway','56883','51917807050','Maharashtra'),(306,'1883 Maikop Lane','68469','96110042435','Kaliningrad'),(307,'1908 Gaziantep Place','58979','108053751300','Liaoning'),(308,'687 Alessandria Parkway','57587','407218522294','Sanaa'),(309,'827 Yuncheng Drive','79047','504434452842','Callao'),(310,'913 Coacalco de Berriozbal Loop','42141','262088367001','Texas'),(311,'715 So Bernardo do Campo Lane','84804','181179321332','Kedah'),(312,'1354 Siegen Street','80184','573441801529','Rio de Janeiro'),(313,'1191 Sungai Petani Boulevard','9668','983259819766','Missouri'),(314,'1224 Huejutla de Reyes Boulevard','70923','806016930576','Lombardia'),(315,'543 Bergamo Avenue','59686','103602195112','Minas Gerais'),(316,'746 Joliet Lane','94878','688485191923','Kursk'),(317,'780 Kimberley Way','17032','824396883951','Tabuk'),(318,'1774 Yaound Place','91400','613124286867','Hubei'),(319,'1957 Yantai Lane','59255','704948322302','So Paulo'),(320,'1542 Lubumbashi Boulevard','62472','508800331065','Tel Aviv'),(321,'651 Pathankot Loop','59811','139378397418','Maharashtra'),(322,'1359 Zhoushan Parkway','29763','46568045367','Streymoyar'),(323,'1769 Iwaki Lane','25787','556100547674','Kujawsko-Pomorskie'),(324,'1145 Vilnius Manor','73170','674805712553','Mxico'),(325,'1892 Nabereznyje Telny Lane','28396','478229987054','Tutuila'),(326,'470 Boksburg Street','97960','908029859266','Central'),(327,'1427 A Corua (La Corua) Place','85799','972574862516','Buenos Aires'),(328,'479 San Felipe del Progreso Avenue','54949','869051782691','Morelos'),(329,'867 Benin City Avenue','78543','168884817145','Henan'),(330,'981 Kumbakonam Place','87611','829116184079','Distrito Federal'),(331,'1016 Iwakuni Street','49833','961370847344','St George'),(332,'663 Baha Blanca Parkway','33463','834418779292','Adana'),(333,'1860 Taguig Loop','59550','38158430589','West Java'),(334,'1816 Bydgoszcz Loop','64308','965273813662','Dhaka'),(335,'587 Benguela Manor','91590','165450987037','Illinois'),(336,'430 Kumbakonam Drive','28814','105470691550','Santa F'),(337,'1838 Tabriz Lane','1195','38988715447','Dhaka'),(338,'431 Szkesfehrvr Avenue','57828','119501405123','Baki'),(339,'503 Sogamoso Loop','49812','834626715837','Sumqayit'),(340,'507 Smolensk Loop','22971','80303246192','Sousse'),(341,'1920 Weifang Avenue','15643','869507847714','Uttar Pradesh'),(342,'124 al-Manama Way','52368','647899404952','Hiroshima'),(343,'1443 Mardan Street','31483','231383037471','Western Cape'),(344,'1909 Benguela Lane','19913','624138001031','Henan'),(345,'68 Ponce Parkway','85926','870635127812','Hanoi'),(346,'1217 Konotop Avenue','504','718917251754','Gelderland'),(347,'1293 Nam Dinh Way','71583','697656479977','Roraima'),(348,'785 Vaduz Street','36170','895616862749','Baja California'),(349,'1516 Escobar Drive','46069','64536069371','Tongatapu'),(350,'1628 Nagareyama Lane','60079','20064292617','Central'),(351,'1157 Nyeri Loop','56380','262744791493','Adygea'),(352,'1673 Tangail Drive','26857','627924259271','Daugavpils'),(353,'381 Kabul Way','87272','55477302294','Taipei'),(354,'953 Hodeida Street','18841','53912826864','Southern Tagalog'),(355,'469 Nakhon Sawan Street','58866','689199636560','Tuvassia'),(356,'1378 Beira Loop','40792','840957664136','Krasnojarsk'),(357,'1641 Changhwa Place','37636','256546485220','Nord-Ouest'),(358,'1698 Southport Loop','49009','754358349853','Hidalgo'),(359,'519 Nyeri Manor','37650','764680915323','So Paulo'),(360,'619 Hunuco Avenue','81508','142596392389','Shimane'),(361,'45 Aparecida de Goinia Place','7431','650496654258','Madhya Pradesh'),(362,'482 Kowloon and New Kowloon Manor','97056','738968474939','Bratislava'),(363,'604 Bern Place','5373','620719383725','Jharkhand'),(364,'1623 Kingstown Drive','91299','296394569728','Buenos Aires'),(365,'1009 Zanzibar Lane','64875','102396298916','Arecibo'),(366,'114 Jalib al-Shuyukh Manor','60440','845378657301','Centre'),(367,'1163 London Parkway','6066','675120358494','Par'),(368,'1658 Jastrzebie-Zdrj Loop','96584','568367775448','Central'),(369,'817 Laredo Avenue','77449','151249681135','Jalisco'),(370,'1565 Tangail Manor','45750','634445428822','Okinawa'),(371,'1912 Emeishan Drive','33050','99883471275','Balikesir'),(372,'230 Urawa Drive','2738','166898395731','Andhra Pradesh'),(373,'1922 Miraj Way','13203','320471479776','Esfahan'),(374,'433 Florencia Street','91330','561729882725','Chihuahua'),(375,'1049 Matamoros Parkway','69640','960505250340','Karnataka'),(376,'1061 Ede Avenue','57810','333390595558','Southern Tagalog'),(377,'154 Oshawa Manor','72771','440365973660','East Java'),(378,'1191 Tandil Drive','6362','45554316010','Southern Tagalog'),(379,'1133 Rizhao Avenue','2800','600264533987','Pernambuco'),(380,'1519 Santiago de los Caballeros Loop','22025','409315295763','East Kasai'),(381,'1618 Olomouc Manor','26385','96846695220','Kurgan'),(382,'220 Hidalgo Drive','45298','342720754566','Kermanshah'),(383,'686 Donostia-San Sebastin Lane','97390','71857599858','Guangdong'),(384,'97 Mogiljov Lane','89294','924815207181','Gujarat'),(385,'1642 Charlotte Amalie Drive','75442','821476736117','Slaskie'),(386,'1368 Maracabo Boulevard','32716','934352415130',NULL),(387,'401 Sucre Boulevard','25007','486395999608','New Hampshire'),(388,'368 Hunuco Boulevard','17165','106439158941','Namibe'),(389,'500 Lincoln Parkway','95509','550306965159','Jiangsu'),(390,'102 Chapra Drive','14073','776031833752','Ibaragi'),(391,'1793 Meixian Place','33535','619966287415','Hmelnytskyi'),(392,'514 Ife Way','69973','900235712074','Shaba'),(393,'717 Changzhou Lane','21615','426255288071','Southern Tagalog'),(394,'753 Ilorin Avenue','3656','464511145118','Sichuan'),(395,'1337 Mit Ghamr Avenue','29810','175283210378','Nakhon Sawan'),(396,'767 Pyongyang Drive','83536','667736124769','Osaka'),(397,'614 Pak Kret Street','27796','47808359842','Addis Abeba'),(398,'954 Lapu-Lapu Way','8816','737229003916','Moskova'),(399,'331 Bydgoszcz Parkway','966','537374465982','Asturia'),(400,'1152 Citrus Heights Manor','5239','765957414528','al-Qadarif'),(401,'168 Cianjur Manor','73824','679095087143','Saitama'),(402,'616 Hagonoy Avenue','46043','604177838256','Krasnojarsk'),(403,'1190 0 Place','10417','841876514789','Rio Grande do Sul'),(404,'734 Bchar Place','30586','280578750435','Punjab'),(405,'530 Lausanne Lane','11067','775235029633','Texas'),(406,'454 Patiala Lane','13496','794553031307','Fukushima'),(407,'1346 Mysore Drive','61507','516647474029','Bretagne'),(408,'990 Etawah Loop','79940','206169448769','Tamil Nadu'),(409,'1266 Laredo Parkway','7664','1483365694','Saitama'),(410,'88 Nagaon Manor','86868','779461480495','Buenos Aires'),(411,'264 Bhimavaram Manor','54749','302526949177','St Thomas'),(412,'1639 Saarbrcken Drive','9827','328494873422','North West'),(413,'692 Amroha Drive','35575','359478883004','Northern'),(414,'1936 Lapu-Lapu Parkway','7122','653436985797','Bauchi & Gombe'),(415,'432 Garden Grove Street','65630','615964523510','Ontario'),(416,'1445 Carmen Parkway','70809','598912394463','West Java'),(417,'791 Salinas Street','40509','129953030512','Punjab'),(418,'126 Acua Parkway','58888','480039662421','West Bengali'),(419,'397 Sunnyvale Avenue','55566','680851640676','Guanajuato'),(420,'992 Klerksdorp Loop','33711','855290087237','Utrecht'),(421,'966 Arecibo Loop','94018','15273765306','Sind'),(422,'289 Santo Andr Manor','72410','214976066017','al-Sharqiya'),(423,'437 Chungho Drive','59489','491271355190','Puerto Plata'),(424,'1948 Bayugan Parkway','60622','987306329957','Bihar'),(425,'1866 al-Qatif Avenue','89420','546793516940','California'),(426,'1661 Abha Drive','14400','270456873752','Tamil Nadu'),(427,'1557 Cape Coral Parkway','46875','368284120423','Hubei'),(428,'1727 Matamoros Place','78813','129673677866','Sawhaj'),(429,'1269 Botosani Manor','47394','736517327853','Guangdong'),(430,'355 Vitria de Santo Anto Way','81758','548003849552','Oaxaca'),(431,'1596 Acua Parkway','70425','157133457169','Jharkhand'),(432,'259 Ipoh Drive','64964','419009857119','So Paulo'),(433,'1823 Hoshiarpur Lane','33191','307133768620','Komi'),(434,'1404 Taguig Drive','87212','572068624538','Okayama'),(435,'740 Udaipur Lane','33505','497288595103','Nizni Novgorod'),(436,'287 Cuautla Boulevard','72736','82619513349','Chuquisaca'),(437,'1766 Almirante Brown Street','63104','617567598243','KwaZulu-Natal'),(438,'596 Huixquilucan Place','65892','342709348083','Nampula'),(439,'1351 Aparecida de Goinia Parkway','41775','959834530529','Northern Mindanao'),(440,'722 Bradford Lane','90920','746251338300','Shandong'),(441,'983 Santa F Way','47472','145720452260','British Colombia'),(442,'1245 Ibirit Way','40926','331888642162','La Romana'),(443,'1836 Korla Parkway','55405','689681677428','Copperbelt'),(444,'231 Kaliningrad Place','57833','575081026569','Lombardia'),(445,'495 Bhimavaram Lane','3','82088937724','Maharashtra'),(446,'1924 Shimonoseki Drive','52625','406784385440','Batna'),(447,'105 Dzerzinsk Manor','48570','240776414296','Inner Mongolia'),(448,'614 Denizli Parkway','29444','876491807547','Rio Grande do Sul'),(449,'1289 Belm Boulevard','88306','237368926031','Tartumaa'),(450,'203 Tambaram Street','73942','411549550611','Buenos Aires'),(451,'1704 Tambaram Manor','2834','39463554936','West Bengali'),(452,'207 Cuernavaca Loop','52671','782900030287','Tatarstan'),(453,'319 Springs Loop','99552','72524459905','Baijeri'),(454,'956 Nam Dinh Manor','21872','474047727727','Kerman'),(455,'1947 Paarl Way','23636','834061016202','Central Java'),(456,'814 Simferopol Loop','48745','524567129902','Sinaloa'),(457,'535 Ahmadnagar Manor','41136','985109775584','Abu Dhabi'),(458,'138 Caracas Boulevard','16790','974433019532','Zulia'),(459,'251 Florencia Drive','16119','118011831565','Michoacn de Ocampo'),(460,'659 Gatineau Boulevard','28587','205524798287','La Paz'),(461,'1889 Valparai Way','75559','670370974122','Ziguinchor'),(462,'1485 Bratislava Place','83183','924663855568','Illinois'),(463,'935 Aden Boulevard','64709','335052544020','Central Java'),(464,'76 Kermanshah Manor','23343','762361821578','Esfahan'),(465,'734 Tanshui Avenue','70664','366776723320','Caquet'),(466,'118 Jaffna Loop','10447','325526730021','Northern Mindanao'),(467,'1621 Tongliao Avenue','22173','209342540247','Irkutsk'),(468,'1844 Usak Avenue','84461','164414772677','Nova Scotia'),(469,'1872 Toulon Loop','7939','928809465153','OHiggins'),(470,'1088 Ibirit Place','88502','49084281333','Jalisco'),(471,'1322 Mosul Parkway','95400','268053970382','Shandong'),(472,'1447 Chatsworth Place','41545','769370126331','Chihuahua'),(473,'1257 Guadalajara Street','33599','195337700615','Karnataka'),(474,'1469 Plock Lane','95835','622884741180','Galicia'),(475,'434 Ourense (Orense) Manor','14122','562370137426','Hodeida'),(476,'270 Tambaram Parkway','9668','248446668735','Gauteng'),(477,'1786 Salinas Place','66546','206060652238','Nam Ha'),(478,'1078 Stara Zagora Drive','69221','932992626595','Aceh'),(479,'1854 Okara Boulevard','42123','131912793873','Drenthe'),(480,'421 Yaound Street','11363','726875628268','Sumy'),(481,'1153 Allende Way','20336','856872225376','Qubec'),(482,'808 Naala-Porto Parkway','41060','553452430707','England'),(483,'632 Usolje-Sibirskoje Parkway','73085','667648979883','Ha Darom'),(484,'98 Pyongyang Boulevard','88749','191958435142','Ohio'),(485,'984 Novoterkassk Loop','28165','435118527255','Gaziantep'),(486,'64 Korla Street','25145','510383179153','Mwanza'),(487,'1785 So Bernardo do Campo Street','71182','684529463244','Veracruz'),(488,'698 Jelets Boulevard','2596','975185523021','Denizli'),(489,'1297 Alvorada Parkway','11839','508348602835','Ningxia'),(490,'1909 Dayton Avenue','88513','702955450528','Guangdong'),(491,'1789 Saint-Denis Parkway','8268','936806643983','Coahuila de Zaragoza'),(492,'185 Mannheim Lane','23661','589377568313','Stavropol'),(493,'184 Mandaluyong Street','94239','488425406814','Baja California Sur'),(494,'591 Sungai Petani Drive','46400','37247325001','Okayama'),(495,'656 Matamoros Drive','19489','17305839123','Boyac'),(496,'775 ostka Drive','22358','171973024401','al-Daqahliya'),(497,'1013 Tabuk Boulevard','96203','158399646978','West Bengali'),(498,'319 Plock Parkway','26101','854259976812','Istanbul'),(499,'1954 Kowloon and New Kowloon Way','63667','898559280434','Chimborazo'),(500,'362 Rajkot Lane','98030','962020153680','Gansu'),(501,'1060 Tandil Lane','72349','211256301880','Shandong'),(502,'1515 Korla Way','57197','959467760895','England'),(503,'1416 San Juan Bautista Tuxtepec Avenue','50592','144206758053','Zufar'),(504,'1 Valle de Santiago Avenue','86208','465897838272','Apulia'),(505,'519 Brescia Parkway','69504','793996678771','East Java'),(506,'414 Mandaluyong Street','16370','52709222667','Lubelskie'),(507,'1197 Sokoto Boulevard','87687','868602816371','West Bengali'),(508,'496 Celaya Drive','90797','759586584889','Nagano'),(509,'786 Matsue Way','37469','111177206479','Illinois'),(510,'48 Maracabo Place','1570','82671830126','Central Luzon'),(511,'1152 al-Qatif Lane','44816','131370665218','Kalimantan Barat'),(512,'1269 Ipoh Avenue','54674','402630109080','Eskisehir'),(513,'758 Korolev Parkway','75474','441628280920','Andhra Pradesh'),(514,'1747 Rustenburg Place','51369','442673923363','Bihar'),(515,'886 Tonghae Place','19450','711928348157','Volgograd'),(516,'1574 Goinia Boulevard','39529','59634255214','Heilongjiang'),(517,'548 Uruapan Street','35653','879347453467','Ontario'),(519,'962 Tama Loop','65952','282667506728',NULL),(520,'1778 Gijn Manor','35156','288910576761','Hubei'),(521,'568 Dhule (Dhulia) Loop','92568','602101369463','Coquimbo'),(522,'1768 Udine Loop','32347','448876499197','Battambang'),(523,'608 Birgunj Parkway','400','627425618482','Taipei'),(524,'680 A Corua (La Corua) Manor','49806','158326114853','Sivas'),(525,'1949 Sanya Street','61244','132100972047','Gumma'),(526,'617 Klerksdorp Place','94707','574973479129','Khanh Hoa'),(527,'1993 0 Loop','41214','25865528181','Liaoning'),(528,'1176 Southend-on-Sea Manor','81651','236679267178','Southern Tagalog'),(529,'600 Purnea (Purnia) Avenue','18043','638409958875','Nghe An'),(530,'1003 Qinhuangdao Street','25972','35533115997','West Java'),(531,'1986 Sivas Place','95775','182059202712','Friuli-Venezia Giuli'),(532,'1427 Tabuk Place','31342','214756839122','Florida'),(533,'556 Asuncin Way','35364','338244023543','Mogiljov'),(534,'486 Ondo Parkway','35202','105882218332','Benguela'),(535,'635 Brest Manor','40899','80593242951','Andhra Pradesh'),(536,'166 Jinchang Street','86760','717566026669','Buenos Aires'),(537,'958 Sagamihara Lane','88408','427274926505','Mie'),(538,'1817 Livorno Way','79401','478380208348','Khanh Hoa'),(539,'1332 Gaziantep Lane','22813','383353187467','Shandong'),(540,'949 Allende Lane','67521','122981120653','Uttar Pradesh'),(541,'195 Ilorin Street','49250','8912935608','Chari-Baguirmi'),(542,'193 Bhusawal Place','9750','745267607502','Kang-won'),(543,'43 Vilnius Manor','79814','484500282381','Colorado'),(544,'183 Haiphong Street','69953','488600270038','Jilin'),(545,'163 Augusta-Richmond County Loop','33030','754579047924','Carabobo'),(546,'191 Jos Azueta Parkway','13629','932156667696','Ruse'),(547,'379 Lublin Parkway','74568','921960450089','Toscana'),(548,'1658 Cuman Loop','51309','784907335610','Sumatera Selatan'),(549,'454 Qinhuangdao Drive','25866','786270036240','Tadla-Azilal'),(550,'1715 Okayama Street','55676','169352919175','So Paulo'),(551,'182 Nukualofa Drive','15414','426346224043','Sumy'),(552,'390 Wroclaw Way','5753','357593328658','Hainan'),(553,'1421 Quilmes Lane','19151','135407755975','Ishikawa'),(554,'947 Trshavn Place','841','50898428626','Central Luzon'),(555,'1764 Jalib al-Shuyukh Parkway','77642','84794532510','Galicia'),(556,'346 Cam Ranh Avenue','39976','978430786151','Zhejiang'),(557,'1407 Pachuca de Soto Place','26284','380077794770','Rio Grande do Sul'),(558,'904 Clarksville Drive','52234','955349440539','Zhejiang'),(559,'1917 Kumbakonam Parkway','11892','698182547686','Vojvodina'),(560,'1447 Imus Place','12905','62127829280','Gujarat'),(561,'1497 Fengshan Drive','63022','368738360376','KwaZulu-Natal'),(562,'869 Shikarpur Way','57380','590764256785','England'),(563,'1059 Yuncheng Avenue','47498','107092893983','Vilna'),(564,'505 Madiun Boulevard','97271','970638808606','Dolnoslaskie'),(565,'1741 Hoshiarpur Boulevard','22372','855066328617','al-Sharqiya'),(566,'1229 Varanasi (Benares) Manor','40195','817740355461','Buenos Aires'),(567,'1894 Boa Vista Way','77464','239357986667','Texas'),(568,'1342 Sharja Way','93655','946114054231','Sokoto & Kebbi & Zam'),(569,'1342 Abha Boulevard','10714','997453607116','Bukarest'),(570,'415 Pune Avenue','44274','203202500108','Shandong'),(571,'1746 Faaa Way','32515','863080561151','Huanuco'),(572,'539 Hami Way','52196','525518075499','Tokat'),(573,'1407 Surakarta Manor','33224','324346485054','Moskova'),(574,'502 Mandi Bahauddin Parkway','15992','618156722572','Anzotegui'),(575,'1052 Pathankot Avenue','77397','128499386727','Sichuan'),(576,'1351 Sousse Lane','37815','203804046132','Coahuila de Zaragoza'),(577,'1501 Pangkal Pinang Avenue','943','770864062795','Mazowieckie'),(578,'1405 Hagonoy Avenue','86587','867287719310','Slaskie'),(579,'521 San Juan Bautista Tuxtepec Place','95093','844018348565','Qaraghandy'),(580,'923 Tangail Boulevard','33384','315528269898','Tokyo-to'),(581,'186 Skikda Lane','89422','14465669789','Morelos'),(582,'1568 Celaya Parkway','34750','278669994384','Kaohsiung'),(583,'1489 Kakamigahara Lane','98883','29341849811','Taipei'),(584,'1819 Alessandria Loop','53829','377633994405','Campeche'),(585,'1208 Tama Loop','73605','954786054144','Ninawa'),(586,'951 Springs Lane','96115','165164761435','Central Mindanao'),(587,'760 Miyakonojo Drive','64682','294449058179','Guerrero'),(588,'966 Asuncin Way','62703','995527378381','Hidalgo'),(589,'1584 Ljubertsy Lane','22954','285710089439','England'),(590,'247 Jining Parkway','53446','170115379190','Banjul'),(591,'773 Dallas Manor','12664','914466027044','Buenos Aires'),(592,'1923 Stara Zagora Lane','95179','182178609211','Nantou'),(593,'1402 Zanzibar Boulevard','71102','387448063440','Guanajuato'),(594,'1464 Kursk Parkway','17381','338758048786','Shandong'),(595,'1074 Sanaa Parkway','22474','154124128457','Loja'),(596,'1759 Niznekamsk Avenue','39414','864392582257','al-Manama'),(597,'32 Liaocheng Way','1944','410877354933','Minas Gerais'),(598,'42 Fontana Avenue','14684','437829801725','Fejr'),(599,'1895 Zhezqazghan Drive','36693','137809746111','California'),(600,'1837 Kaduna Parkway','82580','640843562301','Inner Mongolia'),(601,'844 Bucuresti Place','36603','935952366111','Liaoning'),(602,'1101 Bucuresti Boulevard','97661','199514580428','West Greece'),(603,'1103 Quilmes Boulevard','52137','644021380889','Piura'),(604,'1331 Usak Boulevard','61960','145308717464','Vaud'),(605,'1325 Fukuyama Street','27107','288241215394','Heilongjiang');


CALL ModificarDireccion(1,'47 Casa 1','-','-','Alberta',@pMensaje);
SELECT @pMensaje;

/*Realizar un procedimiento almacenado llamado TotalPeliculas que muestre por cada
actor su código, apellido y nombre (formato: apellido, nombre) y cantidad de películas en las
que participó. Al final del listado se deberá mostrar también la cantidad total de películas. La
salida deberá estar ordenada alfabéticamente según el apellido y nombre del actor. Incluir
en el código la llamada al procedimiento.*/

DROP PROCEDURE IF EXISTS `TotalPeliculas`;
DELIMITER //

CREATE PROCEDURE `TotalPeliculas`()
FINAL:
BEGIN
    -- Descripcion
    /*

    */
    -- Declaraciones

    -- Exception handler
    (SELECT A.idActor, CONCAT(A.apellido, ', ', A.nombres) AS Actor, COUNT(ADP.idPelicula) AS Cantidad
     FROM Actores A
              join ActoresDePeliculas ADP on A.idActor = ADP.idActor
     GROUP BY A.idActor, Actor)
    UNION
    (SELECT NULL, NULL, COUNT(*) AS Cantidad
     FROM ActoresDePeliculas ADP)
    ORDER BY (Actor is null ), Actor;


END //


DELIMITER ;

CALL TotalPeliculas();

/*Utilizando triggers, implementar la lógica para que en caso que se quiera modificar una
película especificando el título de otra película existente se informe mediante un mensaje
de error que no se puede. Incluir el código con la modificación del título de una película con
un valor distinto a cualquiera de las que ya hubiera definidas y otro con un valor igual a otra
que ya hubiera definida.**/

DROP TRIGGER IF EXISTS Peliculas_before_update;
DELIMITER //
CREATE TRIGGER Peliculas_before_update
    BEFORE UPDATE
    ON Peliculas
    FOR EACH ROW
BEGIN

    IF EXISTS(SELECT Peliculas.idPelicula FROM Peliculas WHERE Peliculas.titulo = NEW.titulo AND Peliculas.idPelicula !=NEW.idPelicula) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error el titulo ya existe';
    END IF;
END //

DELIMITER ;

select *
from Peliculas;

update Peliculas
set clasificacion = 'PG'
where idPelicula=2;