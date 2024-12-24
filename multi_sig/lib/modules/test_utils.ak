use aiken/cbor
use aiken/primitive/bytearray
use aiken/primitive/string

pub const exmaple_enables: Int = 1

pub fn trace_example(label: String, a) -> Bool {
  if exmaple_enables > 0 {
    trace string.join([label, bytearray.to_hex(cbor.serialise(a))], @": ")
    True
  } else {
    True
  }
}
