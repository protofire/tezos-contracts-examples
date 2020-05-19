const { Tezos, UnitValue } = require('@taquito/taquito')
const { InMemorySigner } = require('@taquito/signer')

// Init config
const wallet = require('./wallet.json')
const contractInspectorAddress = "KT1Pjc9cUypMwv3zqHVmApXws1Agf7w7e7JG"
const contractSenderAddress = "KT1TYv6hZbP49w3ynnd2C6D3sv8DoW26yDYe"
const signer = InMemorySigner.fromFundraiser(wallet.email, wallet.password, wallet.mnemonic.join(' '))
const rpc = "https://api.tez.ie/rpc/carthagenet"

Tezos.setProvider({ rpc, signer });

const useInspector = async () => {
    const contractInspector = await Tezos.contract.at(contractInspectorAddress)
    const contractSender = await Tezos.contract.at(contractSenderAddress)

    const contractInspectorBefore = await contractInspector.storage()
    console.log(`Inspector storage before: ${contractInspectorBefore}`)

    const barValue = 1 + Math.floor((10) * Math.random())
    const operationSender = await contractSender.methods.setBar(barValue).send()
    console.log(`Trying to setting value: ${barValue}`)
    await operationSender.confirmation()

    const operationInspector = await contractInspector.methods.getFoo(contractSenderAddress).send()
    await operationInspector.confirmation()

    const contractInspectorAfter = await contractInspector.storage()
    console.log(`Inspector storage after: ${contractInspectorAfter}`)
}

(async () => {
    await useInspector()
})().catch(e => {
    console.error(e)
    process.exit(1)
})