-- View 1: Player Performance and Cash flow
CREATE OR REPLACE VIEW v_player_performance AS
SELECT
    p.playerEmail,
    p.username,
    p.Balance,

    -- betting stats
    COUNT(b.dateTime) AS totalBets,
    SUM(CASE WHEN b.outcome = 1 THEN 1 ELSE 0 END) AS wins,
    SUM(CASE WHEN b.outcome = 0 THEN 1 ELSE 0 END) AS losses,
    ROUND(
        100.0 * SUM(CASE WHEN b.outcome = 1 THEN 1 ELSE 0 END) / NULLIF(COUNT(b.dateTime), 0),
        2
    ) AS winRatePercent,

    -- transaction stats
    COALESCE(SUM(CASE WHEN t.transactionType = 0 THEN t.amount ELSE 0 END), 0) AS totalDeposited,
    COALESCE(SUM(CASE WHEN t.transactionType = 1 THEN t.amount ELSE 0 END), 0) AS totalWithdrawn,

    -- "currently banned?" flag
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


-- View 2: for looking at dealer 
CREATE OR REPLACE VIEW v_session_summary AS
SELECT
    s.dealerNo,
    d.dealerName,
    s.dateTime AS startTime,
    s.endTime,
    s.gameName,
    g.minBet,
    g.maxBet,
    g.payoutRatio,
    TIMESTAMPDIFF(MINUTE, s.dateTime, s.endTime) AS durationMinutes
FROM session s
JOIN dealer d ON s.dealerNo = d.dealerNo
JOIN game g ON s.gameName = g.name;
