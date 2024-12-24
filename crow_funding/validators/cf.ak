use aiken/collection/list
use aiken/crypto.{VerificationKeyHash}
use aiken/interval
use cardano/address.{Address}
use cardano/transaction.{
  Datum, InlineDatum, Output, OutputReference, Transaction,
}

/// shorthand notation for custom types
/// the full version would have the explicit Data Constructor like
/// type Datum { Datum {...fields are the same...} }
pub type CFdatum {
  // CFDatum {
    campaign_id: Int,
    title: ByteArray,
    goal: Int,
    creator: VerificationKeyHash,
    backer: VerificationKeyHash,
    amount: Int,
    deadline: Int,
    current_funds: Int,
  }
  // BackerDatum { 
  //   campaign_id: Int,
  //   backer: VerificationKeyHash,
  //   amount: Int }
  //}

/// Actions Enumerator
///  0 -> Cancel Campaign
///  1 -> Support Campaign
///  2 -> 
///
pub type Action =
  Int

pub type CFredeemer {
  campaign_id: Int,
  action: Action,
  amount: Int,
  backer: VerificationKeyHash,
}

validator manage_campaign {
  spend(
    datum: Option<CFdatum>,
    redeemer: CFredeemer,
    utxo: OutputReference,
    transaction: Transaction,
  ) {
    expect Some(datum) = datum

    when redeemer.action is {
      0 ->
        cancel_campaign(
          datum,
          redeemer.campaign_id,
          transaction.extra_signatories,
        )

      1 -> support_campaign(datum, redeemer.campaign_id, utxo, transaction)

      2 -> claims(datum, redeemer.campaign_id, transaction)
      _ -> fail
    }
  }

  else(_) {
    fail
  }
}


fn cancel_campaign(
  datum: CFdatum,
  campaign_id: Int,
  signatories: List<VerificationKeyHash>,
) -> Bool {
  datum.campaign_id == campaign_id && datum.current_funds == 0 && datum.amount == 0 && datum.backer == "" && must_be_signed_by(
    datum.creator,
    signatories,
  )
}

fn support_campaign(
  datum: CFdatum,
  campaign_id: Int,
  utxo: OutputReference,
  tx: Transaction,
) -> Bool {
  expect Some(input_utxo) = transaction.find_input(tx.inputs, utxo)
  let input_datum = input_utxo.output.datum
  and {
    (datum.campaign_id == campaign_id)?,
    must_be_signed_by(datum.backer, tx.extra_signatories)?,
    datum_creator_match(datum, input_datum),
    must_be_sent_to_script(input_utxo.output.address, tx.outputs),
  }
}


fn claims(datum: CFdatum, campaign_id: Int, tx: Transaction) -> Bool {
  (datum.campaign_id == campaign_id)? && (
    (datum.current_funds >= datum.goal)? || interval.is_entirely_after(
      tx.validity_range,
      datum.deadline,
    )?
  ) && must_be_signed_by(
    datum.creator,
    tx.extra_signatories,
  )
}

fn must_be_signed_by(
  signer: VerificationKeyHash,
  signatories: List<VerificationKeyHash>,
) -> Bool {
  list.has(signatories, signer)
}


fn must_be_sent_to_script(address: Address, outputs: List<Output>) -> Bool {
  let counter =
    list.count(outputs, fn(output) -> Bool { output.address == address })
  counter == 1
}


fn datum_creator_match(datum: CFdatum, tx_datum: Datum) -> Bool {
  when tx_datum is {

    InlineDatum(datum_data) -> {
      // let Pair(key, datalist) = un_constr_data(datum_data)
      expect input_datum: CFdatum = datum_data
      input_datum.creator == datum.creator
    }
    _ -> False
  }
}

