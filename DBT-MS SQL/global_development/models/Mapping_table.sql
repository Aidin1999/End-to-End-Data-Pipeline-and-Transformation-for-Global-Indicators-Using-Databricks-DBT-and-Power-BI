-- Country Mapping table 
SELECT DISTINCT
       alpha_3 AS country_code,
       name_clean AS name,
       region
FROM   dbo.countries;

