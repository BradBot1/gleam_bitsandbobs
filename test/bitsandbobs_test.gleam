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
import gleam/list
import gleeunit
import gleeunit/should

pub fn main() {
  gleeunit.main()
}

pub fn split_equal_test() -> Nil {
  <<1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16>>
  |> bitsandbobs.split_every_x_bits(4 * 8)
  |> should.equal([
    <<1, 2, 3, 4>>,
    <<5, 6, 7, 8>>,
    <<9, 10, 11, 12>>,
    <<13, 14, 15, 16>>,
  ])
}

pub fn split_unequal_test() -> Nil {
  <<1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16>>
  |> bitsandbobs.split_every_x_bits(3 * 8)
  |> should.equal([
    <<1, 2, 3>>,
    <<4, 5, 6>>,
    <<7, 8, 9>>,
    <<10, 11, 12>>,
    <<13, 14, 15>>,
    <<16>>,
  ])
}

pub fn is_atleast_x_bits_test() -> Nil {
  let counter = list.range(0, 8)
  counter
  |> list.map(fn(x) { <<5:8>> |> bitsandbobs.is_atleast_x_bits(x) })
  |> list.map(should.be_true)
  Nil
}

pub fn is_atleast_x_bits_invalid_test() -> Nil {
  let counter = list.range(9, 200)
  counter
  |> list.map(fn(x) { <<5:8>> |> bitsandbobs.is_atleast_x_bits(x) })
  |> list.map(should.be_false)
  Nil
}

pub fn is_atleast_x_bits_invalid_negative_test() -> Nil {
  let counter = list.range(-1, -9)
  counter
  |> list.map(fn(x) { <<5:8>> |> bitsandbobs.is_atleast_x_bits(x) })
  |> list.map(should.be_false)
  Nil
}

pub fn bit_size_0_test() -> Nil {
  <<>> |> bitsandbobs.bit_size |> should.equal(0)
}

pub fn bit_size_1_test() -> Nil {
  <<2:1>> |> bitsandbobs.bit_size |> should.equal(1)
}

pub fn bit_size_2_test() -> Nil {
  <<2:2>> |> bitsandbobs.bit_size |> should.equal(2)
}

pub fn bit_size_3_test() -> Nil {
  <<2:3>> |> bitsandbobs.bit_size |> should.equal(3)
}

pub fn bit_size_4_test() -> Nil {
  <<5:4>> |> bitsandbobs.bit_size |> should.equal(4)
}

pub fn bit_size_5_test() -> Nil {
  <<5:5>> |> bitsandbobs.bit_size |> should.equal(5)
}

pub fn bit_size_7_test() -> Nil {
  <<5:7>> |> bitsandbobs.bit_size |> should.equal(7)
}

pub fn bit_size_8_test() -> Nil {
  <<5:8>> |> bitsandbobs.bit_size |> should.equal(8)
}

pub fn bit_size_16_test() -> Nil {
  <<5:16>> |> bitsandbobs.bit_size |> should.equal(16)
}

pub fn bit_size_32_test() -> Nil {
  <<5:32>> |> bitsandbobs.bit_size |> should.equal(32)
}

pub fn bit_size_64_test() -> Nil {
  <<5:64>> |> bitsandbobs.bit_size |> should.equal(64)
}

pub fn bit_size_128_test() -> Nil {
  <<5:128>> |> bitsandbobs.bit_size |> should.equal(128)
}

pub fn bit_size_256_test() -> Nil {
  <<5:256>> |> bitsandbobs.bit_size |> should.equal(256)
}

pub fn bit_size_512_test() -> Nil {
  <<5:512>> |> bitsandbobs.bit_size |> should.equal(512)
}

pub fn bit_size_1024_test() -> Nil {
  <<5:1024>> |> bitsandbobs.bit_size |> should.equal(1024)
}

pub fn bit_size_2048_test() -> Nil {
  <<5:2048>> |> bitsandbobs.bit_size |> should.equal(2048)
}

pub fn bit_size_4096_test() -> Nil {
  <<5:4096>> |> bitsandbobs.bit_size |> should.equal(4096)
}

pub fn map_test() -> Nil {
  <<1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16>>
  |> bitsandbobs.map(8, fn(x) { <<x:bits, 1:8>> })
  |> should.equal(<<
    1, 1, 2, 1, 3, 1, 4, 1, 5, 1, 6, 1, 7, 1, 8, 1, 9, 1, 10, 1, 11, 1, 12, 1,
    13, 1, 14, 1, 15, 1, 16, 1,
  >>)
}

pub fn zip_test() -> Nil {
  bitsandbobs.zip(<<5:32, 10:32>>, <<40:32, 45:32>>, 32)
  |> should.equal([#(<<5:32>>, <<40:32>>), #(<<10:32>>, <<45:32>>)])
}

pub fn pad_test() -> Nil {
  bitsandbobs.pad(<<5:8>>, 24)
  |> should.equal(<<0:8, 0:8, 0:8, 5:8>>)
}
