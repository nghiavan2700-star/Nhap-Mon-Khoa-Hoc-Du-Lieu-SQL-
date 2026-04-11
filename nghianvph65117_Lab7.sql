SELECT column_name
FROM information_schema.columns
WHERE table_name = 'customers';

-- BÀI 1: PHÂN TÍCH HIỆU NĂNG KHI CHƯA CÓ INDEX

DROP INDEX IF EXISTS idx_customers_phone;
DROP INDEX IF EXISTS idx_customers_address;

EXPLAIN ANALYZE
SELECT *
FROM customers
WHERE phone = '0910099999';

-- Bài 2: TẠO INDEX VÀ SO SÁNH

CREATE INDEX idx_customers_phone
ON customers(phone);

EXPLAIN ANALYZE
SELECT *
FROM customers
WHERE phone = '0910099999';

-- Bài 3: ẢNH HƯỞNG CỦA INDEX TỚI LỆNH GHI

EXPLAIN ANALYZE
INSERT INTO customers (full_name, phone, address)
VALUES ('Test Index User', '0999999999', '123 Test Index');

-- Bài 4: BITMAP SCAN

CREATE INDEX idx_customers_address
ON customers(address);

EXPLAIN
SELECT *
FROM customers
WHERE address = 'Address 500'
   OR phone LIKE '091001%';