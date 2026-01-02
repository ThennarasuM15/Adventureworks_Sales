create database Adventureworks;
go
use Adventureworks;
go

SELECT name FROM sys.tables;

-- Checking Null values:

-- Adven_Customer

EXEC sp_help adven_customer;

select sum(case when customerkey is null then 1 else 0 end) as Custkey,
      sum(case when customer_id is null then 1 else 0 end)as custid,
	  sum(case when customer is null then 1 else 0 end) as cust,
	  sum(case when city is null then 1 else 0 end) city,
	  sum(case when state_province is null then 1 else 0 end) province,
	  sum(case when country_region is null then 1 else 0 end) reg,
	  sum(case when postal_code is null then 1 else 0 end) pcode
	from adven_customer;

--Adven_date

EXEC sp_help adven_date;

SELECT
    SUM(CASE WHEN DateKey IS NULL THEN 1 ELSE 0 END) AS DateKey_Null,
    SUM(CASE WHEN [Date] IS NULL THEN 1 ELSE 0 END) AS Date_Null,
    SUM(CASE WHEN Fiscal_Year IS NULL THEN 1 ELSE 0 END) AS FiscalYear_Null,
    SUM(CASE WHEN Fiscal_Quarter IS NULL THEN 1 ELSE 0 END) AS FiscalQuarter_Null,
    SUM(CASE WHEN [Month] IS NULL THEN 1 ELSE 0 END) AS Month_Null,
    SUM(CASE WHEN Full_Date IS NULL THEN 1 ELSE 0 END) AS FullDate_Null,
    SUM(CASE WHEN MonthKey IS NULL THEN 1 ELSE 0 END) AS MonthKey_Null
FROM adven_date;

--Adven_Product

EXEC sp_help adven_product;

SELECT
    SUM(CASE WHEN ProductKey IS NULL THEN 1 ELSE 0 END) AS ProductKey_Null,
    SUM(CASE WHEN SKU IS NULL THEN 1 ELSE 0 END) AS SKU_Null,
    SUM(CASE WHEN Product IS NULL THEN 1 ELSE 0 END) AS Product_Null,
    SUM(CASE WHEN Standard_Cost IS NULL THEN 1 ELSE 0 END) AS StandardCost_Null,
    SUM(CASE WHEN Color IS NULL THEN 1 ELSE 0 END) AS Color_Null,
    SUM(CASE WHEN List_Price IS NULL THEN 1 ELSE 0 END) AS ListPrice_Null,
    SUM(CASE WHEN Model IS NULL THEN 1 ELSE 0 END) AS Model_Null,
    SUM(CASE WHEN Subcategory IS NULL THEN 1 ELSE 0 END) AS Subcategory_Null,
    SUM(CASE WHEN Category IS NULL THEN 1 ELSE 0 END) AS Category_Null
FROM Adven_product;

-- Adven_Reseller

EXEC sp_help adven_reseller;

SELECT
    SUM(CASE WHEN ResellerKey IS NULL THEN 1 ELSE 0 END) AS ResellerKey_Null,
    SUM(CASE WHEN Reseller_ID IS NULL THEN 1 ELSE 0 END) AS ResellerID_Null,
    SUM(CASE WHEN Business_Type IS NULL THEN 1 ELSE 0 END) AS BusinessType_Null,
    SUM(CASE WHEN Reseller IS NULL THEN 1 ELSE 0 END) AS Reseller_Null,
    SUM(CASE WHEN City IS NULL THEN 1 ELSE 0 END) AS City_Null,
    SUM(CASE WHEN State_Province IS NULL THEN 1 ELSE 0 END) AS StateProvince_Null,
    SUM(CASE WHEN Country_Region IS NULL THEN 1 ELSE 0 END) AS CountryRegion_Null,
    SUM(CASE WHEN Postal_Code IS NULL THEN 1 ELSE 0 END) AS PostalCode_Null
FROM adven_reseller;


--Adven_Sales

EXEC sp_help adven_sales;

