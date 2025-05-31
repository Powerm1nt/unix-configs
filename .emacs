;(setq custom-file (expand-file-name "custom.el" user-emacs-directory))

;;essentials
(tool-bar-mode 0)
(global-display-line-numbers-mode)
(electric-pair-mode t)
(setq ido-enable-flex-matching t)
(set-frame-font "ComicShannsMono Nerd Font 12")

;;exwm
(require 'exwm)
;; Set the initial workspace number.
(setq exwm-workspace-number 10)
;; Make class name the buffer name.
(add-hook 'exwm-update-class-hook
  (lambda () (exwm-workspace-rename-buffer exwm-class-name)))

(setq mouse-autoselect-window t
      focus-follows-mouse t)

;; Global keybindings.
(setq exwm-input-global-keys
      `(([?\s-r] . exwm-reset) ;; s-r: Reset (to line-mode).
        ([?\s-w] . exwm-workspace-switch) ;; s-w: Switch workspace.
        ([?\s-&] . (lambda (cmd) ;; s-&: Launch application.
                     (interactive (list (read-shell-command "$ ")))
                     (start-process-shell-command cmd nil cmd)))
        ;; s-N: Switch to certain workspace.
        ,@(mapcar (lambda (i)
                    `(,(kbd (format "s-%d" i)) .
                      (lambda ()
                        (interactive)
                        (exwm-workspace-switch-create ,i))))
                  (number-sequence 0 9))))
;; Enable EXWM
(exwm-enable)
;; Launch my shit
(start-process-shell-command "polybar" nil "polybar -r")
(start-process-shell-command "picom" nil "picom")

;; Useful shortcuts

;;resizing windows
(global-set-key (kbd "s-<left>")  'shrink-window-horizontally)
(global-set-key (kbd "s-<right>") 'enlarge-window-horizontally)
(global-set-key (kbd "s-<down>")  'shrink-window)
(global-set-key (kbd "s-<up>")    'enlarge-window)

;; (setq ido-everywhere t)
;; (ido-mode 1)
(fido-vertical-mode 1)

(defun my-c++-mode-hook ()
  (setq c-basic-offset 4)
  (c-set-offset 'substatement-open 0))
(add-hook 'c++-mode-hook 'my-c++-mode-hook)


(setq ido-create-new-buffer 'always)
(setq-default confirm-nonexistent-file-or-buffer nil)
(setq lazy-highlight-cleanup nil)
(setq completion-styles '(emacs21 basic partial-completion))

(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(dolist (package '(use-package))
   (unless (package-installed-p package)
     (package-install package)))

(use-package shades-of-purple-theme :ensure t)
(load-theme 'shades-of-purple t)

(use-package magit :ensure t)
(use-package cmake-mode :ensure t)
(use-package cmake-ide :ensure t)

(cmake-ide-setup)

					; C++ config
(use-package lsp-mode
  :ensure t
  :hook (prog-mode . lsp-deferred)
  :custom
  (lsp-clients-clangd-executable "clangd") ;; or use ccls package to get call
                                         ;; hierarchy lsp extension
  (lsp-auto-guess-root t)                ;; auto guess root
  (lsp-prefer-capf t)                    ;; using `company-capf' by default
  (lsp-keymap-prefix "C-c l"))

;; (use-package ccls
;;   :ensure t
;;   :config
;;   (setq ccls-executable "ccls")
;;   (setq lsp-prefer-flymake nil)
;;   (setq-default flycheck-disabled-checkers '(c/c++-clang c/c++-cppcheck c/c++-gcc))
;;   :hook ((c-mode c++-mode objc-mode) .
;;          (lambda () (require 'ccls) (lsp))))
(use-package flycheck
  :ensure t)
(use-package yasnippet
  :ensure t
  :config (yas-global-mode))
(use-package which-key
  :ensure t
  :config (which-key-mode))

(use-package lsp-treemacs
  :ensure t)

;;; This will enable emacs to compile a simple cpp single file without any makefile by just pressing [f9] key
(defun code-compile()
  (interactive)
  (unless (file-exists-p "Makefile")
    (set (make-local-variable 'compile-command)
	 (let ((file (file-name-nondirectory buffer-file-name)))
	   (format "%s -o %s %s"
		   (if (equal (file-name-extension file) "cpp") "g++" "gcc")
		   (file-name-sans-extension file)
		   file)))
    (compile compile-command)))
(global-set-key [f9] 'code-compile)

(use-package company :ensure t)
(add-hook 'after-init-hook 'global-company-mode)

;; Persist history over Emacs restarts. Vertico sorts by history position.
(use-package savehist
  :init
  (savehist-mode))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("a57c3c53d60e99f39ad3272729810e0ea19a41c1fff2751888201695423714a9"
     default))
 '(package-selected-packages
   '(ccls cmake-ide cmake-mode cmake-project command-log-mode company
	  corfu exwm flycheck helm-lsp lsp-treemacs lsp-ui magit
	  orderless shades-of-purple-theme vertico which-key yasnippet)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

