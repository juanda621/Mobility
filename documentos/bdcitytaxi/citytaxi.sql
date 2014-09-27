SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

CREATE SCHEMA IF NOT EXISTS `citytaxi` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `citytaxi` ;

-- -----------------------------------------------------
-- Table `citytaxi`.`drivers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `citytaxi`.`drivers` (
  `id` VARCHAR(10) NOT NULL,
  `name` VARCHAR(50) NOT NULL,
  `lastname` VARCHAR(50) NOT NULL,
  `rh` VARCHAR(5) NOT NULL,
  `active` TINYINT(1) NOT NULL DEFAULT 0,
  `password` VARCHAR(45) NOT NULL,
  `phone` VARCHAR(45) NOT NULL,
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL,
  `deleted_at` TIMESTAMP NULL,
  `photo` TINYINT(1) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `citytaxi`.`countries`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `citytaxi`.`countries` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
PACK_KEYS = Default;


-- -----------------------------------------------------
-- Table `citytaxi`.`domains`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `citytaxi`.`domains` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `max_latitude` DOUBLE NOT NULL,
  `max_longitude` DOUBLE NOT NULL,
  `min_latitude` DOUBLE NOT NULL,
  `min_longitude` DOUBLE NOT NULL,
  `active` TINYINT(1) NOT NULL DEFAULT 1,
  `country_id` INT NOT NULL,
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_domain_country1_idx` (`country_id` ASC),
  CONSTRAINT `fk_domain_country1`
    FOREIGN KEY (`country_id`)
    REFERENCES `citytaxi`.`countries` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `citytaxi`.`companies`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `citytaxi`.`companies` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  `domain_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_empresa_rodamiento_dominio1_idx` (`domain_id` ASC),
  CONSTRAINT `fk_empresa_rodamiento_dominio1`
    FOREIGN KEY (`domain_id`)
    REFERENCES `citytaxi`.`domains` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `citytaxi`.`makes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `citytaxi`.`makes` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `citytaxi`.`references`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `citytaxi`.`references` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `make_id` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `trunk` TINYINT(1) NOT NULL,
  INDEX `fk_referencia_marca1_idx` (`make_id` ASC),
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_referencia_marca1`
    FOREIGN KEY (`make_id`)
    REFERENCES `citytaxi`.`makes` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `citytaxi`.`taxis`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `citytaxi`.`taxis` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `company_id` INT NOT NULL,
  `reference_id` INT NOT NULL,
  `placa` VARCHAR(45) NOT NULL,
  `active` TINYINT(1) NOT NULL,
  `passengers` INT NOT NULL,
  `model` INT NOT NULL,
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL,
  `deleted_at` TIMESTAMP NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_taxi_empresa_rodamiento1_idx` (`company_id` ASC),
  INDEX `fk_taxi_referencia1_idx` (`reference_id` ASC),
  CONSTRAINT `fk_taxi_empresa_rodamiento1`
    FOREIGN KEY (`company_id`)
    REFERENCES `citytaxi`.`companies` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_taxi_referencia1`
    FOREIGN KEY (`reference_id`)
    REFERENCES `citytaxi`.`references` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
PACK_KEYS = Default;


