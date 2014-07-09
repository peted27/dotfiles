(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

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

;; add local dir to path
(add-to-list 'load-path "~/.emacs.d/lisp/")

;; set up package repos
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")
                         ("melpa" . "http://melpa.milkbox.net/packages/")))

;; initialise packages
(package-initialize)

;; set scheme to chicken
(setq scheme-program-name "csi -:c")

;; install some low level packages before req-package takes over
(defvar package-list `(req-package))
(dolist (p package-list)
    (when (not (package-installed-p p))
      (print (format "Installing %s" p))
      (package-install p)))

;; using req-package to manage packages and configuration
(require 'req-package)

;; enable evil (vi emulation)
(req-package evil
  :require undo-tree
  :ensure evil
  :init
  (progn 
    (evil-mode 1)))

;; cider
(req-package cider
  :require clojure-mode
  :init
  (progn
    (add-hook 'cider-repl-mode-hook (lambda () (evil-emacs-state)))
    (add-hook 'clojure-mode-hook 'cider-mode)))

;; add paredit hooks
(req-package paredit
  :init
  (progn 
    (autoload 'enable-paredit-mode "paredit" "Turn on pseudo-structural editing of Lisp code." t)
    (add-hook 'emacs-lisp-mode-hook       'enable-paredit-mode)
    (add-hook 'eval-expression-minibuffer-setup-hook 'enable-paredit-mode)
    (add-hook 'ielm-mode-hook             'enable-paredit-mode)
    (add-hook 'lisp-mode-hook             'enable-paredit-mode)
    (add-hook 'lisp-interaction-mode-hook 'enable-paredit-mode)
    (add-hook 'clojure-mode-hook          'enable-paredit-mode)
    (add-hook 'cider-repl-mode-hook       'enable-paredit-mode)
    (add-hook 'scheme-mode-hook           'enable-paredit-mode)))

;; add gambit hooks
;; (req-package gambit
;;   :init
;;   (progn 
;;     (autoload 'gambit-inferior-mode "gambit" "Hook Gambit mode into cmuscheme.")
;;     (autoload 'gambit-mode "gambit" "Hook Gambit mode into scheme.")
;;     (add-hook 'inferior-scheme-mode-hook 'gambit-inferior-mode)
;;     (add-hook 'scheme-mode-hook          'gambit-mode)
;;     (setq scheme-program-name "gsi -:d-")))

;; configure org mode
(req-package org 
  :init
  (progn 
    (setq org-archive-default-command (quote org-archive-to-archive-sibling))
    (setq org-log-done (quote note))
    (setq org-log-reschedule (quote note))
    (setq org-log-redeadline (quote note))
    (setq org-blank-before-new-entry (quote ((heading . t) (plain-list-item . t))))))

;; erlang
(req-package erlang)

;; magit
(req-package magit)

;; configure pretty symbols
(req-package pretty-symbols
  :init
  (progn
    (add-hook 'emacs-lisp-mode-hook 'pretty-symbols-mode)
    (add-hook 'lisp-mode-hook       'pretty-symbols-mode)
    (add-hook 'lisp-interaction-mode-hook 'pretty-symbols-mode)
    (add-hook 'clojure-mode-hook    'pretty-symbols-mode)
    (add-hook 'scheme-mode-hook     'pretty-symbols-mode)))

;; line numbers
(req-package linum
  :config
  (add-hook 'prog-mode-hook
            '(lambda () (linum-mode 1)))) 

;; add #! automatically to .scm files
(req-package  autoinsert
  :init
  (progn
    (add-hook 'find-file-hooks 'auto-insert)
    (setq auto-insert-alist 
	  '(("\\.scm" . 
	     (insert "#!/bin/sh\n#| -*- scheme -*-\nexec csi -s $0 \"$@\"\n|#\n"))))))

;; load packages
(req-package-finish)
