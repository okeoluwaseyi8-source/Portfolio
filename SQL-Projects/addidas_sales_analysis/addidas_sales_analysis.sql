-- Adidas Sales Analysis SQL Script
-- Author: Oke Oluwaseyi Adebiyi
-- Dataset: [dbo].[Data Sales Adidas]
-- Purpose: Comprehensive analysis of 2021 Adidas sales data for business case presentation

SELECT * FROM dbo.['Data Sales Adidas$'];

-- Query 1: Total Sales Revenue by Foot Locker in Charleston
SELECT Retailer, City, SUM([Total Sales]) AS total_revenue
FROM dbo.['Data Sales Adidas$']
WHERE Retailer = 'Foot Locker' and City = 'Charleston'
GROUP BY Retailer, City;

-- Query 2: Units Sold in February 2021
SELECT SUM([Units Sold]) AS Sum_of_Unit_Sold
FROM dbo.['Data Sales Adidas$']
WHERE YEAR([Invoice Date]) =2021 AND MONTH([Invoice Date]) = 2;

-- Query 3a: Product with Highest Total Sales in March 2021
SELECT Product, SUM([Total Sales]) AS highest_sale
FROM dbo.['Data Sales Adidas$']
WHERE YEAR([Invoice Date]) = 2021 AND MONTH([Invoice date]) = 3
GROUP BY Product
ORDER BY highest_sale DESC;


-- Query 3b: Top 1 Product with Highest Total Sales in March 2021
SELECT TOP 1 Product, SUM([Total Sales]) AS highest_sale
FROM dbo.['Data Sales Adidas$']
WHERE YEAR([Invoice Date]) = 2021 AND MONTH([Invoice date]) = 3
GROUP BY Product
ORDER BY highest_sale DESC;

-- Query 4: Average Price per Unit for Women's Athletic Footwear
SELECT AVG([Price per Unit]) avg_price
FROM dbo.['Data Sales Adidas$']
WHERE Product ='Women''s Athletic Footwear';

-- Query 5: Total Operating Profit for Men's Street Footwear in April 2021
SELECT SUM([Operating profit]) AS Porift
FROM dbo.['Data Sales Adidas$']
WHERE (Product ='Men''s Street Footwear') AND (YEAR([Invoice Date]) =2021) AND (MONTH([Invoice date]) =4);

-- Query 6: Product with Highest Average Operating Margin
SELECT TOP 1 Product,AVG([Operating Margin]) AS AVG_OPERA
FROM dbo.['Data Sales Adidas$']
GROUP BY Product
ORDER BY AVG_OPERA DESC;

-- Query 6b: Top Products with Highest Operating Margin
SELECT  Product,AVG([Operating Margin]) AS AVG_OPERA
FROM dbo.['Data Sales Adidas$']
GROUP BY Product
ORDER BY AVG_OPERA DESC;


-- Query 7: Distinct Products Sold in May 2021
SELECT DISTINCT Product
FROM DBO.['Data Sales Adidas$']
WHERE YEAR([Invoice Date]) = 2021 and MONTH([Invoice Date]) =5;


-- Query 7b: Count Distinct Products Sold in May 2021
SELECT COUNT(DISTINCT Product) AS count_of_product
FROM dbo.['Data Sales Adidas$']
WHERE YEAR([Invoice Date]) = 2021 AND MONTH([Invoice Date]) = 5;


-- Query 8: Total Sales Revenue for Online Sales
SELECT SUM([Total Sales]) AS tolal_sales
FROM dbo.['Data Sales Adidas$']
WHERE [Sales Method] = 'Online';



-- Query 10: Product with Lowest Units Sold in April 2021
SELECT Product, SUM([Units Sold]) AS unit_sold
FROM dbo.['Data Sales Adidas$']
WHERE YEAR([Invoice Date]) = 2021 AND MONTH([Invoice Date]) = 4
GROUP BY Product
ORDER BY unit_sold ASC;


-- Query 11: Total Operating Profit for Apparel Products
SELECT SUM([Operating Profit]) AS pROFIT
FROM dbo.['Data Sales Adidas$']
WHERE Product IN ('Men''s Apparel', 'Women''s Apparel');


-- Query 12: Average Total Sales per Transaction in March 2021
SELECT AVG([Total Sales]) as avg_sales
FROM DBO.['Data Sales Adidas$']
where YEAR([Invoice date]) =2021 and MONTH([Invoice Date]) = 3;


--- Query 13: Transactions for Women's Street Footwear in 2021
SELECT SUM([Total Sales]) AS total_transaction
FROM dbo.['Data Sales Adidas$']
WHERE (Product ='Women''s Street Footwear') AND (YEAR([Invoice Date]) = 2021);


