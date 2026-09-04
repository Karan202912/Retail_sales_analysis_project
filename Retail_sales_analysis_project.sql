-- ============================================================
-- RETAIL SALES ANALYSIS - PostgreSQL
-- Portfolio Project
-- ============================================================

-- 1. DATABASE SETUP
CREATE DATABASE retail_sales_analysis;

-- 2. TABLE DESIGN
CREATE TABLE retail_sales_analysis (
    transactions_id INT PRIMARY KEY,
    sale_date DATE,
    sale_time TIME,
    customer_id INT,
    gender VARCHAR(16),
    age INT,
    category VARCHAR(16),
    quantity INT,
    price_per_unit NUMERIC(10,2),
    cogs NUMERIC(10,2),
    total_sale NUMERIC(12,2)
);

-- 3. DATA CHECK
SELECT *
FROM retail_sales_analysis;

SELECT COUNT(*) AS total_transactions
FROM retail_sales_analysis;

-- 4. DATA QUALITY CHECK
SELECT *
FROM retail_sales_analysis
WHERE transactions_id IS NULL
   OR sale_date IS NULL
   OR sale_time IS NULL
   OR customer_id IS NULL
   OR gender IS NULL
   OR age IS NULL
   OR category IS NULL
   OR quantity IS NULL
   OR price_per_unit IS NULL
   OR cogs IS NULL
   OR total_sale IS NULL;

-- If the project requirement is to remove incomplete records:
DELETE FROM retail_sales_analysis
WHERE transactions_id IS NULL
   OR sale_date IS NULL
   OR sale_time IS NULL
   OR customer_id IS NULL
   OR gender IS NULL
   OR age IS NULL
   OR category IS NULL
   OR quantity IS NULL
   OR price_per_unit IS NULL
   OR cogs IS NULL
   OR total_sale IS NULL;

-- Verify the cleaned row count
SELECT COUNT(*) AS cleaned_transactions
FROM retail_sales_analysis;

-- 5. BASIC EXPLORATION

-- Number of unique customers
SELECT COUNT(DISTINCT customer_id) AS unique_customers
FROM retail_sales_analysis;

-- Available product categories
SELECT DISTINCT category
FROM retail_sales_analysis
ORDER BY category;

-- Overall revenue, cost and profit
SELECT
    ROUND(SUM(total_sale), 2) AS total_revenue,
    ROUND(SUM(cogs), 2) AS total_cost,
    ROUND(SUM(total_sale - cogs), 2) AS total_profit
FROM retail_sales_analysis;

-- 6. BUSINESS ANALYSIS

-- Q1. Which customers have the highest number of transactions?
SELECT
    customer_id,
    COUNT(*) AS transaction_count,
    ROUND(SUM(total_sale), 2) AS customer_revenue
FROM retail_sales_analysis
GROUP BY customer_id
ORDER BY transaction_count DESC, customer_revenue DESC
LIMIT 10;


-- Q2. How much profit does each category generate?
SELECT
    category,
    ROUND(SUM(total_sale), 2) AS revenue,
    ROUND(SUM(cogs), 2) AS cost,
    ROUND(SUM(total_sale - cogs), 2) AS profit
FROM retail_sales_analysis
GROUP BY category
ORDER BY profit DESC;


-- Q3. What is the average profit per transaction by category?
SELECT
    category,
    ROUND(AVG(total_sale - cogs), 2) AS avg_profit_per_transaction
FROM retail_sales_analysis
GROUP BY category
ORDER BY avg_profit_per_transaction DESC;


-- Q4. Which customers purchase from multiple categories?
SELECT
    customer_id,
    COUNT(DISTINCT category) AS categories_purchased
FROM retail_sales_analysis
GROUP BY customer_id
HAVING COUNT(DISTINCT category) > 1
ORDER BY categories_purchased DESC, customer_id;


-- Q5. Which category sells the most units?
SELECT
    category,
    SUM(quantity) AS units_sold
