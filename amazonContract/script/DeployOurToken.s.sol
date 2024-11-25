// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.19;

import {Script} from "forge-std/Script.sol";
import {AmazonToken} from "../src/AmazonToken.sol";

contract DeployOurToken is Script{

    uint256 public constant INITIAL_SUPPLY = 100 ether;


    function run() external returns(AmazonToken) {
        vm.startBroadcast();
        AmazonToken at = new AmazonToken(INITIAL_SUPPLY);
        vm.stopBroadcast();
        return at;
    }

}