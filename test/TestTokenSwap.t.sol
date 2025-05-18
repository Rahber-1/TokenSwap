// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/TokenSwap.sol";
import {MockERC20} from "./mocks/MockERC20.sol";
import {MockSwapRouter} from "./mocks/MockSwapRouter.sol";

contract TokenSwapTest is Test {
    TokenSwap public tokenSwap;
    MockERC20 public tokenIn;
    MockERC20 public tokenOut;
    MockSwapRouter public mockRouter;

    address user = address(0xABCD);

    function setUp() public {
        tokenIn = new MockERC20("MockIn", "MIN", 18);
        tokenOut = new MockERC20("MockOut", "MOUT", 18);
        mockRouter = new MockSwapRouter();

        tokenSwap = new TokenSwap(address(mockRouter));

        // Give user tokens and approve TokenSwap contract
        tokenIn.mint(user, 10e18);
        vm.prank(user);
       
        tokenIn.approve(address(tokenSwap), 1e18);
    }

    function testSwapExactInputSingle() public {
        vm.prank(user);
        
        
        tokenSwap.exactInputSingle(
            address(tokenIn),
            address(tokenOut),
            1e18,
            1e17
        );

        
        assertEq(tokenIn.balanceOf(address(mockRouter)), 1e18);
    }
}
