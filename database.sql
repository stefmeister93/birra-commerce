-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema birra_commerce
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema birra_commerce
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `birra_commerce` DEFAULT CHARACTER SET utf8 ;
USE `birra_commerce` ;

-- -----------------------------------------------------
-- Table `birra_commerce`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `birra_commerce`.`user` (
  `username` VARCHAR(16) NOT NULL,
  `email` VARCHAR(255) NULL,
  `password` VARCHAR(32) NOT NULL,
  `create_time` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `iduser` INT NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`iduser`));


-- -----------------------------------------------------
-- Table `birra_commerce`.`birra`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `birra_commerce`.`birra` (
  `idbirra` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(255) NOT NULL,
  `colore` VARCHAR(64) NOT NULL,
  `marchio` VARCHAR(128) NOT NULL,
  `tipo` VARCHAR(96) NULL,
  `stato_provenienza` VARCHAR(128) NOT NULL,
  PRIMARY KEY (`idbirra`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `birra_commerce`.`item`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `birra_commerce`.`item` (
  `iditem` INT NOT NULL AUTO_INCREMENT,
  `quantita_item` INT NOT NULL DEFAULT 0,
  `nome` VARCHAR(45) NOT NULL,
  `birra` INT NOT NULL,
  PRIMARY KEY (`iditem`, `birra`),
  INDEX `fk_item_birra1_idx` (`birra` ASC) VISIBLE,
  CONSTRAINT `fk_item_birra1`
    FOREIGN KEY (`birra`)
    REFERENCES `birra_commerce`.`birra` (`idbirra`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `birra_commerce`.`carrello`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `birra_commerce`.`carrello` (
  `idcarrello` INT NOT NULL,
  `utente` INT NOT NULL,
  `stato` VARCHAR(96) NOT NULL,
  PRIMARY KEY (`idcarrello`, `utente`),
  INDEX `fk_carrello_user1_idx` (`utente` ASC) VISIBLE,
  CONSTRAINT `fk_carrello_user1`
    FOREIGN KEY (`utente`)
    REFERENCES `birra_commerce`.`user` (`iduser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `birra_commerce`.`ordine`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `birra_commerce`.`ordine` (
  `idordine` INT NOT NULL,
  `nome` VARCHAR(45) NOT NULL,
  `data_creazione` DATETIME NOT NULL,
  `data_consegna` DATETIME NULL,
  `stato` VARCHAR(45) NOT NULL,
  `data_spedizione` DATETIME NULL,
  `carrello` INT NOT NULL,
  `utente` INT NOT NULL,
  PRIMARY KEY (`idordine`, `carrello`, `utente`),
  INDEX `fk_ordine_carrello1_idx` (`carrello` ASC, `utente` ASC) VISIBLE,
  CONSTRAINT `fk_ordine_carrello1`
    FOREIGN KEY (`carrello` , `utente`)
    REFERENCES `birra_commerce`.`carrello` (`idcarrello` , `utente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `birra_commerce`.`indirizzo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `birra_commerce`.`indirizzo` (
  `idindirizzo` INT NOT NULL AUTO_INCREMENT,
  `comune` VARCHAR(96) NOT NULL,
  `codice_postale` VARCHAR(5) NOT NULL,
  `regione` VARCHAR(96) NOT NULL,
  `provincia` VARCHAR(96) NOT NULL,
  `indirizzo` VARCHAR(255) NOT NULL,
  `utente` INT NOT NULL,
  PRIMARY KEY (`idindirizzo`, `utente`),
  INDEX `fk_indirizzo_user_idx` (`utente` ASC) VISIBLE,
  CONSTRAINT `fk_indirizzo_user`
    FOREIGN KEY (`utente`)
    REFERENCES `birra_commerce`.`user` (`iduser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `birra_commerce`.`immagine`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `birra_commerce`.`immagine` (
  `idimmagine` INT NOT NULL AUTO_INCREMENT,
  `url` VARCHAR(1024) NOT NULL,
  `birra` INT NOT NULL,
  `immagine_vetrina` TINYINT NULL DEFAULT 0,
  PRIMARY KEY (`idimmagine`),
  INDEX `fk_immagine_birra1_idx` (`birra` ASC) VISIBLE,
  CONSTRAINT `fk_immagine_birra1`
    FOREIGN KEY (`birra`)
    REFERENCES `birra_commerce`.`birra` (`idbirra`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `birra_commerce`.`carrello_has_birra`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `birra_commerce`.`carrello_has_birra` (
  `carrello` INT NOT NULL,
  `utente` INT NOT NULL,
  `birra` INT NOT NULL,
  `quantita` INT NOT NULL,
  PRIMARY KEY (`carrello`, `utente`, `birra`),
  INDEX `fk_carrello_has_birra_birra1_idx` (`birra` ASC) VISIBLE,
  INDEX `fk_carrello_has_birra_carrello1_idx` (`carrello` ASC, `utente` ASC) VISIBLE,
  CONSTRAINT `fk_carrello_has_birra_carrello1`
    FOREIGN KEY (`carrello` , `utente`)
    REFERENCES `birra_commerce`.`carrello` (`idcarrello` , `utente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_carrello_has_birra_birra1`
    FOREIGN KEY (`birra`)
    REFERENCES `birra_commerce`.`birra` (`idbirra`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
