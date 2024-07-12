// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "hardhat/console.sol";

contract DegenToken is ERC20, Ownable, ERC20Burnable {

    constructor() ERC20("Degen", "DGN") {}

    //mint tokens, accessible by the owner
    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }
    function decimals() override public pure returns (uint8){
        return 0;
    }
    //check balance, accessible by anyone
    function getBalance() external view returns (uint256){   
        return this.balanceOf(msg.sender);
    }
    //transfer tokens, accessible by anyone
    function transferTokens(address _receiver, uint256 _value) external{
        require(balanceOf(msg.sender) >= _value, "You do not have enough Degen Tokens.");
        approve(msg.sender, _value);
        transferFrom(msg.sender, _receiver, _value);
    }
    //burn tokens, accessible by the owner
    function burnTokens(uint256 _value) view  external onlyOwner {
        require(balanceOf(msg.sender) >= _value, "You do not have enough Degen Tokens.");
    }
    //displays store items
    function showStoreItems() external pure returns (string memory){
        return "1. Official Degen NFT - 100 tokens 2. Official Degen T-Shirt - 85 tokens 3. Official Degen Deskmat - 95 tokens";
    }
    //redeem tokens, accessible by players
    function redeemTokens(uint8 _choice) external {
        require(_choice >= 1 && _choice <= 3, "Invalid selection.");

        uint256 userBalance = balanceOf(msg.sender);
        uint256 amountToDeduct;

         if(_choice == 1){
            amountToDeduct = 100;
        } else if(_choice == 2){
            amountToDeduct = 85;
        } else if(_choice == 3){
            amountToDeduct = 95;
        }
        require(userBalance >= amountToDeduct, "You do not have enough Degen Tokens.");
        _burn(msg.sender, amountToDeduct);
    }

}

