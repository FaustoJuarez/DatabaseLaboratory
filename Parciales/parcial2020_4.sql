-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Parcial2020_4
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `Parcial2020_4` ;

-- -----------------------------------------------------
-- Schema Parcial2020_4
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Parcial2020_4` DEFAULT CHARACTER SET utf8 ;
USE `Parcial2020_4` ;

-- -----------------------------------------------------
-- Table `Parcial2020_4`.`Escuelas`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Parcial2020_4`.`Escuelas` ;

CREATE TABLE IF NOT EXISTS `Parcial2020_4`.`Escuelas` (
  `idEscuela` INT NOT NULL,
  `codigo` VARCHAR(10) NOT NULL,
  `nombre` VARCHAR(100) NOT NULL,
  `domicilio` VARCHAR(70) NOT NULL,
  `tipo` VARCHAR(10) NOT NULL CHECK(`tipo` IN ('Pública','Privada')),
  PRIMARY KEY (`idEscuela`))
ENGINE = InnoDB;

CREATE UNIQUE INDEX `codigo_UNIQUE` ON `Parcial2020_4`.`Escuelas` (`codigo` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `Parcial2020_4`.`Etapas`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Parcial2020_4`.`Etapas` ;

CREATE TABLE IF NOT EXISTS `Parcial2020_4`.`Etapas` (
  `idEtapas` INT NOT NULL,
  `nombre` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`idEtapas`))
ENGINE = InnoDB;

CREATE UNIQUE INDEX `nombre_UNIQUE` ON `Parcial2020_4`.`Etapas` (`nombre` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `Parcial2020_4`.`Curricula`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Parcial2020_4`.`Curricula` ;

CREATE TABLE IF NOT EXISTS `Parcial2020_4`.`Curricula` (
  `idCurricula` INT NOT NULL,
  `nombre` VARCHAR(70) NOT NULL,
  `desde` DATE NOT NULL,
  `hasta` DATE NULL,
  PRIMARY KEY (`idCurricula`))
ENGINE = InnoDB;

CREATE UNIQUE INDEX `nombre_UNIQUE` ON `Parcial2020_4`.`Curricula` (`nombre` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `Parcial2020_4`.`Asignaturas`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Parcial2020_4`.`Asignaturas` ;

CREATE TABLE IF NOT EXISTS `Parcial2020_4`.`Asignaturas` (
  `codigo` INT NOT NULL,
  `nombre` VARCHAR(30) NOT NULL,
  `tipo` VARCHAR(20) NOT NULL CHECK(`tipo` IN ('Obligatoria','Opcional')),
  PRIMARY KEY (`codigo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Parcial2020_4`.`Propuestas`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Parcial2020_4`.`Propuestas` ;

CREATE TABLE IF NOT EXISTS `Parcial2020_4`.`Propuestas` (
  `idEscuela` INT NOT NULL,
  `idEtapas` INT NOT NULL,
  `idCurricula` INT NOT NULL,
  PRIMARY KEY (`idEscuela`, `idEtapas`, `idCurricula`),
  CONSTRAINT `fk_Escuelas_has_Etapas_Escuelas`
    FOREIGN KEY (`idEscuela`)
    REFERENCES `Parcial2020_4`.`Escuelas` (`idEscuela`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Escuelas_has_Etapas_Etapas1`
    FOREIGN KEY (`idEtapas`)
    REFERENCES `Parcial2020_4`.`Etapas` (`idEtapas`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Escuelas_has_Etapas_Curricula1`
    FOREIGN KEY (`idCurricula`)
    REFERENCES `Parcial2020_4`.`Curricula` (`idCurricula`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Escuelas_has_Etapas_Etapas1_idx` ON `Parcial2020_4`.`Propuestas` (`idEtapas` ASC) VISIBLE;

CREATE INDEX `fk_Escuelas_has_Etapas_Escuelas_idx` ON `Parcial2020_4`.`Propuestas` (`idEscuela` ASC) VISIBLE;

CREATE INDEX `fk_Escuelas_has_Etapas_Curricula1_idx` ON `Parcial2020_4`.`Propuestas` (`idCurricula` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `Parcial2020_4`.`Detalle`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Parcial2020_4`.`Detalle` ;

CREATE TABLE IF NOT EXISTS `Parcial2020_4`.`Detalle` (
  `idCurricula` INT NOT NULL,
  `codigo` INT NOT NULL,
  `carga` INT NOT NULL,
  PRIMARY KEY (`idCurricula`, `codigo`),
  CONSTRAINT `fk_Curricula_has_Asignaturas_Curricula1`
    FOREIGN KEY (`idCurricula`)
    REFERENCES `Parcial2020_4`.`Curricula` (`idCurricula`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Curricula_has_Asignaturas_Asignaturas1`
    FOREIGN KEY (`codigo`)
    REFERENCES `Parcial2020_4`.`Asignaturas` (`codigo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Curricula_has_Asignaturas_Asignaturas1_idx` ON `Parcial2020_4`.`Detalle` (`codigo` ASC) VISIBLE;

CREATE INDEX `fk_Curricula_has_Asignaturas_Curricula1_idx` ON `Parcial2020_4`.`Detalle` (`idCurricula` ASC) VISIBLE;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

INSERT INTO Escuelas VALUES(54,  '9000062',  'ESC. EL PUESTITO DE ARRIBA',  'Domicilio 54',  'Pública');
INSERT INTO Escuelas VALUES(97,  '9000122',  'ESC. JOSE IGNACIO THAMES',  'Domicilio 97',  'Pública');
INSERT INTO Escuelas VALUES(149,  '9000199',  'ESC. LEOPOLDO LUGONES',  'Domicilio 149',  'Pública');
INSERT INTO Escuelas VALUES(275,  '9000337',  'ESC. OBISPO JOSE EUSEBIO COLOMBRES',  'Domicilio 275',  'Pública');
INSERT INTO Escuelas VALUES(286,  '9000351',  'ESC. NORMAL SUPERIOR EN LENGUAS VIVAS JUAN BAUTISTA ALBERDI',  'Domicilio 286',  'Pública');
INSERT INTO Escuelas VALUES(432,  '9000582',  'ESC. 9 DE JULIO',  'Domicilio 432',  'Pública');
INSERT INTO Escuelas VALUES(504,  '9000689',  'ESC. PATRICIAS ARGENTINAS',  'Domicilio 504',  'Pública');
INSERT INTO Escuelas VALUES(589,  '9000806',  'ESC. REPUBLICA DEL PARAGUAY',  'Domicilio 589',  'Pública');
INSERT INTO Escuelas VALUES(986,  '9000067',  'INST. Privada SAN PABLO APOSTOL',  'Domicilio 986',  'Privada');
INSERT INTO Escuelas VALUES(1013,  '9000426',  'INST. GUILLERMINA LESTON DE GUZMAN',  'Domicilio 1013',  'Privada');
INSERT INTO Escuelas VALUES(1578,  '9000674',  'COL. SAN PATRICIO',  'Domicilio 1578',  'Privada');
INSERT INTO Escuelas VALUES(7602,  '9000003',  'INST. SAN JOSE DE CALASANZ',  'Domicilio 7602',  'Privada');


INSERT INTO Etapas VALUES(1,  'INICIAL');
INSERT INTO Etapas VALUES(2,  'MEDIO');
INSERT INTO Etapas VALUES(3,  'SUPERIOR');
INSERT INTO Etapas VALUES(4,  'EGB I');
INSERT INTO Etapas VALUES(5,  'EGB II');
INSERT INTO Etapas VALUES(6,  'EGB III-7');
INSERT INTO Etapas VALUES(7,  'POLIMODAL');
INSERT INTO Etapas VALUES(9,  'NINGUNO');
INSERT INTO Etapas VALUES(10,  'PRIMARIO');
INSERT INTO Etapas VALUES(16,  'EGB III-89');
INSERT INTO Etapas VALUES(21,  'EGB III');
INSERT INTO Etapas VALUES(23,  'SECUNDARIO');

INSERT INTO Asignaturas VALUES(5,  'ANTROPOLOGIA',  'Obligatoria');
INSERT INTO Asignaturas VALUES(7,  'AGRICULTURA GENERAL',  'Obligatoria');
INSERT INTO Asignaturas VALUES(9,  'HISTORIA',  'Obligatoria');
INSERT INTO Asignaturas VALUES(10,  'ACTIVIDADES PRACTICAS',  'Obligatoria');
INSERT INTO Asignaturas VALUES(11,  'ELECTRICIDAD',  'Opcional');
INSERT INTO Asignaturas VALUES(13,  'PEDAGOGIA',  'Obligatoria');
INSERT INTO Asignaturas VALUES(14,  'DIDACTICA GENERAL',  'Obligatoria');
INSERT INTO Asignaturas VALUES(17,  'GEOGRAFIA',  'Obligatoria');
INSERT INTO Asignaturas VALUES(18,  'GEOGRAFIA I',  'Obligatoria');
INSERT INTO Asignaturas VALUES(19,  'CIENCIAS SOCIALES',  'Obligatoria');
INSERT INTO Asignaturas VALUES(20,  'COMPUTACION',  'Obligatoria');
INSERT INTO Asignaturas VALUES(21,  'LITERATURA',  'Obligatoria');
INSERT INTO Asignaturas VALUES(22,  'BIOLOGIA',  'Obligatoria');
INSERT INTO Asignaturas VALUES(24,  'LENGUA Y LITERATURA',  'Opcional');
INSERT INTO Asignaturas VALUES(25,  'EDUCACION CIVICA',  'Obligatoria');
INSERT INTO Asignaturas VALUES(30,  'SOCIOLOGIA',  'Obligatoria');
INSERT INTO Asignaturas VALUES(38,  'EXPRESION CORPORAL',  'Obligatoria');
INSERT INTO Asignaturas VALUES(42,  'CONTABILIDAD',  'Obligatoria');
INSERT INTO Asignaturas VALUES(43,  'INSTRUCCION CIVICA',  'Obligatoria');
INSERT INTO Asignaturas VALUES(45,  'TECNOLOGIA',  'Obligatoria');
INSERT INTO Asignaturas VALUES(46,  'VETERINARIA',  'Obligatoria');
INSERT INTO Asignaturas VALUES(53,  'MUSICA',  'Obligatoria');
INSERT INTO Asignaturas VALUES(54,  'EDUCACION FISICA',  'Obligatoria');
INSERT INTO Asignaturas VALUES(55,  'INGLES',  'Obligatoria');
INSERT INTO Asignaturas VALUES(57,  'TALLER CONTABLE',  'Obligatoria');
INSERT INTO Asignaturas VALUES(58,  'MATEMATICAS',  'Obligatoria');
INSERT INTO Asignaturas VALUES(59,  'FISICA Y QUIMICA',  'Obligatoria');
INSERT INTO Asignaturas VALUES(60,  'FISICA I',  'Opcional');
INSERT INTO Asignaturas VALUES(61,  'QUIMICA',  'Obligatoria');
INSERT INTO Asignaturas VALUES(65,  'ECONOMIA',  'Obligatoria');
INSERT INTO Asignaturas VALUES(68,  'ORGANIZACION DEL  TRABAJO',  'Obligatoria');
INSERT INTO Asignaturas VALUES(70,  'ADMINISTRACION RURAL',  'Obligatoria');
INSERT INTO Asignaturas VALUES(71,  'HORTICULTURA',  'Obligatoria');
INSERT INTO Asignaturas VALUES(72,  'RELIGION',  'Obligatoria');
INSERT INTO Asignaturas VALUES(74,  'FILOSOFIA',  'Obligatoria');
INSERT INTO Asignaturas VALUES(75,  'PSICOLOGIA',  'Obligatoria');
INSERT INTO Asignaturas VALUES(78,  'ECONOMIA POLITICA',  'Opcional');
INSERT INTO Asignaturas VALUES(79,  'DIBUJO',  'Obligatoria');
INSERT INTO Asignaturas VALUES(80,  'BOTANICA AGRICOLA',  'Obligatoria');
INSERT INTO Asignaturas VALUES(83,  'TEJIDO',  'Obligatoria');
INSERT INTO Asignaturas VALUES(87,  'ALGEBRA',  'Obligatoria');
INSERT INTO Asignaturas VALUES(91,  'FILOSOFIA DE LA EDUCACION',  'Obligatoria');
INSERT INTO Asignaturas VALUES(102,  'SISTEMA EDUCATIVO',  'Obligatoria');
INSERT INTO Asignaturas VALUES(107,  'DIBUJO TECNICO',  'Obligatoria');
INSERT INTO Asignaturas VALUES(109,  'TECNOLOGIA DE LOS MATERIALES',  'Obligatoria');
INSERT INTO Asignaturas VALUES(111,  'TALLER',  'Obligatoria');
INSERT INTO Asignaturas VALUES(117,  'CARPINTERIA',  'Obligatoria');
INSERT INTO Asignaturas VALUES(120,  'PLASTICA',  'Opcional');
INSERT INTO Asignaturas VALUES(128,  'FRANCES',  'Opcional');
INSERT INTO Asignaturas VALUES(129,  'CIENCIAS NATURALES',  'Obligatoria');
INSERT INTO Asignaturas VALUES(132,  'MATEMATICA FINANCIERA',  'Obligatoria');
INSERT INTO Asignaturas VALUES(134,  'QUIMICA ORGANICA',  'Obligatoria');
INSERT INTO Asignaturas VALUES(135,  'FISICA II',  'Obligatoria');
INSERT INTO Asignaturas VALUES(141,  'ELECTRONICA',  'Obligatoria');
INSERT INTO Asignaturas VALUES(142,  'INSTALACIONES INDUSTRIALES',  'Obligatoria');
INSERT INTO Asignaturas VALUES(149,  'INTRODUCCION A LA FILOSOFIA',  'Obligatoria');
INSERT INTO Asignaturas VALUES(152,  'INDUSTRIAS AGRICOLAS',  'Obligatoria');
INSERT INTO Asignaturas VALUES(162,  'FONIATRIA',  'Obligatoria');
INSERT INTO Asignaturas VALUES(163,  'EDUCACION PLASTICA',  'Obligatoria');
INSERT INTO Asignaturas VALUES(165,  'LENGUA',  'Obligatoria');
INSERT INTO Asignaturas VALUES(168,  'AGRICULTURA ESPECIAL',  'Obligatoria');
INSERT INTO Asignaturas VALUES(173,  'SANIDAD VEGETAL',  'Obligatoria');
INSERT INTO Asignaturas VALUES(174,  'LENGUA EXTRANJERA',  'Obligatoria');
INSERT INTO Asignaturas VALUES(180,  'MAQUINARIAS',  'Obligatoria');
INSERT INTO Asignaturas VALUES(181,  'LEGISLACION AGRARIA',  'Obligatoria');
INSERT INTO Asignaturas VALUES(185,  'FISICA BIOLOGICA',  'Obligatoria');
INSERT INTO Asignaturas VALUES(186,  'QUIMICA ORGANICA Y BIOLOGICA',  'Obligatoria');
INSERT INTO Asignaturas VALUES(197,  'GANADERIA',  'Opcional');
INSERT INTO Asignaturas VALUES(203,  'CULTURA MUSICAL',  'Obligatoria');
INSERT INTO Asignaturas VALUES(204,  'RELACIONES HUMANAS',  'Obligatoria');
INSERT INTO Asignaturas VALUES(219,  'DISCURSO Y COMUNICACION',  'Obligatoria');
INSERT INTO Asignaturas VALUES(220,  'ALFABETIZACION',  'Obligatoria');
INSERT INTO Asignaturas VALUES(221,  'COMERCIALIZACION DE GRANOS',  'Obligatoria');
INSERT INTO Asignaturas VALUES(225,  'TALLER RURAL',  'Obligatoria');
INSERT INTO Asignaturas VALUES(226,  'FOLKLORE',  'Obligatoria');
INSERT INTO Asignaturas VALUES(228,  'DERECHO',  'Obligatoria');
INSERT INTO Asignaturas VALUES(230,  'ADMINISTRACION DE EMPRESAS',  'Obligatoria');
INSERT INTO Asignaturas VALUES(240,  'LEGISLACION LABORAL',  'Obligatoria');
INSERT INTO Asignaturas VALUES(242,  'ARBORICULTURA Y FRUTICULTURA',  'Obligatoria');
INSERT INTO Asignaturas VALUES(245,  'EXPLOTACION AVICOLA',  'Obligatoria');
INSERT INTO Asignaturas VALUES(268,  'HIGIENE Y SEGURIDAD LABORAL',  'Obligatoria');
INSERT INTO Asignaturas VALUES(269,  'QUIMICA AGRICOLA',  'Obligatoria');
INSERT INTO Asignaturas VALUES(283,  'ARQUITECTURA',  'Obligatoria');
INSERT INTO Asignaturas VALUES(292,  'CIENCIAS BIOLOGICAS',  'Obligatoria');
INSERT INTO Asignaturas VALUES(302,  'LENCERIA',  'Obligatoria');
INSERT INTO Asignaturas VALUES(305,  'FONOAUDIOLOGIA',  'Obligatoria');
INSERT INTO Asignaturas VALUES(310,  'LEGISLACION IMPOSITIVA',  'Obligatoria');
INSERT INTO Asignaturas VALUES(331,  'EXPLOTACION GANADERA',  'Obligatoria');
INSERT INTO Asignaturas VALUES(338,  'DERECHO ADMINISTRATIVO',  'Opcional');
INSERT INTO Asignaturas VALUES(363,  'CONSTRUCCIONES',  'Obligatoria');
INSERT INTO Asignaturas VALUES(367,  'INDUSTRIAS DE LA GRANJA',  'Obligatoria');
INSERT INTO Asignaturas VALUES(375,  'PRACTICA ADMINISTRATIVA',  'Obligatoria');
INSERT INTO Asignaturas VALUES(401,  'TECNOLOGIA DE FABRICACION',  'Obligatoria');
INSERT INTO Asignaturas VALUES(408,  'PROBLEMATICA EDUCATIVA',  'Opcional');
INSERT INTO Asignaturas VALUES(413,  'ETICA',  'Obligatoria');
INSERT INTO Asignaturas VALUES(447,  'CIENCIAS  EXACTAS Y NATURALES',  'Obligatoria');
INSERT INTO Asignaturas VALUES(454,  'SOCIOLOGIA DE LA EDUCACION',  'Obligatoria');
INSERT INTO Asignaturas VALUES(473,  'TURISMO',  'Obligatoria');
INSERT INTO Asignaturas VALUES(487,  'INFORMATICA',  'Obligatoria');
INSERT INTO Asignaturas VALUES(492,  'LABORATORIO DE COMPUTACION',  'Obligatoria');
INSERT INTO Asignaturas VALUES(493,  'PROGRAMACION',  'Obligatoria');
INSERT INTO Asignaturas VALUES(494,  'PSICOLOGIA GENERAL I',  'Obligatoria');
INSERT INTO Asignaturas VALUES(506,  'COORDINADOR',  'Obligatoria');
INSERT INTO Asignaturas VALUES(514,  'LENGUA Y SU DIDACTICA',  'Obligatoria');
INSERT INTO Asignaturas VALUES(573,  'COORDINADOR DE RESIDENCIA',  'Obligatoria');
INSERT INTO Asignaturas VALUES(593,  'FINANZAS',  'Obligatoria');
INSERT INTO Asignaturas VALUES(601,  'ECONOMIA Y CONTABILIDAD',  'Obligatoria');
INSERT INTO Asignaturas VALUES(609,  'MOTORES DE COMBUSTION INTERNA',  'Obligatoria');
INSERT INTO Asignaturas VALUES(613,  'TALLER DE PRACTICA PROFESIONAL',  'Obligatoria');
INSERT INTO Asignaturas VALUES(626,  'TALLER DE INFORMATICA ',  'Obligatoria');
INSERT INTO Asignaturas VALUES(635,  'PLASTICA Y SU DIDACTICA',  'Obligatoria');
INSERT INTO Asignaturas VALUES(643,  'EDUCACION ARTISTICA',  'Obligatoria');
INSERT INTO Asignaturas VALUES(651,  'SISTEMA ADMINISTRATIVO',  'Obligatoria');
INSERT INTO Asignaturas VALUES(663,  'GEOGRAFIA AMBIENTAL I',  'Obligatoria');
INSERT INTO Asignaturas VALUES(666,  'TUTORIA',  'Opcional');
INSERT INTO Asignaturas VALUES(667,  'APOYO',  'Obligatoria');
INSERT INTO Asignaturas VALUES(672,  'MATEMATICA Y SU DIDACTICA',  'Obligatoria');
INSERT INTO Asignaturas VALUES(681,  'PROYECTO II',  'Obligatoria');
INSERT INTO Asignaturas VALUES(684,  'DIDACTICA Y CURRICULUM',  'Obligatoria');
INSERT INTO Asignaturas VALUES(687,  'TECNOLOGIA RURAL II',  'Opcional');
INSERT INTO Asignaturas VALUES(694,  'LAS BASES DE LA BIODIVERSIDAD',  'Obligatoria');
INSERT INTO Asignaturas VALUES(695,  'INVESTIGACION',  'Obligatoria');
INSERT INTO Asignaturas VALUES(700,  'TALLER ESPACIO Y TIEMPO LIBRE',  'Obligatoria');
INSERT INTO Asignaturas VALUES(720,  'TECNOLOGIA Y SU DIDACTICA',  'Obligatoria');
INSERT INTO Asignaturas VALUES(721,  'COORDINACION',  'Obligatoria');
INSERT INTO Asignaturas VALUES(725,  'TECNOLOGIA RURAL III',  'Obligatoria');
INSERT INTO Asignaturas VALUES(732,  'GEOGRAFIA ARGENTINA',  'Obligatoria');
INSERT INTO Asignaturas VALUES(736,  'TOPOGRAFIA RURAL',  'Obligatoria');
INSERT INTO Asignaturas VALUES(739,  'EDUCACION MUSICAL',  'Obligatoria');
INSERT INTO Asignaturas VALUES(748,  'PROBLEMATICA PEDAGOGICA',  'Obligatoria');
INSERT INTO Asignaturas VALUES(756,  'TECNICAS Y PRACTICAS CONTABLES',  'Obligatoria');
INSERT INTO Asignaturas VALUES(760,  'PALEONTOLOGIA',  'Obligatoria');
INSERT INTO Asignaturas VALUES(764,  'FUNDAMENTO DE LA GEOLOGIA',  'Obligatoria');
INSERT INTO Asignaturas VALUES(768,  'MATEMATICA I',  'Obligatoria');
INSERT INTO Asignaturas VALUES(769,  'MATEMATICA II',  'Obligatoria');
INSERT INTO Asignaturas VALUES(770,  'CIENCIAS DE LA EDUCACION',  'Obligatoria');
INSERT INTO Asignaturas VALUES(772,  'FUNDAMENTOS DE ECONOMIA',  'Obligatoria');
INSERT INTO Asignaturas VALUES(775,  'FORMACION ESTETICA PLASTICA',  'Obligatoria');
INSERT INTO Asignaturas VALUES(783,  'DEPARTAMENTO DE CAPACITACION',  'Obligatoria');
INSERT INTO Asignaturas VALUES(784,  'DEPARTAMENTO DE INVESTIGACION',  'Opcional');
INSERT INTO Asignaturas VALUES(785,  'MARKETING I',  'Obligatoria');
INSERT INTO Asignaturas VALUES(789,  'ELEMENTOS DE MAQUINAS',  'Obligatoria');
INSERT INTO Asignaturas VALUES(801,  'GEOGRAFIA II',  'Obligatoria');
INSERT INTO Asignaturas VALUES(809,  'TALLER DE FORMACION DOCENTE I',  'Obligatoria');
INSERT INTO Asignaturas VALUES(810,  'TALLER DE FORMACION DOCENTE II',  'Obligatoria');
INSERT INTO Asignaturas VALUES(814,  'INSTITUCION EDUCATIVA',  'Obligatoria');
INSERT INTO Asignaturas VALUES(818,  'RESIDENCIA DOCENTE',  'Obligatoria');
INSERT INTO Asignaturas VALUES(823,  'CIENCIAS DEL LENGUAJE',  'Obligatoria');
INSERT INTO Asignaturas VALUES(826,  'ORGANIZACION INDUST. I',  'Obligatoria');
INSERT INTO Asignaturas VALUES(827,  'ESTUDIOS SOCIALES',  'Obligatoria');
INSERT INTO Asignaturas VALUES(832,  'INVESTIGACION EDUCATIVA',  'Obligatoria');
INSERT INTO Asignaturas VALUES(836,  'GEOGRAFIA ECONOMICA',  'Obligatoria');
INSERT INTO Asignaturas VALUES(849,  'PROGRAMA DE INVESTIGACION',  'Obligatoria');
INSERT INTO Asignaturas VALUES(853,  'CONSTRUCCIONES RURALES',  'Obligatoria');
INSERT INTO Asignaturas VALUES(855,  'ARTES REGIONALES',  'Obligatoria');
INSERT INTO Asignaturas VALUES(857,  'PLASTICA VISUAL',  'Obligatoria');
INSERT INTO Asignaturas VALUES(859,  'EDUCACION ARTISTICA MUSICA',  'Obligatoria');
INSERT INTO Asignaturas VALUES(864,  'FILOSOFIA Y PSICOLOGIA',  'Obligatoria');
INSERT INTO Asignaturas VALUES(866,  'FORMACION ESTETICA MUSICAL',  'Obligatoria');
INSERT INTO Asignaturas VALUES(868,  'ESTRATEGIAS DIDACTICAS',  'Obligatoria');
INSERT INTO Asignaturas VALUES(870,  'TALLER HUERTA Y JARDINERIA',  'Obligatoria');
INSERT INTO Asignaturas VALUES(896,  'ALFABETIZACION INICIAL',  'Obligatoria');
INSERT INTO Asignaturas VALUES(924,  'FORMACION ETICA Y SU DIDACTICA',  'Opcional');
INSERT INTO Asignaturas VALUES(929,  'LABORATORIO',  'Obligatoria');
INSERT INTO Asignaturas VALUES(940,  'ESPACIO INSTITUCIONAL',  'Obligatoria');
INSERT INTO Asignaturas VALUES(950,  'PROGRAMACION III',  'Obligatoria');
INSERT INTO Asignaturas VALUES(951,  'ANALISIS DE SISTEMA',  'Obligatoria');
INSERT INTO Asignaturas VALUES(952,  'SIMULACION',  'Obligatoria');
INSERT INTO Asignaturas VALUES(961,  'GABINETE SICOPEDAGOGICO',  'Obligatoria');
INSERT INTO Asignaturas VALUES(981,  'TALLER DE PERCUSION',  'Obligatoria');
INSERT INTO Asignaturas VALUES(983,  'CONTABILIDAD DE COSTOS',  'Obligatoria');
INSERT INTO Asignaturas VALUES(989,  'PRACTICAS PROFESIONALES',  'Obligatoria');
INSERT INTO Asignaturas VALUES(1009,  'HISTORIA ARGENTINA',  'Obligatoria');
INSERT INTO Asignaturas VALUES(1014,  'TORNERIA',  'Obligatoria');
INSERT INTO Asignaturas VALUES(1025,  'INTERPRETACION DE BALANCE',  'Obligatoria');
INSERT INTO Asignaturas VALUES(1026,  'INVESTIGACION DE MERCADO',  'Obligatoria');
INSERT INTO Asignaturas VALUES(1029,  'PRACTICA CONTABLE',  'Obligatoria');
INSERT INTO Asignaturas VALUES(1042,  'TECNICAS BCARIAS Y SEGUROS',  'Obligatoria');
INSERT INTO Asignaturas VALUES(1047,  'INGLES TECNICO',  'Obligatoria');
INSERT INTO Asignaturas VALUES(1049,  'NOCIONES DE AUDITORIA',  'Obligatoria');
INSERT INTO Asignaturas VALUES(1050,  'CESTOBALL',  'Opcional');
INSERT INTO Asignaturas VALUES(1055,  'MUSICA EN EL NIVEL INICIAL',  'Obligatoria');
INSERT INTO Asignaturas VALUES(1077,  'HORAS INSTITUCIONALES',  'Obligatoria');
INSERT INTO Asignaturas VALUES(1081,  'SUJETO DESARROLLO Y CULTURA',  'Obligatoria');
INSERT INTO Asignaturas VALUES(1084,  'BIOLOGIA II',  'Obligatoria');
INSERT INTO Asignaturas VALUES(1101,  'CAPACITACION',  'Obligatoria');
INSERT INTO Asignaturas VALUES(1104,  'TALLER DE PERIODISMO',  'Obligatoria');
INSERT INTO Asignaturas VALUES(1113,  'BIOGEOGRAFIA',  'Obligatoria');
INSERT INTO Asignaturas VALUES(1126,  'EDUCACION TECNOLOGICA',  'Obligatoria');
INSERT INTO Asignaturas VALUES(1136,  'DISEÑO GRAFICO',  'Obligatoria');
INSERT INTO Asignaturas VALUES(1152,  'CIENCIAS',  'Obligatoria');
INSERT INTO Asignaturas VALUES(1155,  'LOCUCION',  'Obligatoria');
INSERT INTO Asignaturas VALUES(1160,  'ORGANIZACION Y EMPRESA',  'Obligatoria');
INSERT INTO Asignaturas VALUES(1177,  'GEOGRAFIA POLITICA',  'Obligatoria');
INSERT INTO Asignaturas VALUES(1180,  'CONTRABAJO',  'Obligatoria');
INSERT INTO Asignaturas VALUES(1181,  'QUIMICA INORGANICA',  'Obligatoria');
INSERT INTO Asignaturas VALUES(1184,  'HISTORIA DE LA CULTURA',  'Obligatoria');
INSERT INTO Asignaturas VALUES(1185,  'MATEMATICA TECNICA',  'Obligatoria');
INSERT INTO Asignaturas VALUES(1187,  'FORMACION ETICA Y CIUDADANA',  'Obligatoria');
INSERT INTO Asignaturas VALUES(1209,  'GEOGRAFIA DE AMERICA',  'Obligatoria');
INSERT INTO Asignaturas VALUES(1214,  'AUDITORIA Y CONTROL',  'Obligatoria');
INSERT INTO Asignaturas VALUES(1248,  'MATEMATICA III',  'Obligatoria');
INSERT INTO Asignaturas VALUES(1270,  'PSICOLOGIA EDUCACIONAL',  'Obligatoria');
INSERT INTO Asignaturas VALUES(1272,  'APICULTURA',  'Obligatoria');
INSERT INTO Asignaturas VALUES(1277,  'PROYECTO',  'Opcional');
INSERT INTO Asignaturas VALUES(1281,  'FORMACION ETICA',  'Obligatoria');
INSERT INTO Asignaturas VALUES(1285,  'CIRCUITOS TURISTICOS',  'Obligatoria');
INSERT INTO Asignaturas VALUES(1299,  'JEFE DE DPTO',  'Obligatoria');
INSERT INTO Asignaturas VALUES(1304,  'EDUCACION ETICA Y CIUDADANA',  'Obligatoria');
INSERT INTO Asignaturas VALUES(1309,  'TECNICA DE COMUNICACION',  'Obligatoria');
INSERT INTO Asignaturas VALUES(1311,  'HISTORIA DEL TUCUMAN',  'Obligatoria');
INSERT INTO Asignaturas VALUES(1317,  'MICROEMPRENDIMIENTO',  'Obligatoria');
INSERT INTO Asignaturas VALUES(1324,  'DISCURSO PEDAGOGICO',  'Obligatoria');
INSERT INTO Asignaturas VALUES(1349,  'PRACTICA PROFESIONAL',  'Obligatoria');
INSERT INTO Asignaturas VALUES(1353,  'TELECOMUNICACIONES',  'Obligatoria');
INSERT INTO Asignaturas VALUES(1373,  'LABORATORIO DE CS NATURALES',  'Obligatoria');
INSERT INTO Asignaturas VALUES(1392,  'DIDACTICA DE LA LENGUA',  'Obligatoria');
INSERT INTO Asignaturas VALUES(1424,  'ORG. INDUSTRIAL Y REL. HUMANAS',  'Obligatoria');
INSERT INTO Asignaturas VALUES(1425,  'DISEÑO',  'Obligatoria');
INSERT INTO Asignaturas VALUES(1440,  'RECREACION',  'Obligatoria');
INSERT INTO Asignaturas VALUES(1450,  'TALLER OPTATIVO I',  'Obligatoria');
INSERT INTO Asignaturas VALUES(1451,  'TALLER OPTATIVO II',  'Obligatoria');
INSERT INTO Asignaturas VALUES(1486,  'TALLER DE HUERTA',  'Obligatoria');
INSERT INTO Asignaturas VALUES(1488,  'INFORMATICA APLICADA',  'Opcional');
INSERT INTO Asignaturas VALUES(1504,  'PRACTICAS DOCENTES EN LENGUA',  'Obligatoria');
INSERT INTO Asignaturas VALUES(1512,  'DIDACTICA ESPECIAL II',  'Obligatoria');
INSERT INTO Asignaturas VALUES(1535,  'EDUCACION PSICOMOTRIZ',  'Obligatoria');
INSERT INTO Asignaturas VALUES(1561,  'FISICA',  'Obligatoria');
INSERT INTO Asignaturas VALUES(1612,  'ANTROPOLOGIA CULTURAL',  'Obligatoria');
INSERT INTO Asignaturas VALUES(1620,  'FUNDAMENTOS DE QUIMICA',  'Obligatoria');
INSERT INTO Asignaturas VALUES(1621,  'BIOLOGIA MOLECULAR Y CELULAR',  'Obligatoria');
INSERT INTO Asignaturas VALUES(1622,  'QUIMICA BIOLOGICA',  'Obligatoria');
INSERT INTO Asignaturas VALUES(1624,  'ETICA APLICADA A LA BIOLOGIA',  'Obligatoria');
INSERT INTO Asignaturas VALUES(1625,  'BIOTECNOLOGIA',  'Obligatoria');
INSERT INTO Asignaturas VALUES(1626,  'BIODIVERSIDAD ANIMAL I',  'Obligatoria');
INSERT INTO Asignaturas VALUES(1627,  'BIODIVERSIDAD ANIMAL II',  'Obligatoria');
INSERT INTO Asignaturas VALUES(1628,  'BIODIVERSIDAD VEGETAL II',  'Obligatoria');
INSERT INTO Asignaturas VALUES(1629,  'BIODIVERSIDAD VEGETAL I',  'Obligatoria');
INSERT INTO Asignaturas VALUES(1630,  'ANATOMIA Y FISIOLOGIA HUMANAS',  'Obligatoria');
INSERT INTO Asignaturas VALUES(1631,  'GENETICA',  'Obligatoria');
INSERT INTO Asignaturas VALUES(1632,  'SALUD HUMANA',  'Obligatoria');
INSERT INTO Asignaturas VALUES(1633,  'ETOLOGIA',  'Obligatoria');
INSERT INTO Asignaturas VALUES(1647,  'GEOGRAFIA AMBIENTAL II',  'Obligatoria');
INSERT INTO Asignaturas VALUES(1648,  'GEOGRAFIA HUMANA',  'Obligatoria');
INSERT INTO Asignaturas VALUES(1650,  'GEOGRAFIA DE TUCUMAN',  'Opcional');
INSERT INTO Asignaturas VALUES(1655,  'ESPACIO OPTATIVO',  'Obligatoria');
INSERT INTO Asignaturas VALUES(1678,  'ECONOMIA I',  'Obligatoria');
INSERT INTO Asignaturas VALUES(1680,  'ECONOMIA II',  'Obligatoria');
INSERT INTO Asignaturas VALUES(1688,  'INDUSTRIAS I',  'Obligatoria');
INSERT INTO Asignaturas VALUES(1697,  'TECNOLOGIA GENERAL',  'Obligatoria');
INSERT INTO Asignaturas VALUES(1699,  'TECNOLOGIA DE GESTION',  'Obligatoria');
INSERT INTO Asignaturas VALUES(1701,  'COMUNICACION',  'Obligatoria');
INSERT INTO Asignaturas VALUES(1704,  'IMAGENES Y CONTEXTOS',  'Obligatoria');
INSERT INTO Asignaturas VALUES(1705,  'INDUSTRIA CULTURAL I',  'Obligatoria');
INSERT INTO Asignaturas VALUES(1706,  'INDUSTRIA CULTURAL II',  'Obligatoria');
INSERT INTO Asignaturas VALUES(1708,  'LENGUAJE MULTIMEDIAL',  'Obligatoria');
INSERT INTO Asignaturas VALUES(1711,  'LENGUAS Y CULTURA GLOBAL',  'Obligatoria');
INSERT INTO Asignaturas VALUES(1712,  'CIENCIAS POLITICAS',  'Obligatoria');
INSERT INTO Asignaturas VALUES(1713,  'OPINION PUBLICA',  'Obligatoria');
INSERT INTO Asignaturas VALUES(1714,  'CULTURA',  'Opcional');
INSERT INTO Asignaturas VALUES(1715,  'PROCESOS PRODUCTIVOS',  'Obligatoria');
INSERT INTO Asignaturas VALUES(1716,  'TECNOLOGIA DE CONTROL',  'Obligatoria');
INSERT INTO Asignaturas VALUES(1717,  'PRODUCCION DE SERVICIOS',  'Obligatoria');
INSERT INTO Asignaturas VALUES(1719,  'INSTRUMENTACION Y CONTROL',  'Obligatoria');
INSERT INTO Asignaturas VALUES(1720,  'PROYECTO TECNOLOGICO',  'Obligatoria');
INSERT INTO Asignaturas VALUES(1721,  'PRODUCCION  Y MARKETING',  'Obligatoria');
INSERT INTO Asignaturas VALUES(1724,  'FISICA ECOLOGICA',  'Obligatoria');
INSERT INTO Asignaturas VALUES(1725,  'MATEMATICA APLICADA',  'Obligatoria');
INSERT INTO Asignaturas VALUES(1726,  'PROYECTO DE INVESTIGACION',  'Obligatoria');
INSERT INTO Asignaturas VALUES(1728,  'BIOLOGIA APLICADA',  'Obligatoria');
INSERT INTO Asignaturas VALUES(1729,  'BIOQUIMICA',  'Obligatoria');
INSERT INTO Asignaturas VALUES(1730,  'BIOFISICA',  'Obligatoria');
INSERT INTO Asignaturas VALUES(1731,  'SALUD',  'Obligatoria');
INSERT INTO Asignaturas VALUES(1732,  'PROCESOS EDUCATIVOS ESCOLARES',  'Obligatoria');
INSERT INTO Asignaturas VALUES(1733,  'SISTEMAS DE INFORMACION',  'Obligatoria');
INSERT INTO Asignaturas VALUES(1734,  'DERECHO ECONOMICO',  'Obligatoria');
INSERT INTO Asignaturas VALUES(1736,  'ARTE Y SOCIEDAD',  'Obligatoria');
INSERT INTO Asignaturas VALUES(1745,  'EDI II',  'Obligatoria');
INSERT INTO Asignaturas VALUES(1747,  'CIENCIAS Y TECNOLOGIA',  'Obligatoria');
INSERT INTO Asignaturas VALUES(1749,  'LAB. DE GESTION ECONOMICA II',  'Opcional');
INSERT INTO Asignaturas VALUES(1757,  'FUNCION SUJETO ED. FISICA',  'Obligatoria');
INSERT INTO Asignaturas VALUES(1760,  'AD. PERS. Y P. LAB.',  'Obligatoria');
INSERT INTO Asignaturas VALUES(1761,  'MERC. QCA',  'Obligatoria');
INSERT INTO Asignaturas VALUES(1762,  'PRACTICA DOCENTE EN MATEMATICA',  'Obligatoria');
INSERT INTO Asignaturas VALUES(1764,  'EDI - PROBLEMAS DE APRENDIZAJE',  'Obligatoria');
INSERT INTO Asignaturas VALUES(1765,  'INFORMATICA EDUCATIVA',  'Obligatoria');
INSERT INTO Asignaturas VALUES(1766,  'RECURSOS DIDACTICOS',  'Obligatoria');
INSERT INTO Asignaturas VALUES(1767,  'CAPACITACION E INVESTIGACION',  'Obligatoria');
INSERT INTO Asignaturas VALUES(1768,  'CONVENIO INTER - INSTITUCIONAL',  'Obligatoria');
INSERT INTO Asignaturas VALUES(1769,  'PROCESOS AGROPECUARIOS',  'Obligatoria');
INSERT INTO Asignaturas VALUES(1771,  'LENGUA EXTRANJERA III',  'Obligatoria');
INSERT INTO Asignaturas VALUES(1773,  'EDI- ANTROPOLOGIA PRACTICA',  'Obligatoria');
INSERT INTO Asignaturas VALUES(1775,  'EDI-INGLES TECNICO',  'Obligatoria');
INSERT INTO Asignaturas VALUES(1776,  'RESIDENCIA DOCENTE EN EGB3',  'Obligatoria');
INSERT INTO Asignaturas VALUES(1781,  'AUXILIAR DE RESIDENCIA DOCENTE',  'Obligatoria');
INSERT INTO Asignaturas VALUES(1796,  'TALLER RURAL II',  'Obligatoria');
INSERT INTO Asignaturas VALUES(1797,  'PRODUCCION DE FRUTALES',  'Obligatoria');
INSERT INTO Asignaturas VALUES(1799,  'GRANJA FAMILIAR II',  'Obligatoria');
INSERT INTO Asignaturas VALUES(1800,  'PROMOCION',  'Obligatoria');
INSERT INTO Asignaturas VALUES(1801,  'GESTION DE VENTAS',  'Obligatoria');
INSERT INTO Asignaturas VALUES(1802,  'COMERCIALIZACION DE SERVICIOS',  'Opcional');
INSERT INTO Asignaturas VALUES(1803,  'DESARROLLO DE LOCALIDADES',  'Obligatoria');
INSERT INTO Asignaturas VALUES(1804,  'INTERPRETACION',  'Obligatoria');
INSERT INTO Asignaturas VALUES(1805,  'TECNOLOGIA DE LA INFORMACION',  'Obligatoria');
INSERT INTO Asignaturas VALUES(1806,  'ORGANIZACION Y GESTION',  'Obligatoria');
INSERT INTO Asignaturas VALUES(1807,  'MODULO INDUSTRIAS LACTEAS',  'Obligatoria');
INSERT INTO Asignaturas VALUES(1808,  'MODULO DE FLORICULTURA',  'Obligatoria');
INSERT INTO Asignaturas VALUES(1809,  'MODULO DE APICULTURA',  'Obligatoria');
INSERT INTO Asignaturas VALUES(1812,  'PROYECTO PRODUCTIVO',  'Obligatoria');
INSERT INTO Asignaturas VALUES(1813,  'SERVICIOS PROMOCIONALES',  'Obligatoria');
INSERT INTO Asignaturas VALUES(1814,  'SERVICIOS DE RECREACION',  'Obligatoria');
INSERT INTO Asignaturas VALUES(1815,  'FILOSOFIA/PSICOLOGIA',  'Obligatoria');
INSERT INTO Asignaturas VALUES(1817,  'TALLER RURAL III',  'Obligatoria');
INSERT INTO Asignaturas VALUES(1821,  'TURISMO II',  'Obligatoria');
INSERT INTO Asignaturas VALUES(1822,  'INSTALACIONES AGROPECUARIAS',  'Obligatoria');
INSERT INTO Asignaturas VALUES(1824,  'PRODUCCION DE HORTALIZAS',  'Opcional');
INSERT INTO Asignaturas VALUES(1825,  'PRODUCCION DE FORRAJE',  'Obligatoria');
INSERT INTO Asignaturas VALUES(1826,  'CIENCIAS NATURALES APLICADA',  'Obligatoria');
INSERT INTO Asignaturas VALUES(1828,  'LENGUAJES CREATIVOS',  'Obligatoria');
INSERT INTO Asignaturas VALUES(1829,  'MAQUINARIA Y EQUIPOS AGRICOLAS',  'Obligatoria');
INSERT INTO Asignaturas VALUES(1830,  'MANEJO DE LA EMPRESA',  'Obligatoria');
INSERT INTO Asignaturas VALUES(1834,  'PRODUCCION DE AVES',  'Obligatoria');
INSERT INTO Asignaturas VALUES(1837,  'MATERIALES Y ENSAYO',  'Obligatoria');
INSERT INTO Asignaturas VALUES(1840,  'ELEM MAQ Y MONT EQ E INST',  'Obligatoria');
INSERT INTO Asignaturas VALUES(1841,  'ADM.Y GTION DE RRHH',  'Obligatoria');
INSERT INTO Asignaturas VALUES(1842,  'GESTION DE CLIENTES',  'Obligatoria');
INSERT INTO Asignaturas VALUES(1843,  'LIQ. Y REG. DE REMUNERAC',  'Obligatoria');
INSERT INTO Asignaturas VALUES(1844,  'LIQ Y REG DE REMUNERAC',  'Obligatoria');
INSERT INTO Asignaturas VALUES(1845,  'PROG. CPRES. Y VENTAS',  'Obligatoria');
INSERT INTO Asignaturas VALUES(1848,  'EDI- OPINION PUBLICA',  'Obligatoria');
INSERT INTO Asignaturas VALUES(1849,  'EDI-TECNICAS DE ESTUDIO',  'Obligatoria');
INSERT INTO Asignaturas VALUES(1850,  'EDI-COMUNICACIONES INST.',  'Obligatoria');
INSERT INTO Asignaturas VALUES(1852,  'EDI-CESTOBALL',  'Obligatoria');
INSERT INTO Asignaturas VALUES(1854,  'OCC-GASTRONOMIA',  'Obligatoria');
INSERT INTO Asignaturas VALUES(1855,  'OCC-ARTESANIAS',  'Obligatoria');
INSERT INTO Asignaturas VALUES(1857,  'OCC-IND DE LA VEST',  'Obligatoria');
INSERT INTO Asignaturas VALUES(1858,  'OCC-CALZADO ARTESANAL',  'Opcional');
INSERT INTO Asignaturas VALUES(1859,  'LENGUA Y LITERATURA I',  'Obligatoria');
INSERT INTO Asignaturas VALUES(1860,  'LENGUA Y LITERATURA II',  'Obligatoria');
INSERT INTO Asignaturas VALUES(1861,  'EDUCACION FISICA I',  'Obligatoria');
INSERT INTO Asignaturas VALUES(1862,  'EDUCACION FISICA II',  'Obligatoria');
INSERT INTO Asignaturas VALUES(1863,  'CULTURA Y ESTETICA',  'Obligatoria');
INSERT INTO Asignaturas VALUES(1865,  'PSICOLOGIA Y SOCIOLOGIA',  'Obligatoria');
INSERT INTO Asignaturas VALUES(1866,  'PROFESOR ASISTENTE',  'Obligatoria');
INSERT INTO Asignaturas VALUES(1867,  'TRASTORNOS DEL LENGUAJE',  'Obligatoria');
INSERT INTO Asignaturas VALUES(1868,  'TALLER DE TECNOLOGIA EDUCATIVA',  'Obligatoria');
INSERT INTO Asignaturas VALUES(1869,  'PROBLEMATICA SOCIO CULTURAL',  'Obligatoria');
INSERT INTO Asignaturas VALUES(1871,  'RESOLUCION DE PROBLEMAS',  'Obligatoria');
INSERT INTO Asignaturas VALUES(1872,  'LA FUNCION DEL EGB 1 Y 2',  'Obligatoria');
INSERT INTO Asignaturas VALUES(1873,  'RECURSOS EN EL AULA',  'Obligatoria');
INSERT INTO Asignaturas VALUES(1879,  'COORDINADORA DE CARRERA',  'Obligatoria');
INSERT INTO Asignaturas VALUES(1883,  'ECOLOGIA',  'Obligatoria');
INSERT INTO Asignaturas VALUES(1891,  'PROF ASISTENTE RESID',  'Obligatoria');
INSERT INTO Asignaturas VALUES(1894,  'PROB. AMB. ESC. NAC. Y MUND.',  'Obligatoria');
INSERT INTO Asignaturas VALUES(1895,  'PRINC. PRAC HISTORIA TUCUMAN',  'Obligatoria');
INSERT INTO Asignaturas VALUES(1896,  'INV. DE PROB. ENS. AP. GEOG',  'Obligatoria');
INSERT INTO Asignaturas VALUES(1897,  'PRAB. DE G. URB. ESC. NAC. M.',  'Obligatoria');
INSERT INTO Asignaturas VALUES(1898,  'DIDACTICA ESPECIAL I P/EGB3',  'Opcional');
INSERT INTO Asignaturas VALUES(1923,  'PRODUCCION DE FORESTAL',  'Obligatoria');
INSERT INTO Asignaturas VALUES(1924,  'PRODUCCION DE CAÑA DE AZUCAR',  'Obligatoria');
INSERT INTO Asignaturas VALUES(1925,  'PRODUCCION DE CERDOS',  'Obligatoria');
INSERT INTO Asignaturas VALUES(1926,  'RIEGO Y DRENAJE',  'Obligatoria');
INSERT INTO Asignaturas VALUES(1933,  'TALLER DE ORALIDAD',  'Obligatoria');
INSERT INTO Asignaturas VALUES(1935,  'OPERACIONES DE COMPRA Y VENTA',  'Obligatoria');
INSERT INTO Asignaturas VALUES(1936,  'TALLER PIIE',  'Obligatoria');
INSERT INTO Asignaturas VALUES(1938,  'ORIENTACION EN MANTENIMIENTO',  'Obligatoria');
INSERT INTO Asignaturas VALUES(1940,  'INTEGRACION',  'Obligatoria');
INSERT INTO Asignaturas VALUES(1941,  'TECNOLOGIA/INFORMATICA',  'Obligatoria');
INSERT INTO Asignaturas VALUES(1949,  'TEC. REPRES. E INT. DE PLANOS',  'Obligatoria');
INSERT INTO Asignaturas VALUES(1952,  'EDI INFORMATICA CONTABLE',  'Obligatoria');
INSERT INTO Asignaturas VALUES(1953,  'EXTRACLASE',  'Obligatoria');
INSERT INTO Asignaturas VALUES(1956,  'INFORMATICA CONTABLE',  'Obligatoria');
INSERT INTO Asignaturas VALUES(1959,  'ORGANIZACION EMPRESARIAL',  'Obligatoria');
INSERT INTO Asignaturas VALUES(1963,  'PROYECTO INSTITUCIONAL',  'Obligatoria');
INSERT INTO Asignaturas VALUES(1965,  'SISTEMA DE PASANTIAS',  'Obligatoria');
INSERT INTO Asignaturas VALUES(1966,  'CULTURA Y ESTETICA CONTEMP.',  'Obligatoria');
INSERT INTO Asignaturas VALUES(1970,  'CONTEXTUALIZACION',  'Obligatoria');
INSERT INTO Asignaturas VALUES(1974,  'FUNDAMETOS DE ELECTRICIDAD',  'Obligatoria');
INSERT INTO Asignaturas VALUES(1983,  'TALLER TECNOLOGICO',  'Opcional');
INSERT INTO Asignaturas VALUES(1985,  'FORMACION DOCENTE I',  'Obligatoria');
INSERT INTO Asignaturas VALUES(1986,  'FORMACION DOCENTE II',  'Obligatoria');
INSERT INTO Asignaturas VALUES(1987,  'EDI-LEGISLACION IMPOSITIVA',  'Obligatoria');
INSERT INTO Asignaturas VALUES(1990,  'FORMACION MORAL-RELIGION',  'Obligatoria');
INSERT INTO Asignaturas VALUES(1994,  'EDI-ORGANIZACION EMPRESARIAL',  'Obligatoria');
INSERT INTO Asignaturas VALUES(2002,  'EDI',  'Obligatoria');
INSERT INTO Asignaturas VALUES(2003,  'INSTALACION DE COMPUTADORAS',  'Obligatoria');
INSERT INTO Asignaturas VALUES(2007,  'EDI-AUDITORIA',  'Obligatoria');
INSERT INTO Asignaturas VALUES(2022,  'LENGUA EXTRANJERA INGLES',  'Obligatoria');
INSERT INTO Asignaturas VALUES(2023,  'LENGUA EXTRANJERA FRANCES',  'Obligatoria');
INSERT INTO Asignaturas VALUES(2024,  'SISTEMA DE INFORMACION',  'Obligatoria');
INSERT INTO Asignaturas VALUES(2025,  'APOYO Y ORIENTACION VOCACIONAL',  'Obligatoria');
INSERT INTO Asignaturas VALUES(2027,  'EDI- CONTABLE',  'Obligatoria');
INSERT INTO Asignaturas VALUES(2030,  'INTALACION BASICA DE SOFWARD',  'Obligatoria');
INSERT INTO Asignaturas VALUES(2034,  'OPTATIVA II',  'Obligatoria');
INSERT INTO Asignaturas VALUES(2035,  'LENGUA EXTRANJERA II',  'Obligatoria');
INSERT INTO Asignaturas VALUES(2036,  'HISTORIA II',  'Obligatoria');
INSERT INTO Asignaturas VALUES(2038,  'QUIMICA I',  'Opcional');
INSERT INTO Asignaturas VALUES(2039,  'QUIMICA II',  'Obligatoria');
INSERT INTO Asignaturas VALUES(2040,  'ORGANIZACION CULTURAL',  'Obligatoria');
INSERT INTO Asignaturas VALUES(2044,  'EDUCACION ETICA',  'Obligatoria');
INSERT INTO Asignaturas VALUES(2047,  'EDI-LEGISLACION LABORAL',  'Obligatoria');
INSERT INTO Asignaturas VALUES(2048,  'PRACTICAS CONTABLES',  'Obligatoria');
INSERT INTO Asignaturas VALUES(2049,  'EDI- PRACTICA PROFESIONAL',  'Obligatoria');
INSERT INTO Asignaturas VALUES(2050,  'SALUD PUBLICA',  'Obligatoria');
INSERT INTO Asignaturas VALUES(2051,  'MEDIOS DE COMUNICACION',  'Obligatoria');
INSERT INTO Asignaturas VALUES(2052,  'TECNICA DE ESTUDIO',  'Obligatoria');
INSERT INTO Asignaturas VALUES(2053,  'TECNOLOGIA Y GESTION',  'Obligatoria');
INSERT INTO Asignaturas VALUES(2054,  'EDI- ORGANIZACION DE EMPRESAS',  'Obligatoria');
INSERT INTO Asignaturas VALUES(2055,  'GESTION DE ORGANIZACION',  'Obligatoria');
INSERT INTO Asignaturas VALUES(2056,  'LENGUA EXTRANJERA I',  'Obligatoria');
INSERT INTO Asignaturas VALUES(2058,  'COORDINADOR DE ETP',  'Obligatoria');
INSERT INTO Asignaturas VALUES(2059,  'TIC',  'Obligatoria');
INSERT INTO Asignaturas VALUES(2063,  'EDI-PRACTICA CONTABLE',  'Obligatoria');
INSERT INTO Asignaturas VALUES(2064,  'EDI- RECURSOS HUMANOS',  'Obligatoria');
INSERT INTO Asignaturas VALUES(2067,  'EDI- DERECHO LABORAL',  'Obligatoria');
INSERT INTO Asignaturas VALUES(2070,  'EDI-COOPERATIVISMO',  'Obligatoria');
INSERT INTO Asignaturas VALUES(2071,  'OPCION CURRICULAR',  'Obligatoria');
INSERT INTO Asignaturas VALUES(2072,  'EDI- INFORMATICA APLICADA',  'Obligatoria');
INSERT INTO Asignaturas VALUES(2075,  'EDUCACION FISICA- VARONES',  'Obligatoria');
INSERT INTO Asignaturas VALUES(2076,  'EDUCACION FISICA- MUJERES',  'Obligatoria');
INSERT INTO Asignaturas VALUES(2077,  'EDI- ESTADISTICA',  'Opcional');
INSERT INTO Asignaturas VALUES(2090,  'CULTURA Y COMUNICACION',  'Obligatoria');
INSERT INTO Asignaturas VALUES(2098,  'FONETICA Y FONOLOGIA I',  'Obligatoria');
INSERT INTO Asignaturas VALUES(2120,  'MANTENIMIENTO DE HAWARD',  'Obligatoria');
INSERT INTO Asignaturas VALUES(2121,  'TALLER OPTATIVO',  'Obligatoria');
INSERT INTO Asignaturas VALUES(2123,  'APOYO EN SERVICIO',  'Obligatoria');
INSERT INTO Asignaturas VALUES(2124,  'APOYO INGRESO',  'Obligatoria');
INSERT INTO Asignaturas VALUES(2125,  'SALA DE INFORMATICA',  'Obligatoria');
INSERT INTO Asignaturas VALUES(2174,  'LABORATORIO DE INFORMATICA',  'Obligatoria');
INSERT INTO Asignaturas VALUES(2177,  'TECNICA DE COMERCIALIZACION',  'Obligatoria');
INSERT INTO Asignaturas VALUES(2178,  'SISTEMA DE ESTADOS CONTABLES',  'Obligatoria');
INSERT INTO Asignaturas VALUES(2180,  'APOYO CURRICULAR',  'Obligatoria');
INSERT INTO Asignaturas VALUES(2182,  'ORIENTACION EN METAL MECANICO',  'Obligatoria');
INSERT INTO Asignaturas VALUES(2188,  'GESTION DE NEGOCIOS',  'Obligatoria');
INSERT INTO Asignaturas VALUES(2201,  'EDI-INFORMACION Y COMUNICACION',  'Obligatoria');
INSERT INTO Asignaturas VALUES(2242,  'OPTATIVA',  'Obligatoria');
INSERT INTO Asignaturas VALUES(2255,  'MANTENIMIENTO',  'Obligatoria');
INSERT INTO Asignaturas VALUES(2301,  'COMP. Y PRESUP.',  'Obligatoria');
INSERT INTO Asignaturas VALUES(2302,  'DIREC. DE LA EJEC TTP',  'Obligatoria');
INSERT INTO Asignaturas VALUES(2304,  'GEST. DE LA EJEC TTP',  'Obligatoria');
INSERT INTO Asignaturas VALUES(2305,  'MAR. JURID. PROC.PROD.',  'Obligatoria');
INSERT INTO Asignaturas VALUES(2306,  'PROY. Y GEST. DE MIC',  'Opcional');
INSERT INTO Asignaturas VALUES(2307,  'TEC. REG. GRAF.E IN',  'Obligatoria');
INSERT INTO Asignaturas VALUES(2308,  'ALG. EST. P/COMP',  'Obligatoria');
INSERT INTO Asignaturas VALUES(2315,  'TECNOLOGIA/COMPUTACION',  'Obligatoria');
INSERT INTO Asignaturas VALUES(2336,  'INSTRUMENTO Y CONTROL',  'Obligatoria');
INSERT INTO Asignaturas VALUES(2338,  'JEFATURA DE DEPARTAMENTO',  'Obligatoria');
INSERT INTO Asignaturas VALUES(2340,  'AYUDANTE TECNICO',  'Obligatoria');
INSERT INTO Asignaturas VALUES(2342,  'CREATIVIDAD',  'Obligatoria');
INSERT INTO Asignaturas VALUES(2345,  'EDI-PROYECTO APICOLA',  'Obligatoria');
INSERT INTO Asignaturas VALUES(2367,  'CONSULTA',  'Obligatoria');
INSERT INTO Asignaturas VALUES(2384,  'CIRCUITOS ELECTRICOS Y REDES',  'Obligatoria');
INSERT INTO Asignaturas VALUES(2396,  'FILOSOFIA / PSICOLOGIA',  'Obligatoria');
INSERT INTO Asignaturas VALUES(2397,  'TALLER DE MARKETING',  'Obligatoria');
INSERT INTO Asignaturas VALUES(2398,  'CONTROL DE PASANTIAS',  'Obligatoria');
INSERT INTO Asignaturas VALUES(2400,  'FORMACION DE VALORES',  'Obligatoria');
INSERT INTO Asignaturas VALUES(2409,  'EDI-TALLER TIEMPO Y DEPORTES',  'Obligatoria');
INSERT INTO Asignaturas VALUES(2413,  'HUERTA COMUNITARIA',  'Obligatoria');
INSERT INTO Asignaturas VALUES(2419,  'TRABAJO DE CAMPO',  'Obligatoria');
INSERT INTO Asignaturas VALUES(2423,  'INSTITUCIONES MATERNALES',  'Obligatoria');
INSERT INTO Asignaturas VALUES(2430,  'CAD CAM CNC',  'Obligatoria');
INSERT INTO Asignaturas VALUES(2444,  'MAESTRA TUTORA',  'Obligatoria');
INSERT INTO Asignaturas VALUES(2447,  'TALLER MECANICO',  'Obligatoria');
INSERT INTO Asignaturas VALUES(2451,  'ESTATICA Y R. DE MATERIALES',  'Obligatoria');
INSERT INTO Asignaturas VALUES(2514,  'INGLES I',  'Obligatoria');
INSERT INTO Asignaturas VALUES(2557,  'OLIMPIADAS GEOGRAFIA ARGENTINA',  'Opcional');
INSERT INTO Asignaturas VALUES(2558,  'JEFE DE INVESTIGACION',  'Obligatoria');
INSERT INTO Asignaturas VALUES(2560,  'COORDINADOR DE POSTITULO',  'Obligatoria');
INSERT INTO Asignaturas VALUES(2562,  'PROBL. EDUC. Y SOCIO CULTURAL',  'Obligatoria');
INSERT INTO Asignaturas VALUES(2563,  'CS. NATURALES I',  'Obligatoria');
INSERT INTO Asignaturas VALUES(2564,  'CS. NATURALES II',  'Obligatoria');
INSERT INTO Asignaturas VALUES(2565,  'SEMINARIO C/T/S',  'Obligatoria');
INSERT INTO Asignaturas VALUES(2566,  'TALLER DE ALFAB. INICIAL',  'Obligatoria');
INSERT INTO Asignaturas VALUES(2567,  'ORG. INSTITUCIONAL EGBA',  'Obligatoria');
INSERT INTO Asignaturas VALUES(2571,  'TALLER DE INVEST. EDUC. I',  'Obligatoria');
INSERT INTO Asignaturas VALUES(2572,  'TALLER DE INVEST. EDUC. II',  'Obligatoria');
INSERT INTO Asignaturas VALUES(2573,  'INFORMATICA PRACTICA',  'Obligatoria');
INSERT INTO Asignaturas VALUES(2576,  'EL TEXTO LITERARIO',  'Obligatoria');
INSERT INTO Asignaturas VALUES(2581,  'DISCURSO Y TEXTO',  'Obligatoria');
INSERT INTO Asignaturas VALUES(2582,  'ORG. DE SERVICIOS Y COMUNIDAD',  'Obligatoria');
INSERT INTO Asignaturas VALUES(2590,  'TAREAS DE COORDINACION',  'Opcional');
INSERT INTO Asignaturas VALUES(2601,  'CALCULO Y ESTADISTICA CONTABLE',  'Obligatoria');
INSERT INTO Asignaturas VALUES(2615,  'DIREC DE COROS',  'Obligatoria');
INSERT INTO Asignaturas VALUES(2617,  'HORAS COMPLEMENTARIAS',  'Obligatoria');
INSERT INTO Asignaturas VALUES(2618,  'MUESTRA PEDAGOGICA',  'Obligatoria');
INSERT INTO Asignaturas VALUES(2619,  'PROYECTO DE HUERTA',  'Obligatoria');
INSERT INTO Asignaturas VALUES(2627,  'ORNAMENTACION',  'Obligatoria');
INSERT INTO Asignaturas VALUES(2634,  'PROYECTO COMUNITARIO',  'Obligatoria');
INSERT INTO Asignaturas VALUES(2649,  'LENGUA Y LITERATURA III',  'Obligatoria');
INSERT INTO Asignaturas VALUES(2650,  'EDUCACION FISICA III',  'Obligatoria');
INSERT INTO Asignaturas VALUES(2651,  'TAREA ADMINISTRATIVA',  'Obligatoria');
INSERT INTO Asignaturas VALUES(2652,  'TALLER EDUCATIVO',  'Obligatoria');
INSERT INTO Asignaturas VALUES(2653,  'ORIENTACION VOCACIONAL',  'Obligatoria');
INSERT INTO Asignaturas VALUES(2656,  'EXTRACLASES',  'Obligatoria');
INSERT INTO Asignaturas VALUES(2658,  'TAREAS COMUNITARIAS',  'Obligatoria');
INSERT INTO Asignaturas VALUES(2659,  'FILOSOFIA I',  'Obligatoria');
INSERT INTO Asignaturas VALUES(2668,  'TALLER DE ESTADISTICA',  'Obligatoria');
INSERT INTO Asignaturas VALUES(2671,  'TECNOLOGIA RURAL',  'Obligatoria');
INSERT INTO Asignaturas VALUES(2672,  'TALLER RECREATIVO',  'Obligatoria');
INSERT INTO Asignaturas VALUES(2673,  'HISTORIA I',  'Obligatoria');
INSERT INTO Asignaturas VALUES(2674,  'TALLER DE SISTEMAS CONTABLES',  'Obligatoria');
INSERT INTO Asignaturas VALUES(2675,  'COORDINACION AREA ESTETICA',  'Obligatoria');
INSERT INTO Asignaturas VALUES(2677,  'EDI-QUIMICA',  'Obligatoria');
INSERT INTO Asignaturas VALUES(2678,  'ECONOMIA Y SOCIEDAD',  'Obligatoria');
INSERT INTO Asignaturas VALUES(2687,  'TECNOLOGIA DE ENERGIA',  'Opcional');
INSERT INTO Asignaturas VALUES(2688,  'PROCESOS DE SERVICIOS',  'Obligatoria');
INSERT INTO Asignaturas VALUES(2692,  'PROYECTO CATEQUESIS',  'Obligatoria');
INSERT INTO Asignaturas VALUES(2695,  'COORDINADOR DE DEPARTAMENTO',  'Obligatoria');
INSERT INTO Asignaturas VALUES(2697,  'E.O.D.I.',  'Obligatoria');
INSERT INTO Asignaturas VALUES(2698,  'GEOMETRIA Y MEDIDA',  'Obligatoria');
INSERT INTO Asignaturas VALUES(2700,  'ADMINISTRACION INDUSTRIAL I',  'Obligatoria');
INSERT INTO Asignaturas VALUES(2701,  'ADMINISTRACION INDUSTRIAL II',  'Obligatoria');
INSERT INTO Asignaturas VALUES(2703,  'SOCIOLOGIA/CS POLITICAS',  'Obligatoria');
INSERT INTO Asignaturas VALUES(2711,  'CULT Y EST CONT',  'Obligatoria');
INSERT INTO Asignaturas VALUES(2717,  'HORAS INSTITUCIONALES: TUTORIA',  'Obligatoria');
INSERT INTO Asignaturas VALUES(2719,  'DIRECTOR A CARGO',  'Obligatoria');
INSERT INTO Asignaturas VALUES(2720,  'PROY INV SOC COM',  'Obligatoria');
INSERT INTO Asignaturas VALUES(2721,  'T. G. AEROBICA',  'Obligatoria');
INSERT INTO Asignaturas VALUES(2723,  'BIBLIOTECARIO',  'Obligatoria');
INSERT INTO Asignaturas VALUES(2724,  'ORIENTACION AGROPECUARIA',  'Obligatoria');
INSERT INTO Asignaturas VALUES(2727,  'TALLER DE ELAB. DE CONSERVAS',  'Obligatoria');
INSERT INTO Asignaturas VALUES(2731,  'BIOLOGIA I',  'Obligatoria');
INSERT INTO Asignaturas VALUES(2733,  'MARCO JURIDICO',  'Opcional');
INSERT INTO Asignaturas VALUES(2738,  'GESTION Y ADMINISTRACION',  'Opcional');
INSERT INTO Asignaturas VALUES(2750,  'AYUDANTE DE INFORMATICA',  'Opcional');
INSERT INTO Asignaturas VALUES(2753,  'TALLER EX ART PLASTICA',  'Obligatoria');
INSERT INTO Asignaturas VALUES(2754,  'LENGUA Y CULTURA GLOBAL',  'Obligatoria');
INSERT INTO Asignaturas VALUES(2758,  'INDUSTRIA LACTEA',  'Obligatoria');
INSERT INTO Asignaturas VALUES(2759,  'INFORMACION Y TECNOLOGIA',  'Obligatoria');
INSERT INTO Asignaturas VALUES(2760,  'TALLER DE TURISMO RURAL',  'Obligatoria');
INSERT INTO Asignaturas VALUES(2761,  'FISICO-QUIMICA',  'Obligatoria');
INSERT INTO Asignaturas VALUES(2763,  'TEORIA Y GESTION I',  'Obligatoria');
INSERT INTO Asignaturas VALUES(2765,  'PROYECTO EDUCACION EN VALORES',  'Obligatoria');
INSERT INTO Asignaturas VALUES(2767,  'EDI-TEJIDO',  'Obligatoria');
INSERT INTO Asignaturas VALUES(2768,  'EDI-CERAMICA',  'Obligatoria');
INSERT INTO Asignaturas VALUES(2769,  'FISICA-QUIMICA',  'Obligatoria');
INSERT INTO Asignaturas VALUES(2771,  'FLORICULTURA',  'Obligatoria');
INSERT INTO Asignaturas VALUES(2773,  'EDI EN CIENCIAS NATURALES',  'Obligatoria');
INSERT INTO Asignaturas VALUES(2775,  'INSTITUCIONALIZACION',  'Obligatoria');
INSERT INTO Asignaturas VALUES(2777,  'EDUCACION ETICA/FILOSOFIA',  'Obligatoria');
INSERT INTO Asignaturas VALUES(2780,  'EDI-DERECHO ECONOMICO',  'Obligatoria');
INSERT INTO Asignaturas VALUES(2781,  'EDI-PROP PUBLI Y MARKETING',  'Opcional');
INSERT INTO Asignaturas VALUES(2789,  'LABORATORIO DE CS. NATURALES',  'Obligatoria');
INSERT INTO Asignaturas VALUES(2793,  'PRODUCCION DE CAPRINOS',  'Obligatoria');
INSERT INTO Asignaturas VALUES(2899,  'JARDINES MATERNALES',  'Obligatoria');
INSERT INTO Asignaturas VALUES(2916,  'PROCESO SOCIO-CULTURAL',  'Obligatoria');
INSERT INTO Asignaturas VALUES(2917,  'COORDINAD DE INVESTIGACION',  'Obligatoria');
INSERT INTO Asignaturas VALUES(2928,  'PRACTICA PROFESIONAL I',  'Obligatoria');
INSERT INTO Asignaturas VALUES(2948,  'CESTO',  'Obligatoria');
INSERT INTO Asignaturas VALUES(2949,  'ARBITRAJE',  'Obligatoria');
INSERT INTO Asignaturas VALUES(2950,  'EDI-ESPACIO DE DEFINIC INST',  'Obligatoria');
INSERT INTO Asignaturas VALUES(2971,  'EDI-DINAMICA DE GRUPO',  'Obligatoria');
INSERT INTO Asignaturas VALUES(2972,  'NUTRICION Y DESARROLLO',  'Obligatoria');
INSERT INTO Asignaturas VALUES(2973,  'TALLER DE MATEMATICA CREATIVA',  'Obligatoria');
INSERT INTO Asignaturas VALUES(2977,  'EDI-TALLER DE PLASTICA',  'Obligatoria');
INSERT INTO Asignaturas VALUES(2978,  'PROCESO PRODUCTIVO',  'Obligatoria');
INSERT INTO Asignaturas VALUES(2981,  'EDI-PROMOTORES DE SALUD',  'Opcional');
INSERT INTO Asignaturas VALUES(2982,  'COORDINADORA DE CAPACITACION',  'Obligatoria');
INSERT INTO Asignaturas VALUES(2983,  'COORDINADORA DE INVESTIGACION',  'Obligatoria');
INSERT INTO Asignaturas VALUES(2992,  'LA ESC NEC/INT ESCOL',  'Obligatoria');
INSERT INTO Asignaturas VALUES(3000,  'OPTATIVA III',  'Obligatoria');
INSERT INTO Asignaturas VALUES(3023,  'SUJETO/T. SICOL.',  'Obligatoria');
INSERT INTO Asignaturas VALUES(3024,  'SIST. EDUC/TEORIA SICOL.',  'Obligatoria');
INSERT INTO Asignaturas VALUES(3025,  'SUJETO/TEORIAS',  'Obligatoria');
INSERT INTO Asignaturas VALUES(3028,  'MATEMATICA Y SU DIDACTICA II',  'Obligatoria');
INSERT INTO Asignaturas VALUES(3034,  'EDI - PROCESOS AGROPECUARIOS',  'Obligatoria');
INSERT INTO Asignaturas VALUES(3036,  'ESPACIO PROPIO DE LA MODALIDAD',  'Obligatoria');
INSERT INTO Asignaturas VALUES(3040,  'JEFE CARRERA',  'Obligatoria');
INSERT INTO Asignaturas VALUES(3044,  'DIDACTICA DE LA VOZ',  'Obligatoria');
INSERT INTO Asignaturas VALUES(3059,  'PRACTICA DE RESIDENCIA',  'Obligatoria');
INSERT INTO Asignaturas VALUES(3060,  'ATENCION CASOS ESPECIALES',  'Obligatoria');
INSERT INTO Asignaturas VALUES(3063,  'EDI-HISTORIA REGIONAL',  'Obligatoria');
INSERT INTO Asignaturas VALUES(3100,  'MANTENIMIENTO DE HARDWARE',  'Obligatoria');
INSERT INTO Asignaturas VALUES(3106,  'EDI-SISTEMA DE PASANTIA',  'Obligatoria');
INSERT INTO Asignaturas VALUES(3114,  'LAB. DE GESTION ECONOMICA III',  'Obligatoria');
INSERT INTO Asignaturas VALUES(3120,  'CONEXION ENTRE 2 COMPUTADORAS',  'Obligatoria');
INSERT INTO Asignaturas VALUES(3170,  'FORM. DE PROY. PROD.',  'Obligatoria');
INSERT INTO Asignaturas VALUES(3171,  'ORG. Y GEST. PROD. AGROP.',  'Obligatoria');
INSERT INTO Asignaturas VALUES(3174,  'PRODUCCION DE FRUTAS CITRICAS',  'Obligatoria');
INSERT INTO Asignaturas VALUES(3180,  'MODULO RECREACION',  'Obligatoria');
INSERT INTO Asignaturas VALUES(3181,  'MODULO PROMOCION',  'Obligatoria');
INSERT INTO Asignaturas VALUES(3182,  'MODULO SERVICIOS DE RECREACION',  'Obligatoria');
INSERT INTO Asignaturas VALUES(3183,  'MODULO GESTION DE VENTAS',  'Obligatoria');
INSERT INTO Asignaturas VALUES(3184,  'MODULO PROYECTO PRODUCTIVO',  'Obligatoria');
INSERT INTO Asignaturas VALUES(3190,  'PROYECTO APICOLA',  'Obligatoria');
INSERT INTO Asignaturas VALUES(3196,  'MOD. HERRAMIENTAS INFORMATICAS',  'Obligatoria');
INSERT INTO Asignaturas VALUES(3197,  'MOD. ELECTRONICA INDUSTRIAL',  'Obligatoria');
INSERT INTO Asignaturas VALUES(3212,  'TECNOLOGIAS DIVERSAS',  'Obligatoria');
INSERT INTO Asignaturas VALUES(3309,  'ADAPTAC.AL MUNDO DEL TRABAJO',  'Obligatoria');
INSERT INTO Asignaturas VALUES(3319,  'SOCIOLOGIA-CS.POLITICAS',  'Opcional');
INSERT INTO Asignaturas VALUES(3337,  'MODULO EDI/TUTORIA',  'Obligatoria');
INSERT INTO Asignaturas VALUES(3374,  'SIN DATOS',  'Obligatoria');
INSERT INTO Asignaturas VALUES(3377,  'ALFABETIZACION ACADEMICA',  'Obligatoria');
INSERT INTO Asignaturas VALUES(3380,  'ATENCION Y EDUCACION TEMPRANA',  'Obligatoria');
INSERT INTO Asignaturas VALUES(3444,  'EX`PRESION ARTISTICA MUSICA',  'Obligatoria');
INSERT INTO Asignaturas VALUES(3445,  'EXPRESION ARTIST PLASTICA',  'Obligatoria');
INSERT INTO Asignaturas VALUES(3446,  'PROB.EDUC.INICIAL',  'Obligatoria');
INSERT INTO Asignaturas VALUES(3447,  'DIDACT.LENGUA Y LITER. I',  'Obligatoria');
INSERT INTO Asignaturas VALUES(3449,  'EXPRESION ARTISTICA MUSICA',  'Obligatoria');
INSERT INTO Asignaturas VALUES(3453,  'ATENCION Y EDUC.TEMPRANA',  'Obligatoria');
INSERT INTO Asignaturas VALUES(3594,  'DIDACTICA DE LA MATEMATICA II',  'Obligatoria');
INSERT INTO Asignaturas VALUES(3620,  'BIOLOGIA CELULAR',  'Obligatoria');
INSERT INTO Asignaturas VALUES(3636,  'EDI-ESPACIO CUATRIMESTRAL',  'Obligatoria');
INSERT INTO Asignaturas VALUES(3659,  'EDUCACION SEXUAL INTEGRAL',  'Obligatoria');
INSERT INTO Asignaturas VALUES(3672,  'MATEMATICA',  'Obligatoria');
INSERT INTO Asignaturas VALUES(3713,  'EXPRESION ARTISTICA: PLASTICA',  'Obligatoria');
INSERT INTO Asignaturas VALUES(3721,  'DIDACTICA DE LA MATEMATICA I',  'Obligatoria');
INSERT INTO Asignaturas VALUES(3722,  'JUEGO Y ACTIVIDAD LUDICA',  'Obligatoria');
INSERT INTO Asignaturas VALUES(3842,  'ORGANIZACION INDUSTRIAL I',  'Obligatoria');
INSERT INTO Asignaturas VALUES(3885,  'DIDACTICA DEL NIVEL INICIAL',  'Obligatoria');
INSERT INTO Asignaturas VALUES(3978,  'LENGUA Y CULTURA I',  'Obligatoria');
INSERT INTO Asignaturas VALUES(3979,  'LENGUA Y CULTURA II',  'Obligatoria');
INSERT INTO Asignaturas VALUES(3980,  'LENGUA ESCRITURA Y ORALIDAD',  'Obligatoria');
INSERT INTO Asignaturas VALUES(4024,  'LECTURA  ESCRITURA Y ORALIDAD',  'Obligatoria');
INSERT INTO Asignaturas VALUES(4036,  'CUERPO SUJETO Y MOVIMIENTO',  'Obligatoria');
INSERT INTO Asignaturas VALUES(4094,  'CIENCIAS DE LA TIERRA',  'Obligatoria');
INSERT INTO Asignaturas VALUES(5337,  'PRACTICA PROFESIONAL II',  'Obligatoria');
INSERT INTO Asignaturas VALUES(5378,  'DIDACTICA DE LA GEOGRAFIA I',  'Obligatoria');
INSERT INTO Asignaturas VALUES(5380,  'GEOGRAFIA DE LA POBLACION',  'Obligatoria');
INSERT INTO Asignaturas VALUES(5382,  'GEOGRAFIA CULTURAL',  'Obligatoria');
INSERT INTO Asignaturas VALUES(5383,  'DIDACTICA DE LA GEOGRAFIA II',  'Obligatoria');
INSERT INTO Asignaturas VALUES(5385,  'GEOGRAFIA ECONOMICA GENERAL',  'Obligatoria');
INSERT INTO Asignaturas VALUES(5386,  'DIDACTICA DE LA GEOGRAFIA III',  'Opcional');
INSERT INTO Asignaturas VALUES(5388,  'INVESTIGACION EN GEOGRAFIA',  'Obligatoria');
INSERT INTO Asignaturas VALUES(5457,  'PRACTICA PROFESIONAL III',  'Obligatoria');
INSERT INTO Asignaturas VALUES(5591,  'QUIMICA GENERAL E INORGANICA',  'Obligatoria');
INSERT INTO Asignaturas VALUES(5597,  'DIDACTICA DE LA BIOLOGIA I',  'Obligatoria');
INSERT INTO Asignaturas VALUES(5598,  'DIDACTICA DE LA BIOLOGIA II',  'Obligatoria');
INSERT INTO Asignaturas VALUES(5599,  'ANATOMIA Y FISIOLOGIA HUMANA',  'Obligatoria');
INSERT INTO Asignaturas VALUES(5600,  'DIDACTICA DE LA BIOLOGIA III',  'Obligatoria');
INSERT INTO Asignaturas VALUES(5601,  'ECOLOGIA Y EDUCACION AMBIENTAL',  'Obligatoria');

INSERT INTO Curricula VALUES(4,  'E.G.B. N° 1',  '2009/01/01',  '2009/12/31');
INSERT INTO Curricula VALUES(5,  'E.G.B. N° 2',  '2009/02/01',  '2009/12/31');
INSERT INTO Curricula VALUES(6,  'PRIMARIO',  '2009/03/01',  null);
INSERT INTO Curricula VALUES(7,  'CERTIFICADO DE INICIAL (JARDIN DE INFANTES)',  '2009/04/01',  '2009/12/31');
INSERT INTO Curricula VALUES(9,  'PROF. DE EDUCACION INICIAL',  '2009/05/01',  '2009/12/31');
INSERT INTO Curricula VALUES(14,  'PROFESORADO DE 1 Y 2 CICLO DE EGB',  '2010/01/01',  '2010/12/31');
INSERT INTO Curricula VALUES(16,  'E.G.B. N° 3',  '2010/02/01',  '2010/12/31');
INSERT INTO Curricula VALUES(40,  'PROFESOR DE E.G.B. 3 Y POL EN GEOGRAFIA ',  '2010/03/01',  '2010/12/31');
INSERT INTO Curricula VALUES(47,  'PROF. DE 3° CICLO EGB Y POLIM EN BIOLOGIA (14/5)',  '2010/04/01',  null);
INSERT INTO Curricula VALUES(51,  'CICLO BASICO PARA ESCUELAS SECUNDARIAS',  '2010/05/01',  '2010/12/31');
INSERT INTO Curricula VALUES(52,  'BACHILLER ESPECIALIZADO EN CIENCIAS BIOLOGICAS',  '2011/01/01',  '2011/12/31');
INSERT INTO Curricula VALUES(53,  'BACHILLER ESPEC. EN CIENCIAS FISICO-MATEMATICAS',  '2011/02/01',  null);
INSERT INTO Curricula VALUES(54,  'BACHILLER PEDAGOGICO',  '2011/03/01',  '2011/12/31');
INSERT INTO Curricula VALUES(245,  'CERTIFICADO DE EGB1',  '2011/04/01',  '2011/12/31');
INSERT INTO Curricula VALUES(246,  'CERTIFICADO DE EGB2',  '2011/05/01',  '2011/12/31');
INSERT INTO Curricula VALUES(247,  'CERTIFICADO NIVEL INICIAL',  '2012/01/01',  null);
INSERT INTO Curricula VALUES(249,  'CERTIFICADO DE EGB 3 - 7 (RES 1115)',  '2012/02/01',  '2012/12/31');
INSERT INTO Curricula VALUES(250,  'CERTIFICADO DE EGB 3 - 8Y9 (RES 1115)',  '2012/03/01',  '2012/12/31');
INSERT INTO Curricula VALUES(252,  'CERTIF. POLIM-ECON. Y GEST. DE LAS ORG.-G.O.(2358)',  '2012/04/01',  '2012/12/31');
INSERT INTO Curricula VALUES(253,  'CERTIF. POLIM.-COMUNICACION ARTE Y DISEÑO-IND. CU',  '2012/05/01',  '2012/12/31');
INSERT INTO Curricula VALUES(255,  'CERTIF.POLIM.-PROD. BIENES Y SERV- EEIMH',  '2013/01/01',  null);
INSERT INTO Curricula VALUES(257,  'CERTIF. POLIM.- CIENCIAS NATURALES - SALUD',  '2013/02/01',  null);
INSERT INTO Curricula VALUES(258,  'CERTIF. POLIM-HUMAN Y CS SOCIALES -EYC-(2358)',  '2013/03/01',  '2013/12/31');
INSERT INTO Curricula VALUES(318,  'POST:ESPEC.SUP.DE EDUC. EN CONTEXTO DE RIESGO Y MA',  '2013/04/01',  '2013/12/31');
INSERT INTO Curricula VALUES(319,  'POST:ESP.SUP.EN MATEMA Y CS NATURALES P/EGBA',  '2013/05/01',  '2013/12/31');
INSERT INTO Curricula VALUES(320,  'POST:ESP SUP EN LENGUA Y CS. SOC P/ LA EGBA',  '2014/01/01',  '2014/12/31');
INSERT INTO Curricula VALUES(366,  'CERT-POLI- MODALIDAD HUMANIDADES Y CS SOC (3357)',  '2014/02/01',  null);
INSERT INTO Curricula VALUES(368,  'CERT-POLI-MODALIDAD CIENCIAS NATURALES (3357)',  '2014/03/01',  null);
INSERT INTO Curricula VALUES(370,  'CERT-POLI-COMUNICACION ARTE Y DISEÑO (3357)',  '2014/04/01',  '2014/12/31');
INSERT INTO Curricula VALUES(451,  'PROF.DE 3ºED. GRAL BCA. Y DE EDUC. POL. GEOGRAFIA',  '2014/05/01',  '2014/12/31');
INSERT INTO Curricula VALUES(455,  'NINGUNO',  '2015/01/01',  '2015/12/31');
INSERT INTO Curricula VALUES(465,  'PROFESORADO DE EDUCACIÓN PRIMARIA (RES 638/5)',  '2015/02/01',  null);
INSERT INTO Curricula VALUES(466,  'PROFESORADO DE EDUCACION INICIAL-RES 637',  '2015/03/01',  null);
INSERT INTO Curricula VALUES(480,  'CICLO BASICO ESC.SEC. (RESOL Nº 1115)',  '2015/04/01',  null);
INSERT INTO Curricula VALUES(572,  'PRIMARIA-JORNADA SIMPLE 118/5',  '2015/05/01',  '2015/12/31');
INSERT INTO Curricula VALUES(647,  'PROFESOR DE PORTUGUES (158/5)',  '2016/01/01',  null);
INSERT INTO Curricula VALUES(851,  'PROFESOR DE EDUCACION SECUNDARIA EN GEOGRAFIA (1419/5)',  '2016/02/01',  null);
INSERT INTO Curricula VALUES(866,  'PROFESOR DE EDUCACION PRIMARIA (1434/5)',  '2016/03/01',  null);
INSERT INTO Curricula VALUES(869,  'PROFESOR DE EDUCACION SECUNDARIA EN BIOLOGIA (1423/5)',  '2016/04/01',  null);
INSERT INTO Curricula VALUES(876,  'PROFESOR DE EDUCACION INICIAL (1433/5)',  '2016/05/01',  null);
INSERT INTO Curricula VALUES(967,  'C.F.E. 140/11 (RECONVERSION)',  '2016/06/01',  null);

INSERT INTO Detalle VALUES (4, 19, 4);
INSERT INTO Detalle VALUES (4, 45, 4);
INSERT INTO Detalle VALUES (4, 54, 4);
INSERT INTO Detalle VALUES (4, 58, 4);
INSERT INTO Detalle VALUES (4, 72, 4);
INSERT INTO Detalle VALUES (4, 111, 4);
INSERT INTO Detalle VALUES (4, 163, 4);
INSERT INTO Detalle VALUES (4, 165, 4);
INSERT INTO Detalle VALUES (4, 225, 4);
INSERT INTO Detalle VALUES (4, 643, 4);
INSERT INTO Detalle VALUES (4, 739, 4);
INSERT INTO Detalle VALUES (4, 1077, 4);
INSERT INTO Detalle VALUES (4, 2619, 4);
INSERT INTO Detalle VALUES (4, 3374, 4);
INSERT INTO Detalle VALUES (5, 19, 5);
INSERT INTO Detalle VALUES (5, 45, 5);
INSERT INTO Detalle VALUES (5, 54, 5);
INSERT INTO Detalle VALUES (5, 55, 5);
INSERT INTO Detalle VALUES (5, 58, 5);
INSERT INTO Detalle VALUES (5, 72, 5);
INSERT INTO Detalle VALUES (5, 163, 5);
INSERT INTO Detalle VALUES (5, 165, 5);
INSERT INTO Detalle VALUES (5, 174, 5);
INSERT INTO Detalle VALUES (5, 225, 5);
INSERT INTO Detalle VALUES (5, 643, 5);
INSERT INTO Detalle VALUES (5, 739, 5);
INSERT INTO Detalle VALUES (5, 1077, 5);
INSERT INTO Detalle VALUES (5, 1963, 5);
INSERT INTO Detalle VALUES (5, 3374, 5);
INSERT INTO Detalle VALUES (6, 10, 6);
INSERT INTO Detalle VALUES (6, 11, 6);
INSERT INTO Detalle VALUES (6, 19, 6);
INSERT INTO Detalle VALUES (6, 20, 6);
INSERT INTO Detalle VALUES (6, 45, 6);
INSERT INTO Detalle VALUES (6, 53, 6);
INSERT INTO Detalle VALUES (6, 54, 6);
INSERT INTO Detalle VALUES (6, 55, 6);
INSERT INTO Detalle VALUES (6, 58, 6);
INSERT INTO Detalle VALUES (6, 72, 6);
INSERT INTO Detalle VALUES (6, 111, 6);
INSERT INTO Detalle VALUES (6, 163, 6);
INSERT INTO Detalle VALUES (6, 165, 6);
INSERT INTO Detalle VALUES (6, 174, 6);
INSERT INTO Detalle VALUES (6, 643, 6);
INSERT INTO Detalle VALUES (6, 666, 6);
INSERT INTO Detalle VALUES (6, 739, 6);
INSERT INTO Detalle VALUES (6, 3212, 6);
INSERT INTO Detalle VALUES (6, 3374, 6);
INSERT INTO Detalle VALUES (7, 20, 7);
INSERT INTO Detalle VALUES (7, 54, 7);
INSERT INTO Detalle VALUES (7, 174, 7);
INSERT INTO Detalle VALUES (7, 739, 7);
INSERT INTO Detalle VALUES (7, 3374, 7);
INSERT INTO Detalle VALUES (9, 13, 9);
INSERT INTO Detalle VALUES (9, 14, 9);
INSERT INTO Detalle VALUES (9, 38, 9);
INSERT INTO Detalle VALUES (9, 53, 9);
INSERT INTO Detalle VALUES (9, 54, 9);
INSERT INTO Detalle VALUES (9, 102, 9);
INSERT INTO Detalle VALUES (9, 120, 9);
INSERT INTO Detalle VALUES (9, 220, 9);
INSERT INTO Detalle VALUES (9, 408, 9);
INSERT INTO Detalle VALUES (9, 454, 9);
INSERT INTO Detalle VALUES (9, 487, 9);
INSERT INTO Detalle VALUES (9, 635, 9);
INSERT INTO Detalle VALUES (9, 672, 9);
INSERT INTO Detalle VALUES (9, 684, 9);
INSERT INTO Detalle VALUES (9, 695, 9);
INSERT INTO Detalle VALUES (9, 720, 9);
INSERT INTO Detalle VALUES (9, 721, 9);
INSERT INTO Detalle VALUES (9, 748, 9);
INSERT INTO Detalle VALUES (9, 775, 9);
INSERT INTO Detalle VALUES (9, 814, 9);
INSERT INTO Detalle VALUES (9, 818, 9);
INSERT INTO Detalle VALUES (9, 832, 9);
INSERT INTO Detalle VALUES (9, 849, 9);
INSERT INTO Detalle VALUES (9, 866, 9);
INSERT INTO Detalle VALUES (9, 868, 9);
INSERT INTO Detalle VALUES (9, 924, 9);
INSERT INTO Detalle VALUES (9, 940, 9);
INSERT INTO Detalle VALUES (9, 1081, 9);
INSERT INTO Detalle VALUES (9, 1101, 9);
INSERT INTO Detalle VALUES (9, 1299, 9);
INSERT INTO Detalle VALUES (9, 1324, 9);
INSERT INTO Detalle VALUES (9, 1450, 9);
INSERT INTO Detalle VALUES (9, 1451, 9);
INSERT INTO Detalle VALUES (9, 1504, 9);
INSERT INTO Detalle VALUES (9, 1762, 9);
INSERT INTO Detalle VALUES (9, 1764, 9);
INSERT INTO Detalle VALUES (9, 1765, 9);
INSERT INTO Detalle VALUES (9, 1766, 9);
INSERT INTO Detalle VALUES (9, 1767, 9);
INSERT INTO Detalle VALUES (9, 1768, 9);
INSERT INTO Detalle VALUES (9, 1781, 9);
INSERT INTO Detalle VALUES (9, 1865, 9);
INSERT INTO Detalle VALUES (9, 1866, 9);
INSERT INTO Detalle VALUES (9, 1867, 9);
INSERT INTO Detalle VALUES (9, 1868, 9);
INSERT INTO Detalle VALUES (9, 1869, 9);
INSERT INTO Detalle VALUES (9, 2002, 9);
INSERT INTO Detalle VALUES (9, 2071, 9);
INSERT INTO Detalle VALUES (9, 2242, 9);
INSERT INTO Detalle VALUES (9, 2423, 9);
INSERT INTO Detalle VALUES (9, 2558, 9);
INSERT INTO Detalle VALUES (9, 2753, 9);
INSERT INTO Detalle VALUES (9, 2899, 9);
INSERT INTO Detalle VALUES (9, 3023, 9);
INSERT INTO Detalle VALUES (9, 3025, 9);
INSERT INTO Detalle VALUES (9, 3040, 9);
INSERT INTO Detalle VALUES (9, 3380, 9);
INSERT INTO Detalle VALUES (14, 14, 14);
INSERT INTO Detalle VALUES (14, 102, 14);
INSERT INTO Detalle VALUES (14, 149, 14);
INSERT INTO Detalle VALUES (14, 162, 14);
INSERT INTO Detalle VALUES (14, 220, 14);
INSERT INTO Detalle VALUES (14, 292, 14);
INSERT INTO Detalle VALUES (14, 305, 14);
INSERT INTO Detalle VALUES (14, 413, 14);
INSERT INTO Detalle VALUES (14, 454, 14);
INSERT INTO Detalle VALUES (14, 514, 14);
INSERT INTO Detalle VALUES (14, 573, 14);
INSERT INTO Detalle VALUES (14, 672, 14);
INSERT INTO Detalle VALUES (14, 684, 14);
INSERT INTO Detalle VALUES (14, 695, 14);
INSERT INTO Detalle VALUES (14, 720, 14);
INSERT INTO Detalle VALUES (14, 748, 14);
INSERT INTO Detalle VALUES (14, 783, 14);
INSERT INTO Detalle VALUES (14, 784, 14);
INSERT INTO Detalle VALUES (14, 814, 14);
INSERT INTO Detalle VALUES (14, 832, 14);
INSERT INTO Detalle VALUES (14, 924, 14);
INSERT INTO Detalle VALUES (14, 929, 14);
INSERT INTO Detalle VALUES (14, 940, 14);
INSERT INTO Detalle VALUES (14, 1050, 14);
INSERT INTO Detalle VALUES (14, 1081, 14);
INSERT INTO Detalle VALUES (14, 1101, 14);
INSERT INTO Detalle VALUES (14, 1324, 14);
INSERT INTO Detalle VALUES (14, 1392, 14);
INSERT INTO Detalle VALUES (14, 1504, 14);
INSERT INTO Detalle VALUES (14, 1757, 14);
INSERT INTO Detalle VALUES (14, 1764, 14);
INSERT INTO Detalle VALUES (14, 1765, 14);
INSERT INTO Detalle VALUES (14, 1773, 14);
INSERT INTO Detalle VALUES (14, 1775, 14);
INSERT INTO Detalle VALUES (14, 1781, 14);
INSERT INTO Detalle VALUES (14, 1865, 14);
INSERT INTO Detalle VALUES (14, 1866, 14);
INSERT INTO Detalle VALUES (14, 1867, 14);
INSERT INTO Detalle VALUES (14, 1869, 14);
INSERT INTO Detalle VALUES (14, 1871, 14);
INSERT INTO Detalle VALUES (14, 1872, 14);
INSERT INTO Detalle VALUES (14, 1873, 14);
INSERT INTO Detalle VALUES (14, 1879, 14);
INSERT INTO Detalle VALUES (14, 1933, 14);
INSERT INTO Detalle VALUES (14, 2002, 14);
INSERT INTO Detalle VALUES (14, 2034, 14);
INSERT INTO Detalle VALUES (14, 2071, 14);
INSERT INTO Detalle VALUES (14, 2242, 14);
INSERT INTO Detalle VALUES (14, 2419, 14);
INSERT INTO Detalle VALUES (14, 2916, 14);
INSERT INTO Detalle VALUES (14, 2917, 14);
INSERT INTO Detalle VALUES (14, 2948, 14);
INSERT INTO Detalle VALUES (14, 2949, 14);
INSERT INTO Detalle VALUES (14, 2971, 14);
INSERT INTO Detalle VALUES (14, 2972, 14);
INSERT INTO Detalle VALUES (14, 2973, 14);
INSERT INTO Detalle VALUES (14, 2977, 14);
INSERT INTO Detalle VALUES (14, 2981, 14);
INSERT INTO Detalle VALUES (14, 2982, 14);
INSERT INTO Detalle VALUES (14, 2983, 14);
INSERT INTO Detalle VALUES (14, 2992, 14);
INSERT INTO Detalle VALUES (14, 3024, 14);
INSERT INTO Detalle VALUES (14, 3025, 14);
INSERT INTO Detalle VALUES (14, 3028, 14);
INSERT INTO Detalle VALUES (14, 3059, 14);
INSERT INTO Detalle VALUES (14, 3063, 14);
INSERT INTO Detalle VALUES (16, 9, 16);
INSERT INTO Detalle VALUES (16, 17, 16);
INSERT INTO Detalle VALUES (16, 19, 16);
INSERT INTO Detalle VALUES (16, 24, 16);
INSERT INTO Detalle VALUES (16, 45, 16);
INSERT INTO Detalle VALUES (16, 54, 16);
INSERT INTO Detalle VALUES (16, 55, 16);
INSERT INTO Detalle VALUES (16, 58, 16);
INSERT INTO Detalle VALUES (16, 72, 16);
INSERT INTO Detalle VALUES (16, 107, 16);
INSERT INTO Detalle VALUES (16, 129, 16);
INSERT INTO Detalle VALUES (16, 163, 16);
INSERT INTO Detalle VALUES (16, 165, 16);
INSERT INTO Detalle VALUES (16, 174, 16);
INSERT INTO Detalle VALUES (16, 225, 16);
INSERT INTO Detalle VALUES (16, 643, 16);
INSERT INTO Detalle VALUES (16, 666, 16);
INSERT INTO Detalle VALUES (16, 739, 16);
INSERT INTO Detalle VALUES (16, 756, 16);
INSERT INTO Detalle VALUES (16, 940, 16);
INSERT INTO Detalle VALUES (16, 1126, 16);
INSERT INTO Detalle VALUES (16, 1180, 16);
INSERT INTO Detalle VALUES (16, 1304, 16);
INSERT INTO Detalle VALUES (16, 1697, 16);
INSERT INTO Detalle VALUES (16, 1699, 16);
INSERT INTO Detalle VALUES (16, 1963, 16);
INSERT INTO Detalle VALUES (16, 2582, 16);
INSERT INTO Detalle VALUES (40, 5, 40);
INSERT INTO Detalle VALUES (40, 21, 40);
INSERT INTO Detalle VALUES (40, 87, 40);
INSERT INTO Detalle VALUES (40, 102, 40);
INSERT INTO Detalle VALUES (40, 219, 40);
INSERT INTO Detalle VALUES (40, 613, 40);
INSERT INTO Detalle VALUES (40, 663, 40);
INSERT INTO Detalle VALUES (40, 684, 40);
INSERT INTO Detalle VALUES (40, 748, 40);
INSERT INTO Detalle VALUES (40, 772, 40);
INSERT INTO Detalle VALUES (40, 832, 40);
INSERT INTO Detalle VALUES (40, 836, 40);
INSERT INTO Detalle VALUES (40, 940, 40);
INSERT INTO Detalle VALUES (40, 1177, 40);
INSERT INTO Detalle VALUES (40, 1281, 40);
INSERT INTO Detalle VALUES (40, 1512, 40);
INSERT INTO Detalle VALUES (40, 1647, 40);
INSERT INTO Detalle VALUES (40, 1648, 40);
INSERT INTO Detalle VALUES (40, 1650, 40);
INSERT INTO Detalle VALUES (40, 1655, 40);
INSERT INTO Detalle VALUES (40, 1776, 40);
INSERT INTO Detalle VALUES (40, 1866, 40);
INSERT INTO Detalle VALUES (40, 1879, 40);
INSERT INTO Detalle VALUES (40, 1891, 40);
INSERT INTO Detalle VALUES (40, 1894, 40);
INSERT INTO Detalle VALUES (40, 1895, 40);
INSERT INTO Detalle VALUES (40, 1896, 40);
INSERT INTO Detalle VALUES (40, 1897, 40);
INSERT INTO Detalle VALUES (40, 1898, 40);
INSERT INTO Detalle VALUES (40, 1985, 40);
INSERT INTO Detalle VALUES (40, 1986, 40);
INSERT INTO Detalle VALUES (40, 2002, 40);
INSERT INTO Detalle VALUES (40, 2242, 40);
INSERT INTO Detalle VALUES (40, 3044, 40);
INSERT INTO Detalle VALUES (47, 102, 47);
INSERT INTO Detalle VALUES (47, 185, 47);
INSERT INTO Detalle VALUES (47, 186, 47);
INSERT INTO Detalle VALUES (47, 684, 47);
INSERT INTO Detalle VALUES (47, 694, 47);
INSERT INTO Detalle VALUES (47, 748, 47);
INSERT INTO Detalle VALUES (47, 760, 47);
INSERT INTO Detalle VALUES (47, 764, 47);
INSERT INTO Detalle VALUES (47, 832, 47);
INSERT INTO Detalle VALUES (47, 940, 47);
INSERT INTO Detalle VALUES (47, 1047, 47);
INSERT INTO Detalle VALUES (47, 1081, 47);
INSERT INTO Detalle VALUES (47, 1620, 47);
INSERT INTO Detalle VALUES (47, 1621, 47);
INSERT INTO Detalle VALUES (47, 1624, 47);
INSERT INTO Detalle VALUES (47, 1625, 47);
INSERT INTO Detalle VALUES (47, 1626, 47);
INSERT INTO Detalle VALUES (47, 1627, 47);
INSERT INTO Detalle VALUES (47, 1628, 47);
INSERT INTO Detalle VALUES (47, 1629, 47);
INSERT INTO Detalle VALUES (47, 1630, 47);
INSERT INTO Detalle VALUES (47, 1631, 47);
INSERT INTO Detalle VALUES (47, 1632, 47);
INSERT INTO Detalle VALUES (47, 1633, 47);
INSERT INTO Detalle VALUES (47, 1883, 47);
INSERT INTO Detalle VALUES (47, 2242, 47);
INSERT INTO Detalle VALUES (47, 3000, 47);
INSERT INTO Detalle VALUES (51, 9, 51);
INSERT INTO Detalle VALUES (51, 17, 51);
INSERT INTO Detalle VALUES (51, 19, 51);
INSERT INTO Detalle VALUES (51, 24, 51);
INSERT INTO Detalle VALUES (51, 25, 51);
INSERT INTO Detalle VALUES (51, 45, 51);
INSERT INTO Detalle VALUES (51, 54, 51);
INSERT INTO Detalle VALUES (51, 58, 51);
INSERT INTO Detalle VALUES (51, 59, 51);
INSERT INTO Detalle VALUES (51, 129, 51);
INSERT INTO Detalle VALUES (51, 165, 51);
INSERT INTO Detalle VALUES (51, 174, 51);
INSERT INTO Detalle VALUES (51, 245, 51);
INSERT INTO Detalle VALUES (51, 292, 51);
INSERT INTO Detalle VALUES (51, 331, 51);
INSERT INTO Detalle VALUES (51, 601, 51);
INSERT INTO Detalle VALUES (51, 1309, 51);
INSERT INTO Detalle VALUES (52, 9, 52);
INSERT INTO Detalle VALUES (52, 21, 52);
INSERT INTO Detalle VALUES (52, 43, 52);
INSERT INTO Detalle VALUES (52, 54, 52);
INSERT INTO Detalle VALUES (52, 58, 52);
INSERT INTO Detalle VALUES (52, 74, 52);
INSERT INTO Detalle VALUES (52, 134, 52);
INSERT INTO Detalle VALUES (52, 174, 52);
INSERT INTO Detalle VALUES (52, 203, 52);
INSERT INTO Detalle VALUES (52, 292, 52);
INSERT INTO Detalle VALUES (52, 732, 52);
INSERT INTO Detalle VALUES (52, 827, 52);
INSERT INTO Detalle VALUES (52, 1009, 52);
INSERT INTO Detalle VALUES (52, 1177, 52);
INSERT INTO Detalle VALUES (52, 1181, 52);
INSERT INTO Detalle VALUES (52, 1561, 52);
INSERT INTO Detalle VALUES (52, 1724, 52);
INSERT INTO Detalle VALUES (53, 21, 53);
INSERT INTO Detalle VALUES (53, 22, 53);
INSERT INTO Detalle VALUES (53, 43, 53);
INSERT INTO Detalle VALUES (53, 54, 53);
INSERT INTO Detalle VALUES (53, 58, 53);
INSERT INTO Detalle VALUES (53, 74, 53);
INSERT INTO Detalle VALUES (53, 134, 53);
INSERT INTO Detalle VALUES (53, 174, 53);
INSERT INTO Detalle VALUES (53, 203, 53);
INSERT INTO Detalle VALUES (53, 494, 53);
INSERT INTO Detalle VALUES (53, 732, 53);
INSERT INTO Detalle VALUES (53, 827, 53);
INSERT INTO Detalle VALUES (53, 1009, 53);
INSERT INTO Detalle VALUES (53, 1177, 53);
INSERT INTO Detalle VALUES (53, 1181, 53);
INSERT INTO Detalle VALUES (53, 1561, 53);
INSERT INTO Detalle VALUES (54, 19, 54);
INSERT INTO Detalle VALUES (54, 58, 54);
INSERT INTO Detalle VALUES (54, 129, 54);
INSERT INTO Detalle VALUES (54, 700, 54);
INSERT INTO Detalle VALUES (54, 770, 54);
INSERT INTO Detalle VALUES (54, 809, 54);
INSERT INTO Detalle VALUES (54, 810, 54);
INSERT INTO Detalle VALUES (54, 823, 54);
INSERT INTO Detalle VALUES (245, 10, 245);
INSERT INTO Detalle VALUES (245, 13, 245);
INSERT INTO Detalle VALUES (245, 45, 245);
INSERT INTO Detalle VALUES (245, 53, 245);
INSERT INTO Detalle VALUES (245, 54, 245);
INSERT INTO Detalle VALUES (245, 55, 245);
INSERT INTO Detalle VALUES (245, 58, 245);
INSERT INTO Detalle VALUES (245, 72, 245);
INSERT INTO Detalle VALUES (245, 111, 245);
INSERT INTO Detalle VALUES (245, 120, 245);
INSERT INTO Detalle VALUES (245, 163, 245);
INSERT INTO Detalle VALUES (245, 165, 245);
INSERT INTO Detalle VALUES (245, 220, 245);
INSERT INTO Detalle VALUES (245, 225, 245);
INSERT INTO Detalle VALUES (245, 226, 245);
INSERT INTO Detalle VALUES (245, 302, 245);
INSERT INTO Detalle VALUES (245, 375, 245);
INSERT INTO Detalle VALUES (245, 643, 245);
INSERT INTO Detalle VALUES (245, 721, 245);
INSERT INTO Detalle VALUES (245, 739, 245);
INSERT INTO Detalle VALUES (245, 857, 245);
INSERT INTO Detalle VALUES (245, 859, 245);
INSERT INTO Detalle VALUES (245, 870, 245);
INSERT INTO Detalle VALUES (245, 940, 245);
INSERT INTO Detalle VALUES (245, 1152, 245);
INSERT INTO Detalle VALUES (245, 1936, 245);
INSERT INTO Detalle VALUES (245, 1963, 245);
INSERT INTO Detalle VALUES (245, 2002, 245);
INSERT INTO Detalle VALUES (245, 2022, 245);
INSERT INTO Detalle VALUES (245, 2023, 245);
INSERT INTO Detalle VALUES (245, 2174, 245);
INSERT INTO Detalle VALUES (245, 2255, 245);
INSERT INTO Detalle VALUES (245, 2590, 245);
INSERT INTO Detalle VALUES (245, 2617, 245);
INSERT INTO Detalle VALUES (245, 2618, 245);
INSERT INTO Detalle VALUES (245, 2619, 245);
INSERT INTO Detalle VALUES (245, 2627, 245);
INSERT INTO Detalle VALUES (245, 2634, 245);
INSERT INTO Detalle VALUES (245, 2651, 245);
INSERT INTO Detalle VALUES (245, 2652, 245);
INSERT INTO Detalle VALUES (245, 2658, 245);
INSERT INTO Detalle VALUES (245, 2671, 245);
INSERT INTO Detalle VALUES (245, 2672, 245);
INSERT INTO Detalle VALUES (245, 2692, 245);
INSERT INTO Detalle VALUES (245, 2700, 245);
INSERT INTO Detalle VALUES (245, 2701, 245);
INSERT INTO Detalle VALUES (245, 2719, 245);
INSERT INTO Detalle VALUES (245, 2723, 245);
INSERT INTO Detalle VALUES (245, 3374, 245);
INSERT INTO Detalle VALUES (246, 10, 246);
INSERT INTO Detalle VALUES (246, 19, 246);
INSERT INTO Detalle VALUES (246, 43, 246);
INSERT INTO Detalle VALUES (246, 45, 246);
INSERT INTO Detalle VALUES (246, 53, 246);
INSERT INTO Detalle VALUES (246, 54, 246);
INSERT INTO Detalle VALUES (246, 55, 246);
INSERT INTO Detalle VALUES (246, 58, 246);
INSERT INTO Detalle VALUES (246, 72, 246);
INSERT INTO Detalle VALUES (246, 111, 246);
INSERT INTO Detalle VALUES (246, 120, 246);
INSERT INTO Detalle VALUES (246, 163, 246);
INSERT INTO Detalle VALUES (246, 165, 246);
INSERT INTO Detalle VALUES (246, 174, 246);
INSERT INTO Detalle VALUES (246, 220, 246);
INSERT INTO Detalle VALUES (246, 225, 246);
INSERT INTO Detalle VALUES (246, 226, 246);
INSERT INTO Detalle VALUES (246, 643, 246);
INSERT INTO Detalle VALUES (246, 666, 246);
INSERT INTO Detalle VALUES (246, 667, 246);
INSERT INTO Detalle VALUES (246, 721, 246);
INSERT INTO Detalle VALUES (246, 739, 246);
INSERT INTO Detalle VALUES (246, 857, 246);
INSERT INTO Detalle VALUES (246, 859, 246);
INSERT INTO Detalle VALUES (246, 929, 246);
INSERT INTO Detalle VALUES (246, 940, 246);
INSERT INTO Detalle VALUES (246, 1152, 246);
INSERT INTO Detalle VALUES (246, 1187, 246);
INSERT INTO Detalle VALUES (246, 1277, 246);
INSERT INTO Detalle VALUES (246, 1486, 246);
INSERT INTO Detalle VALUES (246, 1765, 246);
INSERT INTO Detalle VALUES (246, 2002, 246);
INSERT INTO Detalle VALUES (246, 2022, 246);
INSERT INTO Detalle VALUES (246, 2023, 246);
INSERT INTO Detalle VALUES (246, 2075, 246);
INSERT INTO Detalle VALUES (246, 2076, 246);
INSERT INTO Detalle VALUES (246, 2121, 246);
INSERT INTO Detalle VALUES (246, 2123, 246);
INSERT INTO Detalle VALUES (246, 2124, 246);
INSERT INTO Detalle VALUES (246, 2125, 246);
INSERT INTO Detalle VALUES (246, 2174, 246);
INSERT INTO Detalle VALUES (246, 2255, 246);
INSERT INTO Detalle VALUES (246, 2444, 246);
INSERT INTO Detalle VALUES (246, 2451, 246);
INSERT INTO Detalle VALUES (246, 2590, 246);
INSERT INTO Detalle VALUES (246, 2627, 246);
INSERT INTO Detalle VALUES (246, 2634, 246);
INSERT INTO Detalle VALUES (246, 2651, 246);
INSERT INTO Detalle VALUES (246, 2652, 246);
INSERT INTO Detalle VALUES (246, 2671, 246);
INSERT INTO Detalle VALUES (246, 2719, 246);
INSERT INTO Detalle VALUES (246, 2727, 246);
INSERT INTO Detalle VALUES (246, 2750, 246);
INSERT INTO Detalle VALUES (246, 3212, 246);
INSERT INTO Detalle VALUES (246, 3374, 246);
INSERT INTO Detalle VALUES (247, 11, 247);
INSERT INTO Detalle VALUES (247, 45, 247);
INSERT INTO Detalle VALUES (247, 54, 247);
INSERT INTO Detalle VALUES (247, 55, 247);
INSERT INTO Detalle VALUES (247, 72, 247);
INSERT INTO Detalle VALUES (247, 111, 247);
INSERT INTO Detalle VALUES (247, 163, 247);
INSERT INTO Detalle VALUES (247, 643, 247);
INSERT INTO Detalle VALUES (247, 739, 247);
INSERT INTO Detalle VALUES (247, 940, 247);
INSERT INTO Detalle VALUES (247, 1055, 247);
INSERT INTO Detalle VALUES (247, 1277, 247);
INSERT INTO Detalle VALUES (247, 1963, 247);
INSERT INTO Detalle VALUES (247, 2002, 247);
INSERT INTO Detalle VALUES (247, 2022, 247);
INSERT INTO Detalle VALUES (247, 2023, 247);
INSERT INTO Detalle VALUES (247, 2255, 247);
INSERT INTO Detalle VALUES (247, 2413, 247);
INSERT INTO Detalle VALUES (247, 2753, 247);
INSERT INTO Detalle VALUES (247, 3374, 247);
INSERT INTO Detalle VALUES (249, 9, 249);
INSERT INTO Detalle VALUES (249, 17, 249);
INSERT INTO Detalle VALUES (249, 22, 249);
INSERT INTO Detalle VALUES (249, 54, 249);
INSERT INTO Detalle VALUES (249, 58, 249);
INSERT INTO Detalle VALUES (249, 165, 249);
INSERT INTO Detalle VALUES (249, 174, 249);
INSERT INTO Detalle VALUES (249, 643, 249);
INSERT INTO Detalle VALUES (249, 666, 249);
INSERT INTO Detalle VALUES (249, 1941, 249);
INSERT INTO Detalle VALUES (249, 1990, 249);
INSERT INTO Detalle VALUES (249, 2002, 249);
INSERT INTO Detalle VALUES (249, 2761, 249);
INSERT INTO Detalle VALUES (250, 9, 250);
INSERT INTO Detalle VALUES (250, 17, 250);
INSERT INTO Detalle VALUES (250, 22, 250);
INSERT INTO Detalle VALUES (250, 54, 250);
INSERT INTO Detalle VALUES (250, 58, 250);
INSERT INTO Detalle VALUES (250, 165, 250);
INSERT INTO Detalle VALUES (250, 174, 250);
INSERT INTO Detalle VALUES (250, 643, 250);
INSERT INTO Detalle VALUES (250, 666, 250);
INSERT INTO Detalle VALUES (250, 1304, 250);
INSERT INTO Detalle VALUES (250, 1941, 250);
INSERT INTO Detalle VALUES (250, 1990, 250);
INSERT INTO Detalle VALUES (250, 2002, 250);
INSERT INTO Detalle VALUES (250, 2761, 250);
INSERT INTO Detalle VALUES (252, 9, 252);
INSERT INTO Detalle VALUES (252, 11, 252);
INSERT INTO Detalle VALUES (252, 17, 252);
INSERT INTO Detalle VALUES (252, 19, 252);
INSERT INTO Detalle VALUES (252, 20, 252);
INSERT INTO Detalle VALUES (252, 22, 252);
INSERT INTO Detalle VALUES (252, 24, 252);
INSERT INTO Detalle VALUES (252, 25, 252);
INSERT INTO Detalle VALUES (252, 30, 252);
INSERT INTO Detalle VALUES (252, 42, 252);
INSERT INTO Detalle VALUES (252, 45, 252);
INSERT INTO Detalle VALUES (252, 54, 252);
INSERT INTO Detalle VALUES (252, 55, 252);
INSERT INTO Detalle VALUES (252, 57, 252);
INSERT INTO Detalle VALUES (252, 58, 252);
INSERT INTO Detalle VALUES (252, 59, 252);
INSERT INTO Detalle VALUES (252, 61, 252);
INSERT INTO Detalle VALUES (252, 65, 252);
INSERT INTO Detalle VALUES (252, 74, 252);
INSERT INTO Detalle VALUES (252, 75, 252);
INSERT INTO Detalle VALUES (252, 78, 252);
INSERT INTO Detalle VALUES (252, 83, 252);
INSERT INTO Detalle VALUES (252, 107, 252);
INSERT INTO Detalle VALUES (252, 109, 252);
INSERT INTO Detalle VALUES (252, 111, 252);
INSERT INTO Detalle VALUES (252, 117, 252);
INSERT INTO Detalle VALUES (252, 120, 252);
INSERT INTO Detalle VALUES (252, 128, 252);
INSERT INTO Detalle VALUES (252, 135, 252);
INSERT INTO Detalle VALUES (252, 142, 252);
INSERT INTO Detalle VALUES (252, 163, 252);
INSERT INTO Detalle VALUES (252, 165, 252);
INSERT INTO Detalle VALUES (252, 174, 252);
INSERT INTO Detalle VALUES (252, 203, 252);
INSERT INTO Detalle VALUES (252, 204, 252);
INSERT INTO Detalle VALUES (252, 228, 252);
INSERT INTO Detalle VALUES (252, 230, 252);
INSERT INTO Detalle VALUES (252, 240, 252);
INSERT INTO Detalle VALUES (252, 283, 252);
INSERT INTO Detalle VALUES (252, 292, 252);
INSERT INTO Detalle VALUES (252, 310, 252);
INSERT INTO Detalle VALUES (252, 338, 252);
INSERT INTO Detalle VALUES (252, 375, 252);
INSERT INTO Detalle VALUES (252, 401, 252);
INSERT INTO Detalle VALUES (252, 408, 252);
INSERT INTO Detalle VALUES (252, 413, 252);
INSERT INTO Detalle VALUES (252, 447, 252);
INSERT INTO Detalle VALUES (252, 473, 252);
INSERT INTO Detalle VALUES (252, 492, 252);
INSERT INTO Detalle VALUES (252, 506, 252);
INSERT INTO Detalle VALUES (252, 593, 252);
INSERT INTO Detalle VALUES (252, 609, 252);
INSERT INTO Detalle VALUES (252, 651, 252);
INSERT INTO Detalle VALUES (252, 666, 252);
INSERT INTO Detalle VALUES (252, 681, 252);
INSERT INTO Detalle VALUES (252, 687, 252);
INSERT INTO Detalle VALUES (252, 725, 252);
INSERT INTO Detalle VALUES (252, 736, 252);
INSERT INTO Detalle VALUES (252, 768, 252);
INSERT INTO Detalle VALUES (252, 769, 252);
INSERT INTO Detalle VALUES (252, 785, 252);
INSERT INTO Detalle VALUES (252, 789, 252);
INSERT INTO Detalle VALUES (252, 853, 252);
INSERT INTO Detalle VALUES (252, 855, 252);
INSERT INTO Detalle VALUES (252, 929, 252);
INSERT INTO Detalle VALUES (252, 940, 252);
INSERT INTO Detalle VALUES (252, 950, 252);
INSERT INTO Detalle VALUES (252, 951, 252);
INSERT INTO Detalle VALUES (252, 952, 252);
INSERT INTO Detalle VALUES (252, 961, 252);
INSERT INTO Detalle VALUES (252, 981, 252);
INSERT INTO Detalle VALUES (252, 983, 252);
INSERT INTO Detalle VALUES (252, 989, 252);
INSERT INTO Detalle VALUES (252, 1014, 252);
INSERT INTO Detalle VALUES (252, 1025, 252);
INSERT INTO Detalle VALUES (252, 1026, 252);
INSERT INTO Detalle VALUES (252, 1029, 252);
INSERT INTO Detalle VALUES (252, 1042, 252);
INSERT INTO Detalle VALUES (252, 1049, 252);
INSERT INTO Detalle VALUES (252, 1113, 252);
INSERT INTO Detalle VALUES (252, 1126, 252);
INSERT INTO Detalle VALUES (252, 1160, 252);
INSERT INTO Detalle VALUES (252, 1184, 252);
INSERT INTO Detalle VALUES (252, 1185, 252);
INSERT INTO Detalle VALUES (252, 1187, 252);
INSERT INTO Detalle VALUES (252, 1214, 252);
INSERT INTO Detalle VALUES (252, 1277, 252);
INSERT INTO Detalle VALUES (252, 1281, 252);
INSERT INTO Detalle VALUES (252, 1285, 252);
INSERT INTO Detalle VALUES (252, 1299, 252);
INSERT INTO Detalle VALUES (252, 1304, 252);
INSERT INTO Detalle VALUES (252, 1311, 252);
INSERT INTO Detalle VALUES (252, 1317, 252);
INSERT INTO Detalle VALUES (252, 1349, 252);
INSERT INTO Detalle VALUES (252, 1373, 252);
INSERT INTO Detalle VALUES (252, 1424, 252);
INSERT INTO Detalle VALUES (252, 1425, 252);
INSERT INTO Detalle VALUES (252, 1440, 252);
INSERT INTO Detalle VALUES (252, 1488, 252);
INSERT INTO Detalle VALUES (252, 1561, 252);
INSERT INTO Detalle VALUES (252, 1678, 252);
INSERT INTO Detalle VALUES (252, 1680, 252);
INSERT INTO Detalle VALUES (252, 1697, 252);
INSERT INTO Detalle VALUES (252, 1699, 252);
INSERT INTO Detalle VALUES (252, 1701, 252);
INSERT INTO Detalle VALUES (252, 1704, 252);
INSERT INTO Detalle VALUES (252, 1705, 252);
INSERT INTO Detalle VALUES (252, 1706, 252);
INSERT INTO Detalle VALUES (252, 1711, 252);
INSERT INTO Detalle VALUES (252, 1712, 252);
INSERT INTO Detalle VALUES (252, 1713, 252);
INSERT INTO Detalle VALUES (252, 1714, 252);
INSERT INTO Detalle VALUES (252, 1715, 252);
INSERT INTO Detalle VALUES (252, 1716, 252);
INSERT INTO Detalle VALUES (252, 1717, 252);
INSERT INTO Detalle VALUES (252, 1719, 252);
INSERT INTO Detalle VALUES (252, 1720, 252);
INSERT INTO Detalle VALUES (252, 1721, 252);
INSERT INTO Detalle VALUES (252, 1725, 252);
INSERT INTO Detalle VALUES (252, 1728, 252);
INSERT INTO Detalle VALUES (252, 1729, 252);
INSERT INTO Detalle VALUES (252, 1730, 252);
INSERT INTO Detalle VALUES (252, 1731, 252);
INSERT INTO Detalle VALUES (252, 1732, 252);
INSERT INTO Detalle VALUES (252, 1733, 252);
INSERT INTO Detalle VALUES (252, 1734, 252);
INSERT INTO Detalle VALUES (252, 1745, 252);
INSERT INTO Detalle VALUES (252, 1749, 252);
INSERT INTO Detalle VALUES (252, 1771, 252);
INSERT INTO Detalle VALUES (252, 1805, 252);
INSERT INTO Detalle VALUES (252, 1815, 252);
INSERT INTO Detalle VALUES (252, 1837, 252);
INSERT INTO Detalle VALUES (252, 1841, 252);
INSERT INTO Detalle VALUES (252, 1842, 252);
INSERT INTO Detalle VALUES (252, 1843, 252);
INSERT INTO Detalle VALUES (252, 1844, 252);
INSERT INTO Detalle VALUES (252, 1845, 252);
INSERT INTO Detalle VALUES (252, 1848, 252);
INSERT INTO Detalle VALUES (252, 1849, 252);
INSERT INTO Detalle VALUES (252, 1850, 252);
INSERT INTO Detalle VALUES (252, 1852, 252);
INSERT INTO Detalle VALUES (252, 1854, 252);
INSERT INTO Detalle VALUES (252, 1855, 252);
INSERT INTO Detalle VALUES (252, 1857, 252);
INSERT INTO Detalle VALUES (252, 1858, 252);
INSERT INTO Detalle VALUES (252, 1859, 252);
INSERT INTO Detalle VALUES (252, 1860, 252);
INSERT INTO Detalle VALUES (252, 1861, 252);
INSERT INTO Detalle VALUES (252, 1862, 252);
INSERT INTO Detalle VALUES (252, 1863, 252);
INSERT INTO Detalle VALUES (252, 1883, 252);
INSERT INTO Detalle VALUES (252, 1926, 252);
INSERT INTO Detalle VALUES (252, 1935, 252);
INSERT INTO Detalle VALUES (252, 1940, 252);
INSERT INTO Detalle VALUES (252, 1952, 252);
INSERT INTO Detalle VALUES (252, 1953, 252);
INSERT INTO Detalle VALUES (252, 1956, 252);
INSERT INTO Detalle VALUES (252, 1959, 252);
INSERT INTO Detalle VALUES (252, 1963, 252);
INSERT INTO Detalle VALUES (252, 1965, 252);
INSERT INTO Detalle VALUES (252, 1966, 252);
INSERT INTO Detalle VALUES (252, 1970, 252);
INSERT INTO Detalle VALUES (252, 1974, 252);
INSERT INTO Detalle VALUES (252, 1983, 252);
INSERT INTO Detalle VALUES (252, 1987, 252);
INSERT INTO Detalle VALUES (252, 1994, 252);
INSERT INTO Detalle VALUES (252, 2002, 252);
INSERT INTO Detalle VALUES (252, 2007, 252);
INSERT INTO Detalle VALUES (252, 2022, 252);
INSERT INTO Detalle VALUES (252, 2023, 252);
INSERT INTO Detalle VALUES (252, 2024, 252);
INSERT INTO Detalle VALUES (252, 2025, 252);
INSERT INTO Detalle VALUES (252, 2027, 252);
INSERT INTO Detalle VALUES (252, 2030, 252);
INSERT INTO Detalle VALUES (252, 2035, 252);
INSERT INTO Detalle VALUES (252, 2044, 252);
INSERT INTO Detalle VALUES (252, 2047, 252);
INSERT INTO Detalle VALUES (252, 2048, 252);
INSERT INTO Detalle VALUES (252, 2049, 252);
INSERT INTO Detalle VALUES (252, 2050, 252);
INSERT INTO Detalle VALUES (252, 2051, 252);
INSERT INTO Detalle VALUES (252, 2052, 252);
INSERT INTO Detalle VALUES (252, 2053, 252);
INSERT INTO Detalle VALUES (252, 2054, 252);
INSERT INTO Detalle VALUES (252, 2055, 252);
INSERT INTO Detalle VALUES (252, 2056, 252);
INSERT INTO Detalle VALUES (252, 2058, 252);
INSERT INTO Detalle VALUES (252, 2059, 252);
INSERT INTO Detalle VALUES (252, 2063, 252);
INSERT INTO Detalle VALUES (252, 2064, 252);
INSERT INTO Detalle VALUES (252, 2067, 252);
INSERT INTO Detalle VALUES (252, 2070, 252);
INSERT INTO Detalle VALUES (252, 2072, 252);
INSERT INTO Detalle VALUES (252, 2077, 252);
INSERT INTO Detalle VALUES (252, 2090, 252);
INSERT INTO Detalle VALUES (252, 2120, 252);
INSERT INTO Detalle VALUES (252, 2177, 252);
INSERT INTO Detalle VALUES (252, 2178, 252);
INSERT INTO Detalle VALUES (252, 2188, 252);
INSERT INTO Detalle VALUES (252, 2301, 252);
INSERT INTO Detalle VALUES (252, 2302, 252);
INSERT INTO Detalle VALUES (252, 2304, 252);
INSERT INTO Detalle VALUES (252, 2305, 252);
INSERT INTO Detalle VALUES (252, 2306, 252);
INSERT INTO Detalle VALUES (252, 2307, 252);
INSERT INTO Detalle VALUES (252, 2308, 252);
INSERT INTO Detalle VALUES (252, 2336, 252);
INSERT INTO Detalle VALUES (252, 2338, 252);
INSERT INTO Detalle VALUES (252, 2367, 252);
INSERT INTO Detalle VALUES (252, 2396, 252);
INSERT INTO Detalle VALUES (252, 2397, 252);
INSERT INTO Detalle VALUES (252, 2398, 252);
INSERT INTO Detalle VALUES (252, 2400, 252);
INSERT INTO Detalle VALUES (252, 2447, 252);
INSERT INTO Detalle VALUES (252, 2601, 252);
INSERT INTO Detalle VALUES (252, 2615, 252);
INSERT INTO Detalle VALUES (252, 2649, 252);
INSERT INTO Detalle VALUES (252, 2653, 252);
INSERT INTO Detalle VALUES (252, 2668, 252);
INSERT INTO Detalle VALUES (252, 2673, 252);
INSERT INTO Detalle VALUES (252, 2674, 252);
INSERT INTO Detalle VALUES (252, 2675, 252);
INSERT INTO Detalle VALUES (252, 2677, 252);
INSERT INTO Detalle VALUES (252, 2678, 252);
INSERT INTO Detalle VALUES (252, 2687, 252);
INSERT INTO Detalle VALUES (252, 2688, 252);
INSERT INTO Detalle VALUES (252, 2695, 252);
INSERT INTO Detalle VALUES (252, 2697, 252);
INSERT INTO Detalle VALUES (252, 2700, 252);
INSERT INTO Detalle VALUES (252, 2701, 252);
INSERT INTO Detalle VALUES (252, 2703, 252);
INSERT INTO Detalle VALUES (252, 2711, 252);
INSERT INTO Detalle VALUES (252, 2720, 252);
INSERT INTO Detalle VALUES (252, 2721, 252);
INSERT INTO Detalle VALUES (252, 2724, 252);
INSERT INTO Detalle VALUES (252, 2731, 252);
INSERT INTO Detalle VALUES (252, 2733, 252);
INSERT INTO Detalle VALUES (252, 2761, 252);
INSERT INTO Detalle VALUES (252, 2763, 252);
INSERT INTO Detalle VALUES (252, 2765, 252);
INSERT INTO Detalle VALUES (252, 2767, 252);
INSERT INTO Detalle VALUES (252, 2768, 252);
INSERT INTO Detalle VALUES (252, 2773, 252);
INSERT INTO Detalle VALUES (252, 2775, 252);
INSERT INTO Detalle VALUES (252, 2777, 252);
INSERT INTO Detalle VALUES (252, 2780, 252);
INSERT INTO Detalle VALUES (252, 2781, 252);
INSERT INTO Detalle VALUES (252, 2789, 252);
INSERT INTO Detalle VALUES (252, 2978, 252);
INSERT INTO Detalle VALUES (252, 3100, 252);
INSERT INTO Detalle VALUES (252, 3106, 252);
INSERT INTO Detalle VALUES (252, 3114, 252);
INSERT INTO Detalle VALUES (252, 3120, 252);
INSERT INTO Detalle VALUES (252, 3309, 252);
INSERT INTO Detalle VALUES (252, 3319, 252);
INSERT INTO Detalle VALUES (253, 9, 253);
INSERT INTO Detalle VALUES (253, 17, 253);
INSERT INTO Detalle VALUES (253, 24, 253);
INSERT INTO Detalle VALUES (253, 54, 253);
INSERT INTO Detalle VALUES (253, 61, 253);
INSERT INTO Detalle VALUES (253, 74, 253);
INSERT INTO Detalle VALUES (253, 75, 253);
INSERT INTO Detalle VALUES (253, 128, 253);
INSERT INTO Detalle VALUES (253, 174, 253);
INSERT INTO Detalle VALUES (253, 626, 253);
INSERT INTO Detalle VALUES (253, 666, 253);
INSERT INTO Detalle VALUES (253, 768, 253);
INSERT INTO Detalle VALUES (253, 769, 253);
INSERT INTO Detalle VALUES (253, 940, 253);
INSERT INTO Detalle VALUES (253, 1155, 253);
INSERT INTO Detalle VALUES (253, 1187, 253);
INSERT INTO Detalle VALUES (253, 1277, 253);
INSERT INTO Detalle VALUES (253, 1425, 253);
INSERT INTO Detalle VALUES (253, 1561, 253);
INSERT INTO Detalle VALUES (253, 1612, 253);
INSERT INTO Detalle VALUES (253, 1655, 253);
INSERT INTO Detalle VALUES (253, 1701, 253);
INSERT INTO Detalle VALUES (253, 1704, 253);
INSERT INTO Detalle VALUES (253, 1705, 253);
INSERT INTO Detalle VALUES (253, 1706, 253);
INSERT INTO Detalle VALUES (253, 1708, 253);
INSERT INTO Detalle VALUES (253, 1713, 253);
INSERT INTO Detalle VALUES (253, 1725, 253);
INSERT INTO Detalle VALUES (253, 1736, 253);
INSERT INTO Detalle VALUES (253, 2002, 253);
INSERT INTO Detalle VALUES (253, 2040, 253);
INSERT INTO Detalle VALUES (253, 2717, 253);
INSERT INTO Detalle VALUES (255, 7, 255);
INSERT INTO Detalle VALUES (255, 9, 255);
INSERT INTO Detalle VALUES (255, 11, 255);
INSERT INTO Detalle VALUES (255, 17, 255);
INSERT INTO Detalle VALUES (255, 20, 255);
INSERT INTO Detalle VALUES (255, 22, 255);
INSERT INTO Detalle VALUES (255, 24, 255);
INSERT INTO Detalle VALUES (255, 25, 255);
INSERT INTO Detalle VALUES (255, 46, 255);
INSERT INTO Detalle VALUES (255, 53, 255);
INSERT INTO Detalle VALUES (255, 54, 255);
INSERT INTO Detalle VALUES (255, 55, 255);
INSERT INTO Detalle VALUES (255, 58, 255);
INSERT INTO Detalle VALUES (255, 61, 255);
INSERT INTO Detalle VALUES (255, 65, 255);
INSERT INTO Detalle VALUES (255, 68, 255);
INSERT INTO Detalle VALUES (255, 70, 255);
INSERT INTO Detalle VALUES (255, 71, 255);
INSERT INTO Detalle VALUES (255, 74, 255);
INSERT INTO Detalle VALUES (255, 75, 255);
INSERT INTO Detalle VALUES (255, 79, 255);
INSERT INTO Detalle VALUES (255, 80, 255);
INSERT INTO Detalle VALUES (255, 109, 255);
INSERT INTO Detalle VALUES (255, 111, 255);
INSERT INTO Detalle VALUES (255, 129, 255);
INSERT INTO Detalle VALUES (255, 132, 255);
INSERT INTO Detalle VALUES (255, 141, 255);
INSERT INTO Detalle VALUES (255, 152, 255);
INSERT INTO Detalle VALUES (255, 163, 255);
INSERT INTO Detalle VALUES (255, 165, 255);
INSERT INTO Detalle VALUES (255, 168, 255);
INSERT INTO Detalle VALUES (255, 173, 255);
INSERT INTO Detalle VALUES (255, 174, 255);
INSERT INTO Detalle VALUES (255, 180, 255);
INSERT INTO Detalle VALUES (255, 181, 255);
INSERT INTO Detalle VALUES (255, 197, 255);
INSERT INTO Detalle VALUES (255, 221, 255);
INSERT INTO Detalle VALUES (255, 225, 255);
INSERT INTO Detalle VALUES (255, 242, 255);
INSERT INTO Detalle VALUES (255, 268, 255);
INSERT INTO Detalle VALUES (255, 269, 255);
INSERT INTO Detalle VALUES (255, 363, 255);
INSERT INTO Detalle VALUES (255, 367, 255);
INSERT INTO Detalle VALUES (255, 413, 255);
INSERT INTO Detalle VALUES (255, 493, 255);
INSERT INTO Detalle VALUES (255, 643, 255);
INSERT INTO Detalle VALUES (255, 666, 255);
INSERT INTO Detalle VALUES (255, 768, 255);
INSERT INTO Detalle VALUES (255, 769, 255);
INSERT INTO Detalle VALUES (255, 826, 255);
INSERT INTO Detalle VALUES (255, 853, 255);
INSERT INTO Detalle VALUES (255, 864, 255);
INSERT INTO Detalle VALUES (255, 940, 255);
INSERT INTO Detalle VALUES (255, 1014, 255);
INSERT INTO Detalle VALUES (255, 1026, 255);
INSERT INTO Detalle VALUES (255, 1047, 255);
INSERT INTO Detalle VALUES (255, 1104, 255);
INSERT INTO Detalle VALUES (255, 1126, 255);
INSERT INTO Detalle VALUES (255, 1136, 255);
INSERT INTO Detalle VALUES (255, 1187, 255);
INSERT INTO Detalle VALUES (255, 1248, 255);
INSERT INTO Detalle VALUES (255, 1272, 255);
INSERT INTO Detalle VALUES (255, 1277, 255);
INSERT INTO Detalle VALUES (255, 1353, 255);
INSERT INTO Detalle VALUES (255, 1440, 255);
INSERT INTO Detalle VALUES (255, 1561, 255);
INSERT INTO Detalle VALUES (255, 1631, 255);
INSERT INTO Detalle VALUES (255, 1688, 255);
INSERT INTO Detalle VALUES (255, 1697, 255);
INSERT INTO Detalle VALUES (255, 1699, 255);
INSERT INTO Detalle VALUES (255, 1701, 255);
INSERT INTO Detalle VALUES (255, 1712, 255);
INSERT INTO Detalle VALUES (255, 1715, 255);
INSERT INTO Detalle VALUES (255, 1716, 255);
INSERT INTO Detalle VALUES (255, 1717, 255);
INSERT INTO Detalle VALUES (255, 1719, 255);
INSERT INTO Detalle VALUES (255, 1720, 255);
INSERT INTO Detalle VALUES (255, 1721, 255);
INSERT INTO Detalle VALUES (255, 1725, 255);
INSERT INTO Detalle VALUES (255, 1769, 255);
INSERT INTO Detalle VALUES (255, 1796, 255);
INSERT INTO Detalle VALUES (255, 1797, 255);
INSERT INTO Detalle VALUES (255, 1799, 255);
INSERT INTO Detalle VALUES (255, 1800, 255);
INSERT INTO Detalle VALUES (255, 1801, 255);
INSERT INTO Detalle VALUES (255, 1802, 255);
INSERT INTO Detalle VALUES (255, 1803, 255);
INSERT INTO Detalle VALUES (255, 1804, 255);
INSERT INTO Detalle VALUES (255, 1805, 255);
INSERT INTO Detalle VALUES (255, 1806, 255);
INSERT INTO Detalle VALUES (255, 1807, 255);
INSERT INTO Detalle VALUES (255, 1808, 255);
INSERT INTO Detalle VALUES (255, 1809, 255);
INSERT INTO Detalle VALUES (255, 1812, 255);
INSERT INTO Detalle VALUES (255, 1813, 255);
INSERT INTO Detalle VALUES (255, 1814, 255);
INSERT INTO Detalle VALUES (255, 1817, 255);
INSERT INTO Detalle VALUES (255, 1821, 255);
INSERT INTO Detalle VALUES (255, 1822, 255);
INSERT INTO Detalle VALUES (255, 1824, 255);
INSERT INTO Detalle VALUES (255, 1825, 255);
INSERT INTO Detalle VALUES (255, 1826, 255);
INSERT INTO Detalle VALUES (255, 1828, 255);
INSERT INTO Detalle VALUES (255, 1829, 255);
INSERT INTO Detalle VALUES (255, 1830, 255);
INSERT INTO Detalle VALUES (255, 1834, 255);
INSERT INTO Detalle VALUES (255, 1837, 255);
INSERT INTO Detalle VALUES (255, 1840, 255);
INSERT INTO Detalle VALUES (255, 1860, 255);
INSERT INTO Detalle VALUES (255, 1923, 255);
INSERT INTO Detalle VALUES (255, 1924, 255);
INSERT INTO Detalle VALUES (255, 1925, 255);
INSERT INTO Detalle VALUES (255, 1938, 255);
INSERT INTO Detalle VALUES (255, 1949, 255);
INSERT INTO Detalle VALUES (255, 2002, 255);
INSERT INTO Detalle VALUES (255, 2022, 255);
INSERT INTO Detalle VALUES (255, 2023, 255);
INSERT INTO Detalle VALUES (255, 2174, 255);
INSERT INTO Detalle VALUES (255, 2182, 255);
INSERT INTO Detalle VALUES (255, 2315, 255);
INSERT INTO Detalle VALUES (255, 2340, 255);
INSERT INTO Detalle VALUES (255, 2342, 255);
INSERT INTO Detalle VALUES (255, 2345, 255);
INSERT INTO Detalle VALUES (255, 2384, 255);
INSERT INTO Detalle VALUES (255, 2409, 255);
INSERT INTO Detalle VALUES (255, 2514, 255);
INSERT INTO Detalle VALUES (255, 2649, 255);
INSERT INTO Detalle VALUES (255, 2733, 255);
INSERT INTO Detalle VALUES (255, 2738, 255);
INSERT INTO Detalle VALUES (255, 2758, 255);
INSERT INTO Detalle VALUES (255, 2759, 255);
INSERT INTO Detalle VALUES (255, 2760, 255);
INSERT INTO Detalle VALUES (255, 2771, 255);
INSERT INTO Detalle VALUES (255, 2793, 255);
INSERT INTO Detalle VALUES (255, 2950, 255);
INSERT INTO Detalle VALUES (255, 3034, 255);
INSERT INTO Detalle VALUES (255, 3170, 255);
INSERT INTO Detalle VALUES (255, 3171, 255);
INSERT INTO Detalle VALUES (255, 3174, 255);
INSERT INTO Detalle VALUES (255, 3180, 255);
INSERT INTO Detalle VALUES (255, 3181, 255);
INSERT INTO Detalle VALUES (255, 3182, 255);
INSERT INTO Detalle VALUES (255, 3183, 255);
INSERT INTO Detalle VALUES (255, 3184, 255);
INSERT INTO Detalle VALUES (255, 3190, 255);
INSERT INTO Detalle VALUES (255, 3196, 255);
INSERT INTO Detalle VALUES (255, 3197, 255);
INSERT INTO Detalle VALUES (255, 3842, 255);
INSERT INTO Detalle VALUES (257, 9, 257);
INSERT INTO Detalle VALUES (257, 17, 257);
INSERT INTO Detalle VALUES (257, 22, 257);
INSERT INTO Detalle VALUES (257, 24, 257);
INSERT INTO Detalle VALUES (257, 54, 257);
INSERT INTO Detalle VALUES (257, 55, 257);
INSERT INTO Detalle VALUES (257, 60, 257);
INSERT INTO Detalle VALUES (257, 61, 257);
INSERT INTO Detalle VALUES (257, 74, 257);
INSERT INTO Detalle VALUES (257, 75, 257);
INSERT INTO Detalle VALUES (257, 128, 257);
INSERT INTO Detalle VALUES (257, 132, 257);
INSERT INTO Detalle VALUES (257, 135, 257);
INSERT INTO Detalle VALUES (257, 165, 257);
INSERT INTO Detalle VALUES (257, 174, 257);
INSERT INTO Detalle VALUES (257, 473, 257);
INSERT INTO Detalle VALUES (257, 506, 257);
INSERT INTO Detalle VALUES (257, 666, 257);
INSERT INTO Detalle VALUES (257, 721, 257);
INSERT INTO Detalle VALUES (257, 768, 257);
INSERT INTO Detalle VALUES (257, 769, 257);
INSERT INTO Detalle VALUES (257, 940, 257);
INSERT INTO Detalle VALUES (257, 1084, 257);
INSERT INTO Detalle VALUES (257, 1113, 257);
INSERT INTO Detalle VALUES (257, 1187, 257);
INSERT INTO Detalle VALUES (257, 1277, 257);
INSERT INTO Detalle VALUES (257, 1488, 257);
INSERT INTO Detalle VALUES (257, 1561, 257);
INSERT INTO Detalle VALUES (257, 1701, 257);
INSERT INTO Detalle VALUES (257, 1725, 257);
INSERT INTO Detalle VALUES (257, 1728, 257);
INSERT INTO Detalle VALUES (257, 1729, 257);
INSERT INTO Detalle VALUES (257, 1730, 257);
INSERT INTO Detalle VALUES (257, 1731, 257);
INSERT INTO Detalle VALUES (257, 1771, 257);
INSERT INTO Detalle VALUES (257, 1859, 257);
INSERT INTO Detalle VALUES (257, 1860, 257);
INSERT INTO Detalle VALUES (257, 1861, 257);
INSERT INTO Detalle VALUES (257, 1862, 257);
INSERT INTO Detalle VALUES (257, 1953, 257);
INSERT INTO Detalle VALUES (257, 2002, 257);
INSERT INTO Detalle VALUES (257, 2035, 257);
INSERT INTO Detalle VALUES (257, 2038, 257);
INSERT INTO Detalle VALUES (257, 2039, 257);
INSERT INTO Detalle VALUES (257, 2044, 257);
INSERT INTO Detalle VALUES (257, 2050, 257);
INSERT INTO Detalle VALUES (257, 2056, 257);
INSERT INTO Detalle VALUES (257, 2059, 257);
INSERT INTO Detalle VALUES (257, 2717, 257);
INSERT INTO Detalle VALUES (257, 2731, 257);
INSERT INTO Detalle VALUES (258, 9, 258);
INSERT INTO Detalle VALUES (258, 17, 258);
INSERT INTO Detalle VALUES (258, 18, 258);
INSERT INTO Detalle VALUES (258, 22, 258);
INSERT INTO Detalle VALUES (258, 24, 258);
INSERT INTO Detalle VALUES (258, 30, 258);
INSERT INTO Detalle VALUES (258, 42, 258);
INSERT INTO Detalle VALUES (258, 54, 258);
INSERT INTO Detalle VALUES (258, 58, 258);
INSERT INTO Detalle VALUES (258, 59, 258);
INSERT INTO Detalle VALUES (258, 61, 258);
INSERT INTO Detalle VALUES (258, 74, 258);
INSERT INTO Detalle VALUES (258, 75, 258);
INSERT INTO Detalle VALUES (258, 109, 258);
INSERT INTO Detalle VALUES (258, 132, 258);
INSERT INTO Detalle VALUES (258, 165, 258);
INSERT INTO Detalle VALUES (258, 174, 258);
INSERT INTO Detalle VALUES (258, 228, 258);
INSERT INTO Detalle VALUES (258, 240, 258);
INSERT INTO Detalle VALUES (258, 408, 258);
INSERT INTO Detalle VALUES (258, 447, 258);
INSERT INTO Detalle VALUES (258, 473, 258);
INSERT INTO Detalle VALUES (258, 487, 258);
INSERT INTO Detalle VALUES (258, 593, 258);
INSERT INTO Detalle VALUES (258, 643, 258);
INSERT INTO Detalle VALUES (258, 666, 258);
INSERT INTO Detalle VALUES (258, 768, 258);
INSERT INTO Detalle VALUES (258, 769, 258);
INSERT INTO Detalle VALUES (258, 801, 258);
INSERT INTO Detalle VALUES (258, 940, 258);
INSERT INTO Detalle VALUES (258, 1187, 258);
INSERT INTO Detalle VALUES (258, 1561, 258);
INSERT INTO Detalle VALUES (258, 1678, 258);
INSERT INTO Detalle VALUES (258, 1697, 258);
INSERT INTO Detalle VALUES (258, 1699, 258);
INSERT INTO Detalle VALUES (258, 1701, 258);
INSERT INTO Detalle VALUES (258, 1711, 258);
INSERT INTO Detalle VALUES (258, 1712, 258);
INSERT INTO Detalle VALUES (258, 1713, 258);
INSERT INTO Detalle VALUES (258, 1714, 258);
INSERT INTO Detalle VALUES (258, 1715, 258);
INSERT INTO Detalle VALUES (258, 1725, 258);
INSERT INTO Detalle VALUES (258, 1726, 258);
INSERT INTO Detalle VALUES (258, 1732, 258);
INSERT INTO Detalle VALUES (258, 1734, 258);
INSERT INTO Detalle VALUES (258, 1760, 258);
INSERT INTO Detalle VALUES (258, 1761, 258);
INSERT INTO Detalle VALUES (258, 1771, 258);
INSERT INTO Detalle VALUES (258, 1837, 258);
INSERT INTO Detalle VALUES (258, 1859, 258);
INSERT INTO Detalle VALUES (258, 1860, 258);
INSERT INTO Detalle VALUES (258, 1861, 258);
INSERT INTO Detalle VALUES (258, 1862, 258);
INSERT INTO Detalle VALUES (258, 2002, 258);
INSERT INTO Detalle VALUES (258, 2003, 258);
INSERT INTO Detalle VALUES (258, 2035, 258);
INSERT INTO Detalle VALUES (258, 2036, 258);
INSERT INTO Detalle VALUES (258, 2038, 258);
INSERT INTO Detalle VALUES (258, 2051, 258);
INSERT INTO Detalle VALUES (258, 2056, 258);
INSERT INTO Detalle VALUES (258, 2090, 258);
INSERT INTO Detalle VALUES (258, 2180, 258);
INSERT INTO Detalle VALUES (258, 2201, 258);
INSERT INTO Detalle VALUES (258, 2342, 258);
INSERT INTO Detalle VALUES (258, 2430, 258);
INSERT INTO Detalle VALUES (258, 2557, 258);
INSERT INTO Detalle VALUES (258, 2649, 258);
INSERT INTO Detalle VALUES (258, 2650, 258);
INSERT INTO Detalle VALUES (258, 2656, 258);
INSERT INTO Detalle VALUES (258, 2659, 258);
INSERT INTO Detalle VALUES (258, 2673, 258);
INSERT INTO Detalle VALUES (258, 2703, 258);
INSERT INTO Detalle VALUES (258, 2717, 258);
INSERT INTO Detalle VALUES (258, 2731, 258);
INSERT INTO Detalle VALUES (258, 2754, 258);
INSERT INTO Detalle VALUES (258, 3060, 258);
INSERT INTO Detalle VALUES (258, 3319, 258);
INSERT INTO Detalle VALUES (318, 1101, 318);
INSERT INTO Detalle VALUES (318, 2560, 318);
INSERT INTO Detalle VALUES (319, 1747, 319);
INSERT INTO Detalle VALUES (319, 2002, 319);
INSERT INTO Detalle VALUES (319, 2242, 319);
INSERT INTO Detalle VALUES (319, 2560, 319);
INSERT INTO Detalle VALUES (319, 2562, 319);
INSERT INTO Detalle VALUES (319, 2563, 319);
INSERT INTO Detalle VALUES (319, 2564, 319);
INSERT INTO Detalle VALUES (319, 2565, 319);
INSERT INTO Detalle VALUES (319, 2566, 319);
INSERT INTO Detalle VALUES (319, 2567, 319);
INSERT INTO Detalle VALUES (319, 2571, 319);
INSERT INTO Detalle VALUES (319, 2572, 319);
INSERT INTO Detalle VALUES (319, 2573, 319);
INSERT INTO Detalle VALUES (319, 2698, 319);
INSERT INTO Detalle VALUES (320, 832, 320);
INSERT INTO Detalle VALUES (320, 2242, 320);
INSERT INTO Detalle VALUES (320, 2560, 320);
INSERT INTO Detalle VALUES (320, 2562, 320);
INSERT INTO Detalle VALUES (320, 2565, 320);
INSERT INTO Detalle VALUES (320, 2566, 320);
INSERT INTO Detalle VALUES (320, 2567, 320);
INSERT INTO Detalle VALUES (320, 2571, 320);
INSERT INTO Detalle VALUES (320, 2572, 320);
INSERT INTO Detalle VALUES (320, 2573, 320);
INSERT INTO Detalle VALUES (320, 2576, 320);
INSERT INTO Detalle VALUES (320, 2581, 320);
INSERT INTO Detalle VALUES (366, 18, 366);
INSERT INTO Detalle VALUES (366, 30, 366);
INSERT INTO Detalle VALUES (366, 75, 366);
INSERT INTO Detalle VALUES (366, 666, 366);
INSERT INTO Detalle VALUES (366, 768, 366);
INSERT INTO Detalle VALUES (366, 769, 366);
INSERT INTO Detalle VALUES (366, 801, 366);
INSERT INTO Detalle VALUES (366, 1187, 366);
INSERT INTO Detalle VALUES (366, 1678, 366);
INSERT INTO Detalle VALUES (366, 1712, 366);
INSERT INTO Detalle VALUES (366, 1725, 366);
INSERT INTO Detalle VALUES (366, 1771, 366);
INSERT INTO Detalle VALUES (366, 1859, 366);
INSERT INTO Detalle VALUES (366, 1860, 366);
INSERT INTO Detalle VALUES (366, 1861, 366);
INSERT INTO Detalle VALUES (366, 1862, 366);
INSERT INTO Detalle VALUES (366, 2002, 366);
INSERT INTO Detalle VALUES (366, 2035, 366);
INSERT INTO Detalle VALUES (366, 2036, 366);
INSERT INTO Detalle VALUES (366, 2038, 366);
INSERT INTO Detalle VALUES (366, 2056, 366);
INSERT INTO Detalle VALUES (366, 2090, 366);
INSERT INTO Detalle VALUES (366, 2649, 366);
INSERT INTO Detalle VALUES (366, 2650, 366);
INSERT INTO Detalle VALUES (366, 2659, 366);
INSERT INTO Detalle VALUES (366, 2673, 366);
INSERT INTO Detalle VALUES (366, 2731, 366);
INSERT INTO Detalle VALUES (366, 3036, 366);
INSERT INTO Detalle VALUES (368, 18, 368);
INSERT INTO Detalle VALUES (368, 60, 368);
INSERT INTO Detalle VALUES (368, 135, 368);
INSERT INTO Detalle VALUES (368, 666, 368);
INSERT INTO Detalle VALUES (368, 768, 368);
INSERT INTO Detalle VALUES (368, 769, 368);
INSERT INTO Detalle VALUES (368, 1084, 368);
INSERT INTO Detalle VALUES (368, 1187, 368);
INSERT INTO Detalle VALUES (368, 1725, 368);
INSERT INTO Detalle VALUES (368, 1771, 368);
INSERT INTO Detalle VALUES (368, 1859, 368);
INSERT INTO Detalle VALUES (368, 1860, 368);
INSERT INTO Detalle VALUES (368, 1861, 368);
INSERT INTO Detalle VALUES (368, 1862, 368);
INSERT INTO Detalle VALUES (368, 2002, 368);
INSERT INTO Detalle VALUES (368, 2035, 368);
INSERT INTO Detalle VALUES (368, 2038, 368);
INSERT INTO Detalle VALUES (368, 2039, 368);
INSERT INTO Detalle VALUES (368, 2056, 368);
INSERT INTO Detalle VALUES (368, 2649, 368);
INSERT INTO Detalle VALUES (368, 2650, 368);
INSERT INTO Detalle VALUES (368, 2659, 368);
INSERT INTO Detalle VALUES (368, 2673, 368);
INSERT INTO Detalle VALUES (368, 2731, 368);
INSERT INTO Detalle VALUES (368, 3036, 368);
INSERT INTO Detalle VALUES (370, 18, 370);
INSERT INTO Detalle VALUES (370, 60, 370);
INSERT INTO Detalle VALUES (370, 666, 370);
INSERT INTO Detalle VALUES (370, 768, 370);
INSERT INTO Detalle VALUES (370, 769, 370);
INSERT INTO Detalle VALUES (370, 1187, 370);
INSERT INTO Detalle VALUES (370, 1425, 370);
INSERT INTO Detalle VALUES (370, 1701, 370);
INSERT INTO Detalle VALUES (370, 1704, 370);
INSERT INTO Detalle VALUES (370, 1725, 370);
INSERT INTO Detalle VALUES (370, 1771, 370);
INSERT INTO Detalle VALUES (370, 1859, 370);
INSERT INTO Detalle VALUES (370, 1860, 370);
INSERT INTO Detalle VALUES (370, 1861, 370);
INSERT INTO Detalle VALUES (370, 1862, 370);
INSERT INTO Detalle VALUES (370, 2002, 370);
INSERT INTO Detalle VALUES (370, 2035, 370);
INSERT INTO Detalle VALUES (370, 2038, 370);
INSERT INTO Detalle VALUES (370, 2056, 370);
INSERT INTO Detalle VALUES (370, 2649, 370);
INSERT INTO Detalle VALUES (370, 2650, 370);
INSERT INTO Detalle VALUES (370, 2659, 370);
INSERT INTO Detalle VALUES (370, 2673, 370);
INSERT INTO Detalle VALUES (370, 3036, 370);
INSERT INTO Detalle VALUES (451, 102, 451);
INSERT INTO Detalle VALUES (465, 13, 465);
INSERT INTO Detalle VALUES (465, 14, 465);
INSERT INTO Detalle VALUES (465, 19, 465);
INSERT INTO Detalle VALUES (465, 24, 465);
INSERT INTO Detalle VALUES (465, 91, 465);
INSERT INTO Detalle VALUES (465, 129, 465);
INSERT INTO Detalle VALUES (465, 454, 465);
INSERT INTO Detalle VALUES (465, 1187, 465);
INSERT INTO Detalle VALUES (465, 1270, 465);
INSERT INTO Detalle VALUES (465, 2002, 465);
INSERT INTO Detalle VALUES (465, 3377, 465);
INSERT INTO Detalle VALUES (465, 3449, 465);
INSERT INTO Detalle VALUES (465, 3594, 465);
INSERT INTO Detalle VALUES (465, 3659, 465);
INSERT INTO Detalle VALUES (465, 3672, 465);
INSERT INTO Detalle VALUES (465, 3713, 465);
INSERT INTO Detalle VALUES (465, 3721, 465);
INSERT INTO Detalle VALUES (465, 3722, 465);
INSERT INTO Detalle VALUES (466, 13, 466);
INSERT INTO Detalle VALUES (466, 14, 466);
INSERT INTO Detalle VALUES (466, 91, 466);
INSERT INTO Detalle VALUES (466, 454, 466);
INSERT INTO Detalle VALUES (466, 1187, 466);
INSERT INTO Detalle VALUES (466, 1270, 466);
INSERT INTO Detalle VALUES (466, 3377, 466);
INSERT INTO Detalle VALUES (466, 3444, 466);
INSERT INTO Detalle VALUES (466, 3445, 466);
INSERT INTO Detalle VALUES (466, 3446, 466);
INSERT INTO Detalle VALUES (466, 3447, 466);
INSERT INTO Detalle VALUES (466, 3449, 466);
INSERT INTO Detalle VALUES (466, 3453, 466);
INSERT INTO Detalle VALUES (466, 3594, 466);
INSERT INTO Detalle VALUES (466, 3636, 466);
INSERT INTO Detalle VALUES (466, 3659, 466);
INSERT INTO Detalle VALUES (466, 3721, 466);
INSERT INTO Detalle VALUES (466, 3885, 466);
INSERT INTO Detalle VALUES (466, 4036, 466);
INSERT INTO Detalle VALUES (480, 9, 480);
INSERT INTO Detalle VALUES (480, 17, 480);
INSERT INTO Detalle VALUES (480, 22, 480);
INSERT INTO Detalle VALUES (480, 54, 480);
INSERT INTO Detalle VALUES (480, 58, 480);
INSERT INTO Detalle VALUES (480, 165, 480);
INSERT INTO Detalle VALUES (480, 174, 480);
INSERT INTO Detalle VALUES (480, 643, 480);
INSERT INTO Detalle VALUES (480, 666, 480);
INSERT INTO Detalle VALUES (480, 1304, 480);
INSERT INTO Detalle VALUES (480, 1941, 480);
INSERT INTO Detalle VALUES (480, 1963, 480);
INSERT INTO Detalle VALUES (480, 1990, 480);
INSERT INTO Detalle VALUES (480, 2002, 480);
INSERT INTO Detalle VALUES (480, 2769, 480);
INSERT INTO Detalle VALUES (480, 3337, 480);
INSERT INTO Detalle VALUES (572, 19, 572);
INSERT INTO Detalle VALUES (572, 45, 572);
INSERT INTO Detalle VALUES (572, 53, 572);
INSERT INTO Detalle VALUES (572, 54, 572);
INSERT INTO Detalle VALUES (572, 58, 572);
INSERT INTO Detalle VALUES (572, 72, 572);
INSERT INTO Detalle VALUES (572, 120, 572);
INSERT INTO Detalle VALUES (572, 129, 572);
INSERT INTO Detalle VALUES (572, 165, 572);
INSERT INTO Detalle VALUES (572, 174, 572);
INSERT INTO Detalle VALUES (572, 3374, 572);
INSERT INTO Detalle VALUES (647, 13, 647);
INSERT INTO Detalle VALUES (647, 14, 647);
INSERT INTO Detalle VALUES (647, 1270, 647);
INSERT INTO Detalle VALUES (647, 2098, 647);
INSERT INTO Detalle VALUES (647, 2928, 647);
INSERT INTO Detalle VALUES (647, 3978, 647);
INSERT INTO Detalle VALUES (647, 3979, 647);
INSERT INTO Detalle VALUES (647, 3980, 647);
INSERT INTO Detalle VALUES (851, 13, 851);
INSERT INTO Detalle VALUES (851, 14, 851);
INSERT INTO Detalle VALUES (851, 91, 851);
INSERT INTO Detalle VALUES (851, 454, 851);
INSERT INTO Detalle VALUES (851, 663, 851);
INSERT INTO Detalle VALUES (851, 732, 851);
INSERT INTO Detalle VALUES (851, 1177, 851);
INSERT INTO Detalle VALUES (851, 1187, 851);
INSERT INTO Detalle VALUES (851, 1209, 851);
INSERT INTO Detalle VALUES (851, 1270, 851);
INSERT INTO Detalle VALUES (851, 1612, 851);
INSERT INTO Detalle VALUES (851, 1650, 851);
INSERT INTO Detalle VALUES (851, 2002, 851);
INSERT INTO Detalle VALUES (851, 2928, 851);
INSERT INTO Detalle VALUES (851, 3659, 851);
INSERT INTO Detalle VALUES (851, 4024, 851);
INSERT INTO Detalle VALUES (851, 5337, 851);
INSERT INTO Detalle VALUES (851, 5378, 851);
INSERT INTO Detalle VALUES (851, 5380, 851);
INSERT INTO Detalle VALUES (851, 5382, 851);
INSERT INTO Detalle VALUES (851, 5383, 851);
INSERT INTO Detalle VALUES (851, 5385, 851);
INSERT INTO Detalle VALUES (851, 5386, 851);
INSERT INTO Detalle VALUES (851, 5388, 851);
INSERT INTO Detalle VALUES (866, 13, 866);
INSERT INTO Detalle VALUES (866, 14, 866);
INSERT INTO Detalle VALUES (866, 19, 866);
INSERT INTO Detalle VALUES (866, 24, 866);
INSERT INTO Detalle VALUES (866, 58, 866);
INSERT INTO Detalle VALUES (866, 91, 866);
INSERT INTO Detalle VALUES (866, 129, 866);
INSERT INTO Detalle VALUES (866, 454, 866);
INSERT INTO Detalle VALUES (866, 896, 866);
INSERT INTO Detalle VALUES (866, 1187, 866);
INSERT INTO Detalle VALUES (866, 1270, 866);
INSERT INTO Detalle VALUES (866, 2002, 866);
INSERT INTO Detalle VALUES (866, 2928, 866);
INSERT INTO Detalle VALUES (866, 3449, 866);
INSERT INTO Detalle VALUES (866, 3594, 866);
INSERT INTO Detalle VALUES (866, 3659, 866);
INSERT INTO Detalle VALUES (866, 3713, 866);
INSERT INTO Detalle VALUES (866, 3721, 866);
INSERT INTO Detalle VALUES (866, 3722, 866);
INSERT INTO Detalle VALUES (866, 4024, 866);
INSERT INTO Detalle VALUES (866, 5337, 866);
INSERT INTO Detalle VALUES (866, 5457, 866);
INSERT INTO Detalle VALUES (869, 13, 869);
INSERT INTO Detalle VALUES (869, 14, 869);
INSERT INTO Detalle VALUES (869, 91, 869);
INSERT INTO Detalle VALUES (869, 454, 869);
INSERT INTO Detalle VALUES (869, 1187, 869);
INSERT INTO Detalle VALUES (869, 1270, 869);
INSERT INTO Detalle VALUES (869, 1622, 869);
INSERT INTO Detalle VALUES (869, 1625, 869);
INSERT INTO Detalle VALUES (869, 1626, 869);
INSERT INTO Detalle VALUES (869, 1627, 869);
INSERT INTO Detalle VALUES (869, 1628, 869);
INSERT INTO Detalle VALUES (869, 1629, 869);
INSERT INTO Detalle VALUES (869, 1631, 869);
INSERT INTO Detalle VALUES (869, 1632, 869);
INSERT INTO Detalle VALUES (869, 2002, 869);
INSERT INTO Detalle VALUES (869, 2928, 869);
INSERT INTO Detalle VALUES (869, 3620, 869);
INSERT INTO Detalle VALUES (869, 3659, 869);
INSERT INTO Detalle VALUES (869, 4024, 869);
INSERT INTO Detalle VALUES (869, 4094, 869);
INSERT INTO Detalle VALUES (869, 5337, 869);
INSERT INTO Detalle VALUES (869, 5591, 869);
INSERT INTO Detalle VALUES (869, 5597, 869);
INSERT INTO Detalle VALUES (869, 5598, 869);
INSERT INTO Detalle VALUES (869, 5599, 869);
INSERT INTO Detalle VALUES (869, 5600, 869);
INSERT INTO Detalle VALUES (869, 5601, 869);
INSERT INTO Detalle VALUES (876, 13, 876);
INSERT INTO Detalle VALUES (876, 14, 876);
INSERT INTO Detalle VALUES (876, 24, 876);
INSERT INTO Detalle VALUES (876, 91, 876);
INSERT INTO Detalle VALUES (876, 454, 876);
INSERT INTO Detalle VALUES (876, 1270, 876);
INSERT INTO Detalle VALUES (876, 1535, 876);
INSERT INTO Detalle VALUES (876, 2002, 876);
INSERT INTO Detalle VALUES (876, 2928, 876);
INSERT INTO Detalle VALUES (876, 3449, 876);
INSERT INTO Detalle VALUES (876, 3594, 876);
INSERT INTO Detalle VALUES (876, 3659, 876);
INSERT INTO Detalle VALUES (876, 3672, 876);
INSERT INTO Detalle VALUES (876, 3713, 876);
INSERT INTO Detalle VALUES (876, 3721, 876);
INSERT INTO Detalle VALUES (876, 3885, 876);
INSERT INTO Detalle VALUES (876, 4024, 876);
INSERT INTO Detalle VALUES (876, 5337, 876);
INSERT INTO Detalle VALUES (876, 5457, 876);

INSERT INTO Propuestas VALUES (54, 1, 7);
INSERT INTO Propuestas VALUES (54, 1, 247);
INSERT INTO Propuestas VALUES (54, 4, 245);
INSERT INTO Propuestas VALUES (54, 5, 246);
INSERT INTO Propuestas VALUES (54, 9, 455);
INSERT INTO Propuestas VALUES (54, 10, 572);
INSERT INTO Propuestas VALUES (54, 10, 6);
INSERT INTO Propuestas VALUES (97, 1, 7);
INSERT INTO Propuestas VALUES (97, 1, 247);
INSERT INTO Propuestas VALUES (97, 4, 245);
INSERT INTO Propuestas VALUES (97, 4, 4);
INSERT INTO Propuestas VALUES (97, 5, 246);
INSERT INTO Propuestas VALUES (97, 5, 5);
INSERT INTO Propuestas VALUES (97, 6, 249);
INSERT INTO Propuestas VALUES (97, 9, 455);
INSERT INTO Propuestas VALUES (97, 10, 572);
INSERT INTO Propuestas VALUES (97, 16, 250);
INSERT INTO Propuestas VALUES (97, 21, 16);
INSERT INTO Propuestas VALUES (97, 23, 249);
INSERT INTO Propuestas VALUES (97, 23, 250);
INSERT INTO Propuestas VALUES (97, 23, 480);
INSERT INTO Propuestas VALUES (149, 1, 7);
INSERT INTO Propuestas VALUES (149, 4, 245);
INSERT INTO Propuestas VALUES (149, 5, 246);
INSERT INTO Propuestas VALUES (149, 6, 249);
INSERT INTO Propuestas VALUES (149, 9, 455);
INSERT INTO Propuestas VALUES (149, 10, 572);
INSERT INTO Propuestas VALUES (149, 10, 6);
INSERT INTO Propuestas VALUES (149, 16, 250);
INSERT INTO Propuestas VALUES (275, 1, 7);
INSERT INTO Propuestas VALUES (275, 1, 247);
INSERT INTO Propuestas VALUES (275, 4, 245);
INSERT INTO Propuestas VALUES (275, 5, 246);
INSERT INTO Propuestas VALUES (275, 6, 249);
INSERT INTO Propuestas VALUES (275, 9, 455);
INSERT INTO Propuestas VALUES (275, 10, 572);
INSERT INTO Propuestas VALUES (275, 10, 6);
INSERT INTO Propuestas VALUES (286, 1, 7);
INSERT INTO Propuestas VALUES (286, 1, 247);
INSERT INTO Propuestas VALUES (286, 2, 53);
INSERT INTO Propuestas VALUES (286, 2, 52);
INSERT INTO Propuestas VALUES (286, 2, 54);
INSERT INTO Propuestas VALUES (286, 2, 51);
INSERT INTO Propuestas VALUES (286, 3, 967);
INSERT INTO Propuestas VALUES (286, 3, 320);
INSERT INTO Propuestas VALUES (286, 3, 319);
INSERT INTO Propuestas VALUES (286, 3, 318);
INSERT INTO Propuestas VALUES (286, 3, 47);
INSERT INTO Propuestas VALUES (286, 3, 9);
INSERT INTO Propuestas VALUES (286, 3, 40);
INSERT INTO Propuestas VALUES (286, 3, 876);
INSERT INTO Propuestas VALUES (286, 3, 866);
INSERT INTO Propuestas VALUES (286, 3, 869);
INSERT INTO Propuestas VALUES (286, 3, 851);
INSERT INTO Propuestas VALUES (286, 3, 647);
INSERT INTO Propuestas VALUES (286, 3, 14);
INSERT INTO Propuestas VALUES (286, 3, 466);
INSERT INTO Propuestas VALUES (286, 3, 465);
INSERT INTO Propuestas VALUES (286, 4, 245);
INSERT INTO Propuestas VALUES (286, 5, 246);
INSERT INTO Propuestas VALUES (286, 6, 249);
INSERT INTO Propuestas VALUES (286, 7, 252);
INSERT INTO Propuestas VALUES (286, 7, 258);
INSERT INTO Propuestas VALUES (286, 7, 257);
INSERT INTO Propuestas VALUES (286, 7, 253);
INSERT INTO Propuestas VALUES (286, 7, 255);
INSERT INTO Propuestas VALUES (286, 7, 451);
INSERT INTO Propuestas VALUES (286, 9, 455);
INSERT INTO Propuestas VALUES (286, 10, 572);
INSERT INTO Propuestas VALUES (286, 16, 250);
INSERT INTO Propuestas VALUES (286, 21, 16);
INSERT INTO Propuestas VALUES (286, 23, 366);
INSERT INTO Propuestas VALUES (286, 23, 370);
INSERT INTO Propuestas VALUES (286, 23, 368);
INSERT INTO Propuestas VALUES (286, 23, 249);
INSERT INTO Propuestas VALUES (286, 23, 250);
INSERT INTO Propuestas VALUES (286, 23, 455);
INSERT INTO Propuestas VALUES (432, 1, 245);
INSERT INTO Propuestas VALUES (432, 1, 7);
INSERT INTO Propuestas VALUES (432, 1, 247);
INSERT INTO Propuestas VALUES (432, 4, 245);
INSERT INTO Propuestas VALUES (432, 5, 246);
INSERT INTO Propuestas VALUES (432, 6, 249);
INSERT INTO Propuestas VALUES (432, 9, 455);
INSERT INTO Propuestas VALUES (432, 10, 572);
INSERT INTO Propuestas VALUES (432, 10, 6);
INSERT INTO Propuestas VALUES (504, 1, 7);
INSERT INTO Propuestas VALUES (504, 1, 247);
INSERT INTO Propuestas VALUES (504, 4, 245);
INSERT INTO Propuestas VALUES (504, 5, 246);
INSERT INTO Propuestas VALUES (504, 9, 455);
INSERT INTO Propuestas VALUES (504, 10, 572);
INSERT INTO Propuestas VALUES (504, 10, 6);
INSERT INTO Propuestas VALUES (589, 1, 7);
INSERT INTO Propuestas VALUES (589, 4, 245);
INSERT INTO Propuestas VALUES (589, 5, 246);
INSERT INTO Propuestas VALUES (589, 6, 249);
INSERT INTO Propuestas VALUES (589, 9, 455);
INSERT INTO Propuestas VALUES (589, 10, 572);
INSERT INTO Propuestas VALUES (589, 10, 6);
INSERT INTO Propuestas VALUES (589, 16, 250);
INSERT INTO Propuestas VALUES (589, 23, 249);
INSERT INTO Propuestas VALUES (589, 23, 250);
INSERT INTO Propuestas VALUES (986, 21, 249);
INSERT INTO Propuestas VALUES (1013, 1, 7);
INSERT INTO Propuestas VALUES (1013, 9, 455);
INSERT INTO Propuestas VALUES (1013, 10, 572);
INSERT INTO Propuestas VALUES (7602, 1, 7);
INSERT INTO Propuestas VALUES (7602, 10, 572);

/********************************************************************************
Crear una vista, llamada CurriculasEscuelas , para que muestre todo el detalle de
las currículas de las escuelas. Se deberá mostrar, en este orden , el código y
nombre de la escuela, el nombre de la etapa, el nombre de la currícula, código,
nombre, tipo y carga horaria de las asignaturas que componen las currículas. El
listado deberá estar ordenado alfabéticamente por el nombre de la escuela, el
nombre de la etapa y el nombre de la currícula.
********************************************************************************/
DROP VIEW IF EXISTS CurriculasEscuelas;
CREATE VIEW CurriculasEscuelas AS
-- el código y nombre de la escuela, el nombre de la etapa, el nombre de la currícula, código, nombre, tipo y carga horaria de las asignaturas que componen las currículas.
	SELECT E.nombre AS NombreEscuela, ET.nombre AS NombreEtapa, C.nombre AS NombreCurricula,
    A.codigo AS AsigCodigo, A.nombre AS NombreAsignatura, A.tipo AS TipoAsignatura, D.carga AS CargaAsignatura
		   
	FROM Escuelas E
	JOIN Propuestas PR ON E.idEscuela = PR.idEscuela
	JOIN Etapas ET ON PR.idEtapa = ET.idEtapa
	JOIN Curricula C ON PR.idCurricula = C.idCurricula
	JOIN Detalle D ON C.idCurricula = D.idCurricula
    JOIN Asignaturas A ON A.codigo = D.codigo;



SELECT * FROM CurriculasEscuelas;

/*************************************************************************************
3)Realizar un procedimiento almacenado, llamado RankingCargaCurricula , para que
muestre un ranking con las currículas con mayor carga horaria. Se deberá mostrar el
nombre de la currícula y la carga horaria total de la misma.
**************************************************************************************/
DROP PROCEDURE IF EXISTS RankingCargaCurricula;

DELIMITER //

CREATE PROCEDURE RankingCargaCurricula()
BEGIN
    SELECT
        C.nombre,
        SUM(D.Carga) AS CargaTotal        
    FROM
        Curricula C
        JOIN Detalle D ON C.idCurricula = D.idCurricula
        
    GROUP BY
        C.nombre,
        D.Carga
    ORDER BY
		CargaTotal DESC;
END //

DELIMITER ;

CALL RankingCargaCurricula();

/**********************************************************************************
4) Realizar un procedimiento almacenado, llamado NuevaEscuela , para dar de alta
una escuela. El mismo deberá incluir el control de errores lógicos y mensajes de
error necesarios. Incluir el código con la llamada al procedimiento probando todos
los casos con datos incorrectos y uno con datos correctos.
***********************************************************************************/
DROP PROCEDURE IF EXISTS NuevaEscuela;

DELIMITER //

CREATE PROCEDURE NuevaEscuela(
    pidEscuela INT,
    pcodigo VARCHAR(10), 
    pnombre VARCHAR(100),
    pdomicilio VARCHAR(70),
    ptipo VARCHAR(10),
    OUT pMensaje VARCHAR(256))
FINAL:
BEGIN
    -- Descripcion
    
    -- Declaraciones
    DECLARE EXIT HANDLER FOR SQLEXCEPTION -- lo puedo cambiar por el numero de la exception
    BEGIN
        GET DIAGNOSTICS CONDITION 1 @sqlstate = RETURNED_SQLSTATE;
        SET pMensaje = 'Error en la transacción. Contáctese con el administrador. SQLSTATE: ' || @sqlstate;
        ROLLBACK;
    END;

    IF pidEscuela IS NULL OR  pcodigo IS NULL OR pnombre IS NULL OR TRIM(pnombre) = '' OR 
    pdomicilio IS NULL OR ptipo IS NULL THEN
        SET pMensaje = 'Error: ID, código, nombre, domicilio o tipo no pueden ser nulos';
        LEAVE FINAL;
    END IF;

    IF EXISTS (SELECT idEscuela FROM Escuelas WHERE idEscuela = pidEscuela) THEN
        SET pMensaje = 'Error: No puede haber nombres de productos repetidos';
        LEAVE FINAL;
    END IF;

    START TRANSACTION;
    
    INSERT INTO Escuelas (idEscuela, codigo, nombre, domicilio, tipo)
    VALUES (pidEscuela, pcodigo, pnombre, pdomicilio, ptipo);
    
    SET pMensaje = 'Inserción exitosa';
    COMMIT;

END //

DELIMITER ; 


SELECT * FROM Escuelas;

CALL NuevaEscuela(7603,'9000807','INST. SAN NICOLAS DE BARI','San Martin 107','Pública', @pMensaje);
SELECT @pMensaje;

/*******************************************************************************************
5) Implementar la lógica para llevar una auditoría para la operación anterior. Se deberá
auditar el usuario que la hizo, la fecha y hora de la operación, la máquina desde
donde se la hizo y toda la información necesaria para la auditoría.
*********************************************************************************************/
DROP TABLE IF EXISTS `AuditoriaEscuelas` ;

CREATE TABLE IF NOT EXISTS `AuditoriaEscuelas` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `idEscuela` INT,
  `codigo` VARCHAR(10), 
  `nombre` VARCHAR(100),
  `domicilio` VARCHAR(70),
  `tipo` VARCHAR(10),
  `TipoOp` CHAR(1) NOT NULL, -- tipo de operación (I: Inserción, B: Borrado, M: Modificación)
  `Usuario` VARCHAR(45) NOT NULL,  
  `Maquina` VARCHAR(45) NOT NULL,  
  `Fecha` DATETIME NOT NULL,
  PRIMARY KEY (`ID`)
);

DELIMITER //
CREATE TRIGGER `AuditarEscuelas` 
AFTER INSERT ON `Escuelas` FOR EACH ROW
BEGIN
	INSERT INTO AuditoriaEscuelas VALUES (
			DEFAULT, 
			NEW.idEscuela,
			NEW.codigo, 
			NEW.nombre,
			NEW.domicilio,
			NEW.tipo,
			'I', 
			SUBSTRING_INDEX(USER(), '@', 1), 
			SUBSTRING_INDEX(USER(), '@', -1), 
			NOW()
	  );
END //
DELIMITER ;

SELECT * FROM Escuelas;

CALL NuevaEscuela(7603,'9000807','INST. SAN NICOLAS DE BARI','San Martin 107','Pública', @pMensaje);
SELECT @pMensaje;
CALL NuevaEscuela(7604,'9000808','COL. SAGRADO CORAZON','25 de mayo 600','Privada', @pMensaje);
SELECT @pMensaje;
SELECT * FROM AuditoriaEscuelas;