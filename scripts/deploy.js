// Import ethers from Hardhat package
const { ethers } = require("hardhat");

async function main() {

  const medicadeContract = await ethers.getContractFactory("Medicade");
  const deployedMedicadeContract = await medicadeContract.deploy();
  await deployedMedicadeContract.deployed();
  console.log("Medicade Address:", deployedMedicadeContract.address);
}

// Call the main function and catch if there is any error
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });