# reentrancy_attack
## Reentrancy Attack in action with two Smart Contracts, vulnerable and attacker.

Reentrancy attack is one of the most destructive and important attacks in Smart Contracts written in Solidity. A reentrancy attack occours when a function vulnerable smart contract makes an external call to an other untrusted or bad contract. That bad contract then makes a recursive call back to the calling function of the vulnerable contract and drains the funds locked in the contract.

This happens due to check-interaction-effect pattern in vulnerable contract, in other words this pattern is the vulnerability in the contract.

## What is happening under the hood:

- Suppose there are some funds in the vulnerable contract
- Attacker contract will have the instance of vulnerable contract, through which it can call functions of vulnerable contract
- Attacker contract will deposit some Ethers, like 1 Ether in the vulnerable contract and will withdraw in the same transaction
- Vulnerable contract will deposit attacker's funds and will call it to give back its deposited funds
- Now the receive or fallaback function of the attacker contract will make a call abck to the withdraw function of vulnerable contract
- Vulnerble contract will transfer funds again before updating balances mapping
- Receive or fallback function of attacker contract will again make a call back to the withdraw function of vulnerable contract
- And it will drain funds (including it's own deposited ones) by recursivily calling withdraw function of vulnerable contract
