;;
;; File: init-bindings.el
;; Set up my custom key-bindings.

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
(global-set-key (kbd "TAB") 'smart-tab)

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

(provide 'init-bindings)
