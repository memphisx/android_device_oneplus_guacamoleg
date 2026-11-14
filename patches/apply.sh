#!/bin/bash
# SPDX-License-Identifier: Apache-2.0
# Applies guacamoleg's changes to other projects of the tree (as commits, with git am). Usage: patches/apply.sh <tree>
# Each folder is a project path with / written as _ (kernel_oneplus_sm8150 -> kernel/oneplus/sm8150).
set -euo pipefail
HERE="$(cd "$(dirname "$0")" && pwd)"; TOP="$(cd "${1:?usage: apply.sh <LineageOS tree>}" && pwd)"
for dir in "$HERE"/*/; do
    proj=$(basename "$dir"); p="$TOP/${proj//_//}"
    if git -C "$p" -c user.name=guacamoleg -c user.email=guacamoleg@localhost am -q "$dir"*.patch; then
        echo "applied $proj"
    else
        git -C "$p" am --abort; echo "FAILED $proj" >&2; exit 1
    fi
done
