;;
;; File: init-display.el
;; Look and feel related customisations.

;; Solarized colour-theme
(load-theme 'solarized-dark t)

;; Font
;; Checks if the font given exists first.
(defvar font-name "Meslo LG L DZ-12")
(unless (null (x-list-fonts font-name))
  (set-face-font 'default font-name))

(provide 'init-display)
