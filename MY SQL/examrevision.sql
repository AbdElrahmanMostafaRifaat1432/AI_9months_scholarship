select first_name , last_name, length(concat(first_name , last_name)),
case
	when length(concat(first_name , last_name)) < 10 then 'short'
	when length(concat(first_name , last_name)) between 10 and 15 then 'med'
    else 'long'
end as length_type
from actor
order by length(concat(first_name , last_name));


select first_name , last_name,

case
	when (select count(*) from rental where customer.customer_id = rental.customer_id) < 10 then 'regular'
    when (select count(*) from rental where customer.customer_id = rental.customer_id) between 10 and 20 then 'prefered'
    else 'vip'
end as loyalty

from customer;

select rating , count(film_id)
from film
group by rating
having count(film_id) >= 10 ;

select month(rental_date) , count(*)
from rental
group by month(rental_date)
having count(*) >100;

select month(payment_date) , sum(amount) as total_amount
from payment
group by month(payment_date)
having total_amount >1000;

select customer_id , sum(amount) 
from payment
group by customer_id
having sum(amount) > 50
order by sum(amount) desc;

select title , length
from film
where length(title) = (select length(title) from film where title = 'ACE GOLDFINGER');

select category.name 
from category
where category_id not in (select distinct category_id from film_category );

select first_name , last_name , (select count(*) from rental where rental.customer_id = customer.customer_id) as criteria
from customer
order by criteria;

select actor_id , first_name , last_name , (select count(*) from film_actor where film_actor.actor_id =actor.actor_id )
from actor;

select name
from category
where (select count(*) 
		from rental join inventory on rental.inventory_id = inventory.inventory_id
        join film_category on inventory.film_id = film_category.film_id
        where film_category.category_id = category.category_id) > all(select count(*)
        
		from rental join inventory on rental.inventory_id = inventory.inventory_id
        join film_category on inventory.film_id = film_category.film_id
        where film_category.category_id in (1,3)
        group by category_id);
        

select rental_date , title
from rental
join inventory on inventory.inventory_id = rental.inventory_id
join film on film.film_id = inventory.film_id
limit 10;

select name , film_id  
from category
join  film_category on film_category.category_id = category.category_id 
limit 10;

select concat(first_name , ' ' , last_name) , amount
from customer
left join payment on payment.payment_id = customer.customer_id;

select title , count(inventory_id)
from film
left join inventory on inventory.film_id = film.film_id 
group by film.film_id;


select concat(first_name , ' ' , last_name) , sum(amount)
from customer
left join payment on payment.customer_id = customer.customer_id
group by customer.customer_id

union

select concat(first_name , ' ' , last_name) , sum(amount)
from payment
left join customer on payment.customer_id = customer.customer_id
group by customer.customer_id;

######################################################################################
select title  , first_name , last_name
from film
join film_actor on film.film_id = film_actor.film_id
join actor on actor.actor_id = film_actor.actor_id

union

select title  , Null , null
from film
left join film_actor on film.film_id = film_actor.film_id
left join actor on actor.actor_id = film_actor.actor_id
group by film.film_id
having count(actor.actor_id)= 0

union

select null  ,first_name , last_name
from actor
left join film_actor on actor.actor_id = film_actor.actor_id
left join film on film.film_id = film_actor.film_id
group by actor.actor_id
having count(film.film_id )= 0;
################################################################################################

select title  , first_name , last_name
from film
left join film_actor on film.film_id = film_actor.film_id
left join actor on actor.actor_id = film_actor.actor_id


union

select null  ,first_name , last_name
from actor
left join film_actor on actor.actor_id = film_actor.actor_id
left join film on film.film_id = film_actor.film_id
group by actor.actor_id
having count(film.film_id )= 0;

#################################################
select actor_id , film_id
from film_actor
where film_id = 2 and actor_id in (select actor_id
from film_actor
where film_id = 3);
################################################

