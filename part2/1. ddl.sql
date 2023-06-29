-- creating the schema/dataset for ecomm data
create schema if not exists `bounce-challenge`.ecomm;

-- 1. `orders` (columns: `order_id`, `customer_id`, `product_id`, `order_time`, `quantity`)
create table if not exists ecomm.orders
(
  order_id integer,
  customer_id integer,
  product_id integer,
  order_time datetime,
  quantity integer
);

-- 2. `products` (columns: `product_id`, `product_name`, `category`, `price`)
create table if not exists ecomm.products
(
  product_id integer,
  product_name string,
  category string,
  price float64
);

-- 3. `customers` (columns: `customer_id`, `registration_date`, `country`)
create table if not exists ecomm.customers
(
  customer_id integer,
  registration_date date,
  country string
);
