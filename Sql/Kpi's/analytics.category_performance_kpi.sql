CREATE OR REPLACE VIEW analytics.category_performance_kpi AS
SELECT 
	product_category_name,
	COUNT(DISTINCT order_id) AS total_order,
	SUM(revenue) AS total_revenue,
	ROUND(SUM(revenue)/COUNT(DISTINCT order_id),2) AS avg_order_value
FROM analytics.fact_sales
GROUP BY product_category_name
ORDER BY total_revenue DESC;

SELECT * FROM analytics.category_performance_kpi;