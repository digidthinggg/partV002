const CONTRACT_NAME = process.env.WALLET_CONTRACT_NAME

async function main() {
  const Contract = await ethers.getContractFactory(CONTRACT_NAME)
  const contract = await Contract.deploy()

  console.log("Wallet deployed to address:", contract.address)
}

main().catch(error => {
  console.log(error)
  process.exitCode = 1
})
