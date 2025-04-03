#!/bin/bash

# The public keys from the transaction inputs (directly extracted)
PUBKEY1="02bbb4ba3f39b5f3258f0014d5e4eab5a6990009e3e1dba6e8eaff10b3832394f7"
PUBKEY2="03aaf17b1a7b4108f7e5bc4f7d59c20f7fb1a72dbc74a9a3d6d1f8488df159c760"
PUBKEY3="03a6d919c76d9117c23570a767450013edf31cf6be7d3b5a881c06a9aa1f2c24ce"
PUBKEY4="0383d12258e3e294a6d7754336f6b4baef992ec4b91694d3460bcb022b11da8cd2"

# Create multisig address using proper JSON formatting
P2SH_INFO=$(bitcoin-cli -regtest createmultisig 1 \
  '[
    "'$PUBKEY1'",
    "'$PUBKEY2'",
    "'$PUBKEY3'",
    "'$PUBKEY4'"
  ]')

# Output only the address
echo "$P2SH_INFO" | jq -r '.address'