;; This file is supposed to be copied as default init.el,
;; which would load more static config and hold any local setting.
;; This can also be for local experimental before moving to config.el

;; if requiring proxy setting for initial package install
;; (setq url-proxy-services
;;       '(("http" . "proxy:port")
;;         ("https" . "proxy:port")))

(load-file "~/.emacs.d/sync/config.el")

;; load under testing config?
;; (load-file "~/.emacs.d/sync/testing.el")
