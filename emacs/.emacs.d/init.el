(require 'package)
;;(add-to-list 'package-archives
;;             '("melpa-stable" . "https://stable.melpa.org/packages/") t)
;;(add-to-list 'package-archives
;;  '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents)) ;; refresh the local copy before package-install
(require 'use-package) ;; use-package makes it easy to work with any downloaded packages without having to do any extra code
(setq use-package-always-ensure t)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(ace-jump-mode xclip helpful which-key command-log-mode xwwp evil csv csv-mode helm color-theme-modern org-bullets melpa-upstream-visit nov fzf exec-path-from-shell latex-preview-pane markdown-mode))
 '(tool-bar-mode nil))
(setq org-M-RET-may-split-line nil)

;; Evil related config
(require 'evil)
(evil-mode 1)

;; Evil does not support mapping stuff like jk to <ESC> command out of the box
(use-package general
  :config
  (general-evil-setup t)
  (general-imap "j" (general-key-dispatch 'self-insert-command :timeout 0.25 "k" 'evil-normal-state)))

;;(general-imap "j"
;;              (general-key-dispatch 'self-insert-command
;;                :timeout 0.25
;;                "k" 'evil-normal-state))

;; org-mode customizations
(setq org-todo-keywords
 '((sequence "TODO" "CURRENT" "WAITING" "|" "DONE" "DELEGATED" "SKIPPED")))

;; (require 'org-bullets)
(add-hook 'org-mode-hook (lambda() (org-bullets-mode 1)))
(add-hook 'org-mode-hook (lambda() (org-indent-mode)))

;; (custom-set-faces
;; '(default ((t (:inherit nil :stipple nil :background "#242424" :foreground "#f6f3e8" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 120 :width normal :foundry "nil" :family "Spleen")))))
(load-theme 'wombat t)
;;(load-theme 'tango-dark)
(set-cursor-color "#add8e6")
;;(org-level-1 ((t (:bold t :foreground "dodger blue" :height 1.5))))
;;(org-level-2 ((t (:bold nil :foreground "#edd400" :height 1.2))))
;;(org-level-3 ((t (:bold t :foreground "#6ac214" :height 1.0))))
;;(org-level-4 ((t (:bold nil :foreground "tomato" :height 1.0))))


(setq backup-directory-alist '(("" . "~/.emacs.d/emacs-backup/")))
(setq auto-save-file-name-transforms '((".*" "~/.emacs.d/emacs-autosave/" t)))

;; Remove startup screen and messages
(setq-default inhibit-startup-screen t)
(setq-default inhibit-splash-screen t)
(setq-default inhibit-startup-message t)

;; some *scratch* configuration
(setq initial-major-mode 'text-mode)
(setq initial-scratch-message "")

(setq scroll-step 1) ;; keyboard scroll one line at a time

(scroll-bar-mode -1) ; hide the scrollbars
(tool-bar-mode -1) ; hide the toolbar
(tooltip-mode -1) ; hide the tooltips
(menu-bar-mode -1) ; hide the menubar
(mouse-wheel-mode -1) ; don't like the mouse
(global-display-line-numbers-mode)

;; only GUI
(set-fringe-mode 10) ;; space on the left and right in the GUI, does not really affect the TUI

;; enable the latex preview pane when open tex files
(latex-preview-pane-enable)

;; Emacs' PATH != Shell's, because Emacs inherits default set of environment variables: https://github.com/purcell/exec-path-from-shell
;; does not work for some reason, so I have to pass the full path for anbt-sql-formatter
(when (memq window-system '(mac ns x))
 (exec-path-from-shell-initialize))

(defun sql-beautify-region (beg end)
   "Beautify SQL in region between beg and END."
   (interactive "r")
   (save-excursion
     (shell-command-on-region beg end "anbt-sql-formatter" nil t)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-level-1 ((t (:inherit outline-1 :foreground "light green" :height 1.5))))
 '(org-level-2 ((t (:inherit outline-2 :foreground "turquoise1" :height 1.2)))))

(define-key evil-normal-state-map (kbd ",f") 'fzf)
;;(setq debug-on-error nil)

;; read epub with Emacs
(add-to-list 'auto-mode-alist '("\\.epub\\'" . nov-mode))

(defun toggle-selective-display (column)
   (interactive "P")
   (set-selective-display
      (or column
          (unless selective-display
            (1+ (current-column))))))

;; copy paste functionality
;;(global-set-key (kbd "C-c") (lambda ()
;;                             (interactive)
;;                             (shell-command-on-region (region-beginning) (region-end) "pbcopy")
;;                             (message "Yanked to clip")
;;                             (deactivate-mark)))

(eval-after-load 'evil-maps
  '(progn
     (define-key evil-motion-state-map (kbd "SPC") 'evil-ex))) ;; remap : to SPC

;; Understand more about the commands
(use-package command-log-mode)
;; show the buffer M-x clm/toggle-command-log-buffer

;; Show info about shortcut that you're trying to use
(use-package which-key
  :init (which-key-mode)
  :diminish which-key-mode
  :config
  (setq which-key-idle-delay 0.2))


;; make the Help pages more detailed
(use-package helpful
  :bind
  ([remap describe-function] . helpful-callable)
  ([remap describe-key] . helpful-key)
  ([remap describe-variable] . helpful-variable)
  ([remap describe-command] . helpful-command))

;; Helm
(use-package helm)
(require 'helm-config)
(setq helm-split-window-in-side-p t
      helm-candidate-number-limit 30)

(global-set-key (kbd "C-c h") 'helm-command-prefix)

(helm-mode 1)

;; replace M-x menu with helm M-x
(global-set-key (kbd "M-x") 'helm-M-x)
;; replace the search with 'helm-
(global-set-key (kbd "C-s") 'helm-occur)
;; replace the search with 'helm-
(global-set-key (kbd "C-x C-f") 'helm-find-files)


;; ace-jump (throws cl deprecation warning)
(use-package ace-jump-mode)
(define-key evil-normal-state-map (kbd "ls") 'ace-jump-char-mode)

;; Enable copy-paste behavior in terminal emacs (https://github.com/noctuid/evil-guide)
(use-package xclip)
(defun noct:conditionally-toggle-xclip-mode ()
   (if (display-graphic-p)
      (if (bound-and-true-p xclip-mode)
         (xclip-mode -1))
      (xclip-mode)))

(noct:conditionally-toggle-xclip-mode)

(add-hook 'focus-in-hook
           #'noct:conditionally-toggle-xclip-mode)
