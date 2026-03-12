Use banking_project;

-- Total Transactions
SELECT COUNT(*) AS total_transactions
FROM bank_transactions;

-- Total Money Flow
SELECT SUM(amount) AS total_transaction_value
FROM bank_transactions;

-- Debit vs Credit Distribution
SELECT 
    transaction_type,
    COUNT(*) AS transaction_count,
    SUM(amount) AS total_amount
FROM bank_transactions
GROUP BY transaction_type;

-- Branch-wise Transaction Volume
SELECT 
    branch,
    COUNT(*) AS transaction_count,
    SUM(amount) AS total_amount
FROM bank_transactions
GROUP BY branch
ORDER BY total_amount DESC;

-- Monthly Transaction Trend
SELECT 
    DATE_FORMAT(transaction_date, '%Y-%m') AS month,
    COUNT(*) AS transaction_count,
    SUM(amount) AS total_amount
FROM bank_transactions
GROUP BY month
ORDER BY month;


-- Top 10 Highest Value Transactions
SELECT 
    customer_name,
    transaction_type,
    amount,
    branch
FROM bank_transactions
ORDER BY amount DESC
LIMIT 10;
 
-- Top 10 Customers by Total Transaction Amount
SELECT 
    customer_name,
    SUM(amount) AS total_amount
FROM bank_transactions
GROUP BY customer_name
ORDER BY total_amount DESC
LIMIT 10;

-- Most Active Customers (By Number of Transactions)
SELECT 
    customer_name,
    COUNT(*) AS transaction_count
FROM bank_transactions
GROUP BY customer_name
ORDER BY transaction_count DESC
LIMIT 10;

-- Transaction Method Usage Analysis
SELECT 
    transaction_method,
    COUNT(*) AS total_transactions,
    SUM(amount) AS total_amount
FROM bank_transactions
GROUP BY transaction_method
ORDER BY total_transactions DESC;

-- Bank-wise Transaction Summary
SELECT 
    bank_name,
    COUNT(*) AS total_transactions,
    SUM(amount) AS total_amount
FROM bank_transactions
GROUP BY bank_name
ORDER BY total_amount DESC;


-- Daily Average Transaction Amount
SELECT 
    transaction_date,
    AVG(amount) AS avg_daily_amount
FROM bank_transactions
GROUP BY transaction_date
ORDER BY transaction_date;


-- Branches With Total Transaction Value Above 50 Lakhs
SELECT 
    branch,
    SUM(amount) AS total_amount
FROM bank_transactions
GROUP BY branch
HAVING SUM(amount) > 5000000
ORDER BY total_amount DESC;

-- Customers With More Than 20 Transactions
SELECT 
    customer_name,
    COUNT(*) AS transaction_count
FROM bank_transactions
GROUP BY customer_name
HAVING COUNT(*) > 20
ORDER BY transaction_count DESC;

-- Customers With Total Transaction Above 1 Lakh
SELECT 
    customer_name,
    SUM(amount) AS total_amount
FROM bank_transactions
GROUP BY customer_name
HAVING SUM(amount) > 100000
ORDER BY total_amount DESC;

-- High Value Transactions (Above 50,000)
SELECT 
    customer_name,
    transaction_type,
    amount,
    branch
FROM bank_transactions
WHERE amount > 50000
ORDER BY amount DESC;

-- Advanced SQL Analysis
-- Debit vs Credit Percentage Contribution
SELECT 
    transaction_type,
    SUM(amount) AS total_amount,
    ROUND(
        SUM(amount) * 100 / 
        (SELECT SUM(amount) FROM bank_transactions),
        2
    ) AS percentage_contribution
FROM bank_transactions
GROUP BY transaction_type;

-- Monthly Growth Trend (Transaction Count)
SELECT 
    DATE_FORMAT(transaction_date, '%Y-%m') AS month,
    COUNT(*) AS transaction_count
FROM bank_transactions
GROUP BY month
ORDER BY month;

-- Running Total Per Customer (Window Function)
SELECT 
    customer_name,
    transaction_date,
    amount,
    SUM(amount) OVER (
        PARTITION BY customer_name
        ORDER BY transaction_date
    ) AS running_total
FROM bank_transactions;

-- Customers With Balance Above Overall Average
SELECT 
    customer_name,
    balance
FROM bank_transactions
WHERE balance > (
    SELECT AVG(balance)
    FROM bank_transactions
);

-- Most Recent Transaction Per Customer
SELECT 
    customer_name,
    MAX(transaction_date) AS last_transaction_date
FROM bank_transactions
GROUP BY customer_name;








