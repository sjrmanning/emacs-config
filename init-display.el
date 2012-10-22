;;
;; File: init-display.el
;; Look and feel related customisations.

;; Solarized colour-theme
(load-theme 'solarized-dark t)

;; Set custom font
;; Meslo is larger on Windows, so size differs between `system-type'.
(defvar font-name (if (eq system-type 'windows-nt)
                      "Meslo LG L DZ-10"
                      "Meslo LG L DZ-13"))

;; Check that given font exists first.
(unless (null (x-list-fonts font-name))
  (set-face-font 'default font-name))

;; Disable menu-bar on Windows.
(when (eq system-type 'windows-nt)
  (menu-bar-mode -1))

(provide 'init-display)
