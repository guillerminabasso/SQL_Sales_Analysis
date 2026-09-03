SELECT
    TO_CHAR(orderdate, 'YYYY-MM') AS year_month,
    SUM(quantity * netprice * exchangerate) AS net_revenue
FROM sales
GROUP BY year_month
ORDER BY year_month;
