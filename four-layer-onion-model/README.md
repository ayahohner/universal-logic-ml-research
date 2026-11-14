# Universal Logic and the Four-Layer Onion

A LaTeX paper on mechanisms for embedding a categorical ontology in AI systems,
adapted from Mark J. J. McCormack's October 2026 letter on the 4 Layer Onion
Model (v4).

- `main.tex`: paper source
- `ulpaper.cls`: document class, copied from
  [academic-paper-skill](../academic-paper-skill/)
- `references.bib`: bibliography
- `figures/`: figures carried over from the source document
- `main.pdf`: compiled paper
- `questions-for-author.md`: open questions for the author, and the
  terminology and related-work changes planned for the next revision

## Build

The paper builds with [Tectonic](https://tectonic-typesetting.github.io), which
fetches the LaTeX packages it needs on first run:

```sh
make
```

The paper uses the two-column layout of `ulpaper.cls`, styled after ICML
preprints, with author-year citations; the appendix switches to one column for
the code listing. Its prose was checked with
[proseclean](https://github.com/ayahohner/proseclean).

## License

© 2026 Mark J. J. McCormack. Licensed under the Sublation License v4.0
(https://doi.org/10.5281/zenodo.23324479). SPDX: AGPL-3.0-or-later WITH
Sublation-Additional-Permissions-4.0; text floor CC BY-SA 4.0.
