---
name: academic-paper
description: Write research papers in LaTeX in the style of current ML conference preprints (ICML, NeurIPS, ACL), in one or two columns with no page limit. Use when asked to write, draft, convert or format an academic or research paper, preprint or technical report as LaTeX or PDF, or to turn notes, a Word document or an essay into a paper.
---

# Academic paper

This skill produces papers that look like current arXiv preprints from ML
venues: Times at 10 pt, a title between rules, author-year citations, a
running head, small bold-label captions and `booktabs` tables. The layout is
two-column (ICML style) or one-column (NeurIPS style). Unlike the venue styles
it has no page limit.

Files:

- `template/ulpaper.cls`: the document class.
- `template/main.tex`: a demo paper that uses every feature. Copy it and
  replace the content.
- `template/references.bib`, `template/Makefile`.
- `scripts/new_paper.sh`: copy the template to a new folder.
- `scripts/render_pages.py`: render PDF pages to PNG for checking.
- `scripts/tex2md.py`, `scripts/lint_prose.sh`: lint the prose with proseclean.
- `reference/style-guide.md`: the venue measurements the class copies and the
  reasons for each choice.
- `reference/venue-styles/`: the official ICML 2026, NeurIPS 2025 and ACL
  style files, for comparison or for submitting to those venues.

Paths below are relative to this skill folder.

## Workflow

### 1. Choose the layout

Pick from the content, not by habit:

- **`twocolumn`** (default): mostly prose, with figures and tables that fit a
  3.25 in column. Wide items use `figure*`/`table*`.
- **`onecolumn`**: many wide tables, long equations, code listings, big
  diagrams, or a report-like text. Also a good choice when a two-column draft
  ends up with most floats starred.

Other class options: `a4paper`, `review` (line numbers), `numbers` (numeric
citations), `nocolorlinks`.

### 2. Create the paper folder

```bash
scripts/new_paper.sh path/to/my-paper twocolumn
```

This copies the class, demo paper, bibliography and Makefile. The class file
travels with each paper so the folder builds alone and uploads to arXiv as is.

### 3. Write

Front matter, before `\begin{document}`:

```latex
\title{Main Title:\\A Descriptive Subtitle}
\shorttitle{Main Title}                  % running head
\author{Ada Author\affil{1} \And Bo Author\affil{1,2} \AND Cy Author\affil{2}}
\affiliations{\affil{1}First Institution. \affil{2}Second Institution.}
\correspondence{Ada Author \textless\texttt{ada@example.org}\textgreater.}
\notice{Preprint.}                       % or a license line, a date, etc.
\keywords{one; two; three}
```

`\And` separates authors on one line and `\AND` starts a new line. Then
`\maketitle` and the `abstract` environment.

Conventions (the demo paper shows each one):

- **Structure.** Introduction (problem, gap, approach, a list of
  contributions with cross-references), Related Work, Method, Experiments or
  Analysis, Discussion and Limitations, Conclusion, an unnumbered
  Acknowledgments section, references, then `\appendix`.
- **Run-in heads.** Use `\paragraph{Label.}` for short labeled paragraphs
  instead of bullet lists or hand-made `\textbf{Label.}` text.
- **Citations.** `\citet{key}` when the authors are part of the sentence,
  `\citep{key}` for a parenthetical citation. Add entries to
  `references.bib` with DOIs or URLs where available. Never invent a
  reference; mark anything unverified with a TODO.
- **Cross-references.** `\cref{sec:x}` and `\Cref` at the start of a sentence.
  Label prefixes: `sec:`, `fig:`, `tab:`, `eq:`, `alg:`, `lst:`, `def:`,
  `app:`.
- **Figures.** Vector PDF or TikZ where possible, else PNG at 300 dpi or more,
  in `figures/`. Width `\columnwidth` for column figures and `\textwidth`
  inside `figure*`. Captions say what the reader should notice.
- **Tables.** `booktabs` rules only, `\small`, caption above. `tabularx` with
  an `X` column for wrapped text.
