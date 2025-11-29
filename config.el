;; This is main personal config settings, supposed to be loaded from init.el
;; as init.el might be added some custom setting, which I don't want to pollute
;; other default config.

;; global setting
(blink-cursor-mode 0)
(setq visible-cursor nil)
(menu-bar-mode 0)
(when (display-graphic-p nil)
  (tool-bar-mode 0)
  (scroll-bar-mode 0))
(setq inhibit-splash-screen t)
(setq initial-scratch-message "")
(setq default-fill-column 80)
(setq column-number-mode t)
(set-frame-font "Hack-14" nil t)

;; define function to shutdown emacs server instance
(defun server-shutdown ()
  "Save buffers, Quit, and Shutdown (kill) server"
  (interactive)
  (save-some-buffers)
  (kill-emacs)
  )

;; package (ELPA/MELPA)
;; so MELPA is for git master tip; MELPA-stable is for tagged release
;; which might not be needed as it looks package maintainer doesn't necessarily
;; keep tagged version compatible...
;;
;;	("melpa-stable" . "https://stable.melpa.org/packages/")
;; note:
;; * 'vertico' requires gnu elpa
(require 'package)
(setq package-archives
      '(
	("gnu" . "https://elpa.gnu.org/packages/")
	("melpa" . "https://melpa.org/packages/")
	))
(package-initialize)

;; use-package
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package)
;; always enable by default
(setq use-package-always-ensure t)

(use-package zenburn-theme
  :config
  (load-theme 'zenburn t))

(use-package cc-mode
  :config
  (setq c-default-style '((java-mode . "java")
                          (awk-mode . "awk")
                          (other . "linux"))))

(use-package rust-mode)

(use-package which-key
  :config
  (progn
    (which-key-mode)
    )
  )

;; open url in firefox
;; =>
(setq browse-url-browser-function 'browse-url-firefox
      browse-url-new-window-flag t
      browse-url-firefox-new-window-is-tab t)
(when (eq system-type 'windows-nt)
  (setq browse-url-firefox-program "C:/Program Files/Mozilla Firefox/firefox.exe"))

;; org-mode
(setq org-log-done 'time)

;; recentf
(use-package recentf
  :bind
  (("C-x C-r" . recentf-open-files)
   )
  :config
  (progn
    (setq recentf-max-saved-items 200
          recentf-max-menu-items 15)
    (recentf-mode)
    ))
