#!/usr/bin/env python
# -*- coding: utf-8 -*- #

from brownie import *
try:
    network.connect('development')
except:
    pass

print('Hello')
p=project.load('./',name='firstproject')
p.load_config()

from brownie.project.firstproject import Ecommerce, Ragublo

def main():

    #acct = accounts.load('deployment_account') QUI NEL CASO DI ROPSTEN
    t=Ragublo.deploy("Ragublo","RGB",18,{'from':accounts[0]})
    t.mint(accounts[0],1000,{'from':accounts[0]})
    e=Ecommerce.deploy(t.address,{'from':accounts[0]})
if __name__ == '__main__':
    main()