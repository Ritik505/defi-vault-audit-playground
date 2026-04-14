// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/Vault.sol";

contract VaultTest is Test {
    Vault vault;

    receive() external payable {}

    function setUp() public {
        vault = new Vault();
    }

    function testDeposit() public {
        vm.deal(address(this), 1 ether);
        vault.deposit{value: 1 ether}();

        assertEq(vault.totalAssets(), 1 ether);
    }

    function testWithdraw() public {
        vm.deal(address(this), 1 ether);

        vault.deposit{value: 1 ether}();

        uint256 shares = vault.shares(address(this));

        vault.withdraw(shares);

        assertEq(address(vault).balance, 0);
    }

    function testFuzz_Deposit(uint256 amount) public {
        vm.assume(amount > 1e9 && amount < 10 ether);

        vm.deal(address(this), amount);

        vault.deposit{value: amount}();

        assertEq(vault.totalAssets(), amount);
    }
}