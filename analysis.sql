-- ============================================================
-- FOOD DELIVERY CUSTOMER ANALYSIS
-- SQL Analysis using PostgreSQL
-- ============================================================


-- ============================================================
-- 1. TOTAL CUSTOMERS
-- Business Question:
-- How many total customer records are in the dataset?
-- ============================================================

SELECT COUNT(*) AS total_customers
FROM food_delivery;


-- ============================================================
-- 2. CUSTOMER DISTRIBUTION BY GENDER
-- Business Question:
-- How many male and female customers are there?
-- ============================================================

SELECT
    gender,
    COUNT(*) AS customer_count
FROM food_delivery
GROUP BY gender
ORDER BY customer_count DESC;


-- ============================================================
-- 3. CUSTOMER DISTRIBUTION BY CUSTOMER TYPE
-- Business Question:
-- How many Regular, Frequent and New customers are there?
-- ============================================================

SELECT
    customer_type,
    COUNT(*) AS customer_count
FROM food_delivery
GROUP BY customer_type
ORDER BY customer_count DESC;


-- ============================================================
-- 4. POSITIVE VS NEGATIVE FEEDBACK
-- Business Question:
-- How many customers gave positive and negative feedback?
-- TRIM removes unwanted spaces from feedback values.
-- ============================================================

SELECT
    TRIM(feedback) AS feedback,
    COUNT(*) AS customer_count
FROM food_delivery
GROUP BY TRIM(feedback)
ORDER BY customer_count DESC;


-- ============================================================
-- 5. POSITIVE FEEDBACK RATE
-- Business Question:
-- What percentage of customers gave positive feedback?
-- ============================================================

SELECT
    ROUND(
        100.0 * SUM(
            CASE
                WHEN TRIM(feedback) = 'Positive' THEN 1
                ELSE 0
            END
        ) / COUNT(*),
        2
    ) AS positive_feedback_rate
FROM food_delivery;


-- ============================================================
-- 6. ONLINE ORDERING DISTRIBUTION
-- Business Question:
-- How many customers have online ordering = Yes or No?
-- ============================================================

SELECT
    TRIM(output) AS online_ordering,
    COUNT(*) AS customer_count
FROM food_delivery
GROUP BY TRIM(output)
ORDER BY customer_count DESC;


-- ============================================================
-- 7. ONLINE ORDERING RATE
-- Business Question:
-- What percentage of customers have online ordering = Yes?
-- ============================================================

SELECT
    ROUND(
        100.0 * SUM(
            CASE
                WHEN TRIM(output) = 'Yes' THEN 1
                ELSE 0
            END
        ) / COUNT(*),
        2
    ) AS online_ordering_rate
FROM food_delivery;


-- ============================================================
-- 8. FEEDBACK BY GENDER
-- Business Question:
-- How does positive and negative feedback vary by gender?
-- ============================================================

SELECT
    gender,
    TRIM(feedback) AS feedback,
    COUNT(*) AS customer_count
FROM food_delivery
GROUP BY gender, TRIM(feedback)
ORDER BY gender, customer_count DESC;


-- ============================================================
-- 9. FEEDBACK BY CUSTOMER TYPE
-- Business Question:
-- How does feedback vary across customer types?
-- ============================================================

SELECT
    customer_type,
    TRIM(feedback) AS feedback,
    COUNT(*) AS customer_count
FROM food_delivery
GROUP BY customer_type, TRIM(feedback)
ORDER BY customer_type, customer_count DESC;


-- ============================================================
-- 10. FEEDBACK BY AGE GROUP
-- Business Question:
-- How does feedback vary across different age groups?
-- ============================================================

SELECT
    CASE
        WHEN age < 25 THEN 'Under 25'
        WHEN age BETWEEN 25 AND 35 THEN '25-35'
        ELSE 'Other'
    END AS age_group,
    TRIM(feedback) AS feedback,
    COUNT(*) AS customer_count
FROM food_delivery
GROUP BY
    CASE
        WHEN age < 25 THEN 'Under 25'
        WHEN age BETWEEN 25 AND 35 THEN '25-35'
        ELSE 'Other'
    END,
    TRIM(feedback)
ORDER BY age_group, customer_count DESC;


-- ============================================================
-- 11. FEEDBACK BY OCCUPATION
-- Business Question:
-- How does feedback vary across different occupations?
-- ============================================================

SELECT
    occupation,
    TRIM(feedback) AS feedback,
    COUNT(*) AS customer_count
FROM food_delivery
GROUP BY occupation, TRIM(feedback)
ORDER BY occupation, customer_count DESC;


-- ============================================================
-- 12. FEEDBACK BY MONTHLY INCOME
-- Business Question:
-- How does feedback vary across income groups?
-- ============================================================

SELECT
    monthly_income,
    TRIM(feedback) AS feedback,
    COUNT(*) AS customer_count
FROM food_delivery
GROUP BY monthly_income, TRIM(feedback)
ORDER BY monthly_income, customer_count DESC;


-- ============================================================
-- 13. FEEDBACK BY EDUCATION
-- Business Question:
-- How does feedback vary across education levels?
-- ============================================================

SELECT
    educational_qualifications,
    TRIM(feedback) AS feedback,
    COUNT(*) AS customer_count
FROM food_delivery
GROUP BY educational_qualifications, TRIM(feedback)
ORDER BY educational_qualifications, customer_count DESC;


-- ============================================================
-- 14. ONLINE ORDERING BY CUSTOMER TYPE
-- Business Question:
-- How many customers order online within each customer type?
-- ============================================================

SELECT
    customer_type,
    TRIM(output) AS online_ordering,
    COUNT(*) AS customer_count
FROM food_delivery
GROUP BY customer_type, TRIM(output)
ORDER BY customer_type, customer_count DESC;


-- ============================================================
-- 15. ONLINE ORDERING RATE BY CUSTOMER TYPE
-- Advanced Analysis using CTE
--
-- Business Question:
-- What is the online ordering rate for each customer type?
-- ============================================================

WITH customer_type_summary AS (

    SELECT
        customer_type,
        COUNT(*) AS total_customers,

        SUM(
            CASE
                WHEN TRIM(output) = 'Yes' THEN 1
                ELSE 0
            END
        ) AS online_customers

    FROM food_delivery

    GROUP BY customer_type
)

SELECT
    customer_type,
    total_customers,
    online_customers,

    ROUND(
        100.0 * online_customers / total_customers,
        2
    ) AS online_ordering_rate

FROM customer_type_summary

ORDER BY online_ordering_rate DESC;


-- ============================================================
-- END OF ANALYSIS
-- ============================================================
