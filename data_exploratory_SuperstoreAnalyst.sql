-- Data Exploration

SELECT * from superstore_bkp2;

-- 1.Total Sales & Total Profit
SELECT 
	YEAR(OrderDate) AS Years,
    sum(Sales) AS Total_Sale,
    sum(Profit) AS Total_Profit
FROM superstore_bkp2
GROUP BY Years
ORDER BY Years ASC;

-- 1.What are the total profit and total sales per quarter and per Year

SELECT 
	YEAR(OrderDate) AS Years,
	CASE 
		WHEN MONTH(OrderDate) IN (1,2,3) THEN 'Q1'
        WHEN MONTH(OrderDate) IN (4,5,6) THEN 'Q2'
        WHEN MONTH(OrderDate) IN (7,8,9) THEN 'Q3'
        ELSE  'Q4'
        END AS Quarter ,
	sum(Sales) AS Total_Sale,
    sum(Profit) AS Total_Profit
FROM superstore_bkp2
GROUP BY Years,Quarter 
ORDER BY  Years,Quarter ;

-- 2.What regions generates the highest sales and profits
select Region from superstore_bkp2;

select 
	Region,
	sum(Sales) AS Total_Sale,
    sum(Profit) AS Total_Profit
FROM superstore_bkp2
group by Region
ORDER BY  Total_Profit DESC;


-- 3.Find Profit Margin
select 
	Region,
	sum(Sales) AS Total_Sale,
    sum(Profit) AS Total_Profit,
    (sum(Profit)/sum(Sales)) *100 AS Total_ProfitMargin
FROM superstore_bkp2
group by Region
ORDER BY  Total_Profit DESC;


-- 4.What State and city bring in the highest sales and profit
-- Top 10 highest sales and profit
SELECT 	
		YEAR(OrderDate) AS Years,
        State,
        sum(Sales),
        sum(Profit) AS Total_Profit
FROM superstore_bkp2
GROUP BY Years,State
ORDER BY Total_Profit DESC
;

-- Bottom 10 lowest sales and profit
SELECT 	
		YEAR(OrderDate) AS Years,
        State,
        sum(Sales),
        sum(Profit) AS Total_Profit
FROM superstore_bkp2
GROUP BY Years,State
ORDER BY Total_Profit ASC
;

-- Highest sale by City
SELECT 
city,
sum(Sales) AS Total_Sales,
sum(Profit) AS Total_Profits,
(sum(Profit)/sum(Sales))*100 AS Profit_Margin
FROM superstore_bkp2
GROUP BY city
ORDER BY Total_Profits DESC
LIMIT 10;

-- 5. The Relationship between discount and sales and total discount per category

	SELECT Discount ,
		   AVG(Sales) AS Average_sale
	From superstore_bkp2
    GROUP BY Discount
    ORDER BY Average_sale DESC;
    
-- we want to see What categories that make a top sale by discount ?

 SELECT 
	Category,
    ROUND(sum(Discount),2) AS Total_Discount
 FROM superstore_bkp2
 GROUP BY Category
 ORDER BY Total_Discount DESC;

-- What sub categories that make a top discount

SELECT Category,
	   SubCategory,
       ROUND(sum(Discount),2) AS Totaldiscount 
from superstore_bkp2
group by Category,SubCategory
ORDER BY Totaldiscount DESC;
-- Summarise ; Office Supplies are the top of give discount to our customer  and 2nd is Phone and Furnishing

-- What category generates the highest sales and profits in each region and state?

-- First Let see the highest sale and profit by category with thier profit margin
	
    SELECT Category,
		   sum(Sales) AS Total_Sales,
           sum(Profit) AS Total_Profits,
           (sum(Profit)/sum(Sales))*100 AS Net_Margin
    FROM superstore_bkp2
    GROUP BY Category
    ORDER BY Total_Profits DESC;
    
    -- Let's observe the highest sales and total profits per Category in each region
SELECT 
	Region,
	Category,
    sum(Sales)  AS Total_Sales,
    sum(Profit) AS Total_Profits,
    (sum(Profit)/sum(Sales))*100 AS Net_Margin
FROM superstore_bkp2
group by Region,Category
ORDER BY Total_Profits DESC;
 -- Central Region with Technology is operate at a loss
 -- West Region with a Tech  is our top 5 and still have an operate outstanding on Profitability.
 
-- Let's see Highest total sales and total profits per Category in each state...
SELECT 
	state,
    category,
    sum(Sales) AS Total_Sales,
    sum(Profit) AS Total_Profits
FROM superstore_bkp2
GROUP BY state,Category
ORDER BY Total_Profits DESC;

	-- The Query above shows the most performing categories in each our states . Office supplies in Georgia / New York & California are around good for our top 3 markets except the furnitures	
-- Let's check about at least profitable ones

SELECT 
	state,
    category,
    sum(Sales) AS Total_Sales,
    sum(Profit) AS Total_Profits
FROM superstore_bkp2
GROUP BY state,Category
ORDER BY Total_Profits ASC;

    -- We will can see in our Tech at North Carolina and Pennsylvania & Illonois for Furniture is our biggest losses 

-- What subcategories generates the highest sales and profits in each regions and state?

