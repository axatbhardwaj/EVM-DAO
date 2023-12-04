// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

//This token will be responsible for providing voting powet to the dao members on specific proposals\
//Every Dao member will be allocated 100 token for voting monthly
//There will be only one voting token
//The token will be minted to the Dao members
//The porposal will require a minimum of 10 votes to be approved

error transferNotAllowed(address to, uint256 amount);

contract Daotoken is ERC20 {
    address public godAddress;

    constructor(
        string memory name_,
        string memory symbol_
    ) ERC20(name_, symbol_) {
        godAddress = msg.sender;
    }

    function mint(address _to, uint256 _amount) public {
        _mint(_to, _amount);
    }

    function (must be followed by the contract name)
    function transfer(
        address _to,
        uint256 _value
    ) public pure override returns (bool) {
        revert transferNotAllowed(_to, _value);
    }

    function burn(address _from, uint256 _value) public {
        _burn(_from, _value);
    }
}

/*
This token is going to be responsible for representing voting power */
