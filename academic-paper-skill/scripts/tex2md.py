#!/usr/bin/env python3
"""Convert a LaTeX paper to Markdown for prose linters such as proseclean.

The output keeps the line numbers of the input, so a finding on line N of the
Markdown file points at line N of the .tex file. Only body prose is kept:
the preamble, floats, code, math displays and comments become blank lines.
Inline math becomes `x`, citations are dropped and cross-references become
"Section 1", so linters see grammatical sentences.

Usage: tex2md.py main.tex [out.md] [--skip ENV ...] [--code MACRO ...]
  --skip ENV    extra environments to blank out (repeatable)
  --code MACRO  one-argument macros whose argument is code, kept as `arg`
"""
import argparse
import re
import sys

SKIP = {
    'figure', 'figure*', 'table', 'table*', 'tikzpicture', 'lstlisting',
    'verbatim', 'algorithm', 'algorithmic', 'equation', 'equation*', 'align',
    'align*', 'gather', 'gather*', 'multline', 'tabular', 'tabularx',
    'subfigure', 'thebibliography', 'tcolorbox',
}
TEXT_MACROS = ('emph', 'textbf', 'textit', 'texttt', 'textsc', 'textrm',
               'textsf', 'mathrm', 'text', 'underline', 'url')


def strip_inline(t, code_macros):
    t = re.sub(r'(?<!\\)%.*', '', t)
    t = re.sub(r'\\verb(.)(.*?)\1', r'`\2`', t)
    t = re.sub(r'\$[^$]*\$', '`x`', t)
    t = re.sub(r'\\\(.*?\\\)', '`x`', t)
    t = re.sub(r'\\\[.*?\\\]', '`x`', t)
    t = re.sub(r'~?\\(cite|citep|citet|citealp|citealt|citeauthor|citeyear)\*?(\[[^\]]*\])*\{[^}]*\}', '', t)
    t = re.sub(r'\\[Cc]ref\{[^}]*\}', 'Section 1', t)
    t = re.sub(r'\\(ref|eqref|autoref|label|footnote)\{[^}]*\}', '', t)
    for m in code_macros:
        t = re.sub(r'\\' + m + r'\{([^}]*)\}', r'`\1`', t)
    for _ in range(3):
        t = re.sub(r'\\(' + '|'.join(TEXT_MACROS) + r')\{([^{}]*)\}', r'\2', t)
    t = t.replace("``", '"').replace("''", '"').replace('---', '\u2014').replace('--', '\u2013')
    for a, b in (('\\&', '&'), ('\\%', '%'), ('\\$', '$'), ('\\_', '_'), ('\\#', '#')):
        t = t.replace(a, b)
    t = re.sub(r'\\(noindent|centering|small|footnotesize)\b\s*', '', t)
    t = re.sub(r'\\[a-zA-Z]+\*?(\[[^\]]*\])?', '', t)
    t = t.replace('{', '').replace('}', '').replace('~', ' ')
    return t.strip()


def convert(src, skip, code_macros):
    out, depth, in_doc = [], 0, False
    for line in src.split('\n'):
        s = line.strip()
        if s.startswith('\\begin{document}'):
            in_doc = True
            out.append('')
            continue
        if not in_doc or s.startswith('\\end{document}'):
            out.append('')
            continue
        m = re.match(r'\\begin\{([\w*]+)\}', s)
        if m and m.group(1) in skip:
            depth += 1
        m_end = re.search(r'\\end\{([\w*]+)\}', s)
        if depth > 0:
            if m_end and m_end.group(1) in skip:
                depth -= 1
            out.append('')
            continue
        if s.startswith('%'):
            out.append('')
            continue
        m = re.match(r'\\(sub)*section\*?\{(.*)\}', s)
        if m:
            level = 1 + s.count('sub', 0, s.index('section'))
            out.append('#' * level + ' ' + strip_inline(m.group(2), code_macros))
            continue
        m = re.match(r'\\paragraph\*?\{(.*?)\}\s*(.*)', s)
        if m:
            out.append(strip_inline(m.group(1) + ' ' + m.group(2), code_macros))
            continue
        if s.startswith('\\item'):
            out.append('- ' + strip_inline(re.sub(r'^\\item(\[[^\]]*\])?', '', s), code_macros))
            continue
        if re.match(r'\\(begin|end)\{', s):
            out.append('')
            continue
        if s.startswith('\\') and not re.match(
                r'\\(textbf|textit|emph|noindent|Cref|cref|citet|citep|verb|\$)', s):
            out.append('')
            continue
        out.append(strip_inline(line, code_macros))
    return '\n'.join(out)


def main():
    ap = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument('tex')
    ap.add_argument('out', nargs='?')
    ap.add_argument('--skip', action='append', default=[])
    ap.add_argument('--code', action='append', default=[])
    a = ap.parse_args()
    md = convert(open(a.tex, encoding='utf-8').read(), SKIP | set(a.skip), a.code)
    if a.out:
        open(a.out, 'w', encoding='utf-8').write(md)
    else:
        sys.stdout.write(md)


if __name__ == '__main__':
    main()
