// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract AssemblyVector {

    event Debug(uint indexed ptr, uint a_value, uint b_value, uint sum);
    //cast keccak "Debug(uint256,uint256,uint256,uint256)"
    //0xf3ee2bbb0b9b66cf7c48e59107dadde90e37dd99b20f2fcc50b1a8929b659910

    function dotProduct(uint[] memory a, uint[] memory b) external returns (uint result) {
        require(a.length == b.length, "Arrays must have same length");

        assembly {
            let sum := 0
            for { let i := 0 } lt(i, mload(a)) { i := add(i, 1) } {
                let a_i := mload(add(add(a, 0x20), mul(i, 0x20)))  // Load a[i]
                let b_i := mload(add(add(b, 0x20), mul(i, 0x20)))  // Load b[i]
                sum := add(sum, mul(a_i, b_i))

            }
            result := sum
        }
    }
    // @notice calculates the internal product between 2 arrays in 3D
    function dotProductEfficient(uint[] memory a, uint[] memory b) external returns (uint result) {
        require(a.length == b.length, "Arrays must have same length");
        assembly {
            let sum := 0
            let ptr_a := add(a, 0x20) // freeMemory 0x80 + a[0] 0x20 pointer
            let ptr_b := add(b, 0x20) // freeMemory 0x80 + b[0] 0x20 pointer

            for { let i := 0 } lt(i, mload(a)) { i := add(i, 1) } {
                let a_i := mload(ptr_a)
                let b_i := mload(ptr_b)

                sum := add(sum, mul(a_i, b_i))
                //debug(a_i, b_i, sum, i)

                ptr_a := add(ptr_a, 0x20)
                ptr_b := add(ptr_b, 0x20)
            }
            result := sum
        }
    }

    function dotProductMinimal(uint[] memory a, uint[] memory b) external returns (uint result) {
        require(a.length == b.length, "Arrays must have same length");
        assembly{
            /*function debug(a_val, b_val, sum_val, ptr) {
                mstore(0x00, a_val)
                mstore(0x20, b_val)
                mstore(0x40, sum_val)
                log2(0x00, 0x60, 0xf3ee2bbb0b9b66cf7c48e59107dadde90e37dd99b20f2fcc50b1a8929b659910, ptr)
            }
            */

            let sum := 0
            let ptr_a := add(a, 0x20)
            let ptr_b := add(b, 0x20)

            for { let i := 0 } lt(i, mload(a)) { i := add(i, 1) } {
                let a_val := mload(ptr_a)
                let b_val := mload(ptr_b)

                sum := add(sum, mul(a_val, b_val))

                ptr_a := add(ptr_a, 0x20)
                ptr_b := add(ptr_b, 0x20)
            }
            result := sum
        }

    }
}

/*
    Write an assembly program in assembly that calculates 
    the dot product of two 3-dimensional vectors 
    (e.g., A = (x1, y1, z1) and B = (x2, y2, z2))

    A . B  = sum ( Ai * Bi )  for i = 1 to 3
    [1, 2,  3] * [1, 2, 3]
    1.1 + 2.2 + 3.3  =  14
*/