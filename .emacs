;; ============================================================
;; Emacs ビギナーに贈る、これからバリバリ使い隊!!人のための設定講座 その1。 - 日々、とんは語る。
;; http://d.hatena.ne.jp/tomoya/20090121/1232536106
(setq load-path (cons "~/.emacs.d/elisp" load-path))

;; install-elisp
(require 'install-elisp)

;; インストールする場所
(setq install-elisp-repository-directory "~/.emacs.d/elisp/")

;; 次からは、インストールしたい Elisp ファイルがあれば、
;; M-x install-elisp というコマンドを実行して、流れのままに、
;; Elisp ファイルの URL を入力して、流れのままに C-c C-c とタイプして、
;; インストールを完了して下さい。

;; その後は、.emacs に設定を書くだけです。
;; なので、今後は、ほぼ設定を書くという作業だけに集中できる様になりました

;;参考: install-elisp で使えるコマンド
;; M-x install-elisp
;;   URL を入力して、Elisp をインストールするコマンド
;; M-x install-elisp-from-emacswiki
;;   EmacsWikiで公開されている Elisp の名前を入力するだけでインストールできるコマンド
;; M-x dired-install-elisp-from-emacswiki
;;   dired(Emacs 組み込みのファイラー)で選択しているファイルをEmacsWikiからインストールするコマンド 

;; ============================================================
;; Emacs(中略)設定講座 その2「elisp のインストールと設定編」。 - 日々、とんは語る。
;; http://d.hatena.ne.jp/tomoya/20090124/1232822594

;; auto-complete
(require 'auto-complete)
(global-auto-complete-mode t)

;; ============================================================
;; Emacs設定講座 その3「scratch バッファと eval(評価)」。 - 日々、とんは語る。
;; http://d.hatena.ne.jp/tomoya/20090215/1234692209

;; C-j は scratch 上では、eval-print-last-sexp というコマンドが実行されます。
;; これは、カーソルの最寄りの関数や変数を評価して、返り値を下の行に表示してくれます。

;; リージョンのハイライト
(setq transient-mark-mode t)

;; ============================================================
;; キーバインド（グローバル）
(global-set-key "\C-h" 'delete-backward-char)
(global-set-key "\C-c>" 'comment-region)
(global-set-key "\C-c<" 'uncomment-region)
(global-set-key "\C-xl" 'goto-line)