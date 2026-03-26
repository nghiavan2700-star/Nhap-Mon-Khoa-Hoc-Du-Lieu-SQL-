DROP TABLE IF EXISTS invoice_detail CASCADE;
DROP TABLE IF EXISTS invoice CASCADE;
DROP TABLE IF EXISTS product CASCADE;
DROP TABLE IF EXISTS customer CASCADE;

CREATE TABLE customer (
    customer_id SERIAL PRIMARY KEY,
    customer_name VARCHAR(255) NOT NULL,
    phone VARCHAR(15),
    address VARCHAR(255)
);

CREATE TABLE product (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(255) NOT NULL,
    price NUMERIC(10,2) NOT NULL,
    stock INT CHECK (stock >= 0)
);

CREATE TABLE invoice (
    invoice_id SERIAL PRIMARY KEY,
    created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    customer_id INT,
    total_amount NUMERIC(10,2),
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id)
);

CREATE TABLE invoice_detail (
    invoice_id INT,
    product_id INT,
    quantity INT NOT NULL CHECK (quantity > 0),
    unit_price NUMERIC(10,2) NOT NULL,
    PRIMARY KEY (invoice_id, product_id),
    FOREIGN KEY (invoice_id) REFERENCES invoice(invoice_id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES product(product_id)
);

INSERT INTO customer (customer_name, phone, address) VALUES
('Nguyen Van An', '0912345678', 'Ha Noi'),
('Tran Thi Binh', '0987654321', 'Da Nang'),
('Le Van Cuong', '0909123456', 'TP HCM');

INSERT INTO product (product_name, price, stock) VALUES
('Sua tuoi Vinamilk', 35000, 100),
('Mi Hao Hao', 5000, 200),
('Banh Oreo', 18000, 150),
('Nuoc ngot Coca Cola', 12000, 120),
('Dau an Simply', 65000, 60),
('Gao ST25', 180000, 40),
('Ca phe G7', 78000, 75),
('Nuoc suoi Aquafina', 10000, 90);

INSERT INTO invoice (customer_id, total_amount) VALUES
(1, 85000),
(2, 230000),
(3, 88000);

INSERT INTO invoice_detail (invoice_id, product_id, quantity, unit_price) VALUES
(1, 1, 1, 35000),
(1, 3, 2, 18000),
(1, 4, 1, 12000),
(2, 6, 1, 180000),
(2, 7, 1, 78000),
(3, 2, 4, 5000),
(3, 8, 2, 10000),
(3, 5, 1, 65000);

-- Bai 2:
CREATE TABLE suppliers (
    supplier_id SERIAL PRIMARY KEY,
    supplier_name VARCHAR(255) NOT NULL,
    contact_phone VARCHAR(15) UNIQUE
);

-- Bai 3:
ALTER TABLE suppliers
ADD COLUMN email VARCHAR(100);

ALTER TABLE product
ADD COLUMN supplier_id INT;

ALTER TABLE product
ADD CONSTRAINT fk_product_supplier
FOREIGN KEY (supplier_id)
REFERENCES suppliers(supplier_id);

-- Bai 4:
INSERT INTO suppliers (supplier_name, contact_phone, email) VALUES
('Cong ty Sua Viet Nam', '0987654321', 'contact@vinamilk.vn'),
('Cong ty Thuc pham A Chau', '0912345678', 'contact@acecook.vn');

UPDATE product
SET supplier_id = 1
WHERE product_name IN ('Sua tuoi Vinamilk');

UPDATE product
SET supplier_id = 2
WHERE product_name IN ('Mi Hao Hao');

UPDATE suppliers
SET contact_phone = '0911112222'
WHERE supplier_name = 'Cong ty Thuc pham A Chau';

DELETE FROM invoice_detail
WHERE product_id = 8;

DELETE FROM product
WHERE product_id = 8;

-- Bai 5:
CREATE TABLE test_table (
    id INT
);

ALTER TABLE suppliers
DROP COLUMN contact_phone;

DROP TABLE test_table;

-- Lenh kiem tra
SELECT * FROM suppliers;
SELECT * FROM product;
SELECT * FROM product WHERE product_id = 8;