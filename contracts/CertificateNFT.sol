// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.0.0
pragma solidity ^0.8.22;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";


contract CertificateNFT is ERC721, ERC721URIStorage{

    address public initialOwner;
    uint public _nextTokenId;

    mapping(uint=> bool) public approvedNFT;
    mapping(uint => address) public boundNFTs;
    
    //  mapping(uint => bool) public boundNFTRequests;
    event BoundTokenMinted(address indexed to, uint256 indexed tokenId);
    
    constructor() ERC721("Student Certificate", "SCT")   {
                initialOwner = msg.sender;}

     modifier onlyOwner() {
        require(msg.sender==initialOwner,"You are Not Owner");
        _;
    }
     

     function mintSoulBoundToken(address _to, uint _tokenId, string memory uri) external onlyOwner {
        require(approvedNFT[_tokenId], "NFT not approved");
      
        _safeMint(_to, _tokenId);
        _setTokenURI(_tokenId, uri);
        boundNFTs[_tokenId] = msg.sender;
         emit BoundTokenMinted(_to, _tokenId);
    }
      
     function approveBoundNFT(uint _tokenId) external onlyOwner {
        // require(boundNFTRequests[_tokenId], "Bound NFT  request not submitted");
        approvedNFT[_tokenId] = true;
    }
   ////////////////////////////////////////////////
   

    // The following functions are overrides required by Solidity.

    function tokenURI(uint256 tokenId)
        public
        view
        override(ERC721, ERC721URIStorage)
        returns (string memory)
    {
        return super.tokenURI(tokenId);
    }
    

    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721, ERC721URIStorage)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }
    /////////////////////
     function _update(address to, uint256 tokenId, address auth) internal override returns (address) {
        address from = _ownerOf(tokenId);
        require(from == address(0) || to == address(0), "SoulBoundNFT: token transfer is not allowed");
        require(approvedNFT[tokenId] ==true,"Bound NFT not Approved");
        return super._update(to, tokenId, auth);
    }
    
    
 
     
}