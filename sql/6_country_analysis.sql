SELECT
    countryfull AS country,
    EXTRACT(YEAR FROM orderdate) AS purchase_year,
    SUM(total_net_revenue) AS net_revenue
FROM cohort_analysis
WHERE EXTRACT(YEAR FROM orderdate) IN (2019, 2020, 2022, 2023)
GROUP BY
    countryfull,
    EXTRACT(YEAR FROM orderdate)
ORDER BY
    purchase_year,
    country;
