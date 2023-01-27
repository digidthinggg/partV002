const ethers = require("ethers")

const CONTRACT_ARTIFACT_PATH = process.env.LAYER_CONTRACT_ARTIFACT_PATH
const CONTRACT_ADDRESS = process.env.LAYER_CONTRACT_ADDRESS

const WALLET_CONTRACT_ARTIFACT_PATH = process.env.WALLET_CONTRACT_ARTIFACT_PATH
const WALLET_CONTRACT_ADDRESS = process.env.WALLET_CONTRACT_ADDRESS

const ALCHEMY_API_KEY = process.env.ALCHEMY_API_KEY
const METAMASK_PKEY = process.env.METAMASK_PKEY

const provider = new ethers.providers.AlchemyProvider(network="goerli", ALCHEMY_API_KEY)
const signer = new ethers.Wallet(METAMASK_PKEY, provider)
const Contract = require(CONTRACT_ARTIFACT_PATH)
const contract = new ethers.Contract(CONTRACT_ADDRESS, Contract.abi, signer)

async function main() {
  await contract.setWalletAddress(WALLET_CONTRACT_ADDRESS)
}

main().catch(error => {
  console.log(error)
  process.exitCode = 1
})

contract.on("StartedEV", () => {
  console.log("EVENT Layer: StartedEv")
})

contract.on("SuccessEv", () => {
  console.log("EVENT Layer: SuccessEv")
})

contract.on("FailureEv", () => {
  console.log("EVENT Layer: FailureEv")
})
