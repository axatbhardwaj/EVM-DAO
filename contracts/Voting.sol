// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

import "./Membership.sol";

/* TODO :

A:- Membership Management;

    1. Create a Membership system for USERS via using SBTs;
    2. No user will be able to use this Dao to propose a vote without SBTs;

    3. Anyvone can vote with the tokens present but can not propose 

B:- Token management;
    1. out custom ERC-20 token can be minted to a max amount of 100 on the address if SBT token holders only;
    
C:- proposal Management

    1. create a proposal;
    1.1. Users will have to pay fee by an ERC-20 token as fee to propose a deal;
    2. users should be able to vote on the basis of ERC-1155 tokens;
    3. users should be able to create proposals as well ;
    4. a group of dao keepers/ADmins will have to approve the proposals;(5/20);
*/
error notMember(address);

/*
proposal struct 
interface Imembership {
    function balanceOf(address _owner) external view virtual returns (uint256);
}
error notMember();

struct proposal {
    //NOTE: change address
    Imembership constant MembershipcontractAddress =
        Imembership(0xADC9Cc03ff1CE5A51cA0B4ae3561bAa1fE6E49D6);
    uint256 choices ;
    
    modifier memberShipCheck() {
        if (MembershipcontractAddress.balanceOf(msg.sender) <= 0)
            revert notMember();
        _;
    }
}

*/


contract dao is MembershipNFT {

    struct vRes {
        uint256 totalMembers;
        uint256 membersVoted;

    }

    address constant MembershipNFTContract = ;
    modifier checkMembership() {
        _;
    }

    function createProposal external (uint256[] arrayOFAddresses, string proposalName) returns 
    {

    }
}
