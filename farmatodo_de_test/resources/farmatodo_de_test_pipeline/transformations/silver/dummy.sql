-- Please edit the sample below

CREATE OR REFRESH MATERIALIZED VIEW workspace.operations.dummy_silver AS
SELECT
    pickup_zip,
    fare_amount
FROM samples.nyctaxi.trips;