// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

//This token will be responsible for providing voting powet to the dao members on specific proposals\
//Every Dao member will be allocated 100 token for voting monthly
//There will be only one voting token
//The token will be minted to the Dao members
//The porposal will require a minimum of 10 votes to be approved

error transferNotAllowed(address to, uint256 amount);
error mintCooldown(uint256 cooldown);
error notMember();

contract Daotoken is ERC20 {
    address public godAddress;

    mapping(address => uint256) public mintingLog;

    constructor(
        string memory name_,
        string memory symbol_
    ) ERC20(name_, symbol_) {
        godAddress = msg.sender;
    }

   //checks if the user is a member
   modifier memberShipCheck() {
        if (MembershipcontractAddress.balanceOf(msg.sender) <= 0)
            revert notMember();
        _;
    }

    //modifier for checking time of mint 
    modifier timeCheck() {
        if (block.timestamp < mintingLog[msg.sender] + 30 days)
            revert mintCooldown(mintingLog[msg.sender]);
        _;
    }

    function mint(address _to, uint256 _amount) public timeCheck {
        mintingLog[_to] = block.timestamp;
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
