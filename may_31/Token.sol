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

    mapping(address => uint256) balances;
    mapping(address => mapping(address => uint256)) allowances;

    event Transfer(address indexed _from, address indexed _to, uint256 _value);
    event Approval(address indexed _owner, address indexed _spender, uint256 _value);

    function balanceOf(address _owner) public view returns (uint256 balance) {
        return balances[_owner];
    }

    function mint(address _owner) public {
        balances[_owner] += 10;
    }

    function transfer(address _to, uint256 _value) public returns (bool success) {
        require(balances[msg.sender] >= _value, "sorry you are poor");
        balances[msg.sender] -= _value;
        balances[_to] += _value;
        emit Transfer(msg.sender, _to, _value);
        return true;
    }

    function transferFrom(address _from, address _to, uint256 _value) public returns(bool success){
      require(balances[_from] >= _value, "sorry you are poor");
      require(allowances[_from][msg.sender] >= _value || _from == msg.sender, "sorry");
      allowances[_from][msg.sender] -= _value;
      balances[_from] -= _value;
      balances[_to] += _value;
      emit Transfer(_from, _to, _value);
      return true;
    }

    function approve(address _spender, uint256 _value) public returns (bool success){
       allowances[msg.sender][_spender] += _value;
       emit Approval(msg.sender, _spender, _value);
       return true;
    }

    function allowance(address _owner, address _spender) public view returns (uint256 remaining) {
        return allowances[_owner][_spender];
    }

}