-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema zomato_db
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema zomato_db
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `zomato_db` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `zomato_db` ;

-- -----------------------------------------------------
-- Table `zomato_db`.`cuisine`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `zomato_db`.`cuisine` (
  `cuisine_id` INT NOT NULL AUTO_INCREMENT,
  `cuisine_name` VARCHAR(40) NOT NULL,
  PRIMARY KEY (`cuisine_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 6
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `zomato_db`.`customer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `zomato_db`.`customer` (
  `customer_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(60) NOT NULL,
  `email` VARCHAR(80) NULL DEFAULT NULL,
  `phone` VARCHAR(15) NULL DEFAULT NULL,
  `signup_date` DATE NULL DEFAULT NULL,
  `gender` VARCHAR(10) NULL DEFAULT NULL,
  `dob` DATE NULL DEFAULT NULL,
  PRIMARY KEY (`customer_id`),
  UNIQUE INDEX `email` (`email` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 6
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `zomato_db`.`customer_address`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `zomato_db`.`customer_address` (
  `address_id` INT NOT NULL AUTO_INCREMENT,
  `customer_id` INT NULL DEFAULT NULL,
  `address_line` VARCHAR(120) NULL DEFAULT NULL,
  `city` VARCHAR(40) NULL DEFAULT NULL,
  `state` VARCHAR(40) NULL DEFAULT NULL,
  `pincode` VARCHAR(10) NULL DEFAULT NULL,
  `address_type` VARCHAR(20) NULL DEFAULT NULL,
  `added_on` DATE NULL DEFAULT NULL,
  PRIMARY KEY (`address_id`),
  INDEX `customer_id` (`customer_id` ASC) VISIBLE,
  CONSTRAINT `customer_address_ibfk_1`
    FOREIGN KEY (`customer_id`)
    REFERENCES `zomato_db`.`customer` (`customer_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 6
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `zomato_db`.`delivery_partner`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `zomato_db`.`delivery_partner` (
  `delivery_partner_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(60) NULL DEFAULT NULL,
  `phone` VARCHAR(15) NULL DEFAULT NULL,
  `vehicle_number` VARCHAR(20) NULL DEFAULT NULL,
  `rating` DECIMAL(2,1) NULL DEFAULT NULL,
  PRIMARY KEY (`delivery_partner_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 6
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `zomato_db`.`restaurant`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `zomato_db`.`restaurant` (
  `restaurant_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  `phone` VARCHAR(15) NULL DEFAULT NULL,
  `email` VARCHAR(80) NULL DEFAULT NULL,
  `avg_rating` DECIMAL(2,1) NULL DEFAULT NULL,
  `registration_date` DATE NULL DEFAULT NULL,
  `is_active` TINYINT(1) NULL DEFAULT NULL,
  PRIMARY KEY (`restaurant_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 6
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `zomato_db`.`payment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `zomato_db`.`payment` (
  `payment_id` INT NOT NULL AUTO_INCREMENT,
  `payment_method` VARCHAR(20) NULL DEFAULT NULL,
  `payment_status` VARCHAR(20) NULL DEFAULT NULL,
  `payment_time` DATETIME NULL DEFAULT NULL,
  `amount_paid` DECIMAL(10,2) NULL DEFAULT NULL,
  PRIMARY KEY (`payment_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 6
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `zomato_db`.`orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `zomato_db`.`orders` (
  `order_id` INT NOT NULL AUTO_INCREMENT,
  `customer_id` INT NULL DEFAULT NULL,
  `restaurant_id` INT NULL DEFAULT NULL,
  `order_date` DATETIME NULL DEFAULT NULL,
  `total_amount` DECIMAL(10,2) NULL DEFAULT NULL,
  `payment_id` INT NULL DEFAULT NULL,
  `delivery_partner_id` INT NULL DEFAULT NULL,
  `order_status` VARCHAR(20) NULL DEFAULT NULL,
  PRIMARY KEY (`order_id`),
  INDEX `customer_id` (`customer_id` ASC) VISIBLE,
  INDEX `restaurant_id` (`restaurant_id` ASC) VISIBLE,
  INDEX `payment_id` (`payment_id` ASC) VISIBLE,
  INDEX `delivery_partner_id` (`delivery_partner_id` ASC) VISIBLE,
  CONSTRAINT `orders_ibfk_1`
    FOREIGN KEY (`customer_id`)
    REFERENCES `zomato_db`.`customer` (`customer_id`),
  CONSTRAINT `orders_ibfk_2`
    FOREIGN KEY (`restaurant_id`)
    REFERENCES `zomato_db`.`restaurant` (`restaurant_id`),
  CONSTRAINT `orders_ibfk_3`
    FOREIGN KEY (`payment_id`)
    REFERENCES `zomato_db`.`payment` (`payment_id`),
  CONSTRAINT `orders_ibfk_4`
    FOREIGN KEY (`delivery_partner_id`)
    REFERENCES `zomato_db`.`delivery_partner` (`delivery_partner_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 6
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `zomato_db`.`delivery_status_history`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `zomato_db`.`delivery_status_history` (
  `status_id` INT NOT NULL AUTO_INCREMENT,
  `order_id` INT NULL DEFAULT NULL,
  `status` VARCHAR(30) NULL DEFAULT NULL,
  `updated_at` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`status_id`),
  INDEX `order_id` (`order_id` ASC) VISIBLE,
  CONSTRAINT `delivery_status_history_ibfk_1`
    FOREIGN KEY (`order_id`)
    REFERENCES `zomato_db`.`orders` (`order_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 6
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `zomato_db`.`menu_item`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `zomato_db`.`menu_item` (
  `item_id` INT NOT NULL AUTO_INCREMENT,
  `restaurant_id` INT NULL DEFAULT NULL,
  `item_name` VARCHAR(100) NULL DEFAULT NULL,
  `description` VARCHAR(200) NULL DEFAULT NULL,
  `price` DECIMAL(7,2) NULL DEFAULT NULL,
  `category` VARCHAR(40) NULL DEFAULT NULL,
  `veg_nonveg` VARCHAR(10) NULL DEFAULT NULL,
  `availability_status` TINYINT(1) NULL DEFAULT NULL,
  PRIMARY KEY (`item_id`),
  INDEX `restaurant_id` (`restaurant_id` ASC) VISIBLE,
  CONSTRAINT `menu_item_ibfk_1`
    FOREIGN KEY (`restaurant_id`)
    REFERENCES `zomato_db`.`restaurant` (`restaurant_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 6
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `zomato_db`.`order_item`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `zomato_db`.`order_item` (
  `order_item_id` INT NOT NULL AUTO_INCREMENT,
  `order_id` INT NULL DEFAULT NULL,
  `item_id` INT NULL DEFAULT NULL,
  `quantity` INT NULL DEFAULT NULL,
  `item_price` DECIMAL(7,2) NULL DEFAULT NULL,
  PRIMARY KEY (`order_item_id`),
  INDEX `order_id` (`order_id` ASC) VISIBLE,
  INDEX `item_id` (`item_id` ASC) VISIBLE,
  CONSTRAINT `order_item_ibfk_1`
    FOREIGN KEY (`order_id`)
    REFERENCES `zomato_db`.`orders` (`order_id`),
  CONSTRAINT `order_item_ibfk_2`
    FOREIGN KEY (`item_id`)
    REFERENCES `zomato_db`.`menu_item` (`item_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 6
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `zomato_db`.`restaurant_address`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `zomato_db`.`restaurant_address` (
  `rest_address_id` INT NOT NULL AUTO_INCREMENT,
  `restaurant_id` INT NULL DEFAULT NULL,
  `address_line` VARCHAR(120) NULL DEFAULT NULL,
  `city` VARCHAR(40) NULL DEFAULT NULL,
  `state` VARCHAR(40) NULL DEFAULT NULL,
  `pincode` VARCHAR(10) NULL DEFAULT NULL,
  `latitude` DECIMAL(10,6) NULL DEFAULT NULL,
  `longitude` DECIMAL(10,6) NULL DEFAULT NULL,
  PRIMARY KEY (`rest_address_id`),
  INDEX `restaurant_id` (`restaurant_id` ASC) VISIBLE,
  CONSTRAINT `restaurant_address_ibfk_1`
    FOREIGN KEY (`restaurant_id`)
    REFERENCES `zomato_db`.`restaurant` (`restaurant_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 6
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `zomato_db`.`restaurant_cuisine`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `zomato_db`.`restaurant_cuisine` (
  `rc_id` INT NOT NULL AUTO_INCREMENT,
  `restaurant_id` INT NULL DEFAULT NULL,
  `cuisine_id` INT NULL DEFAULT NULL,
  PRIMARY KEY (`rc_id`),
  INDEX `restaurant_id` (`restaurant_id` ASC) VISIBLE,
  INDEX `cuisine_id` (`cuisine_id` ASC) VISIBLE,
  CONSTRAINT `restaurant_cuisine_ibfk_1`
    FOREIGN KEY (`restaurant_id`)
    REFERENCES `zomato_db`.`restaurant` (`restaurant_id`),
  CONSTRAINT `restaurant_cuisine_ibfk_2`
    FOREIGN KEY (`cuisine_id`)
    REFERENCES `zomato_db`.`cuisine` (`cuisine_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 6
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `zomato_db`.`review`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `zomato_db`.`review` (
  `review_id` INT NOT NULL AUTO_INCREMENT,
  `customer_id` INT NULL DEFAULT NULL,
  `restaurant_id` INT NULL DEFAULT NULL,
  `rating` INT NULL DEFAULT NULL,
  `review_text` VARCHAR(200) NULL DEFAULT NULL,
  `review_date` DATE NULL DEFAULT NULL,
  PRIMARY KEY (`review_id`),
  INDEX `customer_id` (`customer_id` ASC) VISIBLE,
  INDEX `restaurant_id` (`restaurant_id` ASC) VISIBLE,
  CONSTRAINT `review_ibfk_1`
    FOREIGN KEY (`customer_id`)
    REFERENCES `zomato_db`.`customer` (`customer_id`),
  CONSTRAINT `review_ibfk_2`
    FOREIGN KEY (`restaurant_id`)
    REFERENCES `zomato_db`.`restaurant` (`restaurant_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 6
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
