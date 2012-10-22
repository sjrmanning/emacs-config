;;
;; File: init-modes.el
;; Initialisation and customisation of modes.
;; Note that some are handled by Graphene, but may be customised here.

;; Dummy header mode.
;; Switches mode to c++, c, objc depending on .h contents.
(add-to-list 'auto-mode-alist '("\\.h$" . dummy-h-mode))
(autoload 'dummy-h-mode "dummy-h-mode" "Dummy header mode" t)

;; Edit-server.
;; Provides editing from Chrome.
(require 'edit-server)
(edit-server-start)

;; Ace-jump.
(require 'ace-jump-mode)

;; Asynchronous clang auto-completion.
(require 'auto-complete-clang-async)

;; Auto-complete configuration.
;; Clang-completion specific.
(defun ac-cc-mode-setup ()
  (setq ac-clang-complete-executable "~/.emacs.d/lib/bin/clang-complete")
  (setq ac-sources '(ac-source-clang-async))
  (ac-clang-launch-completion-process)
  )
(setq ac-quick-help-delay 0.5)

;; Add hooks in clang-friendly modes.
(defun my-ac-config ()
  (add-hook 'c-mode-common-hook 'ac-cc-mode-setup)
  (add-hook 'objc-mode-common-hook 'ac-cc-mode-setup))
(my-ac-config)

;; Enable menu-map to use custom bindings.
(setq ac-use-menu-map t)

;; Change location of history dat file.
(setq ac-comphist-file "~/.emacs.d/cache/ac-comphist.dat")

;; Ido-mode settings.
(ido-mode 1)
(setq ido-save-directory-list-file "~/.emacs.d/cache/.ido.last"
      ido-enable-last-directory-history t
      ido-max-work-directory-list 30
      ido-max-work-file-list 50
      ido-use-filename-at-point nil
      ido-use-url-at-point nil
      ido-max-prospects 8
      ido-configm-unique-completion t
      ido-auto-merge-work-directories-length 0)

;; Display ido results vertically.
(setq ido-decorations (quote ("\n-> " "" "\n   " "\n   ..." "[" "]" " [No match]" " [Matched]" " [Not readable]" " [Too big]" " [Confirm]")))
(defun ido-disable-line-trucation () (set (make-local-variable 'truncate-lines) nil))
(add-hook 'ido-minibuffer-setup-hook 'ido-disable-line-trucation)

;; Ido key bindings.
(defun mp-ido-hook ()
  (define-key ido-completion-map (kbd "C-h") 'ido-delete-backward-updir)
  (define-key ido-completion-map (kbd "C-w") 'ido-delete-backward-word-updir)
  (define-key ido-completion-map (kbd "C-n") 'ido-next-match)
  (define-key ido-completion-map (kbd "C-n") 'ido-next-match)
  (define-key ido-completion-map (kbd "C-p") 'ido-prev-match)
  (define-key ido-completion-map [tab] 'ido-complete))
(add-hook 'ido-setup-hook 'mp-ido-hook)

;; Uniquify eases handling of buffers with the same name.
(require 'uniquify)

;; iedit provides Sublime-like multiple instance editing.
(require 'iedit)

;; Change multiple-cursor settings location.
(require 'multiple-cursors)
(setq mc/list-file "~/.emacs.d/lib/.mc-lists.el")

;; Org-mode setup.
(setq org-todo-keywords
      '((sequence "TODO(t)" "|" "DONE(d!)")
        (sequence "|" "CANCELED(c@/!)")
        (sequence "|" "STALLED(s@/!)")
        (sequence "FUTURE(f)" "|")
        (sequence "PENDING(p@/!)" "|" )))

(provide 'init-modes)
