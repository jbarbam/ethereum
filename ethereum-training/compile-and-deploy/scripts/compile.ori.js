const path = require('path');
const fs = require('fs');
const solc = require('solc');
const chalk = require('chalk');

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
  const bytecode = output.contracts['UsersContract.sol']['UsersContract'].evm.bytecode.object;
  const interface = JSON.stringify(output.contracts['UsersContract.sol']['UsersContract'].abi); //ABI --> application binary interface
  console.log(chalk.cyan(interface));
  console.log(chalk.green(bytecode));

