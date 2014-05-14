(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-archive-default-command (quote org-archive-to-archive-sibling))
 '(org-log-done (quote note))
 '(org-log-reschedule (quote note))
 '(org-log-redeadline (quote note))
 '(org-blank-before-new-entry (quote ((heading . t) (plain-list-item . t)))))


(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; don't show startup messages
(setq inhibit-startup-message t)
(setq inhibit-startup-screen t)
(setq inhibit-splash-screen t)
(setq inhibit-startup-echo-area-message t)
(setq initial-scratch-message nil)

;; load wombat theme
(load-theme 'wombat t)

;; show column numbers
(column-number-mode t)

;; turn off backup files
(setq make-backup-files nil)

;; set up package repos
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")
                         ("melpa" . "http://melpa.milkbox.net/packages/")))

;; initialise packages
(package-initialize)

;; add local dir to path
(add-to-list 'load-path "~/.emacs.d/lisp/")

;; check require packages are installed
(require 'evil)
(require 'magit)
(require 'org)
(require 'paredit)
(require 'undo-tree)
(require 'gambit)

;; enable evil (vi emulation)
(evil-mode 1)

;; add paredit hooks
(autoload 'enable-paredit-mode "paredit" "Turn on pseudo-structural editing of Lisp code." t)
(add-hook 'emacs-lisp-mode-hook       #'enable-paredit-mode)
(add-hook 'eval-expression-minibuffer-setup-hook #'enable-paredit-mode)
(add-hook 'ielm-mode-hook             #'enable-paredit-mode)
(add-hook 'lisp-mode-hook             #'enable-paredit-mode)
(add-hook 'lisp-interaction-mode-hook #'enable-paredit-mode)
(add-hook 'scheme-mode-hook           #'enable-paredit-mode)

;; add gambit hooks
(autoload 'gambit-inferior-mode "gambit" "Hook Gambit mode into cmuscheme.")
(autoload 'gambit-mode "gambit" "Hook Gambit mode into scheme.")
(add-hook 'inferior-scheme-mode-hook (function gambit-inferior-mode))
(add-hook 'scheme-mode-hook (function gambit-mode))
(setq scheme-program-name "gsi -:d-")
