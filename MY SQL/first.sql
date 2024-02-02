#Retrieve the titles and replacement costs of all films, aliasing them as 'Movie Title' and 'Replacement Cost'.

select film.title as "Movie Title" , film.replacement_cost as "Replacement Cost"
from film;

#Find the titles of films with a rental rate less than or equal to $2.50 and released before the year 2005.

select film.title , film.rental_rate 
from film
where film.rental_rate <= 2.5 and film.release_year = 2006;

#Retrieve the first and last names of customers whose last names start with the letter 'S'.

select customer.first_name , customer.last_name  
from customer
where customer.last_name like "S%";

#List the first and last names of customers from the customer table, ordered alphabetically by last name and then by first name.
select customer.first_name , customer.last_name  
from customer
order by customer.last_name , customer.first_name;

#Retrieve the titles and lengths of films from the film table. Add a column that categorizes films based on their length. Use the following categories: 'Short' (less than 60 minutes), 'Medium' (between 60 and 120 minutes), and 'Long' (more than 120 minutes). Order the result by the length_category in ascending order.
select film.title , film.length,
case 
	when film.length < 60 then 'short'
    when film.length >=  60 and film.length <  120  then 'medium'
    when film.length >= 120 then 'long'
    end as length_category
    from film
    order by length_category;
    
#Determine the maximum and minimum rental rate among all films.
select max(film.rental_rate) ,min(film.rental_rate)
from film;

#Determine the average replacement cost of films released in the year 2002, 2007, and 2006.
 select avg( film.replacement_cost)
from film
where film.release_year in (2002,2007,2006);

#Count the number of films available for each rating category. Display the rating and the count of films. Exclude ratings with less than 10 films.
select  film.rating , count(*) as sum
from film
group by film.rating
having sum > 200;

# Retrieve the titles and categories of the first 10 films.
select film.title , category.name
from film
join film_category on  film.film_id = film_category.film_id
join category on  category.category_id = film.category_id
limit 10 ;

#Retrieve the names of customers and the amounts they paid, including customers who have not made any payments.
select concat (customer.first_name , " " , customer.last_name) , payment.amount
from customer
left join payment on payment.customer_id = customer.customer_id;

 # Retrieve a list of actors who have acted in both films with IDs 2 and 3.
select first_name
from actor
join film_actor on actor.actor_id = film_actor.actor_id
where actor.actor_id in (
select film_actor.actor_id 
from film_actor
where film_actor.film_id = 2

and actor.actor_id in(
select film_actor.actor_id 
from film_actor
where film_actor.film_id = 3)
);

# Retrieve a list of customers who rented films in both the 'Action' and 'Comedy' categories.

select first_name,last_name,category.name
from film_category 
join category 
on category.category_id = film_category.category_id
join inventory 
on inventory.film_id = film_category.film_id
join customer 
on customer.store_id =inventory.store_id
join rental
on rental.customer_id = customer.customer_id
 
where customer.customer_id in (
select customer.customer_id 
from customer
where category.name = "Action" and customer.customer_id in(
select customer.customer_id 
from customer
where category.name = "Comedy")
);

select customer.first_name
from rental 
join customer on customer.customer_id = rental.customer_id
join inventory on inventory.inventory_id = rental.inventory_id
join film_category on inventory.film_id = film_category.film_id
join category on category.category_id = film_category.category_id
where category.name = 'Action' and rental.customer_id in (
select rental.customer_id
from rental 
join customer on customer.customer_id = rental.customer_id
join inventory on inventory.inventory_id = rental.inventory_id
join film_category on inventory.film_id = film_category.film_id
join category on category.category_id = film_category.category_id
where category.name="Comedy");

#Retrieve a list of customers who rented films in the 'Action' category but did not rent any films in the 'Comedy' 

select customer.first_name
from rental 
join customer on customer.customer_id = rental.customer_id
join inventory on inventory.inventory_id = rental.inventory_id
join film_category on inventory.film_id = film_category.film_id
join category on category.category_id = film_category.category_id
where category.name = 'Action' and rental.customer_id in (
select rental.customer_id
from rental 
join customer on customer.customer_id = rental.customer_id
join inventory on inventory.inventory_id = rental.inventory_id
join film_category on inventory.film_id = film_category.film_id
join category on category.category_id = film_category.category_id
where category.name!="Comedy");

#Find the title of the film with the maximum length. Display the film title and its length.
select film.title , max(film.length)	
from film
group by film.film_id
order by film.length
limit 1;

#############################################################################
select 	linda.first_name , max(payment.amount)
from payment , (select * from customer where customer.first_name = 'linda') as linda
where payment.customer_id = linda.customer_id;

select 	linda.first_name , max(linda.amount)
from   customer, (select * from payment join customer on customer.customer_id = payment.customer_id ) as linda
where customer.first_name = 'linda';
#############################################################################
create view abdo as 
select film.film_id , title , release_year , category.name
from rental
join inventory on rental.inventory_id = inventory.film_id
join film on film.film_id = inventory.film_id
join film_category on film.film_id = film_category.film_id
join category on film_category.category_id = category.category_id
where rental.return_date is not null ;

drop view abdo;

select count(*) 
from abdo;



#create view abdo1 as
select customer.first_name
from customer join rental on customer.customer_id = rental.customer_id
group by rental.customer_id;
#########################################################
delimiter //
create function uppercase (word varchar(255)) returns varchar(255) deterministic
begin
declare output varchar(255);
set output = concat(upper(SUBSTRING(word, 1,1)),"" , lower(SUBSTRING(word, 2)) );
return output;
end
//
delimiter ;
 
 select uppercase(customer.first_name)
 from customer;
 
 drop function uppercase
 
 
