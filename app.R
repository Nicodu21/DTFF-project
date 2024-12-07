library(shiny)
library(ggplot2)
library(readxl)
library(dplyr)
library(zoo)  # For rolling calculations
library(tidyr)
library(readr)

# Load the data
stock_data <- read_csv("/srv/shiny-server/Stock_Prices_csv.csv", delim = ";")
announcements_data <- read_excel("/srv/shiny-server/announcements.xlsx")



# Reshape the stock data to long format
stock_data_long <- stock_data %>%
  pivot_longer(
    cols = -Name,            # Keep the "Name" column as-is
    names_to = "Date",       # Create a "Date" column from column names
    values_to = "Price"      # Create a "Price" column for the values
  ) %>%
  mutate(
    Date = as.Date(Date, format = "%d.%m.%Y"),  # Convert Date to proper format
    Price = as.numeric(gsub(",", ".", Price))  # Convert Price to numeric
  )

# Ensure the announcements data has proper date formatting
announcements_data <- announcements_data %>%
  mutate(Date = as.Date(Date, format = "%Y-%m-%d"))

# UI
ui <- fluidPage(
  titlePanel("Firm Volatility Over Time"),
  sidebarLayout(
    sidebarPanel(
      selectInput("firm", "Select a firm:", choices = unique(stock_data_long$Name)),
      dateRangeInput(
        "date_range",
        "Select Time Frame:",
        start = min(stock_data_long$Date, na.rm = TRUE),
        end = max(stock_data_long$Date, na.rm = TRUE)
      ),
      actionButton("update", "Update Graph")
    ),
    mainPanel(
      plotOutput("volatilityPlot")
    )
  )
)

# Server
server <- function(input, output, session) {
  observeEvent(input$update, {
    output$volatilityPlot <- renderPlot({
      print("Filtering data...")

      # Filter stock data based on selected firm and date range
      filtered_data <- stock_data_long %>%
        filter(Name == input$firm & Date >= input$date_range[1] & Date <= input$date_range[2])

      # Debug: Print filtered data
      print("Filtered Data:")
      print(filtered_data)

      # Handle missing data gracefully
      if (nrow(filtered_data) == 0) {
        return(
          ggplot() +
            annotate("text", x = 1, y = 1, label = "No data available for the selected firm and date range.", size = 5) +
            theme_void()
        )
      }

      # Calculate rolling volatility
      filtered_data <- filtered_data %>%
        arrange(Date) %>%
        mutate(
          Returns = c(NA, diff(log(Price))),
          RollingVolatility = rollapply(Returns, width = 20, FUN = sd, fill = NA)
        )

      # Debug: Print rolling volatility data
      print("Rolling Volatility Data:")
      print(head(filtered_data))

      # Filter announcements based on the selected date range
      filtered_announcements <- announcements_data %>%
        filter(Date >= input$date_range[1] & Date <= input$date_range[2])

      # Plot the data
      ggplot(filtered_data, aes(x = Date, y = RollingVolatility)) +
        geom_line(color = "blue") +
        geom_vline(
          data = filtered_announcements,
          aes(xintercept = as.Date(Date)),
          color = "red",
          linetype = "dashed",
          alpha = 0.7
        ) +
        labs(
          title = paste("Volatility of", input$firm, "Over Time"),
          x = "Date",
          y = "Rolling Volatility"
        ) +
        theme_minimal()
    })
  })
}

# Launch the app
shinyApp(ui = ui, server = server)