pandoc presentation.md --verbose --template=template.latex -t beamer --slide-level 1 --pdf-engine=xelatex -f markdown+fenced_code_attributes -f markdown+multiline_tables -o presentation.pdf
