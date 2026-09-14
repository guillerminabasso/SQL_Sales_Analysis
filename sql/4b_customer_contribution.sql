WITH monthly_revenue AS (
    SELECT
        EXTRACT(YEAR FROM orderdate) AS year,
        EXTRACT(MONTH FROM orderdate) AS month,
        
        SUM(
            CASE 
                WHEN cohort_year = EXTRACT(YEAR FROM orderdate)
                THEN total_net_revenue
                ELSE 0
            END
        ) AS new_customers_revenue,
        
        SUM(
            CASE 
                WHEN cohort_year < EXTRACT(YEAR FROM orderdate)
                THEN total_net_revenue
                ELSE 0
            END
        ) AS existing_customers_revenue,
        
        SUM(total_net_revenue) AS total_revenue
        
    FROM cohort_analysis
    GROUP BY
        EXTRACT(YEAR FROM orderdate),
        EXTRACT(MONTH FROM orderdate)
)

SELECT
    year,
    month,
    new_customers_revenue,
    existing_customers_revenue,
    total_revenue,

    ROUND(
        (
            new_customers_revenue / NULLIF(total_revenue, 0) * 100
        )::numeric,
        2
    ) AS new_customers_revenue_percentage,

    ROUND(
        (
            existing_customers_revenue / NULLIF(total_revenue, 0) * 100
        )::numeric,
        2
    ) AS existing_customers_revenue_percentage

FROM monthly_revenue
ORDER BY year, month;