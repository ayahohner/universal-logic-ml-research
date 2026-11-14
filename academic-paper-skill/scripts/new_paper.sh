#!/usr/bin/env bash
# Create a new paper folder from the template.
#   new_paper.sh DEST [onecolumn|twocolumn]
set -euo pipefail
here="$(cd "$(dirname "$0")/.." && pwd)"
dest="${1:?usage: new_paper.sh DEST [onecolumn|twocolumn]}"
layout="${2:-twocolumn}"
case "$layout" in onecolumn|twocolumn) ;; *) echo "layout must be onecolumn or twocolumn" >&2; exit 1;; esac
if [ -e "$dest" ] && [ -n "$(ls -A "$dest" 2>/dev/null)" ]; then
  echo "$dest exists and is not empty" >&2; exit 1
fi
mkdir -p "$dest/figures"
cp "$here/template/ulpaper.cls" "$here/template/main.tex" "$here/template/references.bib" \
   "$here/template/Makefile" "$dest/"
if [ "$layout" = onecolumn ]; then
  # Swap the active and commented-out class lines.
  sed -i.bak -e 's/^\\documentclass\[twocolumn\]{ulpaper}/@@ONE@@/' \
             -e 's/^% \\documentclass\[onecolumn\]{ulpaper}/% \\documentclass[twocolumn]{ulpaper}/' \
             -e 's/^@@ONE@@/\\documentclass[onecolumn]{ulpaper}/' "$dest/main.tex"
fi
rm -f "$dest/main.tex.bak"
echo "Created $dest ($layout). Build with: make -C $dest"
