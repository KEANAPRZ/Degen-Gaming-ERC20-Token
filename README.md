# Degen-Gaming-ERC20-Token
Forth Module Assement For MetaCrafters ETH + AVAX PROOF: Intermediate EVM Course

# Description
DegenToken is an ERC20-compliant token implemented in Solidity. It leverages OpenZeppelin's libraries for standard functionalities and includes additional features for token redemption, minting, burning, and balance checking.

# Getting Started
To run this program, you can use Remix, an online Solidity IDE. To get started, go to the Remix website at https://remix.ethereum.org/.

Once you are on the Remix website, create a new file by clicking on the "+" icon in the left-hand sidebar. Save the file with a .sol extension (e.g., DegenToken.sol). Copy and paste the following code into the file:
       
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
    constructor() 
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

To compile the code, click on the "Solidity Compiler" tab in the left-hand sidebar. Make sure the "Compiler" option is set to "0.8.23" (or another compatible version), and then click on the "Compile DegenToken.sol" button.

Once the code is compiled, you can deploy the contract by clicking on the "Deploy & Run Transactions" tab in the left-hand sidebar. Select the "DegenToken" contract from the dropdown menu, and then click on the "Deploy" button.

Once the contract is deployed, you can interact with it.

# Features
* ERC20 Standard: Implements the ERC20 token standard for fungible tokens.
* Ownable: Access control using OpenZeppelin's Ownable contract.
* Token Redemption: Users can redeem tokens for "magic" at a specified cost.
* Minting: Only the contract owner can mint new tokens.
* Burning: Users can burn their tokens to remove them from circulation.
* Balance Checking: Functions to check the balance of tokens or magic owned.

#  Functions
* redeemMagic(uint256 quantity): This function allows users to redeem their DegenTokens for a "powerful magic" at a cost of 100 tokens per unit of magic. The function burns * the tokens and updates the user's magic balance in the magicOwned mapping.
* checkMagicOwned(address user): This function returns the amount of magic owned by the specified user.
* mintTokens(address to, uint256 amount): This function allows the contract owner to mint new tokens and send them to a specified address.
* checkBalance(address account): This function returns the balance of tokens owned by the specified address.
* burnTokens(uint256 amount): This function allows users to burn their tokens, removing them from circulation.
* transferTokens(address to, uint256 amount): This function allows users to transfer their tokens to another address.

# Authors
Keana Aliza C. Perez

Student of National Trachers College - BSIT
