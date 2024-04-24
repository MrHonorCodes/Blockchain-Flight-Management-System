// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

contract AirlineManagement {
    address public admin;

    struct Flight {
        string flightNumber;
        uint price;
        bool isActive;
    }

    mapping(string => Flight) public flights;

    constructor() {
        admin = msg.sender;
    }

    modifier onlyAdmin() {
        require(msg.sender == admin, "Unauthorized: Only admin can perform this action.");
        _;
    }

    function addFlight(string memory flightNumber, uint price) public onlyAdmin {
        flights[flightNumber] = Flight(flightNumber, price, true);
    }

    function updateFlightStatus(string memory flightNumber, bool isActive) public onlyAdmin {
        flights[flightNumber].isActive = isActive;
    }

    function getFlightDetails(string memory flightNumber) public view returns (Flight memory) {
        return flights[flightNumber];
    }
}
