(setq package-check-signature nil)

(require 'package)
(add-to-list 'package-archives
	     '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)

;; package-refresh-contents
;; package-install auto-complete
(ac-config-default)
(global-auto-complete-mode t)

;; Parens!!
(show-paren-mode t)

;; Slime auto-complete
;; is necessary previously auto-complete and slime
;; package-install ac-slime
(add-hook 'slime-mode-hook 'set-up-slime-ac)
(add-hook 'slime-repl-mode-hook 'set-up-slime-ac)
(eval-after-load "auto-complete"
  '(add-to-list 'ac-modes 'slime-repl-mode))

(setq backup-directory-alist `(("." . "~/.saves")))
(display-time)

(load (expand-file-name "~/quicklisp/slime-helper.el"))
(setq inferior-lisp-program "/usr/local/bin/sbcl")

;; Themes (cli and gtk)
;; packages: solarized-theme
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
(load-theme 'solarized-ligth t)
;; or (load-theme RET solarized-dark) instant charge

(global-set-key "\C-x\C-n" 'other-window)
(global-set-key "\C-x\C-p" 'other-window-backward)

(defun other-window-backward ()
  "Move to the previous windows."
  (interactive "P")
  (other-window (- (prefix-numeric-value n))))

;; Scroll lines
(defun scroll-n-lines-up (&optional n)
  "Scroll up N lines (1 by default)."
  (interactive "P")
  (scroll-up (prefix-numeric-value n)))

(defun scroll-n-lines-down (&optional n)
  "Scroll down N lines (1 by default)."
  (interactive "P")
  (scroll-down (prefix-numeric-value n)))

(global-set-key "\C-q" 'scroll-n-lines-up)
(global-set-key "\C-z" 'scroll-n-lines-down)

;; Insert special characters (C-x C-q 361)
(global-set-key "\C-x\C-q" 'quoted-insert)

;; Words navigation
(global-set-key "\C-i" 'move-beginning-of-line)
(global-set-key "\C-f" 'move-end-of-line)

;; Top and down point window
(defun point-to-top ()
  "Put point on top line of window."
  (interactive)
  (move-to-window-line 0))

(defun point-to-down ()
  "Put point on down line of window."
  (interactive)
  (move-to-window-line -1))

(global-set-key "\C-x\C-t" 'point-to-top)
(global-set-key "\C-x\C-d" 'point-to-down)

;; Symlink procedure
(defun read-only-if-symlink ()
  "Read only symlinks."
  (if (file-symlink-p buffer-file-name)
      (progn
	(setq buffer-read-only t)
	(message "File is a symlink."))))

(defun delete-unlynked-symbolic ()
  "Delete the unlynked symbolic."
  (if (file-symlink-p buffer-file-name)
      (let ((symb-name buffer-file-name)
	    (orig-file (file-symlink-p buffer-file-name)))
	(if (file-exists-p orig-file)
	    (read-only-if-symlink)
	  (progn
	    (delete-file symb-name)
	    (kill-buffer symb-name)
	    (message "Deleted unlinked symlink."))))))

(add-hook 'find-file-hook 'delete-unlynked-symbolic)

;; only buffer names
(defadvice switch-to-buffer (before existing-buffer
				    activate compile)
  "When interactive, switch to existing buffers only,
unless given a prefix argument."
  (interactive
   (list (read-buffer "Switch to buffer:"
		      (other-buffer)
		      (null current-prefix-arg)))))
