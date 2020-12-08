// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.8.0;
    
contract Ownable {
     
    address payable internal owner;
     
    constructor() {
        owner = msg.sender;
    }
        
    modifier isOwner(){
        require(owner == msg.sender);
        _;
    }
}