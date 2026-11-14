# Build the paper with Tectonic (https://tectonic-typesetting.github.io).
main.pdf: main.tex references.bib $(wildcard figures/*)
	tectonic -X compile main.tex

clean:
	rm -f main.pdf main.aux main.log main.bbl main.blg main.out

.PHONY: clean
