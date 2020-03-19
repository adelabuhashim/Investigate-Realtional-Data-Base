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
