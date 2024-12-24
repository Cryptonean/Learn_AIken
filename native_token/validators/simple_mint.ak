use aiken/collection/dict
use cardano/assets.{PolicyId, Value}
use cardano/transaction.{Transaction}

pub type Action {
  Mint
  Burn
}

validator check_redeemer {
  mint(redeemer action: Action, policy_id: PolicyId, tx: Transaction) {
    let Transaction { mint, inputs, .. } = tx
    let mint_qty = mint |> mint_qty(policy_id)
    when action is {
      Mint -> (mint_qty == 1)?
      Burn -> (mint_qty == -1)?
    }
  }

  else(_) {
    fail
  }
}

pub fn mint_qty(mint: Value, policy_id: PolicyId) -> Int {
  expect [Pair(_, qty)] =
    mint
      |> assets.tokens(policy_id)
      |> dict.to_pairs()
  qty
}
