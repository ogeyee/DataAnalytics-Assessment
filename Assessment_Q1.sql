SELECT
    u.id AS owner_id,
    u.name,
    COUNT(DISTINCT s.id) AS savings_count,
    COUNT(DISTINCT p.id) AS investment_count,
    ROUND(SUM(IFNULL(s.confirmed_amount, 0) + IFNULL(p.confirmed_amount, 0)) / 100, 2) AS total_deposits
FROM users_customuser u
    LEFT JOIN savings_savingsaccount s
    ON u.id = s.owner_id AND s.is_regular_savings = 1 AND s.confirmed_amount > 0
    LEFT JOIN plans_plan p
    ON u.id = p.owner_id AND p.is_a_fund = 1 AND p.confirmed_amount > 0
GROUP BY u.id, u.name
HAVING savings_count > 0 AND investment_count > 0
ORDER BY total_deposits DESC;
