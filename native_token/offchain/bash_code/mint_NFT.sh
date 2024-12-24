utxoin1="7103cd0400f406324cc4456364288262e090b4a4fd52d471d7e9c128f666bb9a#1" #give same utxo as given in param in file applyParams.ts
policyid=$(cat /home/faizan/AIKEN/learning/native_token/offchain/pokemon.pid)  #to get policyid -first do aiken b , copy cbor, give it to applyParams, run it copy that cbor give it here than use cardano-cli conway transaction policyid --script-file Params_nft.uplc
output="3000000"
tokenamount="1"
tokenname="506f6b656d6f6e"
mintingScript="/home/faizan/AIKEN/learning/native_token/offchain/pokemon.uplc"
collateral="e19d234d2e7cdeb6118530eeed4509870d0ffa7d48e830b4161070dc94f8b6fe#0"
ownerPKH="6359eb552b112c2cb3e5494c18f829dd8d543784c27a24f6623c538a"
notneeded="--invalid-hereafter 10962786"
ALICE_ADDR="addr_test1qp34n6649vgjct9nu4y5cx8c98wc64phsnp85f8kvg798z30xq8h446ltdty54y28v3ncd5wh57c5j4kvm02wu6ajttqtrxl43"
ALICE_SKEY=/home/faizan/AIKEN/learning/address/alice.skey
nami="addr_test1qzu75psqc5c234da4tpzuqymmru6reqlaulq25k8ecqc53krhru8dgujmceyjamw6m636jzcdv834nkgll2nlpuyak6sf6wy9k"
PREVIEW="--testnet-magic 2"

cardano-cli conway transaction build \
  $PREVIEW \
  --tx-in $utxoin1 \
  --required-signer-hash $ownerPKH \
  --tx-in-collateral $collateral \
  --tx-out $nami+$output+"$tokenamount $policyid.$tokenname" \
  --change-address $ALICE_ADDR \
  --mint "$tokenamount $policyid.$tokenname" \
  --mint-script-file $mintingScript \
  --mint-redeemer-file ../values/redeemer.json \
  --metadata-json-file ../values/NFTmetadata.json \
  --out-file mint_NFT.unsigned

cardano-cli conway transaction sign \
    --tx-body-file mint_NFT.unsigned \
    --signing-key-file $ALICE_SKEY \
    $PREVIEW \
    --out-file mint_NFT.signed

 cardano-cli conway transaction submit \
    $PREVIEW \
    --tx-file mint_NFT.signed