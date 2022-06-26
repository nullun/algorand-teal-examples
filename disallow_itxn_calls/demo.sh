#!/usr/bin/env bash

set -e -u -x -o pipefail

GOAL="goal"
TDBG="tealdbg"
ADDR="JAQA7FTVZP2ZK32Z7HEVIL5XJZEMTEFV7FRI6BJAT7VUQB6GA7NEBN4KS4"

# Deploy Application 1 - The example
APP1_ID=$(${GOAL} app create --creator ${ADDR} \
	--approval-prog approval_1.teal \
	--clear-prog clear.teal \
	--global-byteslices 0 --global-ints 0 \
	--local-byteslices 0 --local-ints 0 \
	| grep 'Created app with app index ' \
	| awk '{print $6}' \
	| tr -d '\r')

# Deploy Application 2 - The caller
APP2_ID=$(${GOAL} app create --creator ${ADDR} \
	--approval-prog approval_2.teal \
	--clear-prog clear.teal \
	--global-byteslices 0 --global-ints 0 \
	--local-byteslices 0 --local-ints 0 \
	| grep 'Created app with app index ' \
	| awk '{print $6}' \
	| tr -d '\r')

# Demonstrate the application call works when invoked directly.
${GOAL} app call --app-id ${APP1_ID} -f ${ADDR}

# This call WILL fail, because our example doesn't allow being called via an
# inner transaction. You can modify approval_1.teal, remove the "not" (!), and
# try again to see that it will succeed when requiring it MUST be called from
# an inner transaction.
${GOAL} app call --app-id ${APP2_ID} -f ${ADDR} \
	--foreign-app ${APP1_ID} \
	--app-arg "int:1" \
	--fee 2000

