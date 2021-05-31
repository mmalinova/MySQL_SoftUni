CREATE DATABASE `minions`;
USE `minions`;
-- 1.
CREATE TABLE `minions` (
	`id` INT PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(30),
    `age` INT
);

CREATE TABLE `towns` (
	`town_id` INT PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(30)
);

-- 2.
ALTER TABLE `minions`
ADD `town_id` INT,
ADD CONSTRAINT fk_minions_towns
FOREIGN KEY (`town_id`)
REFERENCES `towns`(`id`);

-- 3.
INSERT INTO `towns` VALUES
(1, 'Sofia'),
(2, 'Plovdiv'),
(3, 'Varna');

INSERT INTO `minions` VALUES
(1, 'Kevin', 22, 1),
(2, 'Bob', 15, 3),
(3, 'Steward', NULL, 2);
    
-- 4.
TRUNCATE `minions`;

-- 5.
DROP TABLE `minions`, `towns`;

-- 6. Maybe with 5 inserts
CREATE TABLE `people`(
	`id` INT PRIMARY KEY AUTO_INCREMENT UNIQUE,
    `name` VARCHAR(200) NOT NULL,
    `picture` BLOB,
    `height` FLOAT(3, 2),
    `weight` FLOAT(3, 2),
    `gender` CHAR(1) NOT NULL,
    `birthdate` DATE NOT NULL,
    `biography` TEXT
);
INSERT INTO `people` VALUES
(1, 'a', '2', 2, 3, 'f', now(), 'any'),
(2, 'a', '2', 2, 3, 'f', now(), 'any'),
(3, 'a', '2', 2, 3, 'f', now(), 'any'),
(4, 'a', '2', 2, 3, 'f', now(), 'any'),
(5, 'a', '2', 2, 3, 'f', now(), 'any');

-- 7. Maybe with 5 inserts
CREATE TABLE `users`(
	`id` INT PRIMARY KEY AUTO_INCREMENT UNIQUE,
    `username` VARCHAR(30) NOT NULL UNIQUE,
    `password` VARCHAR(26) NOT NULL,
    `profile_picture` BLOB,
    `lats_login_time` DATETIME,
    `is_deleted` BOOL NOT NULL
);
INSERT INTO `users` VALUES
(1, 'a', '2', '2', now(), false),
(2, 'a', '2', '2', now(), false),
(3, 'a', '2', '2', now(), false),
(4, 'a', '2', '2', now(), false),
(5, 'a', '2', '2', now(), false);

-- 8.
ALTER TABLE `users`
DROP PRIMARY KEY,
ADD CONSTRAINT pk_users
PRIMARY KEY (`id`, `username`);

-- 9.
ALTER TABLE `users`
CHANGE COLUMN `lats_login_time`
`lats_login_time` DATETIME DEFAULT CURRENT_TIMESTAMP;

-- 10.
ALTER TABLE `users`
DROP PRIMARY KEY,
ADD CONSTRAINT pk_users
PRIMARY KEY (`id`),
CHANGE COLUMN `username`
`username` VARCHAR(30) NOT NULL UNIQUE;

-- 11.  Maybe with 5 inserts
CREATE DATABASE IF NOT EXISTS `movies`;

CREATE TABLE `directors` (
	`id` INT PRIMARY KEY AUTO_INCREMENT UNIQUE,
    `director_name` VARCHAR(40) NOT NULL,
    `notes` TEXT
); 
CREATE TABLE `genres` (
	`id` INT PRIMARY KEY AUTO_INCREMENT UNIQUE,
    `genre_name` VARCHAR(40) NOT NULL,
    `notes` TEXT
); 
CREATE TABLE `categories` (
	`id` INT PRIMARY KEY AUTO_INCREMENT UNIQUE,
    `category_name` VARCHAR(30) NOT NULL,
    `notes` TEXT
); 
CREATE TABLE `movies` (
	`id` INT PRIMARY KEY AUTO_INCREMENT UNIQUE,
    `title` VARCHAR(50) NOT NULL,
    `director_id` INT NOT NULL,
    `copyright_year` INT,
    `length` FLOAT,
    `genre_id` INT NOT NULL,
    `category_id` INT NOT NULL,
    `rating` FLOAT,
    `notes` TEXT
); 

-- 12. Maybe with 3 inserts
CREATE DATABASE IF NOT EXISTS `car_rental`;

