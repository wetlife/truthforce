.PHONY: all clean
all: truthforce.net.tex truthforce.css .latex2html-init
	@echo "######################## MAKING TRUTHFORCE ########################"
	# TODO FIXME links in contents not work since %s/subsection/section/g in html
	# TODO FIXME headings wrong: multiple h1-elements, links to h2-elementss are broken
	# compile source from LaTeX into html:
	latex2html -split 0 truthforce.net.tex
	# upgrade document to html5:
	sed -i 's/<!DOCTYPE.*EN">/<!DOCTYPE html>/' truthforce.net/index.html
	# declare language for accessibility:
	sed -i 's/<HTML>/<html lang="en">/' truthforce.net/index.html
	# declare encoding of characters:
	sed -i '/<HEAD>/i <meta charset="utf-8" />' truthforce.net/index.html
	# backup the compiled stylesheet output by latex2html:
	cp truthforce.net/truthforce.net.css truthforce.net/truthforce.net.css.original-generated-by-l2h
	# copy custom stylesheet over the compiled sheet output by latex2html:
	cp truthforce.css truthforce.net/truthforce.net.css
	# copy source-images into their respective locations
	cp *.png *.jpg truthforce.net/
	# link fonts:
	sed -i '/<\/HEAD>/i <link href="https://fonts.googleapis.com/css?family=Modak|Nunito|Roboto|Roboto+Mono|Special+Elite|Tomorrow&display=swap" rel="stylesheet" \/>' truthforce.net/index.html
	# open div#paper to simulate paper and open div#toc to float table of contents
	# FIXME remove div#toc
	# 	TODO style div#toc->ul#TofC
	sed -i.sed-backup 's/<BODY >/<body><div id="paper"><h1 id="title">Truthforce<\/h1>/' truthforce.net/index.html
	# insert a visible title in page:
	set -i '/<BODY>/a <h1>Truthforce<\/h1>' truthforce.net/index.html
	# make internal links local to the document:
	sed -i 's/HREF="truthforce.net.html/HREF="/g' truthforce.net/index.html
	# insert closing div-tags
	sed -i '/<\/BODY>/i <\/div>' truthforce.net/index.html
	@echo "##### TRUTHFORCE MADE: VIEW TRUTHFORCE AT truthforce.net/index.html #####"

clean:
	# remove the directory containing output
	rm -rf truthforce.net/
