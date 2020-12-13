// SPDX-License-Identifier: MIT
pragma solidity ^0.7.5;

contract UsersContract {
    struct User {
        string name;
        string surname;
    }

    mapping(address => User) private users;
    mapping(address => bool) private joinedUsers;
    address[] private total;

    function join(string memory name, string memory surname) public {    
        require(!userJoined(msg.sender));
        User storage user = users[msg.sender];
        user.name = name;
        user.surname = surname;
        joinedUsers[msg.sender] = true;
        total.push(msg.sender);
    }

    function getUser(address addr) public view returns (string memory, string memory) {
        require(userJoined(msg.sender));
        User memory user = users[addr];
        return (user.name, user.surname);
    }

    function  userJoined(address addr) private view returns(bool) {
        return joinedUsers[addr];
    }

    function totalUsers() public view returns (uint) {
        return total.length;
    }
}