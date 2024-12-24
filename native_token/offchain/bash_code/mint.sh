utxoin1="9910bb423bfe4614726eda688b895ab0cf84b7f298695c87de26df9894a4f4b6#1"
policyid=$(cat ../coin.pid)
output="22000000"
tokenamount="101"
tokenname="444543454e5452414c"
mintingScript="/home/faizan/AIKEN/learning/native_token/offchain/coin.uplc"
collateral="e80e39a04934d177211c93c5169a5fd5908eb355a49d623483c72ed4ae10096e#0"
signerPKH="6359eb552b112c2cb3e5494c18f829dd8d543784c27a24f6623c538a"  #ALice Pubkey hash
PREVIEW="--testnet-magic 2"
ALICE_ADDR="addr_test1qp34n6649vgjct9nu4y5cx8c98wc64phsnp85f8kvg798z30xq8h446ltdty54y28v3ncd5wh57c5j4kvm02wu6ajttqtrxl43"
nami="addr_test1qzu75psqc5c234da4tpzuqymmru6reqlaulq25k8ecqc53krhru8dgujmceyjamw6m636jzcdv834nkgll2nlpuyak6sf6wy9k"
redeemer="/home/faizan/AIKEN/learning/native_token/offchain/redeemer.json"
ALICE_SKEY="/home/faizan/AIKEN/learning/address/alice.skey"

cardano-cli conway transaction build \
  $PREVIEW \
  --tx-in $utxoin1 \
  --required-signer-hash $signerPKH \
  --tx-in-collateral $collateral \
  --tx-out $nami+$output+"$tokenamount $policyid.$tokenname" \
  --change-address $ALICE_ADDR \
  --mint "$tokenamount $policyid.$tokenname" \
  --mint-script-file $mintingScript \
  --mint-redeemer-file $redeemer \
  --out-file mintTx.unsigned

cardano-cli conway transaction sign \
    --tx-body-file mintTx.unsigned \
    --signing-key-file $ALICE_SKEY \
    $PREVIEW \
    --out-file mintTx.signed

 cardano-cli conway transaction submit \
    $PREVIEW \
    --tx-file mintTx.signed