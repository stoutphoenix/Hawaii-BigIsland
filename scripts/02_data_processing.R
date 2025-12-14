# Hawaii Big Island Data Processing and Visualization Functions
# MA615 Final Project
# Author: Phoenix Stout

library(tidyverse)
library(scales)

# ==============================================================================
# THEME SETTINGS
# ==============================================================================

# Custom theme for plots
theme_bigisland <- function() {
  theme_minimal() +
    theme(
      plot.title = element_text(face = "bold", size = 14),
      plot.subtitle = element_text(size = 11, color = "gray30"),
      axis.title = element_text(size = 10),
      legend.position = "bottom"
    )
}

# Color palette inspired by Hawaii
hawaii_colors <- c(
  ocean = "#006BA6",
  lava = "#C1121F",
  forest = "#2D6A4F",
  sand = "#F4A261",
  sunset = "#E76F51",
  sky = "#219EBC"
)

# ==============================================================================
# DATA LOADING FUNCTIONS
# ==============================================================================

#' Load all project data
#' @return List of all data frames
load_all_data <- function() {
  list(
    demographics = readRDS("data/demographics.rds"),
    race_composition = readRDS("data/race_composition.rds"),
    climate_monthly = readRDS("data/climate_monthly.rds"),
    climate_annual = readRDS("data/climate_annual.rds"),
    economics = readRDS("data/economics.rds"),
    industry_composition = readRDS("data/industry_composition.rds"),
    disasters = readRDS("data/disasters.rds"),
    volcanic_activity = readRDS("data/volcanic_activity.rds"),
    tsunami_zones = readRDS("data/tsunami_zones.rds"),
    locations = readRDS("data/locations.rds")
  )
}

# ==============================================================================
# SUMMARY STATISTICS FUNCTIONS
# ==============================================================================

#' Calculate summary statistics for demographics
#' @param demographics Demographics data frame
#' @return Summary table
summarize_demographics <- function(demographics) {
  demographics %>%
    summarise(
      latest_population = last(population),
      population_growth = (last(population) - first(population)) / first(population) * 100,
      median_age_2023 = last(median_age),
      pct_seniors = last(percent_65_over)
    )
}

#' Calculate summary statistics for economics
#' @param economics Economics data frame
#' @return Summary table
summarize_economics <- function(economics) {
  economics %>%
    summarise(
      latest_median_income = last(median_income),
      income_growth = (last(median_income) - first(median_income)) / first(median_income) * 100,
      current_unemployment = last(unemployment_rate),
      current_poverty = last(poverty_rate)
    )
}

# ==============================================================================
# VALIDATION FUNCTIONS
# ==============================================================================

#' Check for NA values in a data frame
#' @param df Data frame to check
#' @param name Name of the data frame for reporting
check_na_values <- function(df, name) {
  na_count <- sum(is.na(df))
  if (na_count > 0) {
    message(sprintf("Warning: %s contains %d NA values", name, na_count))
    return(FALSE)
  }
  return(TRUE)
}

#' Validate all datasets
#' @return TRUE if all datasets are valid
validate_all_data <- function() {
  data_list <- load_all_data()

  all_valid <- TRUE
  for (name in names(data_list)) {
    if (!check_na_values(data_list[[name]], name)) {
      all_valid <- FALSE
    }
  }

  if (all_valid) {
    message("✓ All datasets validated successfully - no NA values detected")
  }

  return(all_valid)
}

# ==============================================================================
# EXPORT FUNCTIONS
# ==============================================================================

#' Save a plot to file
#' @param plot ggplot object
#' @param filename Output filename
#' @param width Width in inches
#' @param height Height in inches
save_plot <- function(plot, filename, width = 8, height = 6) {
  ggsave(
    filename,
    plot,
    width = width,
    height = height,
    dpi = 300
  )
}
