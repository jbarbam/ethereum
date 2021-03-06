const path = require('path');
const fs = require('fs');
const solc = require('solc');

const contractPath = path.resolve(__dirname,"../contracts","UsersContract.sol");
const fileContent = fs.readFileSync(contractPath, 'utf8');

const config = {
    language : 'Solidity',
    sources: {
      'UsersContract.sol': {
          content:fileContent
        },
    },
    settings: {
        outputSelection: { // return everything
            '*': {
                '*': ['*']
            }
        }
    }
  };

  const output = JSON.parse(solc.compile(JSON.stringify(config)));
  module.exports = output.contracts['UsersContract.sol']['UsersContract'];
