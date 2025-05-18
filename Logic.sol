// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// Sample Logic Contract
contract Logic {
    // State variable to store a number
    uint256 public value;

    // Function to set the value
    function setValue(uint256 _value) external {
        value = _value;
    }

    // Function to get the value
    function getValue() external view returns (uint256) {
        return value;
    }
}