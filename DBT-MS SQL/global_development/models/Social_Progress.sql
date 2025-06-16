-- Social Progress Table
WITH country_mapping AS (
    SELECT DISTINCT
           alpha_3 AS country_code,
           name_clean AS name,
           region
    FROM dbo.countries
)

SELECT
    ROW_NUMBER() OVER (ORDER BY c.country_code, gdi.year) AS id,
    c.country_code,
    CAST(gdi.year AS INT)                 AS year,
    CAST(gdi.internet_usage_pct           AS FLOAT) AS internet_usage_pct,
    CAST(gdi.human_development_composite  AS FLOAT) AS human_development_composite,
    CAST(gdi.life_expectancy              AS FLOAT) AS life_expectancy
FROM   country_mapping                       c
JOIN   dbo.global_development_indicators_2000_2020 gdi
       ON gdi.country_code = c.country_code
WHERE  gdi.year BETWEEN 2000 AND 2020;

