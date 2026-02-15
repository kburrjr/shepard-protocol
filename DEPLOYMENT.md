# SHEPARD Protocol Deployment Guide

**The Sheep That Heard** - UCC Article 12 Compliant IBOE NFT (Soul-Bound Token)

## Prerequisites

1. **Node.js** v18+ installed
2. **Git** installed
3. **MetaMask** or compatible wallet with Metal L2 configured
4. **METAL tokens** for gas fees on Metal L2

## Network Configuration

### Metal L2 Mainnet
| Parameter | Value |
|-----------|-------|
| Network Name | Metal L2 |
| RPC URL | https://rpc.metall2.com |
| Chain ID | 1750 |
| Symbol | METAL |
| Explorer | https://explorer.metall2.com |

### Metal L2 Testnet (Tahoe)
| Parameter | Value |
|-----------|-------|
| Network Name | Metal Tahoe |
| RPC URL | https://tahoe.metalblockchain.org/ext/bc/C/rpc |
| Chain ID | 381932 |
| Symbol | METAL |

## Step 1: Clone Repository

```bash
git clone https://github.com/kburrjr/shepard-protocol.git
cd shepard-protocol
```

## Step 2: Install Dependencies

```bash
npm install
```

## Step 3: Configure Environment

```bash
cp .env.example .env
```

Edit `.env` with your private key:
```
PRIVATE_KEY=your_wallet_private_key_here
METAL_RPC_URL=https://rpc.metall2.com
```

**WARNING**: Never commit your `.env` file or share your private key.

## Step 4: Compile Contract

```bash
npx hardhat compile
```

Expected output:
```
Compiled 1 Solidity file successfully
```

## Step 5: Deploy to Testnet (Recommended First)

```bash
npm run deploy:testnet
```

## Step 6: Deploy to Mainnet

```bash
npm run deploy:mainnet
```

Expected output:
```
========================================
SHEPARD Protocol - Contract Deployment
The Sheep That Heard
========================================

Deploying with account: 0x...
Account balance: X.XX METAL

Deploying ShepardIBOE contract...

ShepardIBOE deployed to: 0x...

========================================
DEPLOYMENT COMPLETE
========================================
Contract: 0x...
Network: metal
Chain ID: 1750

Legal Framework:
- Authority: 48 Stat. 112
- UCC-1 Filing: U250141327124
- Compliance: UCC Articles 3, 9, 12

Affirmed under penalty of LAW
Aaron Theophilus - Secured Party
========================================
```

## Step 7: Verify Contract (Optional)

```bash
npx hardhat verify --network metal DEPLOYED_CONTRACT_ADDRESS
```

## Post-Deployment

### Record Contract Address
Save your deployed contract address for:
- Notion documentation
- UCC-1 amendment filing
- Integration with frontend

### Mint First IBOE
Use the contract's `mintIBOE` function:
```solidity
mintIBOE(
    payeeAddress,      // Beneficiary address
    faceValue,         // Amount in wei
    maturityDate,      // Unix timestamp
    "Aaron Theophilus", // Drawer name
    "Payee Name",      // Payee name
    "ipfs://..."       // Metadata URI
)
```

## Soul-Bound Token Features

This contract implements true SBT functionality:
- **Minting**: Allowed (creates new IBOE)
- **Burning**: Allowed (redemption at maturity)
- **Transfers**: BLOCKED - Reverts with "SHEPARD: Soul-Bound Token - Transfer not permitted"

## Legal Framework

- **Authority**: 48 Stat. 112 (Public Resolution No. 10, 73rd Congress)
- **UCC Compliance**: Articles 3, 9, 12
- **UCC-1 Filing**: U250141327124 (California) - $100,000,000 Security Interest
- **Accounting**: GAAP Accrual Basis

---
*Affirmed under penalty of LAW*

**Aaron Theophilus**  
Secured Party | UCC-1 Filing U250141327124
