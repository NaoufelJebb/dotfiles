(defvar file-name-handler-alist-original file-name-handler-alist)
(defvar ehackable/gc-cons-threshold 100000000)

(setq gc-cons-threshold most-positive-fixnum
      gc-cons-percentage 0.6
      file-name-handler-alist nil
      site-run-file nil)


(add-hook 'emacs-startup-hook ; hook run after loading init files
          (lambda ()
            (setq gc-cons-threshold ehackable/gc-cons-threshold
                  gc-cons-percentage 0.1
                  file-name-handler-alist file-name-handler-alist-original)))

(add-hook 'minibuffer-setup-hook (lambda ()
                                   (setq gc-cons-threshold (* ehackable/gc-cons-threshold 2))))
(add-hook 'minibuffer-exit-hook (lambda ()
                                  (garbage-collect)
                                  (setq gc-cons-threshold ehackable/gc-cons-threshold)))

;; Always follow the sym links
(setq vc-follow-symlinks nil)

(require 'package)
(add-to-list 'package-archives '("gnu" . "https://elpa.gnu.org/packages/"))
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/"))
(setq package-enable-at-startup nil)
(package-initialize)

;; Setting up the package manager. Install if missing.
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(eval-and-compile
  (setq use-package-always-ensure t))


;; Load main config file "./config.org"
(require 'org)
(org-babel-load-file (expand-file-name (concat user-emacs-directory "config.org")))

;; Specific MAC OS configuration
 (setq mac-option-modifier        'meta
       mac-command-modifier       'meta
       mac-right-option-modifier   nil
       mac-pass-control-to-system nil)

(provide 'init)
;;; init.el ends here
