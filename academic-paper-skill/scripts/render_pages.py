#!/usr/bin/env python3
"""Render PDF pages to PNG for visual checks.

Usage (needs pymupdf and pillow; uv fetches them):
  uvx --with pymupdf --with pillow python -I render_pages.py main.pdf OUTDIR [--dpi 80] [--pages 1,3] [--sheet]

Writes OUTDIR/page-NN.png for each page. With --sheet it also writes
OUTDIR/sheet.png, the pages side by side in rows of four, which is the quickest
way to check layout across the whole paper.
"""
import argparse
import os

import fitz  # pymupdf
from PIL import Image


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('pdf')
    ap.add_argument('outdir')
    ap.add_argument('--dpi', type=int, default=80)
    ap.add_argument('--pages', help='comma-separated 1-based page numbers')
    ap.add_argument('--sheet', action='store_true')
    ap.add_argument('--per-row', type=int, default=4)
    a = ap.parse_args()

    os.makedirs(a.outdir, exist_ok=True)
    doc = fitz.open(a.pdf)
    want = {int(x) for x in a.pages.split(',')} if a.pages else None
    paths = []
    for i, page in enumerate(doc, start=1):
        if want and i not in want:
            continue
        path = os.path.join(a.outdir, f'page-{i:02d}.png')
        page.get_pixmap(dpi=a.dpi).save(path)
        paths.append(path)
    print(f'{doc.page_count} pages, {doc[0].rect.width:.0f}x{doc[0].rect.height:.0f}pt; wrote {len(paths)} PNGs')

    if a.sheet and paths:
        ims = [Image.open(p) for p in paths]
        w, h = ims[0].size
        cols = min(a.per_row, len(ims))
        rows = (len(ims) + cols - 1) // cols
        sheet = Image.new('RGB', (w * cols, h * rows), 'white')
        for j, im in enumerate(ims):
            sheet.paste(im, ((j % cols) * w, (j // cols) * h))
        out = os.path.join(a.outdir, 'sheet.png')
        sheet.save(out)
        print('sheet:', out)


if __name__ == '__main__':
    main()
