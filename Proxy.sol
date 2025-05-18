// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// Proxy contract implementing EIP-1967
contract Proxy {
    // EIP-1967 storage slot for the logic contract address
    bytes32 private constant IMPLEMENTATION_SLOT = 
        0x360894a13ba1a3210667c828492db98dca3e2076cc3735a920a3ca505d382bbc;

    // Only the owner can upgrade the contract
    address public owner;

    // Constructor sets the initial logic contract address and owner
    constructor(address _logic) {
        owner = msg.sender;
        // Store the logic contract address in the EIP-1967 slot
        bytes32 slot = IMPLEMENTATION_SLOT;
        assembly {
            sstore(slot, _logic)
        }
    }

    // Modifier to restrict functions to the owner
    modifier onlyOwner() {
        require(msg.sender == owner, "Not owner");
        _;
    }

    // Upgrade the logic contract address (only owner)
    function upgrade(address _newLogic) external onlyOwner {
        bytes32 slot = IMPLEMENTATION_SLOT;
        assembly {
            sstore(slot, _newLogic)
        }
    }

    // Fallback function to forward calls to the logic contract
    fallback() external payable {
        // Get the logic contract address from the EIP-1967 slot
        address logic;
        bytes32 slot = IMPLEMENTATION_SLOT;
        assembly {
            logic := sload(slot)
        }

        // Use delegatecall to execute the logic contract’s code
        (bool success, bytes memory data) = logic.delegatecall(msg.data);
        require(success, "Delegatecall failed");

        // Return the result to the caller
        assembly {
            return(add(data, 0x20), mload(data))
        }
    }

    // Receive function to accept ETH (if needed)
    receive() external payable {}
}