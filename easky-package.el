;;; easky-package.el --- Control Eask's package module  -*- lexical-binding: t; -*-

;; Copyright (C) 2022  Shen, Jen-Chieh

;; This file is not part of GNU Emacs.

;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program. If not, see <https://www.gnu.org/licenses/>.

;;; Commentary:
;;
;;
;;

;;; Code:

(require 'easky)

(defmacro easky-package--setup (body &rest unwind)
  "Execute BODY without touching the Eask-file global variables."
  (declare (indent 1) (debug t))
  `(unwind-protect (easky--setup ,body) ,@unwind))

(defun easky--revert-package-info (&rest _)
  "Revert package inforamtion after we have displayed in Package Menu."
  ;; Revert package information!
  (package-initialize t))

;;;###autoload
(defun easky-list-packages ()
  "List packages."
  (interactive)
  (easky-package--setup
      (progn
        (package-initialize t)
        (package-list-packages t))
    (add-hook 'package-menu-mode-hook #'easky--revert-package-info)))

;;;###autoload
(defalias 'easky-package-list-packages 'easky-list-packages)

;;;###autoload
(defun easky-package-install ()
  "List packages."
  (interactive)
  (easky-package--setup
      (progn
        (package-initialize t)
        (call-interactively #'package-install))
    (easky--revert-package-info)))

;;;###autoload
(defun easky-package-reinstall ()
  "List packages."
  (interactive)
  (easky-package--setup
      (progn
        (package-initialize t)
        (call-interactively #'package-reinstall))
    (easky--revert-package-info)))

(provide 'easky-package)
;;; easky-package.el ends here