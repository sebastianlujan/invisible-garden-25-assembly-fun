// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract AssemblyVector {
    function dotProduct(uint[] memory a, uint[] memory b) external pure returns (uint result) {
        require(a.length == b.length, "Arrays must have same length");
        assembly {
            //let a_alloc := add(a, 0x20)
            let sum := 0
            for { let i := 0 } lt(i, mload(a) ) { i := add(i, 1) } {
                // ai = add(a , i * 32 )
                // cada entero demora 32 bytes


                //mstore(p, v)
                //mstore(0x40, mul(mload(a), mul(i, 0x20)))
                //mstore(, mul(mload(b), mul(i, 0x20)))

                // 0x80 + offset

                let a_i := mload(add(add(a, 0x20), mul(i, 0x20)))  // Load a[i]
                let b_i := mload(add(add(b, 0x20), mul(i, 0x20)))  // Load b[i]

                sum := add(sum, mul(a_i, b_i))
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