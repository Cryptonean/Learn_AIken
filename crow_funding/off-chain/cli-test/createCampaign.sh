utxoin="c2f6c87f267d4620a1ddeccdf1abbda5b91232ba3d81f2e9f7a32e6ab3fb202d#2"
address="addr_test1qzu75psqc5c234da4tpzuqymmru6reqlaulq25k8ecqc53krhru8dgujmceyjamw6m636jzcdv834nkgll2nlpuyak6sf6wy9k"
output="500000000"
PREVIEW="--testnet-magic 2"
ALICE="addr_test1qp34n6649vgjct9nu4y5cx8c98wc64phsnp85f8kvg798z30xq8h446ltdty54y28v3ncd5wh57c5j4kvm02wu6ajttqtrxl43"

cardano-cli conway transaction build \
  $PREVIEW \
  --tx-in $utxoin \
  --tx-out $address+$output \
  --tx-out-datum-hash-file ../values/CFdatum.json \
  --change-address $ALICE\
  --out-file createCampaign.unsigned

cardano-cli conway transaction sign \
    --tx-body-file createCampaign.unsigned \
    --signing-key-file /home/faizan/AIKEN/learning/address/alice.skey \
    $PREVIEW \
    --out-file createCampaign.signed

cardano-cli conway transaction submit \
    $PREVIEW \
    --tx-file createCampaign.signed