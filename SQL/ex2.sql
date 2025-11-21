-- Optional: create & use database
CREATE DATABASE IF NOT EXISTS assignment3;
USE assignment3;

-- Clean up old tables (if they exist)
SET FOREIGN_KEY_CHECKS = 0;

DROP TABLE IF EXISTS `bans`;
DROP TABLE IF EXISTS `bet`;
DROP TABLE IF EXISTS `txn`;
DROP TABLE IF EXISTS `session`;
DROP TABLE IF EXISTS `game`;
DROP TABLE IF EXISTS `dealer`;
DROP TABLE IF EXISTS `player`;

SET FOREIGN_KEY_CHECKS = 1;

-- 1. PLAYER
CREATE TABLE `player` (
  `playerEmail` varchar(50) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL,
  `Balance` decimal(10,2) NOT NULL,
  PRIMARY KEY (`playerEmail`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- 2. DEALER
CREATE TABLE `dealer` (
  `dealerNo` int NOT NULL,
  `dealerName` varchar(50) NOT NULL,
  PRIMARY KEY (`dealerNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- 3. GAME
CREATE TABLE `game` (
  `name` varchar(15) NOT NULL,
  `minBet` decimal(10,2),
  `maxBet` decimal(10,2),
  `payoutRatio` int,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- 4. SESSION
CREATE TABLE `session` (
  `dealerNo` int NOT NULL,
  `dateTime` datetime NOT NULL,
  `gameName` varchar(15) NOT NULL,
  `endTime` datetime,
  PRIMARY KEY (`dealerNo`,`dateTime`),
  UNIQUE KEY `uq_session_datetime_dealerno` (`dateTime`,`dealerNo`),
  CONSTRAINT `fk_dealerNo` FOREIGN KEY (`dealerNo`) REFERENCES `dealer` (`dealerNo`),
  CONSTRAINT `fk_gameName` FOREIGN KEY (`gameName`) REFERENCES `game` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- 5. BET
CREATE TABLE `bet` (
  `amount` decimal(10,2) NOT NULL,
  `playerEmail` varchar(50) NOT NULL,
  `dateTime` datetime NOT NULL,
  `dealerNo` int NOT NULL,
  `outcome` boolean, -- 1 = win | 0 = loss
  PRIMARY KEY (`playerEmail`,`dateTime`),
  KEY `fk_bet_session` (`dateTime`,`dealerNo`),
  CONSTRAINT `fk_bet_playerEmail` FOREIGN KEY (`playerEmail`) REFERENCES `player` (`playerEmail`),
  CONSTRAINT `fk_bet_session` FOREIGN KEY (`dateTime`, `dealerNo`) REFERENCES `session` (`dateTime`, `dealerNo`),
  CONSTRAINT `fk_bet_dealer` FOREIGN KEY (`dealerNo`) REFERENCES `dealer` (`dealerNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- 6. BANS
CREATE TABLE `bans` (
  `startDate` date NOT NULL,
  `endDate` date NOT NULL,
  `reason` varchar(25) NOT NULL,
  `playerEmail` varchar(50) NOT NULL,
  PRIMARY KEY (`playerEmail`,`startDate`),
  KEY `fk_playerEmail` (`playerEmail`),
  CONSTRAINT `fk_playerEmail` FOREIGN KEY (`playerEmail`) REFERENCES `player` (`playerEmail`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- 7. TRANSACTIONS
CREATE TABLE `transactions` (
  `playerEmail` varchar(50) NOT NULL,
  `dateTime` datetime NOT NULL,
  `amount` int NOT NULL,
  `transactionType` boolean, -- 1 = withdraw | 0 = depposit
  PRIMARY KEY (`playerEmail`,`dateTime`),
  CONSTRAINT `playerEmail` FOREIGN KEY (`playerEmail`) REFERENCES `player` (`playerEmail`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
