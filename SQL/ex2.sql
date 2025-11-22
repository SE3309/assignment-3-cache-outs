-- Optional: create & use database
CREATE DATABASE IF NOT EXISTS assignment3;
USE assignment3;

-- Clean up old tables (if they exist)
SET FOREIGN_KEY_CHECKS = 0;

DROP TABLE IF EXISTS bans;
DROP TABLE IF EXISTS bet;
DROP TABLE IF EXISTS transactions;
DROP TABLE IF EXISTS session;
DROP TABLE IF EXISTS game;
DROP TABLE IF EXISTS dealer;
DROP TABLE IF EXISTS player;

SET FOREIGN_KEY_CHECKS = 1;

-- 1. PLAYER
CREATE TABLE player (
  playerEmail VARCHAR(50) NOT NULL,
  username    VARCHAR(50) NOT NULL,
  password    VARCHAR(50) NOT NULL,
  Balance     DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (playerEmail)
);

-- 2. DEALER
CREATE TABLE dealer (
  dealerNo   INT NOT NULL,
  dealerName VARCHAR(50) NOT NULL,
  PRIMARY KEY (dealerNo)
);

-- 3. GAME
CREATE TABLE game (
  name         VARCHAR(15)  NOT NULL,
  minBet       DECIMAL(10,2),
  maxBet       DECIMAL(10,2),
  payoutRatio  INT,
  PRIMARY KEY (name)
);

-- 4. SESSION
CREATE TABLE session (
  dealerNo INT       NOT NULL,
  dateTimePlayed DATETIME  NOT NULL,
  gameName VARCHAR(15) NOT NULL,
  endTime  DATETIME,
  PRIMARY KEY (dealerNo, dateTimePlayed),
  CONSTRAINT fk_dealerNo
    FOREIGN KEY (dealerNo) REFERENCES dealer(dealerNo),
  CONSTRAINT fk_gameName
    FOREIGN KEY (gameName) REFERENCES game(name)
);

-- 5. BET
CREATE TABLE bet (
  amount          DECIMAL(10,2) NOT NULL,
  playerEmail     VARCHAR(50)   NOT NULL,
  dateTimePlaced  DATETIME      NOT NULL,
  sessionDateTime DATETIME      NOT NULL,
  dealerNo        INT           NOT NULL,
  outcome         BOOLEAN,  -- 1 = win | 0 = loss
  PRIMARY KEY (playerEmail, dateTimePlaced),
  CONSTRAINT fk_bet_playerEmail
    FOREIGN KEY (playerEmail) REFERENCES player(playerEmail),
  CONSTRAINT fk_bet_session
    FOREIGN KEY (dealerNo, sessionDateTime)
      REFERENCES session(dealerNo, dateTimePlayed),
  CONSTRAINT fk_bet_dealer
    FOREIGN KEY (dealerNo) REFERENCES dealer(dealerNo)
);

-- 6. BANS
CREATE TABLE bans (
  startDate   DATE        NOT NULL,
  endDate     DATE        NOT NULL,
  reason      VARCHAR(25) NOT NULL,
  playerEmail VARCHAR(50) NOT NULL,
  PRIMARY KEY (playerEmail, startDate),
  CONSTRAINT fk_playerEmail
    FOREIGN KEY (playerEmail) REFERENCES player(playerEmail)
);

-- 7. TRANSACTIONS
CREATE TABLE transactions (
  playerEmail     VARCHAR(50) NOT NULL,
  dateTime        DATETIME    NOT NULL,
  amount          INT         NOT NULL,
  transactionType BOOLEAN,    -- 1 = withdraw | 0 = deposit
  PRIMARY KEY (playerEmail, dateTime),
  CONSTRAINT fk_transactions_playerEmail
    FOREIGN KEY (playerEmail) REFERENCES player(playerEmail)
);

-- Optional indexes (ISO-style, separate from CREATE TABLE)
CREATE INDEX idx_bet_session
  ON bet (dateTimePlaced, dealerNo);

CREATE INDEX idx_session_gameName
ON session (gameName);

CREATE INDEX idx_transactions_type
ON transactions (transactionType);
