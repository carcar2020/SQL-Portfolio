-- Looking at the Ecommerce Data.
Select * from dbo.kz;



-- Identyfing the top 20 Companies with the highest sales.
SELECT brand, SUM(CAST(price as float)) AS Total
FROM dbo.kz
GROUP BY (brand)
ORDER BY Total DESC;


-- Picking only 10 brands from the top 20 highest sales.
-- Query 1
SELECT brand, SUM(CAST(price as float)) AS Total
FROM dbo.kz
WHERE brand IN ('samsung', 'apple', 'lg', 'bosch','huawei','asus','lenovo','hp','sony','philips')
GROUP BY (brand)
ORDER BY Total DESC;



-- Identifying all Categories 
SELECT DISTINCT category_code
FROM DBO.Kz
ORDER BY category_code DESC;




-- Created view to simplify discovery and cleaned out categories with ' ' values.
-- Selected 10 of the top 20 companies with most sales.
CREATE VIEW Companies_ten AS
SELECT *
FROM dbo.kz
WHERE brand IN ('samsung', 'apple', 'lg', 'bosch','huawei','asus','lenovo','hp','sony','philips') AND category_code <>'';


-- Breaking the category_code column into two new columns ( Category and Item Type).
-- Query 2
select event_time, brand, SUBSTRING(category_code, 1, CHARINDEX('.', category_code)-1) AS Category, REVERSE(PARSENAME(REPLACE(REVERSE(category_code), '.', '.'), 2)) AS Item_Type,
CAST(price AS float) AS Price
FROM  dbo.Companies_ten
WHERE category_code <> ''
ORDER BY brand;



-- Query Used for testing.
SELECT category_code, REVERSE(PARSENAME(REPLACE(REVERSE(category_code), '.', '.'), 2)) AS Item_Type
FROM dbo.Companies_ten;