SELECT
    SUM(CASE WHEN SalesOrderLineKey IS NULL THEN 1 ELSE 0 END) AS SalesOrderLineKey_Null,
    SUM(CASE WHEN ResellerKey IS NULL THEN 1 ELSE 0 END) AS ResellerKey_Null,
    SUM(CASE WHEN CustomerKey IS NULL THEN 1 ELSE 0 END) AS CustomerKey_Null,
    SUM(CASE WHEN ProductKey IS NULL THEN 1 ELSE 0 END) AS ProductKey_Null,
    SUM(CASE WHEN OrderDateKey IS NULL THEN 1 ELSE 0 END) AS OrderDateKey_Null,
    SUM(CASE WHEN DueDateKey IS NULL THEN 1 ELSE 0 END) AS DueDateKey_Null,
    SUM(CASE WHEN ShipDateKey IS NULL THEN 1 ELSE 0 END) AS ShipDateKey_Null,
    SUM(CASE WHEN SalesTerritoryKey IS NULL THEN 1 ELSE 0 END) AS SalesTerritoryKey_Null,
    SUM(CASE WHEN Order_Quantity IS NULL THEN 1 ELSE 0 END) AS OrderQuantity_Null,
    SUM(CASE WHEN Unit_Price IS NULL THEN 1 ELSE 0 END) AS UnitPrice_Null,
    SUM(CASE WHEN Extended_Amount IS NULL THEN 1 ELSE 0 END) AS ExtendedAmount_Null
FROM adven_sales;

--Adven_Sales_Territory

EXEC sp_help 'adven_sales terittory';

SELECT
    SUM(CASE WHEN SalesTerritoryKey IS NULL THEN 1 ELSE 0 END) AS SalesTerritoryKey_Null,
    SUM(CASE WHEN Region IS NULL THEN 1 ELSE 0 END) AS Region_Null,
    SUM(CASE WHEN Country IS NULL THEN 1 ELSE 0 END) AS Country_Null,
    SUM(CASE WHEN [Group] IS NULL THEN 1 ELSE 0 END) AS Group_Null
FROM "adven_sales terittory";


--Adven_sales_order

EXEC sp_help adven_sales_order;

SELECT
    SUM(CASE WHEN Channel IS NULL THEN 1 ELSE 0 END) AS Channel_Null,
    SUM(CASE WHEN SalesOrderLineKey IS NULL THEN 1 ELSE 0 END) AS SalesOrderLineKey_Null,
    SUM(CASE WHEN Sales_Order IS NULL THEN 1 ELSE 0 END) AS SalesOrder_Null,
    SUM(CASE WHEN Sales_Order_Line IS NULL THEN 1 ELSE 0 END) AS SalesOrderLine_Null
FROM adven_sales_order;

-- ## Adhoc Requests

-- 1) Identify order lines where Extended_Amount ≠ Order_Quantity × Unit_Price and quantify revenue leakage

select o.sales_order_line,s.Extended_amount,(s.order_quantity*s.unit_price) as order_price ,
(s.extended_amount - (s.order_quantity*s.unit_price)) as leakage 
from adven_sales s join adven_sales_order o 
on o.SalesOrderLineKey=s.SalesOrderLineKey 
where (s.extended_amount - (s.order_quantity*s.unit_price))!= 0; 

-- Observation : From the results there is no Leakage in any order_line


--2) Find products with low total revenue but highest QoQ growth rate.

select * from adven_sales;
select * from adven_date;
select * from adven_product;

ALTER TABLE adven_date
ADD datekey_ nvarchar(8);

UPDATE adven_date
SET datekey_ =REPLACE(datekey, '-', '');

select * from adven_date;

WITH cte AS (
    SELECT
        s.ProductKey,
        s.Extended_Amount
        p.Product,
        d.Fiscal_Quarter,
    FROM adven_sales s
    JOIN adven_product p 
        ON s.ProductKey = p.ProductKey
    JOIN adven_date d 
        ON d.DateKey = s.OrderDateKey
),
QoQ AS (
    SELECT
        ProductKey,
        Product,
        Fiscal_Quarter,
        SUM(Extended_Amount) AS Rev
    FROM cte
    GROUP BY ProductKey, Product, Fiscal_Quarter
),
QoQ_pct AS (
    SELECT
        *,
        (Rev - LAG(Rev) OVER (
            PARTITION BY ProductKey 
            ORDER BY Fiscal_Quarter
        )) * 100.0 
        / LAG(Rev) OVER (
            PARTITION BY ProductKey 
            ORDER BY Fiscal_Quarter
        ) AS QoQ_Growth_Pct
    FROM QoQ
)
SELECT TOP 1
    ProductKey,
    Product,
    SUM(Rev) AS Total_Revenue,
    AVG(QoQ_Growth_Pct) AS Avg_QoQ_Growth
