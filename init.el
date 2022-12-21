;; global setting
(blink-cursor-mode 0)
(menu-bar-mode 0)
(when (display-graphic-p nil)
  (tool-bar-mode 0)
  (scroll-bar-mode 0))
(setq inhibit-splash-screen t)
(setq initial-scratch-message "")
(setq default-fill-column 80)
(set-frame-font "Hack-14" nil t)

;; package (ELPA/MELPA)
(require 'package)
(setq package-archives
      '(("melpa" . "https://melpa.org/packages/")
	("melpa-stable" . "https://stable.melpa.org/packages/")
	("gnu" . "https://elpa.gnu.org/packages/")))
(package-initialize)

;; use-package
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package)
(setq use-package-always-ensure t)

(use-package zenburn-theme
  :config
  (load-theme 'zenburn t))

(use-package citre
  :init
  ;; below load citre default config
  (require 'citre-config)
  ;; 'citre-jump & 'citre-jump-back has default M-. & M-, key binding
  ;; (M-? for reverse reference lookup), the only missed one should be peek.
  ;; Peek window key bindings is:
  ;;     M-n, M-p: next/prev line
  ;;     M-N, M-P: next/prev definition
  ;;     M-l j: jump to definition
  ;;     C-g: close peek window
  :bind (:map citre-mode-map ("M-]" . citre-peek)))

(use-package cc-mode
  :config
  (setq c-default-style '((java-mode . "java")
                          (awk-mode . "awk")
                          (other . "linux"))))

(use-package vterm)

(use-package multi-vterm
  :bind (:map vterm-mode-map
	      ;; How to specify vterm's default mode special key
	      ;; instead of directly specify C-c?
	      ("C-c n" . multi-vterm-next)
	      ("C-c p" . multi-vterm-prev)))

(use-package rust-mode)

(use-package lsp-mode
  :init
  :hook (;;lsp-rust: need to install rust-analyzer like
	 ;;    rustup component add rust-src
	 ;;    rustup component add rust-analyzer
	 ;;Need to add 'rust-analyzer' into PATH e.g
	 ;;    ln -sf `rustup which rust-analyzer` ~/bin/.
	 ;;lsp-rust would by default search 'rust-analyzer' binary
	 ;;Note: maybe there's some cargo metadata error, looks if
	 ;;tried to build project one, it might better to go...
	 (rust-mode . lsp))
  :commands lsp)

;; custom...(just ignore for now...)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(use-package tabbar session pod-mode notmuch muttrc-mode mutt-alias markdown-mode initsplit htmlize graphviz-dot-mode folding eproject diminish csv-mode company color-theme-modern browse-kill-ring boxquote bm bar-cursor apache-mode)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

  
