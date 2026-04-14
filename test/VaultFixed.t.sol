// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/VaultFixed.sol";
import "../src/Attack.sol";

contract VaultFixedTest is Test {
    VaultFixed vault;
    Attack attacker;

    address user = address(1);

    receive() external payable {}

    function setUp() public {
        vault = new VaultFixed();

        vm.deal(user, 10 ether);
        vm.prank(user);
        vault.deposit{value: 10 ether}();

        attacker = new Attack(address(vault));

        vm.deal(address(attacker), 1 ether);
    }

    function testAttackFails() public {
        uint256 beforeBal = address(vault).balance;

        vm.prank(address(attacker));
        attacker.attack{value: 1 ether}();

        uint256 afterBal = address(vault).balance;

        // attack should NOT drain significantly
        assertGe(afterBal, beforeBal - 1 ether);
    }
}