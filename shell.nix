with import (builtins.fetchTarball rec {
  # grab a hash from here: https://nixos.org/channels/
  name = "nixpkgs-darwin-18.09pre154171.2aead2422f8";
  url = "https://github.com/nixos/nixpkgs/archive/2aead2422f85562a09619a657ecab0ca405f2d72.tar.gz";
  # Hash obtained using `nix-prefetch-url --unpack <url>`
  sha256 = "0hg7q8ggpwni0gswa3a74nnn5pa3gi5xw29735l7w59dw9nln8lp";
}) { };

stdenv.mkDerivation {
  name = "elm-swapper";
  buildInputs = [ git bash jq ];
}
