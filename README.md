# DeFi Vault Audit Playground

A practical smart contract security project built with Foundry that demonstrates real-world DeFi vulnerabilities, exploitation techniques, and secure remediation patterns.

## Overview

This project implements a simplified ETH vault where users can:

. Deposit ETH and receive proportional shares
. Withdraw ETH based on owned shares
. Interact with a system that intentionally includes security flaws
. Objectives
. Understand common DeFi vulnerabilities
. Learn how to write exploit contracts
. Practice identifying insecure Solidity patterns
. Implement secure fixes
. Build a strong smart contract auditing foundation

## Project Structure

defi-vault-audit-playground/
│
├── src/
│   ├── Vault.sol
│   ├── VaultFixed.sol
│   └── Attack.sol
│
├── test/
│   ├── Vault.t.sol
│   ├── VaultAttack.t.sol
│   ├── ShareInflation.t.sol
│   └── VaultFixed.t.sol
│
├── lib/
├── script/
├── foundry.toml
├── AUDIT_REPORT.md
└── README.md   


Vulnerabilities Covered
Reentrancy (Medium Severity)
. Location: withdraw()
. Issue: External call before state update
. Risk: Reentrant execution possible
. Fix: Follow Checks-Effects-Interactions pattern

## Share Inflation (Critical Severity)

. Location: deposit() and invest()
. Issue: Incorrect accounting using totalAssets
. Risk: Attacker can mint excessive shares
. Fix: Use address(this).balance and proper validation

# Test Suite

## Functional Tests
. Vault.t.sol
   - Deposit validation
   - Withdraw validation
   - Fuzz testing

## Attack Tests
. VaultAttack.t.sol
   -Demonstrates reentrancy   behavior
. ShareInflation.t.sol
  -Demonstrates share inflation exploit

## Fix Validation
. VaultFixed.t.sol
   - Confirms vulnerabilities are mitigated
   - Ensures attacker cannot exploit


## Security Concepts
. Checks-Effects-Interactions (CEI)
. Reentrancy attacks
. Vault share accounting
. Exploit contract design
. Secure Solidity patterns

## Audit Report

Full audit report available in:

AUDIT_REPORT.md


## Future Improvements
. Add more vulnerabilities
. Integrate OpenZeppelin contracts
. Add invariant testing
. Add static analysis (Slither)
. Expand to ERC4626 vault standard

# Author
## Ritik Verma