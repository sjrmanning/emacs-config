;;
;; File: init-settings.el
;; Various small customisations, mostly editing related.

;; Default directory
(setq default-directory "~")

;; Set home dir
(cd (expand-file-name "~/"))

;; Indentation (C-modes)
(setq c-default-style "bsd"
      c-basic-offset 4)

;; Disable smartparens because it breaks indentation.
(setq graphene-autopair-auto nil)

;; Tabs => Spaces (4)
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)

;; Enable y/n answers
(fset 'yes-or-no-p 'y-or-n-p)

;; Keep backups in a separate directory
(defun make-backup-file-name (file)
  (concat "~/.emacs.d/cache/backups" (file-name-nondirectory file) "~"))

;; Change auto-save-list directory.
(setq auto-save-list-file-prefix "~/.emacs.d/cache/auto-save-list/.saves-")

;; Change eshell directory.
(setq eshell-directory-name "~/.emacs.d/cache/eshell")

;; Since I use .emacs.d/cache as a temp directory, this checks whether
;; it exists and creates the directory if necessary.
(unless (file-exists-p "~/.emacs.d/cache/")
  (make-directory "~/.emacs.d/cache/"))

;; Do the same for .emacs.d/etc, which is used for settings files
;; and other similar stuff (keeping lib/ solely for .el files).
(unless (file-exists-p "~/.emacs.d/etc/")
  (make-directory "~/.emacs.d/etc/"))

;; Change bookmarks file location.
(setq bookmark-file "~/.emacs.d/etc/bookmarks")

(provide 'init-settings)
