# Use the official Shiny image as the base
FROM rocker/shiny:latest

# Install required R packages
RUN R -e "install.packages(c('shiny', 'ggplot2', 'readxl', 'dplyr', 'zoo', 'tidyr', 'readr'))"

# Set the working directory
WORKDIR /srv/shiny-server/

# Copy the app and data files into the container
COPY app.R /srv/shiny-server/
COPY Stock_Prices_csv.csv /srv/shiny-server/
COPY announcements.xlsx /srv/shiny-server/

# Expose the default Shiny server port
EXPOSE 3838

# Start the Shiny server
CMD ["/usr/bin/shiny-server"]
