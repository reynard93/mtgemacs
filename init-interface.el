;; Element of Emacs UI
(setq inhibit-startup-screen 1)            ; Remove start-up screen
(scroll-bar-mode -1)                       ; Remove scroll bar
(menu-bar-mode -1)                         ; Remove menu bar
(tool-bar-mode -1)                         ; Remove the toolbar
(line-number-mode )                        ; Display line number of the cursor current position
(column-number-mode 1)                     ; Display column number of the cursor current position
(fringe-mode '(6 . 0))                     ; Display left fringe
(setq scroll-step 1)                       ; Line by line scrolling
(setq default-tab-width 4)                 ; Set width for tabs
(global-hl-line-mode 1)                    ; Hightlight current line
(setq x-select-enable-clipboard 1)         ; Merge both system's and Emacs'clipboard
(setq-default show-trailing-whitespace 1)  ; Display trailing whitespaces
(setq-default indent-tabs-mode nil)        ; No tabs
(setq sgml-basic-offset 4)                 ; Set indent to 4 spaces
(global-subword-mode 1)                    ; Iterate through CamelCase words
(setq mouse-yank-at-point 1)               ; Yank at mouse cursor rather than click location
(mouse-avoidance-mode 'animate)            ; Move the cursor to the corner when typing
(toggle-frame-fullscreen)                  ; Start Emacs in full-screen
(setq-default indicate-empty-lines t)      ; Indicate empty line (require left fringe)


;; Add prefixes to buffer titles (in case of duplicates)
;; (require 'uniquify)
;; (setq uniquify-buffer-name-style 'forward)


;; Sort directories first while in dired mode
(defun list-directories-first ()
  (save-excursion
    (let (buffer-read-only)
      (forward-line 2)
      (sort-regexp-fields t "^.*$" "[ ]*." (point) (point-max)))
    (set-buffer-modified-p nil)))
(defadvice dired-readin
  (after dired-after-updating-hook first () activate)
  (list-directories-first))


;; Highlight parent parenthesis
(show-paren-mode t)             ; Turn paren-mode on
(setq show-paren-delay 0)       ; How long to wait ?
(setq show-paren-style 'mixed)  ; Alternatives are 'parenthesis' and 'mixed'