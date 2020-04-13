(package-initialize)

(require 'package)
(add-to-list 'package-archives
	     (quote
	      (("melpa" . "http://stable.melpa.org/pacakges/")
	       ("gnu" . "https://elpa.gnu.org/packages/"))))

(setq backup-directory-alist `(("." . "~/.saves")))
(display-time)

(load (expand-file-name "~/quicklisp/slime-helper.el"))
(setq inferior-lisp-program "/usr/local/bin/sbcl")

(global-set-key "\C-x\C-n" 'other-window)
(global-set-key "\C-x\C-p" 'other-window-backward)

(defun other-window-backward ()
  "Move to the previous windows."
  (interactive "P")
  (other-window (- (prefix-numeric-value n))))

;; Scroll lines
(defun scroll-n-lines-up ()
  "Scroll up N lines (1 by default)."
  (interactive "P")
  (scroll-up (prefix-numeric-value n)))

(defun scroll-n-lines-down ()
  "Scroll down N lines (1 by default)."
  (interactive "P")
  (scroll-down (prefix-numeric-value n)))

(global-set-key "\C-q" 'scroll-n-lines-up)
(global-set-key "\C-z" 'scroll-n-lines-donw)

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
