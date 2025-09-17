// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

//Get funds from users
//Withdraw funds
//Set min funding value in USD
import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

contract FundMe {

    uint256 public minUSD = 50;

    function fund() public payable {
        //Min Fund amount in USD
        require(msg.value >= minUSD, "Send me more"); // 1e18 == 1 * 10 ** 18 == 1000000000000000000
    }

    function getPrice() public view returns (uint256) {
        //ABI
        //Address - 0x694AA1769357215DE4FAC081bf1f309aDC325306
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);

        (, int256 price, , ,) = priceFeed.latestRoundData();
        // ETH in USD
        return uint256(price * 1e10);
    }

    function getConversionRate(uint ethAmount) public view returns (uint256) {
        uint ethPrice = getPrice();
        uint ethAmountInUSD = (ethPrice * ethAmount) / 1e18;
        return ethAmountInUSD;
    }

    //function withdraw(){}
}