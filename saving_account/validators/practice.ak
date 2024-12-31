use aiken/collection/list
use cardano/transaction.{InlineDatum, OutputReference, Transaction}

validator prac {
  spend(
    datum: Option<Data>,
    redeemer: Int,
    oref: OutputReference,
    tx: Transaction,
  ) {
    expect Some(datum) = datum
    let Transaction(inputs, ..) = tx
    expect input1 =
      list.find(inputs, fn(input) { input.output_reference == oref })

    // expect InlineDatum(some_datum) = input1.output.datum
    // expect Script(poli) = input1.output.address.payment_credential
    True
  }

  else(_) {
    fail
  }
}

// find ref_input and Datum type
// let ref_input =
//   utils.find_ref_input_with_config_nft(reference_inputs, config_nft)
// // expect InlineDatum(output_datum) = ref_input.output.datum
// let config_datum: ConfigDatum = d.input_to_config_datum(ref_input)

fn add(x) {
  x + 55
}

fn add1(x) {
  fn() { x + 55 }
}

test test_add() {
  add(2) == 57
}

test test_add1() {
  add1(2)() == 57
  // Call the closure returned by add1
}
//   let must_spend_two_nodes =
//     fn() { list.length(common.node_inputs) == 2 }
