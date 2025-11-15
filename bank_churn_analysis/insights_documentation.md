# 🏦 Bank Customer Churn Analysis

### 📘 Project Overview

The objective of this project is to analyze customer churn in a bank using SQL and identify the key factors influencing whether a customer stays or leaves.
Customer churn is a critical performance metric for banks, as retaining existing clients is significantly more cost-effective than acquiring new ones.

### 📊 Dataset Description

| Column            | Description                             | Relevance                             |
| ----------------- | --------------------------------------- | ------------------------------------- |
| RowNumber         | Record index                            | ❌ Not relevant                        |
| CustomerId        | Unique customer ID                      | ❌ Not relevant                        |
| Surname           | Customer surname                        | ❌ Not relevant                        |
| CreditScore       | Customer’s credit score                 | ✅ Higher score → less likely to churn |
| Geography         | Customer’s location                     | ✅ Regional churn variation            |
| Gender            | Customer gender                         | ⚙️ For demographic comparison          |
| Age               | Customer age                            | ✅ Key churn driver                    |
| Tenure            | Number of years with the bank           | ✅ Loyalty indicator                   |
| Balance           | Account balance                         | ✅ Higher balance → more loyal         |
| NumOfProducts     | Products held with the bank             | ✅ More products → less churn          |
| HasCrCard         | Credit card ownership                   | ✅ Slightly affects churn              |
| IsActiveMember    | Active status                           | ✅ Active → lower churn                |
| EstimatedSalary   | Customer salary                         | ⚙️ Moderate relevance                  |
| Exited            | Whether the customer left (1=Yes, 0=No) | 🎯 Target variable                     |
| Complain          | Customer had a complaint (Yes/No)       | ✅ Strong churn indicator              |
| SatisfactionScore | Customer satisfaction rating            | ✅ Higher = less churn                 |
| CardType          | Type of card owned                      | ⚙️ Can influence churn slightly        |
| PointsEarned      | Credit card points                      | ⚙️ Loyalty factor                      |

### 🧠 Tools & Technologies

Database: MySQL

Language: SQL, Python

Visualization: Power BI

Goal: Generate business insights for churn prevention

### 🧩 SQL Analysis & Insights

| **Area**                     | **SQL Query Summary**                                                                                                   | **Key Insight**                                                                                                                                  |
| ---------------------------- | ----------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------ |
| **Overall Churn Rate**       | Counted churned vs retained customers                                                                                   | ~20% customers churned.                                                                                                                          |
| **By Credit Score**          | Categorized into `<= 579 (Poor)`, `580 - 669 (Fair)`, `670 - 739 (Good)`, `740 - 799 (Very Good)`, `>= 800 (Excellent)` | Customers with Credit Score `<= 579 (Poor)` has highest churn rate of ~22%.                                                                      |
| **By Geography**             | Grouped churn rate by country                                                                                           | Germany has the highest churn (~32%).                                                                                                            |
| **By Gender**                | Compared male vs female churn                                                                                           | Females has the highest churn (~25%).                                                                                                            |
| **By Age Group**             | Categorized into `<= 25 (Young Adult)`, `26 - 44 (Adult)`, `45 - 59 (Middle-aged)`, `>= 60 (Elderly)`                   | `45 - 59 (Middle-aged)` most likely to churn (~49%).                                                                                             |
| **By Tenure**                | Analyzed years with bank                                                                                                | New customers (Tenure 0–1 years) show the highest churn rate (≈22–23%).                                                                          |
| **By Balance**               | Categorized into `0 (No Balance)`, `1K-50K`, `50K-100K`, `100K-150K`, `150K-200K`, `>200K`                              | High-balance >200K customers churn unusually high (55.9%); 0 balance customers churn is low (13.8%).                                             |
| **By Products**              | Number of products owned                                                                                                | Investigate the extreme churn in 3–4 product customers. Customers with 3 and 4 products have churned ~82% and 100% respectively.                 |
| **By Credit Card Ownership** | Has Credit Card or not                                                                                                  | Customers with a credit card (HasCrCard=1) churn slightly less (20.2%) than those without (20.8%); ownership has minimal impact.                 |
| **By Active Status**         | Customer has an active account or not                                                                                   | Inactive members (0) churn much more (~26%) than active members (1) at ~14%; activity strongly reduces churn.                                    |
| **By Salary**                | Categorized into `<50K`, `50K-100K`, `100K-150K`, `150K-200K`, `>200K`                                                  | Churn is fairly consistent across salary bands (≈19–21%), indicating income has minimal effect on churn.                                         |
| **By Complaints**            | Checked churn for customers with complaints                                                                             | Customers with complaints almost always churn — 99.51% churn rate.                                                                               |
| **By Satisfaction Score**    | Avg score of churned vs retained                                                                                        | Satisfaction Score alone shows minimal variation in churn rates (≈19–22%).                                                                       |
| **By Card Type**             | Grouped churn rate by Card Type                                                                                         | Premium cardholders (Gold, Platinum) are slightly more loyal (churn ~19–20%) than Diamond (~21%); card type has moderate impact.                 |
| **By Point Earned**          | Categorized into `0  (No Points)`, `1-100`, `101-500`, `501-1000`, `1001-2000`, `>2000`                                 | Customers with more points (101–1000) show slightly lower churn (~20.3–20.4%); higher loyalty points correlate with marginally better retention. |

