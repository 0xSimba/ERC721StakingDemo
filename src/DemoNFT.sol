// SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

import "@ERC721A/ERC721A.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/security/Pausable.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";

contract DemoNFT is ERC721A, Ownable, Pausable {
    using SafeMath for uint256;

    uint256 public MAX_MINTS = 10;
    uint256 public MAX_SUPPLY = 1000;
    uint256 public mintRate = 0.05 ether;

    string public _contractBaseURI;

    constructor(string memory baseURI) ERC721A("Demo NFT", "DMT") {
        _contractBaseURI = baseURI;
    }

    function mint(uint256 quantity) external payable {
        // _safeMint's second argument now takes in a quantity, not a tokenId.
        require(quantity > 0, "Quantity cannot be zero");
        uint totalMinted = totalSupply();
        require(quantity <= MAX_MINTS, "Cannot mint that many at once");
        require(totalMinted.add(quantity) < MAX_SUPPLY, "Not enough tokens left to mint");
        require(msg.value >= (mintRate * quantity), "Insufficient funds sent");
        _safeMint(msg.sender, quantity);
    }

    function withdraw() external payable onlyOwner {
        payable(owner()).transfer(address(this).balance);
    }

    function _baseURI() internal view override returns (string memory) {
        return _contractBaseURI;
    }

    function setMintRate(uint256 _mintRate) public onlyOwner {
        mintRate = _mintRate;
    }

    function pause() public onlyOwner {
        _pause();
    }

    function unpause() public onlyOwner {
        _unpause();
    }
}
