-- MySQL dump 10.13  Distrib 26.7.0, for Win64 (x86_64)
--
-- Host: localhost    Database: charityevents_db
-- ------------------------------------------------------
-- Server version	26.7.0

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
SET @MYSQLDUMP_TEMP_LOG_BIN = @@SESSION.SQL_LOG_BIN;
SET @@SESSION.SQL_LOG_BIN= 0;

--
-- GTID state at the beginning of the backup 
--

SET @@GLOBAL.GTID_PURGED=/*!80000 '+'*/ 'c897430c-b4fc-11f1-8ddd-02508ca7948e:1-8';

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categories` (
  `category_id` int NOT NULL AUTO_INCREMENT,
  `category_name` varchar(50) NOT NULL,
  PRIMARY KEY (`category_id`),
  UNIQUE KEY `category_name` (`category_name`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` VALUES (5,'Charity Walk'),(4,'Concert'),(1,'Fun Run'),(2,'Gala Dinner'),(3,'Silent Auction');
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `events`
--

DROP TABLE IF EXISTS `events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `events` (
  `event_id` int NOT NULL AUTO_INCREMENT,
  `event_name` varchar(150) NOT NULL,
  `description` text,
  `event_date` date NOT NULL,
  `event_time` time DEFAULT NULL,
  `location` varchar(150) DEFAULT NULL,
  `ticket_price` decimal(10,2) DEFAULT '0.00',
  `goal_amount` decimal(12,2) DEFAULT '0.00',
  `current_amount` decimal(12,2) DEFAULT '0.00',
  `status` enum('active','suspended') DEFAULT 'active',
  `image_url` varchar(255) DEFAULT NULL,
  `org_id` int DEFAULT NULL,
  `category_id` int DEFAULT NULL,
  PRIMARY KEY (`event_id`),
  KEY `org_id` (`org_id`),
  KEY `category_id` (`category_id`),
  CONSTRAINT `events_ibfk_1` FOREIGN KEY (`org_id`) REFERENCES `organisations` (`org_id`),
  CONSTRAINT `events_ibfk_2` FOREIGN KEY (`category_id`) REFERENCES `categories` (`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `events`
--

LOCK TABLES `events` WRITE;
/*!40000 ALTER TABLE `events` DISABLE KEYS */;
INSERT INTO `events` VALUES (1,'City Fun Run 2026','A 5km fun run to raise funds for children.','2026-10-15','08:00:00','Sydney Olympic Park',25.00,10000.00,3500.00,'active',NULL,1,1),(2,'Charity Gala Night','An elegant evening of dinner and auction.','2026-11-05','19:00:00','Sydney Town Hall',150.00,50000.00,22000.00,'active',NULL,1,2),(3,'Silent Auction for Hope','Bid on amazing items to support children.','2026-10-28','18:30:00','Online',0.00,20000.00,8000.00,'active',NULL,1,3),(4,'Green Earth Concert','Live music to support reforestation.','2026-12-01','20:00:00','Melbourne Arena',80.00,30000.00,12000.00,'active',NULL,2,4),(5,'Coastal Charity Walk','Walk along the coast for a good cause.','2026-10-20','07:30:00','Bondi Beach',15.00,8000.00,2000.00,'active',NULL,2,5),(6,'Winter Gala 2026','A gala dinner supporting homeless communities.','2026-11-20','19:30:00','Brisbane Convention Centre',200.00,60000.00,25000.00,'active',NULL,3,2),(7,'Art Auction for Care','Auction of local artworks for charity.','2026-12-10','18:00:00','Perth Art Gallery',50.00,15000.00,5000.00,'active',NULL,3,3),(8,'Sunset Charity Run','Evening run to raise awareness.','2026-10-30','17:00:00','Adelaide Parklands',20.00,12000.00,4000.00,'active',NULL,1,1),(9,'Past Fun Run 2025','An event that already happened.','2025-05-01','08:00:00','Sydney',20.00,10000.00,10000.00,'active',NULL,1,1),(10,'Suspended Event','This event violated policy.','2026-11-01','10:00:00','Unknown',0.00,5000.00,0.00,'suspended',NULL,1,1);
/*!40000 ALTER TABLE `events` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `organisations`
--

DROP TABLE IF EXISTS `organisations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `organisations` (
  `org_id` int NOT NULL AUTO_INCREMENT,
  `org_name` varchar(100) NOT NULL,
  `description` text,
  `contact_email` varchar(100) DEFAULT NULL,
  `contact_phone` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`org_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `organisations`
--

LOCK TABLES `organisations` WRITE;
/*!40000 ALTER TABLE `organisations` DISABLE KEYS */;
INSERT INTO `organisations` VALUES (1,'Hope Foundation','Dedicated to helping children in need.','info@hopefoundation.org','02-1234-5678'),(2,'Green Earth','Environmental charity focused on reforestation.','contact@greenearth.org','02-2345-6789'),(3,'Care & Share','Supporting homeless communities.','hello@careshare.org','02-3456-7890');
/*!40000 ALTER TABLE `organisations` ENABLE KEYS */;
UNLOCK TABLES;
SET @@SESSION.SQL_LOG_BIN = @MYSQLDUMP_TEMP_LOG_BIN;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-09-20 22:48:06
