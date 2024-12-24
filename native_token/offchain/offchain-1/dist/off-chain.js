"use strict";
// import { BlockfrostProvider, MeshTxBuilder, MeshWallet, deserializeAddress } from "@meshsdk/core"
// const blockchainProvider = new BlockfrostProvider("preprod4XNNKV7AtEG8EjLc0kDwdIVoIVLx1x3F");
// const wallet = new MeshWallet({
//   networkId: 0, // 0: testnet, 1: mainnet
//   fetcher: blockchainProvider,
//   submitter: blockchainProvider,
//   key: {
//     type: 'mnemonic',
//     words: ["solution","solution","solution","solution","solution","solution","solution","solution","solution","solution","solution","solution","solution","solution","solution","solution","solution","solution","solution","solution","solution","solution","solution","solution"],
//   },
// });
// const wallet2 = new MeshWallet({
//     networkId: 0, // 0: testnet, 1: mainnet
//     fetcher: blockchainProvider,
//     submitter: blockchainProvider,
//     key: {
//       type: 'mnemonic',
//       words: ["solution","solution","solution","solution","solution","solution","solution","solution","solution","solution","solution","solution","solution","solution","solution","solution","solution","solution","solution","solution","solution","solution","solution","solution"],
//     },
//   });
// const address = await wallet.getChangeAddress();
// const utxos = await wallet.getUtxos();
// const utxos2 = await wallet2.getUtxos();
// const balance = await wallet.getBalance();
// const balance2 = await wallet2.getBalance();
// const { pubKeyHash: vk } = deserializeAddress(address);
Object.defineProperty(exports, "__esModule", { value: true });
// const txBuilder = new MeshTxBuilder({
//     fetcher: blockchainProvider,
//     submitter: blockchainProvider
// });
// const nami = "addr_test1qzu75psqc5c234da4tpzuqymmru6reqlaulq25k8ecqc53krhru8dgujmceyjamw6m636jzcdv834nkgll2nlpuyak6sf6wy9k"
// // Lock without Datum
// const lockWithoutDatumTx = await txBuilder
//     .txOut(nami, [{ unit: "lovelace", quantity: '5000000' }])
//     .changeAddress(address)
//     .selectUtxosFrom(utxos)
//     .complete();
// // const initialSignedTx = await wallet.signTx(lockWithoutDatumTx, true);
// const signedTx = await wallet.signTx(lockWithoutDatumTx, false);
// const txHash = await wallet.submitTx(signedTx);
// console.log(`\ntx hash: ${txHash}\n`);
// import {
//   BlockfrostProvider,
//   MeshTxBuilder,
//   MeshWallet,
//   deserializeAddress,
//   resolveScriptHash,
//   AssetMetadata,
//   Mint,
//   Transaction,
// } from "@meshsdk/core";
// import {
//   builtinByteString,
//   conStr,
//   mConStr0,
//   mConStr1,
//   outputReference,
//   PlutusScript,
//   scriptHash,
//   stringToHex,
//   UTxO,
// } from "@meshsdk/common";
// import { add } from "lodash";
// const blockchainProvider = new BlockfrostProvider(
//   "preprod4XNNKV7AtEG8EjLc0kDwdIVoIVLx1x3F"
// );
// const wallet = new MeshWallet({
//   networkId: 0, // 0: testnet, 1: mainnet
//   fetcher: blockchainProvider,
//   submitter: blockchainProvider,
//   key: {
//     type: "mnemonic",
//     words: [
//       "solution",
//       "solution",
//       "solution",
//       "solution",
//       "solution",
//       "solution",
//       "solution",
//       "solution",
//       "solution",
//       "solution",
//       "solution",
//       "solution",
//       "solution",
//       "solution",
//       "solution",
//       "solution",
//       "solution",
//       "solution",
//       "solution",
//       "solution",
//       "solution",
//       "solution",
//       "solution",
//       "solution",
//     ],
//   },
// });
// async function main() {
//   try {
//     const address = await wallet.getChangeAddress();
//     console.log("Address 1:", address);
//     const utxos = await wallet.getUtxos();
//     const balance = await wallet.getBalance();
//     // const { pubKeyHash: vk } = deserializeAddress(address);
//     // console.log("\nPublic Key Hash (vk):", vk);
//     const txBuilder = new MeshTxBuilder({
//       fetcher: blockchainProvider,
//       submitter: blockchainProvider,
//     });
    //     const nami =
    //       "addr_test1qzu75psqc5c234da4tpzuqymmru6reqlaulq25k8ecqc53krhru8dgujmceyjamw6m636jzcdv834nkgll2nlpuyak6sf6wy9k";
