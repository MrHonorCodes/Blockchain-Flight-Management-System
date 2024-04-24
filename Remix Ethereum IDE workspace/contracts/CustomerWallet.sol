// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

contract CustomerWallet {
    address public owner;

    event FundsDeposited(address indexed depositor, uint amount);
    event FundsWithdrawn(address indexed withdrawer, uint amount);

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "You are not the owner.");
        _;
    }

    receive() external payable {
        emit FundsDeposited(msg.sender, msg.value);
    }

    function withdraw(uint amount) public onlyOwner {
        require(address(this).balance >= amount, "Insufficient balance.");
        payable(owner).transfer(amount);
        emit FundsWithdrawn(msg.sender, amount);
    }

    function getBalance() public view returns (uint) {
        return address(this).balance;
    }
}
