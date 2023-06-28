# Bounce - Data Engineer Challenge

## Part 2: Advanced SQL Query for Time-based Events Analysis

Imagine you have an e-commerce dataset with the following three tables:

1. `orders` (columns: `order_id`, `customer_id`, `product_id`, `order_time`, `quantity`)
2. `products` (columns: `product_id`, `product_name`, `category`, `price`)
3. `customers` (columns: `customer_id`, `registration_date`, `country`)
   Write a SQL query that returns the top 3 products in each category with the highest total sales in the past week, but only for the customers that registered in the past year. Also, filter out the results for the categories that have total sales of less than 100 units in the past week. Please use window functions to accomplish this

---

To run this part of the challenge you need to execute the following steps:

1) Make sure that you have a Google Cloud Platform account with BigQuery access. [link](https://cloud.google.com/bigquery).
2) Create a project in the GCP to use in BigQuery. [link](https://cloud.google.com/resource-manager/docs/creating-managing-projects)
3) Go to BigQuery and run the scripts in this order:
   1) ddl.sql - responsible to create the schema/dataset + the tables needed
   2) mockup_data.sql - responsible to populate the tables with some random/mockup data
   3) query.sql - the query requested in this challenge --> this is the most important one. The first 2 scripts were used to support the query creation/validation.
