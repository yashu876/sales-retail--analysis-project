--Find daily sales.

SELECT sale_date,
SUM(amount) daily_sales
FROM sale
GROUP BY sale_date
ORDER BY sale_date;

-- Find monthly sales.

SELECT TO_CHAR(sale_date,'YYYY-MM') month,
SUM(amount) monthly_sales
FROM sale
GROUP BY TO_CHAR(sale_date,'YYYY-MM')
ORDER BY month;

-- Find weekend sales.

SELECT * FROM sale
WHERE TO_CHAR(sale_date,'DY')
IN ('SAT','SUN');

-- Find first sale date.

SELECT MIN(sale_date) first_sale
FROM sale;

-- Find last sale date.

SELECT MAX(sale_date) last_sale
FROM sale;

-- Find sales in specific month.

SELECT * FROM sale
WHERE TO_CHAR(sale_date,'YYYY-MM')='2025-01';

-- Find sales growth month-wise

SELECT month,
sales,
sales - LAG(sales) OVER(ORDER BY month) growth
FROM (
 SELECT TO_CHAR(sale_date,'YYYY-MM') month,
 SUM(amount) sales
 FROM sale
 GROUP BY TO_CHAR(sale_date,'YYYY-MM')
);

--Find inactive customers (30 days).

SELECT customer_id,sale_date
FROM sale
GROUP BY customer_id,sale_date
HAVING MAX(sale_date) < SYSDATE-30;

-- Find repeat customers.

SELECT customer_id
FROM sale
GROUP BY customer_id
HAVING COUNT(*) > 1;

-- Find sales trend.

SELECT month,total_sales,
CASE WHEN total_sales > LAG(total_sales) OVER (ORDER BY month) THEN 'Increase'
WHEN total_sales < LAG(total_sales) OVER (ORDER BY month) THEN 'Decrease'
ELSE 'No Change'
 END AS trend
FROM (SELECT TO_CHAR(sale_date, 'YYYY-MM') AS month,
SUM(amount) AS total_sales
FROM sale
GROUP BY TO_CHAR(sale_date, 'YYYY-MM')
);







