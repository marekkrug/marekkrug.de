{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  buildInputs = with pkgs; [
    git
    ruby
    gcc
    gnumake
    jekyll
    html-proofer
  ];
}