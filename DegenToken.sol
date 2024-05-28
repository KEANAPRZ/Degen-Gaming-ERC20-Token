// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

// This contract implements the ERC20 standard for tokens and includes the Ownable contract from OpenZeppelin for access control.
contract DegenToken is ERC20, Ownable {

  // The redemption cost for magic is set to 100 tokens per unit of magic.
    uint256 public constant REDEMPTION_COST = 100;

    // This mapping keeps track of the amount of magic owned by each user.
    mapping(address => uint256) public magicOwned;

 // The constructor initializes the contract with an initial supply of tokens for the contract creator.
constructor ()
ERC20("Degen", "DGN") Ownable(msg.sender) {
        _mint(msg.sender, 10 * (10 ** uint256(decimals())));
    }
 // This function allows users to redeem their DegenTokens for a "powerful magic" at a cost of 100 tokens per unit of magic.
    // The function burns the tokens and updates the user's magic balance in the `magicOwned` mapping.
    function redeemMagic(uint256 quantity) public {
        uint256 cost = REDEMPTION_COST * quantity;
        require(balanceOf(msg.sender) >= cost, "Your token is not enough tokens to redeem for a powerful magic");

        magicOwned[msg.sender] += quantity;
        _burn(msg.sender, cost);
    }

 // This function returns the amount of magic owned by the specified user.
    function checkMagicOwned(address user) public view returns (uint256) {
        return magicOwned[user];
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

