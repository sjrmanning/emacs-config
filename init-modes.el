;;
;; File: init-modes.el
;; Initialisation and customisation of modes.
;; Note that some are handled by Graphene, but may be customised here.

;; Dummy header mode.
;; Switches mode to c++, c, objc depending on .h contents.
(add-to-list 'auto-mode-alist '("\\.h$" . dummy-h-mode))
(autoload 'dummy-h-mode "dummy-h-mode" "Dummy header mode" t)

;; Disable speedbar until it's fixed.
(speedbar -1)

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

;; Autopair (replacing smartparens).
(require 'autopair)
(autopair-global-mode)

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
(require 'multiple-cursors)
(setq mc/list-file "~/.emacs.d/etc/.mc-lists.el")

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

;; Capture settings.
(setq org-directory "~/Org")
(setq org-default-notes-file (concat org-directory "/Notes.org"))
;; Templates.
(setq org-capture-templates
      '(("w" "Work Task" entry (file+headline (concat org-directory "/Work.org") "Tasks")
         "* TODO %?\n %i\n")
        ("h" "Home Task" entry (file+headline (concat org-directory "/Home.org") "Tasks")
         "* TODO %?\n %i\n")
        ("n" "Note" entry (file+headline (concat org-directory "/Notes.org") "Captured")
         "* %^{Description} %T %^G\n %i%?\n %A")
        ))

;; Android support.
(require 'android-mode)
(setq android-mode-sdk-dir "~/Dev/android-sdk-macosx/")
(add-hook 'android-mode-hook
          (lambda ()
            (define-key android-mode-map (kbd "C-x r")
              (lambda ()
                (interactive)
                (android-build-with-eshell)))
            (setq c-basic-offset 2)))
(add-hook 'gud-mode-hook
          (lambda ()
            (add-to-list 'gud-jdb-classpath
                         "~/Dev/android-sdk-macosx/platforms/android-16/android.jar")))

;; Setup markdown-mode autoload.
(setq auto-mode-alist
      (cons '("\\.md" . markdown-mode) auto-mode-alist))

;; C#
;; Add csharp-mode to graphene's prog-modes.
(push 'csharp-mode-hook graphene-prog-mode-hooks)
(add-hook 'csharp-mode-hook (lambda ()
                              (autopair-mode 0)))

;; Enable subword mode for programming modes.
(add-hook 'prog-mode-hook 'subword-mode)

;; ERC setup.
(require 'erc-image)
(setq erc-image-inline-rescale 600)
(add-to-list 'erc-modules 'image)
(erc-update-modules)
(require 'erc-match)
(setq erc-keywords '("simon"))
(setq erc-autojoin-channels-alist
      '((".*" "#dev")))
(setq erc-email-userid "s")
(defun irc-work-connect ()
  "Connect to work IRC server and channels."
  (interactive)
  (erc :server "moonshine.local" :port 6667
       :nick "simon" :full-name "Sympathy for the Devil"))

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
;; Disable yasnippet and autopair in term.
(add-hook 'term-mode-hook
          (lambda()
            (yas-minor-mode -1)
            (autopair-mode 0)))
;; Use UTF-8 in term modes.
(defun term-use-utf8 ()
  (set-buffer-process-coding-system 'utf-8-unix 'utf-8-unix))
(add-hook 'term-exec-hook 'term-use-utf8)

;; Emacs-Eclim setup.
(require 'eclim)
(require 'eclimd)
(global-eclim-mode)
(setq eclimd-default-workspace "~/Documents/EclipseWorkspace")

;; Add Eclim to autocomplete.
(require 'ac-emacs-eclim-source)
(ac-emacs-eclim-config)

;; Compilation mode.
;; Auto-close successful compilation window.
(setq compilation-exit-message-function 'compilation-exit-autoclose)
(defun compilation-exit-autoclose (status code msg)
  (when (and (eq status 'exit) (zerop code))
    (bury-buffer)
    (delete-window (get-buffer-window (get-buffer "*compilation*"))))
  (cons msg code))

(provide 'init-modes)
