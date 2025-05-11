munka.pdf:
	pdflatex -shell-escape -silent -interaction=nonstopmode munka.tex

.PHONY: clean
clean:
	-rm *.aux *.log *.lua *.bcf *.idx *.lof *.xml *.toc *.pdf *.bbl *.blg
	-rm -rf _markdown_munka
	-rm -rf _minted
