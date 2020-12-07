// SPDX-License-Identifier: None
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
}
