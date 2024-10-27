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
import gleam/int

pub fn and(first: BitArray, second: BitArray) -> BitArray {
  ints.to_bitarray(int.bitwise_and(
    ints.from_bitarray(first),
    ints.from_bitarray(second),
  ))
}

pub fn or(first: BitArray, second: BitArray) -> BitArray {
  ints.to_bitarray(int.bitwise_or(
    ints.from_bitarray(first),
    ints.from_bitarray(second),
  ))
}

pub fn xor(first: BitArray, second: BitArray) -> BitArray {
  ints.to_bitarray(int.bitwise_exclusive_or(
    ints.from_bitarray(first),
    ints.from_bitarray(second),
  ))
}

pub fn not(first: BitArray) -> BitArray {
  ints.to_bitarray(int.bitwise_not(ints.from_bitarray(first)))
}

pub fn lshift(first: BitArray, amount: Int) -> BitArray {
  ints.to_bitarray(int.bitwise_shift_left(ints.from_bitarray(first), amount))
}

pub fn rshift(first: BitArray, amount: Int) -> BitArray {
  ints.to_bitarray(int.bitwise_shift_right(ints.from_bitarray(first), amount))
}
