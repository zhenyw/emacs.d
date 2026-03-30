;; Just put everything under testing here. After some experiments,
;; if something feels good to use, can move into default config.el

(add-to-list 'load-path "~/.emacs.d/sync/lisp/")

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
  :ensure t
  :config
  (setq eglot-report-progress t)
  (add-hook 'rust-mode-hook 'eglot-ensure)
  ;; not by default open for all C, can fallback to cscope, dump-jump...
  ;;  (add-hook 'c-mode-hook 'eglot-ensure)
  (add-to-list 'eglot-stay-out-of 'eldoc)
  )

;; Try dump jump which only depends on grep to find symbols

;; (use-package dumb-jump
;;  :ensure t
;;  :config
;;  (add-hook 'xref-backend-functions #'dumb-jump-xref-activate)
;;  (setq dumb-jump-force-searcher 'rg)
;;  ;; use completion-read instead of a separate buffer with candidates
;;  ;;(setq xref-show-definitions-function #'xref-show-definitions-completing-read)
;;  (with-eval-after-load 'project
;;    (add-to-list 'project-vc-extra-root-markers ".dumbjump"))
;;  ;; Remove "Makefile" from the list of things that define a project root
;;  (setq dumb-jump-project-root-denoters 
;;        '(".dumbjump" ".git" ".projectile" ".project"))
;;  )

;; use hacked version for emacs project support
;;(require dumb-jump) ;; why this doesn't work with load-path?

;; Below is previous config.
;; Currently still use cscope for old kernel source, dumb-jump doesn't
;; work fast with large code base even with rg like linux kernel...
;;(load-file "~/.emacs.d/sync/lisp/dumb-jump.el")
;;(add-hook 'xref-backend-functions #'dumb-jump-xref-activate)
;;(setq dumb-jump-force-searcher 'rg)

;;dirvish
(use-package dirvish
  :config
  (dirvish-override-dired-mode 1)
  )

;;tree-sitter
(use-package treesit-auto
  :config
  (global-treesit-auto-mode))

;;symbols-outline (only with lsp now)
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

(with-eval-after-load 'notmuch
  ;; below from gemini
  ;; Change the background of the message headers to stand out
  (set-face-attribute 'notmuch-message-summary-face nil 
                      :background "#333333" :foreground "orange")

  ;; Change the color of quoted/cited text (the > lines)
  (set-face-attribute 'notmuch-wash-cited-text nil 
                      :foreground "gray60")

  ;; Highlight the matching search terms in the message
  ;;(set-face-attribute 'notmuch-search-matching-face nil 
  ;;                    :foreground "orange")
  
  ;; Make tags look like small buttons or distinctive labels
  (set-face-attribute 'notmuch-tag-face nil 
                      :foreground "cyan" :weight 'bold)
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
  :ensure t
  :config
  (cscope-setup)
  :bind
;; * Default Keybindings:
;;
;; All keybindings use the "C-c s" prefix, but are usable only while
;; editing a source file, or in the cscope results buffer:
;;
;;      C-c s s         Find symbol.
;;      C-c s =         Find assignments to this symbol
;;      C-c s d         Find global definition.
;;      C-c s g         Find global definition (alternate binding).
;;      C-c s G         Find global definition without prompting.
;;      C-c s c         Find functions calling a function.
;;      C-c s C         Find called functions (list functions called
;;                      from a function).
;;      C-c s t         Find text string.
;;      C-c s e         Find egrep pattern.
;;      C-c s f         Find a file.
;;      C-c s i         Find files #including a file.
;;
;; These pertain to navigation through the search results:
;;
;;      C-c s b         Display *cscope* buffer.
;;      C-c s B         Auto display *cscope* buffer toggle.
;;      C-c s n         Next symbol.
;;      C-c s N         Next file.
;;      C-c s p         Previous symbol.
;;      C-c s P         Previous file.
;;      C-c s u         Pop mark.
;;
;; These pertain to setting and unsetting the variable,
;; `cscope-initial-directory', (location searched for the cscope database
;;  directory):
;;
;;      C-c s a         Set initial directory.
;;      C-c s A         Unset initial directory.
;;
;; These pertain to cscope database maintenance:
;;
;;      C-c s L         Create list of files to index.
;;      C-c s I         Create list and index.
;;      C-c s E         Edit list of files to index.
;;      C-c s W         Locate this buffer's cscope directory
;;                      ("W" --> "where").
;;      C-c s S         Locate this buffer's cscope directory.
;;                      (alternate binding: "S" --> "show").
;;      C-c s T         Locate this buffer's cscope directory.
;;                      (alternate binding: "T" --> "tell").
;;      C-c s D         Dired this buffer's directory.

  (("C-c d" . cscope-find-global-definition-no-prompting)
   ("C-c c" . cscope-find-functions-calling-this-function)
   ("C-c u" . cscope-pop-mark)
   )
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

;; eww web browser
(use-package eww
  :config
  (setq shr-use-colors nil)
  (setq shr-bullet "• ")
  (setq shr-folding-mode t)
  (setq eww-search-prefix "https://duckduckgo.com/html?q=")
  )


;; elfeed rss reader
;; Currently use elfeed/eww to read and use bookmark to save entry.
;; C-x r l - list bookmarks
;; C-x r m - mark entry
(use-package elfeed
  :ensure t
  :custom
  (elfeed-search-remain-on-entry t)
  (elfeed-search-title-max-width 80)
  (elfeed-search-title-min-width 30)
  (elfeed-search-trailing-width 25)
  (elfeed-show-truncate-long-urls t)
  :bind
  (:map elfeed-search-mode-map
	("Q" . elfeed-kill-buffer)
	;; 't' for top which exclude all hacking posts
	("t" . (lambda () (interactive)
		 (elfeed-search-set-filter "@6-months-ago +unread -hacking")))
	("N" . (lambda () (interactive)
		 ;;(elfeed-search-set-filter "@6-months-ago +unread +news")))
		 (elfeed-search-set-filter "@6-months-ago +news")))
	("E" . (lambda () (interactive)
		 (elfeed-search-set-filter "@6-months-ago +emacs")))
	("L" . (lambda () (interactive)
		 (elfeed-search-set-filter "@6-months-ago +linux")))
	("A" . (lambda () (interactive)
		 (elfeed-search-set-filter "@6-months-ago +arts")))
	("C" . (lambda () (interactive)
		 (elfeed-search-set-filter "@6-months-ago +cycling")))
	("B" . (lambda () (interactive)
		 (elfeed-search-set-filter "@6-months-ago +books")))
	("H" . (lambda () (interactive)
		 (elfeed-search-set-filter "@6-months-ago +hacking")))
	)
  (:map elfeed-show-mode-map
	("f" . elfeed-show-fetch-full-text)
	)
  )

(use-package elfeed-org
  :after elfeed
  :ensure t
  :config
  (elfeed-org)
  (setq rmh-elfeed-org-files (list "~/.emacs.d/sync/elfeed.org")))

(with-eval-after-load 'elfeed
  (elfeed-org))

;;from https://plrj.org/2025/06/14/my-emacs-elfeed-configuration/
(defun elfeed-show-fetch-full-text ()
  "Fetch the full text of the current Elfeed entry using eww-readable."
  (interactive)
  (let* ((entry elfeed-show-entry)
         (url (elfeed-entry-link entry)))
    (eww url)  ;; Open the URL in eww
    ;;    (run-at-time "0.5" nil
    ;;               (lambda ()
    ;;                 (with-current-buffer "*eww*"
    ;;                   (eww-readable))))) ;; Call eww-readable after a short delay
    ;;    It might not be good to use eww-readable for some pages, or just try 'R'
    )
  ) 


;; AI, AI...more to be debugged...
(use-package eca)

;;emacs-reader
;; (use-package reader
;;   :vc t
;;   :load-path "/home/zhen/devel/emacs/emacs-reader")

;; more themes
;; (use-package nordic-night-theme
;;   :ensure t
;;   )

(use-package doom-themes
  :ensure t
  :custom
  ;; Global settings (defaults)
  (doom-themes-enable-bold t)   ; if nil, bold is universally disabled
  (doom-themes-enable-italic t) ; if nil, italics is universally disabled
  ;; for treemacs users
  (doom-themes-treemacs-theme "doom-atom") ; use "doom-colors" for less minimal icon theme
  :config
  ;; (load-theme 'doom-one t)
  ;; doom-gruvbox
  (load-theme 'doom-zenburn t)

  ;; ;; Enable flashing mode-line on errors
  ;; (doom-themes-visual-bell-config)
  ;; ;; Enable custom neotree theme (nerd-icons must be installed!)
  ;; (doom-themes-neotree-config)
  ;; ;; or for treemacs users
  ;; (doom-themes-treemacs-config)
  ;; ;; Corrects (and improves) org-mode's native fontification.
  ;; (doom-themes-org-config)
  )

;; (use-package ef-themes
;;   :ensure t
;;   )

;; not bad in dark
(use-package cyberpunk-theme
  :ensure t
  )

(use-package kanagawa-themes
  :ensure t
  )

(use-package leuven-theme
  :ensure t
  )

(use-package atom-one-dark-theme
  :ensure t
;;:config
;; (load-theme 'atom-one-dark t)
  )

;;
;;magit
(use-package magit
  :ensure t
  :bind (("C-c g" . magit-status))
  )
