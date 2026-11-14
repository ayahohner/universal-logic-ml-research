# Universal Logic and the Four-Layer Onion

A LaTeX paper on mechanisms for embedding a categorical ontology in AI systems,
adapted from Mark J. J. McCormack's October 2026 letter on the 4 Layer Onion
Model (v4).

- `main.tex`: paper source
- `references.bib`: bibliography
- `figures/`: figures carried over from the source document
- `main.pdf`: compiled paper

## Build

The paper builds with [Tectonic](https://tectonic-typesetting.github.io), which
fetches the LaTeX packages it needs on first run:

```sh
make
```

The paper's structure follows the `academic-paper.tex` template from
[ndpvt-web/latex-document-skill](https://github.com/ndpvt-web/latex-document-skill),
and its prose was checked with
[proseclean](https://github.com/ayahohner/proseclean).

## License

© 2026 Mark J. J. McCormack. Licensed under the Sublation License v4.0
(https://doi.org/10.5281/zenodo.23324479). SPDX: AGPL-3.0-or-later WITH
Sublation-Additional-Permissions-4.0; text floor CC BY-SA 4.0.
