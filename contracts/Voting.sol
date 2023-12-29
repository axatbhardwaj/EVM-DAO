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
    2. users should be able to vote on the basis of ERC-20 tokens;
    3. users should be able to create proposals as well they will need to submit a fee of 10 Native tokens;
    4. a group of dao keepers/ADmins will have to approve the proposals more than 10 votes to be approved;
*/
error notMember(address);
error provideFee();
error deaadlinePassed(uint32 deadline);
error provideParticipants();

/*
proposal struct 
interface Imembership {
    function balanceOf(address _owner) external view virtual returns (uint256);
}
*/

contract dao is MembershipNFT {
    event proposalCreated(
        string proposalName,
        string proposalDescription,
        uint256[] arrayOFAddresses,
        uint32 deadline,
        uint256 proposalId,
        address proposer
    );

    uint256 proposalId;

    struct proposal {
        string proposalName;
        string proposalDescription;
        uint256[] particiapnts;
        uint256 deadline;
        bool approved;
        address proposer;
    }

    //NOTE: change address
    Imembership constant MembershipcontractAddress =
        Imembership(0xADC9Cc03ff1CE5A51cA0B4ae3561bAa1fE6E49D6);

    //mapping of proposals
    mapping(address => proposal) proposals;

    modifier memberShipCheck() {
        if (MembershipcontractAddress.balanceOf(msg.sender) <= 0)
            revert notMember();
        _;
    }

    function createProposal(
        string calldata _proposalName,
        string calldata _proposalDescription,
        uint256[] calldata _particiapnts,
        uint32 _deadline
    ) external {
        if (msg.value < 1 * 10 ** 18) revert provideFee();

        if (_deadline < block.timestamp) revert deaadlinePassed(_deadline);

        if (_particiapnts.length < 1) revert provideParticipants();

        ++proposalId;

        proposals[proposalId] = proposal(
            _proposalName,
            _proposalDescription,
            _particiapnts,
            _deadline,
            false,
            msg.sender
        );

        emit proposalCreated(
            _proposalName,
            _proposalDescription,
            _particiapnts,
            _deadline,
            proposalId,
            msg.sender
        );
    }


}
