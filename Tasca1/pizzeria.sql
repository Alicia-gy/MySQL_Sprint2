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
-- Table `mydb`.`provincia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`provincia` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`localitat`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`localitat` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(45) NULL,
  `provincia` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_localitat_provincia_idx` (`provincia` ASC) VISIBLE,
  CONSTRAINT `fk_localitat_provincia`
    FOREIGN KEY (`provincia`)
    REFERENCES `mydb`.`provincia` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`client`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`client` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(45) NULL,
  `cognom` VARCHAR(45) NULL,
  `adreça` VARCHAR(255) NULL,
  `codi_postal` INT NULL,
  `localitat` INT NULL,
  `telefon` VARCHAR(15) NULL,
  `clientcol` VARCHAR(45) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_client_localitat1_idx` (`localitat` ASC) VISIBLE,
  CONSTRAINT `fk_client_localitat1`
    FOREIGN KEY (`localitat`)
    REFERENCES `mydb`.`localitat` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`botiga`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`botiga` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `adreça` VARCHAR(255) NULL,
  `codi_postal` INT NULL,
  `localitat` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_botiga_localitat1_idx` (`localitat` ASC) VISIBLE,
  CONSTRAINT `fk_botiga_localitat1`
    FOREIGN KEY (`localitat`)
    REFERENCES `mydb`.`localitat` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`treballador`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`treballador` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(45) NULL,
  `cognom` VARCHAR(45) NULL,
  `botiga` INT NULL,
  `nif` VARCHAR(9) NULL,
  `telefon` VARCHAR(15) NULL,
  `treball` TINYINT(1) NULL COMMENT '0 = cuina\n1 = repartiment',
  PRIMARY KEY (`id`),
  INDEX `fk_treballador_botiga1_idx` (`botiga` ASC) VISIBLE,
  CONSTRAINT `fk_treballador_botiga1`
    FOREIGN KEY (`botiga`)
    REFERENCES `mydb`.`botiga` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`comanda`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`comanda` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `client` INT NULL,
  `data` DATETIME NULL,
  `repartiment` TINYINT(1) NULL COMMENT '0 = recollir en botiga\n1 = repartiment a domicili',
  `repartidor` INT NULL,
  `cuantitat_productes` VARCHAR(45) NULL,
  `preu_total` FLOAT NULL,
  `botiga` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_comanda_client1_idx` (`client` ASC) VISIBLE,
  INDEX `fk_comanda_botiga1_idx` (`botiga` ASC) VISIBLE,
  INDEX `fk_comanda_treballador1_idx` (`repartidor` ASC) VISIBLE,
  CONSTRAINT `fk_comanda_client1`
    FOREIGN KEY (`client`)
    REFERENCES `mydb`.`client` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_comanda_botiga1`
    FOREIGN KEY (`botiga`)
    REFERENCES `mydb`.`botiga` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_comanda_treballador1`
    FOREIGN KEY (`repartidor`)
    REFERENCES `mydb`.`treballador` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`producte_categoria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`producte_categoria` (
  `id` INT NOT NULL,
  `categoria` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`productes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`productes` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `categoria` INT NULL,
  `nom` VARCHAR(45) NULL,
  `descripcio` VARCHAR(255) NULL,
  `imatge` BLOB NULL,
  `preu` FLOAT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_productes_producte_categoria1_idx` (`categoria` ASC) VISIBLE,
  CONSTRAINT `fk_productes_producte_categoria1`
    FOREIGN KEY (`categoria`)
    REFERENCES `mydb`.`producte_categoria` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`comanda_linea`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`comanda_linea` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `producte` INT NULL,
  `comanda` INT NULL,
  `quantitat` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_comanda_linea_productes1_idx` (`producte` ASC) VISIBLE,
  INDEX `fk_comanda_linea_comanda1_idx` (`comanda` ASC) VISIBLE,
  CONSTRAINT `fk_comanda_linea_productes1`
    FOREIGN KEY (`producte`)
    REFERENCES `mydb`.`productes` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_comanda_linea_comanda1`
    FOREIGN KEY (`comanda`)
    REFERENCES `mydb`.`comanda` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
