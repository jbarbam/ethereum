// SPDX-License-Identifier: None
pragma solidity >=0.7.0 <0.8.0;

contract Ownable {
 
    address private owner;
 
    constructor() {
        owner = msg.sender;
    }
    
    modifier isOwner(){
        require(owner == msg.sender);
        _;
    }
    
}