SELECT * FROM ordersTBL
SELECT * FROM CustomersTBL

--Q1
SELECT  SUM(ORDER_TOTAL) FROM ordersTBL

Q2
SELECT SUM(A.ORDER_TOTAL)
FROM
(
SELECT TOP 25  ORDER_TOTAL FROM ordersTBL
ORDER BY ORDER_TOTAL DESC
)A


--Q3
SELECT * FROM ordersTBL

--Q4
SELECT SUM(B.ORDER_CNT)
FROM 
(
SELECT TOP 10 COUNT(ORDER_NUMBER)ORDER_CNT, CUSTOMER_KEY FROM ordersTBL
GROUP BY CUSTOMER_KEY
ORDER BY ORDER_CNT DESC
) B

--Q5
SELECT COUNT(CUSTOMER_KEY)
FROM
(
SELECT  COUNT(ORDER_NUMBER)ORDER_CNT, CUSTOMER_KEY FROM ordersTBL
GROUP BY CUSTOMER_KEY
HAVING COUNT(ORDER_NUMBER) = 1
)P

--Q6
SELECT COUNT(*)
FROM
(
SELECT  COUNT(ORDER_NUMBER)ORDER_CNT, CUSTOMER_KEY FROM ordersTBL
GROUP BY CUSTOMER_KEY
)X
WHERE ORDER_CNT > 1

--Q7
SELECT COUNT(CUSTOMER_KEY) FROM CustomersTBL
WHERE Referred_Other_customers > 0

--Q8
SELECT  MONTH(ORDER_DATE),YEAR(ORDER_DATE),
SUM(ORDER_TOTAL) OVER (PARTITION BY MONTH(ORDER_DATE) ORDER BY YEAR(ORDER_DATE)) AS MONTHLY_REV
FROM ordersTBL


--Q9
SELECT TOP 1 DATEPART(YEAR, order_date) AS OrderYear,
DATEPART(MONTH, order_date) AS OrderMonth,
SUM(ORDER_TOTAL) AS TotalRevenue
FROM ordersTBL
GROUP BY DATEPART(YEAR, order_date), DATEPART(MONTH, order_date)
ORDER BY TotalRevenue DESC

--Q10

SELECT COUNT(G.CUSTOMER_KEY)
FROM
(
SELECT DISTINCT CUSTOMER_KEY, MAX(ORDER_DATE) OVER() AS MAX_ORDER,ORDER_DATE,
DATEDIFF(DAY,  ORDER_DATE,MAX(ORDER_DATE) OVER()) AS INACTIVE FROM ordersTBL
)G
WHERE INACTIVE >= 60

--Q11

with cte1 as
(
select 
sum(case when month(ORDER_DATE)=11 and year(ORDER_DATE)= 2015 then 1 else 0 end) as novorders,
sum(case when month(ORDER_DATE)=7 and year(ORDER_DATE)= 2016 then 1 else 0 end) as julyorders
from ordersTBL
)
select 
(julyorders - novorders) * 100 / novorders
from cte1

--Q12


with cte2 as
(
select 
sum(case when month(ORDER_DATE)=11 and year(ORDER_DATE)= 2015 THEN ORDER_TOTAL else 0 end) as NOVTOTAL,
sum(case when month(ORDER_DATE)=7 and year(ORDER_DATE)= 2016 then ORDER_TOTAL else 0 end) as JULYTOTAL
from ordersTBL
)
select 
round((JULYTOTAL - NOVTOTAL) * 100 / NOVTOTAL,2)
from cte2

--Q13

select 
sum(case when gender = 'm' then 1 else 0 end) * 100 / count(*) as malecust
from CustomersTBL

--Q14

select COUNT(CUSTOMER_KEY) abc ,Location from CustomersTBL
group by Location
order by abc desc

--Q15

select count(order_total) from ordersTBL
where order_total < 0

--Q16

SELECT TOP 1 COUNT(CUSTOMER_KEY), Acquired_Channel FROM CustomersTBL
GROUP BY Acquired_Channel
ORDER BY COUNT(CUSTOMER_KEY) DESC

--Q17


--Q19

SELECT 
SUM( CASE WHEN GENDER = 'M' AND ACQUIRED_CHANNEL = 'APP' THEN 1 ELSE 0 END) *100.0 / count(gender)
FROM CustomersTBL


