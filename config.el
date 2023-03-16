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

(use-package lsp-mode
  :init
  :bind-keymap ("C-c l" . lsp-command-map)
  :hook (;;lsp-rust: need to install rust-analyzer like
	 ;;    rustup component add rust-src
	 ;;    rustup component add rust-analyzer
	 ;;Need to add 'rust-analyzer' into PATH e.g
	 ;;    ln -sf `rustup which rust-analyzer` ~/bin/.
	 ;;lsp-rust would by default search 'rust-analyzer' binary
	 ;;Note: maybe there's some cargo metadata error, looks if
	 ;;tried to build project one, it might better to go...
	 (rust-mode
	  ;;enable for all c/c++ mode (not sure why cc-mode not work...)
	  ;;for linux kernel, just use 'clangd' lsp server
	  ;;   make CC=clang defconfig (for e.g)
	  ;;   make CC=clang
	  ;;   ./scripts/clang-tools/gen_compile_commands.py
	  ;;then just import project from top of linux kernel source
	  ;;default xref key seems still works:
	  ;;   alt+.: find definition
	  ;;   S-alt-?: find reference
	  c-mode
	  c++-mode
	  c-or-c++-mode
	  ) . lsp-deferred)
  :commands lsp)

(use-package lsp-ui
  :hook (lsp-mode . lsp-ui-mode)
  :bind
  (("M-]" . lsp-ui-peek-find-definitions)
   )
  :custom
  ((lsp-ui-peek-always-show t)
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