FROM QoQ_pct
GROUP BY ProductKey, Product
ORDER BY Avg_QoQ_Growth DESC;

--3)  What % of total revenue comes from top 5% of customers?

WITH cte AS (
    SELECT
        customerkey,
        SUM(sales_amount) AS rev
    FROM adven_sales
    GROUP BY customerkey
),
sep AS (
    SELECT
        *,
        NTILE(20) OVER (ORDER BY rev DESC) AS rnk
    FROM cte
)
SELECT
    100.0 * 
    (SELECT SUM(rev) FROM sep WHERE rnk = 1)
    /
    (SELECT SUM(rev) FROM cte) AS top_5_percent_revenue_pct;

--4) Which territories have below-average revenue per customer despite high order volume?

select * from "adven_sales terittory";
select * from Adven_Sales;

WITH base AS (
    SELECT
        s.SalesTerritoryKey,
        t.Region,
        t.Country,
        t.[Group],
        s.CustomerKey,
        s.SalesOrderLineKey,
        s.Sales_Amount
    FROM Adven_Sales s
    JOIN [Adven_Sales Terittory] t
        ON s.SalesTerritoryKey = t.SalesTerritoryKey
),

territory_metrics AS (
    SELECT
        SalesTerritoryKey,
        Region,
        Country,
        [Group],
        SUM(Sales_Amount) AS territory_revenue,
        COUNT(DISTINCT CustomerKey) AS territory_customers,
        COUNT(SalesOrderLineKey) AS territory_order_volume,
        SUM(Sales_Amount) * 1.0 / COUNT(DISTINCT CustomerKey) AS rev_per_customer
    FROM base
    GROUP BY
        SalesTerritoryKey,
        Region,
        Country,
        [Group]
),

global_benchmarks AS (
    SELECT
        SUM(Sales_Amount) * 1.0 / COUNT(DISTINCT CustomerKey) AS global_avg_rev_per_customer,
        COUNT(SalesOrderLineKey) * 1.0 / COUNT(DISTINCT SalesTerritoryKey) AS global_avg_order_volume
    FROM base
)

SELECT
    tm.SalesTerritoryKey,
    tm.Region,
    tm.Country,
    tm.[Group],
    tm.rev_per_customer,
    tm.territory_order_volume
FROM territory_metrics tm
CROSS JOIN global_benchmarks gb
WHERE
    tm.rev_per_customer < gb.global_avg_rev_per_customer
    AND tm.territory_order_volume > gb.global_avg_order_volume
ORDER BY tm.territory_order_volume DESC;

--5) Did online sales increase in regions where reseller sales declined?
select * from Adven_Reseller;
select * from "adven_sales terittory";
select * from Adven_Sales;
select * from Adven_Sales where ResellerKey='-1'; 

-- Without Time comparison 
with c1 as (select t.Region,t.Country,s.ResellerKey,s.Sales_Amount from [Adven_Sales Terittory] t join Adven_Sales s on t.SalesTerritoryKey=s.SalesTerritoryKey),
     c2 as (select region,country,resellerkey,sum(sales_amount) rev from c1 group by region,country,resellerkey)
	 select region,country, sum(case when resellerkey='-1' then rev else 0 end) as Online_sales,
	        sum(case when resellerkey !='-1' then rev else 0 end) as Reseller_sales from c2 group by region,country;


select * from Adven_Date;

--With Time Comparison

