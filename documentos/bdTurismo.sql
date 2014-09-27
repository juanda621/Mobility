SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`empresas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`empresas` (
  `id_empresas` INT NOT NULL,
  `nombre` VARCHAR(100) NULL,
  `telefono` INT(10) NULL,
  `direccion` VARCHAR(100) NULL,
  `latitud` VARCHAR(30) NULL,
  `longitud` VARCHAR(30) NULL,
  `correo` VARCHAR(45) NULL,
  PRIMARY KEY (`id_empresas`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`lugar_evento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`lugar_evento` (
  `id_lugar` INT NOT NULL,
  `nombre` VARCHAR(45) NULL,
  `direccion` VARCHAR(45) NULL,
  `latitud` VARCHAR(45) NULL,
  `longitud` VARCHAR(45) NULL,
  `telefono` VARCHAR(45) NULL,
  PRIMARY KEY (`id_lugar`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`evento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`evento` (
  `id_evento` INT NOT NULL,
  `nombre` VARCHAR(45) NULL,
  `descripcion` VARCHAR(45) NULL,
  `fecha_inicio` TIMESTAMP NULL,
  `fecha_fin` TIMESTAMP NULL,
  `duraccion` VARCHAR(45) NULL,
  `estado` VARCHAR(45) NULL,
  `id_lugar` INT NOT NULL,
  `id_empresa` INT NOT NULL,
  PRIMARY KEY (`id_evento`),
  INDEX `fk_evento_lugar_evento1_idx` (`id_lugar` ASC),
  INDEX `fk_evento_empresas1_idx` (`id_empresa` ASC),
  CONSTRAINT `fk_evento_lugar_evento1`
    FOREIGN KEY (`id_lugar`)
    REFERENCES `mydb`.`lugar_evento` (`id_lugar`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_evento_empresas1`
    FOREIGN KEY (`id_empresa`)
    REFERENCES `mydb`.`empresas` (`id_empresas`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`publicidad`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`publicidad` (
  `id_publicidad` INT NOT NULL,
  `titulo` VARCHAR(45) NULL,
  `descripcion` VARCHAR(45) NULL,
  `imagen` VARCHAR(45) NULL,
  `codigo_qr` VARCHAR(45) NULL,
  `estado` VARCHAR(45) NULL,
  `id_empresa` VARCHAR(45) NULL,
  `id_evento` VARCHAR(45) NULL,
  `id_empresa` INT NOT NULL,
  `id_evento` INT NOT NULL,
  PRIMARY KEY (`id_publicidad`),
  INDEX `fk_publicidad_empresas1_idx` (`id_empresa` ASC),
  INDEX `fk_publicidad_evento1_idx` (`id_evento` ASC),
  CONSTRAINT `fk_publicidad_empresas1`
    FOREIGN KEY (`id_empresa`)
    REFERENCES `mydb`.`empresas` (`id_empresas`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_publicidad_evento1`
    FOREIGN KEY (`id_evento`)
    REFERENCES `mydb`.`evento` (`id_evento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`tipo_publicidad`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`tipo_publicidad` (
  `id_tipo` INT NOT NULL,
  `nombre` VARCHAR(45) NULL,
  `descripcion` VARCHAR(45) NULL,
  PRIMARY KEY (`id_tipo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`tipopublicidad_publicidad`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`tipopublicidad_publicidad` (
  `id` INT NOT NULL,
  `Id_TipoPublicidad` INT NOT NULL,
  `Id_Publicidad` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_tipopublicidad_publicidad_tipo_publicidad_idx` (`Id_TipoPublicidad` ASC),
  INDEX `fk_tipopublicidad_publicidad_publicidad1_idx` (`Id_Publicidad` ASC),
  UNIQUE INDEX `Id_TipoPublicidad_UNIQUE` (`Id_TipoPublicidad` ASC),
  CONSTRAINT `fk_tipopublicidad_publicidad_tipo_publicidad`
    FOREIGN KEY (`Id_TipoPublicidad`)
    REFERENCES `mydb`.`tipo_publicidad` (`id_tipo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tipopublicidad_publicidad_publicidad1`
    FOREIGN KEY (`Id_Publicidad`)
    REFERENCES `mydb`.`publicidad` (`id_publicidad`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`categoria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`categoria` (
  `id_categoria` INT NOT NULL,
  `nombre` VARCHAR(45) NULL,
  `descripcion` VARCHAR(45) NULL,
  PRIMARY KEY (`id_categoria`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`categoria_publicidad`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`categoria_publicidad` (
  `id` INT NOT NULL,
  `id_categoria` INT NOT NULL,
  `id_publicidad` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_categoria_publicidad_categoria1_idx` (`id_categoria` ASC),
  INDEX `fk_categoria_publicidad_publicidad1_idx` (`id_publicidad` ASC),
  CONSTRAINT `fk_categoria_publicidad_categoria1`
    FOREIGN KEY (`id_categoria`)
    REFERENCES `mydb`.`categoria` (`id_categoria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_categoria_publicidad_publicidad1`
    FOREIGN KEY (`id_publicidad`)
    REFERENCES `mydb`.`publicidad` (`id_publicidad`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
