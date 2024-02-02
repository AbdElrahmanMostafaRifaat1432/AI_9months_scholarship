select a.first_name , a.last_name , f.film_id
from actor as a
inner join film_actor as f on a.actor_id = f.actor_id
limit 10;

select f.title , fc.category_id
from film as f
inner join film_category as fc on f.film_id= fc.film_id
order by rand()
limit 10;

select f.title , r.rental_date
from film as f
join inventory as i  on i.film_id = f.film_id
join rental as r on r.inventory_id = i.inventory_id ;


select s.first_name
from staff as s
join store as st on s.store_id = st.store_id;
##########################################################
select concat(customer.first_name , ' ' , customer.last_name ) as Customer,
ifnull(sum(payment.amount) , 0) as TotalAmountPaid
from customer
left join payment on customer.customer_id = payment.customer_id
group by
customer.customer_id , customer.first_name , customer.last_name;
##########################################################
select count(*)
from inventory
group by film_id;
#####################################################
select film.title , actor.first_name
from film
join film_actor on film.film_id = film_actor.film_id
left join actor on actor.actor_id = film_actor.actor_id
union 
select film.title , actor.first_name
from actor
join film_actor on actor.actor_id = film_actor.actor_id
left join film on film.film_id = film_actor.film_id;  
#############################################################
SELECT t1.value, t2.value, t3.value
FROM t1 LEFT JOIN t2 ON t1.value = t2.value
        LEFT JOIN t3 ON t1.value = t3.value
UNION ALL
SELECT t1.value, t2.value, t3.value
FROM t2 LEFT JOIN t1 ON t1.value = t2.value
        LEFT JOIN t3 ON t2.value = t3.value
WHERE t1.value IS NULL
UNION ALL
SELECT t1.value, t2.value, t3.value
FROM t3 LEFT JOIN t1 ON t1.value = t3.value
        LEFT JOIN t2 ON t2.value = t3.value
WHERE t1.value IS NULL AND t2.value IS NULL;


SELECT
    film.title AS 'Film Title',
    actor.first_name AS 'Actor First Name',
    actor.last_name AS 'Actor Last Name'
FROM
    film
INNER JOIN
    film_actor ON film.film_id = film_actor.film_id
INNER JOIN
    actor ON film_actor.actor_id = actor.actor_id

UNION

-- Films with No Associated Actors
SELECT
    film.title AS 'Film Title',
    NULL AS 'Actor First Name',
    NULL AS 'Actor Last Name'
FROM
    film
WHERE
    film.film_id NOT IN (SELECT DISTINCT film_id FROM film_actor)
UNION 
SELECT
    NULL AS 'Film Title',
    first_name AS 'Actor First Name',
    last_name AS 'Actor Last Name'
FROM
    actor
WHERE
    actor.actor_id NOT IN (SELECT DISTINCT actor_id FROM film_actor);
######################################################################################################