-- -----------------------------------------------------
-- Table `citytaxi`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `citytaxi`.`users` (
  `email` VARCHAR(45) NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `phone` VARCHAR(15) NOT NULL,
  `password` VARCHAR(100) NOT NULL,
  `password2` VARCHAR(45) NULL,
  `news` TINYINT(1) NOT NULL DEFAULT 1,
  `emails` TINYINT(1) NOT NULL DEFAULT 1,
  `verified` TINYINT(1) NOT NULL DEFAULT 0,
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL,
  PRIMARY KEY (`email`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `citytaxi`.`requests`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `citytaxi`.`requests` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `type` VARCHAR(45) NULL,
  `so` VARCHAR(45) NULL,
  `push` VARCHAR(300) NULL,
  `appversion` VARCHAR(45) NULL,
  `user_email` VARCHAR(45) NOT NULL,
  `lang` VARCHAR(4) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Requests_users1_idx` (`user_email` ASC),
  CONSTRAINT `fk_Requests_users1`
    FOREIGN KEY (`user_email`)
    REFERENCES `citytaxi`.`users` (`email`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `citytaxi`.`services`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `citytaxi`.`services` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `domain_id` INT NOT NULL,
  `address` VARCHAR(100) NOT NULL,
  `hint` VARCHAR(50) NULL,
  `city` VARCHAR(45) NOT NULL,
  `latitude` DOUBLE NOT NULL,
  `longitude` DOUBLE NOT NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL,
  `request_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Servicio_Dominios_idx` (`domain_id` ASC),
  INDEX `fk_services_Requests1_idx` (`request_id` ASC),
  CONSTRAINT `fk_Servicio_Dominios`
    FOREIGN KEY (`domain_id`)
    REFERENCES `citytaxi`.`domains` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_services_Requests1`
    FOREIGN KEY (`request_id`)
    REFERENCES `citytaxi`.`requests` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `citytaxi`.`states`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `citytaxi`.`states` (
  `service_id` INT NOT NULL,
  `date` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `state` INT NULL,
  `substate` INT NULL,
  `description` TEXT NULL,
  INDEX `fk_Estado_Servicio1_idx` (`service_id` ASC),
  CONSTRAINT `fk_Estado_Servicio1`
    FOREIGN KEY (`service_id`)
    REFERENCES `citytaxi`.`services` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `citytaxi`.`disabled_users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `citytaxi`.`disabled_users` (
  `user_email` VARCHAR(45) NOT NULL,
  `reason` TEXT NOT NULL,
  `date` TIMESTAMP NOT NULL,
  `deleted_at` TIMESTAMP NULL,
  INDEX `fk_usuario_inactivo_usuario1_idx` (`user_email` ASC),
  CONSTRAINT `fk_usuario_inactivo_usuario`
    FOREIGN KEY (`user_email`)
    REFERENCES `citytaxi`.`users` (`email`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `citytaxi`.`taxi_document`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `citytaxi`.`taxi_document` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `taxi_id` INT NOT NULL,
  `type` VARCHAR(45) NULL,
  `number` VARCHAR(45) NULL,
  `expiration` TIMESTAMP NULL,
  `comments` TEXT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_documentos_taxi1_idx` (`taxi_id` ASC),
  CONSTRAINT `fk_documentos_taxi1`
    FOREIGN KEY (`taxi_id`)
    REFERENCES `citytaxi`.`taxis` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `citytaxi`.`admins`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `citytaxi`.`admins` (
  `id` INT NOT NULL,
  `password` VARCHAR(300) NOT NULL,
  `name` VARCHAR(45) NULL,
  `last_name` VARCHAR(45) NULL,
  `email` VARCHAR(45) NULL,
  `active` TINYINT(1) NULL DEFAULT 0,
  `remember_token` VARCHAR(100) NULL,
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `citytaxi`.`user_codes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `citytaxi`.`user_codes` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `user_email` VARCHAR(45) NOT NULL,
  `code` VARCHAR(10) NULL,
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NULL,
  `expiration` INT NULL DEFAULT 8,
  `type` INT NULL DEFAULT 1,
  INDEX `fk_user_code_user1_idx` (`user_email` ASC),
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_user_code_user1`
    FOREIGN KEY (`user_email`)
    REFERENCES `citytaxi`.`users` (`email`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `citytaxi`.`devices`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `citytaxi`.`devices` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `taxi_id` INT NOT NULL,
  `driver_id` VARCHAR(10) NOT NULL,
  `device_id` VARCHAR(45) NULL,
  `push` VARCHAR(300) NULL,
  `so` VARCHAR(45) NULL,
  `make` VARCHAR(45) NULL,
  `reference` VARCHAR(45) NULL,
  `description` TEXT NULL,
  `used` TINYINT(1) NOT NULL DEFAULT 0,
  `active` TINYINT(1) NOT NULL DEFAULT 0,
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL,
  `deleted_at` TIMESTAMP NULL,
  `code` INT NULL,
  INDEX `fk_device_taxi1_idx` (`taxi_id` ASC),
  INDEX `fk_device_driver1_idx` (`driver_id` ASC),
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_device_taxi1`
    FOREIGN KEY (`taxi_id`)
    REFERENCES `citytaxi`.`taxis` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_device_driver1`
    FOREIGN KEY (`driver_id`)
    REFERENCES `citytaxi`.`drivers` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `citytaxi`.`locations`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `citytaxi`.`locations` (
  `device_id` INT NOT NULL,
  `latitude` DOUBLE NOT NULL,
  `longitude` DOUBLE NOT NULL,
  `state` VARCHAR(45) NOT NULL,
  `date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `speed` INT NULL,
  `accuracy` INT NULL,
  INDEX `fk_device_location_device1_idx` (`device_id` ASC),
  CONSTRAINT `fk_device_location_device1`
    FOREIGN KEY (`device_id`)
    REFERENCES `citytaxi`.`devices` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `citytaxi`.`assigned_services`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `citytaxi`.`assigned_services` (
  `service_id` INT NOT NULL,
  `device_id` INT NOT NULL,
  `device_latitude` DOUBLE NOT NULL,
  `device_longitude` DOUBLE NOT NULL,
  `code` VARCHAR(2) NOT NULL,
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL,
  `time` INT NULL,
  INDEX `fk_assigned_service_service1_idx` (`service_id` ASC),
  INDEX `fk_assigned_service_device1_idx` (`device_id` ASC),
  PRIMARY KEY (`service_id`),
  CONSTRAINT `fk_assigned_service_service1`
    FOREIGN KEY (`service_id`)
    REFERENCES `citytaxi`.`services` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_assigned_service_device1`
    FOREIGN KEY (`device_id`)
    REFERENCES `citytaxi`.`devices` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `citytaxi`.`friends`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `citytaxi`.`friends` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `user_email` VARCHAR(45) NOT NULL,
  `friend` VARCHAR(45) NULL,
  `name` VARCHAR(45) NULL,
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NULL,
  `deleted_at` TIMESTAMP NULL,
  INDEX `fk_users_has_users_users1_idx` (`user_email` ASC),
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_users_has_users_users1`
    FOREIGN KEY (`user_email`)
    REFERENCES `citytaxi`.`users` (`email`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `citytaxi`.`favorites`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `citytaxi`.`favorites` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `services_id` INT NOT NULL,
  `name` VARCHAR(45) NULL,
  `deleted_at` TIMESTAMP NULL,
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  INDEX `fk_favorites_services1_idx` (`services_id` ASC),
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_favorites_services1`
    FOREIGN KEY (`services_id`)
    REFERENCES `citytaxi`.`services` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `citytaxi`.`charges`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `citytaxi`.`charges` (
  `id` INT NOT NULL,
  `domains_id` INT NOT NULL,
  `name` VARCHAR(45) NULL,
  `value` FLOAT NULL,
  `deleted_at` TIMESTAMP NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_charges_domains1_idx` (`domains_id` ASC),
  CONSTRAINT `fk_charges_domains1`
    FOREIGN KEY (`domains_id`)
    REFERENCES `citytaxi`.`domains` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `citytaxi`.`settings`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `citytaxi`.`settings` (
  `domain_id` INT NOT NULL,
  `take_service_time` INT NULL,
  `minimum_cost` FLOAT NULL,
  `kilometer_cost` FLOAT NULL,
  `first_search_taxis` INT NULL,
  `first_search_time` INT NULL,
  `offert_time` INT NULL,
  `kilometer_time` INT NULL,
  `max_distance` INT NULL,
  `flag` INT NULL,
  `cost_time_stoped` INT NULL,
  INDEX `fk_settigns_domains1_idx` (`domain_id` ASC),
  PRIMARY KEY (`domain_id`),
  CONSTRAINT `fk_settigns_domains1`
    FOREIGN KEY (`domain_id`)
    REFERENCES `citytaxi`.`domains` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `citytaxi`.`logins`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `citytaxi`.`logins` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `date` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `device_id` VARCHAR(45) NULL,
  `driver_id` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_logins_drivers1_idx` (`driver_id` ASC),
  CONSTRAINT `fk_logins_drivers1`
    FOREIGN KEY (`driver_id`)
    REFERENCES `citytaxi`.`drivers` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
PACK_KEYS = Default;


-- -----------------------------------------------------
-- Table `citytaxi`.`messages`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `citytaxi`.`messages` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `service_id` INT NOT NULL,
  `message` TEXT NULL,
  `from` ENUM('user','driver') NULL,
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted_at` TIMESTAMP NULL,
  INDEX `fk_messages_assigned_services1_idx` (`service_id` ASC),
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_messages_assigned_services1`
    FOREIGN KEY (`service_id`)
    REFERENCES `citytaxi`.`assigned_services` (`service_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `citytaxi`.`history_locations`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `citytaxi`.`history_locations` (
  `device_id` INT NOT NULL,
  `latitude` DOUBLE NOT NULL,
  `longitude` DOUBLE NOT NULL,
  `state` VARCHAR(45) NOT NULL,
  `date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `speed` INT NULL,
  `accuracy` INT NULL,
  INDEX `fk_device_location_device1_idx` (`device_id` ASC),
  PRIMARY KEY (`device_id`, `date`),
  CONSTRAINT `fk_device_location_device10`
    FOREIGN KEY (`device_id`)
    REFERENCES `citytaxi`.`devices` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
