-- INSERT INTO player (playerEmail, username, password, Balance)
-- VALUES ('alice@example.com', 'Alice123', 'passA!', 150.00);

-- INSERT INTO player (playerEmail, username, password, Balance)
-- VALUES 
-- ('bob@example.com', 'Bobby', 'bobpwd', 200.00),
-- ('carl@example.com', 'Carlito', 'carlpwd', 320.50);

INSERT INTO player (playerEmail, username, password, Balance)
SELECT 'diana@example.com', 'DianaD', 'dianapwd', Balance
FROM player
WHERE playerEmail = 'alice@example.com';


SELECT * from player