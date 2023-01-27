const CONTRACT_NAME = process.env.LAYER_CONTRACT_NAME

async function main() {
  const Contract = await ethers.getContractFactory(CONTRACT_NAME)
  const contract = await Contract.deploy()

  console.log("Layer deployed to address:", contract.address)
}

main().catch(error => {
  console.log(error)
  process.exitCode = 1
})
