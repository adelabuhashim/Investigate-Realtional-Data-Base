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
