# SHAK Token

[![License](https://img.shields.io/badge/license-MIT-blue.svg)](https://opensource.org/licenses/MIT)

The SHAK Token is the Stable Hyper Algorithmic Kryptocurrency. It is intended to be used as a stable alternative to store value as compared to fiat currencies, commodities, or even other stablecoins. Our cryptocurrency is backed by a basket of different currencies and other assets. With our algorithms continuously balancing the basket, we aim to provide a store of value that stays above the volatile fluctuations that impact commonly held assets.

## Table of Contents
---
- [Installation](#installation)
    - [Balancing Algorithm](#balancing-algorithm)
    - [Placeholder](#placeholder)
- [Balancing Methodology](#balancing-methodology)
    - [Country Indicator Balancing](#country-indicator-balancing)
    - [Continuous FX Balancing](#continuous-fx-balancing)
- [Smart Contracts](#smart-contracts)
- [Oracle](#oracle)
- [User Guide](#user-guide)
- [Contributors](#contributors)

## Installation
---

Beyond cloning the repository, in order to run the included scripts, some installation steps are required. They are listed below by section, with the specific scripts specified as well. Most of these can be installed with the [Anaconda](https://www.anaconda.com) package (as indicated with an asterisk).

## Balancing Algorithm

Scripts covered: [countryweight.py](countryweight.py), placeholder

### Key Python Libraries Required:
|Library|Command Line Install|
|-------|-----------------------------|
|[Pandas*](https://pandas.pydata.org/getting_started.html) | ```conda install pandas``` |
|[Numpy*](https://numpy.org/install/)  | ```conda install numpy```  |
|[ScikitLearn*](https://scikit-learn.org/stable/install.html#)|```pip install -U scikit-learn```|


## Smart Contract Deployment

### Installation Required:


## Balancing Methodology
---

Stability is the cornerstone of our cryptocurrency. As such, we are evaluating the currency basket we hold daily. In addition to monitoring the interday fluctuations in exchange rates, we also take a long-term approach by looking at key indicators for the countries of our currencies to anticipate future currency movements. This country indicator balancing is done at a lesser frequency as these indicators are only released annually.

### Country Indicator Balancing

All country indicator information is pulled via the [World Bank API](https://datahelpdesk.worldbank.org/knowledgebase/topics/125589-developer-information). The indicators currently used are [Gross Domestic Product](https://en.wikipedia.org/wiki/Gross_domestic_product) (GDP), GDP Growth (Year over Year), GDP per capita, Inflation based on [Consumer Price Index](https://en.wikipedia.org/wiki/Consumer_price_index) (CPI), and Unemployment rate. These indicators going back 20 years are pulled for all countries that are represented in the currency basket. 

Matched against this set of historical indicators are the annualized volatility of each currency against the USD (as provided by [Federal Reserve Economic Data](https://fred.stlouisfed.org) (FRED)). These indicators and annualized volatility numbers then go to train a linear regression machine learning algorithm (a deep learning model and other forms of linear regression were also evaluated in the process). This trained model is used on the most recent set of indicators for the countries represented in the currency basket to provide projected annualized volatility for the next year. These projections are fed into the weighting recommendation model. 

This model takes in the annualized volatility and removes the most volatile 25% of projections and sets the weighting to 0. Then based on the remaining volatility associated with each country/currency pair, it assigns weights for the portfolio (with higher weight assigned to lower projected volatility). These weighting recommendations then form the baseline for the continuous FX balancing algorithm that will be explained in the next section.

### Continuous FX Balancing

Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.

## Smart Contracts
---
Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.

## Oracle
---
Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.

## User Guide
---
Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.


## Contributors
---
|Doc Fern|Albert Kong|Thee Sanpitakseree|Henry Schrader|Kiel Wheat|
|:------:|:---------:|:----------------:|:------------:|:--------:|
|![Doc](images/propic.png)| ![Albert](images/propic.png)| ![Thee](images/propic.png)| ![Henry](images/propic.png)| ![Kiel](images/propic.png)|
