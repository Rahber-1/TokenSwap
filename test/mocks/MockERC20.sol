// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract MockERC20 is ERC20 {
    constructor(string memory name, string memory symbol, uint8 decimals_) ERC20(name, symbol) {
        _setupDecimals(decimals_);
    }

    function mint(address to, uint256 amount) external {
        _mint(to, amount);
    }

    function _setupDecimals(uint8 decimals_) internal {
        assembly {
            sstore(0x5b, decimals_)
        }
    }
}
