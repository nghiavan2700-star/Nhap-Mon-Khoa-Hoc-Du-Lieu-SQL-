# Bài 1:

SELECT product_name, AVG(price) AS avg_price
FROM products
GROUP BY product_name;

SELECT product_name, price,
       AVG(price) OVER () AS avg_overall_price
FROM products;

# Bài 2:

ALTER TABLE products
ADD COLUMN category VARCHAR(50);

UPDATE products SET category = 'Do uong' WHERE product_id IN (1,2,3);
UPDATE products SET category = 'Banh keo' WHERE product_id IN (4,5,6);
UPDATE products SET category = 'Do gia dung' WHERE product_id IN (7,8,9);

SELECT category, product_name, price,
       AVG(price) OVER (PARTITION BY category) AS avg_category_price
FROM products;

# Bài 3:

UPDATE products
SET price = 35000
WHERE product_id IN (1,2);

SELECT product_name, price,
       ROW_NUMBER() OVER (ORDER BY price DESC) AS row_num,
       RANK() OVER (ORDER BY price DESC) AS rank_num,
       DENSE_RANK() OVER (ORDER BY price DESC) AS dense_rank_num
FROM products;


# Bài 4:

WITH daily_revenue AS (
    SELECT o.order_date,
           SUM(oi.quantity * p.price) AS total_daily_revenue
    FROM orders o
    JOIN order_items oi ON o.order_id = oi.order_id
    JOIN products p ON oi.product_id = p.product_id
    GROUP BY o.order_date
)
SELECT order_date,
       total_daily_revenue,
       SUM(total_daily_revenue) OVER (ORDER BY order_date) AS running_total_revenue
FROM daily_revenue;