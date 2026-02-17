// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Burnable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/// @title Shepard Sovereign Bond Series A ($SSB-A)
/// @notice ERC-721 Bond Instrument on Metal L2 (Chain ID 1750)
/// @dev UCC Article 7 Document of Title / UCC Article 12 CER
/// Authority: 48 Stat. 112; UCC Arts. 3, 7, 9, 12
contract ShepardSovereignBond is ERC721, ERC721URIStorage, ERC721Burnable, Ownable {
    uint256 private _nextTokenId;

    struct BondData {
        string bondNumber;
        uint256 faceValue;
        string trustName;
        string uccFiling;
        string filingState;
        bytes32 documentHash;
        uint256 maturityDate;
        string status;
        string instrumentType;
    }

    mapping(uint256 => BondData) public bonds;
    mapping(bytes32 => bool) public hashUsed;

    event BondMinted(uint256 indexed tokenId, string bondNumber, uint256 faceValue, string trustName);
    event BondRedeemed(uint256 indexed tokenId, string bondNumber, uint256 faceValue);
    event StatusUpdated(uint256 indexed tokenId, string newStatus);

    constructor()
        ERC721("Shepard Sovereign Bond Series A", "SSB-A")
        Ownable(msg.sender)
    {}

    function mintBond(
        address to,
        string memory uri,
        string memory bondNumber,
        uint256 faceValue,
        string memory trustName,
        string memory uccFiling,
        string memory filingState,
        bytes32 documentHash,
        uint256 maturityDate,
        string memory instrumentType
    ) public onlyOwner returns (uint256) {
        require(!hashUsed[documentHash], "Document hash already used");
        uint256 tokenId = _nextTokenId++;
        _safeMint(to, tokenId);
        _setTokenURI(tokenId, uri);
        bonds[tokenId] = BondData({
            bondNumber: bondNumber,
            faceValue: faceValue,
            trustName: trustName,
            uccFiling: uccFiling,
            filingState: filingState,
            documentHash: documentHash,
            maturityDate: maturityDate,
            status: "ACTIVE",
            instrumentType: instrumentType
        });
        hashUsed[documentHash] = true;
        emit BondMinted(tokenId, bondNumber, faceValue, trustName);
        return tokenId;
    }

    function updateStatus(uint256 tokenId, string memory newStatus) public onlyOwner {
        require(tokenId < _nextTokenId, "Token does not exist");
        bonds[tokenId].status = newStatus;
        emit StatusUpdated(tokenId, newStatus);
    }

    function getBondStatus(uint256 tokenId) public view returns (
        string memory bondNumber,
        uint256 faceValue,
        string memory trustName,
        string memory status,
        uint256 maturityDate
    ) {
        require(tokenId < _nextTokenId, "Token does not exist");
        BondData storage bond = bonds[tokenId];
        return (bond.bondNumber, bond.faceValue, bond.trustName, bond.status, bond.maturityDate);
    }

    // Override required by Solidity
    function tokenURI(uint256 tokenId) public view override(ERC721, ERC721URIStorage) returns (string memory) {
        return super.tokenURI(tokenId);
    }

    function supportsInterface(bytes4 interfaceId) public view override(ERC721, ERC721URIStorage) returns (bool) {
        return super.supportsInterface(interfaceId);
    }
}
