// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.0.0
pragma solidity ^0.8.22;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

// use soulBound 
//check uri format from sepolia etherscan
// correct uri format
contract CertificateNFT is  ERC721, ERC721URIStorage, Ownable{
   

    uint public _nextTokenId=0;
    
    constructor(address initialOwner) ERC721("Student Certificate", "SCT")  Ownable(initialOwner) {  }

   
      modifier onlyApprovedSoulBound(uint _tokenId){
            require(approveSoulBoundNFT[_tokenId] == false,"Not approved");
            require(boundNFTMinted[_tokenId][msg.sender]== false,"Not approved");
            _;
   }

     mapping(uint=> bool) public approveSoulBoundNFT;
     mapping(uint =>mapping(address=>bool)) public boundNFTMinted;
    
   
    event BoundTokenMinted(address indexed to, uint256 indexed tokenId);
//mapping ----
//modifier --- {
   
     function mintSoulBoundToken(address _to, string memory uri) public onlyOwner {
        require(_to != address(0), "Invalid Address");
        require(approveSoulBoundNFT[_nextTokenId] ==true, "NFT not approved");
        require(boundNFTMinted[_nextTokenId][_to] ==false, "NFT not approved");
        _safeMint(_to, _nextTokenId);
        _setTokenURI(_nextTokenId, uri);
        boundNFTMinted[_nextTokenId][_to]= true;
        approveSoulBoundNFT[_nextTokenId] = false; // approval ended after minting
        _nextTokenId ++;
         emit BoundTokenMinted(_to, _nextTokenId);
    }

     function approveSoulboundNFT( uint256 tokenId) external  onlyOwner {  
        approveSoulBoundNFT[tokenId] = true;
    }
        function transferFrom(address from, address to, uint256 tokenId) public  virtual onlyApprovedSoulBound(tokenId) override(ERC721, IERC721) {
        super.transferFrom(from, to, tokenId);
    }
  
      function safeTransferFrom(address from, address to, uint256 tokenId, bytes memory data) public  virtual override(ERC721,IERC721)  {
        transferFrom(from, to, tokenId);
        ERC721Utils.checkOnERC721Received(_msgSender(), from, to, tokenId, data);
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
///////////////////////////////
