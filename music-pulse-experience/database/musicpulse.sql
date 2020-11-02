SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

CREATE SCHEMA IF NOT EXISTS `MusicPulseExperience` DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci ;
USE `MusicPulseExperience` ;

CREATE TABLE IF NOT EXISTS `MusicPulseExperience`.`users` (
  `userId` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(60) NOT NULL,
  `email` VARCHAR(100) NOT NULL,
  `password` VARCHAR(60) NOT NULL,
  `dateofbirth` DATE NULL,
  `height` FLOAT NULL,
  `weight` FLOAT NULL,
  `sex` VARCHAR(10) NULL,
  `way` VARCHAR(10) NULL,
  PRIMARY KEY (`userId`),
  UNIQUE INDEX `userId_UNIQUE` (`userId` ASC),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC))
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `MusicPulseExperience`.`beat` (
  `beatId` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `beatperminute` INT NOT NULL,
  `users` INT UNSIGNED NOT NULL,
  `dateregister` DATETIME NOT NULL,
  PRIMARY KEY (`beatId`),
  UNIQUE INDEX `beatId_UNIQUE` (`beatId` ASC),
  INDEX `userbeat_idx` (`users` ASC),
  CONSTRAINT `userbeat`
    FOREIGN KEY (`users`)
    REFERENCES `MusicPulseExperience`.`users` (`userId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `MusicPulseExperience`.`music` (
  `musicId` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  `artist` VARCHAR(100) NOT NULL,
  `duration` INT NOT NULL,
  `image` VARCHAR(100) NOT NULL,
  `creationdate` DATE NOT NULL,
  `link` VARCHAR(100) NOT NULL,
  `channel` VARCHAR(100) NOT NULL,
  `way` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`musicId`),
  UNIQUE INDEX `musicId_UNIQUE` (`musicId` ASC))
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `MusicPulseExperience`.`image` (
  `imageId` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `image` VARCHAR(100) NOT NULL,
  `music` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`imageId`),
  UNIQUE INDEX `imageId_UNIQUE` (`imageId` ASC),
  INDEX `musicimage_idx` (`music` ASC),
  CONSTRAINT `musicimage`
    FOREIGN KEY (`music`)
    REFERENCES `MusicPulseExperience`.`music` (`musicId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `MusicPulseExperience`.`suggestion` (
  `suggestionId` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `image` INT UNSIGNED NOT NULL,
  `beat` INT UNSIGNED NOT NULL,
  `liked` TINYINT(1) NOT NULL,
  `dateregister` DATETIME NOT NULL,
  PRIMARY KEY (`suggestionId`),
  UNIQUE INDEX `suggestionId_UNIQUE` (`suggestionId` ASC),
  INDEX `suggestionimage_idx` (`image` ASC),
  INDEX `beatsuggestion_idx` (`beat` ASC),
  CONSTRAINT `suggestionimage`
    FOREIGN KEY (`image`)
    REFERENCES `MusicPulseExperience`.`image` (`imageId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `beatsuggestion`
    FOREIGN KEY (`beat`)
    REFERENCES `MusicPulseExperience`.`beat` (`beatId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