### 📈 Key SQL Examples

### 1. Overall Churn

```sql
SELECT
    Exited,
    COUNT(*) AS count,
    ROUND((COUNT(*) / (SELECT COUNT(*) FROM customers)) * 100, 2) AS churn_rate
FROM customers
GROUP BY Exited
ORDER BY churn_rate DESC;
```

### 2. Churn by Geography

```sql
SELECT
    Geography,
    COUNT(*) AS total_customers,
    SUM(Exited) AS churned_customers,
    ROUND((SUM(Exited) / COUNT(*)) * 100, 2) AS churn_rate
FROM customers
GROUP BY Geography
ORDER BY churn_rate DESC;
```

### 3. Churn by Gender

```sql
SELECT
    Gender,
    COUNT(*) AS total_customers,
    SUM(Exited) AS churned_customers,
    ROUND((SUM(Exited) / COUNT(*)) * 100, 2) AS churn_rate
FROM customers
GROUP BY Gender
ORDER BY churn_rate DESC;
```

### 4. Churn by Age Group

```sql
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
```

### 5. Churn by Complaints

```sql
SELECT
    Complain,
    COUNT(*) AS total_customers,
    SUM(Exited) AS churned_customers,
    ROUND((SUM(Exited) / COUNT(*)) * 100, 2) AS churn_rate
FROM customers
GROUP BY Complain
ORDER BY churn_rate DESC;
```

### 📊 Business Insights Summary

**👥 Customer Demographics**

* **Geography:**

Germany records the **highest churn rate**, with **approximately 32%** of customers having left the bank. This indicates potential **regional service dissatisfaction** or **competitive alternatives** in that market.

* **Gender:**

**Female customers** are more likely to churn, with around **25%** of the female customer base having exited, compared to a lower rate among males.

* **Age Group:**

**Middle-aged customers (45–59 years)** exhibit the **highest churn rate of approximately 49%**, suggesting that this segment may have **higher expectations** or **greater sensitivity to service quality**.

**💼 Behavioral Insights**

* **Complaints:**

Nearly **99% of customers who raised complaints have churned**, making this the **strongest single churn predictor**. Effective **complaint management** is therefore critical for retention.

Account Balance:
Customers with high account balances demonstrate a **churn rate of about 55%** (19 out of 34 customers). This indicates that **high-value clients may be seeking more personalized** or **premium banking experiences** elsewhere.

### 📈 Overall Trend

* **Top churn drivers:**

Complaints, geography (Germany), and middle-aged customers.

* **Loyalty indicators:**

Longer tenure, higher satisfaction, and multiple (but not excessive) product relationships.

* **Action focus:**

Prioritize **complaint resolution**, **retention of middle-aged** and **high-balance clients**, and **targeted support for female customers**.
