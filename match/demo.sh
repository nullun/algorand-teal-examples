#!/usr/bin/env bash

set -e -u -x -o pipefail

SB=~/sandbox/sandbox
GOAL="${SB} goal"
TDBG="${SB} tealdbg"

ADDR=$(${GOAL} account list \
  | grep '\[online\]' \
  | head -n 1 \
  | awk '{print $3}' \
  | tr -d '\r')

${SB} copyTo approval.teal
${SB} copyTo clear.teal

#${GOAL} app create --creator ${ADDR} \
${GOAL} app method --create --from ${ADDR} \
  --method "deploy()void" \
	--approval-prog approval.teal \
	--clear-prog clear.teal \
	--global-byteslices 0 --global-ints 0 \
	--local-byteslices 0 --local-ints 0 \
	--dryrun-dump \
	-o demo.dr

${TDBG} debug -d demo.dr

