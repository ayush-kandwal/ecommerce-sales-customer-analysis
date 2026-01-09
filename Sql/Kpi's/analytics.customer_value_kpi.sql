CREATE OR REPLACE VIEW analytics.customer_value_kpi AS
SELECT
	customer_unique_id,
	COUNT(DISTINCT order_id) AS total_order,
	SUM(revenue) AS total_revenue,
	ROUND(SUM(revenue)/COUNT(DISTINCT order_id), 2) AS avg_order_value
FROM analytics.fact_sales
GROUP BY customer_unique_id
ORDER BY total_revenue DESC;

SELECT * FROM analytics.customer_value_kpi;

SELECT
    COUNT(*) AS total_customers,
    SUM(total_revenue) AS summed_revenue
FROM analytics.customer_value_kpi;
