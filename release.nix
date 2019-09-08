{ compiler ? "ghc865" }:
let pkgs = import <nixpkgs> { };
in { elm-swapper = pkgs.haskell.packages.${compiler}.callPackage ./elm-swapper.nix { }; }
