#!/usr/bin/env bash

set -e -u -x -o pipefail

SB=~/sandbox/sandbox
GOAL="${SB} goal"
TDBG="${SB} tealdbg"

ACCT1=$(${GOAL} account list | grep '[online]' | head -n 1 | tail -n 1 | awk '{print $3}' | tr -d '\r')

APP_ID=$(cat .APP_ID)

# Uint8 Demo
${GOAL} app method \
  --app-id ${APP_ID} \
  --from ${ACCT1} \
  --method "uint8_demo(uint8)uint8" \
  --arg 255

# Uint16 Demo
${GOAL} app method \
  --app-id ${APP_ID} \
  --from ${ACCT1} \
  --method "uint16_demo(uint16)uint16" \
  --arg 65535

# Uint32 Demo
${GOAL} app method \
  --app-id ${APP_ID} \
  --from ${ACCT1} \
  --method "uint32_demo(uint32)uint32" \
  --arg 4294967295

# Uint64 Demo
${GOAL} app method \
  --app-id ${APP_ID} \
  --from ${ACCT1} \
  --method "uint64_demo(uint64)uint64" \
  --arg 18446744073709551615

