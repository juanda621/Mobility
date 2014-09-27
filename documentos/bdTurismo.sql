SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';


-- -----------------------------------------------------
-- Table `empresas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `empresas` (
  `id_empresa` INT NOT NULL,
  `nombre` VARCHAR(100) NULL,
  `telefono` INT(10) NULL,
  `direccion` VARCHAR(100) NULL,
  `latitud` VARCHAR(30) NULL,
  `longitud` VARCHAR(30) NULL,
  `correo` VARCHAR(45) NULL,
  PRIMARY KEY (`id_empresa`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `lugar_evento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lugar_evento` (
  `id_lugar` INT NOT NULL,
  `nombre` VARCHAR(45) NULL,
  `direccion` VARCHAR(45) NULL,
  `latitud` VARCHAR(45) NULL,
  `longitud` VARCHAR(45) NULL,
  `telefono` VARCHAR(45) NULL,
  PRIMARY KEY (`id_lugar`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `evento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `evento` (
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
    REFERENCES `lugar_evento` (`id_lugar`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_evento_empresas1`
    FOREIGN KEY (`id_empresa`)
    REFERENCES `empresas` (`id_empresa`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `publicidad`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `publicidad` (
  `id_publicidad` INT NOT NULL,
  `titulo` VARCHAR(45) NULL,
  `descripcion` VARCHAR(45) NULL,
  `imagen` VARCHAR(45) NULL,
  `codigo_qr` VARCHAR(45) NULL,
  `estado` VARCHAR(45) NULL,
  `id_empresa` INT NOT NULL,
  `id_evento` INT NOT NULL,
  INDEX `fk_publicidad_empresas1_idx` (`id_empresa` ASC),
  INDEX `fk_publicidad_evento1_idx` (`id_evento` ASC),
  PRIMARY KEY (`id_publicidad`),
  CONSTRAINT `fk_publicidad_empresas1`
    FOREIGN KEY (`id_empresa`)
    REFERENCES `empresas` (`id_empresa`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_publicidad_evento1`
    FOREIGN KEY (`id_evento`)
    REFERENCES `evento` (`id_evento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tipo_publicidad`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tipo_publicidad` (
  `id_tipo` INT NOT NULL,
  `nombre` VARCHAR(45) NULL,
  `descripcion` VARCHAR(45) NULL,
  PRIMARY KEY (`id_tipo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tipopublicidad_publicidad`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tipopublicidad_publicidad` (
  `id` INT NOT NULL,
  `id_tipo_publicidad` INT NOT NULL,
  `id_publicidad` INT NOT NULL,
  INDEX `fk_tipopublicidad_publicidad_tipo_publicidad_idx` (`id_tipo_publicidad` ASC),
  INDEX `fk_tipopublicidad_publicidad_publicidad1_idx` (`id_publicidad` ASC),
  UNIQUE INDEX `Id_TipoPublicidad_UNIQUE` (`id_tipo_publicidad` ASC),
  CONSTRAINT `fk_tipopublicidad_publicidad_tipo_publicidad`
    FOREIGN KEY (`id_tipo_publicidad`)
    REFERENCES `tipo_publicidad` (`id_tipo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tipopublicidad_publicidad_publicidad1`
    FOREIGN KEY (`id_publicidad`)
    REFERENCES `publicidad` (`id_publicidad`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `categoria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `categoria` (
  `id_categoria` INT NOT NULL,
  `nombre` VARCHAR(45) NULL,
  `descripcion` VARCHAR(45) NULL,
  PRIMARY KEY (`id_categoria`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `categoria_publicidad`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `categoria_publicidad` (
  `id` INT NOT NULL,
  `id_categoria` INT NOT NULL,
  `id_publicidad` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_categoria_publicidad_categoria1_idx` (`id_categoria` ASC),
  INDEX `fk_categoria_publicidad_publicidad1_idx` (`id_publicidad` ASC),
  CONSTRAINT `fk_categoria_publicidad_categoria1`
    FOREIGN KEY (`id_categoria`)
    REFERENCES `categoria` (`id_categoria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_categoria_publicidad_publicidad1`
    FOREIGN KEY (`id_publicidad`)
    REFERENCES `publicidad` (`id_publicidad`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
