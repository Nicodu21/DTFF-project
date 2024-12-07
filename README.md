# Digital Tools for Finance - Final project

This is the final project of
- Lucille Dauer  xx-xxx-xxx
- Nicolas Profumo   19-419-290
- Pierre Angevin xx-xxx-xxx
- Bastien Tognolini 21-409-925

for the course Digital Tools for Finance at UZH.

## What is the project about?

The affect of product annoucments on the stock price volatility of tech companies.

## Info about the Project (Vol/annoucments etc) 
- We use a 10 day rolling average vol
- the annoncements are new products/new features presented by the companies themeselves either in conferences or official communication

## Data
- The [announcement data set](https://github.com/Nicodu21/DTFF-project/blob/main/Data/Stock_Prices.xlsx) was compiled using Chat GPT which helped us gathering the data from  the 10 biggest Tech companies (by 2024 market cap).
- The [stock prices data set](https://github.com/Nicodu21/DTFF-project/blob/main/Data/Stock_Prices.xlsx) was compiled with Refinitiv EIKON (Datastream) that gathers daily stock prices in USD (adjusted for dividends) from 31.12.2013-31.12.2023 for the ten biggest tech firms in terms of market capitalization.

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
    ├── README.md           # Project overview and instructions
    └── requirements.txt    # Python dependencies for the project


## Download and Usage

Simply Fork, Clone, or Download on GitHub (maybe modify this)

To run the code ensure that your environment has the needed libraries by using pip:

`pip install -r requirements.txt`

you can find requirements.txt [here](https://github.com/Nicodu21/DTFF-project/blob/main/code/requirements.txt)

To modify the presentation or report you require a tex editor, we used [MikTex](https://miktex.org/)

## Dependencies

See [requirements](https://github.com/Nicodu21/DTFF-project/blob/main/code/requirements.txt)

## Bugs

Find a bug in the project? [Open a new issue on GitHub](https://github.com/Nicodu21/DTFF-project/issues)
