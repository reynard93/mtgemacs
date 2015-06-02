;;─────────────────────────────────────────────────────────────────────────────
;; Configure Emacs for Docker buffers
;;─────────────────────────────────────────────────────────────────────────────


;; https://github.com/spotify/dockerfile-mode
(use-package dockerfile-mode
  :ensure t
  :delight dockerfile-mode "dockerfile"
  :init
  (add-to-list 'auto-mode-alist '("Dockerfile\\'" . dockerfile-mode)))


;;─────────────────────────────────────────────────────────────────────────────
;; End init-docker.el
;;─────────────────────────────────────────────────────────────────────────────


(provide 'init-docker)