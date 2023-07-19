// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/interfaces/IERC721.sol";
import "@openzeppelin/contracts/interfaces/IERC721Metadata.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

// Uncomment this line to use console.log
// import "hardhat/console.sol";

contract NFT is Ownable, ERC721 {
    mapping (uint256 => string) public tokenURIs;

    constructor (string memory name_, string memory symbol_) Ownable() ERC721(name_, symbol_) {
    }

    function withdraw() public onlyOwner {
        bool sent = payable(owner()).send(address(this).balance);
        require(sent, "Failed to send Ether");
    }

    function tokenURI(uint256 tokenId_) public override view virtual returns (string memory) {
        return tokenURIs[tokenId_];
    }

    function setTokenURI(string memory uri, uint256 tokenId_) public onlyOwner {
        tokenURIs[tokenId_] = uri;
    }

    function mint(address to_, uint256 tokenId_) public onlyOwner {
        _safeMint(to_, tokenId_);
    }
}
