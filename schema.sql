-- MariaDB dump 10.19  Distrib 10.6.16-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: 127.0.0.1    Database: task
-- ------------------------------------------------------
-- Server version	10.6.16-MariaDB-0ubuntu0.22.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `application_status_history`
--

DROP TABLE IF EXISTS `application_status_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `application_status_history` (
                                              `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
                                              `application_id` bigint(20) unsigned NOT NULL,
                                              `status` enum('NEW','PROCESSING','APPROVED','DECLINED','COMPLETED','CANCELED') NOT NULL,
                                              `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
                                              `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
                                              PRIMARY KEY (`id`),
                                              KEY `application_status_history_applications_id_fk` (`application_id`),
                                              CONSTRAINT `application_status_history_applications_id_fk` FOREIGN KEY (`application_id`) REFERENCES `applications` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `applications`
--

DROP TABLE IF EXISTS `applications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `applications` (
                                `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
                                `customer_id` bigint(20) unsigned DEFAULT NULL,
                                `broker_id` int(10) unsigned DEFAULT NULL,
                                `product_id` int(10) unsigned DEFAULT NULL,
                                `loan_amount` decimal(10,2) NOT NULL,
                                `status` enum('NEW','PROCESSING','APPROVED','DECLINED','COMPLETED','CANCELLED') NOT NULL DEFAULT 'NEW',
                                `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
                                `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
                                PRIMARY KEY (`id`),
                                KEY `applications_customers_id_fk` (`customer_id`),
                                KEY `applications_brokers_id_fk` (`broker_id`),
                                KEY `applications_products_id_fk` (`product_id`),
                                CONSTRAINT `applications_brokers_id_fk` FOREIGN KEY (`broker_id`) REFERENCES `brokers` (`id`) ON DELETE SET NULL,
                                CONSTRAINT `applications_customers_id_fk` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`) ON DELETE SET NULL,
                                CONSTRAINT `applications_products_id_fk` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `broker_address`
--

DROP TABLE IF EXISTS `broker_address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `broker_address` (
                                  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
                                  `broker_id` int(10) unsigned NOT NULL,
                                  `address_line_1` varchar(150) NOT NULL,
                                  `address_line_2` varchar(100) DEFAULT NULL,
                                  `city` varchar(100) NOT NULL,
                                  `region` varchar(50) DEFAULT NULL,
                                  `country_code_alpha2` varchar(2) NOT NULL,
                                  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
                                  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
                                  `postcode` smallint(5) unsigned NOT NULL,
                                  PRIMARY KEY (`id`),
                                  KEY `broker_address_brokers_id_fk` (`broker_id`),
                                  CONSTRAINT `broker_address_brokers_id_fk` FOREIGN KEY (`broker_id`) REFERENCES `brokers` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `brokers`
--

DROP TABLE IF EXISTS `brokers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `brokers` (
                           `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
                           `name` varchar(255) NOT NULL,
                           `email` varchar(320) NOT NULL,
                           `type` enum('A','B','C','D') NOT NULL,
                           `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
                           `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
                           PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `customer_address_history`
--

DROP TABLE IF EXISTS `customer_address_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `customer_address_history` (
                                            `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
                                            `customer_id` bigint(20) unsigned NOT NULL,
                                            `status` enum('ACTIVE','DISABLED') NOT NULL DEFAULT 'ACTIVE',
                                            `address_line_1` varchar(150) NOT NULL,
                                            `address_line_2` varchar(100) DEFAULT NULL,
                                            `city` varchar(100) NOT NULL,
                                            `region` varchar(50) DEFAULT NULL,
                                            `country_code_alpha2` varchar(2) NOT NULL,
                                            `postcode` smallint(5) unsigned NOT NULL,
                                            `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
                                            `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
                                            PRIMARY KEY (`id`),
                                            KEY `customer_address_history_customers_id_fk` (`customer_id`),
                                            CONSTRAINT `customer_address_history_customers_id_fk` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `customers`
--

DROP TABLE IF EXISTS `customers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `customers` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `first_name` varchar(100) NOT NULL,
  `last_name` varchar(100) NOT NULL,
  `middle_name` varchar(100) DEFAULT '',
  `email` varchar(320) NOT NULL,
  `date_of_birth` date NOT NULL,
  `current_address_id` bigint(20) unsigned DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=391 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `products` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `interest_rate` decimal(5,2) NOT NULL,
  `term` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;


/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

