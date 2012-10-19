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
;; Display ido results vertically.
(setq ido-decorations (quote ("\n-> " "" "\n   " "\n   ..." "[" "]" " [No match]" " [Matched]" " [Not readable]" " [Too big]" " [Confirm]")))
(defun ido-disable-line-trucation () (set (make-local-variable 'truncate-lines) nil))
(add-hook 'ido-minibuffer-setup-hook 'ido-disable-line-trucation)

;; Required as minibuffer-complete overrides otherwise.
(add-hook 'ido-setup-hook 
          (lambda () 
            (define-key ido-completion-map [tab] 'ido-complete)))

;; Uniquify eases handling of buffers with the same name.
(require 'uniquify)

;; iedit provides Sublime-like multiple instance editing.
(require 'iedit)

(provide 'init-modes)
