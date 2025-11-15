USE bank_churn_analysis;

-- 1. Overall churn rate
-- Number and percentage of customers who left:
SELECT
	Exited,
    COUNT(*) AS count,
    ROUND((COUNT(*) / (SELECT COUNT(*) FROM customers)) * 100, 2) AS churn_rate
FROM customers
GROUP BY Exited
ORDER BY churn_rate DESC;

-- 2. Churn by CreditScore
-- Grouped CreditScore into bands and calculated churn rate for each band (FICO score):
SELECT
	CASE
		WHEN CreditScore < 579 THEN '<= 579 (Poor)'
        WHEN CreditScore BETWEEN 580 AND 669 THEN '580 - 669 (Fair)'
        WHEN CreditScore BETWEEN 670 AND 739 THEN '670 - 739 (Good)'
        WHEN CreditScore BETWEEN 740 AND 799 THEN '740 - 799 (Very Good)'
        ELSE '>= 800 (Excellent)'
	END AS credit_score_band,
    COUNT(*) AS total_customers,
    SUM(Exited) AS churned_customers,
    ROUND((SUM(Exited) / COUNT(*)) * 100, 2) AS churn_rate
FROM customers
GROUP BY credit_score_band
ORDER BY churn_rate DESC;

-- 3. Churn by Geography
-- Check if geography impacts churn:
SELECT
	Geography,
    COUNT(*) AS total_customers,
    SUM(Exited) AS churned_customers,
    ROUND((SUM(Exited) / COUNT(*)) * 100, 2) AS churn_rate
FROM customers
GROUP BY Geography
ORDER BY churn_rate DESC;

-- 4. Churn by Gender
-- Check gender differences:
SELECT
	Gender,
    COUNT(*) AS total_customers,
    SUM(Exited) AS churned_customers,
    ROUND((SUM(Exited) / COUNT(*)) * 100, 2) AS churn_rate
FROM customers
GROUP BY Gender
ORDER BY churn_rate DESC;

-- 5. Churn by Age
-- Segment customers into age groups and analyze churn rates:
SELECT
	CASE
		WHEN Age <= 25 THEN '<= 25 (Young Adult)'
        WHEN Age BETWEEN 26 AND 44 THEN '26 - 44 (Adult)'
        WHEN Age BETWEEN 45 AND 59 THEN '45 - 59 (Middle-aged)'
        ELSE '>= 60 (Elderly)'
	END AS age_group,
    COUNT(*) AS total_customers,
    SUM(Exited) AS churned_customers,
    ROUND((SUM(Exited) / COUNT(*)) * 100, 2) AS churn_rate
FROM customers
GROUP BY age_group
ORDER BY churn_rate DESC;

-- 6. Churn by Tenure
-- Check if tenure affects churn:
SELECT
	Tenure,
    COUNT(*) AS total_customers,
    SUM(Exited) AS churned_customers,
    ROUND((SUM(Exited) / COUNT(*)) * 100, 2) AS churn_rate
FROM customers
GROUP BY Tenure
ORDER BY churn_rate DESC;

-- 7. Churn by Balance
-- Categorize Balance into bands and calculate churn rate for each band:
SELECT
	CASE
        WHEN Balance = 0 THEN '0 (No Balance)'
        WHEN Balance BETWEEN 1 AND 50000 THEN '1 - 50K'
        WHEN Balance BETWEEN 50001 AND 100000 THEN '50K - 100K'
        WHEN Balance BETWEEN 100001 AND 150000 THEN '100K - 150K'
        WHEN Balance BETWEEN 150001 AND 200000 THEN '150K - 200K'
        ELSE '>200K'
    END AS balance_band,
    COUNT(*) AS total_customers,
    SUM(Exited) AS churned_customers,
    ROUND((SUM(Exited) / COUNT(*)) * 100, 2) AS churn_rate
FROM customers
GROUP BY balance_band
ORDER BY churn_rate DESC;

