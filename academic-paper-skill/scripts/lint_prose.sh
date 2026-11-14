#!/usr/bin/env bash
# Lint the prose of a LaTeX paper with proseclean (https://github.com/ayahohner/proseclean).
#   lint_prose.sh main.tex [extra tex2md.py args, e.g. --code rel]
# Findings report line numbers of main.tex, since tex2md.py keeps lines aligned.
set -euo pipefail
here="$(cd "$(dirname "$0")" && pwd)"
tex="${1:?usage: lint_prose.sh main.tex [tex2md args]}"; shift
tmp="$(mktemp -d)"; trap 'rm -rf "$tmp"' EXIT
md="$tmp/$(basename "${tex%.tex}").md"
python3 -I "$here/tex2md.py" "$tex" "$md" "$@"
uvx proseclean "$md"
