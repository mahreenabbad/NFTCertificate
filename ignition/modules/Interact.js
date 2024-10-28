
require("dotenv").config();
// var fs = require('fs');

var ethers = require('ethers')
// const fsPromises = fs.promises;
// Contract addresses
const ABI_FILE_PATH = '../../artifacts/contracts/CertificateNFT.sol/CertificateNFT.json';
 const CONTRACT_ADDRESS = "0xb09659C512Ed68938A18C99954dD9AD930cDCb64";

// async function getAbi(){
//   const data = await fsPromises.readFile(ABI_FILE_PATH)
//   const abi = JSON.parse(data)['abi']
//   return abi;
// }
async function main(){
  const ALCHEMY_API_KEY = process.env.ALCHEMY_API_KEY
  let provider = new ethers.getDefaultProvider(`https://eth-sepolia.g.alchemy.com/v2/${ALCHEMY_API_KEY}`);
  
  //  const abi = await getAbi();
 

  const SEPOLIA_PRIVATE_KEY =process.env.SEPOLIA_PRIVATE_KEY;

  let signer = new ethers.Wallet(SEPOLIA_PRIVATE_KEY, provider);
  console.log(signer)

  const contract = new ethers.Contract(CONTRACT_ADDRESS,ABI_FILE_PATH.abi,signer)
  console.log(contract)
  //  const owner = await contract.initialOwner()
  //    console.log("Owner:", owner);

  //    try {
  //     const tokenId = 0
  //   const baseURI = await certificateNFT.tokenURI(tokenId);
  //   console.log("Base URI:", baseURI);
  // } catch (error) {
  //   console.log("Error getting base URI:", error.message);
  // }
  // try {
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
}
main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });





 
    
   
    