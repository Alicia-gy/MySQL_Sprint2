-- MySQL Script generated by MySQL Workbench
-- Wed Nov  1 14:16:18 2023
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`tipus_montura`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`tipus_montura` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `tipus` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`color_vidre`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`color_vidre` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `color` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`color_montura`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`color_montura` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `color` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`proveidors`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`proveidors` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(45) NULL,
  `adreca` VARCHAR(255) NULL,
  `telefon` VARCHAR(15) NULL,
  `fax` VARCHAR(15) NULL,
  `nif` VARCHAR(9) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`marques`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`marques` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `proveidor` INT NULL,
  `marca` VARCHAR(45) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_marques_proveidors1_idx` (`proveidor` ASC) VISIBLE,
  CONSTRAINT `fk_marques_proveidors1`
    FOREIGN KEY (`proveidor`)
    REFERENCES `mydb`.`proveidors` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`ulleres`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`ulleres` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `marca` INT NULL,
  `graduacio` VARCHAR(45) NULL COMMENT 'varchar en vez de float porque hay algunas graduaciones como astigmatismo que no son numericas',
  `tipus_montura` INT NULL,
  `color_montura` INT NULL,
  `color_vidre_dret` INT NULL,
  `color_vidre_esquerra` INT NULL,
  `preu` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_ulleres_tipus_montura_idx` (`tipus_montura` ASC) VISIBLE,
  INDEX `fk_ulleres_color_vidre1_idx` (`color_vidre_dret` ASC) INVISIBLE,
  INDEX `fk_ulleres_color_montura1_idx` (`color_montura` ASC) VISIBLE,
  INDEX `fk_ulleres_marques1_idx` (`marca` ASC) VISIBLE,
  INDEX `fk_ulleres_color_vidre1_idx1` (`color_vidre_esquerra` ASC) VISIBLE,
  CONSTRAINT `fk_ulleres_tipus_montura`
    FOREIGN KEY (`tipus_montura`)
    REFERENCES `mydb`.`tipus_montura` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ulleres_color_vidre_dret`
    FOREIGN KEY (`color_vidre_dret`)
    REFERENCES `mydb`.`color_vidre` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ulleres_color_montura1`
    FOREIGN KEY (`color_montura`)
    REFERENCES `mydb`.`color_montura` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ulleres_marques1`
    FOREIGN KEY (`marca`)
    REFERENCES `mydb`.`marques` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ulleres_color_vidre_esquerra`
    FOREIGN KEY (`color_vidre_esquerra`)
    REFERENCES `mydb`.`color_vidre` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`clients`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`clients` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(45) NULL,
  `adreca_postal` VARCHAR(255) NULL,
  `telefon` VARCHAR(15) NULL,
  `correu_electronic` VARCHAR(45) NULL,
  `data_registre` DATE NULL,
  `recomannacio` INT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`empleats`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`empleats` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`venta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`venta` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `client` INT NULL,
  `empleat` INT NULL,
  `ullera` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_venta_clients1_idx` (`client` ASC) VISIBLE,
  INDEX `fk_venta_empleats1_idx` (`empleat` ASC) VISIBLE,
  INDEX `fk_venta_ulleres1_idx` (`ullera` ASC) VISIBLE,
  CONSTRAINT `fk_venta_clients1`
    FOREIGN KEY (`client`)
    REFERENCES `mydb`.`clients` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_venta_empleats1`
    FOREIGN KEY (`empleat`)
    REFERENCES `mydb`.`empleats` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_venta_ulleres1`
    FOREIGN KEY (`ullera`)
    REFERENCES `mydb`.`ulleres` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;