// SPDX-License-Identifier: MIT

pragma solidity ^0.8.4;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v4.6/contracts/token/ERC20/ERC20.sol";


contract GameOfToken is ERC20 {
    constructor(uint256 initialSupply) ERC20("GameOfToken","GOT"){
   
        _mint(msg.sender, initialSupply);

    }
        
}