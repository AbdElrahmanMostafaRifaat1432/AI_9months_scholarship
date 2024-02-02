select title as movie_title , replacement_cost as cost
from film;

select title , rental_rate
from film
where rental_rate between 3 and 5
limit 5;

select*
from film
where title like '_A%' ;

select*
from film
where release_year in (2005,2006,2007) ;

select*
from film
where release_year in (2005,2006,2007) ;

#q1
select title , rental_rate
from film
where rental_rate between 3 and 5;

# q2
select first_name , last_name
from customer
where last_name like 's%';

#q3
select title
from film
where rental_rate <= 2.5 and release_year < 2005;

#q4
select title
from film
where rental_rate != 4.99 and replacement_cost between 10 and 15
and release_year in (2002,2005,2006) ;
###################################################

#q2
select first_name , last_name
from customer
order by last_name , first_name;

#q3
select title , rental_rate
from film
order by rental_rate ;
########################################################
#q1
select first_name ,last_name,
case 
	when length(concat(first_name ,last_name)) < 10 then 'short' 
	when length(concat(first_name ,last_name)) between 10 and 15 then 'medium'
    else 'long'
end as length_class
from actor;

#q2
select title ,length,
case 
	when length < 60 then 'short' 
	when length between 60 and 120 then 'medium'
    else 'long'
end as length_type
from film
order by length;
#################################################

select count(*) 
from rental
group by customer_id;

select first_name , last_name , 
case
	when (select count(*) 
		from rental as r
		where r.customer_id = c.customer_id) < 10 then 'regular'
    when (select count(*) 
		from rental as r
		where r.customer_id = c.customer_id) between  10 and 20 then 'prefered'
    else 'vip'
end as loyalty
from customer as c
order by loyalty;

#####################################################
select count(*)
from film;

select avg(replacement_cost)
from film;

select max(rental_rate) , min(rental_rate)
from film ;

#####################################################
select month(rental_date) as month1 , count(*) as sum
from rental
group by month1
having sum > 100;
#####################################################


