{ compiler ? "ghc865" }:
let
  sources = import ./nix/sources.nix;
  niv = import sources.niv { };
  nixpkgs = import sources.nixpkgs { };
  ormolu = import sources.ormolu { };
in with nixpkgs;
(import ./release.nix { inherit compiler; }).elm-swapper.env.overrideAttrs (attrs: {
  buildInputs = attrs.buildInputs ++ [ bench cabal-install cabal2nix elmPackages.elm git ormolu.ormolu niv.niv ];
})
