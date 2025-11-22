-- MySQL dump 10.13  Distrib 8.0.44, for Win64 (x86_64)
--
-- Host: localhost    Database: assignment3
-- ------------------------------------------------------
-- Server version	8.0.44

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
-- Table structure for table `bans`
--

DROP TABLE IF EXISTS `bans`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bans` (
  `startDate` date NOT NULL,
  `endDate` date NOT NULL,
  `reason` varchar(25) NOT NULL,
  `playerEmail` varchar(50) NOT NULL,
  PRIMARY KEY (`playerEmail`,`startDate`),
  CONSTRAINT `fk_playerEmail` FOREIGN KEY (`playerEmail`) REFERENCES `player` (`playerEmail`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bans`
--

LOCK TABLES `bans` WRITE;
/*!40000 ALTER TABLE `bans` DISABLE KEYS */;
INSERT INTO `bans` VALUES ('2024-11-20','2025-01-13','Underage','player127@example.com'),('2024-04-02','2024-05-07','Underage','player145@example.com'),('2024-06-01','2024-06-16','Underage','player165@example.com'),('2024-11-10','2025-01-06','Chargeback','player174@example.com'),('2024-07-16','2024-08-15','Cheating','player176@example.com'),('2024-06-18','2024-06-27','Chargeback','player187@example.com'),('2024-05-21','2024-07-10','Multiple Accounts','player191@example.com'),('2024-04-20','2024-06-14','Multiple Accounts','player199@example.com'),('2024-07-16','2024-09-10','Underage','player21@example.com'),('2024-10-31','2024-12-05','Abuse','player210@example.com'),('2024-10-08','2024-11-26','Underage','player22@example.com'),('2024-12-06','2025-01-31','Underage','player225@example.com'),('2024-12-05','2024-12-21','Fraud','player231@example.com'),('2024-11-02','2024-12-19','Multiple Accounts','player237@example.com'),('2024-08-05','2024-09-05','Multiple Accounts','player244@example.com'),('2024-11-03','2024-12-01','Abuse','player257@example.com'),('2024-03-15','2024-04-05','Abuse','player259@example.com'),('2024-02-29','2024-03-17','Abuse','player268@example.com'),('2024-02-20','2024-04-05','Chargeback','player269@example.com'),('2024-06-20','2024-07-26','Fraud','player27@example.com'),('2024-02-06','2024-03-19','Multiple Accounts','player284@example.com'),('2024-02-01','2024-03-16','Multiple Accounts','player293@example.com'),('2024-05-09','2024-05-20','Fraud','player298@example.com'),('2024-05-22','2024-07-11','Underage','player307@example.com'),('2024-10-02','2024-10-14','Fraud','player310@example.com'),('2024-11-18','2025-01-08','Underage','player313@example.com'),('2024-09-23','2024-11-02','Cheating','player32@example.com'),('2024-03-01','2024-03-12','Fraud','player331@example.com'),('2024-02-24','2024-03-24','Fraud','player334@example.com'),('2024-12-17','2025-02-15','Abuse','player348@example.com'),('2024-01-15','2024-03-04','Fraud','player363@example.com'),('2024-05-20','2024-06-15','Abuse','player366@example.com'),('2024-05-30','2024-06-24','Fraud','player379@example.com'),('2024-07-26','2024-08-17','Fraud','player397@example.com'),('2024-03-24','2024-04-21','Chargeback','player44@example.com'),('2024-09-07','2024-10-26','Chargeback','player53@example.com'),('2024-09-17','2024-11-07','Multiple Accounts','player78@example.com'),('2024-11-10','2024-11-27','Multiple Accounts','player82@example.com'),('2024-11-23','2025-01-19','Cheating','player89@example.com'),('2024-09-11','2024-11-01','Multiple Accounts','player97@example.com');
/*!40000 ALTER TABLE `bans` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-11-21 21:41:42
