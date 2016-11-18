# Init OPAM
source .travis-opam-init.sh

# Check OPAM package description
opam lint

# Install
opam pin add -y --no-action --kind=git monomorphic .
opam install -y monomorphic

# Uninstall
opam remove -y monomorphic
