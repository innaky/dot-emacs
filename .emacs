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
