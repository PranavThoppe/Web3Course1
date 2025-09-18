// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

import "contracts/PriceConvertor.sol";

//Get funds from users
//Withdraw funds
//Set min funding value in USD

contract FundMe {
    using PriceConvertor for uint256;

    uint256 public minUSD = 50 * 1e18;
    address[] public funders;
    mapping(address => uint256) public addressToAmountFunded;

    address public owner;

    constructor(){
        owner = msg.sender;
    }

    function fund() public payable {
        //Min Fund amount in USD
        
        require(msg.value.getConversionRate() >= minUSD, "Send me more"); // 1e18 == 1 * 10 ** 18 == 1000000000000000000
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] = msg.value;
    }



    function withdraw() public onlyOwner {
        for (uint256 i = 0; i <= funders.length; i++) 
        {
            address funder = funders[i];
            addressToAmountFunded[funder] = 0;
            payable(funder).transfer(address(this).balance);
            funders = new address[](0);
       
            //transfer
            //send
            //call
        }
    }

    modifier onlyOwner {
        require(msg.sender == owner, "Sender is not owner");
        _;
    }


}