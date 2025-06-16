USE global_development;
GO

drop table if exists dbo.countries;

create TABLE dbo.countries (
    name                         nvarchar(255),
    alpha_2                      char(2),
    alpha_3                      char(3),
    country_cc                   nvarchar(50),
    iso_3166_2                   nvarchar(50),
    region                       nvarchar(100),
    sub_region                   nvarchar(100),
    intermedia_region_cod        nvarchar(100),
    sub_region_intermedia        nvarchar(100),
    name_clean                   nvarchar(255)
);

drop table if exists dbo.gdi2;

create TABLE dbo.gdi2 (
    countryid                                         NVARCHAR(50),
    country                                           NVARCHAR(100),
    year                                              INT,
    ama_exchange_rate                                 FLOAT,
    imf_based_exchange_rate                           FLOAT,
    population                                        BIGINT,
    currency                                          NVARCHAR(50),
    per_capita_gni                                    FLOAT,
    agriculture_hunting_forestry_fishing_isic_ab      FLOAT,
    changes_in_inventories                            FLOAT,
    construction_isic_f                               FLOAT,
    exports_of_goods_and_services                     FLOAT,
    final_consumption_expenditure                     FLOAT,
    general_government_final_consumption_expenditure  FLOAT,
    gross_capital_formation                           FLOAT,
    gross_fixed_capital_formation_including_acq_less_disp_of_valuables FLOAT,
    household_consumption_expenditure_inc_npish       FLOAT,
    imports_of_goods_and_services                     FLOAT,
    manufacturing_isic_d                              FLOAT,
    mining_manufacturing_utilities_isic_ce            FLOAT,
    other_activities_isic_jp                          FLOAT,
    total_value_added                                 FLOAT,
    transport_storage_communication_isic_i            FLOAT,
    wholesale_retail_trade_restaurants_hotels_isic_gh FLOAT,
    gross_national_income_gni_usd                     FLOAT,
    gross_domestic_product_gdp                        FLOAT,
    country_clean                                     NVARCHAR(400)
);
GO

drop table if exists dbo.Global_Development_Indicators_2000_2020;

create TABLE dbo.Global_Development_Indicators_2000_2020 (
    year                                   INT,
    country_code                            CHAR(3),
    country_name                            NVARCHAR(100),
    region                                  NVARCHAR(50),
    income_group                            NVARCHAR(50),
    currency_unit                           NVARCHAR(50),
    gdp_usd                                 FLOAT,
    population                              BIGINT,
    gdp_per_capita                          FLOAT,
    inflation_rate                          FLOAT,
    unemployment_rate                       FLOAT,
    fdi_pct_gdp                             FLOAT,
    co2_emissions_kt                        FLOAT,
    energy_use_per_capita                   FLOAT,
    renewable_energy_pct                    FLOAT,
    forest_area_pct                         FLOAT,
    electricity_access_pct                  FLOAT,
    life_expectancy                         FLOAT,
    child_mortality                         FLOAT,
    school_enrollment_secondary             FLOAT,
    health_expenditure_pct_gdp              FLOAT,
    hospital_beds_per_1000                  FLOAT,
    physicians_per_1000                     FLOAT,
    internet_usage_pct                      FLOAT,
    mobile_subscriptions_per_100            FLOAT,
    calculated_gdp_per_capita               FLOAT,
    real_economic_growth_indicator          FLOAT,
    econ_opportunity_index                  FLOAT,
    co2_emissions_per_capita_tons           FLOAT,
    co2_intensity_per_million_gdp           FLOAT,
    green_transition_score                  FLOAT,
    ecological_preservation_index           FLOAT,
    renewable_energy_efficiency             FLOAT,
    human_development_composite             FLOAT,
    healthcare_capacity_index               FLOAT,
    digital_connectivity_index              FLOAT,
    health_development_ratio                FLOAT,
    education_health_ratio                  FLOAT,
    years_since_2000                        INT,
    years_since_century                     INT,
    is_pandemic_period                      BIT,
    human_development_index                 FLOAT,
    climate_vulnerability_index             FLOAT,
    digital_readiness_score                 FLOAT,
    governance_quality_index                FLOAT,
    global_resilience_score                 FLOAT,
    global_development_resilience_index     FLOAT
);
GO

drop table if exists dbo.world_tourism_economy_data;


CREATE TABLE dbo.world_tourism_economy_data (
    country               NVARCHAR(100),
    country_code          CHAR(3),
    year                  INT,
    tourism_receipts      FLOAT,      -- international tourism receipts, USD (or local)
    tourism_arrivals      BIGINT,     -- number of inbound tourists
    tourism_exports       FLOAT,      -- tourism exports, USD
    tourism_departures    BIGINT,     -- outbound tourists
    tourism_expenditures  FLOAT,      -- tourism expenditures, USD
    gdp                   FLOAT,      -- total GDP (optional indicator)
    inflation             FLOAT,      -- CPI or similar %
    unemployment          FLOAT       -- %
);
GO




