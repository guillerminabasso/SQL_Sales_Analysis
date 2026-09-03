SELECT 
	COUNT(DISTINCT customerkey) AS total_customers,
	EXTRACT(YEAR FROM orderdate) AS purchase_year
FROM sales
GROUP BY purchase_year
ORDER BY purchase_year ASC