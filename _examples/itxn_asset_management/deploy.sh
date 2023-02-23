#!/usr/bin/env bash

set -e -u -x

GOAL="goal"

APP_ID=$(${GOAL} app method \
  --create \
  --method "appl_deploy()void" \
  -f ALICE7Y2JOFGG2VGUC64VINB75PI56O6M2XW233KG2I3AIYJFUD4QMYTJM \
  --approval-prog approval.teal \
  --clear-prog clear.teal \
  --global-byteslices 0 --global-ints 0 \
  --local-byteslices 0 --local-ints 0 \
  | grep 'Created app with app index' \
  | awk '{print $6}' \
  | tr -d '\n')

echo -n ${APP_ID} > .APP_ID

