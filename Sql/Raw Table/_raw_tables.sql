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
  