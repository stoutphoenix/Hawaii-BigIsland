# MA615 Final Project: Hawaii's Big Island

**Author:** Phoenix Stout

**Course:** MA615 Fall 2025

## Project Overview

This project analyzes Hawaii's Big Island across four key dimensions:
- Demographics
- Climate
- Economics
- Natural Disasters

## Deliverables

1. **Quarto Report** (`reports/big_island_report.qmd`) - Comprehensive analysis with visualizations and maps
2. **Quarto Presentation** (`reports/big_island_presentation.qmd`) - Key findings presentation
3. **Shiny Web App** (`shiny/app.R`) - Interactive dashboard for data exploration

## Project Structure

```
├── data/              # Data files and sources
├── scripts/           # Data gathering and processing scripts
├── reports/           # Quarto report and presentation
├── shiny/             # Shiny web application
└── README.md          # This file
```

## Running the Project

### Render the Report
```r
quarto::quarto_render("reports/big_island_report.qmd")
```

### Render the Presentation
```r
quarto::quarto_render("reports/big_island_presentation.qmd")
```

### Run the Shiny App
```r
shiny::runApp("shiny")
```

## Data Sources

- U.S. Census Bureau (demographics)
- NOAA (climate data)
- Bureau of Economic Analysis (economic indicators)
- USGS/NOAA (natural disaster records)
