#Q1
select country.country_name , count(*) as sum
from address , customer_address , country
where customer_address.address_id = address.address_id and country.country_id = address.country_id
group by country.country_name
order by sum desc
limit 5;

#Q2
select author.author_name , count(*) as sum
from book , book_author , author
where book.book_id = book_author.book_id and author.author_id = book_author.author_id 
group by author.author_name
order by sum desc
limit 5;

#Q3
select shipping_method.method_name , count(*) as sum
from shipping_method , cust_order
where shipping_method.method_id = cust_order.shipping_method_id
group by shipping_method.method_name 
order by sum desc
limit 5;

#Q4
select  book.title , count(*) as sum1
from order_line  , book
where book.book_id = order_line.book_id
group by book.title
order by sum1 desc
limit 5;


#Q5
select  customer.first_name , sum(price) as sum1
from 	customer , cust_order , order_line
where customer.customer_id = cust_order.customer_id and cust_order.order_id = order_line.order_id 
group by customer.customer_id
order by sum1 desc
limit 5;

#Q6
select title , max(num_pages) as max
from book;

#Q7
select book.title , author.author_name
from book , book_author , author
where book.book_id = book_author.book_id and book_author.author_id = author.author_id;

#Q8
select concat(customer.first_name,' ',customer.last_name), count(cust_order.order_id)
from cust_order,customer
where customer.customer_id = cust_order.customer_id
group by customer.customer_id;

#Q9
select shipping_method.method_name  , sum(order_line.price)
from shipping_method , cust_order , order_line
where shipping_method.method_id = cust_order.shipping_method_id and  cust_order.order_id = order_line.order_id
group by shipping_method.method_name;

#Q10
select book.title , publisher.publisher_name
from book , publisher
where book.publisher_id = publisher.publisher_id; 

#Q11
select cust_order.order_id , cust_order.order_date , status_value
from cust_order join order_history on order_history.order_id = cust_order.order_id
join order_status on order_status.status_id = order_history.status_id;

#Q12
select concat(customer.first_name , " " , customer.last_name) as conc , sum(order_line.price) + sum(shipping_method.cost) ,
case 
	when sum(order_line.price) + sum(shipping_method.cost) <100 then 'low'
    when sum(order_line.price) + sum(shipping_method.cost) >= 100 and sum(order_line.price) + sum(shipping_method.cost) < 300 then 'medium'
    when sum(order_line.price) + sum(shipping_method.cost) >= 300 then 'High'
end as category_class
from customer join cust_order on customer.customer_id = cust_order.customer_id
join order_line on order_line.order_id = cust_order.order_id
join shipping_method on shipping_method.method_id = cust_order.shipping_method_id
group by conc;

#Q13
select concat(customer.first_name,' ',customer.last_name), count(cust_order.order_id),
case
	when count(cust_order.order_id) < 3 then 'Bronze'
    when count(cust_order.order_id) >= 3 and count(cust_order.order_id) < 5 then 'silver'
    when count(cust_order.order_id) >=5  then 'gold'
end as loyalty
from cust_order,customer
where customer.customer_id = cust_order.customer_id
group by customer.customer_id;



#Q14
select first_name , last_name ,'yes' 
from customer
where customer.customer_id in (select customer_id from cust_order )
union
select first_name , last_name ,'no' 
from customer
where customer.customer_id not in (select customer_id from cust_order );

select first_name , last_name , 
case 
	when cust_order.order_date is null then 'no'
    else 'yes'
end as has_placed_order
from customer    
left join cust_order on cust_order.customer_id = customer.customer_id;

select customer.customer_id  , first_name , last_name , 'yes'
from customer
join cust_order on customer.customer_id = cust_order.customer_id

union

select customer.customer_id  , first_name , last_name , 'no'
from customer
left join cust_order on customer.customer_id = cust_order.customer_id
where cust_order.order_id is null;

#Q15
select  distinct author.author_id ,( author.author_name) 
from author join book_author on author.author_id = book_author.author_id
join book on book.book_id = book_author.book_id
where book.num_pages > 500;


#Q16

select   customer.customer_id , first_name , last_name
from customer
where customer.customer_id in (select customer_id from shipping_method left join cust_order  on cust_order.shipping_method_id = shipping_method.method_id 
);

select   customer.customer_id , first_name , last_name
from customer
left join cust_order  on cust_order.customer_id = customer.customer_id
left join shipping_method on shipping_method.method_id = cust_order.shipping_method_id
where cust_order.order_id is not null and shipping_method.method_id is not null; 

SELECT
    c.customer_id,
    c.first_name,
    c.last_name
FROM
    customer c
WHERE
    NOT EXISTS (
        SELECT sm.method_id
        FROM shipping_method sm
        WHERE NOT EXISTS (
            SELECT co.order_id
            FROM cust_order co
            WHERE co.customer_id = c.customer_id
              AND co.shipping_method_id = sm.method_id
        )
    );

select customer.customer_id , first_name , last_name , count(distinct(shipping_method_id)) as sum
from customer
join cust_order on customer.customer_id = cust_order.order_id
group by customer.customer_id
having sum = 4;
# this is the correct answer isa 
select customer_id , count(distinct shipping_method_id)
from cust_order
join  shipping_method on cust_order.shipping_method_id = shipping_method.method_id
group by customer_id
having count(distinct shipping_method_id) = 4 ;

#Q17
select book.title , count(order_line.order_id) as sum
from book
join order_line on order_line.book_id = book.book_id
group by book.book_id
having sum > 5;

#Q18
select customer.customer_id,first_name,last_name ,sum(order_line.price) as total_order_price 
from customer 
join cust_order on customer.customer_id=cust_order.customer_id
join order_line on order_line.order_id=cust_order.order_id 
group by customer.customer_id
having total_order_price> (select avg(order_line.price) from order_line );

#q19
create view customers_And_orders as 
select  customer.customer_id,first_name,last_name,order_id
from customer 
join cust_order on customer.customer_id=cust_order.customer_id;

select * from customers_And_orders;

drop view customers_And_orders;

#q21
delimiter //
create function return_cost(order_ids int) returns float deterministic
begin
declare cost float;

select  sum(order_line.price)
from order_line
where order_line.order_id = order_ids into cost;

return cost;
end
//
delimiter ;

select  order_id, return_cost(order_id)
from order_line;

drop function return_cost;
################################################################################



    
