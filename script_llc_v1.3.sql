-- MySQL dump 10.13  Distrib 5.7.17, for macos10.12 (x86_64)
--
-- Host: 127.0.0.1    Database: project
-- ------------------------------------------------------
-- Server version	5.7.17

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
-- Table structure for table `Appointment`
--

DROP TABLE IF EXISTS `Appointment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Appointment` (
  `appointment_id` int(11) NOT NULL,
  `c_name` varchar(30) DEFAULT NULL,
  `d_name` varchar(30) DEFAULT NULL,
  `car_id` int(11) DEFAULT NULL,
  `appointment_time` date DEFAULT NULL,
  PRIMARY KEY (`appointment_id`),
  KEY `appointment_ibfk_1` (`c_name`),
  KEY `appointment_ibfk_2` (`d_name`),
  KEY `appointment_ibfk_3` (`car_id`),
  CONSTRAINT `appointment_ibfk_1` FOREIGN KEY (`c_name`) REFERENCES `Customer` (`username`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `appointment_ibfk_2` FOREIGN KEY (`d_name`) REFERENCES `Dealer` (`username`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `appointment_ibfk_3` FOREIGN KEY (`car_id`) REFERENCES `Car` (`car_id`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Appointment`
--

LOCK TABLES `Appointment` WRITE;
/*!40000 ALTER TABLE `Appointment` DISABLE KEYS */;
/*!40000 ALTER TABLE `Appointment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Appointment_Service`
--

DROP TABLE IF EXISTS `Appointment_Service`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Appointment_Service` (
  `appointment_id` int(11) DEFAULT NULL,
  `service_type` varchar(30) DEFAULT NULL,
  KEY `service_type` (`service_type`),
  KEY `appointment_service_ibfk_1` (`appointment_id`),
  CONSTRAINT `appointment_service_ibfk_1` FOREIGN KEY (`appointment_id`) REFERENCES `Appointment` (`appointment_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `appointment_service_ibfk_2` FOREIGN KEY (`service_type`) REFERENCES `Services` (`service_type`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Appointment_Service`
--

LOCK TABLES `Appointment_Service` WRITE;
/*!40000 ALTER TABLE `Appointment_Service` DISABLE KEYS */;
/*!40000 ALTER TABLE `Appointment_Service` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Car`
--

DROP TABLE IF EXISTS `Car`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Car` (
  `car_id` int(11) NOT NULL,
  `model_name` varchar(30) DEFAULT NULL,
  `type_name` varchar(30) DEFAULT NULL,
  `brand_name` varchar(30) DEFAULT NULL,
  `place_of_production` varchar(30) DEFAULT NULL,
  `year_of_production` year(4) DEFAULT NULL,
  `mileage` int(11) DEFAULT NULL,
  `imageURL` varchar(100) DEFAULT NULL,
  `price` decimal(5,2) DEFAULT NULL,
  PRIMARY KEY (`car_id`),
  KEY `car_ibfk_1` (`type_name`),
  KEY `car_ibfk_2` (`model_name`),
  KEY `car_ibfk_3_idx` (`brand_name`),
  CONSTRAINT `car_ibfk_1` FOREIGN KEY (`type_name`) REFERENCES `Type` (`name`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `car_ibfk_2` FOREIGN KEY (`model_name`) REFERENCES `Model` (`name`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `car_ibfk_3` FOREIGN KEY (`brand_name`) REFERENCES `Model` (`name`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Car`
--

LOCK TABLES `Car` WRITE;
/*!40000 ALTER TABLE `Car` DISABLE KEYS */;
/*!40000 ALTER TABLE `Car` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Customer`
--

DROP TABLE IF EXISTS `Customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Customer` (
  `username` varchar(30) NOT NULL,
  `balance` decimal(5,2) DEFAULT '0.00',
  PRIMARY KEY (`username`),
  CONSTRAINT `customer_ibfk_1` FOREIGN KEY (`username`) REFERENCES `User` (`username`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Customer`
--

LOCK TABLES `Customer` WRITE;
/*!40000 ALTER TABLE `Customer` DISABLE KEYS */;
/*!40000 ALTER TABLE `Customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Dealer`
--

DROP TABLE IF EXISTS `Dealer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Dealer` (
  `username` varchar(30) NOT NULL,
  `star_count` int(11) DEFAULT '3',
  PRIMARY KEY (`username`),
  CONSTRAINT `dealer_ibfk_1` FOREIGN KEY (`username`) REFERENCES `User` (`username`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Dealer`
--

LOCK TABLES `Dealer` WRITE;
/*!40000 ALTER TABLE `Dealer` DISABLE KEYS */;
/*!40000 ALTER TABLE `Dealer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Following`
--

DROP TABLE IF EXISTS `Following`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Following` (
  `username` varchar(30) DEFAULT NULL,
  `car_id` int(11) DEFAULT NULL,
  KEY `following_ibfk_1` (`username`),
  KEY `following_ibfk_2` (`car_id`),
  CONSTRAINT `following_ibfk_1` FOREIGN KEY (`username`) REFERENCES `Customer` (`username`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `following_ibfk_2` FOREIGN KEY (`car_id`) REFERENCES `Car` (`car_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Following`
--

LOCK TABLES `Following` WRITE;
/*!40000 ALTER TABLE `Following` DISABLE KEYS */;
/*!40000 ALTER TABLE `Following` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Inventory`
--

DROP TABLE IF EXISTS `Inventory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Inventory` (
  `username` varchar(30) DEFAULT NULL,
  `car_id` int(11) DEFAULT NULL,
  `location` varchar(30) DEFAULT NULL,
  KEY `inventory_ibfk_1` (`username`),
  KEY `inventory_ibfk_2` (`car_id`),
  CONSTRAINT `inventory_ibfk_1` FOREIGN KEY (`username`) REFERENCES `Dealer` (`username`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `inventory_ibfk_2` FOREIGN KEY (`car_id`) REFERENCES `Car` (`car_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Inventory`
--

LOCK TABLES `Inventory` WRITE;
/*!40000 ALTER TABLE `Inventory` DISABLE KEYS */;
/*!40000 ALTER TABLE `Inventory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Model`
--

DROP TABLE IF EXISTS `Model`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Model` (
  `name` varchar(30) NOT NULL,
  `brand_name` varchar(30) DEFAULT NULL,
  `creation_year` date DEFAULT NULL,
  `price_min` decimal(5,2) DEFAULT NULL,
  `price_max` decimal(5,2) DEFAULT NULL,
  `description` text,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Model`
--

LOCK TABLES `Model` WRITE;
/*!40000 ALTER TABLE `Model` DISABLE KEYS */;
/*!40000 ALTER TABLE `Model` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Report`
--

DROP TABLE IF EXISTS `Report`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Report` (
  `report_id` int(11) NOT NULL,
  `car_id` int(11) DEFAULT NULL,
  `check_date` date DEFAULT NULL,
  `owner` varchar(30) DEFAULT NULL,
  `estimated_ownership_length` decimal(3,2) DEFAULT NULL,
  `mileage` int(11) DEFAULT NULL,
  `accident` enum('None','Damage','Accident') DEFAULT NULL,
  `use_type` enum('personal','goverment','commercial') DEFAULT NULL,
  `title` enum('Salvage','Junk','Rebuilt','Fire','Flood','Hail','Lemon') DEFAULT NULL,
  PRIMARY KEY (`report_id`),
  KEY `report_ibfk_1` (`car_id`),
  CONSTRAINT `report_ibfk_1` FOREIGN KEY (`car_id`) REFERENCES `Car` (`car_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Report`
--

LOCK TABLES `Report` WRITE;
/*!40000 ALTER TABLE `Report` DISABLE KEYS */;
/*!40000 ALTER TABLE `Report` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Review`
--

DROP TABLE IF EXISTS `Review`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Review` (
  `review_id` int(11) NOT NULL,
  `c_name` varchar(30) DEFAULT NULL,
  `d_name` varchar(30) DEFAULT NULL,
  `release_time` datetime DEFAULT NULL,
  `comment` text,
  `star_count` int(11) DEFAULT NULL,
  PRIMARY KEY (`review_id`),
  KEY `review_ibfk_1` (`c_name`),
  KEY `review_ibfk_2` (`d_name`),
  CONSTRAINT `review_ibfk_1` FOREIGN KEY (`c_name`) REFERENCES `Customer` (`username`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `review_ibfk_2` FOREIGN KEY (`d_name`) REFERENCES `Dealer` (`username`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Review`
--

LOCK TABLES `Review` WRITE;
/*!40000 ALTER TABLE `Review` DISABLE KEYS */;
/*!40000 ALTER TABLE `Review` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Services`
--

DROP TABLE IF EXISTS `Services`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Services` (
  `service_type` varchar(30) NOT NULL,
  `price` decimal(5,2) DEFAULT NULL,
  `description` text,
  PRIMARY KEY (`service_type`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Services`
--

LOCK TABLES `Services` WRITE;
/*!40000 ALTER TABLE `Services` DISABLE KEYS */;
/*!40000 ALTER TABLE `Services` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Transaction`
--

DROP TABLE IF EXISTS `Transaction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Transaction` (
  `car_id` int(11) DEFAULT NULL,
  `c_name` varchar(30) DEFAULT NULL,
  `d_name` varchar(30) DEFAULT NULL,
  `transaction_price` decimal(5,2) DEFAULT NULL,
  `transaction_date` date DEFAULT NULL,
  KEY `transaction_ibfk_1` (`car_id`),
  KEY `transaction_ibfk_2` (`c_name`),
  KEY `transaction_ibfk_3` (`d_name`),
  CONSTRAINT `transaction_ibfk_1` FOREIGN KEY (`car_id`) REFERENCES `Car` (`car_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `transaction_ibfk_2` FOREIGN KEY (`c_name`) REFERENCES `Customer` (`username`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `transaction_ibfk_3` FOREIGN KEY (`d_name`) REFERENCES `Dealer` (`username`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Transaction`
--

LOCK TABLES `Transaction` WRITE;
/*!40000 ALTER TABLE `Transaction` DISABLE KEYS */;
/*!40000 ALTER TABLE `Transaction` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Type`
--

DROP TABLE IF EXISTS `Type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Type` (
  `name` varchar(30) NOT NULL,
  `description` text,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Type`
--

LOCK TABLES `Type` WRITE;
/*!40000 ALTER TABLE `Type` DISABLE KEYS */;
/*!40000 ALTER TABLE `Type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `User`
--

DROP TABLE IF EXISTS `User`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `User` (
  `username` varchar(30) NOT NULL,
  `password` varbinary(256) DEFAULT NULL,
  `name` varchar(30) DEFAULT NULL,
  `phone` varchar(30) DEFAULT NULL,
  `email` varchar(30) DEFAULT NULL,
  `zipcode` decimal(5,0) DEFAULT NULL,
  `register_date` date NOT NULL,
  `authority` enum('Customer','Dealer','DBManager') DEFAULT 'Customer',
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `User`
--

LOCK TABLES `User` WRITE;
/*!40000 ALTER TABLE `User` DISABLE KEYS */;
/*!40000 ALTER TABLE `User` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `ownerhistory`
--

DROP TABLE IF EXISTS `ownerhistory`;
/*!50001 DROP VIEW IF EXISTS `ownerhistory`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `ownerhistory` AS SELECT 
 1 AS `car_id`,
 1 AS `check_date`,
 1 AS `estimated_ownership_length`,
 1 AS `accident`,
 1 AS `mileage`,
 1 AS `title`,
 1 AS `use_type`,
 1 AS `name`,
 1 AS `email`*/;
SET character_set_client = @saved_cs_client;

--
-- Dumping events for database 'project'
--

--
-- Dumping routines for database 'project'
--
/*!50003 DROP FUNCTION IF EXISTS `countStar` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `countStar`(dealer_name varchar(30)) RETURNS int(11)
begin
		Declare star int default 3;
        SET star =  (select avg(temp.s) from (select  r.star_count as s from Review r where r.d_name = dealer_name) temp);
        update Dealer set star_count = star where Dealer.username = dealer_name;
        return star;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `ownerhistory`
--

/*!50001 DROP VIEW IF EXISTS `ownerhistory`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `ownerhistory` AS select `r`.`car_id` AS `car_id`,`r`.`check_date` AS `check_date`,`r`.`estimated_ownership_length` AS `estimated_ownership_length`,`r`.`accident` AS `accident`,`r`.`mileage` AS `mileage`,`r`.`title` AS `title`,`r`.`use_type` AS `use_type`,`c`.`name` AS `name`,`c`.`email` AS `email` from (`report` `r` left join `user` `c` on((`r`.`owner` = `c`.`username`))) order by `r`.`check_date` desc limit 5 */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-04-30 17:29:14
