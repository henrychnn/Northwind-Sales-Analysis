# Northwind Sales Analysis



## Project Overview

This project analyzes the Northwind sales database using MySQL to identify trends in customer behavior, product performance, geographic sales, and revenue over time.



## Dataset / Setup

This project uses the Northwind sample database.

To run the analysis:
1. Run `Northwind.sql` in MySQL Workbench to create and populate the database.
2. Open `Northwind_Analysis_Final.sql`
3. Run the analysis queries against the Northwind schema.



## Tools Used

- MySQL
- MySQL Workbench



## Analysis Performed

- Customer order frequency
- Customer revenue and average order value
- Product and category revenue
- Product sales volume
- Revenue by shipping country
- Monthly and yearly revenue trends
- Month-over-month revenue change



## Key Insights

- Customer 63 generated the highest total revenue at approximately $110,277.
- Customer 71 placed the most orders with 31 total orders.
- Customer 63 also had the highest average order value at approximately $3,938 per order.
- Beverages generated the highest category revenue at approximately $267,868.
- Product QDOMO generated the highest product revenue at approximately $141,397.
- Product WHBYK sold the most units with 1,577 units sold.
- The USA generated the highest revenue by shipping country at approximately $245,585.
- December 2007 had the largest month-over-month revenue increase at approximately 64%.



## Data Notes

- This dataset begins on July 4, 2006 and ends on May 6, 2008
- Because of this, 2006 and 2008 are partial years.
- May 2008 is also a partial month, so month-over-month comparisons involving May 2008 should be interpreted carefully.
- Revenue was calculated using unit price, quantity, and discount from the OrderDetail table.



## SQL Skills Demonstrated
- SELECT statements and filtering
- Aggregate functions including COUNT, SUM, AVG, MIN, and MAX
- GROUP BY and ORDER BY
- INNER JOIN and LEFT JOIN
- Subqueries
- Window functions using LAG()
- Date functions including YEAR() and MONTH()
- Revenue calculations using price, quantity, and discount
- Customer, product, geographic, and time-series analysis
