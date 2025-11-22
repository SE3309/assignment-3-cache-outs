-- query 1
select *
from bet
where amount>200;

-- query 2
SELECT playerEmail, sum(amount) AS total_winnings
from bet
where outcome=1
group by playerEmail;

-- query 3
SELECT username,Balance,reason,endDate
FROM player
JOIN bans ON bans.playerEmail = player.playerEmail
WHERE balance > 0;

-- query 4
SELECT *
FROM bet
WHERE amount > (
    SELECT AVG(amount)
    FROM bet
);

-- query 5
SELECT *
FROM player
WHERE NOT EXISTS (
    SELECT *
    FROM bans
    WHERE bans.playerEmail = player.playerEmail
);

-- query 6
SELECT player.playerEmail,
       COUNT(dateTimePlaced) AS bet_placed
FROM Player
JOIN bet ON bet.playerEmail = player.playerEmail
GROUP BY player.playerEmail
ORDER BY bet_placed DESC;

-- query 7
SELECT player.playerEmail, bet.amount
FROM player
JOIN bet ON player.playerEmail = bet.playerEmail
WHERE bet.amount IN (
    SELECT amount
    FROM bet
    WHERE amount > 400
);