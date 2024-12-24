import {Lucid, Blockfrost, Credential, Constr, applyDoubleCborEncoding, applyParamsToScript} from "@lucid-evolution/lucid";
import { Address, Data, fromText, LucidEvolution, MintingPolicy, SpendingValidator, TxSignBuilder, UTxO } from "@lucid-evolution/lucid";
import { mintingPolicyToId, paymentCredentialOf, validatorToAddress } from "npm:@lucid-evolution/utils";


 
const lucid = await Lucid(
  new Blockfrost("https://cardano-preview.blockfrost.io/api/v0", "previewJozgQD6aSv6vSmTI1XETNMLZh3eFWuZ4"),
  "Preview"
);

const policyID = "9c739c0759eb42eab83f8295e18a662cd681c7c3f30789c52d7b6c05"
const from_address = "addr_test1qp34n6649vgjct9nu4y5cx8c98wc64phsnp85f8kvg798z30xq8h446ltdty54y28v3ncd5wh57c5j4kvm02wu6ajttqtrxl43"; 
const utxos = await lucid.utxosAt(from_address);
lucid.selectWallet.fromAddress(from_address, utxos);

const to_address="addr_test1qzu75psqc5c234da4tpzuqymmru6reqlaulq25k8ecqc53krhru8dgujmceyjamw6m636jzcdv834nkgll2nlpuyak6sf6wy9k"

const tx = await lucid
  .newTx()
  .mintAssets({
    [policyID + fromText("Dragon")]: 1n  })
  .pay.ToAddress(to_address, {[policyID + fromText("Dragon")]: 1n })
  .attach.MintingPolicy(policyID)
  .attachMetadata(1, { "721": {
        "9c739c0759eb42eab83f8295e18a662cd681c7c3f30789c52d7b6c05": {  
          "Pokemon": {
            "description": "ASH",
            "name": "Pokemon",
            "id": 1,
            "image": "https://avatars.githubusercontent.com/u/68136265?v=4"
          }
        }
    }})
  .complete();
 
const signed = await tx.sign.withWallet().complete();
const txHash = await signed.submit();