--Q20
SELECT 
 CAST(SUM(CASE WHEN order_status = 'cancelled' THEN 1 ELSE 0 END) AS DECIMAL(10,2)) * 100 / 
 NULLIF(COUNT(*), 0) AS CancelledOrderPercentage
FROM ordersTBL;

--Q21
SELECT 
    (SELECT COUNT(*) 
     FROM ordersTBL O 
     WHERE O.CUSTOMER_KEY IN 
         (SELECT C.CUSTOMER_KEY
          FROM CustomersTBL C 
          WHERE C.Referred_Other_customers > 0)
    ) * 100.0 / NULLIF(COUNT(*), 0) AS PercentageOrdersByHappyCustomers
FROM 
    ordersTBL;
--Q22
select top 1 location, count(customer_key) customers,count(referred_other_customers) referred
from CustomersTBL
group by location

--Q23

SELECT SUM(order_total) AS TotalOrderValue
FROM ordersTBL o
WHERE  o.CUSTOMER_KEY IN (
SELECT c.CUSTOMER_KEY
FROM CustomersTBL c
WHERE c.Gender = 'M'         
AND c.Location = 'Chennai'         
AND c.Referred_Other_customers > 0 
)

--Q24
select sum(o.ORDER_TOTAL) tot_rev,
DATEPART(month, ORDER_DATE) as month1, DATEPART(year, ORDER_DATE) year1
from ordersTBL o
where o.CUSTOMER_KEY in(
select c.CUSTOMER_KEY from CustomersTBL c
where c.Gender = 'm'
and c.Location = 'chennai'
)
group by DATEPART(month, ORDER_DATE), DATEPART(year, ORDER_DATE)
order by tot_rev desc

--Q25
--Prepare at least 5 additional analysis on your own? 
--Q1
SELECT 
AVG(ORDER_TOTAL) AS AvgOrder
FROM 
ordersTBL
WHERE  CUSTOMER_KEY IN (
SELECT CUSTOMER_KEY 
FROM CustomersTBL 
WHERE Gender = 'M'
 )

 --Q2
SELECT (SELECT COUNT(*) FROM ordersTBL 
 WHERE DELIVERY_STATUS = 'Late') * 100.0 / COUNT(*) AS LATEORDERPERCENTAGE
FROM ordersTBL


--Q3
SELECT SUM(DISCOUNT) AS TotalDiscountGurgaon
FROM ordersTBL
WHERE  CUSTOMER_KEY IN ( SELECT CUSTOMER_KEY 
 FROM CustomersTBL 
 WHERE Location = 'Gurgaon')

--Q4

SELECT SUM(ORDER_TOTAL) AS Totalrevfemale
FROM  ordersTBL
WHERE CUSTOMER_KEY IN (
SELECT CUSTOMER_KEY 
FROM CustomersTBL 
WHERE Gender = 'F')

--Q5
SELECT C.CONTACT_NUMBER
FROM 
CustomersTBL C
WHERE 
C.CUSTOMER_KEY NOT IN (
SELECT CUSTOMER_KEY 
FROM ordersTBL)

--Q 25
SELECT COUNT(*) AS DiscountedOrders
FROM ordersTBL o
WHERE o.CUSTOMER_KEY IN (
SELECT c.CUSTOMER_KEY 
FROM CustomersTBL c
WHERE c.Gender = 'F' 
AND c.Location = 'Bangalore' AND Acquired_Channel = 'Website'
) 
AND o.DISCOUNT > 0
AND o.DELIVERY_STATUS = 'ON-TIME'

--Q26
SELECT DATEPART(MONTH,ORDER_DATE), DATEPART(YEAR, ORDER_DATE),
COUNT(CASE WHEN ORDER_STATUS = 'Delivered' THEN 1  END) AS DELIVERED,
COUNT(CASE WHEN ORDER_STATUS = 'Cancelled' THEN 1  END) AS CANCELLED,
COUNT(CASE WHEN ORDER_STATUS IN ('Packaged','Created') THEN 1 END) AS ETC
FROM ordersTBL
GROUP BY DATEPART(MONTH,ORDER_DATE), DATEPART(YEAR, ORDER_DATE)
ORDER BY DELIVERED DESC

