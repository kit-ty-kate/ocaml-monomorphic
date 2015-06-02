case "$OCAML_VERSION" in
    3.12) ppa=avsm/ocaml312+opam12;;
    4.00) ppa=avsm/ocaml40+opam12;;
    4.01) ppa=avsm/ocaml41+opam12;;
    4.02) ppa=avsm/ocaml42+opam12;;
    *) echo Unknown $OCAML_VERSION; exit 1;;
esac

sudo add-apt-repository --yes ppa:$ppa
sudo apt-get update -qq
sudo apt-get install -qq ocaml ocaml-native-compilers
wget https://raw.github.com/ocaml/opam/master/shell/opam_installer.sh
export OPAMYES=1
sh ./opam_installer.sh /usr/local/bin system # The ppa is not up-to-date
eval `opam config env`
opam pin add -n --kind=git monomorphic .
opam install monomorphic.dev
