
Approach to Assessment-Q1
- I identified customers with funded savings accounts (confirmed_amount > 0) and funded investment plans (if_a_fund = 1 and confirmed_amount > 0).
- Aggregated counts and total deposits from both savings and investments.
- Joined the results on owner_id and include user details.

Approach to Assessment_Q2
- Calculated monthly transaction counts per customer.
- Computed the average transactions per month for each customer.
- Categorized customers based on their average transaction frequency.

Approach to Assessment_Q3
- Identified savings accounts and investment plans with no transactions in the last 365 days.
- Used UNION ALL to combine results from both tables.

Approach to Assessment_Q4
- Calculated account tenure in months.
- Summed the total transactions and computed customer lifetime valuation (CLV) using the provided formula.

Challenges Faced
1. Handling Kobo to Currency Conversion: Assumed amounts were in base currency due to lack of detailed conversion requirements.
2. Accurate Date Calculations: I used PostgreSQL date functions to accurately compute tenure and inactivity periods.
3. Query Optimization: I utilized CTEs and subqueries to improve readability and performance.
