# Hawaii's Big Island Interactive Dashboard
# MA615 Final Project - Shiny Application
# Author: Phoenix Stout
# Date: December 15, 2025

library(shiny)
library(shinydashboard)
library(tidyverse)
library(plotly)
library(leaflet)
library(scales)
library(DT)

# ==============================================================================
# DATA LOADING
# ==============================================================================

# Load all data files
demographics <- readRDS("../data/demographics.rds")
race_composition <- readRDS("../data/race_composition.rds")
climate_monthly <- readRDS("../data/climate_monthly.rds")
climate_annual <- readRDS("../data/climate_annual.rds")
economics <- readRDS("../data/economics.rds")
industry_composition <- readRDS("../data/industry_composition.rds")
disasters <- readRDS("../data/disasters.rds")
volcanic_activity <- readRDS("../data/volcanic_activity.rds")
tsunami_zones <- readRDS("../data/tsunami_zones.rds")
locations <- readRDS("../data/locations.rds")

# Color palette
hawaii_colors <- c(
  ocean = "#006BA6",
  lava = "#C1121F",
  forest = "#2D6A4F",
  sand = "#F4A261",
  sunset = "#E76F51",
  sky = "#219EBC"
)

# ==============================================================================
# USER INTERFACE
# ==============================================================================

