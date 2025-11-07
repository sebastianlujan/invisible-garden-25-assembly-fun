// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script} from "forge-std/Script.sol";
import { AssemblyVector } from "../src/AssemblyVector.sol";

contract CounterScript is Script {
    AssemblyVector vector;

    function setUp() public {}

    function run() public {
        vm.startBroadcast();

        vector = new AssemblyVector();

        vm.stopBroadcast();
    }
}
