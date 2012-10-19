;; Emacs initialisation

;; Require Emacs' package functionality
(require 'package)
;; Add the Melpa repository to the list of package sources
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
;; Initialise the package system.
(package-initialize)

;; Load-paths
(setq load-path (cons "~/.emacs.d/"       load-path))
(setq load-path (cons "~/.emacs.d/lib"    load-path))
(add-to-list 'custom-theme-load-path "~/.emacs.d/lib/color-themes")

;; Graphene
(require 'graphene)

;; Initialise display.
(require 'init-display)

;; Initialise custom functions.
(require 'init-defuns)

;; Initialise emacs modes.
(require 'init-modes)

;; Initialise bindings.
(require 'init-bindings)

;; Initialise settings.
(require 'init-settings)
