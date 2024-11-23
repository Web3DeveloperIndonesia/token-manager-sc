// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./TokenManagerToken.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract TokenManagerPrivateSale is Ownable {
    TokenManagerToken public token;
    uint256 public privateSalePrice;
    mapping(address => bool) public whitelist;

    constructor(TokenManagerToken _token, uint256 _privateSalePrice) {
        token = _token;
        privateSalePrice = _privateSalePrice;
    }

    // Fungsi untuk menambahkan alamat ke whitelist
    function addToWhitelist(address _user) external onlyOwner {
        whitelist[_user] = true;
    }

    // Fungsi pembelian token selama private sale
    function buyTokens() external payable {
        require(whitelist[msg.sender], "Not whitelisted for private sale");
        uint256 tokensToBuy = msg.value / privateSalePrice;
        token.mint(msg.sender, tokensToBuy);
    }

    // Mengambil dana yang dikumpulkan ke alamat pemilik kontrak
    function withdrawFunds() external onlyOwner {
        payable(owner()).transfer(address(this).balance);
    }
}
