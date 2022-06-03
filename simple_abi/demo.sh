#!/usr/bin/env bash

set -e -u -x -o pipefail

GOAL="goal"
ADDR="JAQA7FTVZP2ZK32Z7HEVIL5XJZEMTEFV7FRI6BJAT7VUQB6GA7NEBN4KS4"

# Deploy
APP_ID=$(${GOAL} app method -f ${ADDR} --create \
	--method "deploy()void" \
	--approval-prog approval.teal \
	--clear-prog clear.teal \
	--global-byteslices 0 --global-ints 0 \
	--local-byteslices 0 --local-ints 0 \
	| grep 'Created app with app index' \
	| awk '{print $6}' \
	| tr -d '\r')

# Call Add
${GOAL} app method -f ${ADDR} --app-id ${APP_ID} \
	--method "add(uint64,uint64)uint64" \
	--arg 6 --arg 4

# Call Subtract
${GOAL} app method -f ${ADDR} --app-id ${APP_ID} \
	--method "subtract(uint64,uint64)uint64" \
	--arg 50 --arg 8

