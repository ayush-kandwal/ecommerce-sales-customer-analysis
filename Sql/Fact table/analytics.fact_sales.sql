CREATE OR REPLACE  VIEW analytics.fact_sales AS
SELECT
	o.order_id,
	o.order_purchase_timestamp,
	DATE_TRUNC('month', o.order_purchase_timestamp) AS order_month,

	c.customer_unique_id,
	c.customer_state,

	oi.product_id,
	COALESCE(p.product_category_name, 'unknown') AS product_category_name,

	oi.price AS revenue,
	oi.freight_value,

	s.seller_id,
	s.seller_state

FROM raw.orders o
JOIN raw.order_items oi
	ON o.order_id = oi.order_id
JOIN raw.customers c
	ON o.customer_id = c.customer_id
LEFT JOIN raw.products p
	ON oi.product_id = p.product_id
LEFT JOIN raw.sellers s
	ON oi.seller_id = s.seller_id

WHERE o.order_status = 'delivered';	

SELECT COUNT(*) FROM analytics.fact_sales;

SELECT * FROM analytics.fact_sales LIMIT 5;

SELECT COUNT(*) AS total_rows
FROM analytics.fact_sales;

SELECT DISTINCT order_id
FROM analytics.fact_sales
LIMIT 5;

--Delivered order check
SELECT order_status
FROM raw.orders
WHERE order_id IN (
	SELECT DISTINCT order_id
	FROM analytics.fact_sales
	LIMIT 5
);

--Revenue sanity check
SELECT
    MIN(revenue) AS min_revenue,
    MAX(revenue) AS max_revenue
FROM analytics.fact_sales;

SELECT 
	product_category_name,
	COUNT(*) AS cnt
FROM analytics.fact_sales
GROUP BY product_category_name
ORDER BY cnt DESC
LIMIT 10;

SELECT 
	COUNT(DISTINCT customer_unique_id) AS unique_customers,
	COUNT(DISTINCT order_id) AS total_orders
FROM analytics.fact_sales;	