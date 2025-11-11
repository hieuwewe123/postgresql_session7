--1
CREATE VIEW v_revenue_by_region AS
SELECT c.region, SUM(o.total_amount) AS total_revenue
FROM customer c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.region;

--a
SELECT * FROM v_revenue_by_region
ORDER BY total_revenue DESC
LIMIT 3;

--2
CREATE MATERIALIZED VIEW mv_monthly_sales AS
SELECT DATE_TRUNC('month', order_date) AS month_date, SUM(total_amount) AS monthly_revenue
FROM orders
GROUP BY DATE_TRUNC('month', order_date);

--a
CREATE VIEW v_orders_status AS
SELECT o.order_id, o.status
FROM orders o
WHERE o.status IS NOT NULL
WITH CHECK OPTION;

--b
UPDATE v_orders_status
SET status = 'Completed'
WHERE order_id = 1;

--3
CREATE VIEW v_revenue_above_avg AS
SELECT region, total_revenue
FROM v_revenue_by_region
WHERE total_revenue > (SELECT AVG(total_revenue) FROM v_revenue_by_region);