CREATE SCHEMA raw;

SELECT schema_name
FROM information_schema.schemata
WHERE schema_name = 'raw';

--Orders
CREATE TABLE raw.orders (
    order_id VARCHAR,
    customer_id VARCHAR,
    order_status VARCHAR,
    order_purchase_timestamp TIMESTAMP,
    order_approved_at TIMESTAMP,
    order_delivered_carrier_date TIMESTAMP,
    order_delivered_customer_date TIMESTAMP,
    order_estimated_delivery_date TIMESTAMP
);

SELECT table_schema, table_name
FROM information_schema.tables
WHERE table_schema = 'raw'
  AND table_name = 'orders';

COPY raw.orders
FROM'A:\projects & portfolio\ecommerce-olist-analysis\Data\Raw\olist_orders_dataset.csv'
DELIMITER','
CSV HEADER;

SELECT COUNT(*) FROM raw.orders;

SELECT * FROM raw.orders LIMIT 5;

--Checking and profiling data

--1.checking for duplicate 
SELECT 
	COUNT(*) AS total_rows,
	COUNT(DISTINCT order_id) AS distinct_orders
FROM raw.orders;	

--2.Understand lifecycle state
SELECT 
	order_status,
	COUNT(*) AS order_count
FROM raw.orders
GROUP BY order_status
ORDER BY order_count DESC; 

--3. Null checks on key column(0,0 means no null)
SELECT
    SUM(CASE WHEN order_purchase_timestamp IS NULL THEN 1 ELSE 0 END) AS null_purchase_time,
    SUM(CASE WHEN customer_id IS NULL THEN 1 ELSE 0 END) AS null_customer_id
FROM raw.orders;

--4.Data range sanity check
SELECT
    MIN(order_purchase_timestamp) AS first_order,
    MAX(order_purchase_timestamp) AS last_order
FROM raw.orders;

--Order items
CREATE TABLE raw.order_items (
    order_id VARCHAR,
    order_item_id INTEGER,
    product_id VARCHAR,
    seller_id VARCHAR,
    shipping_limit_date TIMESTAMP,
    price NUMERIC,
    freight_value NUMERIC
);

SELECT table_schema, table_name
FROM information_schema.tables
WHERE table_schema = 'raw'
  AND table_name = 'order_items';

COPY raw.order_items
FROM'A:\projects & portfolio\ecommerce-olist-analysis\Data\Raw\olist_order_items_dataset.csv'
DELIMITER','
CSV HEADER;

SELECT COUNT(*) FROM raw.order_items;

SELECT * FROM raw.order_items LIMIT 5;

--Checking and profiling data
SELECT 
	COUNT(*) AS total_rows,
	COUNT(DISTINCT order_id) AS distinct_orders
FROM raw.order_items;

SELECT 
	MIN(price) AS min_price,
	MAX(price) AS max_price,
    MIN(freight_value) AS min_freight,
    MAX(freight_value) AS max_freight
FROM raw.order_items;

SELECT
    SUM(CASE WHEN order_id IS NULL THEN 1 ELSE 0 END) AS null_order_id,
    SUM(CASE WHEN product_id IS NULL THEN 1 ELSE 0 END) AS null_product_id,
    SUM(CASE WHEN price IS NULL THEN 1 ELSE 0 END) AS null_price
FROM raw.order_items;

SELECT 
	order_id,
	COUNT(*) AS items_in_order
FROM raw.order_items
GROUP BY order_id
ORDER BY items_in_order DESC
LIMIT 5;


--Customers data
CREATE TABLE raw.customers (
    customer_id VARCHAR,
    customer_unique_id VARCHAR,
    customer_zip_code_prefix INTEGER,
    customer_city VARCHAR,
    customer_state VARCHAR
);

SELECT table_schema, table_name
FROM information_schema.tables
WHERE table_schema = 'raw'
  AND table_name = 'customers';

COPY raw.customers
FROM 'A:\projects & portfolio\ecommerce-olist-analysis\Data\Raw\olist_customers_dataset.csv'
DELIMITER ','
CSV HEADER;

SELECT COUNT(*) FROM raw.customers;

SELECT * FROM raw.customers LIMIT 5;

--Checking and profiling data

SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT customer_id) AS distinct_customer_id,
    COUNT(DISTINCT customer_unique_id) AS distinct_customer_unique_id
FROM raw.customers;

SELECT
    SUM(CASE WHEN customer_id IS NULL THEN 1 ELSE 0 END) AS null_customer_id,
    SUM(CASE WHEN customer_unique_id IS NULL THEN 1 ELSE 0 END) AS null_customer_unique_id,
    SUM(CASE WHEN customer_state IS NULL THEN 1 ELSE 0 END) AS null_state
FROM raw.customers;

SELECT
    customer_state,
    COUNT(*) AS customer_count
FROM raw.customers
GROUP BY customer_state
ORDER BY customer_count DESC
LIMIT 10;

--Products data
CREATE TABLE raw.products (
    product_id VARCHAR,
    product_category_name VARCHAR,
    product_name_length INTEGER,
    product_description_length INTEGER,
    product_photos_qty INTEGER,
    product_weight_g INTEGER,
    product_length_cm INTEGER,
    product_height_cm INTEGER,
    product_width_cm INTEGER
);

