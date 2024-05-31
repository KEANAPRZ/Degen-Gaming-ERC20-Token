// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

// This contract implements the ERC20 standard for tokens and includes the Ownable contract from OpenZeppelin for access control.
contract DegenToken is ERC20, Ownable {
  
  // The redemption cost for magic is set to 100 tokens per unit of magic.
  uint256 public constant REDEMPTION_COST = 100;

  // This mapping keeps track of the address that redeemed the magic (key) and the amount of magic owned (value).
  mapping(address => uint256) public magicOwnedBy; // Changed name for clarity

  // The constructor initializes the contract with an initial supply of tokens for the contract creator.
  constructor() 
    ERC20("Degen", "DGN") Ownable(msg.sender) {
    _mint(msg.sender, 10 * (10 ** uint256(decimals())));
  }

  // This function allows users to redeem their DegenTokens for a "powerful magic" at a cost of 100 tokens per unit of magic.
  // The function burns the tokens and updates the user's magic balance in the `magicOwnedBy` mapping.
  function redeemMagic(uint256 quantity) public {
    uint256 cost = REDEMPTION_COST * quantity;
    require(balanceOf(msg.sender) >= cost, "Your token is not enough tokens to redeem for a powerful magic");

    magicOwnedBy[msg.sender] += quantity;
    _burn(msg.sender, cost);
  }

  // This function returns the amount of magic owned by a specified address (considering the mapped redeemer).
  function checkMagicOwned(address user) public view returns (uint256) {
    return magicOwnedBy[user];
  }

  // This function allows the contract owner to assign the redeemed magic (stored in magicOwned) to a designated recipient address.
  function grantMagic(address recipient, uint256 amount) public onlyOwner {
    require(magicOwnedBy[msg.sender] >= amount, "Insufficient redeemed magic to grant");
    magicOwnedBy[msg.sender] -= amount;
    magicOwnedBy[recipient] += amount;
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
    require(balanceOf(msg.sender) >= amount, "Your token is not enough tokens to burn");
    _burn(msg.sender, amount);
  }

  // This function allows users to transfer their tokens to another address.
  function transferTokens(address to, uint256 amount) public {
    require(to != address(0), "Your address is invalid ");
    require(balanceOf(msg.sender) >= amount, "Your token is not enough tokens to transfer");
    _transfer(msg.sender, to, amount);
  }
}
