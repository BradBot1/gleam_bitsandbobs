import gleam/bit_array
import gleam/list

/// Splits a BitArray into a list of BitArrays of the specified size
/// Will leave trailing bits in the last BitArray if the BitArray is not evenly divisible by the specified size
/// If the specified size is greater than the BitArray size, the BitArray will be returned as a singleton list
@external(javascript, "./bitsandbobs_ffi.mjs", "split_every_x_bits")
pub fn split_every_x_bits(bitarray: BitArray, every: Int) -> List(BitArray) {
  case bitarray {
    <<chunk:bits-size(every), rest:bits>> ->
      list.append([chunk], split_every_x_bits(rest, every))
    remainder ->
      case remainder |> is_atleast_x_bits(1) {
        False -> []
        True -> [remainder]
      }
  }
}

/// Determines if a BitArray is at least the specified size, will return negatives as False
@external(javascript, "./bitsandbobs_ffi.mjs", "is_atleast_x_bits")
pub fn is_atleast_x_bits(bitarray: BitArray, mininum: Int) -> Bool {
  case bitarray {
    <<_:size(mininum), _:bits>> -> True
    _ -> False
  }
}

/// Returns the size of a BitArray in bits by reading 8 bits at a time recursively
/// This is a recursive function, so for larger bit arrays look to using `bit_size_x` with a custom starting size
pub fn bit_size(bitarray: BitArray) -> Int {
  bit_size_recursive(bitarray, 8)
}

/// A version of `bit_size` that allows you to specify the starting size
pub fn bit_size_x(bitarray: BitArray, starting_size: Int) -> Int {
  case starting_size {
    s if s < 1 -> panic as "Invalid starting size, must be atleast 1"
    _ -> bit_size_recursive(bitarray, starting_size)
  }
}

@external(javascript, "./bitsandbobs_ffi.mjs", "bit_size_recursive")
fn bit_size_recursive(bitarray: BitArray, read_size: Int) -> Int {
  case bitarray {
    <<_:size(read_size), rest:bits>> ->
      read_size + bit_size_recursive(rest, read_size)
    _ ->
      case read_size / 2 {
        0 -> 0
        new_read_size -> bit_size_recursive(bitarray, new_read_size)
      }
  }
}

/// Splits a BitArray into a list of BitArrays of the specified size, performs an operation defined by the function on each BitArray and then appends the results back into a bit array
pub fn map(
  bitarray: BitArray,
  every: Int,
  f: fn(BitArray) -> BitArray,
) -> BitArray {
  split_every_x_bits(bitarray, every)
  |> list.map(f)
  |> bit_array.concat
}

/// Zips two BitArrays together by splitting them into BitArrays of the specified size and then `list.zip`-ping them together
pub fn zip(
  first: BitArray,
  second: BitArray,
  every: Int,
) -> List(#(BitArray, BitArray)) {
  list.zip(split_every_x_bits(first, every), split_every_x_bits(second, every))
}

/// Pads the start of a bitarray with zeros
pub fn pad(bitarray: BitArray, amount_of_padding: Int) -> BitArray {
  bit_array.append(<<0:size(amount_of_padding)>>, bitarray)
}

@external(javascript, "./bitsandbobs_ffi.mjs", "bits_required_to_represent_x_bits")
pub fn bits_required_to_represent_x_bits(int: Int) -> Int {
  int
}
