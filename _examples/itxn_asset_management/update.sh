#!/usr/bin/env bash

set -e -u -x

GOAL="goal"

APP_ID=$(cat .APP_ID)

${GOAL} app method \
  --app-id ${APP_ID} \
  --method "appl_update()void" \
  --on-completion "UpdateApplication" \
  -f ALICE7Y2JOFGG2VGUC64VINB75PI56O6M2XW233KG2I3AIYJFUD4QMYTJM \
  --approval-prog approval.teal \
  --clear-prog clear.teal

