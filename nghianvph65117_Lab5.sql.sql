-- LAB 5: JOIN & SUBQUERY
-- Sinh vien: Nghia
-- Mon: ITA104

-- BAI 1.1 INNER JOIN
SELECT 
    oi.order_id,
    p.product_name,
    oi.quantity,
    oi.unit_price AS price
FROM order_items oi
INNER JOIN products p 
ON oi.product_id = p.product_id;

-- BAI 1.2 LEFT JOIN
SELECT 
    c.full_name,
    o.order_id
FROM customers c
LEFT JOIN orders o 
ON c.customer_id = o.customer_id;

-- BAI 2.1 RIGHT JOIN
SELECT 
    p.product_name,
    oi.order_id
FROM order_items oi
RIGHT JOIN products p 
ON oi.product_id = p.product_id;

-- BAI 2.2 UNION
SELECT 
    full_name AS ContactName,
    phone AS PhoneNumber
FROM customers

UNION

SELECT 
    supplier_name AS ContactName,
    phone AS PhoneNumber
FROM suppliers;

-- BAI 3.1 SUBQUERY WHERE
SELECT 
    product_name,
    price
FROM products
WHERE supplier_id IN (
    SELECT supplier_id
    FROM suppliers
    WHERE supplier_name = 'Công ty Sữa Việt Nam'
);

-- BAI 3.2 SUBQUERY SELECT
SELECT 
    product_name,
    price,
    (SELECT AVG(price) FROM products) AS average_price
FROM products;

-- BAI 4.1 SUBQUERY FROM
SELECT *
FROM (
    SELECT 
        order_id,
        SUM(quantity * unit_price) AS total_money
    FROM order_items
    GROUP BY order_id
) AS temp
WHERE total_money > 50000;

-- BAI 4.2 EXISTS
SELECT supplier_name
FROM suppliers s
WHERE EXISTS (
    SELECT 1
    FROM products p
    WHERE p.supplier_id = s.supplier_id
);
