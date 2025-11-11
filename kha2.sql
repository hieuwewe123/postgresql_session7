-- 1
CREATE VIEW v_order_summary AS
SELECT c.full_name, o.total_amount, o.order_date
FROM customer c
JOIN orders o ON c.customer_id = o.customer_id
WITH CHECK OPTION;

-- 2 
SELECT * FROM v_order_summary;

-- 3
UPDATE v_order_summary
SET total_amount = 150.50
WHERE full_name = 'John Doe' AND order_date = '2025-11-11'
WITH CHECK OPTION; -- Đảm bảo chỉ cập nhật dữ liệu phù hợp với View

-- 4
SELECT DATE_TRUNC('month', order_date) AS sale_month, SUM(total_amount) AS total_revenue
FROM orders
GROUP BY DATE_TRUNC('month', order_date);

-- 5
DROP VIEW v_order_summary;
 