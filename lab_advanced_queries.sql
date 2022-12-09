use sakila;
-- 1. List each pair of actors that have worked together.
select * from film_actor a join film_actor a2 on a.actor_id > a2.actor_id 
and a.film_id = a2.film_id
order by a.film_id, a.actor_id;
-- 2. For each film, list actor that has acted in more films.
-- Solution 1:
select  f.title, concat(a.first_name, ' ', a.last_name) as actor_name, count(fa.film_id) as num_films from film_actor fa
join actor a using (actor_id)
join film f using (film_id) where film_id in 
(select count(fa.film_id) as num_films from film_actor fa join actor a using (actor_id) group by actor_id
order by num_films DESC)
group by f.title;

-- Solution 2:
select title, a.actor_id, a.actor_name, a.number_of_films from film join
(select film_actor.actor_id, concat(first_name, ' ',last_name) as actor_name, count(film_id) as number_of_films from film_actor join actor 
on film_actor.actor_id = actor.actor_id group by actor_id order by number_of_films desc) as a;

-- I tried 2 ways to solve this ex, Sol 1 outcome seems right & pretty, can you help me to check what is wrong in solution 2
 