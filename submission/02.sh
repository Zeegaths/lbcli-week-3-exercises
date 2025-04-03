# Create a native segwit address and get the public key from the address.
#!/bin/bash

# Create a SegWit address
SEGWIT_ADDRESS=$(bitcoin-cli -regtest getnewaddress "segwit_address" "bech32")

# Get only the public key from the address using getaddressinfo
# Using grep and cut to extract just the pubkey value
PUBKEY=$(bitcoin-cli -regtest getaddressinfo "$SEGWIT_ADDRESS" | grep -o '"pubkey": "[^"]*' | cut -d'"' -f4)

# First generate some blocks to get coins
FUNDING_ADDRESS=$(bitcoin-cli -regtest getnewaddress)
bitcoin-cli -regtest generatetoaddress 101 "$FUNDING_ADDRESS" >/dev/null 2>&1

# Now send with explicit fee rate to avoid fee estimation
bitcoin-cli -regtest -named sendtoaddress address="$SEGWIT_ADDRESS" amount=1.0 fee_rate=10 >/dev/null 2>&1

# Return only the public key (should be in format: 02/03 + 64 hex characters)
echo "$PUBKEY"