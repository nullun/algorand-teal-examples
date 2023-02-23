#!/usr/bin/env bash

set -e -u -x

GOAL="goal"

APP_ID=$(cat .APP_ID)
ASSET_ID=$(cat .ASSET_ID)

${GOAL} app method \
  --app-id ${APP_ID} \
  --method "itxn_config(asset)void" \
  -f ALICE7Y2JOFGG2VGUC64VINB75PI56O6M2XW233KG2I3AIYJFUD4QMYTJM \
  --arg ${ASSET_ID} \
  | grep 'succeeded with output' \
  | awk '{print $6}' \
  | tr -d '\n'