-- Query 14: Total Sales Revenue for Products with Operating Margin > 0.4
SELECT SUM([Total Sales]) AS sales
FROM dbo.['Data Sales Adidas$']
WHERE [Operating Margin] >0.4;



-- Query 15: Month with Highest Total Units Sold in 2021
SELECT TOP 1 SUM([Units Sold]) AS sold_unit, MONTH([Invoice Date]) as month
FROM dbo.['Data Sales Adidas$']
WHERE YEAR([Invoice Date]) =2021
GROUP BY MONTH([Invoice Date])
ORDER BY sold_unit DESC;

----
-- Query 15: Month with Highest Total Units Sold in 2021 NEW VERSION
SELECT TOP 1 DATENAME(MONTH, DATEFROMPARTS(2021, MONTH([Invoice Date]),1)) as Month, SUM([Units Sold]) AS unit_sold
FROM DBO.['Data Sales Adidas$']
WHERE YEAR([Invoice Date]) = 2021
GROUP BY DATENAME(MONTH, DATEFROMPARTS(2021, MONTH([Invoice Date]),1))
ORDER BY unit_sold DESC;


-- Query 15b: Sales by Month in 2021
SELECT SUM([Total Sales]) AS sales,  MONTH([Invoice Date]) AS months, SUM([Units Sold]) AS Sold_unit
FROM dbo.['Data Sales Adidas$']
WHERE YEAR([Invoice Date]) =2021
GROUP BY MONTH([Invoice Date])
ORDER BY sales DESC;

-- Query 16: Profit Margin for Men's Athletic Footwear in May 2021
SELECT SUM([Operating Profit]) / SUM([Total Sales])  AS Total_Margin
FROM DBO.['Data Sales Adidas$']
WHERE (Product = 'Men''s Athletic Footwear') AND (year([Invoice Date])=2021) AND (MONTH([Invoice Date]) =5);


-- Query 17: Average Price per Unit in Charleston
SELECT AVG([Price per Unit]) AS avg_Price
FROM DBO.['Data Sales Adidas$']
WHERE City ='Charleston';

-- Query 18: Units Sold for Men's Street Footwear in Q2 2021
SELECT SUM([Units Sold]) AS Unit_sold
FROM dbo.['Data Sales Adidas$']
WHERE Product = 'Men''s Street Footwear' AND YEAR([Invoice date]) = 2021 AND MONTH([Invoice Date]) in (4,5,6);

-- Query 19: Total Sales Revenue for Products Priced Above $40
SELECT SUM([Total Sales]) AS Revenue
FROM dbo.['Data Sales Adidas$']
WHERE [Price per Unit] > 40;



-- Query 20: Product with Highest Total Operating Profit in 2021
SELECT TOP 1 Product, SUM([Operating Profit]) AS Profit
FROM dbo.['Data Sales Adidas$']
WHERE Product IS NOT NULL AND YEAR([Invoice Date]) =2021
GROUP BY Product 
ORDER BY Profit DESC;

-- Query 20b: Product with Highest Total Operating Profit, profit margin, and total sales in 2021
SELECT TOP 3 3 product,
	SUM([Total Sales]) AS Sales, 
	SUM([Operating Profit]) AS profit, 
	SUM([Operating Profit])/SUM([Total Sales]) AS profit_margin
FROM dbo.['Data Sales Adidas$']
WHERE YEAR([Invoice Date]) =2021 AND Product IS NOT NULL
GROUP BY Product
ORDER BY profit DESC;


-- Query 21: Percentage of Total Sales by Women's Apparel
SELECT woman_sales.w/ total_sales.t * 100 AS Sales_Percentage
FROM
(SELECT SUM([Total Sales]) AS w
FROM dbo.['Data Sales Adidas$']
WHERE Product= 'Women''s Apparel') AS woman_sales,

(SELECT SUM([total Sales])AS t
FROM dbo.['Data Sales Adidas$']) AS total_sales;

-- Query 21: Percentage of Total Sales by Women's Apparel ANOTHR METHOD
SELECT 
    SUM([Total Sales]) / (SELECT SUM([Total Sales]) FROM DBO.['Data Sales Adidas$']) * 100 AS Sales_Percentage
FROM DBO.['Data Sales Adidas$']
WHERE Product = 'Women''s Apparel';


-- Query 22: Transactions with Total Sales Above $300,000
SELECT COUNT(*) AS Transaction_Count
FROM DBO.['Data Sales Adidas$']
WHERE [Total Sales] > 300000;

