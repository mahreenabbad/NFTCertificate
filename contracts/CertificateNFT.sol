// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.0.0
pragma solidity ^0.8.22;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";


contract CertificateNFT is ERC721, ERC721URIStorage{
    address public initialOwner;
    
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
        _safeMint(to, tokenId);
        _setTokenURI(tokenId, uri);
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
       function checkOwnership(address from, address to, uint256 tokenId) internal onlyOwner {
        require(from == initialOwner,"You are not owner");

        // if (to != address(0)) {
        //     revert ERC721InvalidReceiver(address(0));
        // }
        address previousOwner = _update(to, tokenId, address(0));
        if (previousOwner == address(0)) {
            revert ERC721NonexistentToken(tokenId);
        } else if (previousOwner != from) {
            revert ERC721IncorrectOwner(from, tokenId, previousOwner);
        }
     
}

}

//CertificateNFT - 0xd5468d2e3de3F9EB3371FC772758c7ed57d4440F
