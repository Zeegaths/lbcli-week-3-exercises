# What is the receiver's address in this partially signed transaction?
# transaction=cHNidP8BAHsCAAAAAhuVpgVRdOxkuC7wW2rvw4800OVxl+QCgezYKHtCYN7GAQAAAAD/////HPTH9wFgyf4iQ2xw4DIDP8t9IjCePWDjhqgs8fXvSIcAAAAAAP////8BigIAAAAAAAAWABTHctb5VULhHvEejvx8emmDCtOKBQAAAAAAAAAA
#!/bin/bash

# Input transaction has two inputs from same txid but different vouts
TXID="23c19f37d4e92e9a115aab86e4edc1b92a51add4e0ed0034bb166314dde50e16"
VOUT1=0
VOUT2=1
SEQUENCE=4294967293  # from the example in docs: "fdffffff" for RBF
RECIPIENT="2MvLcssW49n9atmksjwg2ZCMsEMsoj3pzUP"
AMOUNT=0.20000000

# Create raw transaction following docs example exactly
rawtx=$(bitcoin-cli -regtest -named createrawtransaction \
  inputs='''[ 
    { "txid": "'$TXID'", "vout": '$VOUT1', "sequence": '$SEQUENCE' },
    { "txid": "'$TXID'", "vout": '$VOUT2', "sequence": '$SEQUENCE' }
  ]''' \
  outputs='''{ "'$RECIPIENT'": '$AMOUNT' }''')

# Convert to PSBT exactly as shown in docs
psbt=$(bitcoin-cli -regtest -named converttopsbt hexstring=$rawtx)

# Output only the PSBT
echo $psbt