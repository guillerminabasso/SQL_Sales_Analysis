WITH customers_per_cohort AS (
    SELECT
        EXTRACT(YEAR FROM first_purchase_date) AS cohort_year,
        EXTRACT(MONTH FROM first_purchase_date) AS cohort_month,
        COUNT(DISTINCT customerkey) AS total_new_customers,
        SUM(total_net_revenue) AS net_revenue
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
LEFT JOIN customers_per_year cy 
	ON cc.cohort_year = cy.purchase_year 
	AND cc.cohort_month = cy.purchase_month

	