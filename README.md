# algorand-teal-examples

## Running an example

Most of the folders will have a `demo.sh` script to run through the contract example. It's assumed you have `goal` installed natively.

## Using tealdbg

Stepping through TEAL opcode-by-opcode is one of the best ways to understand how it works. To do this we use the `tealdbg` tool which comes with [go-algorand](https://github.com/algorand/go-algorand). Use the following instructions as a quick guide on how to use it.

```shell
goal app create --creator $ADDR \
	--approval-prog v4_loop/approval.teal \
	--clear-prog v4_loop/clearstate.teal \
	--global-byteslices 0 --global-ints 0 \
	--local-byteslices 0 --local-ints 0 \
	--dryrun-dump -o debug.dr

tealdbg debug v4_loop/approval.teal -d debug.dr --remote-debugging-port 9393
```

