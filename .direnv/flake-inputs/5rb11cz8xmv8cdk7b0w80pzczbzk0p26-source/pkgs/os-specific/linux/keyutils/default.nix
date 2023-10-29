{ lib, stdenv, fetchurl }:

# Note: this package is used for bootstrapping fetchurl, and thus
# cannot use fetchpatch! All mutable patches (generated by GitHub or
# cgit) that are needed here should be included directly in Nixpkgs as
# files.

stdenv.mkDerivation rec {
  pname = "keyutils";
  version = "1.6.3";

  src = fetchurl {
    url = "https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/keyutils.git/snapshot/${pname}-${version}.tar.gz";
    sha256 = "sha256-ph1XBhNq5MBb1I+GGGvP29iN2L1RB+Phlckkz8Gzm7Q=";
  };

  patches = [
    ./conf-symlink.patch
    # This patch solves a duplicate symbol error when building with a clang stdenv
    # Before removing this patch, please ensure the package still builds by running eg.
    # nix-build -E 'with import ./. {}; pkgs.keyutils.override { stdenv = pkgs.clangStdenv; }'
    ./0001-Remove-unused-function-after_eq.patch

    # Fix build for s390-linux, where size_t is different from ptrdiff_t.
    (fetchurl {
      url = "https://lore.kernel.org/keyrings/20230301134250.301819-1-hi@alyssa.is/raw";
      sha256 = "1cbgwxq28fw5ldh38ngcs7xiqvpnmrw0hw9zzhbhb1hdxkavrc1s";
    })
  ];

  makeFlags = lib.optionals stdenv.hostPlatform.isStatic "NO_SOLIB=1";

  outputs = [ "out" "lib" "dev" ];

  postPatch = ''
    # https://github.com/archlinux/svntogit-packages/blob/packages/keyutils/trunk/reproducible.patch
    substituteInPlace Makefile \
      --replace \
        'VCPPFLAGS	:= -DPKGBUILD="\"$(shell date -u +%F)\""' \
        'VCPPFLAGS	:= -DPKGBUILD="\"$(date -ud "@$SOURCE_DATE_EPOCH" +%F)\""'
  '';

  enableParallelBuilding = true;

  installFlags = [
    "ETCDIR=$(out)/etc"
    "BINDIR=$(out)/bin"
    "SBINDIR=$(out)/sbin"
    "SHAREDIR=$(out)/share/keyutils"
    "MANDIR=$(out)/share/man"
    "INCLUDEDIR=$(dev)/include"
    "LIBDIR=$(lib)/lib"
    "USRLIBDIR=$(lib)/lib"
  ];

  meta = with lib; {
    homepage = "https://people.redhat.com/dhowells/keyutils/";
    description = "Tools used to control the Linux kernel key management system";
    license = licenses.gpl2Plus;
    platforms = platforms.linux;
  };
}
