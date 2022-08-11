;;; barrinalo.el --- Collection of text-changing functions -*- lexical-binding: t; -*-

;; Copyright (C) 2022 Mathieu Marques

;; Author: Mathieu Marques <mathieumarques78@gmail.com>
;; Created: November 29, 2021
;; Homepage: https://github.com/angrybacon/dotemacs/tree/master/lisp/barrinalo

;; This program is free software. You can redistribute it and/or modify it under
;; the terms of the Do What The Fuck You Want To Public License, version 2 as
;; published by Sam Hocevar.
;;
;; This program is distributed in the hope that it will be useful, but WITHOUT
;; ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
;; FOR A PARTICULAR PURPOSE.
;;
;; You should have received a copy of the Do What The Fuck You Want To Public
;; License along with this program. If not, see http://www.wtfpl.net/.

;;; Commentary:

;; Barrinalo was a powerful blue mage from Dominaria and scribe at the Tolarian
;; Academy. Comparably, barrinalo.el is a collection of small interactive
;; functions that help you change text at point or in region.

;;; Code:

(require 'replace)
(require 'simple)

;;;; Case functions

;;;###autoload
(defun barrinalo-kebab (begin end)
  "Convert region to kebab-case.
that is all lowercase, coma-separated words. if region is not active and BEGIN
and END are not defined, apply to the whole line instead."
  (interactive "*r")
  (let ((begin (if (use-region-p) begin (line-beginning-position)))
        (end (if (use-region-p) end (line-end-position))))
    (downcase-region begin end)
    (save-excursion
      (perform-replace " +" "-" nil t nil nil nil begin end))))

;;;; Date commands

;;;###autoload
(defun barrinalo-date-iso ()
  "Insert the current date, ISO format eg. 2016-12-09."
  (interactive "*")
  (insert (format-time-string "%F")))

;;;###autoload
(defun barrinalo-date-iso-with-time ()
  "Insert the current date, ISO format with time eg. 2016-12-09T14:34:54+0100."
  (interactive "*")
  (insert (format-time-string "%FT%T%z")))

;;;###autoload
(defun barrinalo-date-long ()
  "Insert the current date, long format eg. December 09, 2016."
  (interactive "*")
  (insert (format-time-string "%B %d, %Y")))

;;;###autoload
(defun barrinalo-date-long-with-time ()
  "Insert the current date, long format eg. December 09, 2016 - 14:34."
  (interactive "*")
  (insert (capitalize (format-time-string "%B %d, %Y - %H:%M"))))

;;;###autoload
(defun barrinalo-date-short ()
  "Insert the current date, short format eg. 2016.12.09."
  (interactive "*")
  (insert (format-time-string "%Y.%m.%d")))

;;;###autoload
(defun barrinalo-date-short-with-time ()
  "Insert the current date, short format with time eg. 2016.12.09 14:34"
  (interactive "*")
  (insert (format-time-string "%Y.%m.%d %H:%M")))

;;;; Duplicate functions

(defun barrinalo--duplicate-line (&optional stay)
  "Duplicate current line.
With optional argument STAY true, leave point where it was."
  (save-excursion
    (move-end-of-line nil)
    (save-excursion
      (insert (buffer-substring (point-at-bol) (point-at-eol))))
    (newline))
  (unless stay
    (let ((column (current-column)))
      (forward-line)
      (forward-char column))))

;;;###autoload
(defun barrinalo-duplicate-backward ()
  "Duplicate current line upward or region backward.
If region was active, keep it so that the command can be repeated."
  (interactive "*")
  (if (region-active-p)
      (let (deactivate-mark)
        (save-excursion
          (insert (buffer-substring (region-beginning) (region-end)))))
    (barrinalo--duplicate-line t)))

;;;###autoload
(defun barrinalo-duplicate-forward ()
  "Duplicate current line downward or region forward.
If region was active, keep it so that the command can be repeated."
  (interactive "*")
  (if (region-active-p)
      (let (deactivate-mark (point (point)))
        (insert (buffer-substring (region-beginning) (region-end)))
        (push-mark point))
    (barrinalo--duplicate-line)))

;;;; Indent functions

;;;###autoload
(defun barrinalo-indent-leftward (begin end)
  "Indent lines between BEGIN and END leftward by one space and keep mark."
  (interactive "*r")
  (indent-rigidly-left begin end)
  (setq deactivate-mark nil))

;;;###autoload
(defun barrinalo-indent-leftward-tab (begin end)
  "Indent lines between BEGIN and END leftward to a tab stop and keep mark."
  (interactive "*r")
  (indent-rigidly-left-to-tab-stop begin end)
  (setq deactivate-mark nil))

;;;###autoload
(defun barrinalo-indent-rightward (begin end)
  "Indent lines between BEGIN and END rightward by one space and keep mark."
  (interactive "*r")
  (indent-rigidly-right begin end)
  (setq deactivate-mark nil))

;;;###autoload
(defun barrinalo-indent-rightward-tab (begin end)
  "Indent lines between BEGIN and END rightward to a tab stop and keep mark."
  (interactive "*r")
  (indent-rigidly-right-to-tab-stop begin end)
  (setq deactivate-mark nil))

;;;; Transpose functions

;;;###autoload
(defun barrinalo-reverse (begin end)
  "Reverse region.
Reverse lines between BEGIN and END. If region only has one line, reverse
characters in region instead."
  (interactive "*r")
  (if (= (count-lines begin end) 1)
      (insert (nreverse (delete-and-extract-region begin end)))
    (reverse-region begin end)))

;;;###autoload
(defun barrinalo-sort-words (reverse begin end)
  "Sort words in region alphabetically.
Sort words between BEGIN and END. When prefixed with \\[universal-argument],
sort in REVERSE instead.

The variable `sort-fold-case' determines whether the case affects the sort. See
`sort-regexp-fields'."
  (interactive "*P\nr")
  (sort-regexp-fields reverse "\\w+" "\\&" begin end))

;;;###autoload
(defun barrinalo-swap-down ()
  "Move down the line under point."
  (interactive "*")
  (forward-line 1)
  (transpose-lines 1)
  (forward-line -1)
  (indent-according-to-mode))

;;;###autoload
(defun barrinalo-swap-up ()
  "Move up the line under point."
  (interactive "*")
  (transpose-lines 1)
  (forward-line -2)
  (indent-according-to-mode))

(provide 'barrinalo)

;;; barrinalo.el ends here
