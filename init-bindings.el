;;
;; File: init-bindings.el
;; Set up my custom global key-bindings.
;; Local/mode-specific bindings are handled in init-modes.el

;; C-w to backward kill word
;; C-x C-k becomes kill-region
(global-set-key "\C-w" 'backward-kill-word)
(global-set-key "\C-x\C-k" 'kill-region)
(global-set-key "\C-c\C-k" 'kill-region)

;; M-x alternative (C-x C-m)
(global-set-key "\C-x\C-m" 'execute-extended-command)
(global-set-key "\C-c\C-m" 'execute-extended-command)

;; Goto-line
(global-set-key "\M-g" 'goto-line)

;; Full-screen toggle.
(global-set-key "\C-c\M-f" 'toggle-frame-fullscreen)

;; Joins following line onto current line.
(global-set-key (kbd "M-j")
                (lambda ()
                  (interactive)
                  (join-line -1)))

;; Moving around a bit quicker (5x C-n, C-f etc.) with Shift.
(global-set-key (kbd "C-S-n")
                (lambda ()
                  (interactive)
                  (ignore-errors (next-line 5))))

(global-set-key (kbd "C-S-p")
                (lambda ()
                  (interactive)
                  (ignore-errors (previous-line 5))))

(global-set-key (kbd "C-S-f")
                (lambda ()
                  (interactive)
                  (ignore-errors (forward-char 5))))

(global-set-key (kbd "C-S-b")
                (lambda ()
                  (interactive)
                  (ignore-errors (backward-char 5))))

;; Comment and uncomment region
(define-key global-map (kbd "s-/") 'comment-region)
(define-key global-map (kbd "s-.") 'uncomment-region)

;; Window movement with C-c C-w f/b/p/n
(define-key global-map (kbd "C-c C-w f") 'windmove-right)
(define-key global-map (kbd "C-c C-w b") 'windmove-left)
(define-key global-map (kbd "C-c C-w p") 'windmove-up)
(define-key global-map (kbd "C-c C-w n") 'windmove-down)

;; Launch a shell
(global-set-key (kbd "C-!") 'eshell)

;; Smart TAB
(global-set-key (kbd "TAB") 'my-smart-tab)

;; Multiple buffer isearch
(global-set-key (kbd "C-M-z") 'isearch-multiple-buffers)

;; Narrowed iedit
(global-set-key (kbd "C-:") 'iedit-dwim)
;; Global iedit
(global-set-key (kbd "C-;") 'iedit-mode)

;; Fast switch to Gnus
(global-set-key (kbd "C-c n") 'switch-to-gnus)

;; Global ace-jump
(define-key global-map (kbd "C-o") 'ace-jump-mode)

;; Auto-complete bindings
(define-key ac-menu-map "\C-n" 'ac-next)
(define-key ac-menu-map "\C-p" 'ac-previous)
(define-key ac-menu-map "\t" 'ac-complete)

;; Multiple-cursors bindings
;; From active region to multiple cursors:
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C-S-c C-e") 'mc/edit-ends-of-lines)
(global-set-key (kbd "C-S-c C-a") 'mc/edit-beginnings-of-lines)
;; Rectangular region mode
(global-set-key (kbd "C-c r") 'set-rectangular-region-anchor)
;; Based on keywords
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)

;; Magit bindings
(global-set-key (kbd "C-x g") 'magit-status)

;; Org-mode
(global-set-key (kbd "C-c x") 'org-capture)

;; Global visit ansi-term.
(global-set-key (kbd "<f2>") 'visit-term-buffer)

;; Switch to previous buffer.
(global-set-key (kbd "C-c b") 'switch-to-previous-buffer)

(provide 'init-bindings)
