-- View 1: Player Performance and Cash flow
CREATE OR REPLACE VIEW v_player_performance AS
SELECT
    p.playerEmail,
    p.username,
    p.Balance,

    -- betting stats
    COUNT(b.dateTimePlaced) AS totalBets,
    SUM(CASE WHEN b.outcome = 1 THEN 1 ELSE 0 END) AS wins,
    SUM(CASE WHEN b.outcome = 0 THEN 1 ELSE 0 END) AS losses,
    ROUND(
        100.0 * SUM(CASE WHEN b.outcome = 1 THEN 1 ELSE 0 END)
        / NULLIF(COUNT(b.dateTimePlaced), 0),
        2
    ) AS winRatePercent,

    -- transaction stats
    COALESCE(SUM(CASE WHEN t.transactionType = 0 THEN t.amount ELSE 0 END), 0) AS totalDeposited,
    COALESCE(SUM(CASE WHEN t.transactionType = 1 THEN t.amount ELSE 0 END), 0) AS totalWithdrawn,

    -- currently banned?
    CASE
        WHEN EXISTS (
            SELECT 1
            FROM bans bn
            WHERE bn.playerEmail = p.playerEmail
              AND CURRENT_DATE BETWEEN bn.startDate AND bn.endDate
        )
        THEN 1
        ELSE 0
    END AS isCurrentlyBanned

FROM player p
LEFT JOIN bet b
    ON p.playerEmail = b.playerEmail
LEFT JOIN transactions t
    ON p.playerEmail = t.playerEmail
GROUP BY p.playerEmail, p.username, p.Balance;

-- View 2: for looking at dealer sessions
CREATE OR REPLACE VIEW v_session_summary AS
SELECT
    s.dealerNo,
    d.dealerName,
    s.dateTimePlayed AS startTime,
    s.endTime,
    s.gameName,
    g.minBet,
    g.maxBet,
    g.payoutRatio,
    TIMESTAMPDIFF(MINUTE, s.dateTimePlayed, s.endTime) AS durationMinutes
FROM session s
JOIN dealer d ON s.dealerNo = d.dealerNo
JOIN game g ON s.gameName = g.name;


-- Player Performance Query
-- SELECT
--   username,
--   Balance,
--   totalBets,
--   wins,
--   losses,
--   winRatePercent,
--   totalDeposited,
--   totalWithdrawn,
--   isCurrentlyBanned
-- FROM v_player_performance
-- ORDER BY winRatePercent DESC, totalBets DESC
-- LIMIT 5;


-- Dealer Sessions Query
-- SELECT
--   dealerName,
--   gameName,
--   startTime,
--   endTime,
--   durationMinutes,
--   minBet,
--   maxBet
-- FROM v_session_summary
-- ORDER BY startTime DESC
-- LIMIT 5;

-- Quries:
-- INSERT INTO v_player_performance
-- (playerEmail, username, Balance)
-- VALUES
-- ('newguy@email.com', 'newguy', 100.00);
--
-- UPDATE v_player_performance
-- SET winRatePercent = 100
-- WHERE playerEmail = 'someplayer@email.com';
--
-- INSERT INTO v_session_summary
-- (dealerNo, dealerName, startTime, endTime, gameName, minBet, maxBet, payoutRatio, durationMinutes)
-- VALUES
-- (99, 'DealerX', '2025-11-20 18:00:00', '2025-11-20 20:00:00', 'Poker', 5.00, 100.00, 2, 120);
--
-- UPDATE v_session_summary
-- SET dealerName = 'ChangedName'
-- WHERE dealerNo = 1;
