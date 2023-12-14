/* Lab | SQL Queries 8 */

/* 1. Rank films by length (filter out the rows with nulls or zeros in length column). 
Select only columns title, length and rank in your output. */
select title, length, rank() over (order by length desc) as 'Rank'
from sakila.film
where length <> 0;

/* 2. Rank films by length within the rating category (filter out the rows with nulls or zeros in length column). 
In your output, only select the columns title, length, rating and rank. */
select title, length, rating, rank() over (partition by rating order by length desc) as 'Rank'
from sakila.film
where length <> 0;

/* 3. How many films are there for each of the categories in the category table? 
Hint: Use appropriate join between the tables "category" and "film_category". */
select c.name, count(f.film_id) as 'Number of films'
from sakila.category c
join sakila.film_category f on c.category_id = f.category_id
group by c.name;  

/* 4. Which actor has appeared in the most films? 
Hint: You can create a join between the tables "actor" and "film actor" and count the number of times an actor appears. */
select concat(a.first_name, ' ', a.last_name) as 'Actor', count(f.film_id) as 'Number of film appearances'
from sakila.actor a
join sakila.film_actor f on  a.actor_id = f.actor_id
group by a.first_name, a.last_name
order by count(f.film_id) desc;

select concat(a.first_name, ' ', a.last_name) as 'Actor', count(f.film_id) as 'Number of film appearances'
from sakila.actor a
join sakila.film_actor f on  a.actor_id = f.actor_id
group by a.first_name, a.last_name
order by count(f.film_id) desc
limit 1;

/* 5. Which is the most active customer (the customer that has rented the most number of films)? 
Hint: Use appropriate join between the tables "customer" and "rental" and count the rental_id for each customer.*/
select c.customer_id, concat(c.first_name, ' ', c.last_name) as 'Customer Name', count(r.rental_id) 'Number of rentals'
from sakila.customer c
join sakila.rental r on c.customer_id = r.customer_id
group by c.customer_id, c.first_name, c.last_name
order by count(r.rental_id) desc;

select c.customer_id, concat(c.first_name, ' ', c.last_name) as 'Customer Name', count(r.rental_id) 'Number of rentals'
from sakila.customer c
join sakila.rental r on c.customer_id = r.customer_id
group by c.customer_id, c.first_name, c.last_name
order by count(r.rental_id) desc
limit 1;

/* Bonus: Which is the most rented film? (The answer is Bucket Brotherhood).
This query might require using more than one join statement. Give it a try. We will talk about queries with multiple join statements later in the lessons.
Hint: You can use join between three tables - "Film", "Inventory", and "Rental" and count the rental ids for each film. */
select i.film_id, f.title, count(r.inventory_id) 'Number of rentals'
from sakila.film f 
join sakila.inventory i on f.film_id = i.film_id
join sakila.rental r on i.inventory_id = r.inventory_id
group by i.film_id, f.title
order by count(r.inventory_id) desc;

select i.film_id, f.title, count(r.inventory_id) 'Number of rentals'
from sakila.film f 
join sakila.inventory i on f.film_id = i.film_id
join sakila.rental r on i.inventory_id = r.inventory_id
group by i.film_id, f.title
order by count(r.inventory_id) desc
limit 1;