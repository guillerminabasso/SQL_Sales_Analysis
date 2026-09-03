SELECT
    EXTRACT(YEAR FROM orderdate) AS year,
    EXTRACT(MONTH FROM orderdate) AS month,
    COUNT(DISTINCT orderkey) AS total_orders,
    SUM(quantity * netprice * exchangerate) AS net_revenue,
    SUM(quantity * netprice * exchangerate)
        / COUNT(DISTINCT orderkey) AS revenue_per_order
FROM sales
GROUP BY year, month
ORDER BY year, month;