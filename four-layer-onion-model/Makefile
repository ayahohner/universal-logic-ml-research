# Build the paper with Tectonic (https://tectonic-typesetting.github.io).
main.pdf: main.tex references.bib ulpaper.cls $(wildcard figures/*)
	tectonic -X compile main.tex

clean:
	rm -f main.pdf *.aux *.log *.bbl *.blg *.out

.PHONY: clean
