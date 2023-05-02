// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

interface Imembership {
    function balanceOf(address _owner) external view virtual returns (uint256);
}
error notMember();

contract Daotoken is ERC20 {
    address private membershipAddress;
    Imembership public membershipContract;

    modifier onlyMember() {
        if (membershipContract.balanceOf(msg.sender) == 0) revert notMember();
        _;
    }

    constructor(
        address _membershipAddress
    ) ERC20("Voting Daotoken", "VDAO-TKN") {
        membershipAddress = _membershipAddress;
        membershipContract = Imembership(membershipAddress);
    }

    function mint(address _recipient, uint256 _tokenAmount) public onlyMember {
        _mint(_recipient, _tokenAmount);
    }

    function burn(
        address _tokenHolder,
        uint256 _tokenAmount
    ) public onlyMember {
        _burn(_tokenHolder, _tokenAmount);
    }
}
