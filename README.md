# Elm Swapper

Automatically use the right version of Elm depending on the version specified in `elm.json`.

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
