
/* PURPOSE: Aggregate station-level data to a municipal (City/State) level.
METRIC: Converts physical port counts into estimated Power Capacity (kW).
ASSUMPTION: DC Fast = 50kW average | Level 2 = 7kW average.
*/

CREATE VIEW city_charger_power AS
SELECT
	city,
	state,
	-- Calculate total Kilowatt capacity for the city
	SUM(ev_dc_fast_count * 50) AS total_dc_fast_kw,
	SUM(ev_level2_evse_num * 7) AS total_level2_kw
FROM
	fact_stations
GROUP BY
	city,
	state;




