// SPDX-License-Identifier: MIT
pragma solidity >0.4.23;

contract Airline{
    address public owner;
    
    struct Customer {
        uint loyaltyPoints;
        uint totalFlights;
    }

    struct Flight {
        string name;
        uint price;
    }

    uint etherPerPoint = 0.5 ether;
    uint pointsPerPurchase = 5;
    
    Flight[] public flights;

    mapping(address => Customer) public customers;
    mapping(address => Flight[]) public customerFlights;
    mapping(address => uint) public customerTotalFlights;

    event FlightPurchased(address indexed customer, uint price);    //Evento que se emite cuando se compra un vuelo 
    
    constructor() public {
        owner = msg.sender;
        
        flights.push(Flight('Tokio', 4 ether));
        flights.push(Flight('Barcelona', 3 ether));
        flights.push(Flight('London', 3 ether));
        flights.push(Flight('Berlin', 4 ether));
        flights.push(Flight('Moscow', 5 ether));
    }
    
    function buyFlight(uint flightIndex) public payable {
        Flight storage flight = flights[flightIndex];
        require(msg.value == flight.price);

        Customer storage customer = customers[msg.sender];
        customer.loyaltyPoints += pointsPerPurchase;
        customer.totalFlights += 1;
        customerFlights[msg.sender].push(flight);
        customerTotalFlights[msg.sender] ++;

        emit FlightPurchased(msg.sender, flight.price);
    }

    function totalFlights() public view returns (uint){
        return flights.length;
    } 

    function redeemLoyaltyPoints() public {
        Customer storage customer = customers[msg.sender];
        uint etherToRefund = customer.loyaltyPoints * etherPerPoint;
        msg.sender.transfer(etherToRefund);
        customer.loyaltyPoints = 0;
    }

    function getRefundableEther() public view returns(uint){
        return etherPerPoint * customers[msg.sender].loyaltyPoints;
    }

    function getAirlineBalance() public isOwner view returns(uint) {
    
        address airlineAddress = address(this);
        return airlineAddress.balance;
    }

    modifier isOwner(){
        require(msg.sender == owner);
        _;
    }
}