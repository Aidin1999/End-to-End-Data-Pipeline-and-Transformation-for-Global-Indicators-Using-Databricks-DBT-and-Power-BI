-- Economic Development Table
WITH country_mapping AS (
    SELECT DISTINCT
           alpha_3 AS country_code,
           name_clean AS name,
           region
    FROM dbo.countries
)

SELECT
    ROW_NUMBER() OVER (ORDER BY c.country_code, t.year) AS id,
    c.country_code,
    CAST(t.year AS INT) AS year,
    CAST(CAST(ROUND(t.tourism_receipts, 0)   AS DECIMAL(20, 0)) AS BIGINT) AS tourism_receipts,
    CAST(CAST(ROUND(t.tourism_departures, 0) AS DECIMAL(20, 0)) AS BIGINT) AS tourism_departures,
    CAST(CAST(ROUND(t.tourism_arrivals, 0)   AS DECIMAL(20, 0)) AS BIGINT) AS tourism_arrivals
FROM country_mapping c
JOIN dbo.world_tourism_economy_data t
    ON t.country_code = c.country_code
WHERE t.year BETWEEN 2000 AND 2020;

