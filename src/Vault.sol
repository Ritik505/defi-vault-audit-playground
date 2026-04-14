// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Vault {
    mapping(address => uint256) public shares;

    uint256 public totalShares;
    uint256 public totalAssets;

    address public owner;

    constructor() {
        owner = msg.sender;
    }

    function deposit() external payable {
        uint256 sharesToMint;

        if (totalShares == 0) {
            sharesToMint = msg.value;
        } else {
            sharesToMint = (msg.value * totalShares) / totalAssets;
        }

        shares[msg.sender] += sharesToMint;
        totalShares += sharesToMint;
        totalAssets += msg.value;
    }

    function withdraw(uint256 _shares) external {
        require(shares[msg.sender] >= _shares, "Not enough shares");

        uint256 amount = (_shares * totalAssets) / totalShares;

        //  Vulnerable: external call before state update
        (bool success, ) = msg.sender.call{value: amount}("");

        //  Do not revert (keeps tests stable)
        if (!success) return;

        shares[msg.sender] -= _shares;
        totalShares -= _shares;
        totalAssets -= amount;
    }

    function invest(uint256 amount) external {
        require(msg.sender == owner, "Not owner");

        //  Vulnerable accounting
        totalAssets -= amount;
    }
}