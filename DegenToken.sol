// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract DegenToken is ERC20, Ownable {

  // Magic types id 1234
  enum Claimables {HELMET, GAUNTLET, JEWELRY, FOOD}

  mapping(Claimables => uint256) public prices;

  mapping(address => mapping(Claimables => uint256)) public claimablesOf;

  constructor() ERC20("Degen", "DGN") Ownable(msg.sender) {
    _mint(msg.sender, 10 * (10 ** decimals()));
    // price with dif. amount
    prices[Claimables.HELMET] = 100;
    prices[Claimables.GAUNTLET] = 150;
    prices[Claimables.JEWELRY] = 200;
    prices[Claimables.FOOD] = 50;
  }

  function redeem(Claimables claimable, uint256 quantity) public {
    uint256 totalPrice = prices[claimable] * quantity;
    require(balanceOf(msg.sender) >= totalPrice, "Insufficient balance for redemption");
    _burn(msg.sender, totalPrice);
    claimablesOf[msg.sender][claimable] += quantity;
  }

  function grant(address recipient, Claimables claimable, uint256 quantity) public onlyOwner {
    require(claimablesOf[msg.sender][claimable] >= quantity, "Insufficient claimables to grant");
    claimablesOf[msg.sender][claimable] -= quantity;
    claimablesOf[recipient][claimable] += quantity;
  }

  function mint(address to, uint256 amount) public onlyOwner {
    _mint(to, amount);
  }

  function burn(uint256 amount) public {
    _burn(msg.sender, amount);
  }

  function transferTo(address to, uint256 amount) public {
    _transfer(msg.sender, to, amount);
  }
}
