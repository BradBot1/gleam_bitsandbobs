# bitsandbobs

[![Package Version](https://img.shields.io/hexpm/v/bitsandbobs)](https://hex.pm/packages/bitsandbobs)
[![Hex Docs](https://img.shields.io/badge/hex-docs-ffaff3)](https://hexdocs.pm/bitsandbobs/)

```sh
gleam add bitsandbobs@1
```
```gleam
import bitsandbobs
import bitsandbobs/ints

pub fn main() {
  let first = <<5:32, 10:32>> |> ints.map_every_x_bits(32, fn(x) { x * 2 })
  let second = <<40:32, 45:32>>
  ints.add(first, second, 32)
}
```

> I'd really recommend looking at the tests for more examples

Further documentation can be found at <https://hexdocs.pm/bitsandbobs>.

## Development

```sh
gleam run   # Run the project
gleam test  # Run the tests
```
