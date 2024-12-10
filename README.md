# Digital Tools for Finance - Final project

This is the final project of
- Lucille Dauer  20-205-670
- Nicolas Profumo   19-419-290
- Pierre Angevin 19-823-921
- Bastien Tognolini 21-409-925

for the course Digital Tools for Finance at UZH.

## What is the project about?

The affect of product annoucments on the stock volatility of tech companies.

## Info about the Project
- stock price is the daily closing stock price adjusted for dividend. 
- the annoncements are important products/new features communicated by the companies either in conferences or official communications
- to calculate volatility we use a rolling average of 10 days 

## Data
- The [announcement data set](https://github.com/Nicodu21/DTFF-project/blob/main/Data/announcements.xlsx) was compiled using Chat GPT which helped us gathering the data from  the 10 biggest Tech companies (by 2024 market cap).  
   Data Frame Structure and technical specificity can be found [here](https://github.com/Nicodu21/DTFF-project/blob/main/Data/announcements.txt)
- The [stock prices data set](https://github.com/Nicodu21/DTFF-project/blob/main/Data/Stock_Prices.xlsx) was compiled with Refinitiv EIKON (Datastream) that gathers daily stock prices in USD (adjusted for dividends) from 31.12.2013-31.12.2023 for the ten biggest tech firms in terms of market capitalization.  
  Data Frame Structure and technical specificity can be found [here](https://github.com/Nicodu21/DTFF-project/blob/main/Data/Stock_Prices.txt)

# Structure of Project



    ├── Data                # Data used for our analysis
    ├── Text                # Documentation files
    │   ├── presentation    # Presentation of project
    │   └── report          # Report of project
    ├── code
    │   ├── notebook        # Python notebook that performs analysis
    │   └── output          # Charts outputted from code
    ├── .gitignore          # Git configuration to ignore specific files or directories
    ├── Dockerfile          # Instructions to build a Docker image for the project
    ├── app.R               # Interactive R Shiny app
    ├── README.md           # Project overview and instructions
    └── requirements.txt    # Python dependencies for the project


## Download and Usage

To download our project from GitHub use the bash command: `git clone https://github.com/Nicodu21/DTFF-project`

To run the code ensure that your environment has the needed libraries by using pip:

`pip install -r requirements.txt`

you can find requirements.txt [here](https://github.com/Nicodu21/DTFF-project/blob/main/requirements.txt)

using the shiny app

To modify the presentation or report you require a tex editor, we used [Overleaf](https://nl.overleaf.com/)

## Dependencies

See [requirements](https://github.com/Nicodu21/DTFF-project/blob/main/requirements.txt)

## Bugs

Find a bug in the project? [Open a new issue on GitHub](https://github.com/Nicodu21/DTFF-project/issues)
