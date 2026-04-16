# Energy Consumption Predictor: Interactive Shiny App

R Shiny application predicting residential energy consumption under a simulated 5-degree warming scenario, built for a class final project using weather, energy, and building data across South Carolina.

## Live App

[View the Interactive App](https://jessicaa.shinyapps.io/shinyfinal/)

## Project Overview

This project was completed as a class final project built around a simulated consulting scenario. Our team took on the role of data scientists advising a fictional energy company, eSC, facing concerns about how rising summer temperatures would impact residential electricity demand across South Carolina. The core question: if this summer were 5 degrees warmer, how would energy usage change, and what can be done about it? The project followed the full OSEMN data science pipeline across multiple datasets covering building characteristics, energy usage, weather patterns, and regional metadata.

## Key Findings

Temperature and wind speed were statistically significant predictors of energy consumption across all five county-level models. Peak energy usage consistently occurred mid-day, aligned with peak heat hours. A simulated 5-degree increase pushed the majority of daily hours above the 80-degree threshold, the point at which indoor activity and electricity use increase significantly. County 4 had the strongest model fit with an Adjusted R-squared of 25%.

## Recommendations

Temperature-responsive cooling systems that adjust in real time during peak heat hours. Off-peak pricing incentives to shift energy consumption to lower-demand periods. AI-driven supply forecasting based on weather data to anticipate and manage grid strain. Smart grid implementation to redistribute consumption without building new infrastructure.

## Tech Stack

Language: R | Application: R Shiny | Libraries: tidyverse, arrow, ggplot2 | Data formats: Parquet, CSV

## Data Sources

All datasets were accessed programmatically via AWS S3 as part of the class assignment. static_house_info.parquet covers building-level characteristics, data_dictionary.csv contains metadata and variable definitions, and energy usage and weather data were retrieved by county code via S3. To replicate the analysis, run energy_consumption_analysis.Rmd — the data loads automatically from the source URLs. Analysis was scoped to the top 10 most populous counties in South Carolina, focusing on July as the peak summer demand month.

## How to Run Locally

Clone the repository at https://github.com/jessdion/Energy-Consumption-Shiny.git, open the project in RStudio, install required packages with install.packages(c("shiny", "tidyverse", "arrow", "ggplot2")), then run the app with shiny::runApp().

## Project Structure

Energy-Consumption-Shiny/ contains energy_predictor_app.R (Interactive Shiny application), energy_consumption_analysis.Rmd (Full analysis and write-up), and README.md.

## Authors

Jessica Aimunmondion — Project Manager, Shiny App Development (sole), Presentation Design. MS Applied Data Science, Business Analytics Concentration, Syracuse University iSchool. Joel Barnes — Lead Developer. Zeek Moore — Co-contributor. Portfolio: https://jessdion.github.io/JessicaAimunmondion | LinkedIn: https://www.linkedin.com/in/jessicaaimunmondion/ | GitHub: https://github.com/jessdion
