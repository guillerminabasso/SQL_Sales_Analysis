SELECT
	EXTRACT(YEAR FROM orderdate) AS year_purchase,
	SUM(quantity * netprice * exchangerate) AS net_revenue,
	COUNT(DISTINCT customerkey) AS total_customers,
	SUM(quantity * netprice * exchangerate) / COUNT(DISTINCT customerkey) AS revenue_per_customer
FROM sales
GROUP BY year_purchase
ORDER BY year_purchase