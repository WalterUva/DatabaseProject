Use `project`;

Drop table If exists `User`;
CREATE TABLE `User` (
  `username` varchar(30),  #primary key
  `password` varchar(30),  # need encryption here
  `name` varchar(30),
  `phone` varchar(30),
  `email` varchar(30),
  `zipcode` decimal(5),
  `authority` enum('Customer', 'Dealer', 'DBManager')
);

Drop table If exists `Customer`;
CREATE TABLE `Customer` (
  `username` varchar(30),  #foreign key
  `register_date` date,
  `balance` decimal(5, 2)
);

Drop table If exists `Dealer`;
CREATE TABLE `Dealer` (
  `username` varchar(30),  #foreign key
  `register_date` date,
  `star_count` integer
);

Drop table If exists `Type`;
CREATE TABLE `Type` (
  `name` varchar(30),
  `description` text
);

Drop table If exists `Model`;
CREATE TABLE `Model` (
  `name` varchar(30),
  `brand_name` varchar(30),
  `creation_year` date,
  `price_min` decimal(5,2),
  `price_max` decimal(5,2),
  `description` text
);

Drop table If exists `Car`;
CREATE TABLE `Car` (
  `car_id` integer,
  `model_name` varchar(30),   #foreign key
  `type_name` varchar(30),	   #forign key
  `place_of_production` varchar(30),
  `year_of_production` year,
  `mileage` int,
  `imageURL` varchar(100),
  `price` decimal(5, 2)
);

Drop table If exists `Inventory`;
CREATE TABLE `Inventory` (
  `username` varchar(30), #foreign key
  `car_id` integer,       #foreign key
  `location` varchar(30)
); 
#Seriously I think location is enough to differ Inventory from Following

Drop table If exists `Following`;
CREATE TABLE `Following` (
  `username` varchar(30), #foreign key
  `car_id` integer       #foreign key
);

Drop table If exists `Transaction`;
CREATE TABLE `Transaction` (
   `car_id` integer,
   `c_name` varchar(30),     #customer
   `d_name` varchar(30),   #dealer
   `transaction_price` decimal(5,2),
   `transaction_date` date
);

Drop table If exists `Review`;
CREATE TABLE `Review` (
  `review_id` int,
  `c_name` varchar(30),              #foreign key for dealer
  `d_name` varchar(30),             #foreign key
  `release_time` datetime,
  `comment` text,
  `star_count` integer
);
# constraint here

Drop table If exists `Appointment`;
CREATE TABLE `Appointment` (
  `appointment_id` int,
  `c_name` varchar(30),     #foreign key for customer
  `d_name` varchar(30),    #foreign key for dealer
  `car_id`  integer, 		  		 #foreign key
  `appointment_time` date
);

Drop table If exists `Appointment_Service`;
CREATE	TABLE `Appointment_Service` (
  `appointment_id` integer,  	#primary key
  `serivce_type` varchar(30)   	#primary key
);

Drop table If exists `Services`;
CREATE TABLE `Services` (
  `serivce_type` varchar(30),    #primary key
  `price` decimal(5,2),
  `description` text
);

Drop table If exists `Report`;
CREATE TABLE `Report` (
  `report_id` integer,
  `car_id` integer,    #foreign key
  `check_date` date,
  `owner` varchar(30),
  `estimated_ownership_length` decimal(3,2),
  `mileage` int,
  `accident` enum('None','Damage','Accident'),
  `use_type` enum('personal','goverment','commercial'),
  `title` enum('Salvage','Junk','Rebuilt','Fire','Flood','Hail','Lemon')
); 

