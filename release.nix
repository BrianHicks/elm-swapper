{ compiler ? "ghc865" }:
let
  sources = import ./nix/sources.nix;
  nixpkgs = import sources.nixpkgs { };
in with nixpkgs; { elm-swapper = haskell.packages.${compiler}.callPackage ./elm-swapper.nix { }; }
