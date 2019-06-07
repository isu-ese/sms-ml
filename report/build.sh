#!/bin/bash

set -e

./build_latex.sh $1
tempdir=$(mktemp -d)

latexmk -pdf -pdflatex="xelatex %O %S" $1.gen -outdir=$tempdir # would add -c but a bug makes it not work in version 4.41. Fixed in later version of latexmk.
cp $tempdir/$1.gen.pdf .

# cleanup
rm -rf $tempdir
rm $1.gen.md
rm $1.gen.tex
