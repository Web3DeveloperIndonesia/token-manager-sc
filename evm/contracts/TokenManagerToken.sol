// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

// Kontrak token yang akan dibuat user melalui Token Manager
contract UserToken is ERC20, Ownable {
    constructor(string memory name, string memory symbol, uint256 initialSupply, address owner) ERC20(name, symbol) {
        _mint(owner, initialSupply * 10 ** decimals());
        transferOwnership(owner);
    }
}

// Kontrak untuk membuat token baru
contract TokenManagerFactory is Ownable {
    event TokenCreated(address indexed creator, address tokenAddress);

    function createToken(string memory name, string memory symbol, uint256 initialSupply) external {
        // Membuat kontrak token baru untuk user
        UserToken newToken = new UserToken(name, symbol, initialSupply, msg.sender);
        emit TokenCreated(msg.sender, address(newToken));
    }
}
