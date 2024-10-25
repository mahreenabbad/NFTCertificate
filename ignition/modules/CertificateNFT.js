const { buildModule } = require("@nomicfoundation/hardhat-ignition/modules");



module.exports = buildModule("CertificateNFTModule", (m) => {


  const nft = m.contract("CertificateNFT");

  return { nft };
});