SELECT table_schema, table_name
FROM information_schema.tables
WHERE table_schema = 'raw'
  AND table_name = 'products';

COPY raw.products
FROM 'A:\projects & portfolio\ecommerce-olist-analysis\Data\Raw\olist_products_dataset.csv'
DELIMITER ','
CSV HEADER;  

SELECT COUNT(*) FROM raw.products;

SELECT * FROM raw.products LIMIT 5;

--Checking and profiling data
SELECT 
	COUNT(*) AS total_rows,
	COUNT(DISTINCT product_id) AS distinct_products
FROM raw.products;

SELECT
	SUM(CASE WHEN product_category_name IS NULL THEN 1 ELSE 0 END) AS null_category_count
FROM raw.products;

SELECT
	product_category_name,
	COUNT(*) AS product_count
FROM raw.products
GROUP BY product_category_name
ORDER BY product_count DESC
LIMIT 10;

SELECT
    MIN(product_weight_g) AS min_weight,
    MAX(product_weight_g) AS max_weight,
    MIN(product_photos_qty) AS min_photos,
    MAX(product_photos_qty) AS max_photos
FROM raw.products;


--Payment Data
CREATE TABLE raw.payments (
    order_id VARCHAR,
    payment_sequential INTEGER,
    payment_type VARCHAR,
    payment_installments INTEGER,
    payment_value NUMERIC
);

SELECT table_schema, table_name
FROM information_schema.tables
WHERE table_schema = 'raw'
  AND table_name = 'payments';

COPY raw.payments
FROM'A:\projects & portfolio\ecommerce-olist-analysis\Data\Raw\olist_order_payments_dataset.csv'
DELIMITER ','
CSV HEADER;

SELECT COUNT(*) FROM raw.payments;

SELECT * FROM raw.payments LIMIT 5;


--Checking and profiling data
SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT order_id) AS distinct_orders
FROM raw.payments;

SELECT
    payment_type,
    COUNT(*) AS payment_count
FROM raw.payments
GROUP BY payment_type
ORDER BY payment_count DESC;

SELECT
    MIN(payment_value) AS min_payment,
    MAX(payment_value) AS max_payment
FROM raw.payments;

SELECT
    payment_installments,
    COUNT(*) AS count
FROM raw.payments
GROUP BY payment_installments
ORDER BY payment_installments;


--Review Data
CREATE TABLE raw.reviews (
    review_id VARCHAR,
    order_id VARCHAR,
    review_score INTEGER,
    review_comment_title VARCHAR,
    review_comment_message VARCHAR,
    review_creation_date TIMESTAMP,
    review_answer_timestamp TIMESTAMP
);

SELECT table_schema, table_name
FROM information_schema.tables
WHERE table_schema = 'raw'
  AND table_name = 'reviews';

COPY raw.reviews
FROM'A:\projects & portfolio\ecommerce-olist-analysis\Data\Raw\olist_order_reviews_dataset.csv'
DELIMITER ','
CSV HEADER;

SELECT COUNT(*) FROM raw.reviews;

SELECT * FROM raw.reviews LIMIT 5;

--Checking and profiling data
SELECT
	COUNT(*) AS total_rows,
	COUNT(DISTINCT order_id) AS distinct_orders
FROM raw.reviews;	

SELECT
    review_score,
    COUNT(*) AS review_count
FROM raw.reviews
GROUP BY review_score
ORDER BY review_score;


SELECT
    SUM(CASE WHEN review_score IS NULL THEN 1 ELSE 0 END) AS null_score,
    SUM(CASE WHEN review_creation_date IS NULL THEN 1 ELSE 0 END) AS null_creation_date,
    SUM(CASE WHEN order_id IS NULL THEN 1 ELSE 0 END) AS null_order_id
FROM raw.reviews;

SELECT
    MIN(review_creation_date) AS first_review,
    MAX(review_creation_date) AS last_review
FROM raw.reviews;


--Sellers Data
CREATE TABLE raw.sellers (
    seller_id VARCHAR,
    seller_zip_code_prefix INTEGER,
    seller_city VARCHAR,
    seller_state VARCHAR
);

SELECT table_schema, table_name
FROM information_schema.tables
WHERE table_schema = 'raw'
  AND table_name = 'sellers';

COPY raw.sellers
FROM 'A:\projects & portfolio\ecommerce-olist-analysis\Data\Raw\olist_sellers_dataset.csv'
DELIMITER','
CSV HEADER;

SELECT COUNT(*) FROM raw.sellers;

SELECT * FROM raw.sellers LIMIT 5;

--Checking and profiling data
SELECT
	COUNT(*) AS total_rows,
	COUNT(DISTINCT seller_id) AS distinct_sellers
FROM raw.sellers;	

SELECT
	SUM(CASE WHEN seller_id IS NULL THEN 1 ELSE 0 END) AS null_seller_id,
	SUM(CASE WHEN seller_state IS NULL THEN 1 ELSE 0 END) AS null_state
FROM raw.sellers;	

SELECT 
	seller_state,
	count(*) AS Seller_count
FROM raw.sellers
GROUP BY seller_state
ORDER BY seller_count DESC;