WITH base AS (
    SELECT
        t.Region,
        d.Fiscal_Year AS yr,
        SUM(CASE WHEN s.ResellerKey = -1 THEN s.Sales_Amount ELSE 0 END) AS online_rev,
        SUM(CASE WHEN s.ResellerKey <> -1 THEN s.Sales_Amount ELSE 0 END) AS reseller_rev
    FROM Adven_Sales s
    JOIN [Adven_Sales Terittory] t
        ON s.SalesTerritoryKey = t.SalesTerritoryKey
    JOIN Adven_Date d
        ON s.OrderDateKey = d.DateKey
    GROUP BY
        t.Region,
        d.Fiscal_Year
),
growth AS (
    SELECT
        Region,
        yr,
        online_rev,
        reseller_rev,
        online_rev - LAG(online_rev) OVER (PARTITION BY Region ORDER BY yr) AS online_change,
        reseller_rev - LAG(reseller_rev) OVER (PARTITION BY Region ORDER BY yr) AS reseller_change
    FROM base
)
SELECT *
FROM growth
WHERE
    online_change > 0
    AND reseller_change < 0;

--6) Which products maintain stable demand despite unit price increases?

select * from Adven_Product; 
select * from Adven_Sales;

select distinct productkey,Unit_Price from adven_sales order by ProductKey;

WITH base AS (
    SELECT
        p.ProductKey,
        p.Product,
        s.Unit_Price,
        COUNT(*) AS demand
    FROM Adven_Product p
    JOIN Adven_Sales s
        ON p.ProductKey = s.ProductKey
    GROUP BY
        p.ProductKey,
        p.Product,
        s.Unit_Price
),
cmp AS (
    SELECT *,
        Unit_Price - LAG(Unit_Price)
            OVER (PARTITION BY ProductKey ORDER BY Unit_Price) AS price_diff,
        demand - LAG(demand)
            OVER (PARTITION BY ProductKey ORDER BY Unit_Price) AS demand_diff
    FROM base
),
valid_products AS (
    SELECT ProductKey
    FROM cmp
    GROUP BY ProductKey
    HAVING
        SUM(
            CASE
                WHEN price_diff > 0 AND demand_diff < 0 THEN 1
                ELSE 0
            END
        ) = 0
)
SELECT
    c.ProductKey,
    c.Product,
    c.Unit_Price,
    c.demand
FROM cmp c
JOIN valid_products v
    ON c.ProductKey = v.ProductKey
ORDER BY
    c.ProductKey,
    c.Unit_Price;


--7) Which categories rely on fewer than 3 products for more than 60% of revenue?

select * from adven_sales_order;
select * from Adven_Product; 
select * from Adven_Sales;

with base as(select p.category, p.productkey,sum(s.sales_amount) rev,dense_rank() 
       over(partition by p.category order by sum(s.sales_amount)desc) Rnk  from adven_product p join adven_sales s on p.productkey=s.productkey 
       group by p.category,p.productkey),
     reven as (select category,count(distinct productkey) produc,sum(rev) tot_rev,sum(case rnk when 1 then rev when 2 then rev when 3 then rev else 0 end ) top3  
       from base group by category)
	   select * from reven where top3 > 0.6*tot_rev;

-- # So there is no category which relies on only 3 products for more than 60% of its total revenue


--8) Compare product category rankings between peak and off-peak seasons

-- identifying peak season:
select * from adven_date;
select * from adven_sales; 
with base as (select p.category,d.fiscal_quarter,sum(s.sales_amount) rev from adven_sales s join adven_product p on s.ProductKey=p.ProductKey join adven_date d on s.OrderDateKey=d.datekey
     group by p.category,d.fiscal_quarter)
select category,sum(case when fiscal_quarter like '%Q1' then rev else 0 end) as Q1,sum(case when fiscal_quarter like '%Q2' then rev else 0 end) as Q2,
  sum(case when fiscal_quarter like '%Q3' then rev else 0 end) as Q3,sum(case when fiscal_quarter like '%Q4' then rev else 0 end) as Q4 from base group by category;

  -- Results states that Q1 is peak season and Q3 is off-peak season
with base as (select p.category,d.fiscal_quarter,sum(s.sales_amount) rev from adven_sales s join adven_product p on s.ProductKey=p.ProductKey join adven_date d on s.OrderDateKey=d.datekey
     group by p.category,d.fiscal_quarter),
