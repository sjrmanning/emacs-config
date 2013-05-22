;;
;; File: init-personal.el
;; Settings that likely relate only to my setup.

;; ERC personalisation.
(setq erc-autojoin-channels-alist
      '((".*" "#dev")))
(setq erc-email-userid "s")

;; Method for connecting to work IRC server.
(defun erc-connect-moonshine ()
  "Connect to work IRC server and channels."
  (interactive)
  (erc :server "moonshine.local" :port 6667
       :nick "simon" :full-name "Sympathy for the Devil"))

;; Android settings.
(setq android-mode-sdk-dir "~/Dev/android-sdk-macosx/")
(add-hook 'gud-mode-hook
          (lambda ()
            (add-to-list 'gud-jdb-classpath
                         "~/Dev/android-sdk-macosx/platforms/android-16/android.jar")))

;; Eclim default workspace.
(setq eclimd-default-workspace "~/Documents/EclipseWorkspace")

;; Org-mode personal settings.
(setq org-directory "~/Org")
(setq org-default-notes-file (concat org-directory "/Notes.org"))

;; Org-mode templates.
(setq org-capture-templates
      '(("w" "Work Task" entry (file+headline (concat org-directory "/Work.org") "Tasks")
         "* TODO %?\n %i\n")
        ("h" "Home Task" entry (file+headline (concat org-directory "/Home.org") "Tasks")
         "* TODO %?\n %i\n")
        ("n" "Note" entry (file+headline (concat org-directory "/Notes.org") "Captured")
         "* %^{Description} %T %^G\n %i%?\n %A")))

;; Use zsh as default term shell.
(setq explicit-shell-file-name "zsh")

;; Use custom executable for python flymake (pyflakes + pep8)
(setq flymake-python-pyflakes-executable "pycheck")

(provide 'init-personal)
