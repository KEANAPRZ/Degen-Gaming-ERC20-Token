// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract DegenToken is ERC20, Ownable {

  uint256 public constant price = 100;

  // Magic types id 1234
  enum Claimables {HELMET, GAUNTLET, JEWLREY, FOOD}

  mapping(address => mapping(Claimables => uint256)) public Claimables_of;

  constructor() ERC20("Degen", "DGN") Ownable(msg.sender) {
    _mint(msg.sender, 10 * (10 ** decimals()));
  }

  function redeem(Claimables claimables, uint256 quantity) public {
    require(balanceOf(msg.sender) >= price, "Insufficient balance for magic redemption");
    Claimables_of[msg.sender][claimables] += quantity;
  }

  function grant(address recipient, Claimables claimables, uint256 quantity) public onlyOwner {
    require(Claimables_of[msg.sender][claimables] >= quantity);
   Claimables_of[msg.sender][claimables] -= quantity;
    Claimables_of[recipient][claimables] += quantity;
  }

  function mint(address to, uint256 amount) public onlyOwner {
    _mint(to, amount);
  }

  function burn(uint256 amount) public {
    _burn(msg.sender, amount);
  }

  function transferto(address to, uint256 amount) public {
    _transfer(msg.sender, to, amount);
  }
}
