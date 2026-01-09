CREATE OR REPLACE VIEW analytics.regional_demand_supply_kpi AS
WITH demand AS (
	SELECT
		customer_state AS state,
		COUNT(DISTINCT order_id) AS total_orders
	FROM analytics.fact_sales
	GROUP BY customer_state	
),
supply AS (
	SELECT
		seller_state AS state,
		COUNT(DISTINCT seller_id) AS total_sellers
	FROM raw.sellers
	GROUP BY seller_state
	
)
SELECT 
	COALESCE(d.state, s.state) AS state,
	COALESCE(d.total_orders, 0) AS total_orders,
	COALESCE(s.total_sellers, 0) AS total_sellers
FROM demand d
FULL OUTER JOIN supply s
	ON d.state = s.state
ORDER BY total_orders DESC;	

SELECT * 
FROM analytics.regional_demand_supply_kpi
LIMIT 10;