--Q27
SELECT DATEPART(MONTH,ORDER_DATE), DATEPART(YEAR, ORDER_DATE),
COUNT(CASE WHEN DELIVERY_STATUS = 'ON-TIME' THEN 1  END) AS ON_TIME,
COUNT(CASE WHEN DELIVERY_STATUS = 'LATE' THEN 1  END) AS LATE,
COUNT(CASE WHEN DELIVERY_STATUS IS NULL THEN 1 END) AS NULLVALUES
FROM ordersTBL
GROUP BY DATEPART(MONTH,ORDER_DATE), DATEPART(YEAR, ORDER_DATE)
ORDER BY ON_TIME DESC

SELECT * FROM ordersTBL


--Q32

SELECT 
    c.CUSTOMER_ID,
    c.CONTACT_NUMBER,
    c.Referred_Other_customers,
    c.Gender,
    c.Location,
    c.Acquired_Channel,
    COUNT(o.ORDER_NUMBER) AS No_Orders,
    SUM(o.ORDER_TOTAL) AS Total_Ordervalue,
    SUM(CASE WHEN o.DISCOUNT > 0 THEN 1 ELSE 0 END) AS Total_Discount_order,
    SUM(CASE WHEN o.DELIVERY_STATUS = 'Late' THEN 1 ELSE 0 END) AS Order_late,
    SUM(CASE WHEN o.ORDER_TOTAL < 0 THEN 1 ELSE 0 END) AS Orders_Returned,
    MAX(o.ORDER_TOTAL) AS Maximum_Order,
    MIN(o.ORDER_DATE) AS First_Transaction,
    MAX(o.ORDER_DATE) AS Last_Transaction,
    DATEDIFF(MONTH, MIN(o.ORDER_DATE), MAX(o.ORDER_DATE)) AS Tenure_Months,
    SUM(CASE WHEN o.ORDER_TOTAL = 0 THEN 1 ELSE 0 END) AS No_of_Orders_with_Zero_Value
FROM 
    CustomersTBL c
LEFT JOIN 
    ordersTBL o ON c.CUSTOMER_KEY = o.CUSTOMER_KEY
GROUP BY 
    c.CUSTOMER_ID, 
    c.CONTACT_NUMBER, 
    c.Referred_Other_customers, 
    c.Gender, 
    c.Location, 
    c.Acquired_Channel;

--Q33
select *  from customer360

SELECT Location,
SUM(Total_Ordervalue) AS Total_Revenue,
SUM(No_Orders) AS Total_Orders
FROM  Customer360
GROUP BY Location

--Q34

SELECT Gender, SUM(Total_Ordervalue) AS TotalRevenue,
SUM(No_Orders) AS TotalOrders
FROM Customer360
GROUP BY Gender


--Q35
SELECT TOP 1 Location, COUNT(Orders_Returned) AS Total_Canceled
FROM Customer360
GROUP BY Location
ORDER BY Total_Canceled DESC

--Q36
SELECT  Acquired_Channel,COUNT(DISTINCT CUSTOMER_ID) AS Total_Customers,
SUM(Total_Ordervalue) AS Total_Revenue,SUM(No_Orders) AS Total_Orders
FROM Customer360
GROUP BY Acquired_Channel

--Q37
SELECT top 1 Acquired_Channel, SUM(Total_Ordervalue) AS TotalRev,SUM(No_Orders) AS TotalOrders,
COUNT(CASE WHEN No_Orders > 1 THEN CUSTOMER_ID END) AS RepeatPurchase
FROM Customer360
GROUP BY Acquired_Channel
ORDER BY TotalRev DESC, TotalOrders DESC, RepeatPurchase DESC

--Q39
--Prepare at least 5 additional analysis on your own from customers 360
--Q1
SELECT Location,AVG(Total_Ordervalue) AS Average_Order_Value
FROM Customer360
GROUP BY Location

--Q2
SELECT Gender, SUM(CASE WHEN Total_Discount_order > 0 THEN 1 ELSE 0 END) * 100.0 / NULLIF(COUNT(CUSTOMER_ID), 0) AS Discount_Usage_Percentage
FROM Customer360
GROUP BY Gender

--Q3
SELECT Acquired_Channel, AVG(No_Orders) AS AveragEOrders
FROM Customer360
GROUP BY Acquired_Channel;

--Q4
SELECT Location, COUNT(CONTACT_NUMBER) AS Phone_Number_Count
FROM Customer360
GROUP BY Location;

--Q5
SELECT AVG(Total_Ordervalue) AS AvGValue
FROM Customer360
WHERE No_Orders > 1;