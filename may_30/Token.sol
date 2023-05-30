// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

/**
 * @title Token
 * @dev An implementation of ERC 20
 * @custom:dev-run-script ./scripts/deploy_with_ethers.ts
 */
contract Token {
    string public name = "Indulgences";
    string public symbol = "IND";
    uint8 public decimals = 18;
    uint256 public totalSupply = 100;

    mapping(address => uint256) everyonesMONEY;

    function balanceOf(address _owner) public view returns (uint256 balance) {
        return everyonesMONEY[_owner];
    }

}