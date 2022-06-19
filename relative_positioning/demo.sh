#!/usr/bin/env bash

set -e -u -x -o pipefail

GOAL="goal"
TDBG="tealdbg"
ADDR="JAQA7FTVZP2ZK32Z7HEVIL5XJZEMTEFV7FRI6BJAT7VUQB6GA7NEBN4KS4"

${GOAL} clerk send -f ${ADDR} \
	-t ${ADDR} \
	-a 1000000 \
	-o pay.txn

${GOAL} app create --creator ${ADDR} \
	--approval-prog approval.teal \
	--clear-prog clear.teal \
	--global-byteslices 0 --global-ints 0 \
	--local-byteslices 0 --local-ints 0 \
	-o appl.txn

cat pay.txn appl.txn > group.ctxn
rm pay.txn appl.txn

${GOAL} clerk group -i group.ctxn -o group.gtxn
rm group.ctxn

${GOAL} clerk dryrun --dryrun-dump -t group.gtxn -o demo.dr
rm group.gtxn

${TDBG} debug -d demo.dr --remote-debugging-port 9393
rm demo.dr

