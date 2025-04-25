munka.pdf:
	pdflatex --shell-escape -output-directory build munka.tex
	move build\munka.pdf .

.PHONY: clean
clean:
	del munka.aux munka.bcf munka.bib munka.idx munka.lof munka.log munka.run.xml munka.toc
	del munka.pdf
