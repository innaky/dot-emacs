(global-set-key "\C-x\C-n" 'other-window)
(global-set-key "\C-x\C-p" 'other-window-backward)

(defun other-window-backward ()
  "Move to the previous windows."
  (interactive)
  (other-window -1))
