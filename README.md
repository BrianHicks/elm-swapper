# Elm Swapper

Automatically use the right version of Elm depending on the version specified in `elm.json`.
If you run `elm-swapper` in a directory which has a parent `elm.json` somewhere, it will:

1. run the right Elm binary if there is one in it's cache
2. download the right Elm binary if there is not a cached version
3. if it has to download, it will also run a checksum to make sure we don't download a bad version

## Usage

Use `elm-swapper` wherever you'd use `elm`. (In fact, it should be safe to `alias elm=elm-swapper`.)

For example, in an 0.19.0 project:

```sh
$ jq '.elm-version' elm.json
"0.19.0"

$ elm-swapper --version
0.19.0
```

But in an 0.19.1 project:

```sh
$ jq '.elm-version' elm.json
"0.19.1"

$ elm-swapper --version
0.19.1
```

`elm-swapper` only works for versions 0.19.0 and greater.
Elm 0.18.0 and prior had multiple binaries and the dispatch would be too annoying to do initially.
This is not "never", though, just "not now."

## Performance

It's a bash script right now, so performance definitely has some low-hanging fruit.

That said, let's check out the total time to issue `--version` from both the bare binary and with the added checks:

| With    | Without | Difference | % Change |
|=========|=========|============|==========|
| 23.25ms | 36.49ms | 13.24ms    | +56.95%  |

### Raw Runs

```sh
$ bench '~/.config/elm-swapper/0.19.0/elm --version'
benchmarking ~/.config/elm-swapper/0.19.0/elm --version
time                 23.25 ms   (22.88 ms .. 23.64 ms)
                     0.999 R²   (0.997 R² .. 0.999 R²)
mean                 23.92 ms   (23.62 ms .. 24.33 ms)
std dev              809.5 μs   (583.1 μs .. 1.195 ms)

$ bench './elm-swapper --version'
benchmarking ./elm-swapper --version
time                 36.49 ms   (36.11 ms .. 36.87 ms)
                     1.000 R²   (0.999 R² .. 1.000 R²)
mean                 36.79 ms   (36.55 ms .. 37.08 ms)
std dev              537.0 μs   (379.5 μs .. 798.2 μs)
```

## Configuration

You mostly shouldn't need to configure `elm-swapper`.
The first time it runs, it will figure out what operating system and architecture you need and download the right binary.
You can control where the binaries get downloaded with `ELM_SWAPPER_HOME`.
It defaults to `$XDG_CONFIG/elm-swapper` and falls back to `$HOME/elm-swapper`.

If you're packaging elm-swapper with Elm as an operating system package, you should be able to pre-seed these locations.

## Installation

Be Brian and know how to install this. It's in experiment phase right now.

(or less snarky: have direnv and nix installed, enter the directory, run scripts.)

## License

Don't use this right now.
It's proprietary source that just so happens to be visible on GitHub for discussion purposes.
Shoo.
