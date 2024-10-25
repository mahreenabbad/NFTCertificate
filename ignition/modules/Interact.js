// const hre = require("hardhat");

const { boolean } = require("hardhat/internal/core/params/argumentTypes");


async function main() {
  try {
    // Get the ContractFactory of your SimpleContract
  //  const SimpleContract = await hre.ethers.getContractFactory("CertificateNFT");

    // Connect to the deployed contract
    const contractAddress = "0xd5468d2e3de3F9EB3371FC772758c7ed57d4440F"; // Replace with your deployed contract address
    // const contract = await SimpleContract.attach(contractAddress);

    const to =" 0x117230682974d73f2DB5C21F0268De2fACB0119f"
     const tokenId = 0;
     const uri = "https://blush-defiant-clam-418.mypinata.cloud/ipfs/QmQs6Uv1zrmzfjP8K3ULRBkYEWZL6FaDfinnZiLuHJwGYg"

    await contractAddress.safeMint(to,tokenId,uri)

    // console.log("Updated Message:", minted);
  } catch (error) {
    console.error(error);
    process.exit(1);
  }
}
