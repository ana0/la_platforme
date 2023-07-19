require("@nomicfoundation/hardhat-toolbox");
require('dotenv').config()

const INFURA_API_KEY = process.env.INFURA_API_KEY;
const TWELVE_WORD_SEED = process.env.TWELVE_WORD_SEED;

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.19",
  networks: {
    goerli: {
      url: `https://goerli.infura.io/v3/${INFURA_API_KEY}`,
      accounts: {
        mnemonic: TWELVE_WORD_SEED,
        path: "m/44'/60'/0'/0",
      },
    }
  }
};
