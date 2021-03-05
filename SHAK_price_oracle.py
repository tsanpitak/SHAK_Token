##############################################################
# Oracle API to provide current SHAK price in wei
#
##############################################################

import os
from dotenv import load_dotenv
from requests import Request, Session
from requests.exceptions import ConnectionError, Timeout, TooManyRedirects
import json
from web3 import Web3

from flask import Flask
from flask import request
from flask import jsonify

# TODO HENRY
#from basket_price_setter script import *

# Grab the CoinMarketData api key and Infura project id
# stored in .env and verify they're are valid strings
load_dotenv()
cmc_api_key = os.getenv("CMC_PRO_API_KEY")
if (type(cmc_api_key) != str):
    print(f"Invalid key found for CMC_PRO_API_KEY")

project_id = os.getenv("WEB3_INFURA_PROJECT_ID")
if (type(project_id) != str):
    print(f"Invalid key found for WEB3_INFURA_PROJECT_ID")

# Setup urls used within price functions
cmc_url = 'https://pro-api.coinmarketcap.com/v1/cryptocurrency/quotes/latest'
infura_project_url = f"https://mainnet.infura.io/v3/{project_id}"

# define the Flask app name
SHAK_price_oracle = Flask(__name__)

@SHAK_price_oracle.route('/isAlive')
def index():
    return "true"

@SHAK_price_oracle.route('/SHAK_wei_price', methods=['GET'])
# TODO HENRY
# add a before function that will retrieve latest token stats from
# solidity contract, potentially also run basket price scripts?
def get_wei_price():
    # unit price for asset basket arbitarily set 10K USD for debug
    # to fetch from another script later on
    basket_USD_price = 10_000
    # Fetch latest ETH price from aggregate exchange average
    # calculated by CoinMarketCap API.
    parameters = {'symbol':'ETH'}
    headers = {
        'Accepts': 'application/json',
        'Accept-Encoding': 'deflate, gzip',
        'X-CMC_PRO_API_KEY': cmc_api_key
        }
    session = Session()
    session.headers.update(headers)
    try:
        response = session.get(cmc_url, params=parameters)
        data = json.loads(response.text)
    except (ConnectionError, Timeout, TooManyRedirects) as e:
        print(e)
    eth_price = data["data"]["ETH"]["quote"]["USD"]["price"]

    # Use Web3 Infura price to convert eth to wei. Not using
    # hard-coded value here to allow for future crypto exchanges
    w3 = Web3(Web3.HTTPProvider(infura_project_url))
    return jsonify({"wei" : w3.toWei((basket_USD_price/eth_price),'ether')})

if __name__ == '__main__':
    SHAK_price_oracle.run(host='0.0.0.0', port=5001)
    #SHAK_price_oracle.run(debug=True)
    #
