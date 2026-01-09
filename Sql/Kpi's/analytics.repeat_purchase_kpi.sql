CREATE OR REPLACE VIEW analytics.repeat_purchase_kpi AS
WITH customer_orders AS (
	SELECT 
		customer_unique_id,
		COUNT(DISTINCT order_id) AS order_count
	FROM analytics.fact_sales
	GROUP BY customer_unique_id

)
SELECT
	COUNT(*) AS total_customers,
	SUM(CASE WHEN order_count > 1 THEN 1 ELSE 0 END) AS repeat_customers,
	ROUND(
		100.0 * SUM(CASE WHEN order_count > 1 THEN 1 ELSE 0 END) /COUNT (*),
		2
	) AS repeat_purchase_rate_pct
FROM customer_orders;

SELECT * FROM analytics.repeat_purchase_kpi;
