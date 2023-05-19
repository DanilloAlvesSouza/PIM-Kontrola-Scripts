-- MySQL Script generated by MySQL Workbench
-- Thu May 18 15:31:56 2023
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Kontrola
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Kontrola
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Kontrola` DEFAULT CHARACTER SET utf8 ;
USE `Kontrola` ;

-- -----------------------------------------------------
-- Table `Kontrola`.`STATUS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Kontrola`.`STATUS` (
  `idSTATUS` INT NOT NULL,
  `DESCRICAO` VARCHAR(45) NULL,
  PRIMARY KEY (`idSTATUS`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Kontrola`.`MODALIDADE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Kontrola`.`MODALIDADE` (
  `idMODALIDADE` INT NOT NULL,
  `DESCRICAO` VARCHAR(45) NULL,
  PRIMARY KEY (`idMODALIDADE`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Kontrola`.`GRAVIDADE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Kontrola`.`GRAVIDADE` (
  `idGRAVIDADE` INT NOT NULL,
  `DESCRICAO` VARCHAR(45) NULL,
  PRIMARY KEY (`idGRAVIDADE`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Kontrola`.`URGENCIA`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Kontrola`.`URGENCIA` (
  `idURGENCIA` INT NOT NULL,
  `DESCRICAO` VARCHAR(45) NULL,
  PRIMARY KEY (`idURGENCIA`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Kontrola`.`TENDENCIA`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Kontrola`.`TENDENCIA` (
  `idTENDENCIA` INT NOT NULL,
  `DESCRICAO` VARCHAR(45) NULL,
  PRIMARY KEY (`idTENDENCIA`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Kontrola`.`CHAMADO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Kontrola`.`CHAMADO` (
  `idCHAMADO` INT NOT NULL,
  `DATA_INICIO` DATETIME(6) NOT NULL,
  `DATA_FECHAMENTO` DATETIME(6) NULL,
  `DESCRICAO` VARCHAR(45) NULL,
  `DIAGNOSTICO` VARCHAR(100) NULL,
  `STATUS_idSTATUS` INT NOT NULL,
  `MODALIDADE_idMODALIDADE` INT NOT NULL,
  `GRAVIDADE_idGRAVIDADE` INT NOT NULL,
  `URGENCIA_idURGENCIA` INT NOT NULL,
  `TENDENCIA_idTENDENCIA` INT NOT NULL,
  PRIMARY KEY (`idCHAMADO`),
  INDEX `fk_CHAMADO_STATUS_idx` (`STATUS_idSTATUS` ASC) VISIBLE,
  INDEX `fk_CHAMADO_MODALIDADE1_idx` (`MODALIDADE_idMODALIDADE` ASC) VISIBLE,
  INDEX `fk_CHAMADO_GRAVIDADE1_idx` (`GRAVIDADE_idGRAVIDADE` ASC) VISIBLE,
  INDEX `fk_CHAMADO_URGENCIA1_idx` (`URGENCIA_idURGENCIA` ASC) VISIBLE,
  INDEX `fk_CHAMADO_TENDENCIA1_idx` (`TENDENCIA_idTENDENCIA` ASC) VISIBLE,
  CONSTRAINT `fk_CHAMADO_STATUS`
    FOREIGN KEY (`STATUS_idSTATUS`)
    REFERENCES `Kontrola`.`STATUS` (`idSTATUS`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_CHAMADO_MODALIDADE1`
    FOREIGN KEY (`MODALIDADE_idMODALIDADE`)
    REFERENCES `Kontrola`.`MODALIDADE` (`idMODALIDADE`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_CHAMADO_GRAVIDADE1`
    FOREIGN KEY (`GRAVIDADE_idGRAVIDADE`)
    REFERENCES `Kontrola`.`GRAVIDADE` (`idGRAVIDADE`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_CHAMADO_URGENCIA1`
    FOREIGN KEY (`URGENCIA_idURGENCIA`)
    REFERENCES `Kontrola`.`URGENCIA` (`idURGENCIA`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_CHAMADO_TENDENCIA1`
    FOREIGN KEY (`TENDENCIA_idTENDENCIA`)
    REFERENCES `Kontrola`.`TENDENCIA` (`idTENDENCIA`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Kontrola`.`CLIENTE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Kontrola`.`CLIENTE` (
  `idCLIENTE` INT NOT NULL,
  `NOME` VARCHAR(45) NULL,
  `CNPJ` VARCHAR(45) NULL,
  PRIMARY KEY (`idCLIENTE`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Kontrola`.`FILIAL`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Kontrola`.`FILIAL` (
  `idFILIAL` INT NOT NULL,
  `DESCRICAO` VARCHAR(45) NOT NULL,
  `CLIENTE_idCLIENTE` INT NOT NULL,
  PRIMARY KEY (`idFILIAL`),
  INDEX `fk_FILIAL_CLIENTE1_idx` (`CLIENTE_idCLIENTE` ASC) VISIBLE,
  CONSTRAINT `fk_FILIAL_CLIENTE1`
    FOREIGN KEY (`CLIENTE_idCLIENTE`)
    REFERENCES `Kontrola`.`CLIENTE` (`idCLIENTE`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Kontrola`.`EQUIPAMENTO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Kontrola`.`EQUIPAMENTO` (
  `idEQUIPAMENTO` INT NOT NULL,
  `MARCA` VARCHAR(45) NOT NULL,
  `MODELO` VARCHAR(45) NULL,
  `NUMERO_SERIE` VARCHAR(45) NOT NULL,
  `POTÊNCIA` VARCHAR(45) NULL,
  `FILIAL_idFILIAL` INT NOT NULL,
  PRIMARY KEY (`idEQUIPAMENTO`),
  UNIQUE INDEX `N/S_UNIQUE` (`NUMERO_SERIE` ASC) VISIBLE,
  INDEX `fk_EQUIPAMENTO_FILIAL1_idx` (`FILIAL_idFILIAL` ASC) VISIBLE,
  CONSTRAINT `fk_EQUIPAMENTO_FILIAL1`
    FOREIGN KEY (`FILIAL_idFILIAL`)
    REFERENCES `Kontrola`.`FILIAL` (`idFILIAL`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Kontrola`.`ITEM`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Kontrola`.`ITEM` (
  `idITEM` INT NOT NULL,
  `CHAMADO_idCHAMADO` INT NOT NULL,
  `EQUIPAMENTO_idEQUIPAMENTO` INT NOT NULL,
  PRIMARY KEY (`idITEM`),
  INDEX `fk_ITEM_CHAMADO1_idx` (`CHAMADO_idCHAMADO` ASC) VISIBLE,
  INDEX `fk_ITEM_EQUIPAMENTO1_idx` (`EQUIPAMENTO_idEQUIPAMENTO` ASC) VISIBLE,
  CONSTRAINT `fk_ITEM_CHAMADO1`
    FOREIGN KEY (`CHAMADO_idCHAMADO`)
    REFERENCES `Kontrola`.`CHAMADO` (`idCHAMADO`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ITEM_EQUIPAMENTO1`
    FOREIGN KEY (`EQUIPAMENTO_idEQUIPAMENTO`)
    REFERENCES `Kontrola`.`EQUIPAMENTO` (`idEQUIPAMENTO`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Kontrola`.`ENDERECO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Kontrola`.`ENDERECO` (
  `idENDERECO` INT NOT NULL,
  `LOGRADOURO` VARCHAR(45) NOT NULL,
  `CEP` DECIMAL(8) NOT NULL,
  `BAIRRO` VARCHAR(45) NULL,
  `CIDADE` VARCHAR(30) NOT NULL,
  `UF` VARCHAR(2) NOT NULL,
  `FILIAL_idFILIAL` INT NOT NULL,
  PRIMARY KEY (`idENDERECO`),
  INDEX `fk_ENDERECO_FILIAL1_idx` (`FILIAL_idFILIAL` ASC) VISIBLE,
  CONSTRAINT `fk_ENDERECO_FILIAL1`
    FOREIGN KEY (`FILIAL_idFILIAL`)
    REFERENCES `Kontrola`.`FILIAL` (`idFILIAL`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
