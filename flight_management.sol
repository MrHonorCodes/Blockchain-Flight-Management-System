// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract FlightManagementSystem {
    struct Flight {
        string flightNumber;
        uint256 departureTime;
        uint256 arrivalTime;
        uint256 price;
        uint seatsAvailable;
    }

    mapping(string => Flight) public flights;

    // Event to emit when a flight is booked
    event FlightBooked(address indexed user, string flightNumber, uint256 price);

    // Function to add a flight to the system
    function addFlight(string memory _flightNumber, uint256 _departureTime, uint256 _arrivalTime, uint256 _price, uint _seatsAvailable) public {
        flights[_flightNumber] = Flight(_flightNumber, _departureTime, _arrivalTime, _price, _seatsAvailable);
    }

    // Function to book a flight
    function bookFlight(string memory _flightNumber) public payable {
        Flight storage flight = flights[_flightNumber];
        
        require(flight.seatsAvailable > 0, "No seats available for this flight");
        require(msg.value == flight.price, "Incorrect payment amount");
        
        flight.seatsAvailable--;
        emit FlightBooked(msg.sender, _flightNumber, flight.price);
    }

    // Function to get flight details
    function getFlightDetails(string memory _flightNumber) public view returns (Flight memory) {
        return flights[_flightNumber];
    }
}
