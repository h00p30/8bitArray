// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Test} from "forge-std/Test.sol";

interface I8bitArray {
    function testBitmask(uint8) external view returns (bytes32);

    function testNumberOffset(uint8, uint8) external view returns (bytes32);

    function testNumberWrite(uint8, uint8) external returns (bytes32);

    function testNumberRead(uint8) external returns (bytes32);
}

contract ArrayTest is Test {
    address internal huff;

    function setUp() external {
        address _huff;
        bytes
            memory huffCode = hex"6100d18061000d6000396000f360003560E01c8063d507330414610032578063a025579314610067578063810bcd901461007b57806341279ea3146100ba575b60043560031b60ff901b7fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff1860005260206000f35b6004356024356101000a0260005260206000f35b602435600435816101000a029060031b60ff901b7fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff1860005416186000555b600435600802600054901c60ff1660005260206000f3";
        bytes32 salt = keccak256(abi.encode(1));
        assembly {
            _huff := create2(0, add(huffCode, 32), mload(huffCode), salt)
        }
        huff = _huff;
    }

    function testBitmask() external {
        bytes32 value = I8bitArray(huff).testBitmask(30);
        assertEq(
            value,
            0xff00ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
        );
        value = I8bitArray(huff).testBitmask(2);
        assertEq(
            value,
            0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffff00ffff
        );
    }

    function testOffset() external {
        bytes32 value = I8bitArray(huff).testNumberOffset(5, 3);
        assertEq(
            value,
            0x0000000000000000000000000000000000000000000000000000000005000000
        );
        value = I8bitArray(huff).testNumberOffset(9, 5);
        assertEq(
            value,
            0x0000000000000000000000000000000000000000000000000000090000000000
        );
    }

    function testWrite() external {
        I8bitArray(huff).testNumberWrite(10, 4);
        I8bitArray(huff).testNumberWrite(5, 2);
        bytes32 value = I8bitArray(huff).testNumberRead(4);
        assertEq(
            value,
            0x000000000000000000000000000000000000000000000000000000000000000a
        );
        value = I8bitArray(huff).testNumberRead(2);
        assertEq(
            value,
            0x0000000000000000000000000000000000000000000000000000000000000005
        );
        value = I8bitArray(huff).testNumberRead(4);
        assertEq(
            value,
            0x000000000000000000000000000000000000000000000000000000000000000a
        );
    }

    function testOverWrite() external {
        I8bitArray(huff).testNumberWrite(10, 4);
        bytes32 value = I8bitArray(huff).testNumberRead(4);
        assertEq(
            value,
            0x000000000000000000000000000000000000000000000000000000000000000a
        );
        I8bitArray(huff).testNumberWrite(5, 4);
        value = I8bitArray(huff).testNumberRead(4);
        assertEq(
            value,
            0x0000000000000000000000000000000000000000000000000000000000000005
        );
    }
}
