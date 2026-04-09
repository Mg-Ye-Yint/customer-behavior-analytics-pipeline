select gender, sum(purchase_amount) from customer
group by gender
order by 2 desc

select customer_id, purchase_amount from customer 
where discount_applied = 'Yes' and 
purchase_amount >= (select avg(purchase_amount) from customer)

select item_purchased, round(avg(review_rating::numeric),2) as average_review_rating from customer
group by item_purchased
order by 2 desc
limit 5

select shipping_type, round(avg(purchase_amount),2) from customer
where shipping_type = 'Standard' or shipping_type = 'Express'
group by shipping_type

select subscription_status,
count(customer_id) as total_customers, 
round(avg(purchase_amount),2) as average_purchase,
sum(purchase_amount) as total_revenue
from customer
group by subscription_status
order by 4,3 desc

select item_purchased, 
round(100 * sum(case when discount_applied = 'Yes' then 1 else 0 end)/count(*),2) 
as discount_rate from customer
group by item_purchased
order by discount_rate desc
limit 5

with customer_type as 
(
select customer_id, 
previous_purchases,
case 
    when previous_purchases = 1 then 'New'
	when previous_purchases between 2 and 10 then 'Old'
	else 'Loyal'
	end as customer_segment
from customer
)

select customer_segment, count(*) as "Number of Customers" from customer_type
group by customer_segment
order by "Number of Customers" desc

with item_counts as (
select 
category, 
item_purchased, 
count(*) as "total_orders",
ROW_NUMBER() over(partition by category order by count(customer_id) desc) 
as item_rank from customer
group by category, item_purchased
)

select item_rank, category, item_purchased, total_orders from item_counts



select category, count(*) as "Number of Purchase" from customer
group by category
order by "Number of Purchase"

select subscription_status, count(customer_id) as customer_cound
from customer
where previous_purchases > 5
group by subscription_status
order by 2 desc

select age_group, sum(purchase_amount) as "total revenue" from customer
group by 1
order by 2 desc

select * from customer

