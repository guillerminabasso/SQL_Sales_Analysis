SELECT
	EXTRACT(YEAR FROM orderdate) AS year_purchase,
	SUM(quantity * netprice * exchangerate) AS net_revenue
FROM sales
GROUP BY year_purchase
ORDER BY year_purchase ASC