FROM retail_sales_analysis
GROUP BY category
ORDER BY units_sold DESC
LIMIT 1;


-- Q6. What is the profit margin of each category?
SELECT
    category,
    ROUND(
        (SUM(total_sale - cogs) / NULLIF(SUM(total_sale), 0)) * 100,
        2
    ) AS profit_margin_percent
FROM retail_sales_analysis
GROUP BY category
ORDER BY profit_margin_percent DESC;


-- Q7. What is the average quantity purchased by gender?
SELECT
    gender,
    ROUND(AVG(quantity), 2) AS avg_quantity_per_transaction,
    COUNT(*) AS transactions
FROM retail_sales_analysis
GROUP BY gender
ORDER BY avg_quantity_per_transaction DESC;


-- Q8. Which weekday produces the highest revenue?
SELECT
    TRIM(TO_CHAR(sale_date, 'Day')) AS weekday,
    ROUND(SUM(total_sale), 2) AS revenue
FROM retail_sales_analysis
GROUP BY TRIM(TO_CHAR(sale_date, 'Day'))
ORDER BY revenue DESC
LIMIT 1;


-- Q9. How many customers belong to each spending segment?
WITH customer_value AS (
    SELECT
        customer_id,
        SUM(total_sale) AS total_spending
    FROM retail_sales_analysis
    GROUP BY customer_id
)
SELECT
    CASE
        WHEN total_spending < 5000 THEN 'Low'
        WHEN total_spending <= 10000 THEN 'Medium'
        ELSE 'High'
    END AS spending_segment,
    COUNT(*) AS customers
FROM customer_value
GROUP BY spending_segment
ORDER BY customers DESC;


-- Q10. Which transactions have an above-average unit price?
SELECT
    transactions_id,
    customer_id,
    category,
    price_per_unit,
    quantity,
    total_sale
FROM retail_sales_analysis
WHERE price_per_unit > (
    SELECT AVG(price_per_unit)
    FROM retail_sales_analysis
)
ORDER BY price_per_unit DESC;


-- 7. ADDITIONAL ORIGINAL ANALYSIS

-- Q11. What is the monthly revenue trend?
SELECT
    DATE_TRUNC('month', sale_date)::DATE AS sales_month,
    ROUND(SUM(total_sale), 2) AS monthly_revenue
FROM retail_sales_analysis
GROUP BY sales_month
ORDER BY sales_month;


-- Q12. Which category contributes the largest share of total revenue?
SELECT
    category,
    ROUND(SUM(total_sale), 2) AS category_revenue,
    ROUND(
        SUM(total_sale) * 100.0 /
        NULLIF((SELECT SUM(total_sale) FROM retail_sales_analysis), 0),
        2
    ) AS revenue_share_percent
FROM retail_sales_analysis
GROUP BY category
ORDER BY category_revenue DESC;


-- Q13. Which customers generated the highest profit?
SELECT
    customer_id,
    ROUND(SUM(total_sale - cogs), 2) AS customer_profit,
    COUNT(*) AS transactions
FROM retail_sales_analysis
GROUP BY customer_id
ORDER BY customer_profit DESC
LIMIT 10;


-- Q14. What is the average order value by category?
SELECT
    category,
    ROUND(AVG(total_sale), 2) AS average_order_value
FROM retail_sales_analysis
GROUP BY category
ORDER BY average_order_value DESC;


-- Q15. What percentage of transactions are high-value transactions?
WITH transaction_summary AS (
    SELECT
        transactions_id,
        total_sale
    FROM retail_sales_analysis
)
SELECT
    COUNT(*) FILTER (WHERE total_sale > 5000) AS high_value_transactions,
    COUNT(*) AS all_transactions,
    ROUND(
        COUNT(*) FILTER (WHERE total_sale > 5000) * 100.0 /
        NULLIF(COUNT(*), 0),
        2
    ) AS high_value_transaction_percent
FROM transaction_summary;

-- ============================================================
-- END OF RETAIL SALES ANALYSIS
-- ============================================================