ui <- dashboardPage(
  skin = "blue",

  # Header
  dashboardHeader(
    title = "Hawaii's Big Island Dashboard",
    titleWidth = 350
  ),

  # Sidebar
  dashboardSidebar(
    width = 250,
    sidebarMenu(
      menuItem("Overview", tabName = "overview", icon = icon("home")),
      menuItem("Demographics", tabName = "demographics", icon = icon("users")),
      menuItem("Climate", tabName = "climate", icon = icon("cloud")),
      menuItem("Economics", tabName = "economics", icon = icon("dollar-sign")),
      menuItem("Natural Disasters", tabName = "disasters", icon = icon("exclamation-triangle")),
      menuItem("Interactive Map", tabName = "map", icon = icon("map-marked-alt")),
      menuItem("Data Explorer", tabName = "data", icon = icon("table")),
      menuItem("About", tabName = "about", icon = icon("info-circle"))
    )
  ),

  # Body
  dashboardBody(
    tags$head(
      tags$style(HTML("
        .box-title { font-weight: bold; }
        .small-box h3 { font-size: 32px; font-weight: bold; }
        .info-box-number { font-size: 24px; font-weight: bold; }
      "))
    ),

    tabItems(

      # OVERVIEW TAB
      tabItem(
        tabName = "overview",
        h2("Hawaii's Big Island: Key Metrics"),

        fluidRow(
          valueBoxOutput("pop_box", width = 3),
          valueBoxOutput("income_box", width = 3),
          valueBoxOutput("temp_box", width = 3),
          valueBoxOutput("disaster_box", width = 3)
        ),

        fluidRow(
          box(
            title = "Population Growth Trend",
            status = "primary",
            solidHeader = TRUE,
            width = 6,
            plotlyOutput("overview_pop_plot", height = 300)
          ),
          box(
            title = "Economic Indicators",
            status = "success",
            solidHeader = TRUE,
            width = 6,
            plotlyOutput("overview_econ_plot", height = 300)
          )
        ),

        fluidRow(
          box(
            title = "Climate Trends",
            status = "warning",
            solidHeader = TRUE,
            width = 6,
            plotlyOutput("overview_climate_plot", height = 300)
          ),
          box(
            title = "Recent Natural Disasters",
            status = "danger",
            solidHeader = TRUE,
            width = 6,
            plotlyOutput("overview_disasters_plot", height = 300)
          )
        )
      ),

      # DEMOGRAPHICS TAB
      tabItem(
        tabName = "demographics",
        h2("Demographics Analysis"),

        fluidRow(
          box(
            title = "Year Range Selection",
            status = "primary",
            width = 12,
            sliderInput(
              "demo_year_range",
              "Select Year Range:",
              min = min(demographics$year),
              max = max(demographics$year),
              value = c(min(demographics$year), max(demographics$year)),
              step = 1,
              sep = ""
            )
          )
        ),

        fluidRow(
          box(
            title = "Population Trends",
            status = "primary",
            solidHeader = TRUE,
            width = 8,
            plotlyOutput("demo_population_plot", height = 400)
          ),
          box(
            title = "Current Statistics",
            status = "info",
            solidHeader = TRUE,
            width = 4,
            tableOutput("demo_stats_table")
          )
        ),

        fluidRow(
          box(
            title = "Age Distribution Over Time",
            status = "primary",
            solidHeader = TRUE,
            width = 6,
            plotlyOutput("demo_age_plot", height = 350)
          ),
          box(
            title = "Racial/Ethnic Composition (2023)",
            status = "primary",
            solidHeader = TRUE,
            width = 6,
            plotlyOutput("demo_race_plot", height = 350)
          )
        )
      ),

      # CLIMATE TAB
      tabItem(
        tabName = "climate",
        h2("Climate Analysis"),

        fluidRow(
          box(
            title = "Climate Metric Selection",
            status = "warning",
            width = 12,
            selectInput(
              "climate_metric",
              "Select Climate Variable:",
              choices = c(
                "Temperature (°F)" = "avg_temp_f",
                "Precipitation (inches)" = "avg_precip_in",
                "Humidity (%)" = "avg_humidity"
              ),
              selected = "avg_temp_f"
            )
          )
        ),

        fluidRow(
          box(
            title = "Monthly Climate Patterns",
            status = "warning",
            solidHeader = TRUE,
            width = 8,
            plotlyOutput("climate_monthly_plot", height = 400)
          ),
          box(
            title = "Climate Summary",
            status = "info",
            solidHeader = TRUE,
            width = 4,
            tableOutput("climate_summary_table")
          )
        ),

        fluidRow(
          box(
            title = "Annual Temperature Trends",
            status = "warning",
            solidHeader = TRUE,
            width = 6,
            plotlyOutput("climate_annual_temp_plot", height = 350)
          ),
          box(
            title = "Extreme Heat Days",
            status = "danger",
            solidHeader = TRUE,
            width = 6,
            plotlyOutput("climate_heat_plot", height = 350)
          )
        )
      ),

      # ECONOMICS TAB
      tabItem(
        tabName = "economics",
        h2("Economic Analysis"),

        fluidRow(
          box(
            title = "Economic Indicator Selection",
            status = "success",
            width = 12,
            radioButtons(
              "econ_indicator",
              "Select Economic Indicator:",
              choices = c(
                "Median Income" = "median_income",
                "Unemployment Rate" = "unemployment_rate",
                "Poverty Rate" = "poverty_rate"
              ),
              selected = "median_income",
              inline = TRUE
            )
          )
        ),

        fluidRow(
          box(
            title = "Economic Trends",
            status = "success",
            solidHeader = TRUE,
            width = 8,
            plotlyOutput("econ_trends_plot", height = 400)
          ),
          box(
            title = "Current Economics",
            status = "info",
            solidHeader = TRUE,
            width = 4,
            tableOutput("econ_stats_table")
          )
        ),

        fluidRow(
          box(
            title = "Industry Employment Share",
            status = "success",
            solidHeader = TRUE,
            width = 6,
            plotlyOutput("econ_industry_plot", height = 350)
          ),
          box(
            title = "Average Wages by Sector",
            status = "success",
            solidHeader = TRUE,
            width = 6,
            plotlyOutput("econ_wages_plot", height = 350)
          )
        )
      ),

      # NATURAL DISASTERS TAB
      tabItem(
        tabName = "disasters",
        h2("Natural Disasters Analysis"),

        fluidRow(
          box(
            title = "Disaster Type Filter",
            status = "danger",
            width = 12,
            checkboxGroupInput(
              "disaster_types",
              "Select Disaster Types:",
              choices = unique(disasters$type),
              selected = unique(disasters$type),
              inline = TRUE
            )
          )
        ),

        fluidRow(
          box(
            title = "Disaster Economic Impact",
            status = "danger",
            solidHeader = TRUE,
            width = 8,
            plotlyOutput("disaster_damage_plot", height = 400)
          ),
          box(
            title = "Disaster Statistics",
            status = "info",
            solidHeader = TRUE,
            width = 4,
            tableOutput("disaster_stats_table")
          )
        ),

        fluidRow(
          box(
            title = "Volcanic Activity Timeline",
            status = "danger",
            solidHeader = TRUE,
            width = 6,
            plotlyOutput("volcanic_activity_plot", height = 350)
          ),
          box(
            title = "Tsunami Risk Zones",
            status = "warning",
            solidHeader = TRUE,
            width = 6,
            plotlyOutput("tsunami_zones_plot", height = 350)
          )
        )
      ),

      # INTERACTIVE MAP TAB
      tabItem(
        tabName = "map",
        h2("Geographic Distribution"),

        fluidRow(
          box(
            title = "Big Island Population Centers",
            status = "primary",
            solidHeader = TRUE,
            width = 12,
            height = 700,
            leafletOutput("island_map", height = 650)
          )
        ),

        fluidRow(
          box(
            title = "Location Details",
            status = "info",
            width = 12,
            DTOutput("locations_table")
          )
        )
      ),

      # DATA EXPLORER TAB
      tabItem(
        tabName = "data",
        h2("Data Explorer"),

        fluidRow(
          box(
            title = "Dataset Selection",
            status = "primary",
            width = 12,
            selectInput(
              "dataset_choice",
              "Select Dataset:",
              choices = c(
                "Demographics" = "demographics",
                "Racial Composition" = "race_composition",
                "Climate (Monthly)" = "climate_monthly",
                "Climate (Annual)" = "climate_annual",
                "Economics" = "economics",
                "Industry Composition" = "industry_composition",
                "Natural Disasters" = "disasters",
                "Volcanic Activity" = "volcanic_activity",
                "Tsunami Zones" = "tsunami_zones",
                "Locations" = "locations"
              )
            )
          )
        ),

        fluidRow(
          box(
            title = "Data Table",
            status = "primary",
            solidHeader = TRUE,
            width = 12,
            DTOutput("data_explorer_table")
          )
        ),

        fluidRow(
          box(
            title = "Dataset Summary",
            status = "info",
            solidHeader = TRUE,
            width = 12,
            verbatimTextOutput("data_summary")
          )
        )
      ),

      # ABOUT TAB
      tabItem(
        tabName = "about",
        h2("About This Dashboard"),

        fluidRow(
          box(
            title = "Project Information",
            status = "primary",
            solidHeader = TRUE,
            width = 12,
            h4("MA615 Final Project: Hawaii's Big Island Analysis"),
            p("This interactive dashboard provides comprehensive analysis of Hawaii's Big Island
              across four key dimensions: demographics, climate, economics, and natural disasters."),
            hr(),
            h4("Author"),
            p("Phoenix Stout"),
            p("MA615 Fall 2025"),
            hr(),
            h4("Data Sources"),
            tags$ul(
              tags$li("U.S. Census Bureau - Demographics"),
              tags$li("NOAA - Climate Data"),
              tags$li("Bureau of Economic Analysis - Economic Indicators"),
              tags$li("USGS & NOAA - Natural Disaster Records")
            ),
            hr(),
            h4("Technologies Used"),
            tags$ul(
              tags$li("R & Shiny for interactive dashboard"),
              tags$li("Plotly for interactive visualizations"),
              tags$li("Leaflet for interactive mapping"),
              tags$li("Quarto for reports and presentations")
            ),
            hr(),
            h4("Key Findings"),
            tags$ul(
              tags$li(strong("Population:"), "206,400 residents (2023), growing 4.9% since 2015"),
              tags$li(strong("Economy:"), "Median income $70,200, tourism-dependent (28.5%)"),
              tags$li(strong("Climate:"), "Warming trend with extreme heat days tripling"),
              tags$li(strong("Hazards:"), "$800M in volcanic damages (2018), ongoing risks")
            )
          )
        )
      )
    )
  )
)

# ==============================================================================
# SERVER
# ==============================================================================

server <- function(input, output, session) {

  # ============================================================================
  # OVERVIEW TAB
  # ============================================================================

  output$pop_box <- renderValueBox({
    valueBox(
      value = comma(tail(demographics$population, 1)),
      subtitle = "Current Population (2023)",
      icon = icon("users"),
      color = "blue"
    )
  })

  output$income_box <- renderValueBox({
    valueBox(
      value = dollar(tail(economics$median_income, 1)),
      subtitle = "Median Household Income",
      icon = icon("dollar-sign"),
      color = "green"
    )
  })

  output$temp_box <- renderValueBox({
    valueBox(
      value = paste0(tail(climate_annual$avg_temp_f, 1), "°F"),
      subtitle = "Average Temperature (2023)",
      icon = icon("thermometer-half"),
      color = "yellow"
    )
  })

  output$disaster_box <- renderValueBox({
    valueBox(
      value = dollar(sum(disasters$damage_millions), suffix = "M"),
      subtitle = "Total Disaster Damages",
      icon = icon("exclamation-triangle"),
      color = "red"
    )
  })

  output$overview_pop_plot <- renderPlotly({
    p <- ggplot(demographics, aes(x = year, y = population)) +
      geom_line(color = hawaii_colors["ocean"], size = 1) +
      geom_point(color = hawaii_colors["ocean"], size = 2) +
      scale_y_continuous(labels = comma) +
      labs(x = "Year", y = "Population") +
      theme_minimal()

    ggplotly(p) %>%
      layout(hovermode = "x unified")
  })

  output$overview_econ_plot <- renderPlotly({
    p <- ggplot(economics, aes(x = year, y = median_income)) +
      geom_line(color = hawaii_colors["forest"], size = 1) +
      geom_point(color = hawaii_colors["forest"], size = 2) +
      scale_y_continuous(labels = dollar) +
      labs(x = "Year", y = "Median Income") +
      theme_minimal()

    ggplotly(p) %>%
      layout(hovermode = "x unified")
  })

  output$overview_climate_plot <- renderPlotly({
    p <- ggplot(climate_annual, aes(x = year, y = avg_temp_f)) +
      geom_line(color = hawaii_colors["lava"], size = 1) +
      geom_point(color = hawaii_colors["lava"], size = 2) +
      labs(x = "Year", y = "Average Temperature (°F)") +
      theme_minimal()

    ggplotly(p) %>%
      layout(hovermode = "x unified")
  })

  output$overview_disasters_plot <- renderPlotly({
    p <- ggplot(disasters, aes(x = year, y = damage_millions, fill = type, text = name)) +
      geom_col() +
      scale_y_continuous(labels = dollar_format(suffix = "M")) +
      labs(x = "Year", y = "Damages (Millions)", fill = "Type") +
      theme_minimal() +
      theme(legend.position = "bottom")

    ggplotly(p, tooltip = c("x", "y", "fill", "text"))
  })

  # ============================================================================
  # DEMOGRAPHICS TAB
  # ============================================================================

  demo_filtered <- reactive({
    demographics %>%
      filter(year >= input$demo_year_range[1] & year <= input$demo_year_range[2])
  })

  output$demo_population_plot <- renderPlotly({
    p <- ggplot(demo_filtered(), aes(x = year, y = population)) +
      geom_line(color = hawaii_colors["ocean"], size = 1.2) +
      geom_point(color = hawaii_colors["ocean"], size = 3) +
      scale_y_continuous(labels = comma) +
      labs(x = "Year", y = "Population") +
      theme_minimal()

    ggplotly(p) %>%
      layout(hovermode = "x unified")
  })

  output$demo_stats_table <- renderTable({
    latest <- tail(demographics, 1)
    tibble(
      Metric = c("Population", "Median Age", "% 65 and Over", "% Under 18"),
      Value = c(
        comma(latest$population),
        paste0(latest$median_age, " years"),
        paste0(latest$percent_65_over, "%"),
        paste0(latest$percent_under_18, "%")
      )
    )
  })

  output$demo_age_plot <- renderPlotly({
    age_data <- demo_filtered() %>%
      select(year, `65 and Over` = percent_65_over, `Under 18` = percent_under_18) %>%
      pivot_longer(cols = -year, names_to = "group", values_to = "percentage")

    p <- ggplot(age_data, aes(x = year, y = percentage, color = group)) +
      geom_line(size = 1.2) +
      geom_point(size = 2) +
      labs(x = "Year", y = "Percentage", color = "Age Group") +
      theme_minimal()

    ggplotly(p) %>%
      layout(hovermode = "x unified")
  })

  output$demo_race_plot <- renderPlotly({
    p <- ggplot(race_composition, aes(x = reorder(category, percentage), y = percentage, fill = category)) +
      geom_col(show.legend = FALSE) +
      coord_flip() +
      labs(x = NULL, y = "Percentage") +
      theme_minimal()

    ggplotly(p)
  })

  # ============================================================================
  # CLIMATE TAB
  # ============================================================================

  output$climate_monthly_plot <- renderPlotly({
    climate_data <- climate_monthly %>%
      mutate(month = factor(month, levels = month.name))

    metric_col <- input$climate_metric
    y_label <- case_when(
      metric_col == "avg_temp_f" ~ "Temperature (°F)",
      metric_col == "avg_precip_in" ~ "Precipitation (inches)",
      metric_col == "avg_humidity" ~ "Humidity (%)"
    )

    p <- ggplot(climate_data, aes(x = month, y = .data[[metric_col]])) +
      geom_line(aes(group = 1), color = hawaii_colors["ocean"], size = 1.2) +
      geom_point(color = hawaii_colors["ocean"], size = 3) +
      labs(x = "Month", y = y_label) +
      theme_minimal() +
      theme(axis.text.x = element_text(angle = 45, hjust = 1))

    ggplotly(p)
  })

  output$climate_summary_table <- renderTable({
    metric <- input$climate_metric

    summary_val <- case_when(
      metric == "avg_temp_f" ~ climate_monthly %>% summarise(avg = mean(avg_temp_f)) %>% pull(),
      metric == "avg_precip_in" ~ climate_monthly %>% summarise(total = sum(avg_precip_in)) %>% pull(),
      metric == "avg_humidity" ~ climate_monthly %>% summarise(avg = mean(avg_humidity)) %>% pull()
    )

    tibble(
      Metric = c("Average", "Minimum", "Maximum"),
      Value = c(
        round(summary_val, 1),
        round(min(climate_monthly[[metric]]), 1),
        round(max(climate_monthly[[metric]]), 1)
      )
    )
  })

  output$climate_annual_temp_plot <- renderPlotly({
    p <- ggplot(climate_annual, aes(x = year, y = avg_temp_f)) +
      geom_line(color = hawaii_colors["lava"], size = 1.2) +
      geom_point(color = hawaii_colors["lava"], size = 3) +
      labs(x = "Year", y = "Average Temperature (°F)") +
      theme_minimal()

    ggplotly(p) %>%
      layout(hovermode = "x unified")
  })

  output$climate_heat_plot <- renderPlotly({
    p <- ggplot(climate_annual, aes(x = year, y = extreme_heat_days)) +
      geom_col(fill = hawaii_colors["sunset"]) +
      labs(x = "Year", y = "Extreme Heat Days (>90°F)") +
      theme_minimal()

    ggplotly(p)
  })

  # ============================================================================
  # ECONOMICS TAB
  # ============================================================================

  output$econ_trends_plot <- renderPlotly({
    indicator <- input$econ_indicator

    color_choice <- case_when(
      indicator == "median_income" ~ hawaii_colors["forest"],
      indicator == "unemployment_rate" ~ hawaii_colors["lava"],
      indicator == "poverty_rate" ~ hawaii_colors["sunset"]
    )

    y_label <- case_when(
      indicator == "median_income" ~ "Median Income",
      indicator == "unemployment_rate" ~ "Unemployment Rate (%)",
      indicator == "poverty_rate" ~ "Poverty Rate (%)"
    )

    p <- ggplot(economics, aes(x = year, y = .data[[indicator]])) +
      geom_line(color = color_choice, size = 1.2) +
      geom_point(color = color_choice, size = 3) +
      labs(x = "Year", y = y_label) +
      theme_minimal()

    if (indicator == "median_income") {
      p <- p + scale_y_continuous(labels = dollar)
    }

    ggplotly(p) %>%
      layout(hovermode = "x unified")
  })

  output$econ_stats_table <- renderTable({
    latest <- tail(economics, 1)
    tibble(
      Metric = c("Median Income", "Unemployment", "Poverty Rate"),
      Value = c(
        dollar(latest$median_income),
        paste0(latest$unemployment_rate, "%"),
        paste0(latest$poverty_rate, "%")
      )
    )
  })

  output$econ_industry_plot <- renderPlotly({
    p <- ggplot(industry_composition, aes(x = reorder(sector, employment_share),
                                          y = employment_share, fill = sector)) +
      geom_col(show.legend = FALSE) +
      coord_flip() +
      labs(x = NULL, y = "Employment Share (%)") +
      theme_minimal()

    ggplotly(p)
  })

  output$econ_wages_plot <- renderPlotly({
    p <- ggplot(industry_composition, aes(x = reorder(sector, avg_wage),
                                          y = avg_wage, fill = sector)) +
      geom_col(show.legend = FALSE) +
      coord_flip() +
      scale_y_continuous(labels = dollar) +
      labs(x = NULL, y = "Average Wage") +
      theme_minimal()

    ggplotly(p)
  })

  # ============================================================================
  # NATURAL DISASTERS TAB
  # ============================================================================

  disasters_filtered <- reactive({
    disasters %>%
      filter(type %in% input$disaster_types)
  })

  output$disaster_damage_plot <- renderPlotly({
    p <- ggplot(disasters_filtered(), aes(x = year, y = damage_millions,
                                          fill = type, text = name)) +
      geom_col() +
      scale_y_continuous(labels = dollar_format(suffix = "M")) +
      labs(x = "Year", y = "Damages (Millions USD)", fill = "Disaster Type") +
      theme_minimal() +
      theme(legend.position = "bottom")

    ggplotly(p, tooltip = c("x", "y", "fill", "text"))
  })

  output$disaster_stats_table <- renderTable({
    total_damage <- sum(disasters_filtered()$damage_millions)
    total_events <- nrow(disasters_filtered())
    total_evac <- sum(disasters_filtered()$evacuations)

    tibble(
      Metric = c("Total Events", "Total Damage", "Total Evacuations"),
      Value = c(
        total_events,
        dollar(total_damage, suffix = "M"),
        comma(total_evac)
      )
    )
  })

  output$volcanic_activity_plot <- renderPlotly({
    p <- ggplot(volcanic_activity, aes(x = year)) +
      geom_col(aes(y = eruption_days), fill = hawaii_colors["lava"], alpha = 0.7) +
      geom_line(aes(y = earthquakes_m3plus / 5), color = hawaii_colors["ocean"], size = 1.2) +
      geom_point(aes(y = earthquakes_m3plus / 5), color = hawaii_colors["ocean"], size = 3) +
      scale_y_continuous(
        name = "Eruption Days",
        sec.axis = sec_axis(~ . * 5, name = "Earthquakes (M3+)")
      ) +
      labs(x = "Year") +
      theme_minimal()

    ggplotly(p)
  })

  output$tsunami_zones_plot <- renderPlotly({
    p <- ggplot(tsunami_zones, aes(x = reorder(zone, -population_affected),
                                   y = population_affected, fill = zone)) +
      geom_col(show.legend = FALSE) +
      scale_y_continuous(labels = comma) +
      labs(x = "Risk Zone", y = "Population Affected") +
      theme_minimal() +
      theme(axis.text.x = element_text(angle = 45, hjust = 1))

    ggplotly(p)
  })

  # ============================================================================
  # INTERACTIVE MAP TAB
  # ============================================================================

  output$island_map <- renderLeaflet({
    leaflet(locations) %>%
      addProviderTiles(providers$OpenStreetMap) %>%
      addCircleMarkers(
        ~longitude, ~latitude,
        radius = ~sqrt(population) / 15,
        color = ~ifelse(type == "City", hawaii_colors["lava"], hawaii_colors["ocean"]),
        fillOpacity = 0.7,
        stroke = TRUE,
        weight = 2,
        popup = ~paste0(
          "<b>", place, "</b><br/>",
          "Population: ", comma(population), "<br/>",
          "Type: ", type, "<br/>",
          "Coordinates: ", round(latitude, 4), ", ", round(longitude, 4)
        ),
        label = ~place
      ) %>%
      setView(lng = -155.5, lat = 19.6, zoom = 9)
  })

  output$locations_table <- renderDT({
    datatable(
      locations %>%
        arrange(desc(population)) %>%
        mutate(
          population = comma(population),
          latitude = round(latitude, 4),
          longitude = round(longitude, 4)
        ),
      options = list(pageLength = 8),
      rownames = FALSE
    )
  })

  # ============================================================================
  # DATA EXPLORER TAB
  # ============================================================================

  selected_dataset <- reactive({
    switch(
      input$dataset_choice,
      "demographics" = demographics,
      "race_composition" = race_composition,
      "climate_monthly" = climate_monthly,
      "climate_annual" = climate_annual,
      "economics" = economics,
      "industry_composition" = industry_composition,
      "disasters" = disasters,
      "volcanic_activity" = volcanic_activity,
      "tsunami_zones" = tsunami_zones,
      "locations" = locations
    )
  })

  output$data_explorer_table <- renderDT({
    datatable(
      selected_dataset(),
      options = list(pageLength = 10, scrollX = TRUE),
      rownames = FALSE
    )
  })

  output$data_summary <- renderPrint({
    summary(selected_dataset())
  })
}

# ==============================================================================
# RUN APPLICATION
# ==============================================================================

shinyApp(ui = ui, server = server)
