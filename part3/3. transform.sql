-- Creating the transformed table to a POINT in a second step, assuming the raw data it's gonna arrive in plain text.
-- we can also do that incrementally in a production scenario.

-- option A (assuming the DDL creation before):
insert into geo.checkins
  (user_id, WKT_point, check_in_time)
select
  user_id,
  ST_GeogPoint(longitude, latitude)  AS WKT_point,
  check_in_time
FROM
  `geo.raw_checkins`
;

-- option B (without the DDL table):
create or replace table geo.checkins
as
select
  user_id,
  ST_GeogPoint(longitude, latitude)  AS WKT_point,
  check_in_time
FROM
  `geo.raw_checkins`
;

-- considerations: giving the idea to generate a heatmap of all checkins, I can't see any need to create any other tables or relationships
-- maybe for a more complex case, we can think about more details, but there is a world of assumptions that we should do before modelling.
-- So, I kept it as simple as possible