pragma solidity >=0.8.0;

import "ds-test/test.sol";

contract DemoNftTest is DSTest {
    uint256 testNumber;

    function testMaxSupply() public {
        assertEq(testNumber, 42);
    }

    function testFailSubtract43() public {
        testNumber -= 43;
    }
}