const hre = require("hardhat");

/**
 * SHEPARD Protocol Deployment Script
 * 
 * Deploys ShepardIBOE contract to Metal L2
 * 
 * The Sheep That Heard
 * UCC Article 12 Compliant IBOE NFT
 * 
 * Authority: 48 Stat. 112 (Public Resolution No. 10, 73rd Congress)
 * UCC-1 Filing: U250141327124 (California)
 */

async function main() {
  console.log("\n========================================");
  console.log("SHEPARD Protocol - Contract Deployment");
  console.log("The Sheep That Heard");
  console.log("========================================\n");

  // Get deployer account
  const [deployer] = await hre.ethers.getSigners();
  console.log("Deploying with account:", deployer.address);
  
  const balance = await hre.ethers.provider.getBalance(deployer.address);
  console.log("Account balance:", hre.ethers.formatEther(balance), "METAL\n");

  // Deploy ShepardIBOE
  console.log("Deploying ShepardIBOE contract...");
  const ShepardIBOE = await hre.ethers.getContractFactory("ShepardIBOE");
  const shepardIBOE = await ShepardIBOE.deploy();
  await shepardIBOE.waitForDeployment();

  const contractAddress = await shepardIBOE.getAddress();
  console.log("\nShepardIBOE deployed to:", contractAddress);

  // Log deployment details
  console.log("\n========================================");
  console.log("DEPLOYMENT COMPLETE");
  console.log("========================================");
  console.log("Contract:", contractAddress);
  console.log("Network:", hre.network.name);
  console.log("Chain ID:", (await hre.ethers.provider.getNetwork()).chainId.toString());
  console.log("\nLegal Framework:");
  console.log("- Authority: 48 Stat. 112");
  console.log("- UCC-1 Filing: U250141327124");
  console.log("- Compliance: UCC Articles 3, 9, 12");
  console.log("\nAffirmed under penalty of LAW");
  console.log("Aaron Theophilus - Secured Party");
  console.log("========================================\n");

  return contractAddress;
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
