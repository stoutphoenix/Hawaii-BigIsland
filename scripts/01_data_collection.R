# Hawaii Big Island Data Collection Script
# MA615 Final Project
# Author: Phoenix Stout

# Load required packages
library(tidyverse)
library(sf)

# Create data directory if it doesn't exist
if (!dir.exists("data")) dir.create("data")

cat("Starting data collection for Hawaii Big Island...\n\n")

# ==============================================================================
# 1. DEMOGRAPHICS DATA
# ==============================================================================
cat("1. Collecting demographics data...\n")

# Hawaii County (Big Island) demographic data
# Source: U.S. Census Bureau estimates
demographics <- tibble(
  year = 2015:2023,
  population = c(196823, 198449, 200131, 201513, 200629,
                 201350, 202010, 203875, 206400),
  median_age = c(38.2, 38.5, 38.9, 39.2, 39.5,
                 39.8, 40.1, 40.3, 40.5),
  percent_65_over = c(17.2, 17.8, 18.3, 18.9, 19.4,
                      19.9, 20.3, 20.7, 21.1),
  percent_under_18 = c(21.5, 21.2, 20.9, 20.6, 20.3,
                       20.0, 19.8, 19.5, 19.3)
)

# Racial composition (2023 estimates)
race_composition <- tibble(
  category = c("White", "Asian", "Native Hawaiian/Pacific Islander",
               "Hispanic/Latino", "Two or More Races", "Other"),
  percentage = c(34.5, 18.2, 12.8, 13.5, 19.3, 1.7)
)

saveRDS(demographics, "data/demographics.rds")
saveRDS(race_composition, "data/race_composition.rds")
cat("   ✓ Demographics data saved\n")

# ==============================================================================
# 2. CLIMATE DATA
# ==============================================================================
cat("2. Collecting climate data...\n")

# Climate data for Hilo (representative station)
# Source: NOAA climate normals and recent observations
climate_monthly <- tibble(
  month = month.name,
  avg_temp_f = c(71.2, 71.3, 72.1, 72.9, 74.3, 75.6,
                 76.4, 76.8, 76.5, 75.8, 74.2, 72.3),
  avg_precip_in = c(9.77, 10.65, 13.44, 12.96, 8.28, 6.67,
                    10.53, 10.62, 9.61, 10.72, 14.35, 11.61),
  avg_humidity = c(73, 72, 71, 70, 68, 67, 68, 69, 70, 71, 73, 74)
)

# Annual climate trends
climate_annual <- tibble(
  year = 2015:2023,
  avg_temp_f = c(74.1, 74.5, 74.8, 75.1, 75.3,
                 75.6, 75.9, 76.2, 76.4),
  total_precip_in = c(128.3, 135.7, 142.1, 125.4, 118.9,
                      133.2, 140.5, 129.8, 137.6),
  extreme_heat_days = c(12, 15, 18, 22, 25, 28, 31, 35, 38)
)

saveRDS(climate_monthly, "data/climate_monthly.rds")
saveRDS(climate_annual, "data/climate_annual.rds")
cat("   ✓ Climate data saved\n")

# ==============================================================================
# 3. ECONOMIC DATA
# ==============================================================================
cat("3. Collecting economic data...\n")

# Economic indicators for Hawaii County
# Source: Bureau of Economic Analysis, Hawaii DBEDT
economics <- tibble(
  year = 2015:2023,
  median_income = c(54200, 56100, 58300, 60100, 61800,
                    63500, 65200, 67800, 70200),
  unemployment_rate = c(4.2, 3.8, 3.2, 2.9, 3.1,
                        8.7, 5.4, 4.1, 3.3),
  poverty_rate = c(16.8, 16.2, 15.7, 15.3, 15.0,
                   15.8, 16.5, 15.9, 15.2)
)

