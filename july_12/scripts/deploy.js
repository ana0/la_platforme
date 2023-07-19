// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// You can also run a script with `npx hardhat run <script>`. If you do that, Hardhat
// will compile your contracts, add the Hardhat Runtime Environment's members to the
// global scope, and execute the script.
const hre = require("hardhat");

async function main() {
  const nft = await hre.ethers.deployContract("NFT", ["Test NFT", "NFT"]);

  await nft.waitForDeployment();

  console.log(
    `NFT deployed to ${nft.target}`
  );

  await nft.setTokenURI("", 1);
  await nft.mint("0x453970Bee811490C4d961e6F6532154c22ecE8fC", 1);

  console.log("NFT minted");
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
