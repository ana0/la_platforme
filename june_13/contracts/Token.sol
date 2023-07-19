// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "./Owner.sol";

// Uncomment this line to use console.log
// import "hardhat/console.sol";

/**
 * @title Token
 * @dev An implementation of ERC 20
 */
contract Token is Owner {
    // @dev All public variables have built in getters
    string public name;
    string public symbol;
    uint8 public decimals;
    uint256 public totalSupply;

    mapping(address => uint256) balances;
    mapping(address => mapping(address => uint256)) allowances;

    // changing my token

    /// Transfer event should be emitted whenever tokens move between addresses
    event Transfer(address indexed _from, address indexed _to, uint256 _value);
    /// Approval should be emitted whenever someone approves a spender on their account
    event Approval(address indexed _owner, address indexed _spender, uint256 _value);

    constructor(
        // only called once!!
        // string storage 
        string memory _nameInMemory,
        string memory _symbolInMemory,
        uint8 _decimalsInMemory
        ) {
        name = _nameInMemory;
        symbol = _symbolInMemory;
        decimals = _decimalsInMemory;
        totalSupply = 0;
        // I don't need _nameInMemory anymore, because I stored name
    }

    /// @notice Returns the balance of a given address
    /// @dev A custom getter for the balances mapping
    /// @param _owner Any address
    /// @return balance The current balance
    function balanceOf(address _owner) public view returns (uint256 balance) {
        return balances[_owner];
    }

    /// @notice Sets a new token name and can only be called by owner
    /// @param newName Any string
    function setName(string memory newName) public isOwner {
        name = newName;
    }

    /// @notice Mints 10 tokens to the given address and can only be called by owner
    /// @param _owner Any address
    function mint(address _owner) public isOwner {
        balances[_owner] += 10;
        totalSupply += 10;
        emit Transfer(address(0), _owner, 10);
    }

    /// @notice Moves tokens from the sender to a given address
    /// @param _to The recipient of the transfer
    /// @param _value The amount of tokens to move
    /// @return success Returns true if success
    function transfer(address _to, uint256 _value) public returns (bool success) {
        /// Will throw an error if the sender doesn't have enough tokens
        /// msg.sender is the address that sent the transaction
        require(balances[msg.sender] >= _value, "Sorry you are poor");
        balances[msg.sender] -= _value;
        balances[_to] += _value;
        emit Transfer(msg.sender, _to, _value);
        return true;
    }

    /// @notice Allows anyone to exchange any amount of base currency for tokens
    /// @dev Uses a 1:1 exchange rate
    function buy() payable public {
        balances[msg.sender] += msg.value;
        totalSupply += msg.value;
        emit Transfer(address(0), msg.sender, msg.value);
    }

    /// @notice Allows anyone to sell tokens for base currency, if the contract has enough reserve
    /// @dev Uses a 1:1 exchange rate
    /// @param sellAmount The amount to sell
    function sell(uint256 sellAmount) public {
        require(address(this).balance >= sellAmount, "Contract doesn't have enough balance to sell");
        require(balances[msg.sender] >= sellAmount, "Sorry you are poor");
        balances[msg.sender] -= sellAmount;
        totalSupply -= sellAmount;
        payable(msg.sender).transfer(sellAmount);
        emit Transfer(msg.sender, address(0), sellAmount);
    }

    /// @notice Moves tokens from one address to another - can only be used by approved accounts
    /// @param _from The person whose tokens are being spent
    /// @param _to The recipient of the transfer
    /// @param _value The amount of tokens to move
    /// @return success Returns true if success
    function transferFrom(address _from, address _to, uint256 _value) public returns(bool success){
        /// Will throw an error if the from address doesn't have enough tokens      
        require(balances[_from] >= _value, "Sorry you are poor");
        /// Will throw an error if the sender is not approved to spend the given amount
        /// unless the sender of the transaction is trying to spend their own tokens
        require(allowances[_from][msg.sender] >= _value || _from == msg.sender, "Sorry");
        /// also have to reduce the allowance of the spending address
        allowances[_from][msg.sender] -= _value;
        balances[_from] -= _value;
        balances[_to] += _value;
        emit Transfer(_from, _to, _value);
        return true;
    }

    /// @notice Approve a third party address to spend the tokens of transaction sender
    /// @param _spender The person who is receiving permission
    /// @param _value The amount of tokens to allowed to be spent
    /// @return success Returns true if success
    function approve(address _spender, uint256 _value) public returns (bool success){
        allowances[msg.sender][_spender] += _value;
        emit Approval(msg.sender, _spender, _value);
        return true;
    }

    /// @notice Returns the amount of owners' tokens that spender is allowed to transfer
    /// @dev A custom getter for the allowances mapping
    /// @param _owner Any address
    /// @return remaining The current allowance
    function allowance(address _owner, address _spender) public view returns (uint256 remaining) {
        return allowances[_owner][_spender];
    }

}