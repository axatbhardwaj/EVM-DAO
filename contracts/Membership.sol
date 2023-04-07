//TODO: 1. Fix comments according to Natspec

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

//Errors
error TransferNotAllowed();
error ApprovalNotAllowed();
error alreadyMember();

//Interfaces
interface ERC721 {
    event Transfer(
        address indexed _from,
        address indexed _to,
        uint256 indexed _tokenId
    );
    event Approval(
        address indexed _owner,
        address indexed _approved,
        uint256 indexed _tokenId
    );
    event ApprovalForAll(
        address indexed _owner,
        address indexed _operator,
        bool _approved
    );

    function balanceOf(address _owner) external view returns (uint256);

    function ownerOf(uint256 _tokenId) external view returns (address);

    function safeTransferFrom(
        address _from,
        address _to,
        uint256 _tokenId,
        bytes memory data
    ) external;

    function safeTransferFrom(
        address _from,
        address _to,
        uint256 _tokenId
    ) external;

    function transferFrom(
        address _from,
        address _to,
        uint256 _tokenId
    ) external;

    function approve(address _approved, uint256 _tokenId) external;

    function setApprovalForAll(address _operator, bool _approved) external;

    function getApproved(uint256 _tokenId) external view returns (address);

    function isApprovedForAll(
        address _owner,
        address _operator
    ) external view returns (bool);

    function name() external view returns (string memory _name);

    function symbol() external view returns (string memory _symbol);

    function tokenURI(uint256 _tokenId) external view returns (string memory);

    function totalSupply() external view returns (uint256);
}

/// @title Membership SBT
/// @author axatbhardwaj
/// @notice This gives acess to Dao
/// @dev Mint's and SBT to user's address as a proof of membership

contract MembershipNFT {
    event Transfer(
        address indexed _from,
        address indexed _to,
        uint256 indexed _tokenId
    );

    constructor() {
        _uri = "https://github.com/axatbhardwaj";
        _symbol = "VD-MNFT";
        _name = "VOTING DAO MEMBERSHIP";
    }

    uint256 private _tokenCount;
    string private _uri;
    string private _symbol;
    string private _name;

    // Mappings
    mapping(address => uint256) private ownerShip;
    mapping(uint256 => address) private ownerShipByTokenId;

    /// @dev function which provides/mints membership/SBT to caller
    function getMembership() public {
        if (ownerShip[msg.sender] >= 1) revert alreadyMember();
        _tokenCount = _tokenCount + 1;
        ownerShip[msg.sender] = _tokenCount; //mint

        emit Transfer(address(this), msg.sender, _tokenCount);
    }

    /// @dev function return tokenId by owner not the Balance
    /// @param _owner : to view membership Id/ Token id of the address
    function balanceOf(address _owner) public view virtual returns (uint256) {
        return ownerShip[_owner];
    }

    /// @dev function to return owner by tokenID
    /// @param _tokenId represents membership number
    function ownerOf(uint256 _tokenId) public view virtual returns (address) {
        return ownerShipByTokenId[_tokenId];
    }

    /// @dev this function is disabled since we don't want to allow transfers
    /// @param address for the receiver
    /// @param membership token id
    function safeTransferFrom(
        address _from,
        address _to,
        uint256 _tokenId
    ) public virtual {
        revert TransferNotAllowed();
    }

    /// @dev this function is disabled since we don;t want to allow transfers
    /// @param address for the receiver
    /// @param membership token id
    /// @param data associated with the transfer/token
    function safeTransferFrom(
        address _from,
        address _to,
        uint256 _tokenId,
        bytes memory _data
    ) public virtual {
        revert TransferNotAllowed();
    }

    /// @dev this function is disabled since we don;t want to allow transfers
    /// @param _from : transfer from address
    /// @param _to : transfer to address
    /// @param _tokenId: token Id to transfer
    function transferFrom(
        address _from,
        address _to,
        uint256 _tokenId
    ) public virtual {
        revert TransferNotAllowed();
    }

    /// @dev this function is disabled since we don;t want to allow transfers
    /// @param address for the operator
    /// @param membership token id
    function approve(address _to, uint256 _tokenId) public virtual {
        revert TransferNotAllowed();
    }

    /// @dev this function is disabled since we don;t want to allow transfers
    function setApprovalForAll(
        address _operator,
        bool _approved
    ) public virtual {
        revert ApprovalNotAllowed();
    }

    /// @dev this function is disabled since we don;t want to allow transfers
    /// @param membership token id
    function getApproved(uint256 _tokenId) public view returns (address) {
        return address(0x0);
    }

    /// @dev this function is disabled since we don;t want to allow transfers
    function isApprovedForAll(
        address _owner,
        address _operator
    ) public view returns (bool) {
        return false;
    }

    /// @dev Function returns tokenuri variable as it is common for all tokens
    /// @param membership token id
    function tokenURI(
        uint256 _tokenId
    ) public view virtual returns (string memory) {
        if (_tokenId > _tokenCount) revert("Token doesn't exist");
        return _uri;
    }

    /// @dev Function returns symbol
    function symbol() external view returns (string memory) {
        return _symbol;
    }

    function totalSupply() external view returns (uint256) {
        return _tokenCount;
    }

    /// @dev Function returns name of token
    function name() external view returns (string memory) {
        return _name;
    }
}
