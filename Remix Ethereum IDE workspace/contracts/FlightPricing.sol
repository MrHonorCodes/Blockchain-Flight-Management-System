// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

contract FlightPricing {
    //address public owner;
    struct Price {
        uint256 economy;
        uint256 business;
        uint256 firstClass;
    }

    mapping(string => Price) public flightPrices;

    function setFlightPrice(
        string memory _flightNumber,
        uint256 _economy,
        uint256 _business,
        uint256 _firstClass
    ) public {
        // Access control
        //require(msg.sender == owner, "Only the owner can set prices.");

        flightPrices[_flightNumber] = Price({
            economy: _economy,
            business: _business,
            firstClass: _firstClass
        });
    }
    // Add a new function to get the price for a specific class
    function getFlightPrice(string memory _flightNumber, uint256 seatClass) public view returns (uint256) {
        Price memory prices = flightPrices[_flightNumber];
        if (seatClass == 0) {
            return prices.economy;
        } else if (seatClass == 1) {
            return prices.business;
        } else if (seatClass == 2) {
            return prices.firstClass;
        } else {
            revert("Invalid seat class.");
        }
    }
}
