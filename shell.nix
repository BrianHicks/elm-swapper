{ nixpkgs ? import <nixpkgs> { }, compiler ? "ghc865" }:
(import ./release.nix { inherit compiler; }).elm-swapper.env.overrideAttrs (attrs: {
  buildInputs = attrs.buildInputs ++ [
    nixpkgs.git
    nixpkgs.elmPackages.elm
    nixpkgs.cabal2nix
    nixpkgs.cabal-install
    nixpkgs.haskellPackages.hindent
    nixpkgs.bench
  ];
})
