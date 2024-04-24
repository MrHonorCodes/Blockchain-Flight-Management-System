// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

import "./FlightPricing.sol"; // Import the FlightPricing contract

contract PlaneTicket {
    address payable public ticketHolder;
    FlightPricing public flightPricingContract; // Reference to the FlightPricing contract
    string public flightNumber;
    enum Statuses { Available, Taken } 
    Statuses public currentStatus;

    // Constructor now takes the address of the FlightPricing contract
    // and the flight number for which this ticket is valid
    constructor(address _flightPricingContract, string memory _flightNumber) {
        ticketHolder = payable(msg.sender);
        flightPricingContract = FlightPricing(_flightPricingContract); // Initialize the reference
        flightNumber = _flightNumber;
        currentStatus = Statuses.Available;
    }
    
    function bookTicket(uint256 seatClass) external payable {
        require(currentStatus == Statuses.Available, "Seat is taken.");

        // Get the price for the specific class (0 for economy, 1 for business, 2 for first class)
        uint price = flightPricingContract.getFlightPrice(flightNumber, seatClass);

        require(msg.value == price, "Please send the exact ticket price.");

        currentStatus = Statuses.Taken;
        ticketHolder.transfer(msg.value);
    }
}
