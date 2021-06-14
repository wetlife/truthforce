.PHONY: all clean
all: truthforce.net.tex truthforce.css .latex2html-init
	@echo "######################## MAKING TRUTHFORCE ########################"
	# TODO FIXME headings wrong: multiple h1-elements, links to h2-elements are broken
	# compile source from LaTeX into html:
	latex2html -split 0 truthforce.net.tex
	# upgrade document to html5 and backup original html:
	sed -i.BAK 's/<!DOCTYPE.*EN">/<!DOCTYPE html>/' truthforce.net/index.html
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
	sed -i 's/<BODY >/<body><div id="paper"><h1 id="title">Truthforce<\/h1>/' truthforce.net/index.html
	# insert a visible title in page:
	sed -i '/<BODY>/a <h1>Truthforce<\/h1>' truthforce.net/index.html
	# move contents to end of body
	ed -v truthforce.net/index.html <<EOF \
	/Contents--/,/End of Table of Contents--/m\$-3 \
	w truthforce.net/index.html \
	w /tmp/sandbox/tested \
	q \
	. \
	EOF
	vimdiff /tmp/sandbox/tested truthforce.net/index.html
	# remove extra <BR>-elements
	sed -i 's/^<BR>//g' truthforce.net/index.html
	# make internal links local to the document:
	sed -i 's/HREF="truthforce.net.html/HREF="/g' truthforce.net/index.html
	# insert closing div-tag
	sed -i '/<\/BODY>/i <\/div>' truthforce.net/index.html
	@echo "##### TRUTHFORCE MADE: VIEW TRUTHFORCE AT truthforce.net/index.html #####"

clean:
	# remove the directory containing output
	rm -rf truthforce.net/
