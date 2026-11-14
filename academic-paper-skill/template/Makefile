# Build with Tectonic (https://tectonic-typesetting.github.io), or latexmk if
# a TeX Live install is available: make ENGINE=latexmk
ENGINE ?= tectonic

main.pdf: main.tex references.bib ulpaper.cls $(wildcard figures/*)
ifeq ($(ENGINE),latexmk)
	latexmk -pdf -interaction=nonstopmode main.tex
else
	tectonic -X compile main.tex
endif

clean:
	rm -f main.pdf *.aux *.log *.bbl *.blg *.out *.fls *.fdb_latexmk *.synctex.gz

.PHONY: clean
