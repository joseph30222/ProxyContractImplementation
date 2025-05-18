# ProxyContractImplementation

# Overview

This repository implements a simplified version of the EIP-1967 proxy standard for upgradeable smart contracts in Solidity. The goal is to demonstrate how proxy patterns enable contract upgradability while preserving data and contract addresses.

# EIP-1967 Proxy Standard

# What is EIP-1967?

EIP-1967 is an Ethereum Improvement Proposal that standardizes how proxy contracts store the address of their logic (implementation) contract. It defines a specific storage slot (0x360894a13ba1a3210667c828492db98dca3e2076cc3735a920a3ca505d382bbc) to hold the address of the logic contract. This ensures compatibility and predictability across proxy implementations.

# How Does It Work?

 A proxy contract acts as a middleman:





 The proxy contract receives function calls from users.



It uses a delegatecall to forward the call to the logic contract, whose address is stored in the EIP-1967 slot.



The logic contract executes the function and returns the result via the proxy.



To upgrade, the proxy updates the logic contract’s address in the storage slot, pointing to a new implementation.

This setup ensures the proxy’s address and storage remain unchanged, preserving user data and interactions.

# Benefits





Upgradability: Developers can fix bugs or add features by deploying a new logic contract.



Data Persistence: User data (e.g., balances) stays in the proxy’s storage.



Cost Efficiency: No need to redeploy large contracts or migrate data.

Security Considerations





Storage Collisions: If the proxy and logic contracts use the same storage slots, data can be corrupted. EIP-1967 mitigates this by using a unique slot.



Access Control: Only authorized addresses (e.g., the contract owner) should upgrade the logic contract to prevent malicious upgrades.



Transparency: Users should know the contract is upgradeable to avoid trust issues.

# Implementation

This repository includes a simplified Solidity implementation:





Proxy.sol: A proxy contract that stores the logic contract’s address and forwards calls using delegatecall.



Logic.sol: A sample logic contract with basic functionality (e.g., storing and retrieving a value).

 See the /contracts folder for the code.

## Testing

The contracts were tested in Remix using Remix VM - Mainnet fork. The `Proxy` contract successfully forwarded calls to the `Logic` contract, and an upgrade to `LogicV2` was performed, demonstrating upgradability while preserving storage.

References





EIP-1967: Standard Proxy Storage Slots



OpenZeppelin Upgrades Documentation



Solidity Documentation
