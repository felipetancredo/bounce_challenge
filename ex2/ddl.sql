-- creating the schema/dataset for ecomm data
create schema if not exists `bounce-challenge`.ecomm;

-- 1. `orders` (columns: `order_id`, `customer_id`, `product_id`, `order_time`, `quantity`)
create table if not exists ecomm.orders
(
  order_id int64,
  customer_id int64,
  product_id int64,
  order_time datetime,
  quantity integer
);

-- 2. `products` (columns: `product_id`, `product_name`, `category`, `price`)
create table if not exists ecomm.products
(
  product_id int64,
  product_name string,
  category string,
  price float64
);

-- 3. `customers` (columns: `customer_id`, `registration_date`, `country`)
create table if not exists ecomm.customers
(
  customer_id int64,
  registration_date date,
  country string
);
