const assert = require('assert');
const AssertionError = require('assert').AssertionError;
const Web3 = require('web3');

const provider = new Web3.providers.HttpProvider("HTTP://127.0.0.1:7545");
const web3 = new Web3(provider);

const compile = require('../scripts/compile');

const bytecode = compile.evm.bytecode.object;
const interface = JSON.stringify(compile.abi); //ABI --> application binary interface

let accounts;
let usersContract;

beforeEach(async() => {
    accounts = await web3.eth.getAccounts();
    usersContract = await new web3.eth.Contract(JSON.parse(interface))
                                      .deploy({data: bytecode})
                                      .send({from: accounts[0], gas:'1000000'});
});

describe('The UsersContract', async() => {
    it('should deploy', () => {
        assert.ok(usersContract.options.address);
    });

    it('should join a user', async () => {
        let name = "Juan";
        let surname = "Barba";
        
        await usersContract.methods.join(name, surname)
            .send({from: accounts[0], gas:'1000000'});
    });

    it('should retrieve a user', async () => {
        let name = "Juan";
        let surname = "Barba";
    
        await usersContract.methods.join(name, surname)
            .send({from: accounts[0], gas:'1000000'});

        let user = await usersContract.methods.getUser(accounts[0])
                         .call();

        assert.strictEqual(name, user[0]);
        assert.strictEqual(surname,user[1]);
    });

    it('should not allow joining an account twice', async () => {
        await usersContract.methods.join("Juan", "Barba")
              .send({from: accounts[2], gas:'1000000'});
        
        try{
            
            await usersContract.methods.join("Juan", "Barba")
                  .send({from: accounts[2], gas:'1000000'});
            assert.fail("same account can't join twice");
        }
        catch(e) {
            if(e instanceof AssertionError){
                assert.fail(e.message);
            }   
        }
    });

    it('should not allow retrieving a not registered user',async() => {

        try {   
            let user = await usersContract.methods.getUser(accounts[1]).call();
            assert.fail('user should not be registered');
        }
        catch (e) {
            if (e instanceof AssertionError) {
                assert.fail(e.message);
            }
        }
    });

    it('should retrieve total registered users', async () => {
        
        await usersContract.methods.join("Juan", "Barba")
            .send({from: accounts[0], gas:'1000000'});

        
        await usersContract.methods.join("Ana", "Albesa")
            .send({from: accounts[1], gas:'1000000'});
    
        let totalusers = await usersContract.methods.totalUsers()
                            .call();
        
        assert.strictEqual(totalusers,'2');
    });

});


