-- Population Table
WITH country_mapping AS (
    SELECT DISTINCT
           alpha_3 AS country_code,
           name_clean AS name,
           region
    FROM dbo.countries
)

SELECT
    ROW_NUMBER() OVER (ORDER BY c.country_code, gdi1.year) AS id,
    c.country_code,
    CAST(gdi1.year AS INT)               AS year,
    CAST(gdi1.calculated_gdp_per_capita  AS FLOAT) AS gdp_per_capita,
    CAST(gdi2.per_capita_gni             AS FLOAT) AS gni_per_capita,
    CAST(gdi1.population                 AS INT)   AS population
FROM   country_mapping                        c
JOIN   dbo.global_development_indicators_2000_2020 gdi1
       ON gdi1.country_code = c.country_code
JOIN   dbo.gdi2 gdi2
       ON gdi2.country_clean = c.name
      AND CAST(gdi1.year AS INT) = CAST(gdi2.year AS INT)
WHERE  gdi1.year BETWEEN 2000 AND 2020;
