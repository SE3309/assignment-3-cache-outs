-- Insert a $50 deposit transaction for every player whose balance is under 100
-- INSERT INTO transactions (playerEmail, dateTime, amount, transactionType)
-- SELECT p.playerEmail,
--        CURRENT_TIMESTAMP,
--        50,
--        0	-- 0 = deposit, 1 = withdraw
-- FROM player AS p
-- WHERE p.Balance < 100.00;

set SQL_SAFE_UPDATES = 0;
-- Add total winnings from bet table to each player's Balance
-- UPDATE player
-- SET Balance = Balance + (
--     SELECT COALESCE(SUM(b.amount), 0)
--     FROM bet AS b
--     WHERE b.playerEmail = player.playerEmail
--       AND b.outcome = TRUE
-- )
-- WHERE player.playerEmail IN (
--     SELECT playerEmail FROM bet WHERE outcome = TRUE
-- );

-- Delete all bans that ended before March 1, 2024
DELETE FROM bans
WHERE endDate < '2024-03-01';




set SQL_SAFE_UPDATES = 1;
