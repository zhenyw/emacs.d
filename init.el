
(add-to-list 'load-path "~/.emacs.d/lisp")

(autoload 'markdown-mode "markdown-mode.el"
  "Major mode for editing markdown files" t)
(setq auto-mode-alist
      (cons '("\\.md" . markdown-mode) auto-mode-alist))

;; be quiet, bady
(blink-cursor-mode 0)
(scroll-bar-mode 0)
(menu-bar-mode 0)
(tool-bar-mode 0)
(setq inhibit-splash-screen t)
(setq initial-scratch-message "")
;;(setq visible-bell t)

(set-fill-column 70)

;; package (ELPA/MELPA)
(require 'package)
(add-to-list 'package-archives
	     '("marmalade" . "http://marmalade-repo.org/packages"))
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/"))

(package-initialize)

	    
;; gtags
(autoload 'gtags-mode "gtags" "" t)
(setq gtags-suggested-key-mapping t)

(add-hook 'c-mode-hook
    '(lambda ()
       (gtags-mode 1)
))

;; title
(setq frame-title-format
  '((:eval (if (buffer-file-name)
                (abbreviate-file-name (buffer-file-name))
                  "%b"))))
;; theme
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
(load-theme 'zenburn t)

;;  SMTP
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(send-mail-function (quote smtpmail-send-it))
 '(smtpmail-smtp-server "mail.intel.com")
 '(smtpmail-smtp-service 25))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;;LLVM
(require 'llvm-mode)
(require 'tablegen-mode)

;; paredit (from emacswiki)
(autoload 'enable-paredit-mode "paredit" "Turn on pseudo-structural editing of Lisp code." t)
(add-hook 'emacs-lisp-mode-hook       #'enable-paredit-mode)
(add-hook 'eval-expression-minibuffer-setup-hook #'enable-paredit-mode)
(add-hook 'ielm-mode-hook             #'enable-paredit-mode)
(add-hook 'lisp-mode-hook             #'enable-paredit-mode)
(add-hook 'lisp-interaction-mode-hook #'enable-paredit-mode)
(add-hook 'scheme-mode-hook           #'enable-paredit-mode)
