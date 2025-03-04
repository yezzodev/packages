#!/bin/bash

# CLONE PHASE
git clone https://github.com/scummvm/scummvm.git source
pushd source
git checkout -f f6ab60c
popd

# BUILD PHASE
pushd "source"
./configure --prefix="$pfx"
make -j "$(nproc)"
make install
popd

# COPY PHASE
cp -rfv "$pfx/bin/" "$diststart/common/dist/"
cp -rfv "$pfx/share" "$diststart/common/dist/"
cp -rfv "assets/run-scummvm.sh" "$diststart/common/dist/"