CREATE TABLE `categories` (
	`id` INT PRIMARY KEY AUTO_INCREMENT UNIQUE,
    `category` VARCHAR(30) NOT NULL,
    `daily_rate` FLOAT NOT NULL,
    `weekly_rate` FLOAT NOT NULL,
    `monthly_rate` FLOAT NOT NULL,
    `weekend_rate` FLOAT NOT NULL
); 
CREATE TABLE `cars` (
	`id` INT PRIMARY KEY AUTO_INCREMENT UNIQUE,
    `plate_number` INT NOT NULL,
    `make` VARCHAR(30) NOT NULL,
    `model` VARCHAR(30) NOT NULL,
    `car_year` INT NOT NULL,
    `category_id` INT NOT NULL,
    `doors` INT,
    `picture` BLOB,
    `car_condition` TEXT,
    `available` BOOL
); 
CREATE TABLE `employees` (
	`id` INT PRIMARY KEY AUTO_INCREMENT UNIQUE,
    `first_name` VARCHAR(30) NOT NULL,
    `last_name` VARCHAR(30) NOT NULL,
    `title` VARCHAR(30) NOT NULL,
    `notes` TEXT
); 
CREATE TABLE `customers` (
	`id` INT PRIMARY KEY AUTO_INCREMENT UNIQUE,
    `driver_licence_number` INT NOT NULL UNIQUE,
    `full_name` VARCHAR(50) NOT NULL,
    `address` VARCHAR(50) NOT NULL,
    `city` VARCHAR(20) NOT NULL,
    `zip_code` INT NOT NULL,
    `notes` TEXT
);

CREATE TABLE `rental_orders` (
	`id` INT PRIMARY KEY AUTO_INCREMENT UNIQUE,
    `employee_id` INT NOT NULL,
    `customer_id` INT NOT NULL,
    `car_id` INT NOT NULL,
    `car_condition` TEXT,
    `tank_level` INT,
    `kilometrage_start` FLOAT,
    `kilometrage_end` FLOAT,
    `total_kilometrage` FLOAT NOT NULL,
    `start_date` DATE NOT NULL,
    `end_date` DATE NOT NULL,
    `total_days` INT,
    `rate_applied` FLOAT NOT NULL,
    `tax_rate` FLOAT NOT NULL,
    `order_status` VARCHAR(30),
    `notes` TEXT
);

-- 13.
CREATE DATABASE IF NOT EXISTS `soft_uni`;

CREATE TABLE `towns` (
	`id` INT PRIMARY KEY AUTO_INCREMENT UNIQUE,
    `name` VARCHAR(30) NOT NULL
); 
CREATE TABLE `addresses` (
	`id` INT PRIMARY KEY AUTO_INCREMENT UNIQUE,
    `address_text` VARCHAR(60) NOT NULL,
    `town_id` INT NOT NULL,
	CONSTRAINT fk_adresses_towns FOREIGN KEY (`town_id`) REFERENCES `towns`(`id`)
); 
CREATE TABLE `departments` (
	`id` INT PRIMARY KEY AUTO_INCREMENT UNIQUE,
    `name` VARCHAR(30) NOT NULL
); 
CREATE TABLE `employees` (
	`id` INT PRIMARY KEY AUTO_INCREMENT UNIQUE,
    `first_name` VARCHAR(20) NOT NULL,
    `middle_name` VARCHAR(20) NOT NULL,
    `last_name` VARCHAR(20) NOT NULL,
    `job_title` VARCHAR(40) NOT NULL,
    `department_id` INT NOT NULL,
    `hire_date` DATE NOT NULL,
    `salary` DECIMAL(6, 2) NOT NULL,
    `address_id` INT,
    CONSTRAINT fk_employees_departments
    FOREIGN KEY (`department_id`) REFERENCES `departments`(`id`),
	CONSTRAINT fk_employees_addresses
    FOREIGN KEY (`address_id`) REFERENCES `addresses`(`id`)
); 

ALTER TABLE `employees`
CHANGE COLUMN `address_id` 
`address_id` INT;

INSERT INTO `towns` (`name`) VALUES
('Sofia'),
('Plovdiv'),
('Varna'),
('Burgas');
INSERT INTO `departments` (`name`) VALUES
('Engineering'),
('Sales'),
('Marketing'),
('Software Development'),
('Quality Assurance');

INSERT INTO `employees` (`first_name`, `middle_name`, `last_name`, `job_title`, `department_id`,
 `hire_date`, `salary`) VALUES
('Ivan', 'Ivanov', 'Ivanov', '.NET Developer',	4,	'2013-02-01', 3500.00),
('Petar', 'Petrov', 'Petrov', 'Senior Engineer', 1,	'2004-03-02', 4000.00),
('Maria', 'Petrova', 'Ivanova', 'Intern',	5,	'2016-08-28', 525.25),
('Georgi', 'Terziev', 'Ivanov', 'CEO',	2,	'2007-12-09', 3000.00),
('Peter', 'Pan', 'Pan', 'Intern',	3,	'2016-08-28', 599.88);

-- 14.
SELECT * FROM `towns`;
SELECT * FROM `departments`;
SELECT * FROM `employees`;

-- 15.
SELECT * FROM `towns`
ORDER BY `name`;
SELECT * FROM `departments`
ORDER BY `name`;
SELECT * FROM `employees`
ORDER BY `salary` DESC;

-- 16.
SELECT `name` FROM `towns`
ORDER BY `name`;
SELECT `name` FROM `departments`
ORDER BY `name`;
SELECT `first_name`, `last_name`, `job_title`, `salary` FROM `employees`
ORDER BY `salary` DESC;

-- 17.
UPDATE `employees` SET `salary` = `salary` * 1.1;
SELECT `salary` FROM `employees`;

-- 18.
DELETE FROM `occupancies`;