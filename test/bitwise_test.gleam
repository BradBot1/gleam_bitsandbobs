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
import bitsandbobs/bitwise
import gleeunit/should

pub fn bitwise_and_test() -> Nil {
  bitwise.and(<<5:8>>, <<4:8>>)
  |> should.equal(<<4:8>>)
}

pub fn bitwise_or_test() -> Nil {
  bitwise.or(<<5:8>>, <<4:8>>)
  |> should.equal(<<5:8>>)
}

pub fn bitwise_xor_test() -> Nil {
  bitwise.xor(<<5:8>>, <<4:8>>)
  |> should.equal(<<1:8>>)
}

pub fn bitwise_not_test() -> Nil {
  bitwise.not(<<5:8>>)
  |> should.equal(<<250:8>>)
}

pub fn bitwise_left_shift_test() -> Nil {
  bitwise.lshift(<<5:8>>, 1)
  |> should.equal(<<10:8>>)
}

pub fn bitwise_right_shift_test() -> Nil {
  bitwise.rshift(<<5:8>>, 1)
  |> should.equal(<<2:8>>)
}
