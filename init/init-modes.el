;;
;; File: init-modes.el
;; Initialisation and customisation of modes.
;; Note that some are handled by Graphene, but may be customised here.

;; Custom auto-mode additions.
(add-to-list 'auto-mode-alist '("\\.md" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.mako\\'" . html-mode))
(add-to-list 'auto-mode-alist '("\\.h$" . dummy-h-mode))
(autoload 'dummy-h-mode "dummy-h-mode" "Dummy header mode." t)

;; Disable speedbar until it's fixed.
(speedbar -1)

;; Automatically clean whitespace on save.
(global-whitespace-cleanup-mode)

;; Edit-server.
;; Provides editing from Chrome.
(require 'edit-server)
(edit-server-start)

;; Tramp-mode on windows needs plink.
(when (eq system-type 'windows-nt)
  (setq tramp-default-method "plink"))

;; Ace-jump.
(require 'ace-jump-mode)

;; Asynchronous clang auto-completion.
(require 'auto-complete-clang-async)

;; Auto-complete configuration.
;; Clang-completion specific.
(defun ac-clang-mode-setup ()
  (setq ac-clang-complete-executable "~/.emacs.d/etc/bin/clang-complete")
  (setq ac-sources '(ac-source-clang-async))
  (ac-clang-launch-completion-process))
(setq ac-quick-help-delay 0.5)

;; Add hooks in clang-friendly modes.
(defun my-ac-config ()
  (add-hook 'c-mode-hook 'ac-clang-mode-setup)
  (add-hook 'objc-mode-hook 'ac-clang-mode-setup))

;; Only use clang autocomplete under OS X with clang installed.
(when (and (eq system-type 'darwin)
           (file-exists-p "/usr/local/bin/clang"))
  (my-ac-config))

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
(setq mc/list-file "~/.emacs.d/etc/.mc-lists.el")
(require 'multiple-cursors)

;; Org-mode setup.
;; Keywords.
(setq org-todo-keywords
      '((sequence "TODO(t)" "|" "DONE(d!)")
        (sequence "|" "CANCELED(c@/!)")
        (sequence "|" "STALLED(s@/!)")
        (sequence "VERIFY(v@)" "|")
        (sequence "PENDING(p@/!)" "|" )))

;; Automatically update TODO, etc.
(defun myorg-update-parent-cookie ()
  (when (equal major-mode 'org-mode)
    (save-excursion
      (ignore-errors
        (org-back-to-heading)
        (org-update-parent-todo-statistics)))))

(defadvice org-kill-line (after fix-cookies activate)
  (myorg-update-parent-cookie))
(defadvice kill-whole-line (after fix-cookies activate)
  (myorg-update-parent-cookie))

;; Android support and setup.
;; SDK and class paths set in `init-personal.el'.
(require 'android-mode)
(add-hook 'android-mode-hook
          (lambda ()
            (setq c-basic-offset 2)
            (setq tab-width 2)))

;; C#
;; Add csharp-mode to graphene's prog-modes.
(push 'csharp-mode-hook graphene-prog-mode-hooks)
;; csharp-mode isn't a normal prog-mode, so it needs to call the
;; shared-prog-mode-settings function manually.
(add-hook 'csharp-mode-hook
          (lambda ()
            (shared-prog-mode-settings)
            (smartparens-mode 0)))

;; ERC basic setup.
;; Further ERC settings are in `init-personal.el'.
(require 'erc-image)
(setq erc-image-inline-rescale 400)
(add-to-list 'erc-modules 'image)
(erc-update-modules)

;; Yasnippet setup.
(require 'yasnippet)

;; If custom snippets dir doesn't exist, create it.
;; We want to replace .emacs.d/snippets with .emacs.d/etc/snippets.
(defvar custom-snippets-dir "~/.emacs.d/etc/snippets/")
(unless (file-exists-p custom-snippets-dir)
  (make-directory custom-snippets-dir))

;; Trim out default custom snippet dir and append the one created above.
(setq yas-snippet-dirs (last yas-snippet-dirs 1))
(add-to-list 'yas-snippet-dirs custom-snippets-dir t)

(yas--initialize)

;; Terminal modes settings.
;; Disable yasnippet in term.
(add-hook 'term-mode-hook
          (lambda ()
            (yas-minor-mode -1)))
;; Use UTF-8 in term modes.
(defun term-use-utf8 ()
  (set-buffer-process-coding-system 'utf-8-unix 'utf-8-unix))
(add-hook 'term-exec-hook 'term-use-utf8)

;; Numerical window-switching with C-x o.
(require 'switch-window)

;; Column indicator mode settings.
(setq fci-rule-color "#292929")
(setq fci-rule-width 1)

;; Python config.
;; Jedi setup.
(setq jedi:setup-keys t)
(setq jedi:complete-on-dot t)
;; Python hook (sets up pyflakes, jedi, etc.)
(add-hook 'python-mode-hook
          (lambda ()
            (electric-indent-mode -1)
            (set-fill-column 79)
            (fci-mode 1)
            (jedi:setup)))

;; Common programming-mode settings.
(defun shared-prog-mode-settings ()
  (subword-mode 1)
  (hl-line-mode 1))
(add-hook 'prog-mode-hook 'shared-prog-mode-settings)

;; Set up flx.
(require 'flx-ido)
(flx-ido-mode 1)
;; Disable ido faces to see flx highlights.
(setq ido-use-faces nil)

;; Clojure development.
;; Auto-complete with nrepl.
(require 'ac-cider)
 (add-hook 'cider-mode-hook 'ac-cider-setup)
 (add-hook 'cider-interaction-mode-hook 'ac-cider-setup)
 (eval-after-load "auto-complete"
   '(add-to-list 'ac-modes 'cider-mode))
;; nrepl configuration.
(add-hook 'cider-interaction-mode-hook 'cider-turn-on-eldoc-mode)

;; Bookmarks+
(setq bmkp-last-as-first-bookmark-file "~/.emacs.d/etc/bookmarks")

;; Ruby stuff.
(add-to-list 'ac-modes 'enh-ruby-mode)

;; ido-vertical
(require 'ido-vertical-mode)
(ido-vertical-mode t)

;; Anzu
(global-anzu-mode +1)
(global-set-key (kbd "M-%") 'anzu-query-replace)
(global-set-key (kbd "C-M-%") 'anzu-query-replace-regexp)

;; Git-gutter setup.
(require 'git-gutter-fringe)
(global-git-gutter-mode t)

;; Deft.
(require 'deft)
(setq deft-extension "org"
      deft-text-mode 'org-mode
      deft-auto-save-interval 30.0
      deft-use-filename-as-title t)

;; Flycheck-pos-tip setup.
;; Shows flycheck error using popup.el.
(require 'flycheck)
(setq flycheck-display-errors-function #'flycheck-pos-tip-error-messages)

;; Browse-kill-ring with default bind (M-y).
(require 'browse-kill-ring)
(browse-kill-ring-default-keybindings)

;; Ag settings.
(require 'ag)
(setq ag-highlight-search t)

;; Auto-complete settings (disabling company).
(company-mode -1)
(global-company-mode -1)
(global-auto-complete-mode t)

(eval-after-load 'auto-complete
  '(progn
     (require 'auto-complete-config)
     (ac-config-default)
     (define-key ac-completing-map (kbd "ESC") 'ac-stop)
     (setq ac-delay 0.125
           ac-auto-show-menu 0.25
           ac-auto-start 3
           ac-quick-help-delay 2.0
           ac-ignore-case nil
           ac-candidate-menu-min 2
           ac-use-quick-help t
           ac-limit 10
           ac-disable-faces nil)
     (setq-default ac-sources '(ac-source-abbrev
                                ac-source-words-in-buffer
                                ac-source-filename
                                ac-source-imenu
                                ac-source-dictionary
                                ac-source-words-in-same-mode-buffers))))

(provide 'init-modes)
