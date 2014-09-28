CREATE DATABASE  IF NOT EXISTS `mobility` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `mobility`;
-- MySQL dump 10.13  Distrib 5.6.13, for Win32 (x86)
--
-- Host: 127.0.0.1    Database: mobility
-- ------------------------------------------------------
-- Server version	5.5.27

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `categoria`
--

DROP TABLE IF EXISTS `categoria`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `categoria` (
  `id_categoria` int(11) NOT NULL,
  `nombre` varchar(45) DEFAULT NULL,
  `descripcion` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id_categoria`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categoria`
--

LOCK TABLES `categoria` WRITE;
/*!40000 ALTER TABLE `categoria` DISABLE KEYS */;
/*!40000 ALTER TABLE `categoria` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categoria_publicidad`
--

DROP TABLE IF EXISTS `categoria_publicidad`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `categoria_publicidad` (
  `id` int(11) NOT NULL,
  `id_categoria` int(11) NOT NULL,
  `id_publicidad` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_categoria_publicidad_categoria1_idx` (`id_categoria`),
  KEY `fk_categoria_publicidad_publicidad1_idx` (`id_publicidad`),
  CONSTRAINT `fk_categoria_publicidad_categoria1` FOREIGN KEY (`id_categoria`) REFERENCES `categoria` (`id_categoria`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_categoria_publicidad_publicidad1` FOREIGN KEY (`id_publicidad`) REFERENCES `publicidad` (`id_publicidad`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categoria_publicidad`
--

LOCK TABLES `categoria_publicidad` WRITE;
/*!40000 ALTER TABLE `categoria_publicidad` DISABLE KEYS */;
/*!40000 ALTER TABLE `categoria_publicidad` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `empresas`
--

DROP TABLE IF EXISTS `empresas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `empresas` (
  `id_empresa` int(11) NOT NULL,
  `nombre` varchar(100) DEFAULT NULL,
  `telefono` int(10) DEFAULT NULL,
  `foto` varchar(200) NOT NULL,
  `direccion` varchar(100) DEFAULT NULL,
  `latitud` varchar(30) DEFAULT NULL,
  `longitud` varchar(30) DEFAULT NULL,
  `correo` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id_empresa`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `empresas`
--

LOCK TABLES `empresas` WRITE;
/*!40000 ALTER TABLE `empresas` DISABLE KEYS */;
INSERT INTO `empresas` VALUES (1,'Frisby',8756544,'','Cra 23 # 59 - 70 Local 14-15 Y 16 C.C. Multicentro','5.0694343','-75.5093442','frisby@frisby.com'),(2,'El corral',8756547,'','Calle 32 # 45-56','5.0626395','75.497648','pedidos@elcorral.com'),(3,'Hotel Carretero',8880502,'','Calle 13 # 45-01','5.067478','75.507561','admin@hotelcarretero.com'),(4,'Hotel Estelar Las colinas',8842009,'','Carrera 22 # 20-20','5.074065','-75.49767','admin@hotelestelar.com'),(5,'Totto Parque Caldas',8917599,'','Carrera 22 # 15-29','5.0690108','-75.513115','admin@totto.com'),(6,'Tennis Cable Plaza',8756466,'','Carrera 23 # 45B-60','5.0561637','-75.4848619','tennis@tennis.com'),(7,'Green Lake Hostel',8916712,'','Calle 63 # 22-22','5.0585872','-75.4868058','adminhotel@greenlakehotel.com'),(8,'Varuna Hotel',8811122,'','Calle 62 # 23-18','5.0592097','-75.4873637','varunahotelmanizales@gmail.com'),(9,'Los yarumos',8909090,'','Los yarumos','5.0562568','-75.4644719','losyarumos@gmail.com');
/*!40000 ALTER TABLE `empresas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `empresas_estadoanimo`
--

DROP TABLE IF EXISTS `empresas_estadoanimo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `empresas_estadoanimo` (
  `id_estadoanimo` int(11) NOT NULL,
  `id_empresa` int(11) NOT NULL,
  KEY `fk_empresas_estadoanimo_estadoanimo1` (`id_estadoanimo`),
  KEY `fk_empresas_estadoanimo_empresas1` (`id_empresa`),
  CONSTRAINT `fk_empresas_estadoanimo_estadoanimo1` FOREIGN KEY (`id_estadoanimo`) REFERENCES `estadoanimo` (`id_estadoanimo`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_empresas_estadoanimo_empresas1` FOREIGN KEY (`id_empresa`) REFERENCES `empresas` (`id_empresa`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `empresas_estadoanimo`
--

LOCK TABLES `empresas_estadoanimo` WRITE;
/*!40000 ALTER TABLE `empresas_estadoanimo` DISABLE KEYS */;
INSERT INTO `empresas_estadoanimo` VALUES (0,3),(0,4),(5,9),(2,9),(1,5),(1,2),(3,2);
/*!40000 ALTER TABLE `empresas_estadoanimo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `estadoanimo`
--

DROP TABLE IF EXISTS `estadoanimo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `estadoanimo` (
  `id_estadoanimo` int(11) NOT NULL,
  `nombre` varchar(45) NOT NULL,
  PRIMARY KEY (`id_estadoanimo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `estadoanimo`
--

LOCK TABLES `estadoanimo` WRITE;
/*!40000 ALTER TABLE `estadoanimo` DISABLE KEYS */;
INSERT INTO `estadoanimo` VALUES (0,'VIAJERO'),(1,'COMPRAS'),(2,'SOCIAL'),(3,'FAMILIAR'),(4,'ROMANTICO'),(5,'CULTURAL');
/*!40000 ALTER TABLE `estadoanimo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `evento`
--

DROP TABLE IF EXISTS `evento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `evento` (
  `id_evento` int(11) NOT NULL,
  `nombre` varchar(45) DEFAULT NULL,
  `descripcion` varchar(45) DEFAULT NULL,
  `fecha_inicio` timestamp NULL DEFAULT NULL,
  `fecha_fin` timestamp NULL DEFAULT NULL,
  `duraccion` varchar(45) DEFAULT NULL,
  `estado` varchar(45) DEFAULT NULL,
  `id_lugar` int(11) NOT NULL,
  `id_empresa` int(11) NOT NULL,
  PRIMARY KEY (`id_evento`),
  KEY `fk_evento_lugar_evento1_idx` (`id_lugar`),
  KEY `fk_evento_empresas1_idx` (`id_empresa`),
  CONSTRAINT `fk_evento_lugar_evento1` FOREIGN KEY (`id_lugar`) REFERENCES `lugar_evento` (`id_lugar`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_evento_empresas1` FOREIGN KEY (`id_empresa`) REFERENCES `empresas` (`id_empresa`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `evento`
--

LOCK TABLES `evento` WRITE;
/*!40000 ALTER TABLE `evento` DISABLE KEYS */;
/*!40000 ALTER TABLE `evento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lugar_evento`
--

DROP TABLE IF EXISTS `lugar_evento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lugar_evento` (
  `id_lugar` int(11) NOT NULL,
  `nombre` varchar(45) DEFAULT NULL,
  `direccion` varchar(45) DEFAULT NULL,
  `latitud` varchar(45) DEFAULT NULL,
  `longitud` varchar(45) DEFAULT NULL,
  `telefono` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id_lugar`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lugar_evento`
--

LOCK TABLES `lugar_evento` WRITE;
/*!40000 ALTER TABLE `lugar_evento` DISABLE KEYS */;
/*!40000 ALTER TABLE `lugar_evento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `publicidad`
--

DROP TABLE IF EXISTS `publicidad`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `publicidad` (
  `id_publicidad` int(11) NOT NULL,
  `titulo` varchar(45) DEFAULT NULL,
  `descripcion` varchar(45) DEFAULT NULL,
  `imagen` varchar(45) DEFAULT NULL,
  `codigo_qr` varchar(45) DEFAULT NULL,
  `estado` varchar(45) DEFAULT NULL,
  `id_empresa` int(11) NOT NULL,
  `id_evento` int(11) NOT NULL,
  PRIMARY KEY (`id_publicidad`),
  KEY `fk_publicidad_empresas1_idx` (`id_empresa`),
  KEY `fk_publicidad_evento1_idx` (`id_evento`),
  CONSTRAINT `fk_publicidad_empresas1` FOREIGN KEY (`id_empresa`) REFERENCES `empresas` (`id_empresa`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_publicidad_evento1` FOREIGN KEY (`id_evento`) REFERENCES `evento` (`id_evento`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `publicidad`
--

LOCK TABLES `publicidad` WRITE;
/*!40000 ALTER TABLE `publicidad` DISABLE KEYS */;
/*!40000 ALTER TABLE `publicidad` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipo_publicidad`
--

DROP TABLE IF EXISTS `tipo_publicidad`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tipo_publicidad` (
  `id_tipo` int(11) NOT NULL,
  `nombre` varchar(45) DEFAULT NULL,
  `descripcion` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id_tipo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipo_publicidad`
--

LOCK TABLES `tipo_publicidad` WRITE;
/*!40000 ALTER TABLE `tipo_publicidad` DISABLE KEYS */;
/*!40000 ALTER TABLE `tipo_publicidad` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipopublicidad_publicidad`
--

DROP TABLE IF EXISTS `tipopublicidad_publicidad`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tipopublicidad_publicidad` (
  `id` int(11) NOT NULL,
  `id_tipo_publicidad` int(11) NOT NULL,
  `id_publicidad` int(11) NOT NULL,
  UNIQUE KEY `Id_TipoPublicidad_UNIQUE` (`id_tipo_publicidad`),
  KEY `fk_tipopublicidad_publicidad_tipo_publicidad_idx` (`id_tipo_publicidad`),
  KEY `fk_tipopublicidad_publicidad_publicidad1_idx` (`id_publicidad`),
  CONSTRAINT `fk_tipopublicidad_publicidad_tipo_publicidad` FOREIGN KEY (`id_tipo_publicidad`) REFERENCES `tipo_publicidad` (`id_tipo`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tipopublicidad_publicidad_publicidad1` FOREIGN KEY (`id_publicidad`) REFERENCES `publicidad` (`id_publicidad`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipopublicidad_publicidad`
--

LOCK TABLES `tipopublicidad_publicidad` WRITE;
/*!40000 ALTER TABLE `tipopublicidad_publicidad` DISABLE KEYS */;
/*!40000 ALTER TABLE `tipopublicidad_publicidad` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2014-09-27 22:00:32