-- Query 23: Average Operating Profit per Unit Sold for Men's Apparel
SELECT SUM([Operating Profit]) / SUM([Units Sold]) AS Avg_Profit_Per_Unit
FROM DBO.['Data Sales Adidas$']
WHERE Product = 'Men''s Apparel';

-- Query 24: Product with Lowest Operating Profit in May 2021 
SELECT TOP 1 Product, SUM([Operating Profit]) AS Total_Profit
FROM DBO.['Data Sales Adidas$']
WHERE YEAR([Invoice Date]) = 2021 AND MONTH([Invoice Date]) = 5
GROUP BY Product
ORDER BY Total_Profit ASC;


-- Query 25: Total Sales Revenue for Foot Locker in Q1 2021
SELECT SUM([Total Sales]) AS Total_Sales
FROM DBO.['Data Sales Adidas$']
WHERE Retailer = 'Foot Locker' 
AND YEAR([Invoice Date]) = 2021 AND MONTH([Invoice Date]) IN (1, 2, 3);


-- Query 26: Units Sold for Products with Operating Margin of 0.35
SELECT SUM([Units Sold]) AS Total_Units_Sold
FROM DBO.['Data Sales Adidas$']
WHERE [Operating Margin] = 0.35;

-- Query 27: Average Units Sold per Transaction for Women's Street Footwear
SELECT AVG([Units Sold]) AS Avg_Units_Sold
FROM DBO.['Data Sales Adidas$']
WHERE Product = 'Women''s Street Footwear';


-- Query 28: Total Operating Profit for Transactions in April 2021
SELECT SUM([Operating Profit]) AS Total_Profit
FROM DBO.['Data Sales Adidas$']
WHERE YEAR([Invoice Date]) = 2021 AND MONTH([Invoice Date]) = 4;


-- Query 29: Product with Highest Price per Unit in May 2021
SELECT TOP 1 Product, MAX([Price per Unit]) AS Max_Price
FROM DBO.['Data Sales Adidas$']
WHERE YEAR([Invoice Date]) = 2021 AND MONTH([Invoice Date]) = 5
GROUP BY Product
ORDER BY Max_Price DESC;


-- Query 30: Total Sales Revenue in South Carolina (Corrected)
SELECT SUM([Total Sales]) AS Total_Sales
FROM DBO.['Data Sales Adidas$']
WHERE State = 'South Carolina';


-- Query 31: Transactions in Southeast Region
SELECT COUNT(*) AS Transaction_Count
FROM DBO.['Data Sales Adidas$']
WHERE Region = 'Southeast';


-- Query 32: Average Operating Margin for Men's Street Footwear
SELECT AVG([Operating Margin]) AS Avg_Operating_Margin
FROM DBO.['Data Sales Adidas$']
WHERE Product = 'Men''s Street Footwear';


-- Query 33: Total Units Sold for Products with Total Sales Below $200,000
SELECT SUM([Units Sold]) AS Total_Units_Sold
FROM DBO.['Data Sales Adidas$']
WHERE [Total Sales] < 200000;


-- Query 34: Month with Lowest Total Operating Profit in 2021
SELECT TOP 1 
    DATENAME(MONTH, DATEFROMPARTS(2021, MONTH([Invoice Date]), 1)) AS Month, 
    SUM([Operating Profit]) AS Total_Profit
FROM DBO.['Data Sales Adidas$']
WHERE YEAR([Invoice Date]) = 2021
GROUP BY MONTH([Invoice Date]), DATENAME(MONTH, DATEFROMPARTS(2021, MONTH([Invoice Date]), 1))
ORDER BY Total_Profit ASC;



-- Query 35: Total Sales Revenue for Products with Units Sold Above 800
SELECT SUM(sum_of_sales.sales) AS Total_Sales
FROM
(SELECT SUM([Total Sales]) AS sales, Product
FROM dbo.['Data Sales Adidas$']
WHERE  [Units Sold] >800
GROUP BY Product) AS  sum_of_sales;
     -----OR
-- Query 35: Total Sales Revenue for Products with Units Sold Above 800
SELECT SUM([Total Sales]) AS Total_Sales
FROM dbo.['Data Sales Adidas$']
WHERE [Units Sold] > 800;



-- Query 36: Distinct Invoice Dates in the Dataset
SELECT COUNT(DISTINCT [Invoice Date]) AS Distinct_Dates
FROM dbo.['Data Sales Adidas$'];


-- Query 37: Average Total Sales for Men's Athletic Footwear
SELECT AVG([Total Sales]) AS Avg_Sales
FROM dbo.['Data Sales Adidas$']
WHERE Product = 'Men''s Athletic Footwear';


