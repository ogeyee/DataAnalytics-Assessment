WITH monthly_transactions AS (
    SELECT 
        owner_id,
        EXTRACT(YEAR FROM transaction_date) AS year,
        EXTRACT(MONTH FROM transaction_date) AS month,
        COUNT(*) AS transactions
    FROM savings_savingsaccount
    GROUP BY owner_id, year, month
),
customer_avg AS (
    SELECT 
        owner_id,
        AVG(transactions) AS avg_transactions
    FROM monthly_transactions
    GROUP BY owner_id
),
categories AS (
    SELECT 
        owner_id,
        CASE 
            WHEN avg_transactions >= 10 THEN 'High Frequency'
            WHEN avg_transactions >= 3 THEN 'Medium Frequency'
            ELSE 'Low Frequency'
        END AS frequency_category,
        avg_transactions
    FROM customer_avg
)
SELECT 
    frequency_category,
    COUNT(owner_id) AS customer_count,
    ROUND(AVG(avg_transactions), 1) AS avg_transactions_per_month
FROM categories
GROUP BY frequency_category
ORDER BY 
    CASE frequency_category
        WHEN 'High Frequency' THEN 1
        WHEN 'Medium Frequency' THEN 2
        ELSE 3
    END;