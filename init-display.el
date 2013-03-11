;;
;; File: init-display.el
;; Look and feel related customisations.

;; Solarized colour-theme
(load-theme 'solarized-dark t)

;; Set custom font.
;; Inconsolata is larger on Windows, so size differs between `system-type'.
(defvar font-name "Inconsolata LGC")
(defvar font-size (if (eq system-type 'windows-nt)
                      10
                      12))
(defvar font-string (format "%s-%d" font-name font-size))

;; Ensure font exists first.
;; Font height is pt size times 10.
(unless (null (x-list-fonts font-name))
  (setq graphene-default-font font-string)
  (setq graphene-fixed-pitch-font font-string)
  (defvar graphene-font-height (* font-size 10)))

;; Disable menu-bar on Windows.
(when (eq system-type 'windows-nt)
  (menu-bar-mode -1))

(provide 'init-display)
