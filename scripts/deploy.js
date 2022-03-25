/**
    * @description      : 
    * @author           : Michael
    * @group            : 
    * @created          : 25/03/2022 - 01:01:51
    * 
    * MODIFICATION LOG
    * - Version         : 1.0.0
    * - Date            : 25/03/2022
    * - Author          : Michael
    * - Modification    : 
**/
const { ethers } = require("hardhat");

async function main() {
  /*
  A ContractFactory in ethers.js is an abstraction used to deploy new smart contracts,
  so tokenContract here is a factory for instances of our ERC20 contract.
  */
  const tokenContract = await ethers.getContractFactory("ERC20");

  // here we deploy the contract
  const deployedTokenContract = await tokenContract.deploy(10000000);
  // 10,000,000 is the total supply we've set
  
  // Wait for it to finish deploying
  await deployedTokenContract.deployed();

  // print the address of the deployed contract
  console.log(
    "ERC20 Contract Address:",
    deployedTokenContract.address
  );
}

// Call the main function and catch if there is any error
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });