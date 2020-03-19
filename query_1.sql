/*Q1*/
/*Create a query that lists each movie, the film category it is classified in, and the number of times it has been rented out.*/

SELECT f.title AS "movie_name",
       c.name AS "category_name",
       COUNT(*) AS "rental_count"
FROM film f
JOIN film_category fc
ON fc.film_id = f.film_id
JOIN category c
ON c.category_id = fc.category_id
JOIN inventory i
ON i.film_id = f.film_id
JOIN rental r
ON r.inventory_id = i.inventory_id
WHERE c.name IN ('Animation', 'Children', 'Classics', 'Comedy', 'Family', 'Music')
GROUP BY 1,2
ORDER BY 2,1;
