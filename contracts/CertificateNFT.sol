// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.0.0
pragma solidity ^0.8.22;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";


contract CertificateNFT is ERC721, ERC721URIStorage{
    address public initialOwner;
    mapping(address => bool) private _transferable;
    mapping(address => uint) private transfered;
  
    
    constructor() ERC721("MyCertificate", "MCT")   {
                initialOwner = msg.sender;}

     modifier onlyOwner() {
        require(msg.sender==initialOwner,"Not authuorized");
        _;
    }

   
    

    function safeMint(address to, uint256 tokenId, string memory uri)
        public
        onlyOwner
    {
        require(transfered[to] == 0, "Already transfered to you");
        _transferable[to] = true;
        require(_transferable[to]==true,"Already transfered to you");
        _safeMint(to, tokenId);
        _setTokenURI(tokenId, uri);
        _transferable[to] = false;
        transfered[to]++;

    }

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
    
 
     
}