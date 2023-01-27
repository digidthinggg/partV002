const ethers = require("ethers")

const CONTRACT_ARTIFACT_PATH = process.env.TOKEN_CONTRACT_ARTIFACT_PATH
const CONTRACT_ADDRESS = process.env.TOKEN_CONTRACT_ADDRESS

const PROXY_CONTRACT_ADDRESS = process.env.PROXY_CONTRACT_ADDRESS;
const WALLET_CONTRACT_ADDRESS = process.env.WALLET_CONTRACT_ADDRESS;

const ALCHEMY_API_KEY = process.env.ALCHEMY_API_KEY
const METAMASK_PKEY = process.env.METAMASK_PKEY

const provider = new ethers.providers.AlchemyProvider(network="goerli", ALCHEMY_API_KEY)
const signer = new ethers.Wallet(METAMASK_PKEY, provider)
const Contract = require(CONTRACT_ARTIFACT_PATH)
const contract = new ethers.Contract(CONTRACT_ADDRESS, Contract.abi, signer)

async function main() {
  console.log(">>> setting proxy addr:", PROXY_CONTRACT_ADDRESS)
  await contract.setProxyAddress(PROXY_CONTRACT_ADDRESS)
  console.log(">>> setting wallet addr:", WALLET_CONTRACT_ADDRESS)
  await contract.setWalletAddress(WALLET_CONTRACT_ADDRESS)

  /*
  const proxyAddress = await contract.getProxyAddress()
  console.log(">>> proxy address")
  console.log(proxyAddress)
  */

  /*
  await contract.simulateTransfer()
  */

  await initTransferRequirements();
}

main().catch(error => {
  console.log(error)
  process.exitCode = 1
})

contract.on("Mint", (account, amount) => {
  console.log("EVENT Token: Mint");
  console.log("account:", account)
  console.log("amount:", amount)
})

contract.on("TransferEv", (receiver, amount) => {
  console.log("EVENT Token: Transfer");
  console.log("receiver:", receiver)
  console.log("amount:", amount)
})

contract.on("TransferFromEv", (sender, receiver, amount) => {
  console.log("EVENT Token: TransferFrom");
  console.log("sender:", sender)
  console.log("receiver:", receiver)
  console.log("amount:", amount)
})
