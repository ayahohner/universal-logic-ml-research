# Venue style files (reference only)

These are unmodified copies of official conference styles, kept to compare
against `ulpaper.cls`. The template does not load them. Each file keeps its
own license header. Fetch the current version from the source before
submitting to a venue.

| File | Version | Source |
|---|---|---|
| `icml2026.sty`, `icml2026.bst` | 2025-10-29 | ICML 2026 author kit (<https://icml.cc/Conferences/2026/AuthorInstructions>); copy taken from arXiv:2611.16361 |
| `acl.sty` | as shipped in arXiv:2611.00544 | <https://github.com/acl-org/acl-style-files> |
| `neurips_2025.sty` | 2025 | <https://media.neurips.cc/Conferences/NeurIPS2025/Styles.zip> |

To submit to one of these venues, start from the venue's own template and
copy the paper body across. The body written for ulpaper (sections,
`\citet`/`\citep`, `booktabs` tables, `figure*`/`table*` floats) moves across
without changes. Replace the title block with the venue's macros.
