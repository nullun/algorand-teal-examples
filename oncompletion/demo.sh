#!/usr/bin/env bash

set -e -u -x -o pipefail

SB=~/sandbox/sandbox
GOAL="${SB} goal"
TDBG="${SB} tealdbg"

ACCT1=$(${GOAL} account list | grep '[online]' | head -n 1 | tail -n 1 | awk '{print $3}' | tr -d '\r')

${SB} copyTo approval.teal
${SB} copyTo clear.teal

APP_ID=$(${GOAL} app create \
  --creator ${ACCT1} \
  --approval-prog approval.teal \
  --clear-prog clear.teal \
  --global-byteslices 0 --global-ints 0 \
  --local-byteslices 0 --local-ints 0 \
  | grep 'Created app with app index' \
  | awk '{print $6}' \
  | tr -d '\r')

${GOAL} app update \
  --from ${ACCT1} \
  --app-id ${APP_ID} \
  --approval-prog approval.teal \
  --clear-prog clear.teal \
  --dryrun-dump \
  -o demo.dr

${TDBG} debug -d demo.dr
rm demo.dr

