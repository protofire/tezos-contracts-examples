const { Tezos, UnitValue } = require('@taquito/taquito')
const { InMemorySigner } = require('@taquito/signer')

// Init config
const wallet = require('./wallet.json')
const contractReceiverAddress = "KT1JCpi8dRfUGZ2kfCm1QUdxtTaQC8MkeiAF"
const contractSenderAddress = "KT1TYv6hZbP49w3ynnd2C6D3sv8DoW26yDYe"
const signer = InMemorySigner.fromFundraiser(wallet.email, wallet.password, wallet.mnemonic.join(' '))
const rpc = "https://api.tez.ie/rpc/carthagenet"

Tezos.setProvider({ rpc, signer });

const useReceiver = async () => {
    const contractReceiver = await Tezos.contract.at(contractReceiverAddress)
    const contractSender = await Tezos.contract.at(contractSenderAddress)

    const contractReceiverBefore = await contractReceiver.storage()
    console.log(`Receiver storage before: ${contractReceiverBefore}`)

    const barValue = 1 + Math.floor((10) * Math.random())
    const operationSender = await contractSender.methods.setBar(barValue).send()
    console.log(`Trying to setting value: ${barValue}`)
    await operationSender.confirmation()

    const operationReceiver = await contractReceiver.methods.getFoo(UnitValue).send()
    await operationReceiver.confirmation()

    const contractReceiverAfter = await contractReceiver.storage()
    console.log(`Receiver storage after: ${contractReceiverAfter}`)
}

(async () => {
    await useReceiver()
})().catch(e => {
    console.error(e)
    process.exit(1)
})