utxoin1="c98fe6e2920163a44d43d60d94fb58d89e1e20aacf03446cbeaef0dd4f4b898f#1"
policyid="5d555ff7b4b9d722e0e1d7e55f43e8e5fd69209ca891b7de93e94ab4"
output="12000000"
tokenamount="69"
tokenname="44594e414d4f"
mintingScript="/home/faizan/AIKEN/learning/native_token/offchain/coin.uplc"
collateral="e80e39a04934d177211c93c5169a5fd5908eb355a49d623483c72ed4ae10096e#0"
signerPKH="6359eb552b112c2cb3e5494c18f829dd8d543784c27a24f6623c538a"  #ALice Pubkey hash
PREVIEW="--testnet-magic 2"
ALICE_ADDR="addr_test1qp34n6649vgjct9nu4y5cx8c98wc64phsnp85f8kvg798z30xq8h446ltdty54y28v3ncd5wh57c5j4kvm02wu6ajttqtrxl43"
nami="addr_test1qzu75psqc5c234da4tpzuqymmru6reqlaulq25k8ecqc53krhru8dgujmceyjamw6m636jzcdv834nkgll2nlpuyak6sf6wy9k"
redeemer="/home/faizan/AIKEN/learning/native_token/offchain/redeemer.json"
ALICE_SKEY="/home/faizan/AIKEN/learning/address/alice.skey"
notneeded="--invalid-hereafter 10962786"

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
  --invalid-hereafter 1730517385 \
  --out-file mintTime.unsigned

cardano-cli conway transaction sign \
    --tx-body-file mintTx.unsigned \
    --signing-key-file $ALICE_SKEY \
    $PREVIEW \
    --out-file mintTime.signed

 cardano-cli conway transaction submit \
    $PREVIEW \
    --tx-file mintTime.signed