//     const scriptPolicy = resolveScriptHash(
//       "9c739c0759eb42eab83f8295e18a662cd681c7c3f30789c52d7b6c05",
//       "V3"
//     );
//     console.log("scriptPolicy", scriptPolicy);
//     const tokenName = "onetime";
//     const tokenNameHex = stringToHex(tokenName);
//     const metadata = {
//       [scriptPolicy]: {
//         [tokenNameHex]: {
//           name: "Ninja",
//           image: "https://avatars.githubusercontent.com/u/228866?v=4",
//           mediaType: "image/jpg",
//           description: "Hello world - CIP68",
//         },
//       },
//     };
//     const collateral: UTxO = (await wallet.getCollateral())[0];
//     if (!collateral) {
//       throw new Error("No collateral utxo found");
//     }
//     const script = "5902865902830101003332323232323232223225333005323232323253323300b3001300c3754004264a6660186004601a6ea80104c8c8c8c8c8c8c8c94ccc05cc0680084c94ccc054c8cc004004dd6180d980c1baa01022533301a00114a0264a66603066ebcc010c068dd5180e80100b8a51133003003001301d00115332330163232533301b301e00213253330193004375a6036004266e3c0040585281bae301900116301c001325333017300230183754002297adef6c6013756603860326ea8004c8cc004004dd5980e180e980e980e980e980c9baa01122533301b00114c103d87a8000132323232533301c337220220042a66603866e3c0440084cdd2a4000660406e980052f5c02980103d87a80001330060060033756603a0066eb8c06c008c07c008c0740044c94ccc05cc0340044c8c8cc004004dd6180f180f980f980f980f980f980f980f980f980d9baa01322533301d00114a0264a66603666e3cdd718100010020a511330030030013020001375c6038603a603a60326ea803c54ccc05cc0080044c8cc88c94ccc06cc018c070dd5000899b89375a6040603a6ea80040085281803180e1baa3003301c3754004603a603c603c603c603c603c603c603c60346ea8048dd69800980d1baa0102301d301e00114a06eb4c008c060dd50071b87480085280a502301a00116375a603000260300046eb8c058004c058008dd6980a000980a0011bad3012001300e37540082c6eb8c040c034dd50011b874800058c038c03c008c034004c034008c02c004c01cdd50008a4c26cac6eb80055cd2ab9d5573caae7d5d02ba1574498127d8799f5820f80aa721b878faae97ebc8722b505c74146264ed9e70436da2f1b65fb73fef0101ff004c0107464e415255544f0001"
//     const redeemer = {
//       data: { alternative: 0, fields: ["mesh"] },
//       tag: "MINT",
//    };
//     // Lock without Datum
//     // const lockWithoutDatumTx = await txBuilder
//     //     .txOut(nami, [{ unit: "lovelace", quantity: '5000000' }])
//     //     .changeAddress(address)
//     //     .selectUtxosFrom(utxos)
//     //     .complete();
//     // const signedTx = await wallet.signTx(lockWithoutDatumTx, false);
//     // const txHash = await wallet.submitTx(signedTx);
//     // const txBuilder = getTxBuilder();
//     const unsignedTx = await txBuilder
//       .mintPlutusScriptV3()
//       .mint("1", scriptPolicy, tokenNameHex)
//       .mintingScript(script)
//       .mintRedeemerValue(mConStr0(["mesh"]))
//       .metadataValue("721", metadata)
//       .changeAddress(address)
//       .selectUtxosFrom(utxos)
//       .txInCollateral(
//         collateral.input.txHash,
//         collateral.input.outputIndex,
//         collateral.output.amount,
//         collateral.output.address
//       )
//       .complete();
//     const signedTx = await wallet.signTx(unsignedTx, false);
//     const txHash = await wallet.submitTx(signedTx);
//     console.log(`\nTransaction submitted successfully!`);
//     // console.log(`Transaction hash: ${txHash}\n`);
//   } catch (error) {
//     console.error("An error occurred:", error);
//   }
// }
// // Execute the main function
// main().catch(console.error);
// off-chain.ts
const core_1 = require("@meshsdk/core");
const common_1 = require("@meshsdk/common");
const blockchainProvider = new core_1.BlockfrostProvider("preprod4XNNKV7AtEG8EjLc0kDwdIVoIVLx1x3F");
const wallet = new core_1.MeshWallet({
    networkId: 0, // 0: testnet, 1: mainnet
    fetcher: blockchainProvider,
    submitter: blockchainProvider,
    key: {
        type: "mnemonic",
        words: [
            "solution", "solution", "solution", "solution", "solution", "solution",
            "solution", "solution", "solution", "solution", "solution", "solution",
            "solution", "solution", "solution", "solution", "solution", "solution",
            "solution", "solution", "solution", "solution", "solution", "solution"
        ],
    },
});
async function main() {
    try {
        const address = await wallet.getChangeAddress();
        console.log("Address 1:", address);
        const utxos = await wallet.getUtxos();
        const balance = await wallet.getBalance();
        const txBuilder = new core_1.MeshTxBuilder({
            fetcher: blockchainProvider,
            submitter: blockchainProvider,
        });
        const nami = "addr_test1qzu75psqc5c234da4tpzuqymmru6reqlaulq25k8ecqc53krhru8dgujmceyjamw6m636jzcdv834nkgll2nlpuyak6sf6wy9k";
        const scriptPolicy = (0, core_1.resolveScriptHash)("9c739c0759eb42eab83f8295e18a662cd681c7c3f30789c52d7b6c05", "V3");
        console.log("scriptPolicy", scriptPolicy);
        const tokenName = "onetime";
        const tokenNameHex = (0, common_1.stringToHex)(tokenName);
        const metadata = {
            [scriptPolicy]: {
                [tokenNameHex]: {
                    name: "Ninja",
                    image: "https://avatars.githubusercontent.com/u/228866?v=4",
                    mediaType: "image/jpg",
                    description: "Hello world - CIP68",
                },
            },
        };
        const collateral = (await wallet.getCollateral())[0];
        if (!collateral) {
            throw new Error("No collateral utxo found");
        }
        const script = "5902865902830101003332323232323232223225333005323232323253323300b3001300c3754004264a6660186004601a6ea80104c8c8c8c8c8c8c8c94ccc05cc0680084c94ccc054c8cc004004dd6180d980c1baa01022533301a00114a0264a66603066ebcc010c068dd5180e80100b8a51133003003001301d00115332330163232533301b301e00213253330193004375a6036004266e3c0040585281bae301900116301c001325333017300230183754002297adef6c6013756603860326ea8004c8cc004004dd5980e180e980e980e980e980c9baa01122533301b00114c103d87a8000132323232533301c337220220042a66603866e3c0440084cdd2a4000660406e980052f5c02980103d87a80001330060060033756603a0066eb8c06c008c07c008c0740044c94ccc05cc0340044c8c8cc004004dd6180f180f980f980f980f980f980f980f980f980d9baa01322533301d00114a0264a66603666e3cdd718100010020a511330030030013020001375c6038603a603a60326ea803c54ccc05cc0080044c8cc88c94ccc06cc018c070dd5000899b89375a6040603a6ea80040085281803180e1baa3003301c3754004603a603c603c603c603c603c603c603c60346ea8048dd69800980d1baa0102301d301e00114a06eb4c008c060dd50071b87480085280a502301a00116375a603000260300046eb8c058004c058008dd6980a000980a0011bad3012001300e37540082c6eb8c040c034dd50011b874800058c038c03c008c034004c034008c02c004c01cdd50008a4c26cac6eb80055cd2ab9d5573caae7d5d02ba1574498127d8799f5820f80aa721b878faae97ebc8722b505c74146264ed9e70436da2f1b65fb73fef0101ff004c0107464e415255544f0001";
        const redeemer = {
            data: { alternative: 0, fields: ["mesh"] },
            tag: "MINT",
        };
        const unsignedTx = await txBuilder
            .mintPlutusScriptV3()
            .mint("1", scriptPolicy, tokenNameHex)
            .mintingScript(script)
            .mintRedeemerValue((0, common_1.mConStr0)(["mesh"]))
            .metadataValue("721", metadata)
            .changeAddress(address)
            .selectUtxosFrom(utxos)
            .txInCollateral(collateral.input.txHash, collateral.input.outputIndex, collateral.output.amount, collateral.output.address)
            .complete();
        const signedTx = await wallet.signTx(unsignedTx, false);
        const txHash = await wallet.submitTx(signedTx);
        console.log(`\nTransaction submitted successfully!`);
        console.log(`Transaction hash: ${txHash}\n`);
    }
    catch (error) {
        console.error("An error occurred:", error);
    }
}
// Execute the main function
main().catch(console.error);
