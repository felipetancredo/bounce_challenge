# Bounce - Data Engineer Challenge
## Part 3: Geospatial Modeling Challenge
For this task, imagine we have an application where users check into various locations and these check-ins are recorded with geospatial data. We want to create a heatmap of these check-ins.

Design a data model (schema) that would support this use-case. This should include the data types and the relationships between tables if multiple tables are required.

Provide the SQL commands necessary to create this schema.

---

To run this part of the challenge you need to execute the following steps:

1) Make sure that you have a Google Cloud Platform account with BigQuery access. [link](https://cloud.google.com/bigquery).
2) Create a project in the GCP to use in BigQuery. [link](https://cloud.google.com/resource-manager/docs/creating-managing-projects)
3) Go to BigQuery and run the scripts in this order:
   1) ddl.sql - responsible to create the schema/dataset + the tables needed --> this is the model that was requested in the challenge. The rest of the scripts were used to support/validation.
   2) mockup_data.sql - responsible to populate the tables with some random/mockup data
   3) transform.sql - an extra deliverable to complement a bit the challenge 