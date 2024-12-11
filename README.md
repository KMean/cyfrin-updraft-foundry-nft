# Cyfrin Updraft Foundry NFT Project

This project is a section of the **Cyfrin Foundry Solidity Course** and focuses on creating two different types of NFTs using Solidity:

1. **IPFS Hosted NFT**  
   NFTs with metadata and assets hosted on IPFS, ensuring decentralized storage.

2. **SVG NFT (On-Chain)**  
   NFTs that are 100% hosted on-chain, with SVG data stored directly in the smart contract.

---

## Project Structure

- **`src/`**: Contains the smart contracts for both NFT types.
- **`script/`**: Deployment scripts for the NFTs.
- **`test/`**: Unit tests written with Forge to ensure functionality.

---

## Prerequisites

Before starting, ensure you have the following installed:

- [Foundry](https://getfoundry.sh/) - A blazing-fast development framework for Solidity.
- [Node.js](https://nodejs.org/) - For managing dependencies if needed.
- A wallet like [MetaMask](https://metamask.io/) to interact with your deployed contracts.

---

## Getting Started

### Clone the Repository

```bash
git clone https://github.com/your-username/cyfrin-updraft-nft.git
cd cyfrin-updraft-nft
```

## Install Foundry
Install Foundry if you haven't already:
```bash
curl -L https://foundry.paradigm.xyz | bash
foundryup
```

## Build the Project
```bash
forge build
```

## Run Tests
Execute the unit tests to ensure everything works as expected:
```bash
forge test
```