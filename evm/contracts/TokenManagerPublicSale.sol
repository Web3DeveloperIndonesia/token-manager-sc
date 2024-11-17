// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./TokenManagerToken.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract TokenManagerPublicSale is Ownable {
    TokenManagerToken public token;
    uint256 public publicSalePrice;

    constructor(TokenManagerToken _token, uint256 _publicSalePrice) {
        token = _token;
        publicSalePrice = _publicSalePrice;
    }

    // Fungsi untuk membeli token dalam public sale
    function buyTokens() external payable {
        uint256 tokensToBuy = msg.value / publicSalePrice;
        token.mint(msg.sender, tokensToBuy);
    }

    // Menarik dana yang dikumpulkan ke alamat pemilik kontrak
    function withdrawFunds() external onlyOwner {
        payable(owner()).transfer(address(this).balance);
    }
}
