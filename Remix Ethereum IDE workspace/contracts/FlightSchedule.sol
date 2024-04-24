// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract FlightSchedule {
    address public owner;
    struct Flight {
        string flightNumber;
        uint256 departureTime;
        uint256 arrivalTime;
        string origin;
        string destination;
        bool isScheduled;
    }

    mapping(string => Flight) public flights;

    function addFlight(
        string memory _flightNumber,
        uint256 _departureTime,
        uint256 _arrivalTime,
        string memory _origin,
        string memory _destination
    ) public {
        // Simple access control example, in real use consider more complex access control mechanisms
        require(msg.sender == owner, "Only the owner can add flights.");
        
        flights[_flightNumber] = Flight({
            flightNumber: _flightNumber,
            departureTime: _departureTime,
            arrivalTime: _arrivalTime,
            origin: _origin,
            destination: _destination,
            isScheduled: true
        });
    }

    function updateFlightStatus(string memory _flightNumber, bool _isScheduled) public {
        require(msg.sender == owner, "Only the owner can update flight status.");
        Flight storage flight = flights[_flightNumber];
        flight.isScheduled = _isScheduled;
    }

    function getFlightDetails(string memory _flightNumber) public view returns (Flight memory) {
        require(flights[_flightNumber].isScheduled, "Flight does not exist.");
        return flights[_flightNumber];
    }
}
