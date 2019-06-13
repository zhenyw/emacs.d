
(add-to-list 'load-path "~/.emacs.d/lisp")

;; be quiet, bady
(blink-cursor-mode 0)
(menu-bar-mode 0)
(setq inhibit-splash-screen t)
(setq initial-scratch-message "")
;;(setq visible-bell t)
(setq default-fill-column 80)

;; package (ELPA/MELPA)
(require 'package)
(setq package-enable-at-startup nil)
(setq package-archives
      '(("gnu" . "http://elpa.gnu.org/packages")
	("marmalade" . "http://marmalade-repo.org/packages")
	("melpa" . "http://melpa.org/packages/")))
(package-initialize)

;; 'use-package'
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package)


;; cc-mode & gtags
(autoload 'gtags-mode "gtags" "" t)
(setq gtags-suggested-key-mapping t)

(add-hook 'c-mode-common-hook
    '(lambda ()
       (gtags-mode 1)
))

;; default to 'linux'
(setq c-default-style '((java-mode . "java")
			(awk-mode . "awk")
			(other . "linux")))

;; customize c++
(c-add-style "my-c++-style"
	     '("stroupstrup"
	       (indent-tabs-mode . nil)
	       ))
(defun my-c++-mode-hook ()
  (c-set-style "my-c++-style"))
(add-hook 'c++-mode-hook 'my-c++-mode-hook)

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
(require 'paredit)
(autoload 'enable-paredit-mode "paredit" "Turn on pseudo-structural editing of Lisp code." t)
(add-hook 'emacs-lisp-mode-hook       #'enable-paredit-mode)
(add-hook 'eval-expression-minibuffer-setup-hook #'enable-paredit-mode)
(add-hook 'ielm-mode-hook             #'enable-paredit-mode)
(add-hook 'lisp-mode-hook             #'enable-paredit-mode)
(add-hook 'lisp-interaction-mode-hook #'enable-paredit-mode)
(add-hook 'scheme-mode-hook           #'enable-paredit-mode)

;; markdown
(autoload 'markdown-mode "markdown-mode.el"
  "Major mode for editing markdown files" t)
(setq auto-mode-alist
      (cons '("\\.md" . markdown-mode) auto-mode-alist))

;; helper function
(defun show-file-absolute-name ()
  "Show the full path file name in the minibuffer."
  (interactive)
  (message (buffer-file-name)))
