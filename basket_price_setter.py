##############################################################
# Wrapper for basket balancer and price modelling scripts
#
##############################################################

from Stable_coin import *

def get_basket_USD_price():
    # call Stable_coin.py function to get modelled and calculated
    # price per stable coin in USD.
    return_close_price = 1.0001045433083318
    basket_scalar = 1000
    return(int(return_close_price*basket_scalar))
#    return(int(return_close_price()*basket_scalar))
