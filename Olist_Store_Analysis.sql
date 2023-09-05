create database Olist_store;

use Olist_store;

-- **************************************************************************************************************************************************** ***  ---
---- 1 Weekday Vs Weekend (order_purchase_timestamp) Payment Statistics

select 
case 
when weekday(o.order_purchase_timestamp)<5 then "weekday"
else "weekend"
end as day_type,
round(sum(p.payment_value),2) as Total_sales
from payments p join orders o on p.order_id = o.order_id
group by day_type;


-- ******************************************************************************************************************************************************** -- 
----- 2 Number of Orders with review score 5 and payment type as credit card.

select count(*) as total_orders, review_score, payment_type
from orders o 
join reviews r on o.order_id = r.order_id
join payments p on o.order_id = p.order_id
where r.review_score = 5
and p.payment_type = "credit_card";

-- ********************************************************************************************************************************************************
-- 3 Average number of days taken for order_delivered_customer_date for pet_shop

select ceiling(avg(datediff(order_delivered_customer_date,order_purchase_timestamp))) as Avg_shipping_days
from orders;  
       
-- ******************************************************************************************************************************************************* --
-- 4 Average price and payment values from customers of sao paulo city

select avg(i.price) as avg_price ,avg(p.payment_value) as avg_payment_value,c.customer_city
from orders o
join payments p on o.order_id = p.order_id
join items i on i.order_id = p.order_id
join customers c on c.customer_id = o.customer_id
where customer_city = "sao Paulo";

-- ********************************************************************************************************************************************************* -- 
-- 5 Relationship between shipping days (order_delivered_customer_date - order_purchase_timestamp) Vs review scores.

select r.review_score, avg(datediff(o.order_delivered_customer_date,o.order_purchase_timeStamp)) as Avg_Shipping_Days
from reviews r 
join orders o on o.order_id = r.order_id
group by r.review_score;

-- ************************************************************************************************************************************************************* -- 
 
 
 
 
 