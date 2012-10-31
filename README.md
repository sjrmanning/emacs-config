Emacs Config
============

A cleaner, saner version of my Emacs setup. Uses [Graphene](https://github.com/rdallasgray/graphene) as a base and uses package management to provide byte-compilation across multiple different systems with no mess.

Setup
-----

Clone this repository into your home directory as .emacs.d.

    git clone git://github.com/stafu/emacs-config.git ~/.emacs.d

...then run Emacs. On the first run, Emacs will install and compile any packages handled by the package manager. This is checked on each run, so if you want to add a package to install, simply add it to the list in `init-packages.el`, and the next time Emacs runs it will automatically install and compile the new package alone.

Prerequisites
-------------

You'll at least need Emacs 24 for package.el and the new color-theme system. This setup is used and tested with 24.2.
