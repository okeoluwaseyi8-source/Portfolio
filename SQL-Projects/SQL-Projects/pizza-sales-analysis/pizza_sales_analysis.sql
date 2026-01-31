-- Pizza Sales and Order Analysis
-- Author: Oke Oluwaseyi Adebiyi
-- Dataset: DBO.pizza_sales
-- Purpose:  Analyze pizza sales and orders to assess revenue, order volume, and average purchase behavior.



SELECT *
FROM DBO.pizza_sales;

----Total Revenue
SELECT SUM(total_price) as Total_Revenue
FROM DBO.pizza_sales;

----Avg Order Value
SELECT SUM(total_price)/COUNT(DISTINCT order_id) as Avg_order_Value
FROM DBO.pizza_sales;

---TOTAL ORDER 
SELECT COUNT(DISTINCT order_id) as Total_Orders
FROM DBO.pizza_sales;

---TOTAL SOLD PIZZA
SELECT SUM(quantity) as Total_sold_Pizza
FROM DBO.pizza_sales;


---AVG PIZZA PER ORDER
SELECT CAST(CAST(SUM(quantity) AS decimal (10,2))/CAST(COUNT(DISTINCT order_id) AS decimal(10,2)) AS decimal(10,2)) as Avg_Pizza_Order
FROM DBO.pizza_sales;

----TOTAL ORDERS DAILY TREND
SELECT DATENAME(DW,order_date) as Daily_qty_sold,  COUNT(DISTINCT order_id) AS Order_id_Count
FROM DBO.pizza_sales
GROUP BY DATENAME(DW,order_date);

---MONTHLY TOTAL ORDERS
SELECT DATENAME(MONTH, order_date) as Month, COUNT(DISTINCT order_id) as Order_count
FROM DBO.pizza_sales
GROUP BY DATENAME(MONTH, order_date);


----PERCENTAGE OF SALES BY PIZZA CATEGORY
SELECT pizza_category, CAST(SUM(total_price)*100  / SUM(SUM(total_price)) OVER () AS decimal(10,2)) AS Percentage
FROM DBO.pizza_sales
GROUP BY pizza_category;

-----OR
SELECT pizza_category, 
	CAST(SUM(total_price) AS decimal(10,2))  Total_Sales, 
	CAST(SUM(total_price) *100/(SELECT SUM(total_price) FROM DBO.pizza_sales) AS decimal(10,2)) AS Percentage
from dbo.pizza_sales
GROUP BY pizza_category;

---PERCENTYAGE OF SALES BY SIZE
SELECT pizza_size,
	CAST(SUM(total_price) AS decimal(10,2))  Total_Sales, 
	CAST(SUM(total_price) *100/(SELECT SUM(total_price) FROM DBO.pizza_sales) AS decimal(10,2)) AS Percentage
FROM DBO.pizza_sales
WHERE MONTH( order_date) = 1
GROUP BY pizza_size;

---TOTAL SALES BY CATEGORY
SELECT pizza_category, SUM(quantity) as Qty_Sold_Category
FROM DBO.pizza_sales
GROUP BY pizza_category;

---TOP 5 REVENUE GENERATING PIZZA
SELECT TOP 5 pizza_name, SUM(total_price) as Revenue
FROM DBO.pizza_sales
GROUP BY  pizza_name
ORDER BY Revenue DESC;

---BOTTOM 5 REVENUE GENERATING PIZZA
SELECT TOP 5 pizza_name, SUM(total_price) as Revenue
FROM DBO.pizza_sales
GROUP BY  pizza_name
ORDER BY Revenue ASC;

---TOP 5  PIZZA SOLD
SELECT TOP 5 pizza_name, SUM(quantity) as Qty
FROM DBO.pizza_sales
GROUP BY  pizza_name
ORDER BY Qty DESC;

---BOTTOM 5  PIZZA SOLD
SELECT TOP 5 pizza_name, SUM(quantity) as Qty
FROM DBO.pizza_sales
GROUP BY  pizza_name
ORDER BY Qty ASC;

---TOP 5  PIZZA ORDERS
SELECT TOP 5 pizza_name, COUNT(DISTINCT order_id) as Orders
FROM DBO.pizza_sales
GROUP BY  pizza_name
ORDER BY Orders DESC;


---BOTTOM 5  PIZZA ORDERS
SELECT TOP 5 pizza_name, COUNT(DISTINCT order_id) as Orders
FROM DBO.pizza_sales
GROUP BY  pizza_name
ORDER BY Orders ASC;
