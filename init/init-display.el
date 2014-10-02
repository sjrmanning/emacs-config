;;
;; File: init-display.el
;; Look and feel related customisations.

;; Monokai colour-theme.
(load-theme 'monokai t)

;; Set custom font.
;; Fonts larger on Windows (or home pixel density), so size differs
;; between `system-type'.
(defvar font-name "Source Code Pro")
(defvar font-size (if (eq system-type 'windows-nt)
                      10
                      13))
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

;; Use a 2px bar cursor.
(setq-default cursor-type '(bar . 2))

(provide 'init-display)
