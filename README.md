# Universal Logic ML Research

Papers on Universal Logic and AI alignment.

- [four-layer-onion-model](four-layer-onion-model/): Universal Logic and the
  Four-Layer Onion, on mechanisms for embedding a categorical ontology in AI
  systems.

## Paper template

[academic-paper-skill](academic-paper-skill/) holds the LaTeX class and
template used for these papers (`ulpaper.cls`, one or two columns, styled
after ICML and NeurIPS preprints) and a Claude Code skill that describes how
to write, build and check a paper with it. Start a new paper with:

```bash
academic-paper-skill/scripts/new_paper.sh my-new-paper twocolumn
```

The skill is linked at `.claude/skills/academic-paper` so Claude Code finds it
in this repository.
