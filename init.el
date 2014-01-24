(setq inhibit-startup-screen t)

(setq x-select-enable-clipboard t)
(setq inteprogram-paste-function 'x-cut-buffer-or-selection-value)

;; (add-to-list
;;  'display-buffer-alist
;;  '("\\*rspec-compilation\\*" display-buffer-reuse-window (reusable-frames . t)))

(require 'color-theme)
(color-theme-initialize)
(load-file "~/.emacs.d/color-theme-railscasts.el")
(color-theme-railscasts)
(set-face-attribute 'default nil :height 160)

(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
(package-initialize)

(defvar rad-packages
  '(
    gist
    helm
    magit
    rspec-mode
    rvm
    yaml-mode
    wrap-region)
  "A list of packages that I want everywhere.")

(defun rad-packages-installed-p ()
  "True if all packages in rad-packages are installed."
  (loop for p in rad-packages
	when (not (package-installed-p p)) do (return nil)
	finally (return t)))

(unless (rad-packages-installed-p)
  (message "%s" "Refreshing package database...")
  (package-refresh-contents)
  (message "%s" " done.")
  (dolist (p rad-packages)
    (when (not (package-installed-p p)) (package-install p))))

(if (file-exists-p "~/.rvm") (setq rspec-use-rvm t))
