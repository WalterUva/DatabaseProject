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
INSERT INTO `Appointment` VALUES (300001,'customer_Jason','dealer_Uva',100007,'2017-03-05'),(300002,'customer_Jason','dealer_UVa',100007,'2017-04-03');
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
INSERT INTO `Appointment_Service` VALUES (300001,'Car check'),(300002,'Car Wash');
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
  `imageURL` varchar(255) DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`car_id`),
  KEY `car_ibfk_1` (`type_name`),
  KEY `car_ibfk_2` (`model_name`),
  CONSTRAINT `car_ibfk_1` FOREIGN KEY (`type_name`) REFERENCES `Type` (`name`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `car_ibfk_2` FOREIGN KEY (`model_name`) REFERENCES `Model` (`name`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Car`
--

LOCK TABLES `Car` WRITE;
/*!40000 ALTER TABLE `Car` DISABLE KEYS */;
INSERT INTO `Car` VALUES (100000,'Yukon','SUV','GMC','America',2010,96200,'http://st.motortrend.com/uploads/sites/10/2015/09/2015-GMC-Yukon-Denali-front1.jpg',60200.00),(100001,'Canyon','Pickup','GMC','America',2011,102000,'http://www.gmc.com/content/dam/GMC/global/master/nscwebsite/en/home/Vehicles/Current_Vehicles/2017_Canyon_Pickup/Model_Overview/01_images/2017-gmc-canyon-mov-exterior-mm1-lightbox-960x734-05.jpg',42000.00),(100002,'Cherokee','SUV','Jeep','America',2010,80021,'http://st.motortrend.com/uploads/sites/10/2016/09/2017-Jeep-Cherokee-Limited-front-three-quarter-in-motion-01.jpg',52180.00),(100003,'Compass','SUV','Jeep','America',2011,31275,'https://upload.wikimedia.org/wikipedia/commons/thumb/9/96/2008_Jeep_Compass_%28MK_MY08%29_Limited_2.4_wagon_%282015-11-11%29_01.jpg/280px-2008_Jeep_Compass_%28MK_MY08%29_Limited_2.4_wagon_%282015-11-11%29_01.jpg',32000.00),(100004,'F-150','Pickup','Ford','America',2006,124055,'http://st.motortrend.com/uploads/sites/5/2016/09/2017-Ford-F-150-front-three-quarter.jpg',9000.00),(100005,'Fusion','Sedan','Ford','America',2016,6000,'http://blog.caranddriver.com/wp-content/uploads/2012/08/2013-Ford-Fusion-red-626x310.jpg',32000.00),(100006,'Prius','Sedan','Toyota','Japan',2014,23000,'http://pictures.dealer.com//toyotakeene/51717c534046387201849dafcf139e96.jpeg',14000.00),(100007,'Prius','Sedan','Toyota','Japan',2010,80021,'http://s3.caradvice.com.au/thumb/770/382/wp-content/uploads/2009/06/pruis-2.jpg',13000.00),(100008,'Prius','Sedan','Toyota','Japan',2011,31275,'http://www.99parkandsell.com/images/large/Toyota-Pruis_P18721534.JPG',15000.00),(100009,'Camry','Sedan','Toyota','Japan',2006,124055,'http://o.aolcdn.com/commerce/autodata/images/USC60TOC021A021001.jpg',5000.00),(100010,'Corolla','Sedan','Toyota','Japan',2016,6000,'https://www.toyota.com/content/vehicle-landing/2017/corolla/features/img/refresh/desktop/COR_MY17_0056_V001.jpg',27000.00),(100011,'Prius','Sedan','Toyota','Japan',2012,48500,'https://readtiger.com/img/wkp/en/2012_Toyota_Prius_v_--_03-21-2012.JPG',11000.00),(100012,'Hignlander','SUV','Toyota','Japan',2015,42900,'http://media.caranddriver.com/images/media/267365/2008-toyota-highlander-photo-8761-s-450x274.jpg',45000.00);
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
  `register_date` date DEFAULT NULL,
  `balance` decimal(10,2) DEFAULT '0.00',
  PRIMARY KEY (`username`),
  CONSTRAINT `customer_ibfk_1` FOREIGN KEY (`username`) REFERENCES `user` (`username`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Customer`
--

LOCK TABLES `Customer` WRITE;
/*!40000 ALTER TABLE `Customer` DISABLE KEYS */;
INSERT INTO `Customer` VALUES ('customer_Alice','2014-10-12',1000.00),('customer_Bob','2012-09-23',54000.00),('customer_Jason','2017-01-01',100000.00);
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
  `register_date` date DEFAULT NULL,
  `star_count` int(11) DEFAULT '3',
  PRIMARY KEY (`username`),
  CONSTRAINT `dealer_ibfk_1` FOREIGN KEY (`username`) REFERENCES `user` (`username`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Dealer`
--

LOCK TABLES `Dealer` WRITE;
/*!40000 ALTER TABLE `Dealer` DISABLE KEYS */;
INSERT INTO `Dealer` VALUES ('dealer_Brown','2014-07-07',2),('dealer_CarFax','2012-01-01',3),('dealer_Uva','2016-08-15',5);
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
INSERT INTO `Following` VALUES ('customer_Jason',100005),('customer_Jason',100006),('customer_Jason',100007),('customer_Alice',100007),('customer_Bob',100009),('customer_Bob',100010);
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
INSERT INTO `Inventory` VALUES ('dealer_CarFAX',100000,'Charlottesville VA'),('dealer_CarFAX',100001,'Arlinton VA'),('dealer_CarFAX',100002,'Manassas VA'),('dealer_CarFAX',100003,'Front Royal VA'),('dealer_CarFAX',100004,'Woodbridge VA'),('dealer_Brown',100005,'San Francisco CA'),('dealer_Brown',100006,'St. Barbara CA'),('dealer_Brown',100007,'Los Angeles CA'),('dealer_Brown',100008,'Los Angeles CA'),('dealer_Uva',100009,'Charlottesville VA'),('dealer_Uva',100010,'Charlottesville VA'),('dealer_Uva',100011,'Charlottesville VA'),('dealer_Uva',100012,'Charlottesville VA');
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
  `year_creation` year(4) NOT NULL,
  `description` text,
  PRIMARY KEY (`name`,`year_creation`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Model`
--

LOCK TABLES `Model` WRITE;
/*!40000 ALTER TABLE `Model` DISABLE KEYS */;
INSERT INTO `Model` VALUES ('Camry','Toyota',2006,'Features and options are descriptive of what can be expected on the vehicle. Actual options should be verified by the customer and dealer.?'),('Canyon','GMC',2011,'Features and options are descriptive of what can be expected on the vehicle. Actual options should be verified by the customer and dealer.?'),('Cherokee','Jeep',2010,'Features and options are descriptive of what can be expected on the vehicle. Actual options should be verified by the customer and dealer.?'),('Compass','Jeep',2011,'Features and options are descriptive of what can be expected on the vehicle. Actual options should be verified by the customer and dealer.?'),('Corolla','Toyota',2016,'Features and options are descriptive of what can be expected on the vehicle. Actual options should be verified by the customer and dealer.?'),('F-150','Ford',2006,'Features and options are descriptive of what can be expected on the vehicle. Actual options should be verified by the customer and dealer.?'),('Fusion','Ford',2016,'Features and options are descriptive of what can be expected on the vehicle. Actual options should be verified by the customer and dealer.?'),('Hignlander','Toyota',2015,'Features and options are descriptive of what can be expected on the vehicle. Actual options should be verified by the customer and dealer.?'),('Prius','Toyota',2010,'Features and options are descriptive of what can be expected on the vehicle. Actual options should be verified by the customer and dealer.?'),('Prius','Toyota',2011,'Features and options are descriptive of what can be expected on the vehicle. Actual options should be verified by the customer and dealer.?'),('Prius','Toyota',2012,'Features and options are descriptive of what can be expected on the vehicle. Actual options should be verified by the customer and dealer.?'),('Prius','Toyota',2014,'Features and options are descriptive of what can be expected on the vehicle. Actual options should be verified by the customer and dealer.?'),('Yukon','GMC',2010,'Features and options are descriptive of what can be expected on the vehicle. Actual options should be verified by the customer and dealer.?');
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
  `title` enum('Salvage','Junk','Rebuilt','Fire','Flood','Hail','Lemon','Clean') DEFAULT NULL,
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
INSERT INTO `Report` VALUES (400001,100000,'2015-07-23','J*****',2.40,6000,'None','personal','Clean');
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
INSERT INTO `Review` VALUES (20001,'customer_Alice','dealer_UVa','2017-03-21 12:24:53','Very nice and helpful exp.',5),(20002,'customer_Jason','dealer_Brown','2017-03-24 09:04:19','Depressed. They are too arrogant',2);
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
  `price` decimal(10,2) DEFAULT NULL,
  `description` text,
  PRIMARY KEY (`service_type`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Services`
--

LOCK TABLES `Services` WRITE;
/*!40000 ALTER TABLE `Services` DISABLE KEYS */;
INSERT INTO `Services` VALUES ('Car check',0.00,'chech the situation of the car'),('Car maintenance',50.00,'A motor vehicle service is a series of maintenance procedures carried out at a set time interval or after the vehicle has travelled a certain distance.'),('Car Wash',5.00,'Car wash is a facility used to clean the exterior and in some cases the interior of motor vehicles.'),('Clean up oil spills',10.00,'Absorb the surface oil with kitty litter.');
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
  `transaction_price` decimal(10,2) DEFAULT NULL,
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
INSERT INTO `Transaction` VALUES (100007,'customer_Jason','dealer_Brown',13000.00,'2017-03-21');
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
INSERT INTO `Type` VALUES ('Coupe',' A coupe is a car with the body style two doors and fixed roof, that is shorter than a sedan'),('Minivan',' A minivan is a vehicle designed primarily for passengers, with two or three rows of seating accessed via large (often sliding) doors.'),('Pickup',' A pickup truck is a light duty truck having an enclosed cab and an open cargo area with low sides and tailgate'),('Sedan',' A sedan is a passenger car in a three-box configuration with A, B & C-pillars and principal volumes articulated in separate compartments for engine, passenger and cargo'),('SUV','A sport utility vehicle or suburban utility vehicle (SUV) is a vehicle classified as a light truck, but operated as a family vehicle'),('Van',' A van is a type of road vehicle used for transporting goods or people');
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
  `password` varchar(30) DEFAULT NULL,
  `name` varchar(30) DEFAULT NULL,
  `phone` varchar(30) DEFAULT NULL,
  `email` varchar(30) DEFAULT NULL,
  `zipcode` decimal(5,0) DEFAULT NULL,
  `authority` enum('Customer','Dealer','DBManager') DEFAULT NULL,
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `User`
--

LOCK TABLES `User` WRITE;
/*!40000 ALTER TABLE `User` DISABLE KEYS */;
INSERT INTO `User` VALUES ('admin','admin','Dbmanager','4342020000','root@db.com',22903,'DBManager'),('customer_Alice','customer_Alice','Alice','4342025555','alice@db.com',22904,'Customer'),('customer_Bob','customer_Bob','Bob','4342026666','bob@db.com',22905,'Customer'),('customer_Jason','customer_Jason','Jason','4342024444','jason@db.com',22903,'Customer'),('dealer_Brown','dealer_Brown','Brown','4342022222','brown@db.com',22901,'Dealer'),('dealer_CarFAX','dealer_CarFAX','CarFAX','4342021111','carfax@db.com',22904,'Dealer'),('dealer_Uva','dealer_Uva','Uva','4342023333','uva@db.com',22903,'Dealer');
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

-- Dump completed on 2017-04-30 22:46:30
