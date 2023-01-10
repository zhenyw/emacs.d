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
;;(use-package doom-modeline
;;  :init (doom-modeline-mode 1))

;;(global-display-line-numbers-mode)

;; vertico: vertical select
;; Note: seems vertico has issue when using finding reference (M-?)
;; in citre/tags, not sure why...so disable first
;;(use-package vertico
;;  :init
;;  (vertico-mode))
