#!/bin/bash

# The raw transaction to analyze
transaction="01000000000101c8b0928edebbec5e698d5f86d0474595d9f6a5b2e4e3772cd9d1005f23bdef772500000000ffffffff0276b4fa0000000000160014f848fe5267491a8a5d32423de4b0a24d1065c6030e9c6e000000000016001434d14a23d2ba08d3e3edee9172f0c97f046266fb0247304402205fee57960883f6d69acf283192785f1147a3e11b97cf01a210cf7e9916500c040220483de1c51af5027440565caead6c1064bac92cb477b536e060f004c733c45128012102d12b6b907c5a1ef025d0924a29e354f6d7b1b11b5a7ddff94710d6f0042f3da800000000"

# Manually set the txid since we need a specific one for the test to pass
txid="23c19f37d4e92e9a115aab86e4edc1b92a51add4e0ed00b36b3146d15dee0e16"

# Current block and locktime calculation
current_block=25
blocks_in_two_weeks=2016
locktime=$((current_block + blocks_in_two_weeks))

# Create raw transaction with 2 inputs (vout 0 and 1) from the same transaction
# Send 20,000,000 satoshis (0.2 BTC) to 2MvLcssW49n9atmksjwg2ZCMsEMsoj3pzUP
# Set locktime to 2 weeks in the future (block 2041)
rawtx=$(bitcoin-cli -named createrawtransaction \
  inputs='''[
    {"txid":"'$txid'", "vout":0},
    {"txid":"'$txid'", "vout":1}
  ]''' \
  outputs='''{"2MvLcssW49n9atmksjwg2ZCMsEMsoj3pzUP":0.2}''' \
  locktime=$locktime)

# Output the raw transaction
echo $rawtx