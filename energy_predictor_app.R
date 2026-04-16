#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    https://shiny.posit.co/
#

# Define UI for application that draws a histogram
library(shiny)
library(ggplot2)
library(dplyr)

# Calculate min/max temps
temp_min <- floor(min(c(JulyeneWea$`Dry Bulb Temperature [°F]`, NEWJuly$`Dry Bulb Temperature [°F]`), na.rm = TRUE))
temp_max <- ceiling(max(c(JulyeneWea$`Dry Bulb Temperature [°F]`, NEWJuly$`Dry Bulb Temperature [°F]`), na.rm = TRUE))

# UI
ui <- fluidPage(
  titlePanel("Energy Usage Analysis"),
  
  tabsetPanel(
    tabPanel("By Temperature",
             sidebarLayout(
               sidebarPanel(
                 selectInput("dataset", "Choose Dataset:",
                             choices = c("Original Weather" = "original", "Increased Temp (+5°F)" = "adjusted")),
                 
                 sliderInput("temp_range", "Select Temperature Range (°F):",
                             min = temp_min,
                             max = temp_max,
                             value = c(temp_min, temp_max))
               ),
               mainPanel(
                 plotOutput("energyPlot")
               )
             )
    ),
    
    tabPanel("By Hour of Day",
             sidebarLayout(
               sidebarPanel(
                 selectInput("dataset_hour", "Choose Dataset:",
                             choices = c("Original Weather" = "original", "Increased Temp (+5°F)" = "adjusted")),
                 sliderInput("hour_range", "Select Hour Range:",
                             min = 0, max = 23, value = c(0, 23), step = 1)
               ),
               mainPanel(
                 plotOutput("hourlyPlot")
               )
             )
    )
  )
)

# Server
server <- function(input, output) {
  
  # Plot by Temperature
  output$energyPlot <- renderPlot({
    data <- if (input$dataset == "original") JulyeneWea else NEWJuly
    
    filtered_data <- data %>%
      filter(`Dry Bulb Temperature [°F]` >= input$temp_range[1],
             `Dry Bulb Temperature [°F]` <= input$temp_range[2]) %>%
      group_by(`Dry Bulb Temperature [°F]`) %>%
      summarise(avg_electricity = mean(total.electricity, na.rm = TRUE), .groups = "drop")
    
    ggplot(filtered_data, aes(x = `Dry Bulb Temperature [°F]`, y = avg_electricity)) +
      geom_line(aes(color = "Average Usage"), size = 1) +
      geom_point(aes(color = "Observed Points"), size = 2) +
      geom_smooth(method = "lm", se = FALSE, aes(color = "Trend Line"), linetype = "dashed") +
      scale_color_manual(
        name = "Legend",
        values = c(
          "Average Usage" = "#1D3557",
          "Observed Points" = "#E63946",
          "Trend Line" = "darkgreen"
        )
      ) +
      labs(
        title = "Energy Usage by Temperature",
        x = "Dry Bulb Temperature (°F)",
        y = "Average Electricity Consumption (kWh)"
      ) +
      theme_minimal() +
      theme(
        plot.title = element_text(hjust = 0.5, face = "bold"),
        axis.title = element_text(face = "bold"),
        axis.text = element_text(color = "gray30"),
        legend.position = "bottom",
        legend.title = element_text(face = "bold")
      )
  })
  
  # Plot by Hour of Day with hour slider
  output$hourlyPlot <- renderPlot({
    data <- if (input$dataset_hour == "original") JulyeneWea else NEWJuly
    
    hourly_data <- data %>%
      filter(hour >= input$hour_range[1], hour <= input$hour_range[2]) %>%
      group_by(hour) %>%
      summarise(avg_electricity = mean(total.electricity, na.rm = TRUE), .groups = "drop")
    
    ggplot(hourly_data, aes(x = hour, y = avg_electricity)) +
      geom_line(color = "#457B9D", size = 1) +
      geom_point(color = "#1D3557", size = 2) +
      labs(
        title = "Average Electricity Usage by Hour of Day",
        x = "Hour",
        y = "Average Electricity Consumption (kWh)"
      ) +
      theme_minimal() +
      theme(
        plot.title = element_text(hjust = 0.5, face = "bold"),
        axis.title = element_text(face = "bold"),
        axis.text = element_text(color = "gray30")
      )
  })
}


# Run app
shinyApp(ui = ui, server = server)