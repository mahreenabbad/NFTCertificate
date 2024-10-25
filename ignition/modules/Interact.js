
////////////////////////////////////////////////
const ethers = require("ethers");
const abi = require("./CertificateNFT.json");
// const { Web3 } = require("web3");
const { Signature } = require("ethers");
// Contract addresses

const CertificateNFTContractAddress = "0x073B815dA90C5468f171d2aE89C28F86D48cBE8C";

// Provider and signer setup
const provider = new ethers.JsonRpcProvider(
  "https://ethereum-sepolia-rpc.publicnode.com"
);
const privateKey =
  "f1cdd843a12b8e3ca694679c0da3e0ae8dd143c2e012cc693043b5fb0206a24c"; // Replace with your private key
const signer = new ethers.Wallet(privateKey, provider);
// Create contract instance
const certificateNftContract = new ethers.Contract(
    CertificateNFTContractAddress,
  abi,
  signer
);
const main = async () => {
 
    
   
    // Try getting base URI
    try {
        const tokenId = 0
      const baseURI = await certificateNftContract.tokenURI(tokenId);
      console.log("Base URI:", baseURI);
    } catch (error) {
      console.log("Error getting base URI:", error.message);
    }
    try {
        const from ="0x117230682974d73f2DB5C21F0268De2fACB0119f";
        const to ="0x4D6d151F4C2eE9211274c5895A1aDe0A291D43FA" ;
        const tokenId =0;
        const tx = await certificateNftContract.safeMint(
          from,
          to,
          tokenId
        );
        const receipt = await tx.wait();
        console.log("NFT minted! Transaction hash:", receipt.transactionHash);
        return receipt;
      } catch (error) {
        console.error("Error minting weapon:", error.message);
        return null;
      }



// Helper function to mint weapon
// const mintNft = async () => {
    
//   try {
//     const from ="0x117230682974d73f2DB5C21F0268De2fACB0119f";
//     const to ="0x4D6d151F4C2eE9211274c5895A1aDe0A291D43FA" ;
//     const tokenId =0;
//     const tx = await certificateNftContract.safeMint(
//       from,
//       to,
//       tokenId
//     );
//     const receipt = await tx.wait();
//     console.log("NFT minted! Transaction hash:", receipt.transactionHash);
//     return receipt;
//   } catch (error) {
//     console.error("Error minting weapon:", error.message);
//     return null;
//   }
// };

// Execute main function
main()
  .then(() => {
    console.log("Script completed");
    process.exit(0);
  })
  .catch((error) => {
    console.error("Script failed:", error);
    process.exit(1);
  });
}
// Export functions for external use
// module.exports = {
//     mintNft,
 
// };