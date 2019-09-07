elm-swapper.nix: elm-swapper.cabal
	cabal2nix . > $@
