1. Total No. of customer

SELECT 
COUNT(*) AS TotalCustomer
FROM Telco_customer_churn;

2. Duplicate check

SELECT
CustomerID,
COUNT(CustomerID) AS CustomerCount
FROM Telco_customer_churn
GROUP BY CustomerID
HAVING COUNT(CustomerID)>1;

3. Check if null

SELECT 
ChurnFlag,
COUNT(*) AS NullCount
FROM Telco_customer_churn
WHERE ChurnFlag = NULL;

4. Churn Rate

SELECT
COUNT(*) AS TotalCustomer,
SUM(CASE WHEN ChurnFlag = 1 THEN 1 ELSE 0 END) AS ChurnedCustomer,
ROUND(SUM(CASE WHEN ChurnFlag = 1 THEN 1 ELSE 0 END)*1.0/COUNT(*)*100,2) AS ChurnRate
FROM Telco_customer_churn;

5. Churn by contract

SELECT 
Contract,
COUNT(*) AS TotalCustomer,
SUM(CASE WHEN ChurnFlag = 1 THEN 1 ELSE 0 END) AS ChurnedCustomer,
ROUND(SUM(CASE WHEN ChurnFlag = 1 THEN 1 ELSE 0 END)*1.0/COUNT(*)*100,2) AS ChurnRate
FROM Telco_customer_churn
GROUP BY Contract
ORDER BY ChurnRate DESC;

6. Churn by internet service

SELECT 
InternetService,
COUNT(*) AS TotalCustomer,
SUM(CASE WHEN ChurnFlag = 1 THEN 1 ELSE 0 END) AS ChurnedCustomer,
ROUND(SUM(CASE WHEN ChurnFlag = 1 THEN 1 ELSE 0 END)*1.0/COUNT(*)*100,2) AS ChurnRate
FROM Telco_customer_churn
GROUP BY InternetService
ORDER BY ChurnRate DESC;

7. Churn by payment method

SELECT 
PaymentMethod,
COUNT(*) AS TotalCustomer,
SUM(CASE WHEN ChurnFlag = 1 THEN 1 ELSE 0 END) AS ChurnedCustomer,
ROUND(SUM(CASE WHEN ChurnFlag = 1 THEN 1 ELSE 0 END)*1.0/COUNT(*)*100,2) AS ChurnRate
FROM Telco_customer_churn
GROUP BY PaymentMethod
ORDER BY ChurnRate DESC;

8. Avg monthly and total charges of churn and non churn customers

SELECT 
ChurnFlag,
ROUND(AVG(MonthlyCharges),2) AS AvgMonthlyCharges,
ROUND(AVG(TotalCharges),2) AS AvgTotalCharges
FROM Telco_customer_churn
GROUP BY ChurnFlag;

9. Most common churn reasons

SELECT
ChurnReason,
COUNT(*) AS TotalCustomer
FROM Telco_customer_churn
WHERE ChurnFlag = 1
GROUP BY ChurnReason
ORDER BY TotalCustomer DESC;

10. Max and min tenure

SELECT
MAX(TenureMonths) AS MaxTenure,
MIN(TenureMonths) AS MinTenure
FROM Telco_customer_churn;

11. Churn by tenure

SELECT
CASE 
WHEN TenureMonths <= 12  THEN "0-12 Months"
WHEN TenureMonths <= 24  THEN "12-24 Months"
WHEN TenureMonths <= 36  THEN "24-36 Months"
ELSE "36+ Months"
END AS TenureBracket,
COUNT(*) AS TotalCustomer,
SUM(CASE WHEN ChurnFlag = 1 THEN 1 ELSE 0 END) AS ChurnedCustomer,
ROUND(SUM(CASE WHEN ChurnFlag = 1 THEN 1 ELSE 0 END)*1.0/COUNT(*)*100,2) AS ChurnRate
FROM Telco_customer_churn
GROUP BY TenureBracket
ORDER BY ChurnRate DESC;

12. Churn by Senior Citizen

