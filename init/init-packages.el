;; File: init-packages.el
;; Installs any needed packages (usually only on first run).
;; Code adapted from prelude.el setup.

;; Required for running this code.
(require 'cl)
(require 'package)

;; Add the Melpa repository to the list of package sources
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)

;; Initialise the package system.
(package-initialize)

;; Define what packages are required from package.el.
(defvar required-packages
  '(ac-cider
    ace-jump-mode
    ag
    android-mode
    anzu
    auto-complete-clang-async
    bookmark+
    browse-kill-ring
    cider
    clojure-mode
    csharp-mode
    deft
    dummy-h-mode
    edit-server
    enh-ruby-mode
    erc-image
    find-file-in-repository
    flx
    flx-ido
    flycheck
    flycheck-pos-tip
    gist
    git-gutter
    git-gutter-fringe
    graphene
    ido-hacks
    ido-vertical-mode
    iedit
    jedi
    magit
    markdown-mode
    monky
    multiple-cursors
    pos-tip
    switch-window
    web-mode
    yasnippet
    whitespace-cleanup-mode)
  "A list of packages to ensure are installed at launch.")

;; Function for determining if packages are installed.
(defun required-packages-installed-p ()
  (loop for p in required-packages
        when (not (package-installed-p p)) do (return nil)
        finally (return t)))

;; Check which packages need to be installed and install them.
(unless (required-packages-installed-p)
  ;; Prevent auto-save-list while installing.
  (setq auto-save-list-file-name nil)

  ;; Check for new packages (package versions)
  (message "%s" "Updating package database...")
  (package-refresh-contents)
  (message "%s" " done.")

  ;; Install the missing packages
  (dolist (p required-packages)
    (when (not (package-installed-p p))
      (package-install p)))

  ;; Finally, if the compile-log window is active, kill it.
  (let ((buf (get-buffer "*Compile-Log*")))
    (when buf (delete-windows-on buf))))

(provide 'init-packages)
