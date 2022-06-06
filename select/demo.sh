#!/usr/bin/env bash

set -e -u -x -o pipefail

GOAL="goal"
ADDR="JAQA7FTVZP2ZK32Z7HEVIL5XJZEMTEFV7FRI6BJAT7VUQB6GA7NEBN4KS4"

${GOAL} app create --creator ${ADDR} \
	--approval-prog approval.teal \
	--clear-prog clear.teal \
	--global-byteslices 0 --global-ints 0 \
	--local-byteslices 0 --local-ints 0 \
	--dryrun-dump \
	-o demo.dr

tealdbg debug -d demo.dr --remote-debugging-port 9393

