# Style guide: how ulpaper matches current ML papers

This note records what `ulpaper.cls` copies from recent arXiv papers and venue
styles, and why. Read it before you change the class.

## Sources

Three arXiv papers from November 2026 served as the visual reference:

| arXiv ID | Venue style | Layout |
|---|---|---|
| 2611.16375 | ICML 2024 (`icml2024.sty`), preprint mode | two-column, letter |
| 2611.16361 | ICML 2026 (`icml2026.sty`), preprint mode | two-column, letter |
| 2611.00544 | ACL (`acl.sty`), final mode | two-column, A4 |

The NeurIPS 2025 style (`neurips_2025.sty`) is the reference for the
one-column layout. Copies of the venue files are in [venue-styles/](venue-styles/).

## Page geometry

| Parameter | ICML 2026 | NeurIPS 2025 | ACL | ulpaper `twocolumn` | ulpaper `onecolumn` |
|---|---|---|---|---|---|
| Paper | letter | letter | A4 | letter (or `a4paper`) | letter (or `a4paper`) |
| Text block | 6.75 x 9 in | 5.5 x 9 in | 6.3 x 9.7 in | 6.75 x 9 in | 5.5 x 9 in |
| Column gap | 0.25 in | n/a | 0.6 cm | 0.25 in | n/a |
| Body size | 10 / 11 pt | 10 / 11 pt | 11 / 13.6 pt | 10 / 11 pt | 10 / 11 pt |
| Paragraphs | no indent, 6 pt skip | no indent, 5.5 pt skip | 1 em indent | no indent, 6 pt skip | no indent, 6 pt skip |
| Page limit | 8 + refs + appendix | 9 + refs + appendix | 8 + refs | none | none |

The text block stays the same with `a4paper`, centered on the page, as in the
ICML and NeurIPS styles.

## Typography

- **Font.** All three papers use Times (ICML 2026 went back to `times` for
  compatibility). ulpaper uses `newtxtext` and `newtxmath`, which match Times in
  text and math. Under XeTeX or LuaTeX (Tectonic), `newtxtext` loads the
  OpenType TeX Gyre Termes X through `fontspec`; under pdfLaTeX (arXiv), it
  uses Type 1 fonts with T1 encoding. Monospace is Inconsolata (`zi4`) in both
  engines. Tectonic downloads all of these on first use.
- **Section heads.** Numbers end with a period ("1.", "3.1."), as in ICML.
  `\section` is large bold, `\subsection` normal-size bold, `\subsubsection`
  italic. `\paragraph` is a bold run-in head followed by text on the same line.
  The reference papers use run-in heads heavily in place of bullet lists.
- **Captions.** Small type, bold label, period separator ("**Figure 1.** Text").
  Table captions sit above the table and figure captions below the figure.
- **Tables.** `booktabs` rules only, no vertical lines, `\small` body.
- **Lists.** Compact: little space between items, as in ICML.

## Front matter

- The title is Large bold, centered, between two 1 pt rules (ICML).
- Authors are bold and centered. Affiliation marks are superscript numbers.
- Affiliations, the correspondence address and a notice ("Preprint." by
  default) go in an unnumbered footnote on page 1, as in ICML. ACL puts
  affiliations under the names instead; ulpaper follows ICML.
- "Abstract" is a centered bold head and the abstract is indented on both
  sides. Keywords, if given, follow the abstract.

## Running head and page numbers

ICML prints the short title in small bold type above a 1 pt rule on every page
after the first, and centers the page number in the footer. ulpaper does the
same with `\shorttitle`. Page 1 has no running head.

## Citations

All three papers cite in author-year form with `natbib`: `\citet{key}` gives
"Vaswani et al. (2017)" and `\citep{key}` gives "(Vaswani et al., 2017)".
ulpaper uses `plainnat`. The `numbers` class option switches to "[1]" style
for venues or fields that want it.

## Color

Links are dark blue (`ullink`), as in ICML preprints. Plot and diagram colors
come from the Okabe-Ito palette, which stays distinct under the common forms
of color blindness: `ulblue`, `ulorange`, `ulgreen`, `ulvermilion`,
`ulpurple`, `ulsky`, `ulgray`.

## Choosing one or two columns

Use **two columns** (the default) for papers that are mostly prose with
column-width figures and tables: the format of ICML, ACL, CVPR and most
proceedings. Use `figure*` and `table*` for content that needs the full width.

Use **one column** when the paper has many wide tables, long equations,
code listings, large diagrams or long derivations, or when it reads more like
a report than a conference paper. NeurIPS, ICLR, COLM and TMLR use one column.

## Length

ulpaper has no page limit. For a long paper, keep the main text focused and
move proofs, extra results, hyperparameters and code to appendices. The
`\appendix` command starts a new page and letters the sections.

## Differences from the first version of the onion-model paper

The first draft of `four-layer-onion-model/main.tex` used the plain `article`
class. Compared with the reference papers it had:

- one column on A4 with 1 in margins and 1.15 line spacing (longer lines and
  more white space than any venue style);
- 11 pt type instead of 10 pt;
- numeric citations instead of author-year;
- section numbers without trailing periods;
- bold "Label." paragraphs written by hand instead of `\paragraph`;
- captions in normal size with a colon separator;
- an `authblk` title block with no rules, no running head and no affiliation
  footnote.
