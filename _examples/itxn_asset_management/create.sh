#!/usr/bin/env bash

set -e -u -x

GOAL="goal"

APP_ID=$(cat .APP_ID)

ASSET_ID=$(${GOAL} app method \
  --app-id ${APP_ID} \
  --method "itxn_create(byte[32],byte[8],uint64,uint64)uint64" \
  -f ALICE7Y2JOFGG2VGUC64VINB75PI56O6M2XW233KG2I3AIYJFUD4QMYTJM \
  --arg '"AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABPTkU="' \
  --arg '"AAAAAAAAADE="' \
  --arg 100 \
  --arg 2 \
  | grep 'succeeded with output' \
  | awk '{print $6}' \
  | tr -d '\n')

echo -n ${ASSET_ID} > .ASSET_ID

