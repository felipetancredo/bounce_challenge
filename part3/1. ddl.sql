-- For this task, imagine we have an application where users check into various locations and these check-ins are recorded with geospatial data.
-- We want to create a heatmap of these check-ins.
-- Design a data model (schema) that would support this use-case.
-- This should include the data types and the relationships between tables if multiple tables are required.
-- Provide the SQL commands necessary to create this schema.

create schema if not exists `bounce-challenge`.geo;

create table if not exists geo.raw_checkins
(
    user_id string,
    latitude float64,
    longitude float64,
    check_in_time timestamp
);

-- Creating the transformed table to a POINT in a second step, assuming the raw data it's gonna arrive in plain text.
-- we can also do that incrementally in a production scenario.
create table if not exists geo.checkins
(
    user_id string,
    WKT_point geography,
    check_in_time timestamp
);
