//SPDX-LICENSE-IDENTIFIER:MIT
pragma solidity^0.8.0;

import {ISwapRouter} from "@uniswap/v3-periphery/contracts/interfaces/ISwapRouter.sol";
// import {TransferHelper} from "@uniswap/v3-periphery/contracts/libraries/TransferHelper.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract TokenSwap {
    ISwapRouter public immutable swapRouter;
    uint24 public constant fees=3000; //uniswap fees of 0.3%

    constructor(address _swapRouter) {
        swapRouter=ISwapRouter(_swapRouter);
    }
    //tokenIn:token being sent to the pool
    //tokenOut:token user wants from the pool
    //amountIn:amount of tokenIn
    //amountOutMin:Minimum amount of token that user is willing to accept for provided tokenIn(slippage protection)
    function exactInputSingle(
        address tokenIn,
        address tokenOut,
        uint256 amountIn,
        uint256 amountOutMin
    ) external payable returns(uint256 amountOut) {
        //User sends(from his wallet) tokenIn to this contract
        // TransferHelper.safeTransferFrom(tokenIn,msg.sender,address(this),amountIn);
        IERC20(tokenIn).transferFrom(msg.sender,address(this),amountIn);

        //now these tokenIn must be approved by this contract to be spent by swapRouter
        //as we dont interact with the pool directly,swapRouter does that for us
        // TransferHelper.safeApprove(tokenIn,address(swapRouter),amountIn);
        IERC20(tokenIn).approve(address(swapRouter),amountIn);

        //now we have to construct the calldata
        ISwapRouter.ExactInputSingleParams memory params=ISwapRouter.ExactInputSingleParams({
            tokenIn:tokenIn,
            tokenOut:tokenOut,
            fee:fees,
            recipient:address(this),
            deadline:block.timestamp,
            amountIn:amountIn,
            amountOutMinimum:amountOutMin,
            sqrtPriceLimitX96:0
        });

        //since we have now created calldata
        //it's time to execute them
        amountOut=swapRouter.exactInputSingle(params);




    }
     //same as swapExactInputSingle but swaps on the basis of provided output token
     function swapExactOutputSingleToken(
        address tokenIn,
        address tokenOut,
        uint256 amountOut,
        uint256 amountInMaximum
    ) external returns (uint256 amountIn) {
        // Transfer tokenIn from sender to this contract
        // TransferHelper.safeTransferFrom(tokenIn, msg.sender, address(this), amountInMaximum);
        IERC20(tokenIn).transferFrom(msg.sender,address(this),amountIn);

        //  Approve the router to spend tokenIn
        // TransferHelper.safeApprove(tokenIn, address(swapRouter), amountInMaximum);
        IERC20(tokenIn).approve(address(swapRouter),amountIn);

        // Create parameters for the swap
        ISwapRouter.ExactOutputSingleParams memory params = ISwapRouter.ExactOutputSingleParams({
            tokenIn: tokenIn,
            tokenOut: tokenOut,
            fee: fees,
            recipient: address(this),
            deadline: block.timestamp,
            amountOut: amountOut,
            amountInMaximum: amountInMaximum,
            sqrtPriceLimitX96: 0 // No price limit
        });

        // Execute the swap
        amountIn = swapRouter.exactOutputSingle(params);

        //  Refund leftover tokenIn if any
        if (amountIn < amountInMaximum) {
            // TransferHelper.safeApprove(tokenIn, address(swapRouter), 0); // remove remaining approval
            IERC20(tokenIn).approve(address(swapRouter),0);
            uint256 refund = amountInMaximum - amountIn;
            // TransferHelper.safeTransfer(tokenIn, msg.sender, refund);
            IERC20(tokenIn).transfer(msg.sender,refund);
        }
    }

}