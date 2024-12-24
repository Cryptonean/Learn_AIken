use aiken/collection/dict
use aiken/collection/list
use aiken/interval.{Finite}
use cardano/address.{Credential, Script}
use cardano/assets.{Lovelace, PolicyId}
use cardano/transaction.{Output, OutputReference, Transaction, ValidityRange}

pub type Multisig {
  Signature { key_hash: ByteArray }
  AtLeast { required: Int, scripts: List<Multisig> }
  AnyOf { scripts: List<Multisig> }
}

pub type MintDatum {
  nft_policy: ByteArray,
  nft_name: ByteArray,
}

pub type SpendDatum {
  required_signatures: Multisig,
  validity_slot: Int,
}

validator nft_contract {
  // Mint hadler
  mint(_r, policy_id: PolicyId, tx: Transaction) {
    expect [Pair(_, qty)] =
      tx.mint
        |> assets.tokens(policy_id)
        |> dict.to_pairs()
    and {
      qty == 1,
      True,
    }
  }

  spend(datum: Option<SpendDatum>, _r, oref: OutputReference, tx: Transaction) {
    expect Some(datum) = datum
    let Transaction { inputs, .. } = tx
    let valid =
      when tx.validity_range.upper_bound.bound_type is {
        Finite(slot) -> slot <= datum.validity_slot
        _ -> False
      }
    let multisig_valid =
      satisfied(
        datum.required_signatures,
        tx.extra_signatories,
        tx.validity_range,
        tx.withdrawals,
      )

    expect Some(own_input) =
      list.find(inputs, fn(input) { input.output_reference == oref })
    expect Script(policy_id) = own_input.output.address.payment_credential
    expect [Pair(_, qty)] =
      tx.mint
        |> assets.tokens(policy_id)
        |> dict.to_pairs()
    let nft_transfered =
      list.any(
        tx.outputs,
        fn(output) {
          and {
            qty == 1,
            True,
          }
        },
      )
    and {
      valid,
      multisig_valid,
      nft_transfered,
    }
  }

  else(_) {
    fail
  }
}

//modified as per our use
pub fn satisfied1(script: Multisig, signatories: List<ByteArray>) -> Bool {
  when script is {
    Signature { key_hash } -> list.has(signatories, key_hash)
    AtLeast { required, scripts } ->
      required <= list.count(scripts, fn(s) { satisfied(s, signatories) })
    AnyOf { scripts } -> list.any(scripts, fn(s) { satisfied1(s, signatories) })
  }
}
