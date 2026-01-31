-- Product Analysis SQL Script
-- Author: Oke Oluwaseyi Adebiyi
-- Dataset: dbo.product_sales, dbo.Product_data, dbo.discount_data
-- Purpose: Analyze 2021 sales performance for a sound product company by integrating product, sales,
-- and discount data to evaluate pricing, customer segments, discount impact, and revenue drivers.



SELECT * FROM dbo.product_sales
SELECT * FROM dbo.Product_data
SELECT * FROM dbo.discount_data


WITH CTE AS (
SELECT 
P.Product,
P.Brand,
P.Category,
p.Sale_Price,
P.Description,
P.Cost_Price,
P.Image_url,
S.Customer_Type,
S.Date,
S.Units_Sold,
S.Country,
S.Discount_Band,
	DATEFROMPARTS(
	year(S.Date),
	Day(S.Date),
	Month(S.Date)) AS Date2,
	P.Sale_Price*S.Units_Sold AS Revenue,
	P.Cost_Price*S.Units_Sold AS Total_cost,
	(P.Sale_Price*S.Units_Sold)-(P.Cost_Price*S.Units_Sold) AS Profit,
	YEAR(DATEFROMPARTS(year(S.Date),Day(S.Date),Month(S.Date))) AS Year,
	FORMAT(DATEFROMPARTS(year(S.Date),Day(S.Date),Month(S.Date)), 'MMMM') AS Month
FROM Product_data P
	INNER JOIN product_sales S
	ON P.Product_ID = S.Product)

SELECT *, 
	(1-D.Discount/100.0)*C.Revenue AS discount_revenue
FROM CTE C
	INNER JOIN discount_data D
	ON C.Discount_Band = D.Discount_Band AND C.Month = D.Month;