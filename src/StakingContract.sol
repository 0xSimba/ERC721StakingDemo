// SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

import "@openzeppelin/contracts/token/ERC721/IERC721Receiver.sol";
import "./DemoNft.sol";
import "./RewardsToken.sol";

contract StakingContract is IERC721Receiver {
    DemoNFT parentNFT;
    RewardsToken rewardsToken;

    struct Stake {
        uint256 tokenId;
        uint256 amount;
        uint256 timestamp;
    }
    
    uint256 private rewardRate = 100000;

    // map staker address to stake details
    mapping (address => Stake) public stakes;

    // map staker total staking time
    mapping (address => uint256) public stakingTime;

    event NFTStaked(address owner, uint256 tokenId, uint256 value);
    event NFTUnstaked(address owner, uint256 tokenId, uint256 value);
    event Claimed(address owner, uint256 amount);

    constructor(DemoNFT _parentNFT, RewardsToken _rewardsToken) {
        parentNFT = _parentNFT;
        rewardsToken = _rewardsToken;
    }

    function stake(uint256 _tokenId, uint256 _amount) public {
        stakes[msg.sender] = Stake(_tokenId, _amount, block.timestamp);
        parentNFT.safeTransferFrom(msg.sender, address(this), _tokenId);
        emit NFTStaked(msg.sender, _tokenId, _amount);
    }

    function unstake() public {
        parentNFT.safeTransferFrom(address(this), msg.sender, stakes[msg.sender].tokenId);
        stakingTime[msg.sender] += (block.timestamp - stakes[msg.sender].timestamp);
        delete stakes[msg.sender];
    }

    function onERC721Received(
    address, 
    address, 
    uint256, 
    bytes calldata
    ) external override pure returns(bytes4) {
    return bytes4(keccak256("onERC721Received(address,address,uint256,bytes)"));
    }
}