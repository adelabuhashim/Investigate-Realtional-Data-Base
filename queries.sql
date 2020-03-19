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

/*Q2*/
/*Now we need to know how the length of rental duration of these family-friendly movies compares to the duration that all movies are rented for.
Can you provide a table with the movie titles and divide them into 4 levels (first_quarter, second_quarter, third_quarter, and final_quarter)
based on the quartiles (25%, 50%, 75%) of the rental duration for movies across all categories? Make sure to also indicate the category that these family-friendly movies fall into.*/
SELECT f.title AS "movie_title",
       c.name AS "category_name",
       f.rental_duration,
       NTILE(4) OVER (ORDER BY f.rental_duration  ) "quartile"
FROM film f
JOIN film_category fc
ON fc.film_id = f.film_id
JOIN category c
ON c.category_id = fc.category_id
WHERE c.name IN ('Animation', 'Children', 'Classics', 'Comedy', 'Family', 'Music');


/*Q3*/
/*provide a table with the family-friendly film category, each of the quartiles, and the corresponding count of movies within each combination of film category for each corresponding rental duration category. The resulting table should have three columns:

    Category
    Rental length category
    Count
*/


SELECT category_name,
       quartile,
       count(*)
FROM (SELECT c.name AS "category_name",
             f.rental_duration AS "rental_duration",
             NTILE(4) OVER (ORDER BY f.rental_duration  ) "quartile"
      FROM film f
      JOIN film_category fc
      ON fc.film_id = f.film_id
      JOIN category c
      ON c.category_id = fc.category_id
      WHERE c.name IN ('Animation', 'Children', 'Classics', 'Comedy', 'Family', 'Music'))sub
GROUP BY 1,2
ORDER BY 1,2;


/*Q4*/
/*Top 10 customers*/
SELECT customer_id,
       customer_full_name,
       sum(sum)
FROM(SELECT cu.customer_id AS "customer_id",
     	      p.payment_id"payment_id",
            cu.first_name || ' ' || cu.last_name AS "customer_full_name",
            SUM(p.amount) OVER (PARTITION BY cu.customer_id ORDER BY p.payment_id)
     FROM customer cu
     JOIN payment p
     ON p.customer_id = cu.customer_id)sub
GROUP BY 1,2
ORDER BY 3 DESC
LIMIT 10;
