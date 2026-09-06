WITH customers_per_cohort AS (
    SELECT
        EXTRACT(YEAR FROM first_purchase_date) AS cohort_year,
        EXTRACT(MONTH FROM first_purchase_date) AS cohort_month,
        COUNT(DISTINCT customerkey) AS total_new_customers
    FROM cohort_analysis
    GROUP BY
        EXTRACT(YEAR FROM first_purchase_date),
        EXTRACT(MONTH FROM first_purchase_date)
)

SELECT 
    cc.cohort_year AS year,
    cc.cohort_month AS month,
    cc.total_new_customers AS new_customers,
    cy.total_customers - cc.total_new_customers AS existing_customers
FROM customers_per_cohort cc
INNER JOIN customers_per_year cy 
    ON cc.cohort_year = cy.purchase_year 
    AND cc.cohort_month = cy.purchase_month
WHERE cc.cohort_year IN (2019, 2020, 2022, 2023)
ORDER BY year, month;