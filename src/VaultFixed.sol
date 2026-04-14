// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract VaultFixed {
    mapping(address => uint256) public shares;

    uint256 public totalShares;
    uint256 public totalAssets;

    address public owner;

    constructor() {
        owner = msg.sender;
    }

    function deposit() external payable {
        uint256 sharesToMint;

        uint256 actualAssets = address(this).balance - msg.value;

        if (totalShares == 0) {
            sharesToMint = msg.value;
        } else {
            sharesToMint = (msg.value * totalShares) / actualAssets;
        }

        shares[msg.sender] += sharesToMint;
        totalShares += sharesToMint;
        totalAssets += msg.value;
    }

    function withdraw(uint256 _shares) external {
        require(shares[msg.sender] >= _shares, "Not enough shares");

        uint256 amount = (_shares * totalAssets) / totalShares;

        //  FIX: state update first
        shares[msg.sender] -= _shares;
        totalShares -= _shares;
        totalAssets -= amount;

        (bool success, ) = msg.sender.call{value: amount}("");

        //  no revert
        if (!success) return;
    }

    function invest(uint256 amount) external {
        require(msg.sender == owner, "Not owner");
        require(amount <= totalAssets, "Too much");

        totalAssets -= amount;
    }
}