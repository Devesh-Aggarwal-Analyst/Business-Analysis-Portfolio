--SQL Advance Case Study


--Q1--BEGIN 
	
select DISTINCT l.State from DIM_LOCATION L
join FACT_TRANSACTIONS f
on l.IDLocation = f.IDLocation
where year(f.date) >= 2005


--Q1--END

--Q2--BEGIN
	
select top 1  L.State from DIM_MODEL M
join FACT_TRANSACTIONS F
on m.IDModel = f.IDModel
join DIM_LOCATION L
on L.IDLocation = F.IDLocation
WHERE L.Country = 'US' AND M.IDManufacturer = 12
group by l.State
order by sum(f.Quantity) desc;

--Q2--END

--Q3--BEGIN      
	
select distinct sum(f.Quantity) as num_trans,f.IDModel, l.State, l.ZipCode from DIM_LOCATION L
join FACT_TRANSACTIONS f
on l.IDLocation = f.IDLocation
group by f.IDModel, l.State, l.ZipCode

--Q3--END

--Q4--BEGIN

select top 1 Model_Name, Unit_price from DIM_MODEL
group by Model_Name, Unit_price
order by min(unit_price)

--Q4--END

--Q5--BEGIN

select 
avg(f.TotalPrice) over ( partition by f.idmodel) as avgpri , d.IDManufacturer, d.Model_Name
from fact_transactions f
join DIM_MODEL d
on f.IDModel = d.IDModel
where  d.IDManufacturer in
(
select top 5  d.IDManufacturer
from  DIM_MODEL d
join FACT_TRANSACTIONS f
on f.IDModel = d.IDModel
group by d.IDManufacturer
order by sum(f.quantity) desc
)
group by f.IDModel, f.TotalPrice,  d.IDManufacturer, d.Model_Name
order by avgpri desc

--Q5--END

--Q6--BEGIN

select  c.Customer_Name, avg(f.totalprice) as avg_amt_spent from DIM_CUSTOMER C
join FACT_TRANSACTIONS F
on c.IDCustomer = f.IDCustomer
where year(f.Date) = 2009
group by c.Customer_Name
having avg(f.totalprice) > 500
 
--Q6--END
	
--Q7--BEGIN  
	
select P.Model_Name
from (
SELECT M.Model_Name, SUM(F.QUANTITY) AS SUM_QUNTTY, YEAR(F.DATE) AS YR,
row_number() OVER ( PARTITION BY YEAR(F.DATE) ORDER BY SUM(F.QUANTITY) DESC) AS QUANTITY_RANK
FROM DIM_MODEL M
JOIN FACT_TRANSACTIONS F
ON M.IDModel = F.IDModel
WHERE YEAR(F.DATE) IN (2008,2009, 2010)
GROUP BY M.Model_Name, YEAR(F.DATE)
) P
WHERE QUANTITY_RANK in (1,2,3,4,5)
AND YR in (2008,2009, 2010) 

--Q7--END	
--Q8--BEGIN

select K.Manufacturer_Name
from (
select d.Manufacturer_Name, YEAR(F.DATE) YR,SUM(F.totalprice) TOTAL_PRICE,
row_number() over( partition by year(f.date) order by sum(f.totalprice) DESC) AS RANK1
from DIM_MODEL M
join DIM_MANUFACTURER D
on m.IDManufacturer = d.IDManufacturer
join FACT_TRANSACTIONS F
 on m.IDModel = f.IDModel
 WHERE YEAR(F.DATE) IN (2009,2010)
 GROUP BY d.Manufacturer_Name, YEAR(F.DATE)
 ) AS K
 WHERE RANK1 = 2

--Q8--END
--Q9--BEGIN	

select m.Manufacturer_Name from DIM_MANUFACTURER M
join DIM_MODEL d
on m.IDManufacturer= d.IDManufacturer
join FACT_TRANSACTIONS f
on f.IDModel = d.IDModel
where year(f.date) = 2010
and m.Manufacturer_Name NOT IN 
(
select m.Manufacturer_Name from DIM_MANUFACTURER M
join DIM_MODEL d
on m.IDManufacturer= d.IDManufacturer
join FACT_TRANSACTIONS f
on f.IDModel = d.IDModel
where year(f.Date) = 2009
)

--Q9--END

--Q10--BEGIN
	
select top 100 C.Customer_Name, sum(f.quantity) from DIM_CUSTOMER C
join FACT_TRANSACTIONS f
on c.IDCustomer = f.IDCustomer
group by c.Customer_Name
order by sum(f.quantity) desc

--Q10--END