// SPDX-License-Identifier: None
pragma solidity >=0.7.0 <0.8.0;

contract MessageStore {
    
    address private owner;
    
    constructor() {
        owner = msg.sender;
    } 
}
