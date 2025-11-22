import random
from datetime import datetime, timedelta

# Explanation in Word document attached to submission.
# ---------- CONFIG ----------
NUM_GAMES = 3
NUM_DEALERS = 20          # tens
NUM_PLAYERS = 400         # hundreds
NUM_SESSIONS = 300        # hundreds
NUM_BETS = 5000           # thousands
NUM_TRANSACTIONS = 5000   # thousands
NUM_BANS = 40             # tens

START_DATE = datetime(2024, 1, 1)
END_DATE = datetime(2024, 12, 31)

random.seed(42)


def random_datetime(start, end):
    """Return a random datetime between start and end."""
    delta = end - start
    seconds = random.randint(0, int(delta.total_seconds()))
    return start + timedelta(seconds=seconds)


def fmt_dt(dt: datetime) -> str:
    """Format datetime for MySQL DATETIME."""
    return dt.strftime("%Y-%m-%d %H:%M:%S")


def fmt_d(dt: datetime) -> str:
    """Format date for MySQL DATE."""
    return dt.strftime("%Y-%m-%d")


print("-- Data generation for assignment3")
print("USE assignment3;")
print()

# 1. GAMES
base_games = ["Blackjack", "Roulette", "Poker"]
game_names = base_games[:NUM_GAMES]

print("-- GAMES")
for name in game_names:
    min_bet = random.choice([5.00, 10.00, 20.00])
    max_bet = min_bet * random.choice([20, 50, 100])
    payout_ratio = random.choice([1, 2, 3])
    print(
        "INSERT INTO game (name, minBet, maxBet, payoutRatio) "
        f"VALUES ('{name}', {min_bet:.2f}, {max_bet:.2f}, {payout_ratio});"
    )
print()

# 2. DEALERS
dealers = []
print("-- DEALERS")
for i in range(1, NUM_DEALERS + 1):
    dealer_no = i
    dealer_name = f"Dealer_{i}"
    dealers.append(dealer_no)
    print(
        "INSERT INTO dealer (dealerNo, dealerName) "
        f"VALUES ({dealer_no}, '{dealer_name}');"
    )
print()

# 3. PLAYERS
players = []
print("-- PLAYERS")
for i in range(1, NUM_PLAYERS + 1):
    email = f"player{i}@example.com"
    username = f"player{i}"
    password = f"pass{i:04d}"
    balance = round(random.uniform(50.00, 5000.00), 2)
    players.append(email)
    print(
        "INSERT INTO player (playerEmail, username, password, Balance) "
        f"VALUES ('{email}', '{username}', '{password}', {balance:.2f});"
    )
print()

# 4. SESSIONS
print("-- SESSIONS")
sessions = []  # list of (dealerNo, dateTimePlayed, gameName, endTime)
used_session_keys = set()

while len(sessions) < NUM_SESSIONS:
    dealer_no = random.choice(dealers)
    game_name = random.choice(game_names)
    start_dt = random_datetime(START_DATE, END_DATE)
    # Round to minutes to reduce duplicates
    start_dt = start_dt.replace(second=0, microsecond=0)
    end_dt = start_dt + timedelta(minutes=random.randint(30, 180))

    key = (dealer_no, start_dt)
    if key in used_session_keys:
        continue
    used_session_keys.add(key)

    sessions.append((dealer_no, start_dt, game_name, end_dt))

for dealer_no, start_dt, game_name, end_dt in sessions:
    print(
        "INSERT INTO session (dealerNo, dateTimePlayed, gameName, endTime) "
        f"VALUES ({dealer_no}, '{fmt_dt(start_dt)}', "
        f"'{game_name}', '{fmt_dt(end_dt)}');"
    )
print()

# 5. BANS
print("-- BANS")
ban_reasons = [
    "Cheating", "Abuse", "Fraud", "Chargeback",
    "Underage", "Multiple Accounts",
]
banned_players = random.sample(players, min(NUM_BANS, len(players)))
used_ban_keys = set()

for email in banned_players:
    # pick a random start date, ensure room for endDate
    start_dt = random_datetime(START_DATE, END_DATE - timedelta(days=7))
    start_date = start_dt.date()
    if (email, start_date) in used_ban_keys:
        continue
    used_ban_keys.add((email, start_date))

    end_date = start_date + timedelta(days=random.randint(7, 60))
    reason = random.choice(ban_reasons)
    print(
        "INSERT INTO bans (startDate, endDate, reason, playerEmail) "
        f"VALUES ('{fmt_d(start_dt)}', '{fmt_d(end_date)}', "
        f"'{reason}', '{email}');"
    )
print()

# 6. TRANSACTIONS
print("-- TRANSACTIONS")
used_txn_keys = set()

for _ in range(NUM_TRANSACTIONS):
    email = random.choice(players)
    dt = random_datetime(START_DATE, END_DATE)
    dt = dt.replace(microsecond=0)
    key = (email, dt)
    if key in used_txn_keys:
        continue
    used_txn_keys.add(key)

    amount = random.randint(10, 2000)  # INT per schema
    txn_type = random.choice([0, 1])   # 0 = deposit, 1 = withdraw
    print(
        "INSERT INTO transactions (playerEmail, dateTime, amount, transactionType) "
        f"VALUES ('{email}', '{fmt_dt(dt)}', {amount}, {txn_type});"
    )
print()

# 7. BETS
print("-- BETS")
used_bet_keys = set()

for _ in range(NUM_BETS):
    # pick a random session
    dealer_no, session_start, game_name, end_dt = random.choice(sessions)
    email = random.choice(players)

    # bet placed sometime during the session
    bet_dt = session_start + timedelta(
        minutes=random.randint(0, int((end_dt - session_start).total_seconds() // 60))
    )
    bet_dt = bet_dt.replace(microsecond=0)

    # PK: (playerEmail, dateTimePlaced)
    bet_key = (email, bet_dt)
    if bet_key in used_bet_keys:
        continue
    used_bet_keys.add(bet_key)

    session_dt = session_start  # must match session.dateTimePlayed for FK

    amount = round(random.uniform(5.00, 500.00), 2)
    outcome = random.choice([0, 1])  # 0 = loss, 1 = win

    print(
        "INSERT INTO bet (amount, playerEmail, dateTimePlaced, sessionDateTime, dealerNo, outcome) "
        f"VALUES ({amount:.2f}, '{email}', '{fmt_dt(bet_dt)}', "
        f"'{fmt_dt(session_dt)}', {dealer_no}, {outcome});"
    )

print("-- END OF DATA")
