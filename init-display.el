;;
;; File: init-display.el
;; Look and feel related customisations.

;; Light Table inspired colour-theme.
(load-theme 'noctilux t)

;; Manually set ac-selection-face (graphene-theme locks this).
;; Bit hacky, will need to look into this.
(defadvice load-theme
  (after load-graphene-theme (theme &optional no-confirm no-enable) activate)
  (set-face-attribute 'ac-selection-face nil
                      :foreground "#13879C"
                      :background "#96FAFF"))


;; Set custom font.
;; Fonts larger on Windows (or home pixel density), so size differs
;; between `system-type'.
(defvar font-name "Inconsolata LGC")
(defvar font-size (if (eq system-type 'windows-nt)
                      10
                      14))
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

;; If OS X full-screen is available, do it.
(when (fboundp 'toggle-frame-fullscreen)
  (toggle-frame-fullscreen))

(provide 'init-display)
