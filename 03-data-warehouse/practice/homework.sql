
-- Creating external table
CREATE OR REPLACE EXTERNAL TABLE `ny_taxi.green_taxi_trip_record`
OPTIONS (
  format = 'parquet',
  uris = ['gs://nyc_taxi_data1/green_taxi_data.parquet']
);


-- Creating table from extrnal table
CREATE OR REPLACE TABLE ny_taxi.green_taxi_data_non_partitioned AS
SELECT * 
FROM ny_taxi.green_taxi_trip_record;



-- Q1: What is count of records for the 2022 Green Taxi Data?

SELECT COUNT(*)
FROM ny_taxi.green_taxi_data_non_partitioned;


--Q2: Write a query to count the distinct number of PULocationIDs for the entire dataset on both the tables.

--External Table
SELECT DISTINCT COUNT(PULocationID)
FROM ny_taxi.green_taxi_trip_record;

--Materialized Table
SELECT DISTINCT COUNT(PULocationID)
FROM ny_taxi.green_taxi_data_non_partitioned;


--Q3: How many records have a fare_amount of 0?

SELECT COUNT(*)
FROM ny_taxi.green_taxi_data_non_partitioned
WHERE fare_amount =0 ;


--Q4: What is the best strategy to make an optimized table in Big Query if your query will always order the results by PUlocationID and filter based on lpep_pickup_datetime?
--Partion by lpep_pickup_datetime

CREATE OR REPLACE TABLE ny_taxi.green_taxi_data_partitioned
PARTITION BY
  DATE(lpep_pickup_datetime)
CLUSTER BY 
  pulocationid AS
SELECT * 
FROM ny_taxi.green_taxi_trip_record;


--Q5 Write a query to retrieve the distinct PULocationID between lpep_pickup_datetime 06/01/2022 and 06/31/2022 (inclusive)

SELECT DISTINCT PULocationID
FROM ny_taxi.green_taxi_data_non_partitioned
WHERE lpep_pickup_datetime BETWEEN '2022-01-01' AND '2022-06-30'
;


SELECT DISTINCT PULocationID
FROM ny_taxi.green_taxi_data_partitioned
WHERE lpep_pickup_datetime BETWEEN '2022-01-01' AND '2022-06-30'
;