select customer.customer_id
from customer
join rental on rental.rental_id = customer.customer_id
join inventory on rental.inventory_id =inventory.inventory_id 
join film_category on inventory.film_id = film_category.film_id
where category_id = 1 and customer.customer_id in (

select customer.customer_id
from customer
join rental on rental.rental_id = customer.customer_id
join inventory on rental.inventory_id =inventory.inventory_id 
join film_category on inventory.film_id = film_category.film_id
where category_id = 5

);
#############################################################
select title , length
from film
where film.length = (select max(length) from film);
#############################################################

select *
from (select concat(first_name , last_name) , count(*) as count2 
		from customer join rental on rental.customer_id = customer.customer_id
        group by customer.customer_id) as rental_counted
where rental_counted.count2 > 10;

select concat(first_name , last_name) , count(*) as count1
from customer join  (select * 
		from rental 
        ) as rental_counted on rental_counted.customer_id = customer.customer_id

group by customer.customer_id
having count1 > 10;
###################################################################
select first_name , max(derived.amount)
from (select first_name ,  amount from customer join payment on customer.customer_id = payment.customer_id ) as derived
where first_name = 'LINDA';
#####################################################################

create view abdo1 as
select first_name , max(derived.amount)
from (select first_name ,  amount from customer join payment on customer.customer_id = payment.customer_id ) as derived
where first_name = 'LINDA';

select *
from abdo1;

drop view abdo1;
############################################################################
select trim(first_name)
from customer;
####################################################
SELECT customer_id, email, SUBSTRING(email, LENGTH(email) - 3) AS domain_name
FROM customer
LIMIT 1;

SELECT TRIM(leading ' ' from title) AS trimmed_title
FROM film
LIMIT 5;

SELECT first_name,ifnull(last_name, 'N/A' ) AS UPDATED_NAME
FROM customer;
#################################################################################
delimiter //
create function get_rental_duration(rental1 int) returns int deterministic
begin
declare rental_duration int ;

select datediff(return_date , rental_date) into rental_duration
from rental
where rental_id = rental1;

return rental_duration;
end;
//
delimiter ;

select get_rental_duration(rental_id)
from rental
where rental_id = 5;
#########################################################################################
delimiter //
create function upper_and_lower(input varchar(255)) returns varchar(255) deterministic
begin
declare output varchar(255);

set output = concat(upper(left(input , 1)) ,lower(substring(input , 2)));
return output;
end;
//
delimiter ; 

select upper_and_lower(first_name)
from customer;
####################################################################################################################

select country_name , count(customer_address.customer_id)
from address , customer_address , country
where customer_address.address_id = address.address_id and address.country_id = country.country_id 
group by address.country_id
order by count(*) desc
limit 5;

select customer.customer_id , concat(first_name , " " , last_name),sum(price) as price1,
case
	when sum(price) < 100 then 'low'
    when sum(price) between 100 and 200 then 'med'
    else 'high'
end as classify
   
from customer
join cust_order on customer.customer_id = cust_order.customer_id  
join order_line on cust_order.order_id = order_line.order_id 
group by customer.customer_id;

#######################################################################################

select customer.customer_id  , first_name , last_name , 'yes'
from customer
join cust_order on customer.customer_id = cust_order.customer_id

union

select customer.customer_id  , first_name , last_name , 'no'
from customer
left join cust_order on customer.customer_id = cust_order.customer_id
where cust_order.order_id is null;
###########################################################################
select customer_id , count(distinct shipping_method_id)
from cust_order
join  shipping_method on cust_order.shipping_method_id = shipping_method.method_id
group by customer_id
having count(distinct shipping_method_id) = 4 ;

#################################################################################
delimiter //
create function calculate_total(input_order_id int) returns float deterministic
begin
declare output float;
select sum(price) into output
from order_line
where order_id = input_order_id ;

return output;
end;
//
delimiter ;

drop function calculate_total;

select  order_id, calculate_total(order_id)
from order_line;
#################################################################################################

SELECT count(*), #customer_id, c.first_name, c.last_name,
(SELECT COUNT(*)
FROM
rental r
WHERE
r.customer_id = c.customer_id
) AS rental_count
FROM customer c;