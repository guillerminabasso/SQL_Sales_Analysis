WITH params AS (
    SELECT 2019 AS target_year
)

SELECT
    COUNT(DISTINCT c.customerkey) AS total_existing_customers,
    SUM(c.total_net_revenue) AS existing_customers_revenue,
    EXTRACT(MONTH FROM c.orderdate) AS month,
    c.cohort_year

FROM cohort_analysis c
CROSS JOIN params p

WHERE
    c.first_purchase_date < MAKE_DATE(p.target_year, 1, 1)
    AND c.orderdate >= MAKE_DATE(p.target_year, 1, 1)
    AND c.orderdate < MAKE_DATE(p.target_year + 1, 1, 1)

GROUP BY month, c.cohort_year

ORDER BY c.cohort_year, month;"""