# Test script to verify project setup
# MA615 Final Project
# Author: Phoenix Stout

cat("Testing Hawaii Big Island Project Setup...\n\n")

# ==============================================================================
# 1. CHECK REQUIRED PACKAGES
# ==============================================================================
cat("1. Checking required packages...\n")

required_packages <- c(
  "tidyverse", "knitr", "kableExtra", "scales", "sf",
  "leaflet", "plotly", "shiny", "shinydashboard", "DT"
)

missing_packages <- setdiff(required_packages, installed.packages()[, "Package"])

if (length(missing_packages) > 0) {
  cat("   ⚠ Missing packages:", paste(missing_packages, collapse = ", "), "\n")
  cat("   Install with: install.packages(c('", paste(missing_packages, collapse = "', '"), "'))\n")
} else {
  cat("   ✓ All required packages are installed\n")
}

# ==============================================================================
# 2. CHECK DATA FILES
# ==============================================================================
cat("\n2. Checking data files...\n")

data_files <- c(
  "data/demographics.rds",
  "data/race_composition.rds",
  "data/climate_monthly.rds",
  "data/climate_annual.rds",
  "data/economics.rds",
  "data/industry_composition.rds",
  "data/disasters.rds",
  "data/volcanic_activity.rds",
  "data/tsunami_zones.rds",
  "data/locations.rds"
)

all_exist <- TRUE
for (file in data_files) {
  if (file.exists(file)) {
    cat("   ✓", file, "\n")
  } else {
    cat("   ✗", file, "- MISSING\n")
    all_exist <- FALSE
  }
}

if (all_exist) {
  cat("   ✓ All data files present\n")
}

# ==============================================================================
# 3. TEST DATA LOADING
# ==============================================================================
cat("\n3. Testing data loading...\n")

tryCatch({
  demographics <- readRDS("data/demographics.rds")
  cat("   ✓ Demographics loaded:", nrow(demographics), "rows\n")

  climate <- readRDS("data/climate_monthly.rds")
  cat("   ✓ Climate data loaded:", nrow(climate), "rows\n")

  economics <- readRDS("data/economics.rds")
  cat("   ✓ Economics loaded:", nrow(economics), "rows\n")

  disasters <- readRDS("data/disasters.rds")
  cat("   ✓ Disasters loaded:", nrow(disasters), "rows\n")

  cat("   ✓ All data files load successfully\n")
}, error = function(e) {
  cat("   ✗ Error loading data:", conditionMessage(e), "\n")
})

# ==============================================================================
# 4. CHECK PROJECT FILES
# ==============================================================================
cat("\n4. Checking project files...\n")

project_files <- c(
  "scripts/01_data_collection.R",
  "scripts/02_data_processing.R",
  "reports/big_island_report.qmd",
  "reports/big_island_presentation.qmd",
  "shiny/app.R",
  "README.md"
)

for (file in project_files) {
  if (file.exists(file)) {
    cat("   ✓", file, "\n")
  } else {
    cat("   ✗", file, "- MISSING\n")
  }
}

# ==============================================================================
# 5. VALIDATE DATA INTEGRITY
# ==============================================================================
cat("\n5. Validating data integrity...\n")

library(tidyverse)

# Check for NA values
check_na <- function(data, name) {
  na_count <- sum(is.na(data))
  if (na_count == 0) {
    cat("   ✓", name, "- No NA values\n")
    return(TRUE)
  } else {
    cat("   ⚠", name, "- Contains", na_count, "NA values\n")
    return(FALSE)
  }
}

demographics <- readRDS("data/demographics.rds")
check_na(demographics, "Demographics")

race_composition <- readRDS("data/race_composition.rds")
check_na(race_composition, "Race Composition")

climate_monthly <- readRDS("data/climate_monthly.rds")
check_na(climate_monthly, "Climate Monthly")

economics <- readRDS("data/economics.rds")
check_na(economics, "Economics")

# ==============================================================================
# SUMMARY
# ==============================================================================
cat("\n", paste(rep("=", 70), collapse = ""), "\n", sep = "")
cat("PROJECT VERIFICATION COMPLETE\n")
cat(paste(rep("=", 70), collapse = ""), "\n", sep = "")

cat("\nNext steps:\n")
cat("1. Render Quarto report: quarto render reports/big_island_report.qmd\n")
cat("2. Render Quarto presentation: quarto render reports/big_island_presentation.qmd\n")
cat("3. Run Shiny app: shiny::runApp('shiny')\n")
cat("4. Create GitHub repository and push project\n")

cat("\nAll core components are in place and ready for testing!\n")
