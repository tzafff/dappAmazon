// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.19;

import {Script} from "forge-std/Script.sol";
import {Dappazon} from "../src/Dappazon.sol";
import {DevOpsTools} from "foundry-devops/src/DevOpsTools.sol";

contract DeployAmazon is Script{

    uint256 public constant INITIAL_SUPPLY = 100 ether;


    function run() external returns(Dappazon) {
         address mostRecentlyDeployedAmazonToken = DevOpsTools.get_most_recent_deployment("AmazonToken", block.chainid);
        vm.startBroadcast();
        Dappazon am = new Dappazon(mostRecentlyDeployedAmazonToken);
        vm.stopBroadcast();
        return am;
    }

}