CREATE OR REPLACE VIEW analytics.monthly_sales_kpi AS 
SELECT 
	order_month,
	COUNT(DISTINCT order_id) AS total_orders,
	COUNT(DISTINCT customer_unique_id) AS total_customers,
	SUM(revenue) AS total_revenue,
	ROUND(SUM(revenue)/ COUNT(DISTINCT order_id),2) AS avg_order_value
FROM analytics.fact_sales
GROUP BY order_month
ORDER BY order_month;

SELECT * 
FROM analytics.monthly_sales_kpi
LIMIT 12;
