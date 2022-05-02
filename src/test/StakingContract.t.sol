pragma solidity >=0.8.0;

import "ds-test/test.sol";
import "@std/Vm.sol";
import "../StakingContract.sol";
import "../RewardsToken.sol";

contract StakingContractTest is DSTest {
    Vm vm = Vm(HEVM_ADDRESS);

    address bob = address(0x12345);
    address dylan = address(0x67890);

    event NFTStaked(address owner, uint256 tokenId, uint256 value);

    StakingContract public stakeContract;
    DemoNFT public nftToken;
    RewardsToken public rewardsToken;
    
    function setup() public {
        vm.label(bob, "Bob");
        vm.label(dylan, "Dylan");
        vm.label(address(this), "Test Staking Contract");

        nftToken = new DemoNFT("ipfs://bafybeieyetlp2c2vubffzjjap7utuz5jwo2k5b5kupvezfchc5tnfg4fh4/");
        rewardsToken = new RewardsToken("Test Token", "TT");
        stakeContract = new StakingContract(nftToken, rewardsToken);
    }

    function test_can_stake_tokens(uint256 amount) public {
        vm.expectEmit(true, true, true, true);
        nftToken.approve(address(this), amount);
        stakeContract.stake(1, amount);
        
    }
}