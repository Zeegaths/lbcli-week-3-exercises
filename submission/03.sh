#!/bin/bash

# The raw transaction
TX="02000000000104b5f641e80e9065f09b12f3e373072518885d1bd1ddd9298e5b9840de515edac90000000000feffffffd54f8986afbb6ff18572acaee58fa3ad64446dd770ffe9b6a04f798becdafb440000000000feffffff475e3062b1c3ee87544c29d723866da2b65a1b1a42e6ea4a4fd48d79f83c26c50000000000feffffffa56387352ecc93dfd37648e6ebd4d9effb37ffefcad02eb7b85860c9097cf8090000000000feffffff02fa440f00000000001600148070ec3954ecdcbfc210d0117e8d28a19eb8467270947d0000000000160014b5fe46c647353ec9c06374655502094095f0289c0247304402200dd758801b40393f68dad8ab57558803efcd2b681ee31eb44fb3cfa9666d2bf90220254d34fa4990e23652bf669053c5e16fd2fbb816bed2eeb44c1f1e6e54143e3e012102bbb4ba3f39b5f3258f0014d5e4eab5a6990009e3e1dba6e8eaff10b3832394f70247304402201694761a5749b6a84f71459c04a44cf9d34a36ae8c9044c3af7a3a5514ef2e64022058f61feb92d6d54b71fdea47e7dfcd20f6a5c12e2fbcb15bc44fe95c73f2e808012103aaf17b1a7b4108f7e5bc4f7d59c20f7fb1a72dbc74a9a3d6d1f8488df159c76002473044022014b65c60f65e62d9dac893e404c8de2a007c7c6b74dbac18e454d8374e159759022012453f69112adadf9495fd3fe288aa5ed9e3d836340da06fa1e82c8e09adef57012103a6d919c76d9117c23570a767450013edf31cf6be7d3b5a881c06a9aa1f2c24ce0247304402203d3b02390803c1d673fa49bd64d4a26fbeb29e3fc152af8f844d776c9409e41302206903a011a04e00a7f4ec606da4320226d2d393f565702cc58cfcef6dca67f84c01210383d12258e3e294a6d7754336f6b4baef992ec4b91694d3460bcb022b11da8cd2817e0c00"

# Decode transaction and extract public keys
DECODED=$(bitcoin-cli -regtest decoderawtransaction $TX true)

# Extract public keys from witness data (keeping the 02/03 prefix)
PUBKEY1=$(echo $DECODED | jq -r '.vin[0].txinwitness[-1]' | cut -c 3-68)
PUBKEY2=$(echo $DECODED | jq -r '.vin[1].txinwitness[-1]' | cut -c 3-68)
PUBKEY3=$(echo $DECODED | jq -r '.vin[2].txinwitness[-1]' | cut -c 3-68)
PUBKEY4=$(echo $DECODED | jq -r '.vin[3].txinwitness[-1]' | cut -c 3-68)

# Create 1-of-4 multisig address and extract just the address
MULTISIG_INFO=$(bitcoin-cli -regtest createmultisig 1 "[\"$PUBKEY1\",\"$PUBKEY2\",\"$PUBKEY3\",\"$PUBKEY4\"]")
echo "$MULTISIG_INFO" | jq -r '.address'