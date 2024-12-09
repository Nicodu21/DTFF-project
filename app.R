library(shiny)
library(ggplot2)
library(plotly)
library(dplyr)
library(readr)
library(tidyr)

# Load and preprocess the data
stock_data <- read_delim("Data/Stock_Prices_csv.csv", delim = ";", col_types = cols(.default = "c")) %>%
  mutate(across(-Name, ~ as.numeric(gsub(",", ".", .)))) %>%
  pivot_longer(-Name, names_to = "Date", values_to = "Close") %>%
  mutate(Date = as.Date(Date, format = "%d/%m/%Y"))

# Load and preprocess announcements data
announcements_data <- read_delim("Data/announcements.csv", delim = ";", col_types = cols(.default = "c")) %>%
  rename_with(trimws) %>%  # Remove any trailing whitespace from column names
  mutate(Date = as.Date(Date, format = "%d/%m/%Y")) %>%
  rename(Name = Company)

# Define UI
ui <- fluidPage(
  titlePanel("Stock prices between (2014-2024)"),
  sidebarLayout(
    sidebarPanel(
      selectInput("company", "Select Company:", choices = unique(stock_data$Name)),
      dateRangeInput("dateRange", "Select Date Range:",
                     start = min(stock_data$Date, na.rm = TRUE),
                     end = max(stock_data$Date, na.rm = TRUE),
                     min = min(stock_data$Date, na.rm = TRUE),
                     max = max(stock_data$Date, na.rm = TRUE),
                     format = "dd/mm/yyyy")
    ),
    mainPanel(
      plotlyOutput("pricePlot")
    )
  )
)

# Define server logic
server <- function(input, output) {
  filtered_data <- reactive({
    stock_data %>%
      filter(Name == input$company & Date >= input$dateRange[1] & Date <= input$dateRange[2])
  })
  
  filtered_announcements <- reactive({
    # Join announcements with stock prices to get the closing price for each announcement
    announcements_data %>%
      filter(Name == input$company & 
             Date >= input$dateRange[1] & 
             Date <= input$dateRange[2]) %>%
      left_join(stock_data %>% select(Name, Date, Close), 
                by = c("Name", "Date"))
  })
  
  output$pricePlot <- renderPlotly({
    p <- ggplot() +
      # Stock price line
      geom_line(data = filtered_data(), aes(x = Date, y = Close), color = "blue") +
      # Announcements as points
      geom_point(data = filtered_announcements(), 
                aes(x = Date, y = Close, text = Announcement),
                color = "red", size = 3) +
      labs(
        title = paste("Stock price", input$company, "(2014-2024)"),
        x = "Date",
        y = "Closing price (USD)"
      ) +
      theme_minimal() +
      scale_y_continuous(labels = scales::dollar) +
      theme(
        plot.title = element_text(hjust = 0.5),
        axis.text.x = element_text(angle = 45, hjust = 1)
      )
    
    # Convert to plotly with custom tooltip for announcements
    ggplotly(p, tooltip = c("text")) %>%
      layout(hovermode = "closest")
  })
}

# Run the application 
shinyApp(ui = ui, server = server)