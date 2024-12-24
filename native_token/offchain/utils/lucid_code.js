"use strict";
var _a, _b;
Object.defineProperty(exports, "__esModule", { value: true });
var lucid_1 = require("@lucid-evolution/lucid");
var lucid_2 = require("@lucid-evolution/lucid");
var lucid = await (0, lucid_1.Lucid)(new lucid_1.Blockfrost("https://cardano-preview.blockfrost.io/api/v0", "previewJozgQD6aSv6vSmTI1XETNMLZh3eFWuZ4"), "Preview");
var policyID = "9c739c0759eb42eab83f8295e18a662cd681c7c3f30789c52d7b6c05";
var from_address = "addr_test1qp34n6649vgjct9nu4y5cx8c98wc64phsnp85f8kvg798z30xq8h446ltdty54y28v3ncd5wh57c5j4kvm02wu6ajttqtrxl43";
var utxos = await lucid.utxosAt(from_address);
lucid.selectWallet.fromAddress(from_address, utxos);
var to_address = "addr_test1qzu75psqc5c234da4tpzuqymmru6reqlaulq25k8ecqc53krhru8dgujmceyjamw6m636jzcdv834nkgll2nlpuyak6sf6wy9k";
var tx = await lucid
    .newTx()
    .mintAssets((_a = {},
    _a[policyID + (0, lucid_2.fromText)("Dragon")] = 1n,
    _a))
    .pay.ToAddress(to_address, (_b = {}, _b[policyID + (0, lucid_2.fromText)("Dragon")] = 1n, _b))
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
    } })
    .complete();
var signed = await tx.sign.withWallet().complete();
var txHash = await signed.submit();
