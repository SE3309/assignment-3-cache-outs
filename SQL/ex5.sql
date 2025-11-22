select *
from bet
where amount>200;

SELECT playerEmail, sum(amount) AS total_winnings
from bet
where outcome=1
group by playerEmail;


SELECT username,Balance,reason,endDate
FROM player
JOIN bans ON bans.playerEmail = player.playerEmail
WHERE balance > 0;

SELECT *
FROM bet
WHERE amount > (
    SELECT AVG(amount)
    FROM bet
);

SELECT *
FROM player
WHERE NOT EXISTS (
    SELECT *
    FROM bans
    WHERE bans.playerEmail = player.playerEmail
);

SELECT player.playerEmail,
       COUNT(dateTimePlaced) AS bet_placed
FROM Player
JOIN bet ON bet.playerEmail = player.playerEmail
GROUP BY player.playerEmail
ORDER BY bet_placed DESC;
