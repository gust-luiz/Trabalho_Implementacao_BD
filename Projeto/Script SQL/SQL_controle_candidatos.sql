-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema controle_candidatos
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema controle_candidatos
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `controle_candidatos` DEFAULT CHARACTER SET utf8 ;
USE `controle_candidatos` ;

-- -----------------------------------------------------
-- Table `controle_candidatos`.`Partido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `controle_candidatos`.`Partido` (
  `idPartido` INT NOT NULL,
  `nome` TEXT NULL,
  `sede` TEXT NULL,
  `nomePresidente` TEXT NULL,
  `qtdFiliados` INT NULL,
  `dataCriacao` DATE NULL,
  PRIMARY KEY (`idPartido`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `controle_candidatos`.`Cargo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `controle_candidatos`.`Cargo` (
  `idCargo` INT NOT NULL,
  `nome` TEXT NULL,
  `salario` REAL NULL,
  `competencias` TEXT NULL,
  PRIMARY KEY (`idCargo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `controle_candidatos`.`Politico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `controle_candidatos`.`Politico` (
  `idPolitico` INT NOT NULL,
  `nome` TEXT NOT NULL,
  `apelido` TEXT NOT NULL,
  `foto` BLOB NULL,
  `idPartido` INT NOT NULL,
  `idCargo` INT NOT NULL,
  `nroEleitoral` INT NULL,
  PRIMARY KEY (`idPolitico`),
  INDEX `Partido_idx` (`idPartido` ASC),
  INDEX `idCargo_idx` (`idCargo` ASC),
  CONSTRAINT `Partido`
    FOREIGN KEY (`idPartido`)
    REFERENCES `controle_candidatos`.`Partido` (`idPartido`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `idCargo`
    FOREIGN KEY (`idCargo`)
    REFERENCES `controle_candidatos`.`Cargo` (`idCargo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `controle_candidatos`.`Processo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `controle_candidatos`.`Processo` (
  `idProcesso` INT NOT NULL,
  `descricao` TEXT NULL,
  `dataCriacao` DATE NULL,
  `terminou` TEXT NULL,
  PRIMARY KEY (`idProcesso`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `controle_candidatos`.`Politico_Processos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `controle_candidatos`.`Politico_Processos` (
  `idPolitico` INT NOT NULL,
  `idProcesso` INT NOT NULL,
  INDEX `idProcesso_idx` (`idProcesso` ASC),
  INDEX `idPolitico_idx` (`idPolitico` ASC),
  CONSTRAINT `Processo`
    FOREIGN KEY (`idProcesso`)
    REFERENCES `controle_candidatos`.`Processo` (`idProcesso`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `PoliticoProcessado`
    FOREIGN KEY (`idPolitico`)
    REFERENCES `controle_candidatos`.`Politico` (`idPolitico`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `controle_candidatos`.`Doador`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `controle_candidatos`.`Doador` (
  `idDoador` INT NOT NULL,
  `nome` TEXT NULL,
  `valor` REAL NULL,
  PRIMARY KEY (`idDoador`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `controle_candidatos`.`Candidato`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `controle_candidatos`.`Candidato` (
  `idCandidato` INT NOT NULL,
  `dataNascimento` DATE NULL,
  PRIMARY KEY (`idCandidato`),
  CONSTRAINT `idCandidato`
    FOREIGN KEY (`idCandidato`)
    REFERENCES `controle_candidatos`.`Politico` (`idPolitico`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `controle_candidatos`.`PoliticoEmMandato`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `controle_candidatos`.`PoliticoEmMandato` (
  `idPoliticoEmMandato` INT NOT NULL,
  `dataPosse` DATE NULL,
  PRIMARY KEY (`idPoliticoEmMandato`),
  CONSTRAINT `idPoliticoEmMandato`
    FOREIGN KEY (`idPoliticoEmMandato`)
    REFERENCES `controle_candidatos`.`Politico` (`idPolitico`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `controle_candidatos`.`AvaliacaoPopular`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `controle_candidatos`.`AvaliacaoPopular` (
  `idAvaliacaoPopular` INT NOT NULL,
  `PoliticoAvaliado` INT NOT NULL,
  `nota` INT NULL,
  `descricao` TEXT NULL,
  PRIMARY KEY (`idAvaliacaoPopular`),
  INDEX `idPoliticoAvaliado_idx` (`PoliticoAvaliado` ASC),
  CONSTRAINT `PoliticoAvaliado`
    FOREIGN KEY (`PoliticoAvaliado`)
    REFERENCES `controle_candidatos`.`PoliticoEmMandato` (`idPoliticoEmMandato`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `controle_candidatos`.`PromessasCampanha`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `controle_candidatos`.`PromessasCampanha` (
  `idPromessasCampanha` INT NOT NULL,
  `Candidato` INT NOT NULL,
  `plano` TEXT NULL,
  `descricao` TEXT NULL,
  `dataOrigem` DATE NULL,
  PRIMARY KEY (`idPromessasCampanha`),
  INDEX `idCandidato_idx` (`Candidato` ASC),
  CONSTRAINT `Candidato`
    FOREIGN KEY (`Candidato`)
    REFERENCES `controle_candidatos`.`Candidato` (`idCandidato`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `controle_candidatos`.`Politico_Cargo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `controle_candidatos`.`Politico_Cargo` (
  `idPolitico` INT NOT NULL,
  `idCargo` INT NOT NULL,
  `nroEleitoral` INT NULL,
  `tipoLocalCargo` TEXT NULL,
  `nomeLocalCargo` TEXT NULL,
  `Politico_Cargocol` VARCHAR(45) NULL,
  PRIMARY KEY (`idPolitico`, `idCargo`),
  INDEX `idCargo_idx` (`idCargo` ASC),
  CONSTRAINT `Politico`
    FOREIGN KEY (`idPolitico`)
    REFERENCES `controle_candidatos`.`Politico` (`idPolitico`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Cargo`
    FOREIGN KEY (`idCargo`)
    REFERENCES `controle_candidatos`.`Cargo` (`idCargo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `controle_candidatos`.`Politico_Doador`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `controle_candidatos`.`Politico_Doador` (
  `idPolitico` INT NOT NULL,
  `idDoador` INT NOT NULL,
  INDEX `idPolitico_idx` (`idPolitico` ASC),
  INDEX `idDoador_idx` (`idDoador` ASC),
  CONSTRAINT `PoliticoDoacao`
    FOREIGN KEY (`idPolitico`)
    REFERENCES `controle_candidatos`.`Politico` (`idPolitico`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Doador`
    FOREIGN KEY (`idDoador`)
    REFERENCES `controle_candidatos`.`Doador` (`idDoador`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