quarters as (select category,sum(case when fiscal_quarter like '%Q1' then rev else 0 end) as Q1,sum(case when fiscal_quarter like '%Q2' then rev else 0 end) as Q2,
       sum(case when fiscal_quarter like '%Q3' then rev else 0 end) as Q3,sum(case when fiscal_quarter like '%Q4' then rev else 0 end) as Q4 
	   from base group by category)
select category,Q1,DENSE_RANK() over (order by Q1 desc) as peak_Rnk ,Q3,DENSE_RANK() over (order by Q3 desc) as off_peak_Rnk from quarters
   order by category;

--9) Identify high-value customers who stopped purchasing in the last 90 days.

select * from adven_customer;
select * from adven_sales;
select * from adven_date;
select max(date) as max_date,min(date) min_date from adven_date; -- max date = 2021-06-30 so the benchmark_date would be 2021-04-01

with base as (select c.customerkey,c.customer,max(d.[date]) max_dt,sum(s.sales_amount) rev from adven_sales s join Adven_Customer c on s.customerkey=c.customerkey 
         join adven_date d on s.orderdatekey=d.datekey group by c.customerkey,c.customer),
		 customer_value as (select *,NTILE(10) over(order by rev desc) cust_val from base)
		select * from customer_value where cust_val =1 and max_dt < '2021-04-01';

--10) Revenue per order vs revenue per customer by territory — which region is inefficient?
select * from [Adven_Sales Terittory];
with base as (select t.*,sum(s.sales_amount) rev,count(*) Tot_orders,count(distinct s.customerkey) Tot_Cust 
from [Adven_Sales Terittory] t join Adven_Sales s on t.SalesTerritoryKey=s.SalesTerritoryKey group by t.Salesterritorykey,t.region,t.country,t.[Group])
select salesterritorykey,region,country,[group],rev*1.0/tot_orders as rev_per_ord,rev*1.0/tot_cust as rev_per_cust from base;

--Preparation for Visualization

Select * from Adven_Customer

ALTER TABLE Adven_Customer
ADD revenue_rank INT,
    customer_percentage DECIMAL(10,4),
    customer_segment VARCHAR(20);


WITH ranked AS (
    SELECT
        c.CustomerKey,
        RANK() OVER (ORDER BY SUM(s.Sales_Amount) DESC) AS revenue_rank,
        COUNT(*) OVER () AS total_customers
    FROM Adven_Customer c
    JOIN Adven_Sales s
        ON c.CustomerKey = s.CustomerKey
    GROUP BY c.CustomerKey
)
UPDATE c
SET
    c.revenue_rank = r.revenue_rank,
    c.customer_percentage = 1.0 * r.revenue_rank / r.total_customers,
    c.customer_segment =
        CASE
            WHEN 1.0 * r.revenue_rank / r.total_customers <= 0.05 THEN 'Top 5%'
            WHEN 1.0 * r.revenue_rank / r.total_customers <= 0.20 THEN 'Top 6-15%'
            WHEN 1.0 * r.revenue_rank / r.total_customers <= 0.50 THEN 'Top 16-50%'
            ELSE 'Bottom 50%'
        END
FROM Adven_Customer c
JOIN ranked r
    ON c.CustomerKey = r.CustomerKey;


Select * from Adven_Customer

select * from Adven_Sales;

Select * from Adven_Date;


Alter table adven_customer add First_order_date date,last_order_date date;

with base as (Select c.customerkey,MAX(d.[date]) Last_order_date ,MIN(d.[date]) First_order_date from adven_customer c join Adven_Sales s on c.CustomerKey=s.CustomerKey Join Adven_Date d on s.OrderDateKey=d.DateKey
group by C.CustomerKey)
update c 
set c.First_order_date= b.first_order_date,
    c.last_order_date= b.last_order_date from Adven_Customer c join base b on c.CustomerKey=b.CustomerKey;


SELECt count(distinct revenue_rank) from adven_Customer;

select * from (select customerkey, datediff(day,first_order_date,last_order_date) as diff from adven_customer) as sub where diff>0;