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
    helm-cmd-t
    magit
    rspec-mode
    ruby-end
    rvm
    smart-tab
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

(eval-after-load "rspec-autoloads"
  '(progn
     (setq-default rspec-use-rvm (file-exists-p "~/.rvm"))))

(require 'recentf)
(recentf-mode t)
(setq recentf-max-menu-items 25)

(require 'helm-config)
(require 'helm-cmd-t)
(setq helm-ff-lynx-style-map nil
      helm-input-idle-delay 0.1
      helm-idle-delay 0.1)
(require 'helm-C-x-b)
(global-set-key (kbd "C-c t") 'helm-cmd-t)
(global-set-key (kbd "C-c b") 'helm-C-x-b)
