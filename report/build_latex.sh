#!/bin/bash

set -e

pp $1.md > $1.gen.md

pandoc $1.gen.md \
  --template=../templates/ieee.latex \
  --top-level-division=section \
  --bibliography=../isu-ese.json \
  --csl=../ieee.csl \
  -F pandoc-crossref \
  -f markdown+fenced_code_attributes \
  -f markdown+multiline_tables \
  -f markdown+tex_math_single_backslash \
  -o $1.gen.tex
