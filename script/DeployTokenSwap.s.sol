//SPDX-LICENSE-IDENTIFIER:MIT
pragma solidity^0.8.0;

import {ISwapRouter} from "@uniswap/v3-periphery/contracts/interfaces/ISwapRouter.sol";
import {Script} from "forge-std/Script.sol";
import {TokenSwap} from "../src/TokenSwap.sol";
import {console} from "forge-std/Test.sol";


contract DeployTokenSwap is Script{
    TokenSwap tokenSwap;
    address constant UNISWAP_SEPOLIA_ROUTER=0xE592427A0AEce92De3Edee1F18E0157C05861564;

    function run() public returns(address) {
        vm.startBroadcast();
        tokenSwap=new TokenSwap(UNISWAP_SEPOLIA_ROUTER);
        vm.stopBroadcast();
        return address(tokenSwap);
       
    }

}