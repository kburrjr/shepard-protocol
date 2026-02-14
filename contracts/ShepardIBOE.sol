// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/**
 * @title ShepardIBOE
 * @notice UCC Article 12 Compliant International Bill of Exchange NFT
 * @dev The Sheep That Heard - SHEPARD Protocol
 * 
 * Legal Authority: 48 Stat. 112 (Public Resolution No. 10, 73rd Congress)
 * UCC Compliance: Articles 3, 9, 12
 * UCC-1 Filing: U250141327124 (California) - $100,000,000 Security Interest
 * Accounting Method: GAAP Accrual Basis
 * 
 * Affirmed under penalty of LAW
 * Aaron Theophilus - Secured Party
 */
contract ShepardIBOE is ERC721, ERC721URIStorage, Ownable {
    
    uint256 private _tokenIdCounter;
    
    struct IBOERecord {
        uint256 faceValue;
        uint256 maturityDate;
        address drawer;
        address payee;
        string drawerName;
        string payeeName;
        string uccFilingNumber;
        string authorityReference;
        bool isEndorsed;
        bool isRedeemed;
    }
    
    mapping(uint256 => IBOERecord) public iboeRecords;
    
    event IBOEMinted(uint256 indexed tokenId, address indexed drawer, address indexed payee, uint256 faceValue);
    event IBOEEndorsed(uint256 indexed tokenId, address indexed from, address indexed to);
    event IBOERedeemed(uint256 indexed tokenId, uint256 faceValue);
    
    constructor() ERC721("SHEPARD IBOE", "SIBOE") Ownable(msg.sender) {
        _tokenIdCounter = 1;
    }
    
    /**
     * @notice Mint a new IBOE NFT per UCC 12-105 Control Requirements
     * @param payee Address of the named beneficiary
     * @param faceValue Principal amount in wei
     * @param maturityDate Unix timestamp for maturity
     * @param drawerName Legal name of drawer
     * @param payeeName Legal name of payee
     * @param tokenURI IPFS URI for off-chain metadata
     */
    function mintIBOE(
        address payee,
        uint256 faceValue,
        uint256 maturityDate,
        string memory drawerName,
        string memory payeeName,
        string memory tokenURI
    ) external returns (uint256) {
        uint256 tokenId = _tokenIdCounter;
        _tokenIdCounter++;
        
        _safeMint(payee, tokenId);
        _setTokenURI(tokenId, tokenURI);
        
        iboeRecords[tokenId] = IBOERecord({
            faceValue: faceValue,
            maturityDate: maturityDate,
            drawer: msg.sender,
            payee: payee,
            drawerName: drawerName,
            payeeName: payeeName,
            uccFilingNumber: "U250141327124",
            authorityReference: "48 Stat. 112",
            isEndorsed: false,
            isRedeemed: false
        });
        
        emit IBOEMinted(tokenId, msg.sender, payee, faceValue);
        return tokenId;
    }
    
    /**
     * @notice Endorse IBOE to new holder per UCC 3-204
     * @param tokenId The IBOE token to endorse
     * @param newHolder Address of the endorsee
     */
    function endorseIBOE(uint256 tokenId, address newHolder) external {
        require(ownerOf(tokenId) == msg.sender, "Not IBOE holder");
        require(!iboeRecords[tokenId].isRedeemed, "IBOE already redeemed");
        
        iboeRecords[tokenId].isEndorsed = true;
        _transfer(msg.sender, newHolder, tokenId);
        
        emit IBOEEndorsed(tokenId, msg.sender, newHolder);
    }
    
    /**
     * @notice Redeem IBOE at maturity - burns token
     * @param tokenId The IBOE token to redeem
     */
    function redeemIBOE(uint256 tokenId) external {
        require(ownerOf(tokenId) == msg.sender, "Not IBOE holder");
        require(block.timestamp >= iboeRecords[tokenId].maturityDate, "Not yet mature");
        require(!iboeRecords[tokenId].isRedeemed, "Already redeemed");
        
        iboeRecords[tokenId].isRedeemed = true;
        uint256 faceValue = iboeRecords[tokenId].faceValue;
        
        _burn(tokenId);
        
        emit IBOERedeemed(tokenId, faceValue);
    }
    
    /**
     * @notice Get full IBOE record
     */
    function getIBOERecord(uint256 tokenId) external view returns (IBOERecord memory) {
        return iboeRecords[tokenId];
    }

    /**
     * @notice Soul-Bound Token Override - Prevents transfers
     * @dev IBOE NFTs are non-transferable per UCC Article 12 Control Requirements
     * Only minting (from address(0)) and burning (to address(0)) are permitted
     * This ensures the IBOE remains bound to the original holder until redemption
     */
    function _update(
        address to,
        uint256 tokenId,
        address auth
    ) internal override(ERC721) returns (address) {
        address from = _ownerOf(tokenId);
        
        // Allow minting (from == address(0)) and burning (to == address(0))
        // Block all other transfers - Soul-Bound Token
        if (from != address(0) && to != address(0)) {
            revert("SHEPARD: Soul-Bound Token - Transfer not permitted");
        }
        
        return super._update(to, tokenId, auth);
    }
    
    // Required overrides
    function tokenURI(uint256 tokenId) public view override(ERC721, ERC721URIStorage) returns (string memory) {
        return super.tokenURI(tokenId);
    }
    
    function supportsInterface(bytes4 interfaceId) public view override(ERC721, ERC721URIStorage) returns (bool) {
        return super.supportsInterface(interfaceId);
    }
}
