#!/usr/bin/env bash

set -e -u -x

GOAL="goal"

APP_ID=$(cat .APP_ID)

${GOAL} app method \
  --app-id ${APP_ID} \
  --method "appl_delete()void" \
  --on-completion "DeleteApplication" \
  -f ALICE7Y2JOFGG2VGUC64VINB75PI56O6M2XW233KG2I3AIYJFUD4QMYTJM

