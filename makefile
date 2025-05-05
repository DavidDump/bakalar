munka.pdf:
	pdflatex -shell-escape -silent munka.tex

.PHONY: clean
clean:
	del /Q *.aux *.log *.lua *.bcf *.idx *.lof *.xml *.toc *.pdf *.bbl *.blg
	rmdir /Q /S _markdown_munka
	rmdir /Q /S _minted