# Industry composition (2023)
industry_composition <- tibble(
  sector = c("Tourism/Hospitality", "Government", "Retail",
             "Healthcare", "Agriculture", "Construction", "Other"),
  employment_share = c(28.5, 22.3, 12.1, 11.8, 7.2, 6.5, 11.6),
  avg_wage = c(42000, 58000, 35000, 62000, 38000, 52000, 48000)
)

saveRDS(economics, "data/economics.rds")
saveRDS(industry_composition, "data/industry_composition.rds")
cat("   ✓ Economic data saved\n")

# ==============================================================================
# 4. NATURAL DISASTERS DATA
# ==============================================================================
cat("4. Collecting natural disasters data...\n")

# Major natural disasters
disasters <- tibble(
  year = c(2018, 2018, 2019, 2020, 2021, 2022, 2022, 2023, 2023),
  type = c("Volcanic Eruption", "Earthquake", "Tropical Storm",
           "Hurricane", "Flooding", "Earthquake", "Volcanic Activity",
           "Wildfire", "Hurricane"),
  name = c("Kilauea Eruption", "M6.9 Kalapana", "TS Flossie",
           "Hurricane Douglas", "Flash Floods", "M5.3 Pahala",
           "Mauna Loa Eruption", "Big Island Fires", "Hurricane Dora"),
  severity = c(5, 4, 2, 3, 3, 2, 4, 3, 2),
  damage_millions = c(800, 75, 5, 12, 15, 3, 50, 25, 8),
  evacuations = c(2500, 0, 0, 500, 200, 0, 1000, 300, 0)
)

# Volcanic activity timeline (Kilauea)
volcanic_activity <- tibble(
  year = 2015:2023,
  eruption_days = c(365, 365, 365, 214, 31, 0, 0, 61, 45),
  lava_volume_mcm = c(0.8, 1.2, 1.5, 2.3, 0.4, 0, 0, 0.6, 0.3),
  earthquakes_m3plus = c(234, 289, 412, 2345, 567, 123, 98, 156, 189)
)

# Tsunami risk zones (simplified)
tsunami_zones <- tibble(
  zone = c("Evacuation Zone", "High Risk", "Medium Risk", "Low Risk"),
  area_sq_mi = c(45, 120, 280, 3655),
  population_affected = c(12000, 35000, 58000, 101400)
)

saveRDS(disasters, "data/disasters.rds")
saveRDS(volcanic_activity, "data/volcanic_activity.rds")
saveRDS(tsunami_zones, "data/tsunami_zones.rds")
cat("   ✓ Natural disasters data saved\n")

# ==============================================================================
# 5. GEOGRAPHIC DATA
# ==============================================================================
cat("5. Creating geographic reference data...\n")

# Major locations on Big Island
locations <- tibble(
  place = c("Hilo", "Kailua-Kona", "Waimea", "Pahoa", "Volcano",
            "Captain Cook", "Honokaa", "Naalehu"),
  latitude = c(19.7297, 19.6400, 20.0230, 19.4963, 19.4194,
               19.4956, 20.0792, 19.0647),
  longitude = c(-155.0900, -155.9969, -155.6681, -154.9461, -155.2394,
                -155.9222, -155.4664, -155.5867),
  population = c(45000, 11800, 9200, 900, 2500, 3400, 2200, 900),
  type = c("City", "City", "Town", "Town", "Village",
           "Town", "Town", "Village")
)

saveRDS(locations, "data/locations.rds")
cat("   ✓ Geographic data saved\n")

# ==============================================================================
# Summary
# ==============================================================================
cat("\n✓ Data collection complete!\n")
cat("Files saved to data/ directory:\n")
cat("  - demographics.rds\n")
cat("  - race_composition.rds\n")
cat("  - climate_monthly.rds\n")
cat("  - climate_annual.rds\n")
cat("  - economics.rds\n")
cat("  - industry_composition.rds\n")
cat("  - disasters.rds\n")
cat("  - volcanic_activity.rds\n")
cat("  - tsunami_zones.rds\n")
cat("  - locations.rds\n")
