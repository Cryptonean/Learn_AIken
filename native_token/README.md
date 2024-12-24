# native_token

Write validators in the `validators` folder, and supporting functions in the `lib` folder using `.ak` as a file extension.

```aiken
validator my_first_validator {
  spend(_datum: Option<Data>, _redeemer: Data, _output_reference: Data, _context: Data) {
    True
  }
}
```

## Building

```sh
aiken build
```

## Configuring

**aiken.toml**
```toml
[config.default]
network_id = 41
```

Or, alternatively, write conditional environment modules under `env`.

## Testing

You can write tests in any module using the `test` keyword. For example:

```aiken
use config

test foo() {
  config.network_id + 1 == 42
}
```

To run all tests, simply do:

```sh
aiken check
```

To run only tests matching the string `foo`, do:

```sh
aiken check -m foo
```

## Documentation

If you're writing a library, you might want to generate an HTML documentation for it.

Use:

```sh
aiken docs
```

## Resources

Find more on the [Aiken's user manual](https://aiken-lang.org).



# for NFT with parameter the flow will be

1. aiken build
2. copy the past it in the applyParam.sh
3. in applyParams.sh put the utxo and id
4. also put the hex of the NFT name
5. run that applyParams.sh with the apply_parmas.sh script
6. so you will get te uplc , its the uplc in which we applied parmas
7. to get the policyid run cardano-cli conway transaction policyid --script-file Params_nft.uplc
8. paste that uplc or paste the path in mint_NFT.sh
9. in metatdata first is the policyid and than name
10. in redemeer mention the pkh of signer