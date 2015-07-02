;;; 言語を日本語にする:
(set-language-environment 'Japanese)

;;; 極力UTF-8とする
(prefer-coding-system 'utf-8)

(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)


;; Mac用フォント設定
;; http://tcnksm.sakura.ne.jp/blog/2012/04/02/emacs/

;; 日本語
(set-fontset-font
 nil 'japanese-jisx0208
;; (font-spec :family "Hiragino Mincho Pro")) ;; font
  (font-spec :family "Hiragino Kaku Gothic ProN")) ;; font

;; 半角と全角の比を1:2にしたければ
(setq face-font-rescale-alist
;;        '((".*Hiragino_Mincho_pro.*" . 1.2)))
      '((".*Hiragino_Kaku_Gothic_ProN.*" . 1.2)));; Mac用フォント設定

;;;対応する括弧を光らせる
(setq show-paren-delay 0)
(setq show-paren-style 'single)
(show-paren-mode t)

;;;行番号の表示
(global-linum-mode t)
(setq linum-format "%4d: ")

;; C-kで行全体を削除
(setq kill-whole-line t)

;;初期メッセージの非表示
(setq inhibit-startup-message t)

;;起動時のwelcome画面をなくす
(setq inhibit-splash-screen t)

;; 起動時のサイズ,表示位置,フォントを指定
(setq initial-frame-alist
      (append (list
      '(width . 100)
      '(height . 58)
      '(top . 0)
      '(left . 0)
      )
     initial-frame-alist))
(setq default-frame-alist initial-frame-alist)




;;autocomplete.el : 単語補完
(require 'auto-complete)
(require 'auto-complete-config)    ; 必須ではないですが一応
(global-auto-complete-mode t)


;; flymake
(require 'flymake)

;; Python (pyflakes + flymake)
(add-hook 'find-file-hook 'flymake-find-file-hook)
(when (load "flymake" t)
  (defun flymake-pyflakes-init ()
    (let* ((temp-file (flymake-init-create-temp-buffer-copy
                       'flymake-create-temp-inplace))
           (local-file (file-relative-name
                        temp-file
                        (file-name-directory buffer-file-name))))
      (list "/usr/local/bin/pyflakes"  (list local-file))))
  (add-to-list 'flymake-allowed-file-name-masks
               '("\\.py\\'" flymake-pyflakes-init)))
; show message on mini-buffer
(defun flymake-show-help ()
  (when (get-char-property (point) 'flymake-overlay)
    (let ((help (get-char-property (point) 'help-echo)))
      (if help (message "%s" help)))))
(add-hook 'post-command-hook 'flymake-show-help)



;; C++
(defun flymake-cc-init ()
  (let* ((temp-file   (flymake-init-create-temp-buffer-copy
                       'flymake-create-temp-inplace))
         (local-file  (file-relative-name
                       temp-file
                       (file-name-directory buffer-file-name))))
    (list "g++" (list "-Wall" "-Wextra" "-fsyntax-only" local-file))))

(push '("\\.cpp$" flymake-cc-init) flymake-allowed-file-name-masks)

(add-hook 'c++-mode-hook
          '(lambda ()
             (flymake-mode t)))

;; octave mode
(setq auto-mode-alist (cons '("\\.m$" . octave-mode) auto-mode-alist))

;;flycheck
;;(add-hook 'after-init-hook #'global-flycheck-mode)
;;(eval-after-load 'flycheck
  ;;'(custom-set-variables
   ;;'(flycheck-display-errors-function #'flycheck-pos-tip-error-messages)))
   
   