- **Colors.** Use the class palette (`ulblue`, `ulorange`, `ulgreen`,
  `ulvermilion`, `ulpurple`, `ulsky`, `ulgray`) so figures stay legible for
  readers with color blindness.
- **Theorem-like environments.** `theorem`, `proposition`, `lemma`,
  `corollary`, `conjecture`, `definition`, `assumption`, `hypothesis`,
  `example`, `remark`.
- **Code and algorithms.** `lstlisting` (Python and JavaScript styles are set
  up) and `algorithm` with `algpseudocode`.
- **Starred floats.** In two-column mode LaTeX places `figure*`/`table*` at the
  top of the next page at the earliest. Put them in the source just before the
  text of the page where they should appear.
- **Length.** No page limit. For long papers keep the main text focused and
  move proofs, extra results and code to appendices.

Do not load packages that the class already loads (amsmath, amsthm,
mathtools, graphicx, xcolor, booktabs, tabularx, multirow, caption,
subcaption, enumitem, listings, algorithm, algpseudocode, natbib, hyperref,
cleveref, microtype). Do not load `amssymb` or `times`: `newtxmath` provides
the symbols and `newtxtext` the font. Load extra packages (tikz, siunitx,
pgfplots, tcolorbox) in the paper preamble.

### 4. Compile

```bash
make -C path/to/my-paper                  # Tectonic (default)
make -C path/to/my-paper ENGINE=latexmk   # TeX Live
```

Tectonic downloads the fonts and packages it needs on the first run. The class
works under pdfLaTeX too, which is what arXiv uses. Do not add
`\pdfoutput=1`: it breaks hyperref under Tectonic, and arXiv detects PDF
output without it.

Read the log for `Overfull \hbox`, undefined references and missing
citations, and fix them.

### 5. Check the pages

```bash
uvx --with pymupdf --with pillow python -I scripts/render_pages.py path/to/my-paper/main.pdf /tmp/pages --sheet
```

Look at `sheet.png` for the whole paper and at single pages at higher
`--dpi` for detail. Check that:

- the title block, affiliation footnote and running head render;
- no float sits alone on a mostly empty page, and starred floats land near
  their text;
- tables and equations fit their column, with no text in the margin;
- figures are legible at print size;
- no section head is stranded at the bottom of a column.

### 6. Lint the prose

```bash
scripts/lint_prose.sh path/to/my-paper/main.tex
```

This converts the body to Markdown with the same line numbers and runs
[proseclean](https://github.com/ayahohner/proseclean). Fix every finding by
rewording. Add `--code MACRO` for paper-specific macros whose argument is
code or a symbol (for example `--code rel`).

### 7. Final checklist

- [ ] Layout chosen for the content; class options set.
- [ ] `\shorttitle`, `\affiliations`, `\correspondence` and `\notice` filled in.
- [ ] Abstract of 150 to 250 words with the main result.
- [ ] Every figure, table, equation and listing is referenced in the text.
- [ ] Every citation resolves; no `??` in the PDF.
- [ ] No overfull boxes in the log.
- [ ] Pages rendered and inspected.
- [ ] proseclean reports 0 findings.
- [ ] `hypersetup` has `pdftitle` and `pdfauthor`.

## Converting an existing document

When the source is a Word document, notes or an essay:

1. Extract the text and images (for `.docx`, unzip `word/media/` for images
   and read `word/document.xml` or use the docx skill for text).
2. Map the source onto the paper structure above. Turn claims into numbered
   definitions, hypotheses or propositions where the source states them
   formally, and turn lists of parallel items into tables.
3. Keep the author's terms and claims. Do not add results the source does not
   contain; flag gaps in Discussion and Limitations instead.
4. Redraw simple diagrams in TikZ; keep complex images as figures.
5. Find and verify references for works the source names.

## Submitting to a venue

ulpaper is for preprints, reports and papers without a fixed venue. To submit
to ICML, NeurIPS or ACL, start from the venue's current author kit (sources in
`reference/venue-styles/README.md`), paste in the body, and replace the title
block with the venue's macros. The body conventions above match those venues,
so little else changes.
