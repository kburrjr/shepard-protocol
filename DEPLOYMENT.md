# SHEPARD Protocol Deployment Guide

**The Sheep That Heard** - UCC Article 12 Compliant Sovereign Bond NFT (Soul-Bound Token)

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

Edit `.env` and add:
- `PRIVATE_KEY` - Your deployer wallet private key
- `METAL_L2_RPC` - Metal L2 RPC URL

## Step 4: Compile Contracts

```bash
npx hardhat compile
```

## Step 5: Deploy

### Deploy to Testnet (Tahoe)
```bash
npm run deploy:testnet
```

### Deploy to Mainnet
```bash
npm run deploy:mainnet
```

## Deployed Contracts (Metal L2 Mainnet)

| Contract | Address | Standard |
|----------|---------|----------|
| ShepardToken ($SHEPARD) | 0x74EA40E2E07806Cef2Fe129bB70d44c9C20F76C5 | ERC-20 |
| ShepardComplianceWrapper (wSHEPARD) | 0x4d68CD64F450dA96A938fb9a85E86Ba9fE7d8Dc9 | ERC-20/ERC-3643 |
| ShepardSovereignBond ($SSB-A) | TBD | ERC-721 |
| ShepardTreasury | 0x650D3750e5C96E45484e9917C6F453528cAD53dE | Custom |

## Post-Deployment Steps

1. Whitelist authorized wallets on ComplianceWrapper via `updateWhitelist(address, bool)`
2. Approve wrapper to spend raw $SHEPARD via `approve(wrapperAddress, amount)`
3. Wrap tokens via `wrap(amount)` on ComplianceWrapper
4. Verify contracts on Blockscout: https://explorer.metall2.com

## Security Notes

- Only the contract owner can update the whitelist
- Only whitelisted addresses can send or receive wSHEPARD
- The `unwrap()` function is restricted to `onlyOwner`
- Bond NFTs are soul-bound (non-transferable after mint)

## Legal Notice

Affirmed under penalty of LAW
Aaron Theophilus - Secured Party
Authority: 48 Stat. 112; UCC Arts. 3, 7, 9, 12
