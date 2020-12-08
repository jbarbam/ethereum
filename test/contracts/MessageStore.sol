// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.8.0;

import "./Ownable.sol";

contract MessageStore is Ownable{
    
    string private message;
    
    function setMessage(string memory newMessage) public payable {
        require(msg.value >= 3 ether);
        message = newMessage;
    }
    
    function getMessage() public view returns(string memory) {
        return message;
    }
    
    function getBalance() public view returns (uint) {
        return address(this).balance;
    }
    
    function getBalanceInEther() public view returns(uint) {
        return getBalance() / 1e18;
    }
    
    function transfer(uint amount) public isOwner {
        require(getBalance() >= amount);
        owner.transfer(amount);
    }
    
    function transferTo(uint amount, address payable accountTo) public isOwner {
        require(getBalance() >= amount);
        require(accountTo != address(0));
        accountTo.transfer(amount);
    }
}
