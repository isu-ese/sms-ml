#!/bin/sh

markdown-pp proposal.mdpp -o proposal.md
pandoc proposal.md --template=templates/ieee.latex --top-level-division=section --pdf-engine=xelatex -F pandoc-crossref -F pandoc-citeproc -f markdown+fenced_code_attributes -f markdown+multiline_tables -o proposal.tex