-- Let see about subcategorise by sales and profit ...
	SELECT SubCategory,
		   sum(Sales) AS TT_Sale,
           sum(Profit) AS TT_Profit
    FROM superstore_bkp2
    GROUP BY SubCategory
    ORDER BY TT_Profit DESC;
  -- From above query you can see the binder  Copier and Accessories are our top 3 which can make a max profitable for our company

	/*SELECT 
		Region,
        State,
        sum(Sales) AS Total_Sales,
        sum(Profit) AS Total_Profits
    FROM superstore_bkp2
    GROUP BY Region,State
    ORDER BY Total_Profits DESC;*/
    
   -- Now Let's see about What subcategorise can make the top profit in each regions
	 SELECT 
		Region,
        SubCategory,
        sum(Sales) AS Total_Sale,
        sum(Profit) AS Total_Profit ,
        round((sum(Profit)/sum(Sales))*100,2) AS Percent_Profit_Margin
     FROM superstore_bkp2
	 GROUP BY Region,SubCategory
     ORDER BY Total_Profit DESC;
     -- These above display about the best subcategories per region 
-- Now let's see the least performing ones ;
	SELECT 
		Region,
        SubCategory,
        sum(Sales) AS Total_Sale,
        sum(Profit) AS Total_Profit ,
        round((sum(Profit)/sum(Sales))*100,2) AS Percent_Profit_Margin
     FROM superstore_bkp2
	 GROUP BY Region,SubCategory
     ORDER BY Total_Profit ASC;
     -- the machine abd Table from each regions are our biggest losses in profits
-- Let's see about What subcategorise can make the top profit in each states
SELECT 
		state,
        SubCategory,
        sum(Sales) AS Total_Sale,
        sum(Profit) AS Total_Profit ,
        round((sum(Profit)/sum(Sales))*100,2) AS Percent_Profit_Margin
     FROM superstore_bkp2
	 GROUP BY state,SubCategory
     ORDER BY Total_Profit DESC;

-- Lets see the lowest sales and profit 
SELECT 
		state,
        SubCategory,
        sum(Sales) AS Total_Sale,
        sum(Profit) AS Total_Profit ,
        round((sum(Profit)/sum(Sales))*100,2) AS Percent_Profit_Margin
     FROM superstore_bkp2
	 GROUP BY state,SubCategory
     ORDER BY Total_Profit ASC;
		-- Machines are our biggest loss in Texas abd illinois so , We should to think first before we filled and Order the stocks.alter

-- What's are the names of the products that are the most and least profitable to us;
	-- Let's see the most profitability First,
	SELECT 
		ProductName,
        sum(Sales) AS TT_Sales,
        sum(Profit) AS TT_Profits,
        round((sum(Profit)/sum(Sales)*100),2) AS Net_Margin
    FROM superstore_bkp2
    GROUP BY ProductName
    ORDER BY TT_Profits DESC;
    -- The binders Electric  are our top 3 which make top profitability in our OfficeSupplies, so we should keep up the stock with these

-- Let's see at least losses profitability after,
	SELECT 
		ProductName,
        sum(Sales) AS TT_Sales,
        sum(Profit) AS TT_Profits,
        round((sum(Profit)/sum(Sales)*100),2) AS Net_Margin
    FROM superstore_bkp2
    GROUP BY ProductName
    ORDER BY TT_Profits ASC;
 -- The printer is our top 3 lowest the losses of profit_margin
 
 -- 9. What segment makes the most of our profits and sales
	SELECT Segment,
			sum(Sales) AS TT_Sales,
			sum(Profit) AS TT_Profits,
            round((sum(Profit)/sum(Sales)*100),2) AS Net_Margin
    FROM superstore_bkp2
    GROUP BY Segment
    ORDER BY TT_Profits DESC;
    -- The Home office segment are brings the most profit followed by Consumer and then Corporate

-- 10. How many customers do we have (uniques customers IDs) in total and how much per regions

-- First we need to know How much customer we have 
		SELECT count( distinct CustomerID) AS Total_customers
        FROM superstore_bkp2;
	-- We have 287 customers between 2014 to 2017 .
-- Total customer by regions
	SELECT 
		Region,
        count(distinct CustomerID) AS Total_customers
	FROM superstore_bkp2
    GROUP BY Region;
		-- Customer are moving around regions which we can explains why they all do not add up to 287 . Since ther could be double counting and west is biggest market of all .

-- Where are customer are living by state?
SELECT 
		state,
        count(distinct CustomerID) AS Total_customers
	FROM superstore_bkp2
    GROUP BY state
    ORDER BY Total_customers DESC;
    
    -- We have the most customers in California New Yorks and Texas 

SELECT
        state,
        count(distinct CustomerID) AS Total_customers
	FROM superstore_bkp2
    GROUP BY state
    ORDER BY Total_customers ASC;
-- We have at least customers in Montana, Nebraska and Arkansas ;

-- 11. Customer Reward programs loyalty and we want to keep these customerid to create  a long term  profitability.

	SELECT CustomerID,
		sum(Sales) AS TT_Sales,
        sum(Profit) AS TT_Profits
    FROM superstore_bkp2
    GROUP BY CustomerID
    ORDER BY TT_Sales DESC
    LIMIT 15 ;
    
-- 12.Average shipping time per class and total

SELECT ROUND(AVG(shipdate- orderdate),2) AS AVG_shipping_times
FROM superstore_bkp2;
    
-- 13. AVG Ship time by Shipmode
SELECT 
shipmode,ROUND(AVG(shipdate- orderdate),2) AS AVG_shipping_times
FROM superstore_bkp2
GROUP BY shipmode
ORDER BY AVG_shipping_times ASC;

