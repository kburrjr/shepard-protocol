require("@nomicfoundation/hardhat-toolbox");
require("dotenv").config();

/**
 * SHEPARD Protocol - Hardhat Configuration
 * Metal L2 Deployment Configuration
 * 
 * The Sheep That Heard
 * UCC Article 12 Compliant IBOE NFT
 */

module.exports = {
  solidity: {
    version: "0.8.20",
    settings: {
      optimizer: {
        enabled: true,
        runs: 200
      }
    }
  },
  networks: {
    // Metal L2 Mainnet
    metal: {
      url: process.env.METAL_RPC_URL || "https://rpc.metall2.com",
      chainId: 1750,
      accounts: process.env.PRIVATE_KEY ? [process.env.PRIVATE_KEY] : [],
      gasPrice: "auto"
    },
    // Metal L2 Testnet (Tahoe)
    metalTestnet: {
      url: process.env.METAL_TESTNET_RPC || "https://tahoe.metalblockchain.org/ext/bc/C/rpc",
      chainId: 381932,
      accounts: process.env.PRIVATE_KEY ? [process.env.PRIVATE_KEY] : [],
      gasPrice: "auto"
    },
    // Local development
    localhost: {
      url: "http://127.0.0.1:8545"
    },
    hardhat: {
      chainId: 31337
    }
  },
  etherscan: {
    apiKey: {
      metal: process.env.METAL_EXPLORER_API || "placeholder"
    },
    customChains: [
      {
        network: "metal",
        chainId: 1750,
        urls: {
          apiURL: "https://explorer.metall2.com/api",
          browserURL: "https://explorer.metall2.com"
        }
      }
    ]
  },
  paths: {
    sources: "./contracts",
    tests: "./test",
    cache: "./cache",
    artifacts: "./artifacts"
  }
};
