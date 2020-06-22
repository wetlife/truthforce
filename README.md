# Generate Truthforce
Truthforce's build is built with GNU's `make` and `latex2html`. Issue this command to make truthforce:
```
make
```

1. `make` executes `latex2html` on the file `truthforce.net.tex` to convert the LaTeX to HTML in the directory `truthforce.net`.
2. `make` then copies the stylesheet `truthforce.css` into directory `truthforce.net`.
3. `make` inserts text into `truthforce.net/index.html` to customize the content.
4. `truthforce.net` now contains the document in HTML at `truthforce.net/index.html`.

# Clean Generated Files
Issue the command `make clean` to delete folder `truthforce.net/`.

# Acknowledgements
The font used is `Special Elite` authored by Astigmatic and hosted by Google Fonts API.
A paper texture is not cited though should be traced back to its source by searching the Web for its unchanged filename.
Tileable wood texture by ftourini on deviantart.com.
