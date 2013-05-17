;;; flymake-popup.el --- displays flymake error msg in popup after delay
;; Modified from flymake-cursor.el
(require 'cl)
(require 'popup)

(defvar flyp--e-at-point nil
  "Error at point, after last command")

(defvar flyp--e-display-timer nil
  "A timer; when it fires, it displays the stored error message.")

(defun flyp/maybe-fixup-message (errore)
  "pyflake is flakey if it has compile problems, this adjusts the
message to display, so there is one ;)"
  (cond ((not (or (eq major-mode 'Python) (eq major-mode 'python-mode) t)))
        ((null (flymake-ler-file errore))
         ;; normal message do your thing
         (flymake-ler-text errore))
        (t ;; could not compile error
         (format "compile error, problem on line %s" (flymake-ler-line errore)))))

(defun flyp/show-stored-error-now ()
  "Displays the stored error in a popup."
  (interactive)
  (let ((editing-p (= (minibuffer-depth) 0)))
    (if (and flyp--e-at-point editing-p)
        (progn
          (let* ((line-no            (flymake-current-line-no))
                 (line-err-info-list (nth 0 (flymake-find-err-info flymake-err-info line-no)))
                 (menu-data          (flymake-make-err-menu-data line-no line-err-info-list)))
            (if menu-data
                (popup-tip (mapconcat '(lambda (e) (nth 0 e))
                                      (nth 1 menu-data)
                                      "\n"))))
          (setq flyp--e-display-timer nil)))))


(defun flyp/-get-error-at-point ()
  "Gets the first flymake error on the line at point."
  (let ((line-no (line-number-at-pos))
        flyp-e)
    (dolist (elem flymake-err-info)
      (if (eq (car elem) line-no)
          (setq flyp-e (car (second elem)))))
    flyp-e))


;;;###autoload
(defun flyp/show-fly-error-at-point-now ()
  "Display a menu with errors/warnings for current line if it has errors and/or warnings."
  (interactive)
  (if flyp--e-display-timer
      (progn
        (cancel-timer flyp--e-display-timer)
        (setq flyp--e-display-timer nil)))
  (let* ((line-no            (flymake-current-line-no))
         (line-err-info-list (nth 0 (flymake-find-err-info flymake-err-info line-no)))
         (menu-data          (flymake-make-err-menu-data line-no line-err-info-list)))
    (if menu-data
        (popup-tip (mapconcat '(lambda (e) (nth 0 e))
                              (nth 1 menu-data)
                              "\n")))
    ))

;;;###autoload
(defun flyp/show-fly-error-at-point-pretty-soon ()
  "If the cursor is sitting on a flymake error, grab the error,
and set a timer for \"pretty soon\". When the timer fires, the error
message will be displayed in a popup.

This allows a post-command-hook to NOT cause a popup to be
updated 10,000 times as a user scrolls through a buffer
quickly. Only when the user pauses on a line for more than a
second, does the flymake error message (if any) get displayed.

"
  (if flyp--e-display-timer
      (cancel-timer flyp--e-display-timer))

  (let ((error-at-point (flyp/-get-error-at-point)))
    (if error-at-point
        (setq flyp--e-at-point error-at-point
              flyp--e-display-timer
              (run-at-time "0.5 sec" nil 'flyp/show-stored-error-now))
      (setq flyp--e-at-point nil
            flyp--e-display-timer nil))))


;;;###autoload
(eval-after-load "flymake"
  '(progn

     (defadvice flymake-goto-next-error (after flyp/display-message-1 activate compile)
       "Display the error in a popup rather than having to mouse over it."
       (flyp/show-fly-error-at-point-now))

     (defadvice flymake-goto-prev-error (after flyp/display-message-2 activate compile)
       "Display the error in a popup rather than having to mouse over it."
       (flyp/show-fly-error-at-point-now))

     (defadvice flymake-mode (before flyp/post-command-fn activate compile)
       "Add functionality to the post command hook so that if the
cursor is sitting on a flymake error the error information is
displayed in a popup (rather than having to mouse over it)."
       (add-hook 'post-command-hook 'flyp/show-fly-error-at-point-pretty-soon t t))))


(provide 'flymake-popup)
