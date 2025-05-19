WITH user_tenure AS (
    SELECT 
        id,
        name,
        created_at,
        (EXTRACT(YEAR FROM AGE(CURRENT_DATE, created_at)) * 12 
            + EXTRACT(MONTH FROM AGE(CURRENT_DATE, created_at)) 
            )    AS tenure_months
    FROM users_customuser
)
SELECT 
    ut.id AS customer_id,
    ut.name,
    ut.tenure_months,
    COUNT(s.id) AS total_transactions,
    ROUND(
        COALESCE(SUM(s.confirmed_amount), 0) * 0.001 * (12 / ut.tenure_months), 
        2
    ) AS estimated_clv  
FROM user_tenure ut  
LEFT JOIN savings_savingsaccount s ON ut.id = s.owner_id
WHERE ut.tenure_months > 0
GROUP BY ut.id, ut.name, ut.tenure_months
ORDER BY estimated_clv DESC;