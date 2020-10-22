-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema pa_db
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema pa_db
-- -----------------------------------------------------
DROP SCHEMA IF  EXISTS `pa_db`;

CREATE SCHEMA IF NOT EXISTS `pa_db` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `pa_db` ;

-- -----------------------------------------------------
-- Table `pa_db`.`attachment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pa_db`.`attachment` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `file_name` TINYTEXT NULL DEFAULT NULL,
  `file_type` TINYTEXT NULL DEFAULT NULL,
  `file_path` TINYTEXT NULL DEFAULT NULL,
  `file_url` TINYTEXT NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `pa_db`.`calendar`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pa_db`.`calendar` (
  `cdate` DATE NOT NULL,
  `day_type_iid` INT UNSIGNED NOT NULL,
  `entry_id` INT UNSIGNED NOT NULL,
  `entry_tyme` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_id` INT UNSIGNED NULL DEFAULT NULL,
  `UpdateTime` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`cdate`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `pa_db`.`classifier`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pa_db`.`classifier` (
  `id` INT UNSIGNED NOT NULL,
  `parent_id` INT UNSIGNED NULL DEFAULT NULL,
  `class_code` VARCHAR(30) NOT NULL,
  `class_name` VARCHAR(50) NULL DEFAULT NULL,
  `note` VARCHAR(255) NULL DEFAULT NULL,
  `is_system` CHAR(1) NOT NULL DEFAULT 'F',
  `entry_id` INT UNSIGNED NOT NULL,
  `entry_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_id` INT UNSIGNED NULL DEFAULT NULL,
  `update_time` DATETIME NULL DEFAULT NULL,
  `is_readonly` CHAR(1) NOT NULL DEFAULT 'T',
  PRIMARY KEY (`id`),
  INDEX `fk_classifier_classifier_idx` (`parent_id` ASC) VISIBLE,
  CONSTRAINT `fk_classifier_classifier`
    FOREIGN KEY (`parent_id`)
    REFERENCES `pa_db`.`classifier` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `pa_db`.`item`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pa_db`.`item` (
  `iid` INT unsigned NOT NULL AUTO_INCREMENT,
  `parent_iid` INT UNSIGNED NULL DEFAULT NULL,
  `classifier_id` INT UNSIGNED NOT NULL,
  `code` VARCHAR(30) NULL DEFAULT NULL,
  `code_lit` VARCHAR(30) NULL DEFAULT NULL,
  `code_num` INT NULL DEFAULT NULL,
  `name` VARCHAR(80) NULL DEFAULT NULL,
  `full_name` VARCHAR(160) NULL DEFAULT NULL,
  `item_name` VARCHAR(80) NULL DEFAULT NULL,
  `note` VARCHAR(255) NULL DEFAULT NULL,
  `status_iid` INT UNSIGNED NOT NULL,
  `entry_id` INT UNSIGNED NOT NULL,
  `entry_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_id` INT UNSIGNED NULL DEFAULT NULL,
  `update_time` DATETIME NULL DEFAULT NULL,
  `sort_idx` VARCHAR(20) NULL DEFAULT NULL,
  PRIMARY KEY (`iid`),
  INDEX `fk_item_item1_idx` (`parent_iid` ASC) VISIBLE,
  INDEX `fk_item_classifier1_idx` (`classifier_id` ASC) VISIBLE,
  CONSTRAINT `fk_item_item1`
    FOREIGN KEY (`parent_iid`)
    REFERENCES `pa_db`.`item` (`iid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_item_classifier1`
    FOREIGN KEY (`classifier_id`)
    REFERENCES `pa_db`.`classifier` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `pa_db`.`menu`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pa_db`.`menu` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `parent_id` INT UNSIGNED NULL DEFAULT NULL,
  `status_iid` INT UNSIGNED NOT NULL,
  `type_iid` INT UNSIGNED NOT NULL,
  `key` VARCHAR(255) NOT NULL DEFAULT '',
  `value` LONGTEXT NULL DEFAULT NULL,
  `entry_id` INT UNSIGNED NOT NULL,
  `entry_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_id` INT UNSIGNED NULL DEFAULT NULL,
  `update_date` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `pa_db`.`post`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pa_db`.`post` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `menu_id` INT UNSIGNED NOT NULL,
  `parent_id` INT UNSIGNED NULL DEFAULT NULL,
  `status_iid` INT UNSIGNED NOT NULL,
  `type_iid` INT UNSIGNED NOT NULL,
  `entry_id` INT UNSIGNED NOT NULL,
  `entry_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_id` INT UNSIGNED NULL DEFAULT NULL,
  `update_date` DATETIME NULL DEFAULT NULL,
  `key` VARCHAR(255) NOT NULL DEFAULT '',
  `value` LONGTEXT NULL DEFAULT NULL,
  `title` TEXT NOT NULL,
  `excerpt` TEXT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_post_item1_idx` (`status_iid` ASC) VISIBLE,
  INDEX `fk_post_menu1_idx` (`menu_id` ASC) VISIBLE,
  CONSTRAINT `fk_post_item1`
    FOREIGN KEY (`status_iid`)
    REFERENCES `pa_db`.`item` (`iid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_post_menu1`
    FOREIGN KEY (`menu_id`)
    REFERENCES `pa_db`.`menu` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `pa_db`.`comment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pa_db`.`comment` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `post_id` INT UNSIGNED NOT NULL DEFAULT '0',
  `entry_id` INT UNSIGNED NOT NULL,
  `entry_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `key` VARCHAR(255) NOT NULL DEFAULT '',
  `value` LONGTEXT NULL DEFAULT NULL,
  `karma` INT NOT NULL DEFAULT '0',
  `status_iid` INT UNSIGNED NOT NULL,
  `type_iid` INT UNSIGNED NOT NULL,
  `parent_id` INT UNSIGNED NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_comment_post1_idx` (`post_id` ASC) VISIBLE,
  CONSTRAINT `fk_comment_post1`
    FOREIGN KEY (`post_id`)
    REFERENCES `pa_db`.`post` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `pa_db`.`commentmeta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pa_db`.`commentmeta` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `comment_id` INT UNSIGNED NULL DEFAULT NULL,
  `key` VARCHAR(255) NOT NULL DEFAULT '',
  `value` LONGTEXT NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_commentmeta_comment1_idx` (`comment_id` ASC) VISIBLE,
  CONSTRAINT `fk_commentmeta_comment1`
    FOREIGN KEY (`comment_id`)
    REFERENCES `pa_db`.`comment` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `pa_db`.`period`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pa_db`.`period` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `begin_date` DATE NOT NULL,
  `end_date` DATE NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_period_calendar1_idx` (`begin_date` ASC) VISIBLE,
  INDEX `fk_period_calendar2_idx` (`end_date` ASC) VISIBLE,
  CONSTRAINT `fk_period_calendar1`
    FOREIGN KEY (`begin_date`)
    REFERENCES `pa_db`.`calendar` (`cdate`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_period_calendar2`
    FOREIGN KEY (`end_date`)
    REFERENCES `pa_db`.`calendar` (`cdate`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `pa_db`.`dues`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pa_db`.`dues` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `member_id` INT UNSIGNED NOT NULL,
  `oper_date` DATE NOT NULL,
  `IBAN` INT NULL DEFAULT NULL,
  `amount` DECIMAL(10,2) NOT NULL DEFAULT 0,
  `purpose_iid` INT UNSIGNED NOT NULL,
  `status_iid` INT UNSIGNED NOT NULL,
  `entry_id` INT UNSIGNED NOT NULL,
  `entry_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `note` VARCHAR(255) NULL DEFAULT NULL,
  `transaction_no` INT NULL DEFAULT NULL,
  `period_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_dues_item1_idx` (`purpose_iid` ASC) VISIBLE,
  INDEX `fk_dues_period1_idx` (`period_id` ASC) VISIBLE,
  CONSTRAINT `fk_dues_item1`
    FOREIGN KEY (`purpose_iid`)
    REFERENCES `pa_db`.`item` (`iid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_dues_period1`
    FOREIGN KEY (`period_id`)
    REFERENCES `pa_db`.`period` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `pa_db`.`event`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pa_db`.`event` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `type_iid` INT UNSIGNED NOT NULL,
  `key` VARCHAR(255) NOT NULL DEFAULT '',
  `value` LONGTEXT NULL DEFAULT NULL,
  `period_id` INT UNSIGNED NOT NULL,
  `note` VARCHAR(255) NULL DEFAULT NULL,
  `url` VARCHAR(255) NULL DEFAULT NULL,
  `status_iid` INT UNSIGNED NOT NULL,
  `entry_id` INT UNSIGNED NOT NULL,
  `entry_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_id` INT UNSIGNED NULL DEFAULT NULL,
  `update_time` DATETIME NULL DEFAULT NULL,
  `post_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_event_period1_idx` (`period_id` ASC) VISIBLE,
  INDEX `fk_event_post1_idx` (`post_id` ASC) VISIBLE,
  INDEX `fk_event_item1_idx` (`type_iid` ASC) VISIBLE,
  INDEX `fk_event_item2_idx` (`status_iid` ASC) VISIBLE,
  CONSTRAINT `fk_event_period1`
    FOREIGN KEY (`period_id`)
    REFERENCES `pa_db`.`period` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_event_post1`
    FOREIGN KEY (`post_id`)
    REFERENCES `pa_db`.`post` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_event_item1`
    FOREIGN KEY (`type_iid`)
    REFERENCES `pa_db`.`item` (`iid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_event_item2`
    FOREIGN KEY (`status_iid`)
    REFERENCES `pa_db`.`item` (`iid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `pa_db`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pa_db`.`user` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `login` VARCHAR(60) NOT NULL DEFAULT '',
  `psw` VARCHAR(255) NOT NULL DEFAULT '',
  `nicename` VARCHAR(50) NOT NULL DEFAULT '',
  `email` VARCHAR(100) NOT NULL DEFAULT '',
  `url` VARCHAR(100) NOT NULL DEFAULT '',
  `registered` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `activation_key` VARCHAR(255) NOT NULL DEFAULT '',
  `status_iid` INT UNSIGNED NOT NULL,
  `display_name` VARCHAR(250) NOT NULL DEFAULT '',
  `type_iid` INT UNSIGNED NOT NULL,
  `begin_date` DATE NULL DEFAULT NULL,
  `end_date` DATE NULL DEFAULT NULL,
  `expire_date` DATE NULL DEFAULT NULL,
  `post_id` INT NULL DEFAULT NULL,
  `tel_num` VARCHAR(20) NULL DEFAULT NULL,
  `entry_id` INT UNSIGNED NULL DEFAULT NULL,
  `entry_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_id` INT UNSIGNED NULL DEFAULT NULL,
  `update_time` DATETIME NULL DEFAULT NULL,
  `note` VARCHAR(200) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_user_item1_idx` (`type_iid` ASC) VISIBLE,
  CONSTRAINT `fk_user_item1`
    FOREIGN KEY (`type_iid`)
    REFERENCES `pa_db`.`item` (`iid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `pa_db`.`failed_login`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pa_db`.`failed_login` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` INT UNSIGNED NULL DEFAULT NULL,
  `user_login` VARCHAR(150) NOT NULL,
  `failed_login_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `login_attempt_ip` VARCHAR(100) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  INDEX `fk_failed_login_user1_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `fk_failed_login_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `pa_db`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `pa_db`.`fixed_dues`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pa_db`.`fixed_dues` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `type_iid` INT UNSIGNED NULL DEFAULT NULL,
  `begin_date` DATE NOT NULL,
  `end_date` DATE NOT NULL,
  `amount` DECIMAL(10,2) NOT NULL DEFAULT 0,
  `status_iid` INT UNSIGNED NOT NULL,
  `entry_id` INT UNSIGNED NOT NULL,
  `entry_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_id` INT UNSIGNED NULL DEFAULT NULL,
  `update_time` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_fixed_dues_item1_idx` (`type_iid` ASC) VISIBLE,
  CONSTRAINT `fk_fixed_dues_item1`
    FOREIGN KEY (`type_iid`)
    REFERENCES `pa_db`.`item` (`iid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `pa_db`.`image`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pa_db`.`image` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `post_id` INT UNSIGNED NOT NULL,
  `url` VARCHAR(600) NOT NULL DEFAULT '',
  `file_name` VARCHAR(600) NOT NULL DEFAULT '',
  `attachment_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_image_post1_idx` (`post_id` ASC) VISIBLE,
  INDEX `fk_image_attachment1_idx` (`attachment_id` ASC) VISIBLE,
  CONSTRAINT `fk_image_post1`
    FOREIGN KEY (`post_id`)
    REFERENCES `pa_db`.`post` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_image_attachment1`
    FOREIGN KEY (`attachment_id`)
    REFERENCES `pa_db`.`attachment` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `pa_db`.`login_activity`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pa_db`.`login_activity` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` INT UNSIGNED NULL DEFAULT NULL,
  `user_login` VARCHAR(150) NOT NULL,
  `in_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `out_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ip_address` VARCHAR(100) NOT NULL DEFAULT '',
  `browser_type` VARCHAR(150) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  INDEX `fk_login_activity_user1_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `fk_login_activity_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `pa_db`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `pa_db`.`login_lockdown`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pa_db`.`login_lockdown` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` INT UNSIGNED NULL DEFAULT NULL,
  `user_login` VARCHAR(150) NOT NULL,
  `lockdown_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `release_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ip_address` VARCHAR(100) NOT NULL DEFAULT '',
  `lock_reason` VARCHAR(128) NOT NULL DEFAULT '',
  `unlock_key` VARCHAR(128) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  INDEX `fk_login_lockdown_user1_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `fk_login_lockdown_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `pa_db`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `pa_db`.`member`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pa_db`.`member` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `type_iid` INT UNSIGNED NOT NULL,
  `user_id` INT UNSIGNED NULL DEFAULT NULL,
  `tax_code` VARCHAR(20) NULL DEFAULT NULL,
  `last_name` VARCHAR(50) NULL DEFAULT NULL,
  `first_name` VARCHAR(50) NULL DEFAULT NULL,
  `middle_name` VARCHAR(50) NULL DEFAULT NULL,
  `org_name` VARCHAR(250) NULL DEFAULT NULL,
  `country_iid` INT UNSIGNED NULL DEFAULT NULL,
  `doc_type_iid` INT UNSIGNED NULL DEFAULT NULL,
  `doc_series` VARCHAR(10) NULL DEFAULT NULL,
  `doc_num` VARCHAR(30) NULL DEFAULT NULL,
  `sex_iid` INT UNSIGNED NULL DEFAULT NULL,
  `birthday` DATE NULL DEFAULT NULL,
  `status_iid` INT UNSIGNED NOT NULL,
  `close_date` DATE NULL DEFAULT NULL,
  `entry_id` INT UNSIGNED NOT NULL,
  `entry_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_iid` INT UNSIGNED NULL DEFAULT NULL,
  `update_time` DATETIME NULL DEFAULT NULL,
  `note` VARCHAR(200) NULL DEFAULT NULL,
  `reestr_num` VARCHAR(20) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_member_item1_idx` (`type_iid` ASC) VISIBLE,
  CONSTRAINT `fk_member_item1`
    FOREIGN KEY (`type_iid`)
    REFERENCES `pa_db`.`item` (`iid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `pa_db`.`options`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pa_db`.`options` (
  `id` INT UNSIGNED NOT NULL,
  `key` VARCHAR(255) NOT NULL DEFAULT '',
  `value` LONGTEXT NULL DEFAULT NULL,
  `is_autoload` CHAR(1) NOT NULL DEFAULT 'T',
  PRIMARY KEY (`id`),
  UNIQUE INDEX `key` (`key` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `pa_db`.`postmeta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pa_db`.`postmeta` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `post_id` INT UNSIGNED NOT NULL DEFAULT '0',
  `key` VARCHAR(255) NOT NULL DEFAULT '',
  `value` LONGTEXT NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_postmeta_post1_idx` (`post_id` ASC) VISIBLE,
  CONSTRAINT `fk_postmeta_post1`
    FOREIGN KEY (`post_id`)
    REFERENCES `pa_db`.`post` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `pa_db`.`support_request`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pa_db`.`support_request` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` INT UNSIGNED NOT NULL,
  `key` VARCHAR(255) NOT NULL DEFAULT '',
  `value` LONGTEXT NULL DEFAULT NULL,
  `entry_date` DATETIME NOT NULL,
  `entry_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_support_request_user1_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `fk_support_request_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `pa_db`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `pa_db`.`support_reply`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pa_db`.`support_reply` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `request_id` INT UNSIGNED NOT NULL,
  `user_id` INT UNSIGNED NOT NULL,
  `key` VARCHAR(255) NOT NULL DEFAULT '',
  `value` LONGTEXT NULL DEFAULT NULL,
  `entry_date` DATETIME NOT NULL,
  `entry_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_support_reply_support_request1_idx` (`request_id` ASC) VISIBLE,
  CONSTRAINT `fk_support_reply_support_request1`
    FOREIGN KEY (`request_id`)
    REFERENCES `pa_db`.`support_request` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_support_reply_user1`
    FOREIGN KEY (`request_id`)
    REFERENCES `pa_db`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `pa_db`.`trans_log`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pa_db`.`trans_log` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `timestamp` DATETIME NOT NULL,
  `level` INT NOT NULL,
  `source` VARCHAR(200) NOT NULL,
  `message` LONGTEXT NOT NULL,
  `value` LONGTEXT NULL DEFAULT NULL,
  `user_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_trans_log_user1_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `fk_trans_log_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `pa_db`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `pa_db`.`user_group`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pa_db`.`user_group` (
  `id` INT unsigned NOT NULL AUTO_INCREMENT,
  `code` VARCHAR(30) NOT NULL,
  `name` VARCHAR(50) NOT NULL,
  `note` VARCHAR(255) NULL DEFAULT NULL,
  `status_iid` INT UNSIGNED NOT NULL,
  `entry_id` INT UNSIGNED NOT NULL,
  `entry_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_id` INT UNSIGNED NULL DEFAULT NULL,
  `update_time` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_user_group_item1_idx` (`status_iid` ASC) VISIBLE,
  INDEX `fk_user_group_user1_idx` (`update_id` ASC) VISIBLE,
  CONSTRAINT `fk_user_group_item1`
    FOREIGN KEY (`status_iid`)
    REFERENCES `pa_db`.`item` (`iid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_group_user1`
    FOREIGN KEY (`update_id`)
    REFERENCES `pa_db`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `pa_db`.`user_group_content`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pa_db`.`user_group_content` (
  `id` INT UNSIGNED NOT NULL,
  `user_id` INT UNSIGNED NOT NULL,
  `group_id` INT UNSIGNED NOT NULL,
  `entry_id` INT UNSIGNED NOT NULL,
  `entry_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  INDEX `fk_user_group_content_user1_idx` (`user_id` ASC) VISIBLE,
  INDEX `fk_user_group_content_user_group1_idx` (`group_id` ASC) VISIBLE,
  CONSTRAINT `fk_user_group_content_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `pa_db`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_group_content_user_group1`
    FOREIGN KEY (`group_id`)
    REFERENCES `pa_db`.`user_group` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `pa_db`.`usermeta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pa_db`.`usermeta` (
  `id` INT UNSIGNED NOT NULL,
  `user_id` INT UNSIGNED NOT NULL DEFAULT '0',
  `key` VARCHAR(255) NOT NULL DEFAULT '',
  `value` LONGTEXT NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_usermeta_user1_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `fk_usermeta_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `pa_db`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
