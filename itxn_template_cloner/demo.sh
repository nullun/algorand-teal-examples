#!/usr/bin/env bash

set -e -u -x -o pipefail

GOAL="goal"
ADDR="JAQA7FTVZP2ZK32Z7HEVIL5XJZEMTEFV7FRI6BJAT7VUQB6GA7NEBN4KS4"

# Deploy original reference application
REF_APP=$(${GOAL} app create --creator ${ADDR} \
	--approval-prog reference.teal \
	--clear-prog clear.teal \
	--global-byteslices 1 --global-ints 0 \
	--local-byteslices 0 --local-ints 0 \
	--app-arg "addr:${ADDR}" \
	| grep 'Created app' \
	| awk '{print $6}' \
	| tr -d '\r')

# Deploy the cloner
CLONER_APP=$(${GOAL} app create --creator ${ADDR} \
	--approval-prog cloner.teal \
	--clear-prog clear.teal \
	--global-byteslices 0 --global-ints 0 \
	--local-byteslices 0 --local-ints 0 \
	| grep 'Created app' \
	| awk '{print $6}' \
	| tr -d '\r')

# Get cloner address
CLONER_ADDR=$(${GOAL} app info --app-id ${CLONER_APP} \
	| grep 'Application account' \
	| awk '{print $3}' \
	| tr -d '\r')

# Fund the cloner before cloning, since the minimum balance requirement will be raised
${GOAL} clerk send -a 1000000 -f ${ADDR} -t ${CLONER_ADDR}

# Call the cloner with our reference app as reference
${GOAL} app call -f ${ADDR} --app-id ${CLONER_APP} \
	--foreign-app ${REF_APP} \
	--app-arg "str:clone" \
	--app-arg "addr:${ADDR}" \
	--fee 2000

# Get newly cloned app ID from cloner account details
CLONED_APP=$(${GOAL} account info -a ${CLONER_ADDR} \
	| grep 'global state used' \
	| awk '{print $2}' \
	| tr -d ',' \
	| tr -d '\r')

# Call new cloned app as user who is the only person who can call it
${GOAL} app call -f ${ADDR} --app-id ${CLONED_APP}

