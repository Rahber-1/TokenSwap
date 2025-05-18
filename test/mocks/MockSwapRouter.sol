// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {ISwapRouter} from "@uniswap/v3-periphery/contracts/interfaces/ISwapRouter.sol";
import {IUniswapV3SwapCallback} from "@uniswap/v3-core/contracts/interfaces/callback/IUniswapV3SwapCallback.sol";

contract MockSwapRouter is ISwapRouter {
    // Store the last swap params for test assertions
    ExactInputSingleParams public lastExactInputSingleParams;
    ExactOutputSingleParams public lastExactOutputSingleParams;

    uint256 public mockedOutputAmount = 1e18;
    uint256 public mockedInputAmount = 1e18;

    // Allow test to set mock return values
    function setMockedAmounts(uint256 _output, uint256 _input) external {
        mockedOutputAmount = _output;
        mockedInputAmount = _input;
    }

    function exactInputSingle(
        ExactInputSingleParams calldata params
    ) external payable override returns (uint256 amountOut) {
        lastExactInputSingleParams = params;
        return mockedOutputAmount;
    }

    function exactOutputSingle(
        ExactOutputSingleParams calldata params
    ) external payable override returns (uint256 amountIn) {
        lastExactOutputSingleParams = params;
        return mockedInputAmount;
    }

    // Dummy implementations to satisfy ISwapRouter
    function exactInput(ExactInputParams calldata) external payable override returns (uint256) {
        return mockedOutputAmount;
    }

    function exactOutput(ExactOutputParams calldata) external payable override returns (uint256) {
        return mockedInputAmount;
    }

    // Required by IUniswapV3SwapCallback
    function uniswapV3SwapCallback(
        int256,
        int256,
        bytes calldata
    ) external override {
        // Leave blank for mock
    }

    receive() external payable {}
}
