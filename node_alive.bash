#!/bin/bash
set -e

NODE=$1
NETWORK=`curl -s ${NODE}/info | jq -r ".nodeVersion"`

echo "Network: $NETWORK"
TKPL=`mktemp`
YAML=`mktemp`


cat << EOF >> $TKPL
code:  (round (free.util-time.to-timestamp (free.util-time.now)))

publicMeta:
  chainId: "0"
  sender: ""
  gasLimit: 1000
  gasPrice: 0.00000001
  ttl: 86400

networkId: $NETWORK
EOF

kda gen -t $TKPL -o $YAML > /dev/null
NODE_TS=`kda local $YAML --no-verify-sigs |jq ".[][0].body.result.data"`

TS_DIFF=$(($EPOCHSECONDS - NODE_TS))

echo "TS diff: $TS_DIFF"

if [ $TS_DIFF -gt 300 ]
  then echo "Node out of sync"; exit 1
fi

echo "Kadena node OK"

rm $TKPL $YAML