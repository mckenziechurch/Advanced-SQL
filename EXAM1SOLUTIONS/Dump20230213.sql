-- MySQL dump 10.13  Distrib 8.0.31, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: raihan
-- ------------------------------------------------------
-- Server version	8.0.31

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `customers`
--


--
-- Table structure for table `insurance_types`
--

DROP TABLE IF EXISTS `insurance_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `insurance_types` (
  `id` tinyint unsigned NOT NULL AUTO_INCREMENT,
  `insurance_type` varchar(15) NOT NULL,
  `insurance_price` decimal(10,0) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `insurance_types`
--

LOCK TABLES `insurance_types` WRITE;
/*!40000 ALTER TABLE `insurance_types` DISABLE KEYS */;
INSERT INTO `insurance_types` VALUES (1,'fire',15),(2,'flood',20),(3,'earthquake',10);
/*!40000 ALTER TABLE `insurance_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--


--
-- Table structure for table `rental_insurance`
--

DROP TABLE IF EXISTS `rental_insurance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rental_insurance` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `insurance_start_date` date DEFAULT NULL,
  `insurance_end_date` date DEFAULT NULL,
  `rental_id` int unsigned NOT NULL,
  `insurance_type` tinyint unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `rental_id` (`rental_id`),
  KEY `insurance_type` (`insurance_type`),
  CONSTRAINT `rental_insurance_ibfk_1` FOREIGN KEY (`rental_id`) REFERENCES `rentals` (`id`),
  CONSTRAINT `rental_insurance_ibfk_2` FOREIGN KEY (`insurance_type`) REFERENCES `insurance_types` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rental_insurance`
--

LOCK TABLES `rental_insurance` WRITE;
/*!40000 ALTER TABLE `rental_insurance` DISABLE KEYS */;
INSERT INTO `rental_insurance` VALUES (13,'2001-10-10','2003-10-10',2,2),(14,'2001-10-10',NULL,4,3);
/*!40000 ALTER TABLE `rental_insurance` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rentals`
--

DROP TABLE IF EXISTS `rentals`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rentals` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `rental_start_date` date DEFAULT NULL,
  `rental_end_date` date DEFAULT NULL,
  `storage_unit` smallint unsigned DEFAULT NULL,
  `renter` mediumint unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `storage_unit` (`storage_unit`),
  KEY `renter` (`renter`),
  CONSTRAINT `rentals_ibfk_1` FOREIGN KEY (`storage_unit`) REFERENCES `units` (`id`),
  CONSTRAINT `rentals_ibfk_2` FOREIGN KEY (`renter`) REFERENCES `renters` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rentals`
--

LOCK TABLES `rentals` WRITE;
/*!40000 ALTER TABLE `rentals` DISABLE KEYS */;
INSERT INTO `rentals` VALUES (1,'2010-10-10',NULL,2,1),(2,'2000-10-10','2003-10-10',1,3),(3,'2000-09-09','2021-10-10',3,2),(4,'2003-12-12',NULL,1,1);
/*!40000 ALTER TABLE `rentals` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `renters`
--

DROP TABLE IF EXISTS `renters`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `renters` (
  `id` mediumint unsigned NOT NULL AUTO_INCREMENT,
  `renter_name` varchar(50) NOT NULL,
  `renter_address` varchar(100) DEFAULT NULL,
  `renter_phone` varchar(15) NOT NULL,
  `renter_email` varchar(100) DEFAULT NULL,
  `renter_state_id` varchar(25) DEFAULT NULL,
  `renter_id_type` varchar(10) DEFAULT NULL,
  `issuing_state` char(3) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `renters`
--

LOCK TABLES `renters` WRITE;
/*!40000 ALTER TABLE `renters` DISABLE KEYS */;
INSERT INTO `renters` VALUES (1,'John','123 blah st','5555555555',NULL,NULL,NULL,NULL),(2,'Jane','333 crazy st','6666666666',NULL,NULL,NULL,NULL),(3,'someone','222 some st','7777777777',NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `renters` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `units`
--

DROP TABLE IF EXISTS `units`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `units` (
  `id` smallint unsigned NOT NULL AUTO_INCREMENT,
  `unit_name` varchar(4) DEFAULT NULL,
  `unit_height` decimal(10,0) DEFAULT NULL,
  `unit_length` decimal(10,0) DEFAULT NULL,
  `unit_width` decimal(10,0) DEFAULT NULL,
  `storage_price` decimal(10,0) DEFAULT NULL,
  `rentable` char(1) DEFAULT 'Y',
  PRIMARY KEY (`id`),
  UNIQUE KEY `unit_name` (`unit_name`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `units`
--

LOCK TABLES `units` WRITE;
/*!40000 ALTER TABLE `units` DISABLE KEYS */;
INSERT INTO `units` VALUES (1,'ST1',10,10,10,50,'Y'),(2,'ST2',10,10,10,50,'N'),(3,'ST3',15,15,15,100,'Y'),(4,'ST4',12,12,12,75,'Y');
/*!40000 ALTER TABLE `units` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-02-13 22:14:59
