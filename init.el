;; This file is supposed to be copied as default init.el,
;; which would load more static config and hold any local setting.
;; This can also be for local experimental before moving to config.el

;; if requiring proxy setting for initial package install
;; (setq url-proxy-services
;;       '(("http" . "proxy:port")
;;         ("https" . "proxy:port")))

;; Without the `custom-file', Emacs writes directly to the "init.el",
;; which can be confusing.
(setq custom-file (locate-user-emacs-file "custom.el"))
(load custom-file :no-error-if-file-is-missing)

(load-file "~/.emacs.d/sync/config.el")

;; load under testing config?
;; (load-file "~/.emacs.d/sync/testing.el")
