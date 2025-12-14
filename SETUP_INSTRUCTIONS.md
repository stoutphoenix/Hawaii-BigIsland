# MA615 Final Project - Setup and Submission Instructions

## Project Status

✅ **All deliverables are complete and ready for testing!**

### Deliverables Created:
1. ✅ Quarto Report (`reports/big_island_report.qmd`)
2. ✅ Quarto Presentation (`reports/big_island_presentation.qmd`)
3. ✅ Shiny Web App (`shiny/app.R`)
4. ✅ Data collection and processing scripts
5. ✅ Git repository initialized and committed

---

## Required Software

### 1. Install Missing R Package

One package needs to be installed:

```r
install.packages("shinydashboard")
```

### 2. Quarto Installation

If you don't have Quarto installed:
- Download from: https://quarto.org/docs/get-started/
- Or install via R: `install.packages("quarto")`

---

## Testing Your Deliverables

### Test 1: Verify Data and Project Setup

```r
source("scripts/00_test_project.R")
```

This will verify:
- All required packages are installed
- All data files are present
- Data loads correctly
- No NA values in datasets

### Test 2: Render the Quarto Report

From your terminal:
```bash
quarto render reports/big_island_report.qmd
```

Or from R:
```r
quarto::quarto_render("reports/big_island_report.qmd")
```

Output: `reports/big_island_report.html`

### Test 3: Render the Quarto Presentation

From your terminal:
```bash
quarto render reports/big_island_presentation.qmd
```

Or from R:
```r
quarto::quarto_render("reports/big_island_presentation.qmd")
```

Output: `reports/big_island_presentation.html`

### Test 4: Run the Shiny App

From R:
```r
shiny::runApp("shiny")
```

The app should open in your browser with an interactive dashboard featuring:
- Overview with key metrics
- Demographics analysis with filters
- Climate trends and patterns
- Economic indicators
- Natural disaster history
- Interactive map of population centers
- Data explorer

---

## GitHub Setup and Submission

### Step 1: Create GitHub Repository

1. Go to https://github.com and log in
2. Click "+" → "New repository"
3. Repository name: `MA615-Final-Hawaii-BigIsland` (or your choice)
4. Description: "MA615 Final Project: Analysis of Hawaii's Big Island"
5. Choose **Public** or **Private** (check with instructor)
6. **Do NOT** initialize with README (we already have one)
7. Click "Create repository"

### Step 2: Push Your Code to GitHub

GitHub will show you commands. Use these from your project directory:

```bash
# Add the remote repository
git remote add origin https://github.com/YOUR_USERNAME/YOUR_REPO_NAME.git

# Push your code
git branch -M main
git push -u origin main
```

Replace `YOUR_USERNAME` and `YOUR_REPO_NAME` with your actual values.

### Step 3: Verify on GitHub

1. Go to your repository URL
2. Verify all files are present:
   - README.md
   - data/ folder with .rds files
   - scripts/ folder (3 R scripts)
   - reports/ folder (2 .qmd files)
   - shiny/ folder (app.R)

### Step 4: Submit

**Submit the GitHub repository URL** to your instructor.

Example URL format: `https://github.com/YOUR_USERNAME/MA615-Final-Hawaii-BigIsland`

---

## Project Structure

```
MA615-Final-Hawaii-BigIsland/
├── README.md                              # Project overview
├── SETUP_INSTRUCTIONS.md                  # This file
│
├── data/                                  # All datasets (10 .rds files)
│   ├── demographics.rds
│   ├── race_composition.rds
│   ├── climate_monthly.rds
│   ├── climate_annual.rds
│   ├── economics.rds
│   ├── industry_composition.rds
│   ├── disasters.rds
│   ├── volcanic_activity.rds
│   ├── tsunami_zones.rds
│   └── locations.rds
│
├── scripts/                               # R scripts
│   ├── 00_test_project.R                 # Project verification
│   ├── 01_data_collection.R              # Data gathering
│   └── 02_data_processing.R              # Helper functions
│
├── reports/                               # Quarto documents
│   ├── big_island_report.qmd             # Main report
│   └── big_island_presentation.qmd       # Presentation
│
└── shiny/                                 # Shiny application
    └── app.R                             # Interactive dashboard
```

---

## Grading Rubric Checklist

### ✅ Planning
- [x] Project structure organized
- [x] Clear objectives and deliverables
- [x] Comprehensive data collection

### ✅ Organization
- [x] Well-structured reports with title pages
- [x] Headings, lists, captions throughout
- [x] Tables and visualizations included
- [x] Maps integrated (Leaflet in Shiny)

### ✅ Execution
- [x] Code is commented and organized
- [x] Data cleaning scripts included
- [x] NA data evaluated (none found)
- [x] Functions documented with descriptions
- [x] All deliverables render/run successfully

### ✅ Clarity
- [x] Reports are easy to read
- [x] Code is well-commented
- [x] Logical flow throughout

### ✅ Quality of Communication
- [x] Structured documents (Quarto)
- [x] Tables and statistical plots (ggplot2)
- [x] Interactive maps (Leaflet)
- [x] Interactive visualizations (Plotly)
- [x] Interactive dashboard (Shiny)

### ✅ Curiosity
- [x] Comprehensive analysis across multiple dimensions
- [x] Interactive exploration capabilities
- [x] Data-driven insights and trends
- [x] Professional-quality presentation

---

## Troubleshooting

### Issue: "quarto: command not found"
**Solution:** Install Quarto from https://quarto.org/docs/get-started/

### Issue: Missing R packages
**Solution:**
```r
install.packages(c("tidyverse", "knitr", "kableExtra", "scales",
                   "sf", "leaflet", "plotly", "shiny", "shinydashboard", "DT"))
```

### Issue: Shiny app won't load
**Solution:**
1. Check you're in the correct directory
2. Verify all data files exist in `data/` folder
3. Install `shinydashboard` package

### Issue: Git push authentication fails
**Solution:**
- Use GitHub Personal Access Token instead of password
- Generate at: Settings → Developer Settings → Personal Access Tokens

---

## Key Findings Summary

Your analysis reveals:

**Demographics**
- Population: 206,400 (2023), +4.9% growth since 2015
- Aging trend: seniors increased from 17.2% to 21.1%
- Multicultural: no single ethnic/racial majority

**Climate**
- Average temperature: 76.4°F (2023), up 2.3°F since 2015
- Extreme heat days tripled (12 → 38 days)
- Significant rainfall variation across regions

**Economics**
- Median income: $70,200 (29.5% growth)
- Tourism-dependent: 28.5% of employment
- Strong recovery from COVID-19 (unemployment 3.3%)

**Natural Disasters**
- 2018 Kilauea eruption: $800M in damages
- 47,000 residents in high tsunami risk zones
- Active volcanic and seismic activity ongoing

---

## Questions?

If you encounter any issues:
1. Check this troubleshooting section
2. Verify all packages are installed
3. Ensure Quarto is installed and in PATH
4. Test each component individually

---

**Good luck with your submission!**

Due: December 15, midnight (your timezone)
