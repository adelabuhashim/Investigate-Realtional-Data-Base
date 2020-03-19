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