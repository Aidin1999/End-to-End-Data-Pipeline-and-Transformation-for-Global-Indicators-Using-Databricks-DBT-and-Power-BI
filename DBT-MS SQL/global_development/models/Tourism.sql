-- Tourism Table
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
    CAST(t.year AS INT)          AS year,
    t.tourism_receipts,
    t.tourism_departures,
    t.tourism_arrivals
FROM   country_mapping                       c
JOIN   dbo.world_tourism_economy_data t
       ON t.country_code = c.country_code
WHERE  t.year BETWEEN 2000 AND 2020;
