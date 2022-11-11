require("@nomicfoundation/hardhat-toolbox");
require('@nomiclabs/hardhat-ethers')
const API_URL = "https://palpable-summer-liquid.ethereum-goerli.discover.quiknode.pro/fc67170e826a61ef001cc2da891436664ef193ee/";
const PRIVATE_KEY = "e0360689bb5816422ae35f3977afaa4a15e6d8562f7d8998b94f799915d9a158"
const PUBLIC_KEY = "0xc4422aBF20BAe1dBfBCc8DBd1b93A02373528a24";


task("accounts", "Prints the list of accounts", async (taskArgs, hre) => {
  const accounts = await hre.ethers.getSigners();

  for (const account of accounts) {
      console.log(account.address);
  }
});

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.17",
  networks: {
    goerli: {
      url: API_URL,
      accounts: [`0x${PRIVATE_KEY}`]
    },
  },
};
