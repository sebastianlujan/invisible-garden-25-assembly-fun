// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test} from "forge-std/Test.sol";
import {AssemblyVector} from "../src/AssemblyVector.sol";

contract AssemblyVectorTest is Test {
    uint[3] vectorA = [1, 2, 3];
    uint[3] vectorB = [1, 2, 3];

    AssemblyVector vector;

    function setUp() public {
        vector = new AssemblyVector();
    }

    function test_dot_product() public view{
        uint[] memory a = new uint[](3);
        uint[] memory b = new uint[](3);

        for (uint i = 0; i < 3; i++) {
            a[i] = vectorA[i];
            b[i] = vectorB[i];
        }
        uint res = vector.dotProduct(a, b);
        assertEq(res, 14);
    }
}