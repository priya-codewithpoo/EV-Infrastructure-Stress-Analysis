
/* PROJECT: EV Infrastructure Scalability Analysis
PURPOSE: Perform Quality Assurance (QA) on raw ingested data.
GOAL: Ensure data integrity and detect anomalies before the transformation layer.
*/
-- Verify row counts match the source file to ensure full ingestion

SELECT
	count(*)
FROM
	fact_stations ;

SELECT
	count(*)
FROM
	dim_vehicles;


-- Check for NULLs in power-critical columns
-- Logic: We assume NULL = 0 for charging ports to avoid calculation errors.

SELECT
	COUNT(*) FILTER (
	WHERE
		ev_dc_fast_count IS NULL
	) AS null_fast,
	COUNT(*) FILTER (
	WHERE
		ev_level2_evse_num IS NULL
	) AS null_level2
FROM
	fact_stations;


-- Duplicate Validation
-- Ensuring each Station ID is unique to prevent overestimating supply.

SELECT
	COUNT(id) AS total_rows,
	COUNT(DISTINCT id) AS unique_stations
FROM
	fact_stations;


-- This shows you exactly how many messy rows you are skipping
-- Identified 86 records with NULL battery data. 
-- Action: Filtered out in 'vehicle_demand' view to protect data quality

SELECT
	COUNT(*)
FROM
	dim_vehicles
WHERE
	battery_capacity_kwh IS NULL;