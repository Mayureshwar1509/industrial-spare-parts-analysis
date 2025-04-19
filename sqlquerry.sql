USE spare_parts_project;
-- Create Internal Inventory Table
CREATE TABLE InternalInventory (
    Item_Code VARCHAR(20),
    Item_Name VARCHAR(100),
    Category VARCHAR(50),
    Stock INT,
    Reorder_Level INT,
    Avg_Daily_Demand INT,
    Warehouse VARCHAR(50),
    Stock_Status VARCHAR(20)
);
-- Create Scraped Market Data Table
CREATE TABLE ScrapedMarketData (
    Search_Item VARCHAR(100),
    Scraped_Title TEXT,
    Category VARCHAR(50),
    Price DECIMAL(10,2),
    Rating FLOAT,
    Reviews INT,
    Availability VARCHAR(20),
    Seller VARCHAR(100),
    Matched_Item VARCHAR(100)
);

SHOW VARIABLES LIKE "secure_file_priv";
#Understocked Items by Category
SELECT Category, COUNT(*) AS Understocked_Items
FROM InternalInventory
WHERE Stock_Status = 'Understock'
GROUP BY Category
ORDER BY Understocked_Items DESC;

#Warehouse with Highest Overstocked Items
SELECT Warehouse, COUNT(*) AS Overstocked_Items
FROM InternalInventory
WHERE Stock_Status = 'Overstock'
GROUP BY Warehouse
ORDER BY Overstocked_Items DESC;

#Top-Rated Market Products (for Preferred Vendor List)
SELECT Scraped_Title, Price, Rating, Seller
FROM ScrapedMarketData
WHERE Rating >= 4.5 AND Reviews > 100
ORDER BY Rating DESC, Reviews DESC
LIMIT 10;

#Items with High Demand but Understocked
SELECT Item_Name, Stock, Avg_Daily_Demand, Reorder_Level
FROM InternalInventory
WHERE Stock_Status = 'Understock'
  AND Avg_Daily_Demand >= 5
ORDER BY Avg_Daily_Demand DESC;

#Price Distribution by Category
SELECT Category, MIN(Price) AS Min_Price, MAX(Price) AS Max_Price, AVG(Price) AS Avg_Price
FROM ScrapedMarketData
WHERE Price IS NOT NULL
GROUP BY Category;

#Items Not Found in Scraped Listings
SELECT i.Item_Name
FROM InternalInventory i
LEFT JOIN ScrapedMarketData s ON i.Item_Name = s.Matched_Item
WHERE s.Matched_Item IS NULL;

#Stockout Days Estimate
SELECT 
    Item_Name,
    Stock,
    Avg_Daily_Demand,
    ROUND(Stock / Avg_Daily_Demand, 1) AS Days_Until_Stockout
FROM InternalInventory
WHERE Stock_Status = 'Understock'
ORDER BY Days_Until_Stockout ASC;

#Summary for Dashboard KPIs
SELECT 
    COUNT(*) AS Total_Items,
    SUM(CASE WHEN Stock_Status = 'Understock' THEN 1 ELSE 0 END) AS Understocked,
    SUM(CASE WHEN Stock_Status = 'Overstock' THEN 1 ELSE 0 END) AS Overstocked,
    SUM(CASE WHEN Stock_Status = 'Optimum' THEN 1 ELSE 0 END) AS Optimum
FROM InternalInventory;

#Price vs Rating Correlation (Is Higher Price Justified?)
SELECT Price, Rating
FROM ScrapedMarketData
WHERE Price IS NOT NULL AND Rating IS NOT NULL;

#Category-Wise Competition Intensity
SELECT Category, COUNT(DISTINCT Seller) AS Unique_Sellers, COUNT(*) AS Listings
FROM ScrapedMarketData
GROUP BY Category
ORDER BY Unique_Sellers DESC;

# Insight:
#More sellers = higher market competition
#Useful for procurement teams to negotiate better prices

#Most Repeated Sellers (Dominant Vendors)
SELECT Seller, COUNT(*) AS Product_Count
FROM ScrapedMarketData
GROUP BY Seller
ORDER BY Product_Count DESC
LIMIT 10;

#Insight-Helps shortlist frequent sellers or potential bulk sourcing vendors

#Top Value Picks (High Rating, Low Price)
SELECT Scraped_Title, Price, Rating, Reviews
FROM ScrapedMarketData
WHERE Rating >= 4.3 AND Price <= 500 AND Reviews > 50
ORDER BY Rating DESC, Price ASC;

# Insight:These are hidden gems in the market, ideal for cost-saving initiatives

#Rating Distribution
SELECT 
    FLOOR(Rating) AS Rating_Group, 
    COUNT(*) AS Product_Count
FROM ScrapedMarketData
WHERE Rating IS NOT NULL
GROUP BY Rating_Group
ORDER BY Rating_Group DESC;

#Insight:Shows quality concentration — are most products in 3–4 star range or 4+?

#Out-of-Stock Items by Category (Supply Gaps)
SELECT Category, COUNT(*) AS OutOfStock_Count
FROM ScrapedMarketData
WHERE Availability = 'Out of Stock'
GROUP BY Category
ORDER BY OutOfStock_Count DESC;

#Insight:Identify demand spikes or supply shortages in certain spare part categories

#Average Price by Seller (Benchmarking)
SELECT Seller, ROUND(AVG(Price), 2) AS Avg_Price, COUNT(*) AS Listings
FROM ScrapedMarketData
GROUP BY Seller
HAVING COUNT(*) > 3
ORDER BY Avg_Price ASC
LIMIT 10;

#Insight:Rank sellers by price — this helps your team choose lowest average-priced vendors

#High-Review Products with Low Ratings (Risky Options)
SELECT Scraped_Title, Price, Rating, Reviews
FROM ScrapedMarketData
WHERE Reviews > 100 AND Rating < 3.5
ORDER BY Reviews DESC;

#Insight:Even if popular, these may be low quality or misleadingly advertised








