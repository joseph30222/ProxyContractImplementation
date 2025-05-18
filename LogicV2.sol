// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract LogicV2 {
    uint256 public value;

    function setValue(uint256 _value) external {
        value = _value * 2; // Doubles the input
    }

    function getValue() external view returns (uint256) {
        return value;
    }
}