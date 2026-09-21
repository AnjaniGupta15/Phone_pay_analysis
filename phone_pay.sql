SELECT * FROM phonepe_analysis.all_transaction;
-- 1.Total Transactions
SELECT COUNT(*) AS total_transactions
FROM all_transaction;
-- 2. Total Transaction Value
SELECT ROUND(SUM(Amount), 2) AS total_value
FROM all_transaction;
-- 3. Average Transaction Value
SELECT ROUND(AVG(Amount), 2) AS average_value
FROM all_transaction;
-- 4. Payment Status Analysis
SELECT Payment_Status, COUNT(*) AS transactions
FROM all_transaction
GROUP BY Payment_Status;
-- 5. Success Rate ⭐
SELECT ROUND(
    100.0 * SUM(Payment_Status = 'Successful') / COUNT(*), 2
) AS success_rate
FROM all_transaction;
-- 6. Service-wise Analysis ⭐
SELECT
    Service,
    COUNT(*) AS transactions,
    ROUND(SUM(Amount), 2) AS total_value
FROM all_transaction
GROUP BY Service
ORDER BY total_value DESC;
-- 7. Monthly Transaction Trend ⭐
SELECT
    DATE_FORMAT(`Date`, '%Y-%m') AS month,
    COUNT(*) AS transactions,
    ROUND(SUM(Amount), 2) AS total_value
FROM all_transaction
GROUP BY month
ORDER BY month;
-- 8. Top 10 Users by Value ⭐
SELECT
    User_ID,
    COUNT(*) AS transactions,
    ROUND(SUM(Amount), 2) AS total_value
FROM all_transaction
GROUP BY User_ID
ORDER BY total_value DESC
LIMIT 10;
ALTER TABLE all_transaction
CHANGE COLUMN `ï»¿Transaction_ID` Transaction_ID VARCHAR(50);
-- 10User + Transaction JOIN
SELECT
    u.User_ID,
    u.Name,
    COUNT(t.Transaction_ID) AS transactions,
    ROUND(SUM(t.Amount), 2) AS total_value
FROM all_users u
JOIN all_transaction t
    ON u.User_ID = t.User_ID
GROUP BY u.User_ID, u.Name
ORDER BY total_value DESC
LIMIT 10;
-- 10users and their transaction details using User_ID
SELECT
    t.Transaction_ID,
    t.User_ID,
    u.Name,
    t.Amount,
    t.Service,
    t.Payment_Status,
    t.Date
FROM all_transaction t
JOIN all_users u
    ON t.User_ID = u.User_ID
LIMIT 10;
