// SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

import "@std/Test.sol";
import "./utils/Cheats.sol";
import "../SpritelyGenesis.sol";

contract SpritelyGenesisTest is Test {
    Cheats internal constant cheats = Cheats(HEVM_ADDRESS);
    uint8 public constant DECIMALS = 18;
    int256 public constant INITIAL_ANSWER = 1 * 10**18;
    SpritelyNFT public spritelyNFT;
    //StakingContract public stakingContract;

    function setUp() public {
        spritelyNFT = new SpritelyNFT();
        //stakingContract = new StakingContract();
    }

    function test_sale_is_active() public {
        spritelyNFT.setSaleIsActive(true);
        bool saleIsActive = spritelyNFT.saleIsActive();
        assertTrue(saleIsActive);
    }

    // function test_mint(uint num) public {
    //     spritelyNFT.mint(num);
    // }
}
