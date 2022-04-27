// SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

import "@solmate/tokens/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

abstract contract DemoNFT is ERC721, Ownable {
    uint256 public MAX_MINTS = 25;
    uint256 public MAX_SUPPLY = 1000;
    uint256 public mintRate = 0.05 ether;

    string public baseURI = "ipfs://bafybeieyetlp2c2vubffzjjap7utuz5jwo2k5b5kupvezfchc5tnfg4fh4/";

    constructor() ERC721("Demo NFT", "DMT") {}

    function mint(uint256 quantity) external payable {
        // _safeMint's second argument now takes in a quantity, not a tokenId.
        require(quantity <= MAX_SUPPLY, "Not enough tokens left");
        require(msg.value >= (mintRate * quantity), "Not enough ether sent");
        _safeMint(msg.sender, quantity);
    }

    function withdraw() external payable onlyOwner {
        payable(owner()).transfer(address(this).balance);
    }

    function _baseURI() internal view returns (string memory) {
        return baseURI;
    }

    function setBaseURI(string memory _newBaseUri) external onlyOwner {
        baseURI = _newBaseUri;
    }

    function setMintRate(uint256 _mintRate) public onlyOwner {
        mintRate = _mintRate;
    }
}
