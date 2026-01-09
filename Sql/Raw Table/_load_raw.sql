COPY raw.orders
FROM'A:\projects & portfolio\ecommerce-olist-analysis\Data\Raw\olist_orders_dataset.csv'
DELIMITER','
CSV HEADER;

COPY raw.order_items
FROM'A:\projects & portfolio\ecommerce-olist-analysis\Data\Raw\olist_order_items_dataset.csv'
DELIMITER','
CSV HEADER;

COPY raw.customers
FROM 'A:\projects & portfolio\ecommerce-olist-analysis\Data\Raw\olist_customers_dataset.csv'
DELIMITER ','
CSV HEADER;

COPY raw.products
FROM 'A:\projects & portfolio\ecommerce-olist-analysis\Data\Raw\olist_products_dataset.csv'
DELIMITER ','
CSV HEADER;  

COPY raw.payments
FROM'A:\projects & portfolio\ecommerce-olist-analysis\Data\Raw\olist_order_payments_dataset.csv'
DELIMITER ','
CSV HEADER;

COPY raw.reviews
FROM'A:\projects & portfolio\ecommerce-olist-analysis\Data\Raw\olist_order_reviews_dataset.csv'
DELIMITER ','
CSV HEADER;

COPY raw.sellers
FROM 'A:\projects & portfolio\ecommerce-olist-analysis\Data\Raw\olist_sellers_dataset.csv'
DELIMITER','
CSV HEADER;
