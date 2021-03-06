/**
    * @description      : 
    * @author           : Michael
    * @group            : 
    * @created          : 25/03/2022 - 01:05:26
    * 
    * MODIFICATION LOG
    * - Version         : 1.0.0
    * - Date            : 25/03/2022
    * - Author          : Michael
    * - Modification    : 
**/
require("@nomiclabs/hardhat-waffle");
require("dotenv").config({ path: ".env" });

const ALCHEMY_API_KEY_URL = process.env.ALCHEMY_API_KEY_URL;

const RINKEBY_PRIVATE_KEY = process.env.RINKEBY_PRIVATE_KEY;

module.exports = {
  solidity: "0.8.4",
  networks: {
    rinkeby: {
      url: ALCHEMY_API_KEY_URL,
      accounts: [RINKEBY_PRIVATE_KEY],
    },
  },
};
