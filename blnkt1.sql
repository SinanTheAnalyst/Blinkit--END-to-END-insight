create database blnkt_prjct;

use blnkt_prjct;

select * from blinkit;

select count(*) from blinkit;

SET SQL_SAFE_UPDATES = 0;

update blinkit
set `item fat content` = 
case 
when `item fat content` in ('LF', 'low fat') then 'Low Fat'
when `item fat content` = 'reg' then 'Regular'
else `item fat content`
end;

SELECT *
FROM blinkit
WHERE  `Item Weight` = "";

UPDATE blinkit
SET `Item Weight` = NULL
WHERE `Item Weight` = '';

WITH ordered_data AS (
    SELECT 
        `Item Weight`,
        ROW_NUMBER() OVER (ORDER BY `Item Weight`) AS row_num,
        COUNT(*) OVER () AS total_rows
    FROM blinkit
    WHERE `Item Weight` IS NOT NULL
)

SELECT AVG(`Item Weight`) AS median_value
FROM ordered_data
WHERE row_num IN (
    FLOOR((total_rows + 1) / 2),
    FLOOR((total_rows + 2) / 2)
);

UPDATE blinkit
SET `Item Weight` = 18.25
WHERE `Item Weight` IS NULL;

select sum(Sales) as total_sales from blinkit;

select cast(sum(sales)/1000000 as decimal(10,2)) as total_sales_millions from blinkit where `item fat content`='Low Fat' ;

select cast(avg(sales) as decimal(10,2)) as avg_sales from blinkit where `Outlet Establishment Year` = 2022;

select count(*) as no_of_items from blinkit where `Outlet Establishment Year` = 2022;

select cast(avg(rating) as decimal(10,2)) as avg_rating from blinkit;

select `Item Fat Content`,
          cast(sum(sales)/1000 as decimal(10,2)) as total_sales,
		  cast(avg(sales) as decimal(10,2)) as avg_sales,
          count(*) as no_of_items,
          cast(avg(rating) as decimal(10,2)) as avg_rating
 from blinkit
 where `Outlet Establishment Year` = 2020
 group by `Item Fat Content` 
 order by total_sales desc;
 
 select  `Item Type`,
          cast(sum(sales) as decimal(10,2)) as total_sales,
		  cast(avg(sales) as decimal(10,2)) as avg_sales,
          count(*) as no_of_items,
          cast(avg(rating) as decimal(10,2)) as avg_rating
 from blinkit
 where `Outlet Establishment Year` = 2020
 group by `Item Type` 
 order by total_sales desc
 limit 5;
 
 select  `Item Fat Content`,`Outlet Location Type`,
          cast(sum(sales) as decimal(10,2)) as total_sales,
		  cast(avg(sales) as decimal(10,2)) as avg_sales,
          count(*) as no_of_items,
          cast(avg(rating) as decimal(10,2)) as avg_rating
 from blinkit
 group by `Item Fat Content`,`Outlet Location Type`
 order by total_sales asc;
 
 SELECT `Outlet Location Type`,
       CAST(SUM(CASE 
                    WHEN `Item Fat Content` = 'Low Fat' 
                    THEN Sales 
                    ELSE 0 
                END) AS DECIMAL(10,2)) AS Low_Fat,

       CAST(SUM(CASE 
                    WHEN `Item Fat Content` = 'Regular' 
                    THEN Sales 
                    ELSE 0 
                END) AS DECIMAL(10,2)) AS Regular
FROM blinkit
GROUP BY `Outlet Location Type`
ORDER BY `Outlet Location Type`;

select `Outlet Establishment Year`,
cast(sum(sales) as decimal(10,2)) as total_sales,
 cast(avg(sales) as decimal(10,2)) as avg_sales,
count(*) as no_of_items,
cast(avg(rating) as decimal(10,2)) as avg_rating
from blinkit
group by `Outlet Establishment Year`
order by  total_sales asc;

SELECT 
  `Outlet Size`, 
    CAST(SUM(Sales) AS DECIMAL(10,2)) AS Total_Sales,
    CAST((SUM(Sales) * 100.0 / SUM(SUM(Sales)) OVER()) AS DECIMAL(10,2)) AS Sales_Percentage
FROM blinkit
GROUP BY `Outlet Size`
ORDER BY Total_Sales DESC;

select `Outlet location type`,
cast(sum(sales) as decimal(10,2)) as total_sales,
cast(sum(sales) * 100.0/sum(sum(sales)) over() as decimal(10,2)) as sales_percentage,
cast(avg(sales) as decimal(10,1)) as avg_sales,
count(*) as no_of_items,
cast(avg(rating)as decimal(10,2)) as avg_rating
from blinkit
where `Outlet Establishment Year` = 2020
group by `Outlet location type`
order by total_sales desc;

select `Outlet Type`,
cast(sum(sales) as decimal(10,2)) as total_sales,
cast(sum(sales) * 100.0/sum(sum(sales)) over() as decimal(10,2)) as sales_percentage,
cast(avg(sales) as decimal(10,1)) as avg_sales,
count(*) as no_of_items,
cast(avg(rating)as decimal(10,2)) as avg_rating
from blinkit
group by `Outlet Type`
order by total_sales desc;




 


