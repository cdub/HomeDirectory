(menu-bar-mode -1)


;;
;; aquamacs special setup
;;

;(when (featurep 'aquamacs)
;  ;; command key as meta
;  (setq mac-command-modifier 'meta)
;  ;; merge emacs kill-ring with clipboard (fix copy/paste)
;  (setq x-select-enable-clipboard t)
;  ;; color themese
;  (color-theme-initialize)
;  (color-theme-taylor)
;;;  (aquamacs-toggle-full-frame)
;  )


;; (load "~/elisp/packages/tiny-tools/lisp/tiny/tinypath")
;; (require 'tiny-setup)
;; (tiny-setup nil)

(setq load-path
      (cons "~/.elisp" load-path))

;; If you did not execute any such command, the situation is
;; probably due to a bug and you should report it.
;;
;; You can disable the popping up of this buffer by adding the entry
;; (undo discard-info) to the user option `warning-suppress-types'.


;; For speed handle the following settings in Xresources/Xdefaults
;;(menu-bar-mode -1)
;;(tool-bar-mode -1)
;; (set-default-font "-adobe-courier-medium-r-normal-*-12-*-*-*-*-*-*-*")



;; (setq automatic-hscrolling nil)
;; (setq auto-hscroll-mode nil)


(setq inhibit-splash-screen t)               ;; no splash screen
(toggle-scroll-bar -1)                       ;; no scrollbar
(global-font-lock-mode t)                    ;; font-lock-mode on!
(fset 'yes-or-no-p 'y-or-n-p)                ;; less typing :)

(setq fill-column 78)                        ;; 78 char column width
(setq auto-fill-mode t)                      ;; auto wrap

(setq line-number-mode t)                    ;; line numbers in mode bar
(setq column-number-mode t)                  ;; column numbers in mode bar

(setq transient-mark-mode t)                 ;; hilight selected buffer

(setq scroll-step 1)                         ;; Scroll a line at a time

;; delete trailing whitespace "M-x dtw"
(defalias 'dtw 'delete-trailing-whitespace)



;; Make sure that the delete key works, regardless of mode
;; But then "C-h a" for apropos mode doesn't work...
;; (keyboard-translate ?\C-h ?\C-?)


;;(split-window-horizontally)                  ;; always do this anyway

(global-set-key "\M-g" 'goto-line)



(defun fullscreen ()
  (interactive)
  (set-frame-parameter
   nil 'fullscreen
   (if (frame-parameter nil 'fullscreen)
       nil 'fullboth)))

(global-set-key [f11] 'fullscreen)           ;; make it BIG




;; C-mode settings

;; highlight parens in c-mode
(show-paren-mode)


(defun my-c-mode-common-hook ()
  (setq tab-width 4)
  (setq c-basic-offset 4)
  (setq indent-tabs-mode nil))

(add-hook 'c-mode-common-hook 'my-c-mode-common-hook)





;; Cscope setup.

(setq cscope-initial-directory "/local2/head")

(require 'xcscope)

(define-prefix-command 'Meta-dot-map nil)
(global-set-key "\M-." 'Meta-dot-map)
(define-key global-map "\M-.." 'cscope-find-global-definition)
(define-key global-map "\M-.r" 'cscope-find-this-symbol)
(define-key global-map "\M-.c" 'cscope-find-functions-calling-this-function)
(define-key global-map "\M-.C" 'cscope-find-called-functions)
(define-key global-map "\M-.t" 'cscope-find-this-text-string)
(define-key global-map "\M-.e" 'cscope-find-egrep-pattern)
(define-key global-map "\M-.f" 'cscope-find-this-file)
(define-key global-map "\M-.i" 'cscope-find-files-including-file)
(define-key global-map "\M-.n" 'cscope-next-symbol)
(define-key global-map "\M-.N" 'cscope-next-file)
(define-key global-map "\M-.p" 'cscope-prev-symbol)
(define-key global-map "\M-.P" 'cscope-prev-file)


;; Doxymacs setup
;;(require 'doxymacs)

;; Default key bindings are:
;;
;; C-c d ? look up documentation for the symbol under the point.
;; C-c d r rescan your Doxygen tags file.
;; C-c d f insert a Doxygen comment for the next function.
;; C-c d i insert a Doxygen comment for the current file.
;; C-c d ; insert a Doxygen comment for a member variable on the current line (like M-;).
;; C-c d m insert a blank multi-line Doxygen comment.
;; C-c d s insert a blank single-line Doxygen comment.
;; C-c d @ insert grouping comments around the current region.
;;
;;
;; Customize the following variables:
;; doxymacs-doxygen-root
;; doxymacs-doxygen-tags

;; invoke doxymacs-mode whenever we visit c/c++ file
(add-hook 'c-mode-common-hook' doxymacs-mode)

;; automatically fontify doxygen keywords
(defun my-doxymacs-font-lock-hook ()
  (if (or (eq major-mode 'c-mode) (eq major-mode 'c++-mode))
      (doxymacs-font-lock)))
(add-hook 'font-lock-mode-hook 'my-doxymacs-font-lock-hook)


;; Use cperl mode instead of the default perl mode
(defalias 'perl-mode 'cperl-mode)

;; turn autoindenting on
(global-set-key "\r" 'newline-and-indent)

;; Use 4 space indents via cperl mode
(custom-set-variables
 '(cperl-close-paren-offset -4)
 '(cperl-continued-statement-offset 4)
 '(cperl-indent-level 4)
 '(cperl-indent-parens-as-block t)
 '(cperl-tab-always-indent t))

;; Insert spaces instead of tabs
(setq-default indent-tabs-mode nil)

;; Use % to match various kinds of brackets
;;(global-set-key "%" 'match-paren)
;;(defun match-paren (arg)
;;  "Go to the matching paren if on a paren; otherwise insert %."
;;  (interactive "p")
;;  (let ((prev-char (char-to-string (preceding-char)))
;;	(next-char (char-to-string (following-char))))
;;    (cond ((string-match "[[{(<]" next-char) (forward-sexp 1))
;;	  ((string-match "[\]})>]" prev-char) (backward-sexp 1))
;;	  (t (self-insert-command (or arg 1))))))







(defun perltidy-region ()
  "Run perltidy on the current region."
  (interactive)
  (save-excursion
    (shell-command-on-region (point) (mark) "perltidy -q" nil t)
    (cperl-mode)))

(defun perltidy-all ()
  "Run perltidy on the current region."
  (interactive)
  (let ((p (point)))
    (save-excursion
      (shell-command-on-region (point-min) (point-max) "perltidy -q" nil t))
    (goto-char p)
    (cperl-mode)))

(global-set-key "\M-t" `perltidy-region)
(global-set-key "\M-T" `perltidy-all)



;; GUD customizations

;;    On startup, GUD runs one of the following hooks: `gdb-mode-hook', if
;; you are using GDB; `dbx-mode-hook', if you are using DBX;
;; `sdb-mode-hook', if you are using SDB; `xdb-mode-hook', if you are
;; using XDB; `perldb-mode-hook', for Perl debugging mode;
;; `pdb-mode-hook', for PDB; `jdb-mode-hook', for JDB.  You can use these
;; hooks to define custom key bindings for the debugger interaction
;; buffer.  Note: Hooks.

;;    Here is a convenient way to define a command that sends a particular
;; command string to the debugger, and set up a key binding for it in the
;; debugger interaction buffer:

;;      (gud-def FUNCTION CMDSTRING BINDING DOCSTRING)

;;    This defines a command named FUNCTION which sends CMDSTRING to the
;; debugger process, and gives it the documentation string DOCSTRING.  You
;; can then use the command FUNCTION in any buffer.  If BINDING is
;; non-`nil', `gud-def' also binds the command to `C-c BINDING' in the GUD
;; buffer's mode and to `C-x C-a BINDING' generally.

;;    The command string CMDSTRING may contain certain `%'-sequences that
;; stand for data to be filled in at the time FUNCTION is called:

;; `%f'
;;      The name of the current source file.  If the current buffer is the
;;      GUD buffer, then the "current source file" is the file that the
;;      program stopped in.

;; `%l'
;;      The number of the current source line.  If the current buffer is
;;      the GUD buffer, then the "current source line" is the line that
;;      the program stopped in.

;; `%e'
;;      The text of the C lvalue or function-call expression at or
;;      adjacent to point.

;; `%a'
;;      The text of the hexadecimal address at or adjacent to point.

;; `%p'
;;      The numeric argument of the called function, as a decimal number.
;;      If the command is used without a numeric argument, `%p' stands for
;;      the empty string.

;;      If you don't use `%p' in the command string, the command you define
;;      ignores any numeric argument.



(defun cws-gud-hook ()
  ;; some stuff
  )

(add-hook 'gdb-mode-hook 'cws-gud-hook)



(autoload 'tt-mode "tt-mode")
(setq auto-mode-alist
  (append '(("\\.tt.*$" . tt-mode))  auto-mode-alist ))


;; Unfortunately, yaml mode is broken... 5/26/08 CWS
;;
;; (autoload 'yaml-mode "yaml-mode")
;; (require 'yaml-mode)
;; (add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))

;; uncomment for 'newline-and-ident' behavior
;;
;; (add-hook 'yaml-mode-hook
;;   '(lambda ()
;;     (define-key yaml-mode-map "\C-m" 'newline-and-indent)))
;;



(require 'color-theme)
(setq color-theme-is-global t)
(color-theme-initialize)
(color-theme-arjen)
;(color-theme-billw)
;(color-theme-clarity)
;(color-theme-dark-laptop)
;(color-theme-gray30)
;(color-theme-hober)
;(color-theme-lethe)
;(color-theme-renegade)
;(color-theme-taming-mr-arneson)
;(color-theme-tty-dark)
;(color-theme-calm-forest)


;;(if (boundp 'aquamacs-version)
    ;; aquamacs specific code
;;    (set-frame-font "-apple-monaco`-medium-r-normal--24-360-72-72-m-360-iso10646-1")
;;
;;)(prin1-to-string (x-list-fonts "*"))




;; Lisp (slime) stuff




;; Aquamacs shit
;(when (boundp 'aquamacs-version)
;  (one-buffer-one-frame-mode 0))

;(One-buffer-one-frame-mode nil)




;;
;; Perl Stylish REPL
;;
(add-to-list 'load-path "~/.emacs.d/stylish/")
(load-library "~/.emacs.d/stylish/stylish.el")
(load-library "~/.emacs.d/stylish/stylish-repl.el")
(load-library "~/.emacs.d/stylish/stylish-repl-iedit.el")


;;
;; Clojure-Mode
;;
(add-to-list 'load-path "~/Clojure/clojure-mode/")
(autoload 'clojure-mode "clojure-mode" "A major mode for Clojure" t)
(add-to-list 'auto-mode-alist '("\\.clj$" . clojure-mode))

;;
;; Clojure-Swank
;;
(add-to-list 'load-path "~/Clojure/swank-clojure/")
;(setq swank-clojure-jar-path "~/Clojure/clojure/clojure.jar")
(setq swank-clojure-binary "~/Clojure/clojure-extra/sh-script/clojure")
(require 'swank-clojure-autoload)
;(swank-clojure-config
; (setq swank-clojure-jar-path "~/SVN/clojure/clojure.jar")
;; (setq swank-clojure-extra-classpaths '()))
;)



;;
;; Slime (must come after swank)
;;
(add-to-list 'load-path "~/.emacs.d/slime/")
;;(setq inferior-lisp-program "/opt/local/bin/sbcl")
(require 'slime)
(slime-setup)


