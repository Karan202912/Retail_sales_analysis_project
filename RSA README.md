# Retail Sales Analysis - SQL Portfolio Project

This is a PostgreSQL project where I analyzed retail sales data using SQL. I also built a Power BI dashboard on the same data.

![Dashboard](dashboard/RSA_DASHBOARD_preview.png)

I worked on the dataset to understand sales, profit, customer spending, categories, and monthly sales trends. I also cleaned the data before running the analysis.

## Tools Used

- PostgreSQL
- pgAdmin
- Power BI

## Dataset

The project uses one main table called `retail_sales_analysis`.

| Column           | Description                    |
| ---------------- | ------------------------------ |
| transactions_id  | Unique ID for each transaction |
| sale_date        | Date of the sale               |
| sale_time        | Time of the sale               |
| customer_id      | Customer ID                    |
| gender           | Customer gender                |
| age              | Customer age                   |
| category         | Product category               |
| quantity         | Number of units sold           |
| price_per_unit   | Price of one unit              |
| cogs             | Cost of goods sold             |
| total_sale       | Total sale amount              |

### Dataset Details

- Raw transactions: 2,000
- Transactions after cleaning: 1,996
- Unique customers: 495
- Categories: Beauty, Clothing, Electronics, Home, Sports

## Project Steps

### 1. Database and Table Setup

Created the database and `retail_sales_analysis` table in PostgreSQL.

### 2. Data Check

Checked the table and counted the total number of records.

### 3. NULL Check

Checked all columns for missing values.

4 incomplete records were found with missing values. These records were removed before doing the main analysis.

### 4. Basic Data Exploration

Checked:

- Number of unique customers
- Product categories
- Total revenue
- Total cost
- Total profit

### 5. Sales Analysis

After cleaning the data, I worked on 15 SQL questions related to customers, categories, revenue, profit, spending, and sales trends.

### 6. Dashboard

I built a Power BI dashboard on the cleaned data (see the Dashboard section below).

## SQL Concepts Used

- SELECT
- WHERE
- GROUP BY
- HAVING
- ORDER BY
- LIMIT
- SUM()
- AVG()
- COUNT()
- COUNT(DISTINCT)
- CASE
- CTEs
- Subqueries
- NULLIF()
- FILTER
- DATE_TRUNC()
- TO_CHAR()

## Business Questions

### Q1. Which customers have the highest number of transactions?

Shows the top 10 customers based on transaction count along with their total revenue.

### Q2. Which category generates the highest profit?

Calculates total profit for each category.

### Q3. What is the average profit per transaction for each category?

Finds the average profit generated from each transaction by category.

### Q4. Which customers have purchased from more than one category?

Finds customers who have bought products from multiple categories.

### Q5. Which category sold the most units?

Compares total quantity sold across categories.

### Q6. What is the profit margin for each category?

Calculates profit margin using profit and revenue.

### Q7. What is the average quantity purchased by each gender?

Compares the average quantity per transaction for each gender.

### Q8. Which day of the week has the highest revenue?

Groups sales by weekday and compares total revenue.

### Q9. How can customers be divided into spending groups?

Customers are grouped into:

- Low: below ₹1,000
- Medium: ₹1,000 to ₹3,000
- High: above ₹3,000

### Q10. Which transactions have a price per unit above the average?

Finds transactions where the unit price is higher than the overall average unit price.

### Q11. What is the monthly revenue trend?

Groups revenue by month to see how sales change over time.

### Q12. What percentage of total revenue comes from each category?

Calculates the revenue contribution of each category.

### Q13. Which customers generate the highest profit?

Finds customers with the highest total profit.

### Q14. What is the average transaction value for each category?

Calculates the average `total_sale` for each category.

### Q15. What percentage of transactions are above ₹2,000?

Checks the percentage of transactions where `total_sale` is greater than ₹2,000.

## Sample Results

Some results from the analysis:

- Total revenue: ₹8,48,740.87
- Total cost: ₹2,30,618.48
- Total profit: ₹6,18,122.39
- Electronics generated the highest profit: ₹3,00,711
- Electronics contributed 48.73% of total revenue
- Clothing had the highest profit margin: 74.15%
- Electronics had a profit margin of 72.71%
- Clothing sold the highest number of units: 1,463
- Wednesday had the highest revenue: ₹1,31,192.72
- Customer 1153 had 11 transactions and generated ₹7,967.94

### Spending Groups

Using the ₹1,000 and ₹3,000 limits:

- Medium: 235 customers
- Low: 184 customers
- High: 76 customers

I first tried ₹5,000 and ₹10,000 as the limits, but no customer crossed ₹10,000 (the highest customer spending was ₹7,967.94), so I lowered them.

### High-Value Transactions

58 of the 1,996 transactions (2.91%) are above ₹2,000. I first tried ₹5,000, but the highest transaction amount was ₹4,491.40, so nothing crossed that limit.

## Dashboard

I made a Power BI dashboard from the same data. At the top there are four cards: total sales (848.74K), total transactions (1,996), average order value (425.22) and gross margin (72.83%). Below them are a monthly sales line, a chart of average order value by age group and gender, and sales and profit by category. The slicers on the right filter by category, date, gender and age group.

A few things the dashboard shows:

- Electronics is the biggest category, with about 48% of total sales.
- December is the best month, at around 98K.
- Women have the higher average order value in four of the five age groups. Only in the 56+ group are men ahead.

The margin on the dashboard is a gross margin (sales minus cogs, divided by sales), so rent, salaries and other running costs are not counted in it.

## How to Run

1. Open PostgreSQL or pgAdmin.
2. Open `sql/Retail_sales_analysis_project.sql`.
3. Run the database and table creation queries.
4. Import `Retail_sales_analysis.csv` into the table.
5. Run the NULL check.
6. Run the cleaning query.
7. Run the basic exploration queries.
8. Run Q1 to Q15.

To look at the dashboard, open `dashboard/RSA_DASHBOARD.pbix` in Power BI Desktop.

## Possible Improvements

Some things I can add later:

- Add more tables and practice JOINs
- Add product-level information
- Create views for commonly used analysis

## Files

- `sql/Retail_sales_analysis_project.sql` - SQL queries and analysis
- `Retail_sales_analysis.csv` - Dataset
- `dashboard/RSA_DASHBOARD.pbix` - Power BI dashboard
- `dashboard/RSA_DASHBOARD.pdf` - PDF export of the dashboard
- `dashboard/RSA_DASHBOARD_preview.png` - Dashboard preview image

## Project Goal

The main goal of this project was to practice SQL on a retail dataset and understand how SQL can be used to answer basic business questions about sales, customers, revenue, and profit.
