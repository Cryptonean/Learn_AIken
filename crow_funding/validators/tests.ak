// use cardano/transaction.{OutputReference, Transaction}
// use campaign_mng.{CFdatum, CFredeemer}

// test cancel_campaign() {
//   let utxo_ref = OutputReference("", 0)
//   let datum =
//     CFdatum {
//       campaign_id: 1,
//       title: "Demo Campaign ",
//       goal: 100000000,
//       creator: "AFDA",
//       backer: "",
//       amount: 0,
//       deadline: 100,
//       current_funds: 0,
//     }

//   let wrong_datum =
//     CFdatum {
//       campaign_id: 1,
//       title: "Demo Campaign",
//       goal: 0,
//       creator: "",
//       backer: "AFDB",
//       amount: 10_000_000,
//       deadline: 0,
//       current_funds: 0,
//     }

//   let redeemer = CFredeemer { campaign_id: 1, action: 0, amount: 0, backer: "" }

//   let tx_info =
//      Transaction { ..transaction.placeholder, extra_signatories: ["AFDA"] }
//   and {
//     campaign_mng.manage_campaign.spend(Some(datum), redeemer, utxo_ref, tx_info),
//     campaign_mng.manage_campaign.spend(
//       Some(wrong_datum),
//       redeemer,
//       utxo_ref,
//       tx_info,
//     )==False ,
//   }
// }


use aiken/interval
use cardano/address.{from_verification_key}
use cardano/assets.{from_lovelace}
use cardano/transaction.{
  InlineDatum, Input, Output, OutputReference, Transaction, placeholder
}
use cf.{CFdatum, CFredeemer}

test cf_cancel_campaign_v01() {
  let utxo_ref = OutputReference("", 0)
  let datum =
    CFdatum {
      campaign_id: 1,
      title: "Demo Campaign ",
      goal: 100000000,
      creator: "AFDA",
      backer: "",
      amount: 0,
      deadline: 100,
      current_funds: 0,
    }
  let wrong_datum =
    CFdatum {
      campaign_id: 1,
      title: "Demo Campaign ",
      goal: 0,
      creator: "",
      backer: "AFDB",
      amount: 10_000_000,
      deadline: 0,
      current_funds: 0,
    }
  let redeemer = CFredeemer { campaign_id: 1, action: 0, amount: 0, backer: "" }
  let tx_info =
    Transaction { ..transaction.placeholder, extra_signatories: ["AFDA"] }
  and {
    cf.manage_campaign.spend(Some(datum), redeemer, utxo_ref, tx_info),
    cf.manage_campaign.spend(Some(wrong_datum), redeemer, utxo_ref, tx_info) == False,
  }
}

test cf_update_campaign_v01() {
  let cfdatum =
    CFdatum {
      campaign_id: 1,
      title: "Demo Campaign",
      goal: 100000000,
      creator: "AFDA",
      backer: "AFDB",
      amount: 0,
      deadline: 100,
      current_funds: 0,
    }
  let utxo_ref = OutputReference("", 0)

  let addr =
    from_verification_key(
      "#5820f695aa0d03c039fc293803da371873cb6e757d3f6ac113f28647c97fbc25bf0d",
    )
  let output =
    Output {
      address: addr,
      value: from_lovelace(10000000),
      datum: InlineDatum(cfdatum),
      reference_script: None,
    }
  let input = Input { output_reference: utxo_ref, output }
  let tx_info = 
    Transaction {
      ..placeholder,
      extra_signatories: ["AFDB"],
      inputs: [input],
      outputs: [output],
    } 

  let redeemer = CFredeemer { campaign_id: 1, action: 1, amount: 0, backer: "" }
  cf.manage_campaign.spend(Some(cfdatum), redeemer, utxo_ref, tx_info) == True
}

test cf_claim_campaign_v01() {
  let utxo_ref = OutputReference("", 0)
  let tx_info =
    Transaction {
      ..transaction.placeholder,
      extra_signatories: ["AFDA"],
      validity_range: interval.entirely_after(1001),
    }
  let datum =
    CFdatum {
      campaign_id: 1,
      title: "Demo Campaign",
      goal: 100000000,
      creator: "AFDA",
      backer: "AFDB",
      amount: 0,
      deadline: 100,
      current_funds: 1000000,
    }
  let redeemer = CFredeemer { campaign_id: 1, action: 2, amount: 0, backer: "" }
  cf.manage_campaign.spend(Some(datum), redeemer, utxo_ref, tx_info) == True
}
