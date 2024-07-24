// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";

contract DegenToken is ERC20, Ownable, ERC20Burnable {
    string[] private items = [
        "Official Degen NFT",
        "Official Degen T-Shirt",
        "Official Degen Deskmat"
    ];

    mapping(string => uint256) public itemPrices;
    mapping(address => string) public redeemedItems;

    constructor() ERC20("Degen", "DGN") {
        itemPrices["Official Degen NFT"] = 100;
        itemPrices["Official Degen T-Shirt"] = 85;
        itemPrices["Official Degen Deskmat"] = 95;
    }

    function decimals() override public pure returns (uint8) {
        return 0;
    }

    // Mint tokens, accessible by the owner
    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }

    // Check balance, accessible by anyone
    function getBalance() external view returns (uint256) {
        return balanceOf(msg.sender);
    }

    // Transfer tokens, accessible by anyone
    function transferTokens(address receiver, uint256 value) external {
        require(balanceOf(msg.sender) >= value, "You do not have enough Degen Tokens.");
        _transfer(msg.sender, receiver, value);
    }

    // Burn tokens, accessible by the owner
    function burnTokens(uint256 value) external onlyOwner {
        require(balanceOf(msg.sender) >= value, "You do not have enough Degen Tokens.");
        _burn(msg.sender, value);
    }

    // Displays store items
    function showStoreItems() external pure returns (string memory) {
        return "1. Official Degen NFT - 100 tokens 2. Official Degen T-Shirt - 85 tokens 3. Official Degen Deskmat - 95 tokens";
    }

    // Redeem tokens, accessible by players
    function redeemTokens(string memory itemName) external {
        require(itemPrices[itemName] > 0, "Item does not exist.");

        uint256 itemPrice = itemPrices[itemName];
        require(balanceOf(msg.sender) >= itemPrice, "You do not have enough Degen Tokens.");
        _burn(msg.sender, itemPrice);
        redeemedItems[msg.sender] = itemName;
    }

    function getRedeemedItem(address account) external view returns (string memory) {
        return redeemedItems[account];
    }
}
