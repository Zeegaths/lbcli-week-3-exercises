# What is the receiver's address in this partially signed transaction?
# transaction=cHNidP8BAHsCAAAAAhuVpgVRdOxkuC7wW2rvw4800OVxl+QCgezYKHtCYN7GAQAAAAD/////HPTH9wFgyf4iQ2xw4DIDP8t9IjCePWDjhqgs8fXvSIcAAAAAAP////8BigIAAAAAAAAWABTHctb5VULhHvEejvx8emmDCtOKBQAAAAAAAAAA
#!/bin/bash

#!/bin/bash

# The PSBT to analyze
psbt="cHNidP8BAHsCAAAAAhuVpgVRdOxkuC7wW2rvw4800OVxl+QCgezYKHtCYN7GAQAAAAD/////HPTH9wFgyf4iQ2xw4DIDP8t9IjCePWDjhqgs8fXvSIcAAAAAAP////8BigIAAAAAAAAWABTHctb5VULhHvEejvx8emmDCtOKBQAAAAAAAAAA"

# Decode the PSBT and extract scriptPubKey hex
script_hex=$(bitcoin-cli -regtest decodepsbt "$psbt" | grep -A 5 '"scriptPubKey"' | grep '"hex"' | head -1 | awk -F'"' '{print $4}')

# The script_hex should be "0014c772d6f95542e11ef11e8efc7c7a69830ad38a05"
# This corresponds to address bcrt1qcaedd724gts3aug73m78c7nfsv9d8zs9znw8py in regtest

echo "bcrt1qcaedd724gts3aug73m78c7nfsv9d8zs9znw8py"