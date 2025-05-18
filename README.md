---

# 🪙 TokenSwap DEX Integration

A smart contract that enables token swaps via the Uniswap V3 protocol. This project is designed for developers building on-chain DeFi solutions using Solidity and Foundry. It includes both mainnet-ready contract logic and a comprehensive local testing setup using mocks.

---

## 📌 Features

* ✅ **Single-token swap (Exact Input)**: Swap a specific amount of token A for token B.
* ✅ **Single-token swap (Exact Output)**: Swap up to a maximum amount of token A to receive an exact amount of token B.
* 🔒 **Slippage Protection**: Set minimum amount out or maximum amount in.
* 🔁 **Mocked Router for Testing**: Includes `MockSwapRouter` to simulate Uniswap V3 behavior in local tests.
* ⚡️ **Written in Solidity `^0.8.0`** with Foundry for testing.

---

## 🚀 Live Deployment

* **Network**: Sepolia Testnet
* **TokenSwap Contract Address**: `0x6a5bA2eB584309A03abbF94e505D868AFE6dD26d`
* **Router Used**: Uniswap V3 SwapRouter (or mocked locally for test)
* **Tokens Used in Test Swaps**:

  * LINK: `0x779877A7B0D9E8603169DdbD7836e478b4624789`
  * USDC: `0x1c7D4B196Cb0C7B01d743Fbc6116a902379C7238`

---

## 🧱 Contract Overview

### `TokenSwap.sol`

Main contract to perform token swaps using Uniswap V3.

```solidity
function swapExactInputSingle(address tokenIn, address tokenOut, uint256 amountIn, uint256 amountOutMin) external returns (uint256);
function swapExactOutputSingleToken(address tokenIn, address tokenOut, uint256 amountOut, uint256 amountInMaximum) external returns (uint256);
```

* Approves the `ISwapRouter` to spend user tokens.
* Encodes parameters for Uniswap's `exactInputSingle` and `exactOutputSingle` functions.
* Executes the swap and optionally refunds unused tokens.

---

## 🧪 Testing

### Prerequisites

* [Foundry](https://book.getfoundry.sh/) installed
* RPC URL and private key set via `.env`

### Run Tests

```bash
forge test -vv
```

### Mocks

* ✅ `MockSwapRouter.sol`: Simulates `ISwapRouter` behavior.
* Implements dummy return values for both `exactInputSingle()` and `exactOutputSingle()`.

---

## 🔄 Mock Example

```solidity
function exactInputSingle(...) external override returns (uint256) {
    return 1e18; // Mocks a successful swap returning 1 ETH-equivalent
}
```

Ensure mock is correctly set in your test setup:

```solidity
swapRouter = new MockSwapRouter();
tokenSwap = new TokenSwap(address(swapRouter));
```

---

## 🧰 Tools & Libraries

* 🧪 **Foundry** – for fast and efficient testing
* 🔁 **Uniswap V3** – interface and logic
* 🔐 **OpenZeppelin** – secure ERC-20 transfers
* 🧪 **Mocks** – to simulate external Uniswap behavior in a safe local environment

---

## 📄 License

[MIT](./LICENSE)

---

## 🤝 Contributions

Contributions, feedback, and suggestions are welcome! Fork this repo and open a PR or file an issue for improvement.

---

