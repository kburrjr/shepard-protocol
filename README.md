# SHEPARD Protocol

**The Sheep That Heard** - UCC Article 12 Compliant IBOE NFT for Metal L2

## Overview

SHEPARD Protocol creates legally compliant International Bills of Exchange (IBOE) as NFTs on Metal L2 blockchain. Each IBOE NFT serves as a UCC Article 12 Controllable Electronic Record (CER) with full chain-of-title tracking.

## Legal Framework

- **Authority**: 48 Stat. 112 (Public Resolution No. 10, 73rd Congress)
- **UCC Compliance**: Articles 3, 9, 12
- **UCC-1 Filing**: U250141327124 (California) - $100,000,000 Security Interest
- **Accounting**: GAAP Accrual Basis

## Architecture

```
shepard-protocol/
├── contracts/
│   └── ShepardIBOE.sol          # Main IBOE NFT contract
├── scripts/
│   └── deploy.js                 # Deployment script
├── test/
│   └── ShepardIBOE.test.js      # Contract tests
├── hardhat.config.js             # Metal L2 configuration
└── README.md
```

## Token Structure

### IBOE Record (On-Chain)
```solidity
struct IBOERecord {
    uint256 faceValue;
    uint256 maturityDate;
    address drawer;
    address payee;
    string drawerName;
    string payeeName;
    string uccFilingNumber;
    string authorityReference;
    bool isEndorsed;
    bool isRedeemed;
}
```

## Deployment

### Metal L2 Mainnet
- **Chain ID**: 1750
- **RPC**: https://rpc.metall2.com
- **Explorer**: https://explorer.metall2.com

### Quick Start
```bash
npm install
npx hardhat compile
npx hardhat run scripts/deploy.js --network metal
```

## Custom House Framework

SHEPARD Protocol implements the Custom House issuance model:
1. **Drawer** creates IBOE NFT (initial mint)
2. **Payee** receives as named beneficiary
3. **Endorsement** transfers control per UCC 12-105
4. **Redemption** burns token upon settlement

## License

Proprietary - All Rights Reserved

---
*Affirmed under penalty of LAW*

**Aaron Theophilus**  
Secured Party | UCC-1 Filing U250141327124
