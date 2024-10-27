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
import { BitArray, List, Ok, Error, byteArrayToInt } from './gleam.mjs';

/**
 * Size of an Int in bits
 */
const MIN_INT_CAP = 8 * Uint8Array.BYTES_PER_ELEMENT;

export function split_every_x_bits(/** @type {BitArray} */bitarray, /** @type {number} */every) {
    const uint8 = bitarray.buffer;
    const read_size_bytes = bits_required_to_represent_x_bits(every) / MIN_INT_CAP;
    const result = [];
    for (let i = 0; i < uint8.length; i += read_size_bytes) {
        const chunk = uint8.subarray(i, i + read_size_bytes);
        result.push(new BitArray(chunk));
    }
    return List.fromArray(result);
}

export function is_atleast_x_bits(/** @type {BitArray} */bitarray, /** @type {number} */mininum) {
    return mininum >= 0 && bit_size_recursive(bitarray, 8) >= mininum;
}

export function bit_size_recursive(/** @type {BitArray} */bitarray, /** @type {number} */starting_size) {
    return bitarray.length * MIN_INT_CAP;
}

export function int_from_x_bits(/** @type {BitArray} */bitarray, /** @type {number} */bit_count) {
    if (bit_count < bit_size_recursive(bitarray, 8)) {
        return new Error(null);
    }
    const result = byteArrayToInt(bitarray.buffer, 0, bit_count / 8 / Uint8Array.BYTES_PER_ELEMENT, true, true);
    return isNaN(result) ? new Error(null) : new Ok(result);
}

export function int_from_bitarray(/** @type {BitArray} */bitarray) {
    return byteArrayToInt(bitarray.buffer, 0, bitarray.length, true, true);
}

export function bits_required_to_represent_x_bits(/** @type {number} */int) {
    return (Math.floor(int / MIN_INT_CAP) * MIN_INT_CAP) + (int % MIN_INT_CAP > 0 ? MIN_INT_CAP : 0);
}