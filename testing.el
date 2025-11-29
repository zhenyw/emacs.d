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

;; company
(use-package company)

;; eglot
(use-package eglot
  :config
  (setq eglot-report-progress t)
  (add-hook 'rust-mode-hook 'eglot-ensure)
  (add-hook 'c-mode-hook 'eglot-ensure)
  (add-to-list 'eglot-stay-out-of 'eldoc)
  )

;;dirvish
(use-package dirvish
  :config
  (dirvish-override-dired-mode 1)
  )

;;tree-sitter
(use-package treesit-auto
  :config
  (global-treesit-auto-mode))

;;symbols-outline
(use-package symbols-outline
  :bind
  (("C-c i" . symbols-outline-show))
  :config
  (setq symbols-outline-fetch-fn #'symbols-outline-lsp-fetch)
  (setq symbols-outline-window-position 'left)
  (setq symbols-outline-window-width 40)
  (setq symbols-outline-use-nerd-icon-in-gui nil)
  (setq symbols-outline-use-nerd-icon-in-tui nil)
  (symbols-outline-follow-mode)
  )

;;notmuch
(use-package notmuch
  :ensure t
  :defer t
  ;;:commands notmuch-hello
  :bind (("C-c m" . notmuch))
  :config
  (setq-default notmuch-search-oldest-first nil) ;; show newest

  ;; Tell Emacs to use msmtp for sending mail
  (setq message-send-mail-function 'message-send-mail-with-sendmail)
  (setq sendmail-program "msmtp")
  ;; Specify the account to use for replies/new mail
  (setq user-mail-address "zhenyuw.linux@gmail.com")
  (setq user-full-name "Zhenyu Wang")

  ;; Recommended for better compliance with notmuch/msmtp
  (setq mail-specify-envelope-from t)
  (setq message-sendmail-envelope-from 'header)
  (setq mail-envelope-from 'header)

  (setq notmuch-saved-searches
   '((:name "inbox" :query "tag:inbox" :key "i" :search-type tree)
     (:name "unread" :query "tag:unread" :key "u")
     (:name "flagged" :query "tag:flagged" :key "f")
     (:name "sent" :query "tag:sent" :key "t")
     (:name "drafts" :query "tag:draft" :key "d")
     (:name "all mail" :query "*" :key "a")
     (:name "intel-gfx" :query "tag:intel-gfx" :key "g" :search-type tree)
     (:name "kvm" :query "tag:kvm" :key "k" :search-type tree)
     (:name "lkml" :query "tag:lkml" :key "l" :search-type tree)
     ))
  (setq notmuch-fcc-dirs "Sent +sent -unread")
  )

;;windmove (easier multiple windows point switch & swap)
(use-package windmove
  :init
  (windmove-mode 1)
  :config
  (windmove-default-keybindings)
  ;;(windmove-swap-states-default-keybindings)
  :bind
  (("C-S-<left>" . windmove-swap-states-left)
   ("C-S-<right>" . windmove-swap-states-right)
   ("C-S-<up>" . windmove-swap-states-up)
   ("C-S-<down>" . windmove-swap-states-down)
   )
  )

;;window operation history track enable
(winner-mode 1)

;;session saving
(desktop-save-mode 1)

;;store backup file in single place
(setq backup-directory-alist '(("." . "~/.emacs.d/saves")))

;;org journal (testing)
(setq org-capture-templates
 '(("j" "Journal entry" plain
    (file+olp+datetree "~/devel/journal.org")
    "**** %i%?\n"
    :time-prompt t
    :unnarrowed t)))

;; nim-mode
(use-package nim-mode)

;; zig-mode
(use-package zig-mode)

;; slime
(use-package slime
  :config
  (setq inferior-lisp-program "/usr/bin/sbcl")
  ;;(setq slime-contribs '(slime-scratch slime-editing-commands))
  )

;; cscope
(use-package xcscope
  :config
  (cscope-setup)
  )

;;inhibit-mouse
(use-package inhibit-mouse
  :ensure t
  :custom
  ;; Disable highlighting of clickable text such as URLs and hyperlinks when
  ;; hovered by the mouse pointer.
  (inhibit-mouse-adjust-mouse-highlight t)

  ;; Disables the use of tooltips (show-help-function) during mouse events.
  (inhibit-mouse-adjust-show-help-function t)

  :config
  (if (daemonp)
      (add-hook 'server-after-make-frame-hook #'inhibit-mouse-mode)
    (inhibit-mouse-mode 1)
    )
  )
