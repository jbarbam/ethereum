import Web3 from 'web3';
import Web3Provider from 'react-web3-provider';

const getWeb3 = () => {
    return new Promise((resolve, reject)=>{
        window.addEventListener('load', function(){
            let web3 = window.web3;

            if(typeof web3 !== undefined){
                web3 = new Web3(web3.currentProvider);
                resolve(web3);
            }
            else {n
                console.error("No provider found, please install Metamask");
                reject();
            }
        });
    });
};

export default getWeb3;