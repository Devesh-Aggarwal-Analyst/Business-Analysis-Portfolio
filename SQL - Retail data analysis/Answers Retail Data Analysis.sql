create database SQLCASESTUDY2

SELECT * FROM Transactions
select * from Customer
select * from prod_cat_info

--DATA PREPARATION AND UNDERSTANDING 

--Q1
SELECT 'transactions' as tbl_name ,count(*) as total_rows FROM Transactions union all
select 'customers' as tbl_name , count(*) as total_rows from Customer union all
select 'prod_cat_info' as tbl_name ,count(*) as total_rows from prod_cat_info

--Q2
select count(*) as return_ord from Transactions
where Rate < 1

--Q3
select tran_date as originaldate,
convert(varchar(10),cast(tran_date as date),103) as  coverted_date
from Transactions

--Q4
SELECT DATEDIFF(DAY, MIN(tran_date), MAX(tran_date)) AS Number_Days,
 DATEDIFF(MONTH, MIN(tran_date), MAX(tran_date)) AS Number_Months,
 DATEDIFF(YEAR, MIN(tran_date), MAX(tran_date)) AS Number_Years
FROM Transactions

--Q5
select prod_cat AS PRODUCT_CATEGORY from prod_cat_info
where prod_subcat = 'DIY'

--DATA ANALYSIS 

--Q1
select top 1 Store_type from Transactions
group by Store_type
order by COUNT(store_type) desc

--Q2
select 
count(case when gender = 'm' then 0 end) as malecount,
count(case when gender = 'f' then 0 end) as femalecount
from Customer

--Q3
select top 1 city_code, COUNT(city_code) as count_cust from Customer
group by city_code
order by COUNT(city_code) desc

--Q4
SELECT DISTINCT COUNT(PROD_SUBCAT)  FROM prod_cat_info
WHERE prod_cat = 'BOOKS'

--Q5
SELECT MAX(QTY) FROM Transactions

--Q6
SELECT SUM(TOTAL_AMT) AS NET_TOTAL_REVENUE FROM Transactions 
WHERE prod_cat_code IN (3,5)

--Q7
SELECT COUNT(P.cust_id)
FROM
(
SELECT  cust_id, count(QTY) AS SUM_QTY FROM Transactions
WHERE QTY > 0
GROUP BY cust_id
) P 
WHERE SUM_QTY > 10

--Q8
SELECT SUM(total_amt) FROM Transactions
WHERE prod_cat_code IN (1,3)
AND Store_type = 'Flagship store'

--Q9
SELECT SUM(T.TOTAL_AMT) total_amount, T.prod_subcat_code FROM Transactions T
JOIN Customer C
ON T.cust_id = C.customer_Id
WHERE GENDER = 'M'
and t.prod_subcat_code in (4,5,8,9,10)
group by t.prod_subcat_code

--Q10



--Q11

WITH CTE1 AS
(
select SUM(T.total_amt) AS TOTAL_REVENUE,T.cust_id ,  DATEDIFF(YEAR,C.DOB,GETDATE()) AS AGE, MAX(T.tran_date) OVER() AS MAXTRANS,
DATEDIFF(DAY,T.tran_date,MAX(T.tran_date) OVER()) AS DATEDIFFERENCE from Transactions t
join Customer c
on t.cust_id = c.customer_Id
GROUP BY  C.DOB, T.cust_id, T.tran_date
)
SELECT TOTAL_REVENUE, DATEDIFFERENCE  from CTE1
WHERE AGE BETWEEN 25 AND 35
AND DATEDIFFERENCE <= 30


--Q12

select top 1 prod_cat_code,
sum(total_amt) over (partition by prod_cat_code) as tota
from Transactions 
where qty < 1
order by tota asc

--Q13

select top 1 store_type,
sum(total_amt) over ( partition by store_type) as sales_amt ,
sum(qty) over (partition by store_type) as qty_sold
from Transactions
order by sales_amt desc, qty_sold desc

--Q14

select distinct a.prod_cat_code from
(
select avg(total_amt) over() as avgtotal_amt, prod_cat_code,
avg(total_amt) over (partition by prod_cat_code) as avg_prod
from Transactions
) a
where avgtotal_amt < avg_prod

--Q15

with cte2 as
(
select *,
sum(qty) over ( partition by prod_subcat_code) as sum_prod,
sum(total_amt) over ( partition by prod_subcat_code) as tot_prod,
avg(total_amt) over ( partition by prod_subcat_code) as avg_prod
from Transactions
order by sum_prod DESC, tot_prod DESC, avg_prod desc
)
select avg(total_amt) from cte2