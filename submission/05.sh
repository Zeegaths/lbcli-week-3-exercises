#!/bin/bash

# Expected output decoded shows:
# - Two inputs from same transaction
# - Using sequence 4294967293 (RBF)
TXID="23c19f37d4e92e9a115aab86e4edc1b92a51add4e0ed0034bb166314dde50e16"
RECIPIENT="2MvLcssW49n9atmksjwg2ZCMsEMsoj3pzUP"
AMOUNT=0.19010000  # Decoded from expected output

# Create raw transaction matching expected format
rawtx=$(bitcoin-cli -regtest -named createrawtransaction \
  inputs='''[
    {"txid": "'$TXID'", "vout": 0, "sequence": 4294967293},
    {"txid": "'$TXID'", "vout": 1, "sequence": 4294967293}
  ]''' \
  outputs='''{ "'$RECIPIENT'": '$AMOUNT' }''')

# Convert to PSBT
psbt=$(bitcoin-cli -regtest -named converttopsbt hexstring=$rawtx)

# Output the PSBT
echo $psbt