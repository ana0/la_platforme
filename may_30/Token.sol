// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.2 <0.9.0;

/**
 * @title Token
 * @dev An implementation of ERC 20
 * @custom:dev-run-script ./scripts/deploy_with_ethers.ts
 */
contract Token {
    // @dev All public variables have built in getters
    string public name = "Indulgences";
    string public symbol = "IND";
    uint8 public decimals = 18;
    uint256 public totalSupply = 100;

    mapping(address => uint256) balances;

    /// @notice Returns the balance of a given address
    /// @dev A custom getter for the balances mapping
    /// @param _owner Any address
    /// @return The current balance
    function balanceOf(address _owner) public view returns (uint256 balance) {
        return balances[_owner];
    }

}