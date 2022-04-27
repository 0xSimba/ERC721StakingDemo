// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "ds-test/test.sol";
import "../SpritelyGenesis.sol";

contract SpritelyGenesisTest is DSTest {
    uint8 public constant DECIMALS = 18;
    int256 public constant INITIAL_ANSWER = 1 * 10**18;
    SpritelyNFT public spritelyNFT;

    function setUp() public {
        spritelyNFT = new SpritelyNFT();
    }

    function test_is_sale_active() public {
        bool saleIsActive = spritelyNFT.saleIsActive();
        assertTrue(saleIsActive);
    }
}
