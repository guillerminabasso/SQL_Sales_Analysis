WITH params AS (
    SELECT 2019 AS target_year
),

existing_customers AS (

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
)

SELECT
    cohort_year,
    month,
    total_existing_customers,
    existing_customers_revenue,
    SUM(existing_customers_revenue) OVER() AS total_existing_cust_revenue,

    ROUND(
        CAST(
            (existing_customers_revenue / SUM(existing_customers_revenue) OVER()) * 100
            AS NUMERIC
        ),
        2
    ) AS cohort_revenue_percentage

FROM existing_customers

ORDER BY cohort_revenue_percentage DESC;