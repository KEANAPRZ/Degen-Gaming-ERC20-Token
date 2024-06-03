// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

// This contract implements the ERC20 standard for tokens and includes the Ownable contract from OpenZeppelin for access control.
contract DegenToken is ERC20, Ownable {
  
  // The redemption cost for magic is set to 100 tokens per unit of magic.
  uint256 public constant REDEMPTION_COST = 100;

  // Enumeration for different types of magic
  enum MagicType { FIRE, ICE, WATER, EARTH, WIND }// 1,2,3,4,5 id of ff

  // This mapping keeps track of the address that redeemed the magic (key) and the amount of each type of magic owned (value).
  mapping(address => mapping(MagicType => uint256)) public magicOwnedBy;

  // The constructor initializes the contract with an initial supply of tokens for the contract creator.
  constructor() 
    ERC20("Degen", "DGN")
    Ownable(msg.sender) // Pass msg.sender as the initial owner to the Ownable constructor
  {
    _mint(msg.sender, 10 * (10 ** uint256(decimals())));
  }

  // This function allows users to redeem their DegenTokens for a specified type of magic at a cost of 100 tokens per unit of magic.
  // The function burns the tokens and updates the user's magic balance in the `magicOwnedBy` mapping.
  function redeemMagic(MagicType magicType, uint256 quantity) public {
    uint256 cost = REDEMPTION_COST * quantity;
    require(balanceOf(msg.sender) >= cost, "Your token balance is not enough to redeem for a powerful magic");

    magicOwnedBy[msg.sender][magicType] += quantity;
    _burn(msg.sender, cost);
  }

  // This function returns the amount of a specific type of magic owned by a specified address.
  function checkMagicOwned(address user, MagicType magicType) public view returns (uint256) {
    return magicOwnedBy[user][magicType];
  }

  // This function allows the contract owner to assign the redeemed magic (stored in magicOwnedBy) to a designated recipient address.
  function grantMagic(address recipient, MagicType magicType, uint256 amount) public onlyOwner {
    require(magicOwnedBy[msg.sender][magicType] >= amount, "Insufficient redeemed magic to grant");
    magicOwnedBy[msg.sender][magicType] -= amount;
    magicOwnedBy[recipient][magicType] += amount;
  }

  // This function allows the contract owner to mint new tokens and send them to a specified address (for potential magic redemption).
  function mintForRedemption(address to, uint256 amount) public onlyOwner {
    _mint(to, amount);
  }

  // This function allows the contract owner to mint new tokens and send them to a specified address.
  function mintTokens(address to, uint256 amount) public onlyOwner {
    _mint(to, amount);
  }

  // This function returns the balance of tokens owned by the specified address.
  function checkBalance(address account) public view returns (uint256) {
    return balanceOf(account);
  }

  // This function allows users to burn their tokens, removing them from circulation.
  function burnTokens(uint256 amount) public {
    require(balanceOf(msg.sender) >= amount, "Your token balance is not enough to burn");
    _burn(msg.sender, amount);
  }

  // This function allows users to transfer their tokens to another address.
  function transferTokens(address to, uint256 amount) public {
    require(to != address(0), "The address is invalid");
    require(balanceOf(msg.sender) >= amount, "Your token balance is not enough to transfer");
    _transfer(msg.sender, to, amount);
  }
}
