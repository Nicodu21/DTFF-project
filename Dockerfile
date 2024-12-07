# Utiliser une image de base avec R et Shiny
FROM rocker/shiny:latest

# Installer les bibliothèques nécessaires
RUN apt-get update && apt-get install -y \
    libcurl4-openssl-dev \
    libssl-dev \
    libxml2-dev

RUN R -e "install.packages('shiny')"
RUN R -e "install.packages('ggplot2')"
RUN R -e "install.packages('plotly')"
RUN R -e "install.packages('tidyverse')"
RUN R -e "install.packages('readr')"
RUN R -e "install.packages('dplyr')"
RUN R -e "install.packages('tidyr')"
RUN R -e "install.packages('scales')"

# Créer le répertoire Data dans le conteneur
RUN mkdir -p /srv/shiny-server/Data

# Copier les fichiers de l'application Shiny
COPY app.R /srv/shiny-server/
COPY Data/Stock_Prices_csv.csv /srv/shiny-server/Data/
COPY Data/announcements.csv /srv/shiny-server/Data/

# Définir les permissions
RUN chown -R shiny:shiny /srv/shiny-server

# Exposer le port utilisé par Shiny
EXPOSE 3838

# Lancer le serveur Shiny
CMD ["/usr/bin/shiny-server"]

#command to launch the R app
# docker build -t shiny-volatility-app . 
# docker run -p 3838:3838 shiny-volatility-app
