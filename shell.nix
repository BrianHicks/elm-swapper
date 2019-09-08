{ nixpkgs ? import <nixpkgs> { }, compiler ? "ghc865" }:
(import ./release.nix { inherit compiler; }).elm-swapper.env.overrideAttrs (attrs: {
  buildInputs = attrs.buildInputs ++ [
    nixpkgs.bench
    nixpkgs.cabal-install
    nixpkgs.cabal2nix
    nixpkgs.elmPackages.elm
    nixpkgs.git
    nixpkgs.haskellPackages.hindent
  ];
})
