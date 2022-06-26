# itxn cloner

This demo contains two smart contracts, the first is our reference smart
contract (the target), and the second is the cloner. It essentially allows
deploying new smart contracts from a template without storing the smart
contract within the deploying smart contract.

## reference

The reference smart contract is deployed with an address (the account_owner) as
the first argument. Once deployed only that addressand can then successfully
call it.

## cloner

The cloner smart contract is deployed without arguments, but can then be called
with a foreign application reference and an argument to be passed during the
deployment of the new cloned smart contract via an inner transaction. In our
example, the argument will be the new account_owner.

