# algorand-teal-examples

## Using tealdbg

Stepping through TEAL opcode-by-opcode is one of the best way to understand how it works. To do this we use the `tealdbg` tool which comes with [go-algorand](https://github.com/algorand/go-algorand). Use the following instructions as a quick guide on how to use it.

```shell
goal app create --creator $ADDR \
	--approval-prog TEALv4/loop/approval.teal \
	--clear-prog TEALv4/loop/clearstate.teal \
	--global-byteslices 0 --global-ints 0 \
	--local-byteslices 0 --local-ints 0 \
	--dryrun-dump -o debug.dr

tealdbg debug TEALv4/loop/approval.teal -d debug.dr --remote-debugging-port 9393
```

