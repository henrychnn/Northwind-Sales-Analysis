-- =====================================================================
-- NORTHWIND SALES ANALYSIS
-- =====================================================================


-- =====================================================================
-- 1. DATA OVERVIEW
-- =====================================================================

SELECT COUNT(*)
FROM Customer;

SELECT COUNT(*)
FROM product;

SELECT COUNT(*)
FROM SalesOrder;

SELECT COUNT(*)
FROM OrderDetail;

SELECT
	MIN(orderdate) AS earliest_order,
    MAX(orderdate) AS latest_order
FROM salesorder;



-- =====================================================================
-- 2. CUSTOMER ANALYSIS
-- =====================================================================

-- Number of Orders by Customer

SELECT custID, 
COUNT(*) AS order_count
FROM Salesorder
GROUP BY custID
ORDER BY order_count DESC;




-- Total Revenue by Customer

SELECT 
	s.custID,
    SUM(o.unitprice * o.quantity * (1-o.discount)) AS customer_revenue
FROM salesorder s
JOIN orderdetail o
	ON s.orderID = o.orderID
GROUP BY s.custID
ORDER BY customer_revenue DESC;



-- Customer performance summary 
-- Order Count, Total Revenue, and Average Order Value by Customer

SELECT 
	custID,
    COUNT(*) AS order_count,
    SUM(order_revenue) AS total_revenue,
    AVG(order_revenue) AS avg_order_revenue
FROM (
SELECT
	s.custID,
    o.orderID,
    SUM(o.unitprice * o.quantity * (1-o.discount)) AS order_revenue
FROM salesorder s
JOIN orderdetail o
	ON s.orderID = o.orderID
GROUP BY s.custID, o.orderID
) AS order_revenue_total
GROUP BY custID
ORDER BY total_revenue DESC;



-- Customers With No Orders

SELECT c.custID, c.companyname
FROM Customer c
LEFT JOIN SalesOrder s
	ON c.custID=s.custID
WHERE s.orderID is NULL;



-- =====================================================================
-- 3. PRODUCT & CATEGORY ANALYSIS
-- =====================================================================

-- Total Revenue by Product

SELECT 
	p.productID,
	p.productname,
	SUM(o.unitprice * o.quantity * (1-o.discount)) AS product_revenue
FROM product p
JOIN orderdetail o
	ON p.productID=o.productID
GROUP BY p.productID, p.productname
ORDER BY product_revenue DESC;



-- Total Revenue By Category

SELECT 
	c.categoryname,
	SUM(o.unitprice * o.quantity * (1-o.discount)) as category_revenue
FROM orderdetail o
JOIN product p
	ON o.productID=p.productID
JOIN category c
	on p.categoryID=c.categoryID
GROUP BY c.categoryname
ORDER BY category_revenue DESC;



-- Total Units Sold by Product

SELECT 
	o.productID,
	p.productname,
    SUM(o.quantity) AS total_units_sold
FROM orderdetail o
JOIN product p
	ON o.productID = p.productID
GROUP BY o.productID, p.productname
ORDER BY total_units_sold DESC;



-- =====================================================================
-- 4.  GEOGRAPHIC ANALYSIS
-- =====================================================================

-- Total Revenue by Shipping Country

SELECT s.shipcountry,
	SUM(unitprice * quantity * (1-discount)) AS country_revenue
FROM orderdetail o
JOIN salesorder s
	ON o.orderid=s.orderid
GROUP BY s.shipcountry
ORDER BY country_revenue DESC;



-- =====================================================================
-- 5. SALES TRENDS
-- =====================================================================

-- Monthly Revenue

SELECT 
	YEAR(s.orderdate) AS year, 
    MONTH(s.orderdate) AS month,
	SUM(o.unitprice * o.quantity * (1-o.discount)) AS monthly_revenue
FROM orderdetail o
JOIN salesorder s
	ON o.orderid=s.orderid
GROUP BY year, month
ORDER BY monthly_revenue DESC;



-- Yearly Revenue

SELECT 
	YEAR(s.orderdate) AS year,
	SUM(o.unitprice * o.quantity * (1-o.discount)) AS yearly_revenue
FROM orderdetail o
JOIN salesorder s
	ON o.orderid=s.orderid
GROUP BY year
ORDER BY year;



-- Month-over-month Revenue Change

SELECT 
	year,
    month,
    monthly_revenue,
    LAG(monthly_revenue) OVER (ORDER BY year, month) AS previous_revenue,
    Monthly_revenue - LAG(monthly_revenue) OVER (ORDER BY year, month) AS revenue_change,
    (
    (monthly_revenue - LAG(monthly_revenue) OVER (ORDER BY year, month)) 
    /
    LAG(monthly_revenue) OVER (ORDER BY year, month)
    ) * 100 AS percent_change
FROM 
(
SELECT YEAR(s.orderdate) AS year, MONTH(s.orderdate) AS month,
	SUM(o.unitprice * o.quantity * (1-o.discount)) AS monthly_revenue
FROM orderdetail o
JOIN salesorder s
	ON o.orderid=s.orderid
GROUP BY year, month
) AS monthly_sales
ORDER BY year, month;
