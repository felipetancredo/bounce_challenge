-- Write a SQL query that returns
-- 1. the top 3 products in each category with the highest total sales in the past week,
-- 2. but only for the customers that registered in the past year.
-- 3. Also, filter out the results for the categories that have total sales of less than 100 units in the past week.
-- Please use window functions to accomplish this.

with source_data as
(
  SELECT
    format_date('%Y%W',date_trunc(o.order_time, week(sunday))) as order_year_week,  -- defining the "week" as starting sunday
    p.category,
    o.product_id,
    p.product_name,
    sum(o.quantity) as product_quantity,
    round(sum(o.quantity * p.price),2) as order_value
  FROM
    `ecomm.orders` o
  join
    `ecomm.customers` c
    on c.customer_id = o.customer_id
    and extract(year from c.registration_date) <= extract(year from current_date()) - 1 -- 2. only customers registered last year
  join
    `ecomm.products` p
    on p.product_id = o.product_id
  group by
    1,2,3,4
),
sales_past_week as
(
  select
    order_year_week,
    category,
    product_id,
    product_name,
    product_quantity,
    order_value,

    -- getting the total of items sold by category
    sum(product_quantity) over(partition by category) as category_quantity,

    -- ranking the items in each category with the highest total sales in the past week.
    -- Using DenseRank in order to avoid missing ranking positions in case of ties. In our case, rank() works as well.
    dense_rank() over(partition by category order by order_value desc) as rnk
  from
    source_data s
  where
    s.order_year_week = format_date('%Y%W',
                          date_sub(
                            date_trunc(current_date(), week(sunday)),
                            interval 1 week
                          )
                        ) -- only past week
)
select
  *
from
  sales_past_week
where
  rnk <= 3  -- 1. the top 3 products only
  and category_quantity >= 100  -- 3. filtering out the results for the categories that have total sales of less than 100 units in the past week.
