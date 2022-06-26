#!/usr/bin/env bash

set -e -u -x -o pipefail

GOAL="goal"
TDBG="tealdbg"
ADDR="JAQA7FTVZP2ZK32Z7HEVIL5XJZEMTEFV7FRI6BJAT7VUQB6GA7NEBN4KS4"

${GOAL} app create --creator ${ADDR} \
	--approval-prog approval_1.teal \
	--clear-prog clear.teal \
	--global-byteslices 0 --global-ints 0 \
	--local-byteslices 0 --local-ints 0 \
	-o app1.txn

${GOAL} app create --creator ${ADDR} \
	--approval-prog approval_2.teal \
	--clear-prog clear.teal \
	--global-byteslices 0 --global-ints 0 \
	--local-byteslices 0 --local-ints 0 \
	-o app2.txn

cat app1.txn app2.txn > group.ctxn
rm app1.txn app2.txn

${GOAL} clerk group -i group.ctxn -o group.gtxn
rm group.ctxn

${GOAL} clerk split -i group.gtxn -o group.txn
rm group.gtxn

${GOAL} clerk sign -i group-0.txn -o group-0.stxn
${GOAL} clerk sign -i group-1.txn -o group-1.stxn
rm group-0.txn group-1.txn

cat group-0.stxn group-1.stxn > group.stxn
rm group-0.stxn group-1.stxn

${GOAL} clerk rawsend -f group.stxn
rm group.stxn

