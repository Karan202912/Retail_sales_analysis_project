# Retail Sales Analysis — SQL Portfolio Project

A PostgreSQL project analyzing retail transaction data — covering database
design, data cleaning, and 15 business-driven SQL queries around sales,
profitability, and customer behavior.

## Overview

This project simulates a real retail analytics workflow: set up a
transactions database, check and clean the data, then answer business
questions a retail analyst would actually be asked — top customers,
category profitability, spending segments, revenue trends, and more.

**Tool used:** PostgreSQL / pgAdmin

## Dataset

A single transactions table, one row per sale:

| Column | Type | Description |
|---|---|---|
| `transactions_id` | INT (PK) | Unique transaction identifier |
| `sale_date` | DATE | Date of sale |
| `sale_time` | TIME | Time of sale |
| `customer_id` | INT | Customer identifier |
| `gender` | VARCHAR | Customer gender |
| `age` | INT | Customer age |
| `category` | VARCHAR | Product category |
| `quantity` | INT | Units purchased |
| `price_per_unit` | NUMERIC | Price per unit |
| `cogs` | NUMERIC | Cost of goods sold |
| `total_sale` | NUMERIC | Total transaction value |

Dataset: `Retail_sales_analysis.csv` — 2,000 raw transactions, 5
categories (Beauty, Clothing, Electronics, Home, Sports), 495 unique
customers.

## Project Workflow

1. **Database & table setup** — created the database and defined the
   transactions table with appropriate data types and a primary key.
2. **Data quality check** — scanned every column for `NULL` values before
   any analysis, to avoid skewed results. Found 4 incomplete records
   (transaction IDs 57, 421, 1098, 1734) with a missing gender, age,
   category, or quantity value.
3. **Data cleaning** — removed the 4 incomplete records, leaving 1,996
   clean transactions, and verified the row count.
4. **Basic exploration** — unique customers, available categories,
   overall revenue/cost/profit.
5. **Business analysis (15 queries)** — grouped into core questions and
   additional original analysis (see below).

## Key SQL Concepts Used

- Aggregate functions: `SUM`, `AVG`, `COUNT`, `COUNT(DISTINCT ...)`
- `GROUP BY` / `HAVING`
- `CASE` statements for customer segmentation
- **CTEs** (`WITH ...`) for multi-step logic
- **Subqueries** (e.g. comparing each row against the overall average)
- `NULLIF()` to safely avoid divide-by-zero errors in ratio calculations
- PostgreSQL `FILTER (WHERE ...)` clause for conditional aggregation
- Date/time functions: `DATE_TRUNC`, `TO_CHAR` (weekday extraction, monthly trends)
- `ORDER BY` + `LIMIT` for top-N style reporting

## Business Questions Answered

**Core analysis**
1. Which customers have the highest number of transactions?
2. How much profit does each category generate?
3. What is the average profit per transaction by category?
4. Which customers purchase from multiple categories?
5. Which category sells the most units?
6. What is the profit margin of each category?
7. What is the average quantity purchased by gender?
8. Which weekday produces the highest revenue?
9. How many customers fall into each spending segment (Low/Medium/High)?
10. Which transactions have an above-average unit price?

**Additional original analysis**
11. What is the monthly revenue trend?
12. Which category contributes the largest share of total revenue?
13. Which customers generated the highest profit?
14. What is the average order value by category?
15. What percentage of transactions are high-value (> 5000)?

## Sample Insights

*(Computed on the cleaned dataset — 1,996 transactions after removing 4
incomplete records.)*

- **Total revenue:** ₹8,48,740.87 | **Total cost:** ₹2,30,618.48 | **Total profit:** ₹6,18,122.39
- **Top category by profit:** Electronics (₹3,00,711 profit) — also the largest
  revenue contributor at 48.73% of total sales
- **Highest profit margin category:** Clothing (74.15%), closely followed by
  Electronics (72.71%) — margins across categories are fairly tight (72–74%)
- **Category selling the most units:** Clothing (1,463 units), despite
  Electronics generating far more revenue — Clothing sells in higher volume
  at a lower price point
- **Highest revenue weekday:** Wednesday (₹1,31,192.72), followed closely by Thursday
- **Customer spending segments:** 479 Low / 16 Medium / 0 High (using the
  default <5,000 / 5,000–10,000 / >10,000 thresholds) — the entire customer
  base falls under ₹10,000 in total spend, so these thresholds may need to be
  scaled down for this dataset (e.g. <1,000 / 1,000–3,000 / >3,000) to get a
  more meaningful split
- **High-value transactions (> ₹5,000):** 0% — the largest single transaction
  in this dataset is ₹4,491.40, so the >5,000 threshold doesn't apply here;
  a lower threshold (e.g. > ₹1,500) would be more useful for this data
- **Most active customer:** Customer #1153 with 11 transactions totaling ₹7,967.94

## How to Run

1. Install PostgreSQL and pgAdmin (or use any PostgreSQL-compatible client).
2. Open `Retail_sales_analysis_project.sql`.
3. Run the **Database Setup** and **Table Design** sections first.
4. Load `Retail_sales_analysis.csv` into the table (via pgAdmin's Import
   tool, or `COPY retail_sales_analysis FROM 'Retail_sales_analysis.csv'
   DELIMITER ',' CSV HEADER;`).
5. Run the **Data Quality Check** and **Data Cleaning** sections — this
   will remove the 4 incomplete records.
6. Run each numbered business question (Q1–Q15) individually to explore
   the results.

## Possible Next Steps

- Adjust the spending-segment and high-value thresholds (Q9, Q15) to better
  fit this dataset's actual value range, as noted above.
- Add a `products` or `categories` reference table and rewrite key
  queries with `JOIN`s instead of a single flat table.
- Visualize results (category profit, monthly trend, spending segments)
  in Excel or Looker Studio.
- Wrap the most-used queries (e.g. Q2, Q9, Q13) as SQL `VIEW`s for reuse.

## Files

- `Retail_sales_analysis_project.sql` — full script: schema, cleaning, and all 15 queries
- `Retail_sales_analysis.csv` — dataset used for the analysis above (2,000
  raw rows / 1,996 after cleaning)
