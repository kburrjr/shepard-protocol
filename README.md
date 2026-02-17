# SHEPARD Protocol

**The Sheep That Heard** - UCC Article 12 Compliant Sovereign Bond NFT for Metal L2

## Overview

SHEPARD Protocol creates legally compliant Sovereign Bond instruments as NFTs on Metal L2 blockchain. Each Bond NFT serves as a UCC Article 12 Controllable Electronic Record (CER) with full chain-of-title tracking. The protocol also includes an ERC-3643 compliant wrapper (wSHEPARD) for the underlying ERC-20 token.

## Legal Framework

- **Authority**: 48 Stat. 112 (Public Resolution No. 10, 73rd Congress)
- **UCC Compliance**: Articles 3, 7, 9, 12
- **UCC-1 Filing**: U250141327124 (California) - $100,000,000 Security Interest
- **Accounting**: GAAP Accrual Basis

## Architecture

```
shepard-protocol/
|-- contracts/
|   |-- ShepardSovereignBond.sol    # ERC-721 Bond NFT ($SSB-A)
|   |-- ShepardComplianceWrapper.sol # ERC-3643 Wrapper (wSHEPARD)
|-- scripts/
|   |-- deploy.js                    # Deployment script
|-- hardhat.config.js                # Metal L2 configuration
|-- README.md
```

## Deployed Contracts (Metal L2 Mainnet - Chain ID 1750)

| Contract | Address |
|----------|--------|
| ShepardToken ($SHEPARD) | 0x74EA40E2E07806Cef2Fe129bB70d44c9C20F76C5 |
| ShepardComplianceWrapper (wSHEPARD) | 0x4d68CD64F450dA96A938fb9a85E86Ba9fE7d8Dc9 |
| ShepardSovereignBond ($SSB-A) | TBD |

## Token Structure

- **Name**: Shepard Sovereign Bond Series A
- **Symbol**: SSB-A
- **Standard**: ERC-721 (Non-Fungible Token)
- **Network**: Metal L2 (Chain ID: 1750)
- **Face Value**: $100,000,000

## Wrapper (wSHEPARD)

- **Name**: Shepard Compliant Note
- **Symbol**: wSHEPARD
- **Standard**: ERC-20 with ERC-3643 compliance layer
- **Supply**: 100,000,000 (wrapped from raw $SHEPARD)
- **Whitelist enforced**: All transfers require both sender and recipient to be whitelisted

## Key Features

- Soul-bound bond instrument (non-transferable after mint)
- On-chain UCC filing reference
- Document hash verification
- Maturity date tracking
- Status management (ACTIVE/REDEEMED)
- ERC-3643 compliance wrapper with whitelist enforcement

## Legal Notice

Affirmed under penalty of LAW
Aaron Theophilus - Secured Party

## License

MIT
