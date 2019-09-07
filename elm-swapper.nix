{ mkDerivation, base, stdenv }:
mkDerivation {
  pname = "elm-swapper";
  version = "0.1.0.0";
  src = ./.;
  isLibrary = false;
  isExecutable = true;
  executableHaskellDepends = [ base ];
  description = "automatically dispatch to the right version of Elm";
  license = "unknown";
  hydraPlatforms = stdenv.lib.platforms.none;
}