-- Query 38: Total Operating Profit in February Permenantly2021
SELECT SUM([Operating Profit]) AS Total_Profit
FROM dbo.['Data Sales Adidas$']
WHERE YEAR([Invoice Date]) = 2021 AND MONTH([Invoice Date]) = 2;


-- Query 39: Product with Highest Units Sold in March 2021
SELECT TOP 1 
    Product, 
    SUM([Units Sold]) AS Total_Units_Sold
FROM dbo.['Data Sales Adidas$']
WHERE YEAR([Invoice Date]) = 2021 AND MONTH([Invoice Date]) = 3
GROUP BY Product
ORDER BY Total_Units_Sold DESC;


-- Query 40: Percentage of Operating Profit by Women's Athletic Footwear
SELECT 
    SUM([Operating Profit]) / (SELECT SUM([Operating Profit]) FROM dbo.['Data Sales Adidas$']) * 100 AS Profit_Percentage
FROM dbo.['Data Sales Adidas$']
WHERE Product = 'Women''s Athletic Footwear';
------OR
-- Query 40: Percentage of Operating Profit by Women's Athletic Footwear
SELECT p.profit/t.total_profit *100 AS percentage_woamen
FROM
(SELECT SUM([Operating Profit]) AS profit
FROM dbo.['Data Sales Adidas$']
WHERE Product='Women''s Athletic Footwear') AS p,

(SELECT SUM([Operating Profit]) AS total_profit
FROM dbo.['Data Sales Adidas$']) AS t;


-- Query 41: Transactions with Operating Margin Below 0.3
SELECT COUNT(*) AS Transaction_Count
FROM dbo.['Data Sales Adidas$']
WHERE [Operating Margin] < 0.3;

-- Query 42: Total Sales Revenue for Men's Apparel in April 2021
SELECT SUM([Total Sales]) AS Total_Sales
FROM dbo.['Data Sales Adidas$']
WHERE Product = 'Men''s Apparel' 
AND YEAR([Invoice Date]) = 2021 AND MONTH([Invoice Date]) = 4;

-- Query 43: Average Units Sold for Transactions with Total Sales Above $250,000
SELECT AVG([Units Sold]) AS Avg_Units_Sold
FROM dbo.['Data Sales Adidas$']
WHERE [Total Sales] > 250000;

-- Query 44: Product with Lowest Price per Unit in February 2021
SELECT TOP 1 Product, MIN([Price per Unit]) AS Min_Price
FROM dbo.['Data Sales Adidas$']
WHERE YEAR([Invoice Date]) = 2021 AND MONTH([Invoice Date]) = 2
GROUP BY Product
ORDER BY Min_Price ASC;

-- Query 45: Total Operating Profit for Products with Units Sold Below 700
SELECT SUM([Operating Profit]) AS Total_Profit
FROM dbo.['Data Sales Adidas$']
WHERE [Units Sold] < 700;

-- Query 46: Transactions for Products Priced at $35
SELECT COUNT(*) AS Transaction_Count
FROM dbo.['Data Sales Adidas$']
WHERE [Price per Unit] = 35;

-- Query 47: Average Operating Profit for Women's Street Footwear
SELECT AVG([Operating Profit]) AS Avg_Profit
FROM dbo.['Data Sales Adidas$']
WHERE Product = 'Women''s Street Footwear';


-- Query 48: Total Sales Revenue for First Week of March 2021
SELECT SUM([Total Sales]) as Sales
FROM dbo.['Data Sales Adidas$']
WHERE (year([Invoice Date]) =2021) AND ( Month([Invoice Date]) = 3) AND (DAY([Invoice Date]) >=1) AND (day([Invoice Date]) <=7)

-- Query 48: Total Sales Revenue for First Week of March 2021

-----OR
SELECT SUM([Total Sales]) AS Total_Sales
FROM dbo.['Data Sales Adidas$']
WHERE YEAR([Invoice Date]) = 2021 AND MONTH([Invoice Date]) = 3 
AND DAY([Invoice Date]) BETWEEN 1 AND 7;




--- Query 49: Product with Highest Operating Margin in April 2021
SELECT TOP 1 Product, MAX([Operating Margin]) AS Max_Margin
FROM dbo.['Data Sales Adidas$']
WHERE YEAR([Invoice Date]) = 2021 AND MONTH([Invoice Date]) = 4
GROUP BY Product
ORDER BY Max_Margin DESC;

-- Query 50: Total Units Sold for Products with Operating Profit Above $100,000
SELECT SUM([Units Sold]) AS Total_Units_Sold
FROM dbo.['Data Sales Adidas$']
WHERE [Operating Profit] > 100000;




