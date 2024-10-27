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
import bitsandbobs/ints
import gleam/bit_array
import gleam/list
import gleeunit/should

pub fn to_bitarray_test() -> Nil {
  5 |> ints.to_bitarray |> should.equal(<<5>>)
}

pub fn from_bitarray_test() -> Nil {
  <<5:32>> |> ints.from_bitarray |> should.equal(5)
}

pub fn from_x_test() -> Nil {
  <<5:32>> |> ints.from_x_bits(32) |> should.equal(Ok(5))
}

pub fn from_x_different_size_test() -> Nil {
  <<4095:12>> |> ints.from_x_bits(6) |> should.equal(Ok(63))
}

pub fn from_x_invalid_size_test() -> Nil {
  <<5:32>> |> ints.from_x_bits(64) |> should.be_error
}

pub fn map_test() -> Nil {
  list.range(0, 10)
  |> list.map(fn(x) { <<x:8>> })
  |> bit_array.concat
  |> ints.map(fn(x) { x * 2 })
  |> should.equal(<<0, 2, 4, 6, 8, 10, 12, 14, 16, 18, 20>>)
}

pub fn map_every_x_bits_test() -> Nil {
  list.range(0, 10)
  |> list.map(fn(x) { <<x:32>> })
  |> bit_array.concat
  |> ints.map_every_x_bits(32, fn(x) { x * 2 })
  |> should.equal(<<
    0:32, 2:32, 4:32, 6:32, 8:32, 10:32, 12:32, 14:32, 16:32, 18:32, 20:32,
  >>)
}

pub fn map_every_x_bits_dif_test() -> Nil {
  list.range(0, 10)
  |> list.map(fn(x) { <<x:32>> })
  |> bit_array.concat
  |> ints.map_every_x_bits(16, fn(x) { x * 2 })
  |> should.equal(<<
    0:16, 0:16, 0:16, 2:16, 0:16, 4:16, 0:16, 6:16, 0:16, 8:16, 0:16, 10:16,
    0:16, 12:16, 0:16, 14:16, 0:16, 16:16, 0:16, 18:16, 0:16, 20:16,
  >>)
}

pub fn add_8_test() -> Nil {
  ints.add(<<16:8, 5:8>>, <<4:8>>, 8)
  |> should.equal(<<16:8, 9:8>>)
}

// the public example
pub fn demo_test() -> Nil {
  <<5:32, 10:32>>
  |> ints.map_every_x_bits(32, fn(x) { x * 2 })
  |> ints.add(<<40:32, 45:32>>, 32)
  |> should.equal(<<50:32, 65:32>>)
}
