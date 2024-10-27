//  Copyright 2024 BradBot_1

//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at

//      http://www.apache.org/licenses/LICENSE-2.0

//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
import bitsandbobs
import gleam/bit_array
import gleam/int
import gleam/list

/// Converts an Int to a BitArray
pub fn to_bitarray(int: Int) -> BitArray {
  <<int>>
}

/// Converts a BitArray to an Int
/// A short hand for `bitsandbobs.bit_size` into `from_x_bits`
@external(javascript, "../bitsandbobs_ffi.mjs", "int_from_bitarray")
pub fn from_bitarray(bitarray: BitArray) -> Int {
  let assert Ok(int) =
    bitarray |> bitsandbobs.bit_size |> from_x_bits(bitarray, _)
  int
}

/// Reads a BitArray into an Int by reading the specified number of bits
/// If the BitArray is not long enough, returns an Error
@external(javascript, "../bitsandbobs_ffi.mjs", "int_from_x_bits")
pub fn from_x_bits(bitarray: BitArray, bit_count: Int) -> Result(Int, Nil) {
  case bitarray {
    <<ret:size(bit_count), _rest:bits>> -> Ok(ret)
    _ -> Error(Nil)
  }
}

/// A short hand for `map_every_x_bits` with a size of 8
pub fn map(bitarray: BitArray, f: fn(Int) -> Int) -> BitArray {
  map_every_x_bits(bitarray, 8, f)
}

/// Maps a function over a BitArray by reading the specified number of bits at a time
pub fn map_every_x_bits(
  bitarray: BitArray,
  every: Int,
  f: fn(Int) -> Int,
) -> BitArray {
  bitsandbobs.map(bitarray, every, fn(x) {
    let assert Ok(int) = x |> from_x_bits(every)
    let ret = int |> f
    <<ret:size(every)>>
  })
}

/// Adds two BitArrays together by splitting them into BitArrays of the specified size and then adding them together, finally concatenating them back into a BitArray
pub fn add(first: BitArray, second: BitArray, size: Int) -> BitArray {
  let first_size = bitsandbobs.bit_size(first)
  let second_size = bitsandbobs.bit_size(second)
  let padded_size = int.max(first_size, second_size) |> int.max(size)

  case first_size {
    s if s < padded_size ->
      first |> bitsandbobs.pad(padded_size - first_size) |> add(second, size)
    _ ->
      case second_size {
        s if s < padded_size ->
          second
          |> bitsandbobs.pad(padded_size - second_size)
          |> add(first, size)
        _ ->
          bitsandbobs.zip(first, second, size)
          |> list.map(fn(x) {
            let #(first, second) = x
            let assert Ok(first) = first |> from_x_bits(size)
            let assert Ok(second) = second |> from_x_bits(size)
            let result = first + second
            <<result:size(size)>>
          })
          |> bit_array.concat
      }
  }
}
