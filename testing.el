;; Just put everything under testing here. After some experiments,
;; if something feels good to use, can move into default config.el

;; Note: looks this slows down some file open contained in git?
;; not sure why yet...
;;(use-package magit)

;;(use-package helm
;;  :bind (("M-x" . helm-M-x)
;;	 ("C-x r b" . helm-filtered-bookmarks)
;;	 ("C-x C-f" . helm-find-files)
;;	 ("M-y" . helm-show-kill-ring)
;;	 ("C-x b" . helm-mini)
;;	 ("C-x r e" . helm-register))
;;  :config
;;  (helm-mode 1))

;; Note: looks only short version of absolute name might be useful,
;; but still not that much...
(use-package doom-modeline
  :init (doom-modeline-mode 1)
  :config
  (setq doom-modeline-icon nil))

;;(global-display-line-numbers-mode)

;; vertico: vertical select
;; Note: seems vertico has issue when using finding reference (M-?)
;; in citre/tags, not sure why...so disable first
;;(use-package vertico
;;  :init
;;  (vertico-mode))

;; only enable vterm on linux
;;(when (eq system-type 'gnu/linux)
;;  (use-package vterm)

;;  (use-package multi-vterm
;;    :bind (:map vterm-mode-map
		;; How to specify vterm's default mode special key
		;; instead of directly specify C-c?
;;		("C-c n" . multi-vterm-next)
;;		("C-c p" . multi-vterm-prev))))

;; citre is good, mostly for the peek window, but limited by ctags or global,
;; sometimes it just can't get full tracks, so switch to lsp
;;(use-package citre
;;  :init
  ;;;; below load citre default config
;;  (require 'citre-config)
  ;; 'citre-jump & 'citre-jump-back has default M-. & M-, key binding
  ;; (M-? for reverse reference lookup), the only missed one should be peek.
  ;; Peek window key bindings is:
  ;;     M-n, M-p: next/prev line
  ;;     M-N, M-P: next/prev definition
  ;;     M-l j: jump to definition
  ;;     C-g: close peek window
;;  :bind (:map citre-mode-map ("M-]" . citre-peek)))

(use-package deadgrep
  :bind ("C-x g" . deadgrep)
  )

;;(use-package lsp-mode
;;  :init
;;  :bind-keymap ("C-c l" . lsp-command-map)
;;  :hook (;;lsp-rust: need to install rust-analyzer like
;;	 ;;    rustup component add rust-src
;;	 ;;    rustup component add rust-analyzer
;;	 ;;Need to add 'rust-analyzer' into PATH e.g
;;	 ;;    ln -sf `rustup which rust-analyzer` ~/bin/.
;;	 ;;lsp-rust would by default search 'rust-analyzer' binary
;;	 ;;Note: maybe there's some cargo metadata error, looks if
;;	 ;;tried to build project one, it might better to go...
;;	 (rust-mode
;;	  ;;enable for all c/c++ mode (not sure why cc-mode not work...)
;;	  ;;for linux kernel, just use 'clangd' lsp server
;;	  ;;   make CC=clang defconfig (for e.g)
;;	  ;;   make CC=clang
;;	  ;;   ./scripts/clang-tools/gen_compile_commands.py
;;	  ;;then just import project from top of linux kernel source
;;	  ;;default xref key seems still works:
;;	  ;;   alt+.: find definition
;;	  ;;   S-alt-?: find reference
;;	  c-mode
;;	  c++-mode
;;	  c-or-c++-mode
;;	  ) . lsp-deferred)
;;  :commands lsp
;;  :config
;;  (lsp-enable-which-key-integration t))

;;(use-package lsp-ui
;;  :custom-face
;;  ;; make peek window same color as default peek list window
;;  ;; make color similar to zenburn theme default background
;;  (lsp-ui-peek-peek ((t (:background "#383838"))))
;;  (lsp-ui-peek-list ((t (:background "#383838"))))
;;  :hook (lsp-mode . lsp-ui-mode)
;;  :bind
;;  (("M-]" . lsp-ui-peek-find-definitions)
;;   )
;;  :custom
;;  ;; peek keybind
;;  ;; n/p: next/prev
;;  ;; M-n/p: 
;;  ;; enter: open file
;;  ;; M-enter: open file in new window
;;  ;; q: quit
;;  ((lsp-ui-peek-enable t)
;;   (lsp-ui-peek-always-show t)
;;   )
;;  )


;; eglot
(use-package eglot
  :config
  (setq eglot-report-progress t)
  (add-hook 'rust-mode-hook 'eglot-ensure)
  (add-hook 'c-mode-hook 'eglot-ensure)
  (add-to-list 'eglot-stay-out-of 'eldoc)
  )
