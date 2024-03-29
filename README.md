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
|---------|---------|------------|----------|
| 32.89ms | 21.92ms | 10.97ms    | +50.04%  |

I'd guess that this could be done at least twice as fast by something better than a bash script.

### Raw Runs

```sh
$ bench './elm-swapper --version'
benchmarking ./elm-swapper --version
time                 32.89 ms   (32.25 ms .. 33.55 ms)
                     0.999 R²   (0.998 R² .. 1.000 R²)
mean                 33.75 ms   (33.43 ms .. 34.19 ms)
std dev              777.5 μs   (553.1 μs .. 1.109 ms)

$ bench '~/.config/elm-swapper/0.19.0/elm --version'
benchmarking ~/.config/elm-swapper/0.19.0/elm --version
time                 21.92 ms   (21.54 ms .. 22.33 ms)
                     0.999 R²   (0.998 R² .. 1.000 R²)
mean                 22.43 ms   (22.23 ms .. 22.60 ms)
std dev              423.7 μs   (340.0 μs .. 557.9 μs)
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
