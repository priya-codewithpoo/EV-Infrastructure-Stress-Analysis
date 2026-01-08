
/*PURPOSE: Aggregate vehicle technical specs to the Manufacturer level.
RATIONALE: We need a 'Demand' baseline to compare against city 'Supply'. 
           Rounding to 2 decimals ensures precision for the Python Stress Score 
           without sacrificing readability in Power BI.
*/

CREATE OR REPLACE
VIEW vehicle_demand AS
SELECT
	manufacturer,
	ROUND(CAST(AVG(battery_capacity_kwh) AS NUMERIC), 2) AS avg_battery_kwh,
	ROUND(CAST(AVG(charging_rate_dc_fast) AS NUMERIC), 2) AS avg_car_fast_kw
FROM
	dim_vehicles
	-- Explicitly filtering raw data BEFORE the calculation
WHERE
	battery_capacity_kwh IS NOT NULL
	AND charging_rate_dc_fast IS NOT NULL
GROUP BY
	manufacturer;
