-- Data cleaning

-- 0. create a table_backup because in the real work place you not work on the raw data may be i accendentally delete the raw data

create table superstore_bkp
LIKE super_store1

select * from superstore_bkp

insert into superstore_bkp
select * from super_store1

-- 1. Remove duplicated by CTE 

SELECT *,
ROW_NUMBER() OVER(Partition by OrderID,OrderDate,ShipDate,ShipMode,CustomerID,CustomerName,Segment,Country,City,State,PostalCode,Region,ProductID,Category,SubCategory,ProductName) AS RN
FROM superstore_bkp;

WITH Duplicate_cte AS (SELECT *,
ROW_NUMBER() OVER(Partition by OrderID,OrderDate,ShipDate,ShipMode,CustomerID,CustomerName,Segment,Country,City,State,PostalCode,Region,ProductID,Category,SubCategory,ProductName,Sales,Profit) AS RN
FROM superstore_bkp)
select * from Duplicate_cte 
WHERE rn >1;
-- Summary these part is No duplicate values , As you can see in row number not have 2 row

-- Check NULL value

SELECT * FROM superstore_bkp
WHERE Row_ID IS NULL or Row_ID = '' or OrderID IS NULL or OrderID = '' or OrderDate;

-- Time series' Visualization 

SELECT OrderDate, 
str_to_date(OrderDate,'%m/%d/%Y') FROM
superstore_bkp ;

UPDATE superstore_bkp
SET OrderDate = str_to_date(OrderDate,'%m/%d/%Y');

SELECT ShipDate, 
str_to_date(ShipDate,'%m/%d/%Y') from
superstore_bkp ;

UPDATE superstore_bkp
SET ShipDate = str_to_date(ShipDate,'%m/%d/%Y');
-- Check date is correct
SELECT * from superstore_bkp;

-- Break with the adding coumn Year for the new tables
SELECT *, YEAR(OrderDate) AS OrderDate_Year,month(OrderDate) AS OrderDate_Month,substring(OrderDate,9,2) AS OrderDate_Day from superstore_bkp

WITH OrderDate_CTE AS 
(SELECT *, YEAR(OrderDate) AS OrderDate_Year,month(OrderDate) AS OrderDate_Month,substring(OrderDate,9,2) AS OrderDate_Day from superstore_bkp)
SELECT * FROM OrderDate_CTE;

CREATE TABLE `superstore_bkp2` (
  `Row_ID` int DEFAULT NULL,
  `OrderID` text,
  `OrderDate` text,
  `ShipDate` text,
  `ShipMode` text,
  `CustomerID` text,
  `CustomerName` text,
  `Segment` text,
  `Country` text,
  `City` text,
  `State` text,
  `PostalCode` int DEFAULT NULL,
  `Region` text,
  `ProductID` text,
  `Category` text,
  `SubCategory` text,
  `ProductName` text,
  `Sales` decimal(10,2) DEFAULT NULL,
  `Quantity` int DEFAULT NULL,
  `Discount` double DEFAULT NULL,
  `Profit` decimal(10,2) DEFAULT NULL,
  `OrderDate_Year` text ,
  `OrderDate_Month` text,
  `OrderDate_Day` TEXT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

SELECT * FROM superstore_bkp2;

INSERT INTO superstore_bkp2
SELECT *, YEAR(OrderDate) AS OrderDate_Year,month(OrderDate) AS OrderDate_Month,substring(OrderDate,9,2) AS OrderDate_Day from superstore_bkp