SELECT
SeniorCitizen,
COUNT(*) AS TotalCustomer,
SUM(CASE WHEN ChurnFlag = 1 THEN 1 ELSE 0 END) AS ChurnedCustomer,
ROUND(SUM(CASE WHEN ChurnFlag = 1 THEN 1 ELSE 0 END)*1.0/COUNT(*)*100,2) AS ChurnRate
FROM Telco_customer_churn
GROUP BY SeniorCitizen
ORDER BY ChurnRate DESC;

13. Max and min CLTV

SELECT
MAX(CLTV) AS MaxCLTV,
MIN(CLTV) AS MinCLTV
FROM Telco_customer_churn;

14. Avg CLTV by churn status

SELECT
ChurnFlag,
ROUND(AVG(CLTV),2) AS AvgCLTV,
COUNT(*)  AS TotalCustomer
FROM Telco_customer_churn
GROUP BY ChurnFlag;

15. Categorising CLTV

SELECT
CASE
WHEN CLTV <=3000 THEN "LOW CLTV"
WHEN CLTV <= 5000 THEN "MID CLTV"
ELSE "HIGH CLTV"
END AS "CLTV Bracket",
ChurnFlag,
COUNT(*) AS TotalCustomer
FROM Telco_customer_churn
GROUP BY "CLTV Bracket", ChurnFlag;

16. Details of high value churned customer

SELECT 
CustomerID,
CLTV,
MonthlyCharges,
TotalCharges,
TenureMonths,
ChurnReason
FROM Telco_customer_churn
WHERE ChurnFlag = 1 AND CLTV >= 5000
ORDER BY CLTV DESC;

17. Churn by Gender

SELECT
Gender,
COUNT(*) AS TotalCustomer,
SUM(CASE WHEN ChurnFlag = 1 THEN 1 ELSE 0 END) AS ChurnedCustomer,
ROUND(SUM(CASE WHEN ChurnFlag = 1 THEN 1 ELSE 0 END)*1.0/COUNT(*)*100,2) AS ChurnRate
FROM Telco_customer_churn
GROUP BY Gender
ORDER BY ChurnRate DESC;

18. Churned customer in different city

SELECT
City,
COUNT(*) AS TotalCustomer,
SUM(CASE WHEN ChurnFlag = 1 THEN 1 ELSE 0 END) AS ChurnedCustomer,
ROUND(SUM(CASE WHEN ChurnFlag = 1 THEN 1 ELSE 0 END)*1.0/COUNT(*)*100,2) AS ChurnRate
FROM Telco_customer_churn
WHERE ChurnFlag = 1
GROUP BY City
ORDER BY ChurnRate DESC;

19. Total Loss due to churned customer

SELECT
SUM(CASE WHEN ChurnFlag = 0 THEN TotalCharges ELSE 0 END) AS TotalRevenue,
SUM(CASE WHEN ChurnFlag = 1 THEN TotalCharges ELSE 0 END) AS LostRevenue,
ROUND(SUM(CASE WHEN ChurnFlag = 1 THEN TotalCharges ELSE 0 END)/SUM(TotalCharges)*100,2) AS RevenueChurnRate
FROM Telco_customer_churn;

20. Churn by Zipcode and its most common reason

SELECT
t.ZipCode,
COUNT(*) AS TotalCustomer,
SUM(CASE WHEN t.ChurnFlag = 1 THEN 1 ELSE 0 END) AS ChurnedCustomer,
ROUND(SUM(CASE WHEN t.ChurnFlag = 1 THEN 1 ELSE 0 END) * 1.0 / COUNT(*) * 100, 2) AS ChurnRate,
(SELECT 
c.ChurnReason
FROM Telco_customer_churn c
WHERE c.ChurnFlag = 1 AND c.ZipCode = t.ZipCode
GROUP BY c.ChurnReason
ORDER BY COUNT(*) DESC
LIMIT 1) AS MostCommonChurnReason
FROM Telco_customer_churn t
GROUP BY t.ZipCode
ORDER BY ChurnedCustomer DESC
LIMIT 25;
