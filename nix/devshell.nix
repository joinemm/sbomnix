# SPDX-FileCopyrightText: 2023 Technology Innovation Institute (TII)
#
# SPDX-License-Identifier: Apache-2.0
{
  perSystem = {
    pkgs,
    lib,
    inputs',
    ...
  }: {
    devShells.default = let
      pp = pkgs.python3Packages;
    in
      pkgs.mkShell rec {
        name = "sbomnix-dev-shell";

        buildInputs = lib.flatten [
          (with pkgs; [
            coreutils
            curl
            gnugrep
            gnused
            graphviz
            grype
            gzip
            nix
            reuse
          ])
          (with pp; [
            beautifulsoup4
            colorlog
            graphviz
            numpy
            packageurl-python
            packaging
            pandas
            requests
            requests-cache
            tabulate
            venvShellHook
            wheel
          ])

          [inputs'.nix-fast-build.packages.default]
        ];
        venvDir = "venv";
        postShellHook = ''
          source $PWD/scripts/env.sh

          # https://github.com/NixOS/nix/issues/1009:
          export TMPDIR="/tmp"

          # Enter python development environment
          make install-dev
        '';
      };
  };
}
