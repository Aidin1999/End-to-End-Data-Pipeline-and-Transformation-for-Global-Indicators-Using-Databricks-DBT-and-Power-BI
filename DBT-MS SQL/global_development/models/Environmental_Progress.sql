-- Environmental Progress Table
with country_mapping as (SELECT DISTINCT alpha_3 AS country_code, name_clean AS name, region
FROM dbo.countries)


SELECT 
    ROW_NUMBER() OVER (ORDER BY c.country_code, gdi1.year) AS id,
    c.country_code,
    CAST(gdi1.year AS INT) AS year,
    CAST(gdi1.energy_use_per_capita AS FLOAT) AS energy_use_per_capita,
    CAST(gdi1.renewable_energy_pct AS FLOAT) AS renewable_energy_pct,
    CAST(gdi1.co2_emissions_per_capita_tons AS FLOAT) AS co2_emissions_per_capita_tons
FROM country_mapping AS c
JOIN dbo.global_development_indicators_2000_2020 AS gdi1 ON gdi1.country_code = c.country_code
WHERE gdi1.year BETWEEN 2000 AND 2020;