#!/usr/bin/env bash

set -e -u -x -o pipefail

SB=~/sandbox/sandbox
GOAL="${SB} goal"
TDBG="${SB} tealdbg"

ACCT1=$(${GOAL} account list | grep '[online]' | head -n 1 | tail -n 1 | awk '{print $3}' | tr -d '\r')

APP_ID=$(cat .APP_ID)

# Byte Demo
${GOAL} app method \
  --app-id ${APP_ID} \
  --from ${ACCT1} \
  --method "byte_array_demo(byte[])byte[]" \
  --arg '[84,69,83,84]'

