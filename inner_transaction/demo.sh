#!/usr/bin/env bash

set -e -u -x -o pipefail

GOAL="goal"
ADDR="JAQA7FTVZP2ZK32Z7HEVIL5XJZEMTEFV7FRI6BJAT7VUQB6GA7NEBN4KS4"

# Deploy
APP_ID=$(${GOAL} app create --creator ${ADDR} \
	--approval-prog approval.teal \
	--clear-prog clear.teal \
	--global-byteslices 0 --global-ints 0 \
	--local-byteslices 0 --local-ints 0 \
	| grep 'Created app with app index' \
	| awk '{print $6}' \
	| tr -d '\r')

# Find Smart Contract Address
APP_ADDR=$(${GOAL} app info --app-id ${APP_ID} \
	| grep 'Application account' \
	| awk '{print $3}' \
	| tr -d '\r')

# Fund Minimum Balance Requirement
${GOAL} clerk send -a 1000000 -f ${ADDR} -t ${APP_ADDR}

# Call Smart Contract
${GOAL} app call --app-id ${APP_ID} -f ${ADDR} --fee 2000