-- 8. Churn vs Number of Products
-- Check whether having more bank products reduces churn:
SELECT
	NumOfProducts,
    COUNT(*) AS total_customers,
    SUM(Exited) AS churned_customers,
    ROUND((SUM(Exited) / COUNT(*)) * 100, 2) AS churn_rate
FROM customers
GROUP BY NumOfProducts
ORDER BY churn_rate DESC;

-- 9. Churn by Has Credit Card
-- Check if owning a credit card affects churn:
SELECT
	HasCrCard,
    COUNT(*) AS total_customers,
    SUM(Exited) AS churned_customers,
    ROUND((SUM(Exited) / COUNT(*)) * 100, 2) AS churn_rate
FROM customers
GROUP BY HasCrCard
ORDER BY churn_rate DESC;

-- 10. Churn by Active Status
-- Check if being an active member affects churn:
SELECT
	IsActiveMember,
    COUNT(*) AS total_customers,
    SUM(Exited) AS churned_customers,
    ROUND((SUM(Exited) / COUNT(*)) * 100, 2) AS churn_rate
FROM customers
GROUP BY IsActiveMember
ORDER BY churn_rate DESC;

-- 11. Churn by Salary
-- Categorize Salary into bands and calculate churn rate for each band:
SELECT
	CASE
        WHEN EstimatedSalary < 50000 THEN '<50K'
        WHEN EstimatedSalary BETWEEN 50000 AND 100000 THEN '50K - 100K'
        WHEN EstimatedSalary BETWEEN 100001 AND 150000 THEN '100K - 150K'
        WHEN EstimatedSalary BETWEEN 150001 AND 200000 THEN '150K - 200K'
        ELSE '>200K'
    END AS salary_band,
    COUNT(*) AS total_customers,
    SUM(Exited) AS churned_customers,
    ROUND((SUM(Exited) / COUNT(*)) * 100, 2) AS churn_rate
FROM customers
GROUP BY salary_band
ORDER BY churn_rate DESC;

-- 12. Churn vs Complaints
-- Check if complaints affect churn:
SELECT
	Complain,
    COUNT(*) AS total_customers,
    SUM(Exited) AS churned_customers,
    ROUND((SUM(Exited) / COUNT(*)) * 100, 2) AS churn_rate
FROM customers
GROUP BY Complain
ORDER BY churn_rate DESC;

-- 13. Churn vs Customer Satisfaction
-- Check if customer satisfaction affect churn:
SELECT
	SatisfactionScore,
    COUNT(*) AS total_customers,
    SUM(Exited) AS churned_customers,
    ROUND((SUM(Exited) / COUNT(*)) * 100, 2) AS churn_rate
FROM customers
GROUP BY SatisfactionScore
ORDER BY churn_rate DESC;

-- 14. Churn by CardType
-- Check if CardType affects churn:
SELECT
	CardType,
    COUNT(*) AS total_customers,
    SUM(Exited) AS churned_customers,
    ROUND((SUM(Exited) / COUNT(*)) * 100, 2) AS churn_rate
FROM customers
GROUP BY CardType
ORDER BY churn_rate DESC;

-- 15. Churn by PointEarned
-- Categorize PointEarned into bands and calculate churn rate for each band:
SELECT
	CASE
        WHEN PointEarned = 0 THEN '0 (No Points)'
        WHEN PointEarned BETWEEN 1 AND 100 THEN '1 - 100'
        WHEN PointEarned BETWEEN 101 AND 500 THEN '101 - 500'
        WHEN PointEarned BETWEEN 501 AND 1000 THEN '501 - 1000'
        WHEN PointEarned BETWEEN 1001 AND 2000 THEN '1001 - 2000'
        ELSE '>2000'
    END AS points_band,
    COUNT(*) AS total_customers,
    SUM(Exited) AS churned_customers,
    ROUND((SUM(Exited) / COUNT(*)) * 100, 2) AS churn_rate
FROM customers
GROUP BY points_band
ORDER BY churn_rate DESC;