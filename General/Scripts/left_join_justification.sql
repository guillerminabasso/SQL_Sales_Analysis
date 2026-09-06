SELECT COUNT(*) 
FROM sales s
LEFT JOIN customer c ON s.customerkey = c.customerkey
WHERE c.customerkey IS NULL;