{ pkgs ? import <nixpkgs> {} }:

with builtins;
with pkgs;
stdenv.mkDerivation {
  name = "tock-syscalls";

  buildInputs = [
    rustup
    gcc-arm-embedded
  ];
}
