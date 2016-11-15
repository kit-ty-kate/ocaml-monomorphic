sudo add-apt-repository --yes ppa:avsm/ocaml42+opam12
sudo apt-get update -qq
sudo apt-get install -qq opam
export OPAMYES=1
opam init
eval `opam config env`
opam pin add -n --kind=git monomorphic .
opam install monomorphic
