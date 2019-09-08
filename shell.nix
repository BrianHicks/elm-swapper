{ nixpkgs ? import <nixpkgs> { }, compiler ? "ghc865" }:
(import ./default.nix { inherit nixpkgs compiler; }).env.overrideAttrs (attrs: {
  buildInputs = attrs.buildInputs ++ [ nixpkgs.git nixpkgs.elmPackages.elm nixpkgs.cabal2nix nixpkgs.cabal-install ];
})
