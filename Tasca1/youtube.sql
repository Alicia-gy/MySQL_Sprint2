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
-- Table `mydb`.`usuari`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`usuari` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(45) NULL,
  `password` VARCHAR(45) NULL,
  `nom` VARCHAR(45) NULL,
  `data_naixement` DATE NULL,
  `sexe` TINYINT(1) NULL COMMENT '1 = home\n2 = dona\n3 = altre',
  `pais` VARCHAR(45) NULL,
  `codi_postal` INT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`video`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`video` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `usuari` INT NULL,
  `titol` VARCHAR(45) NULL,
  `descripcio` VARCHAR(255) NULL,
  `grandaria` FLOAT NULL,
  `nom_arxiu` VARCHAR(45) NULL,
  `thumbnail` BLOB NULL,
  `reproduccions` INT NULL,
  `likes` INT NULL,
  `dislikes` INT NULL,
  `estat` TINYINT(1) NULL COMMENT '1 = public\n2 = ocult\n3 = privat',
  `data_creacio` DATETIME NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_video_usuari_idx` (`usuari` ASC) VISIBLE,
  CONSTRAINT `fk_video_usuari`
    FOREIGN KEY (`usuari`)
    REFERENCES `mydb`.`usuari` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`video_etiquetes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`video_etiquetes` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(45) NULL,
  `video` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_video_etiquetes_video1_idx` (`video` ASC) VISIBLE,
  CONSTRAINT `fk_video_etiquetes_video1`
    FOREIGN KEY (`video`)
    REFERENCES `mydb`.`video` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`canal`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`canal` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(45) NULL,
  `descripcio` VARCHAR(255) NULL,
  `data_creacio` DATETIME NULL,
  `usuari` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_canal_usuari1_idx` (`usuari` ASC) VISIBLE,
  CONSTRAINT `fk_canal_usuari1`
    FOREIGN KEY (`usuari`)
    REFERENCES `mydb`.`usuari` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`canal_subscripcio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`canal_subscripcio` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `usuari` INT NULL,
  `canal` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_canal_subscripcio_canal1_idx` (`canal` ASC) VISIBLE,
  INDEX `fk_canal_subscripcio_usuari1_idx` (`usuari` ASC) VISIBLE,
  CONSTRAINT `fk_canal_subscripcio_canal1`
    FOREIGN KEY (`canal`)
    REFERENCES `mydb`.`canal` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_canal_subscripcio_usuari1`
    FOREIGN KEY (`usuari`)
    REFERENCES `mydb`.`usuari` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`video_like`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`video_like` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `video` INT NULL,
  `usuari` INT NULL,
  `like_dislike` TINYINT(1) NULL COMMENT '1 = like\n2 = dislike',
  `data` DATETIME NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_video_like_video1_idx` (`video` ASC) VISIBLE,
  INDEX `fk_video_like_usuari1_idx` (`usuari` ASC) VISIBLE,
  CONSTRAINT `fk_video_like_video1`
    FOREIGN KEY (`video`)
    REFERENCES `mydb`.`video` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_video_like_usuari1`
    FOREIGN KEY (`usuari`)
    REFERENCES `mydb`.`usuari` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`usuari_playlist`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`usuari_playlist` (
  `id` INT NOT NULL,
  `usuari` INT NULL,
  `nom` VARCHAR(45) NULL,
  `estat` TINYINT(1) NULL COMMENT '1 = public\n2 = privat',
  `data_creacio` DATETIME NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_usuari_playlist_usuari1_idx` (`usuari` ASC) VISIBLE,
  CONSTRAINT `fk_usuari_playlist_usuari1`
    FOREIGN KEY (`usuari`)
    REFERENCES `mydb`.`usuari` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`playlist_entrada`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`playlist_entrada` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `playlist` INT NULL,
  `video` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_playlist_entrada_usuari_playlist1_idx` (`playlist` ASC) VISIBLE,
  INDEX `fk_playlist_entrada_video1_idx` (`video` ASC) VISIBLE,
  CONSTRAINT `fk_playlist_entrada_usuari_playlist1`
    FOREIGN KEY (`playlist`)
    REFERENCES `mydb`.`usuari_playlist` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_playlist_entrada_video1`
    FOREIGN KEY (`video`)
    REFERENCES `mydb`.`video` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`video_comentaris`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`video_comentaris` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `video` INT NULL,
  `usuari` INT NULL,
  `text` VARCHAR(1000) NULL,
  `data` DATETIME NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_video_comentari_video1_idx` (`video` ASC) VISIBLE,
  INDEX `fk_video_comentari_usuari1_idx` (`usuari` ASC) VISIBLE,
  CONSTRAINT `fk_video_comentari_video1`
    FOREIGN KEY (`video`)
    REFERENCES `mydb`.`video` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_video_comentari_usuari1`
    FOREIGN KEY (`usuari`)
    REFERENCES `mydb`.`usuari` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`comentari_like`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`comentari_like` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `comentari` INT NULL,
  `usuari` INT NULL,
  `like_dislike` TINYINT(1) NULL COMMENT '1 = like\n2 = dislike',
  `data` DATETIME NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_comentari_like_video_comentaris1_idx` (`comentari` ASC) VISIBLE,
  INDEX `fk_comentari_like_usuari1_idx` (`usuari` ASC) VISIBLE,
  CONSTRAINT `fk_comentari_like_video_comentaris1`
    FOREIGN KEY (`comentari`)
    REFERENCES `mydb`.`video_comentaris` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_comentari_like_usuari1`
    FOREIGN KEY (`usuari`)
    REFERENCES `mydb`.`usuari` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
