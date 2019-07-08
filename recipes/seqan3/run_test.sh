#!/bin/bash
TMP=$(mktemp -d)
cd ${TMP}
DL=${CONDA_PREFIX}/../work_moved_${PKG_NAME}-${PKG_VERSION}-${PKG_BUILD_STRING}_${SUBDIR}
cp --recursive ${DL}/test/unit ./
cp --recursive ${DL}/test/include ./
cp ${DL}/LICENSE.md ./
cp ${DL}/test/seqan3-test.cmake ./
mkdir test
cd test
CMAKE_PREFIX_PATH=$PREFIX/share/cmake \
cmake ../unit -DCMAKE_BUILD_TYPE=Release -DSEQAN3_INCLUDE_DIR=${CONDA_PREFIX}/include
make -j$(nproc)
ctest --parallel $(nproc) --output-on-failure
