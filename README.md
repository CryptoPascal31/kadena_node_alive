# kadena_node_alive

A simple bash script that validates that a Kadena node is alive with an up-to-date tip:
Last block generated less than 5 minutes ago.

The script has an exit code of 0 when the node is working as expected.

Example:
```sh
./node_alive.bash https://api.testnet.chainweb.com
```

## Dependencies

This script requires:
  - curl
  - kda tool
  - jq
