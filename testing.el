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
  :init (doom-modeline-mode 1))

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

(use-package deadgrep)
