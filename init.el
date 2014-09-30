;; Emacs initialisation & config.
;; https://github.com/stafu/emacs-config

;; Prepare paths.
(setq load-path (cons "~/.emacs.d/init"   load-path))
(setq load-path (cons "~/.emacs.d/lib"    load-path))
(add-to-list 'exec-path "/usr/local/bin")
(add-to-list 'custom-theme-load-path "~/.emacs.d/lib/color-themes")

;; Ensure required packages are installed.
(require 'init-packages)

;; Load Graphene.
(require 'graphene)

;; Initialise settings.
(require 'init-settings)

;; Initialise display.
(require 'init-display)

;; Initialise custom functions.
(require 'init-defuns)

;; Initialise emacs modes.
(require 'init-modes)

;; Initialise bindings.
(require 'init-bindings)

;; Initialise personal settings.
(require 'init-personal)
