;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!   


;;;;;================================= 2024-02-11，周日

   (setq package-archives '(("gnu"   . "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
                            ("org-cn". "http://mirrors.tuna.tsinghua.edu.cn/elpa/org/")
                            ("melpa" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")))

   
   ;; Key Configuration for Doom as Vanilla Emacs
   (setq evil-default-state 'emacs)
   
   (setq system-time-locale "C")
	
   (set-language-environment "UTF-8")
   (set-terminal-coding-system 'utf-8)
   (set-keyboard-coding-system 'utf-8)
   (set-clipboard-coding-system 'utf-8)
   (set-buffer-file-coding-system 'utf-8)
   (set-selection-coding-system 'utf-8)
   (modify-coding-system-alist 'process "*" 'utf-8)
	
	
	

;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
    (setq user-full-name "Jiangwei Yang"
          user-mail-address "yangjw2011@foxmail.com")
	
	(display-time-mode 1)
    (setq display-time-day-and-date t)
	
    (setq frame-title-format
          '("" " 為學日益, 為道日損 - "
           (:eval (if (buffer-file-name)
                  (abbreviate-file-name (buffer-file-name)) "%b"))))
			 
	;;设置窗口位置为屏库左上角(0,0)
    (set-frame-position (selected-frame) 300 8)
    (add-to-list 'default-frame-alist '(width  . 130))
    (add-to-list 'default-frame-alist '(height . 43))	
    ;;(add-to-list 'initial-frame-alist '(fullscreen . maximized))	
	

	;; 默认显示120列
    (setq default-fill-column 120)
	

	
    ;; 定义 IS-WINDOWS 变量
    (defvar IS-WINDOWS (eq system-type 'windows-nt))

    (when IS-WINDOWS
      (when (display-graphic-p)
        (defun set-font (english chinese english-size chinese-size)
          (set-face-attribute 'default nil :font
                              (format   "%s:pixelsize=%d"  english english-size))
          (dolist (charset '(kana han symbol cjk-misc bopomofo))
            (set-fontset-font (frame-parameter nil 'font) charset
                              (font-spec :family chinese :size chinese-size))))
      (set-font "Source Code Pro" "Microsoft Yahei" 15 17)
      ))
			
	(define-key evil-insert-state-map (kbd "C-y") #'yank)
    (define-key evil-insert-state-map (kbd "M-w") #'kill-ring-save)		
	
	
	;; 解决粘贴中文出现乱码的问题
    (if (eq system-type 'windows-nt)
	  (progn
	    ;; (setq selection-coding-system 'utf-16le-dos) ;; 修复从网页剪切文本过来时显示 \nnn \nnn 的问题
	    ;; (set-default selection-coding-system 'utf-16le-dos)
	    (set-selection-coding-system 'utf-16le-dos) ;; 别名set-clipboard-coding-system
	  )
    (set-selection-coding-system 'utf-8))
	

	
	
	;; Best with custom Iosevka font. See, e.g., https://is.gd/L67AoR
    (setq +pretty-code-enabled-modes '(emacs-lisp-mode org-mode clojure-mode
                                       latex-mode scheme-mode racket-mode ess-r-mode))
    (setq highlight-indent-guides-responsive 'top
          highlight-indent-guides-delay 0)

    ;; Org and R additional symbols
    ;; hex code ▷ (9655), ◇ (9671), ▶ (9654), ƒ (402)
    ;;(setq +pretty-code-iosevka-font-ligatures
    ;;      (append +pretty-code-iosevka-font-ligatures
    ;;              '(("[ ]" .  "☐")
    ;;                ("[X]" . "☑" )
    ;;                ("[-]" . "❍" )
    ;;                ("%>%" . ?▷)
    ;;                ("%$%" . ?◇)
    ;;                ("%T>%" . ?▶)
    ;;                ("function" . ?ƒ))))
	
	

    ;; https://is.gd/3VuSXj
    (defface org-checkbox-done-text
      '((t (:foreground "#5a637b")))
      "Face for the text part of a checked org-mode checkbox.")

    (font-lock-add-keywords 'org-mode
                            '(("^[ \t]*\\(?:[-+*]\\|[0-9]+[).]\\)[ \t]+\\(\\(?:\\[@\\(?:start:\\)?[0-9]+\\][ \t]*\\)?\\[\\(?:X\\|\\([0-9]+\\)/\\2\\)\\][^\n]*\n\\)"
                               1 'org-checkbox-done-text prepend))
                            'append)
    ;; (custom-set-faces '(org-checkbox ((t (:foreground nil :inherit org-todo)))))
	
	
	;; ----------------------------------  org-mode配置：开始 -----------------------------------------------
	


(use-package! org-modern
  :hook (org-mode . org-modern-mode)
  :config
  (setq org-modern-star '("◉" "○" "✸" "✿" "✤" "✜" "◆" "▶")
        org-modern-table-vertical 1
        org-modern-table-horizontal 0.2
        org-modern-list '((43 . "➤")
                          (45 . "–")
                          (42 . "•"))
        org-modern-todo-faces
        '(("TODO" :inverse-video t :inherit org-todo)
          ("PROJ" :inverse-video t :inherit +org-todo-project)
          ("STRT" :inverse-video t :inherit +org-todo-active)
          ("[-]"  :inverse-video t :inherit +org-todo-active)
          ("HOLD" :inverse-video t :inherit +org-todo-onhold)
          ("WAIT" :inverse-video t :inherit +org-todo-onhold)
          ("[?]"  :inverse-video t :inherit +org-todo-onhold)
          ("KILL" :inverse-video t :inherit +org-todo-cancel)
          ("NO"   :inverse-video t :inherit +org-todo-cancel))
        org-modern-footnote
        (cons nil (cadr org-script-display))
        org-modern-block-fringe nil
        org-modern-block-name
        '((t . t)
          ("src" "»" "«")
          ("example" "»–" "–«")
          ("quote" "❝" "❞")
          ("export" "⏩" "⏪"))
        org-modern-progress nil
        org-modern-priority nil
        org-modern-horizontal-rule (make-string 36 ?─)
        org-modern-keyword
        '((t . t)
          ("title" . "𝙏")
          ("subtitle" . "𝙩")
          ("author" . "𝘼")
          ("email" . #("" 0 1 (display (raise -0.14))))
          ("date" . "𝘿")
          ("property" . "☸")
          ("options" . "⌥")
          ("startup" . "⏻")
          ("macro" . "𝓜")
          ("bind" . #("" 0 1 (display (raise -0.1))))
          ("bibliography" . "")
          ("print_bibliography" . #("" 0 1 (display (raise -0.1))))
          ("cite_export" . "⮭")
          ("print_glossary" . #("ᴬᶻ" 0 1 (display (raise -0.1))))
          ("glossary_sources" . #("" 0 1 (display (raise -0.14))))
          ("include" . "⇤")
          ("setupfile" . "⇚")
          ("html_head" . "🅷")
          ("html" . "🅗")
          ("latex_class" . "🄻")
          ("latex_class_options" . #("🄻" 1 2 (display (raise -0.14))))
          ("latex_header" . "🅻")
          ("latex_header_extra" . "🅻⁺")
          ("latex" . "🅛")
          ("beamer_theme" . "🄱")
          ("beamer_color_theme" . #("🄱" 1 2 (display (raise -0.12))))
          ("beamer_font_theme" . "🄱𝐀")
          ("beamer_header" . "🅱")
          ("beamer" . "🅑")
          ("attr_latex" . "🄛")
          ("attr_html" . "🄗")
          ("attr_org" . "⒪")
          ("call" . #("" 0 1 (display (raise -0.15))))
          ("name" . "⁍")
          ("header" . "›")
          ("caption" . "☰")
          ("results" . "🠶")))
  (custom-set-faces! '(org-modern-statistics :inherit org-checkbox-statistics-todo)))

  (after! spell-fu
  (cl-pushnew 'org-modern-tag (alist-get 'org-mode +spell-excluded-faces-alist)))
  
  

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "D:/Dropbox/git")

    ;;设置打开文件的缺省路径
    (setq default-directory "D:/Dropbox/")
    ;;(setq org-roam-directory "E:/Dropbox/git/org/roam")


    ;; org-mode
    (global-set-key "\C-cl" 'org-store-link)
    (global-set-key "\C-cc" 'org-capture)
    (global-set-key "\C-ca" 'org-agenda)
    (global-set-key "\C-cb" 'org-iswitchb)

    (setq tramp-ssh-controlmaster-options
          "-o ControlMaster=auto -o ControlPath='tramp.%%C' -o ControlPersist=no")
    ;; define the refile targets
    (defvar org-agenda-dir "" "gtd org files location")
    (setq-default org-agenda-dir "D:/Dropbox/git/gtd")
    (setq org-agenda-file-note (expand-file-name "notes.org" org-agenda-dir))
    (setq org-agenda-file-gtd (expand-file-name "gtd.org" org-agenda-dir))
    ;;(setq org-agenda-file-task (expand-file-name "task.org" org-agenda-dir))
    (setq org-agenda-file-journal (expand-file-name "journal.org" org-agenda-dir))
    (setq org-agenda-file-trading (expand-file-name "trading.org" org-agenda-dir))
    (setq org-agenda-file-projects (expand-file-name "projects.org" org-agenda-dir))
    ;; (setq org-default-notes-file (expand-file-name "gtd.org" org-agenda-dir))
    (setq org-agenda-file-finished (expand-file-name "finished.org" org-agenda-dir))
    (setq org-agenda-file-canceled (expand-file-name "canceled.org" org-agenda-dir))
    ;; 设置 org-agenda-files 包含多个目录
    (setq org-agenda-files (list "D:/Dropbox/git/gtd"
                                "D:/Dropbox/git/notes/topics/forex"
                                "D:/Dropbox/git/notes/topics/rates"
                                "D:/Dropbox/git/notes/topics/yen"))


    (require 'org-protocol)
    (require 'org-capture)
  
    (setq org-capture-templates
        '(
          ;; Todo 任务模板组
		  ("t" "📋 Todo 待办事项")
          ("tt" "📌 General Task 一般任务" entry (file+headline org-agenda-file-gtd "To Do Items")
           "* TODO [#B] %?\n %i\n %U"
           :empty-lines 1)
          ("tw" "💼 Work Task 工作任务" entry (file+headline org-agenda-file-gtd "Task")
           "* TODO %^{任务名}\n%u\n%a\n"
		   :empty-lines 1)

          ;; 会议模板
          ("m" "🤝 Meeting 会议" entry (file+headline org-agenda-file-gtd "Meetings")
           "* MEETING %^{会议主题} @ %^{会议地点}\nSCHEDULED: %^t\n:PROPERTIES:\n:LOCATION: %\\2\n:ATTENDEES: %^{参会人员}\n:END:\n\n** 议程 Agenda\n- %?\n\n** 会议纪要 Notes\n\n** 行动项 Action Items\n- [ ] \n\n%U"
           :empty-lines 1)

          ;; Inbox 收集箱模板
          ("x" "📥 Inbox 收集箱" entry (file+headline org-agenda-file-gtd "Inbox")
           "* %^{标题} :INBOX:\n%U\n%?"
           :empty-lines 1)

		  ("h" "🔁 Habit 习惯" entry (file+headline org-agenda-file-gtd "Habit")
           "* NEXT %?\n%U\n%a\nSCHEDULED: %(format-time-string \"<%Y-%m-%d %a .+1d/3d>\")\n:PROPERTIES:\n:STYLE: habit\n:REPEAT_TO_STATE: NEXT\n:END:\n")
		  ("b" "📚 Book Reading 读书" entry (file+olp org-agenda-file-gtd "Reading" "Book")
           "* TODO %^{书名}\n%u\n%?\n"
		   :empty-lines 1)
		  ("n" "📝 Notes 笔记" entry (file+headline org-agenda-file-note "Quick notes")
           "* %^{heading} %^g %?\n %i\n %U"
           :empty-lines 1)
		  ("i" "💡 Ideas 想法" entry (file+headline org-agenda-file-note "Quick ideas")
           "* %? :IDEA:\n%U\n%a\n"
           :empty-lines 1)
          ("j" "📔 Journal 日志"
           entry (file+datetree org-agenda-file-journal)
           "* %^{heading}\n  %?\n%U"
		   :empty-lines 1)
		  ("o" "💹 Trading Ideas 交易想法" entry (file+headline org-agenda-file-trading "Trading ideas")
           "* TODO [#B] %? :IDEA:\n%U\n%a\n"
           :empty-lines 1)

          ;; 回顾模板
          ("r" "🔍 Reviews 回顾")
          ("rd" "📅 Daily Review 每日回顾" entry (file+datetree org-agenda-file-journal)
           "* 每日回顾 Daily Review :REVIEW:DAILY:\n%U\n\n** 今日完成 What I accomplished today\n- %?\n\n** 今日学到 What I learned today\n- \n\n** 明日计划 What's planned for tomorrow\n- \n\n** 今日感悟 Thoughts and reflections\n- \n\n** 改进点 Areas for improvement\n- "
           :empty-lines 1
           :jump-to-captured t)

          ("rw" "📊 Weekly Review 每周回顾" entry (file+datetree org-agenda-file-journal)
           "* 每周回顾 Weekly Review - Week %(format-time-string \"%%W\") :REVIEW:WEEKLY:\n%U\n\n** 本周成就 Achievements this week\n- %?\n\n** 本周挑战 Challenges faced\n- \n\n** 下周目标 Goals for next week\n*** TODO \n*** TODO \n*** TODO \n\n** 本周学习 Key learnings\n- \n\n** 习惯追踪 Habit tracking\n- [ ] 每日运动 Daily exercise\n- [ ] 阅读 Reading\n- [ ] 冥想 Meditation\n\n** 本周反思 Weekly reflection\n"
           :empty-lines 1
           :jump-to-captured t)

          ("rm" "📈 Monthly Review 月度回顾" entry (file+datetree org-agenda-file-journal)
           "* 月度回顾 Monthly Review - %(format-time-string \"%%Y-%%m\") :REVIEW:MONTHLY:\n%U\n\n** 月度目标完成情况 Monthly goals completion\n*** 已完成 Completed\n- %?\n*** 未完成 Not completed\n- \n\n** 重要成就 Key achievements\n- \n\n** 主要挑战和解决方案 Challenges and solutions\n- \n\n** 下月目标 Goals for next month\n*** TODO \n*** TODO \n*** TODO \n\n** 月度财务回顾 Financial review\n- 收入 Income: \n- 支出 Expenses: \n- 储蓄 Savings: \n\n** 个人成长 Personal growth\n- \n\n** 下月改进计划 Improvement plan for next month\n- "
           :empty-lines 1
           :jump-to-captured t)
		   ))
	
    ;; --------------- 回顾辅助函数 --------------
    ;; 快速创建每日回顾
    (defun my/daily-review ()
      "快速创建每日回顾"
      (interactive)
      (org-capture nil "rd"))

    ;; 快速创建每周回顾
    (defun my/weekly-review ()
      "快速创建每周回顾"
      (interactive)
      (org-capture nil "rw"))

    ;; 快速创建月度回顾
    (defun my/monthly-review ()
      "快速创建月度回顾"
      (interactive)
      (org-capture nil "rm"))

    ;; 绑定快捷键
    (global-set-key (kbd "C-c r d") 'my/daily-review)
    (global-set-key (kbd "C-c r w") 'my/weekly-review)
    (global-set-key (kbd "C-c r m") 'my/monthly-review)

    ;; --------------- Inbox 整理辅助函数 --------------
    ;; 快速将 Inbox 条目标记为需要 refile
    (defun my/mark-as-refile ()
      "Mark current entry with REFILE tag."
      (interactive)
      (org-toggle-tag "REFILE" 'on)
      (org-toggle-tag "INBOX" 'off)
      (message "Marked for refile"))

    ;; 快速将条目移到 Someday/Maybe
    (defun my/mark-as-someday ()
      "Mark current entry as SOMEDAY."
      (interactive)
      (org-toggle-tag "SOMEDAY" 'on)
      (org-toggle-tag "INBOX" 'off)
      (org-todo "")
      (message "Moved to Someday/Maybe"))

    ;; 快速处理 Inbox 条目（设置 TODO 和优先级）
    (defun my/process-inbox-item ()
      "Quick process inbox item: set TODO state and priority."
      (interactive)
      (org-todo "TODO")
      (org-priority ?B)
      (org-toggle-tag "INBOX" 'off)
      (message "Inbox item processed. Ready to refile with C-c C-w"))

    ;; 统计 Inbox 数量
    (defun my/count-inbox-items ()
      "Count and display number of inbox items."
      (interactive)
      (let ((count 0))
        (org-map-entries
         (lambda () (setq count (1+ count)))
         "INBOX"
         'agenda)
        (message "📥 Inbox contains %d items" count)))

    ;; 一键清理已完成的 Inbox 条目
    (defun my/archive-done-inbox-items ()
      "Archive all DONE items in Inbox."
      (interactive)
      (let ((count 0))
        (org-map-entries
         (lambda ()
           (when (member (org-get-todo-state) '("DONE" "CANCELLED"))
             (org-archive-subtree)
             (setq count (1+ count))))
         "INBOX"
         'file)
        (message "Archived %d completed inbox items" count)))

    ;; 绑定 Inbox 整理快捷键
    (global-set-key (kbd "C-c i r") 'my/mark-as-refile)
    (global-set-key (kbd "C-c i s") 'my/mark-as-someday)
    (global-set-key (kbd "C-c i p") 'my/process-inbox-item)
    (global-set-key (kbd "C-c i c") 'my/count-inbox-items)
    (global-set-key (kbd "C-c i a") 'my/archive-done-inbox-items)

    ;; 辅助函数：检查条目是否在 Inbox 标题下
    (defun my/org-agenda-skip-if-not-inbox-child ()
      "Skip entries that are not direct children of Inbox heading."
      (let ((parent-heading (save-excursion
                              (org-up-heading-safe)
                              (org-get-heading t t t t))))
        (if (string= parent-heading "Inbox")
            nil
          (org-entry-end-position))))

    ;; --------------- 定义转接文件 --------------
    (define-key global-map "\C-cr" 'org-refile)

    ;; 扩展 refile targets - 支持 Inbox 快速整理到各个位置
    (setq org-refile-targets  '((org-agenda-file-gtd :maxlevel . 2)        ; GTD 主文件的二级标题
                               (org-agenda-file-projects :maxlevel . 2)    ; 项目文件
                               (org-agenda-file-note :maxlevel . 2)        ; 笔记文件
                               (org-agenda-file-trading :maxlevel . 2)     ; 交易文件
                               (org-agenda-file-finished :maxlevel . 1)    ; 已完成归档
                               (org-agenda-file-canceled :maxlevel . 1)))  ; 已取消归档

    ;; Refile 使用完整路径显示
    (setq org-refile-use-outline-path 'file)
    (setq org-outline-path-complete-in-steps nil)
    (setq org-refile-allow-creating-parent-nodes 'confirm)	
	
    ;;; roam v2 configuration
	(setq org-roam-directory "D:/Dropbox/git/org/roam") ;改成你的文件位置

    ;; ------------------  美化 MEETING 在 agenda 中的显示 ------------------
    ;; 定义MEETING关键字
    (setq org-todo-keywords
          '((sequence "TODO(t)" "NEXT(n)" "STARTED(s)" "WAITING(w)" "HOLD(h)" "|" "DONE(d)" "CANCELLED(c)")
            (sequence "MEETING(m)" "|" "DONE(d)")))

    ;; 设置MEETING的显示颜色和样式 - 只突出MEETING关键字本身
    (setq org-todo-keyword-faces
          '(("MEETING" . (:foreground "#ff6c6b" :weight bold))))

    ;; ------------------  设置aganda view
    ;; An Agenda for Life With Org Mode
    ;; https://blog.aaronbieber.com/2016/09/24/an-agenda-for-life-with-org-mode.html
    (defun air-org-skip-subtree-if-priority (priority)
      "Skip an agenda subtree if it has a priority of PRIORITY.

    PRIORITY may be one of the characters ?A, ?B, or ?C."
      (let ((subtree-end (save-excursion (org-end-of-subtree t)))
            (pri-value (* 1000 (- org-lowest-priority priority)))
            (pri-current (org-get-priority (thing-at-point 'line t))))
        (if (= pri-value pri-current)
            subtree-end
          nil)))

    (defun air-org-skip-subtree-if-habit ()
      "Skip an agenda entry if it has a STYLE property equal to \"habit\"."
      (let ((subtree-end (save-excursion (org-end-of-subtree t))))
            (if (string= (org-entry-get nil "STYLE") "habit")
                subtree-end
              nil)))

    ;; 辅助函数：检查任务是否在今天完成
    (defun my/org-is-task-completed-today ()
      "Check if current task was completed today."
      (let ((closed-time (org-entry-get nil "CLOSED")))
        (and closed-time
             (string-match (regexp-quote (format-time-string "%Y-%m-%d")) closed-time))))

    ;; 辅助函数：跳过不是今天完成的任务
    (defun my/org-skip-not-completed-today ()
      "Skip tasks that were not completed today."
      (let ((subtree-end (save-excursion (org-end-of-subtree t))))
        (if (my/org-is-task-completed-today)
            nil
          subtree-end)))
			  

    (setq org-agenda-custom-commands
      '(("x" "10日视图 10-Day View"
         ((tags "PRIORITY=\"A\""
                ((org-agenda-skip-function '(or (org-agenda-skip-entry-if 'todo 'done)
                                               (air-org-skip-subtree-if-habit)))
                 (org-agenda-overriding-header "🔴 高优先级未完成任务 High-priority unfinished tasks:")))
          (agenda ""
                  ((org-agenda-span 10)
                   (org-agenda-start-day "+0d")
                   (org-agenda-overriding-header "📅 10日日程 10-Day Schedule:")
                   (org-habit-show-habits nil)  ;; 不显示习惯图表
                   (org-agenda-skip-function 'air-org-skip-subtree-if-habit)))  ;; 跳过习惯任务
          (tags-todo "IDEA"
		             ((org-agenda-skip-function '(or (air-org-skip-subtree-if-priority ?A)
                                                     (air-org-skip-subtree-if-habit)))
                      (org-agenda-overriding-header "💡 外汇交易想法 FX Trading Ideas:")))
          (tags-todo "提升"
		             ((org-agenda-skip-function '(or (air-org-skip-subtree-if-priority ?A)
                                                     (air-org-skip-subtree-if-habit)))
                      (org-agenda-overriding-header "📈 提升相关 Promotion:")))
          (alltodo ""
                   ((org-agenda-skip-function '(or (air-org-skip-subtree-if-habit)
				                                   (org-agenda-skip-subtree-if 'regexp ":提升:")
												   (org-agenda-skip-subtree-if 'regexp ":IDEA:")
                                                   (air-org-skip-subtree-if-priority ?A)
                                                   (org-agenda-skip-if nil '(scheduled deadline))))
                    (org-agenda-overriding-header "📋 所有常规优先级任务 All normal priority tasks:"))))
         ((org-agenda-compact-blocks nil)))

        ;; 每日回顾视图
        ("d" "每日回顾 Daily Review"
         ((tags-todo "+PRIORITY=\"A\""
                     ((org-agenda-overriding-header "🔴 高优先级 High Priority:")
                      (org-agenda-skip-function '(org-agenda-skip-entry-if 'done))))

          (agenda ""
                  ((org-agenda-span 1)
                   (org-agenda-start-day "0d")
                   (org-agenda-overriding-header "📅 今日日程 Today's Schedule:")
                   (org-habit-show-habits t)  ;; 显示习惯
                   (org-habit-graph-column 50)))

          (todo "DONE"
                ((org-agenda-overriding-header "✅ 今日完成 Completed Today:")
                 (org-agenda-skip-function
                  '(let ((closed (org-entry-get nil "CLOSED")))
                     (if (and closed
                              (string-match-p (regexp-quote (format-time-string "%Y-%m-%d")) closed))
                         nil
                       (or (outline-next-heading) (point-max)))))))

          (todo "TODO|NEXT|STARTED"
                ((org-agenda-overriding-header "⏳ 未完成任务 Unfinished Tasks:")
                 (org-agenda-skip-function
                  '(org-agenda-skip-entry-if 'scheduled 'deadline))))

          (tags "JOURNAL"
                ((org-agenda-overriding-header "📝 今日笔记 Today's Journal:")
                 (org-agenda-files '("D:/Dropbox/git/gtd/journal.org"))
                 (org-agenda-skip-function
                  '(org-agenda-skip-entry-if 'notregexp
                                            (format-time-string "%Y-%m-%d"))))))
         ((org-agenda-compact-blocks nil)
          (org-agenda-block-separator "────────────────────────────────────────")
          (org-agenda-start-with-log-mode t)))

        ;; 每周回顾视图
        ("w" "每周回顾 Weekly Review"
         ((agenda "" ((org-agenda-span 'week)
                     (org-agenda-start-on-weekday 1)
                     (org-agenda-overriding-header "📅 本周日程 This Week's Schedule:")
                     (org-habit-show-habits nil)  ;; 不显示习惯图表
                     (org-agenda-skip-function 'air-org-skip-subtree-if-habit)))  ;; 跳过习惯任务

          (todo "DONE"
                ((org-agenda-overriding-header "✅ 本周完成 Completed This Week:")
                 (org-agenda-skip-function
                  '(let* ((today (current-time))
                          (week-start (time-subtract today (days-to-time
                                                          (mod (- (time-to-days today) 1) 7)))))
                     (if (string= (org-entry-get nil "STYLE") "habit")
                         (point-max)
                       (org-agenda-skip-entry-if 'notregexp
                                               (format-time-string "\\[%Y-%m" week-start)))))))

          (todo "CANCELLED"
                ((org-agenda-overriding-header "❌ 本周取消 Cancelled This Week:")
                 (org-agenda-skip-function 'air-org-skip-subtree-if-habit)))

          (tags-todo "+PRIORITY=\"A\""
                     ((org-agenda-overriding-header "🔴 待处理高优先级 Pending High Priority:")
                      (org-agenda-skip-function 'air-org-skip-subtree-if-habit)))

          (tags-todo "GOAL"
                     ((org-agenda-overriding-header "🎯 目标进展 Goals Progress:")
                      (org-agenda-skip-function 'air-org-skip-subtree-if-habit))))
         ((org-agenda-compact-blocks nil)
          (org-agenda-block-separator "────────────────────────────────────────")
          (org-agenda-start-with-log-mode t)))

        ;; 月度回顾视图
        ("m" "月度回顾 Monthly Review"
         ((agenda "" ((org-agenda-span 'month)
                     (org-agenda-overriding-header "📅 本月日程 This Month's Schedule:")
                     (org-habit-show-habits nil)  ;; 不显示习惯图表
                     (org-agenda-skip-function 'air-org-skip-subtree-if-habit)))  ;; 跳过习惯任务

          (tags-todo "GOAL"
                     ((org-agenda-overriding-header "🎯 月度目标 Monthly Goals:")
                      (org-agenda-skip-function 'air-org-skip-subtree-if-habit)))

          (tags "ACHIEVEMENT"
                ((org-agenda-overriding-header "🏆 本月成就 Achievements:")
                 (org-agenda-skip-function 'air-org-skip-subtree-if-habit)))

          (todo "TODO"
                ((org-agenda-overriding-header "📋 待办事项 Pending TODOs:")
                 (org-agenda-skip-function 'air-org-skip-subtree-if-habit)
                 (org-agenda-max-entries 10))))
         ((org-agenda-compact-blocks nil)
          (org-agenda-block-separator "────────────────────────────────────────")))

        ;; 项目视图
        ("p" "项目视图 Project Board"
         ((todo "PROJ"
                ((org-agenda-files (list org-agenda-file-projects))
                 (org-agenda-overriding-header "🗂 活动项目 Active Projects:")
                 (org-tags-match-list-sublevels 'indented)
                 (org-agenda-sorting-strategy '(priority-down todo-state-down category-keep))))
          (todo "NEXT|TODO"
                ((org-agenda-files (list org-agenda-file-projects))
                 (org-agenda-overriding-header "➡️ 下一步行动 Next Actions:")
                 (org-agenda-skip-function '(org-agenda-skip-entry-if 'todo '("PROJ" "WAIT" "HOLD")))
                 (org-tags-match-list-sublevels 'indented)
                 (org-agenda-prefix-format '((todo . " %i %-12:c")))
                 (org-agenda-sorting-strategy '(priority-down scheduled-up category-keep))))
          (todo "WAIT|HOLD"
                ((org-agenda-files (list org-agenda-file-projects))
                 (org-agenda-overriding-header "⏸ 阻塞项目 Waiting / On Hold:")
                 (org-agenda-skip-function '(org-agenda-skip-entry-if 'todo '("PROJ")))
                 (org-tags-match-list-sublevels 'indented)
                 (org-agenda-sorting-strategy '(priority-down todo-state-down)))))
         ((org-agenda-compact-blocks nil)
          (org-agenda-block-separator "────────────────────────────────────────")
          (org-agenda-start-with-log-mode nil)))

        ;; 交易视图
        ("y" "交易视图 Trading Desk"
         ((agenda ""
                  ((org-agenda-files (list org-agenda-file-trading))
                   (org-agenda-span 7)
                   (org-agenda-start-day "0d")
                   (org-agenda-overriding-header "📅 交易日程 Trading Calendar:")
                   (org-habit-show-habits nil)
                   (org-agenda-show-log nil)))
          (todo "NEXT|STRT|TODO"
                ((org-agenda-files (list org-agenda-file-trading))
                 (org-agenda-overriding-header "▶️ 活动策略 Active Setups:")
                 (org-tags-match-list-sublevels 'indented)
                 (org-agenda-skip-function '(org-agenda-skip-entry-if 'todo '("WAIT" "HOLD" "DONE" "KILL" "NO")))
                 (org-agenda-sorting-strategy '(priority-down deadline-up))))
          (tags-todo "IDEA"
                     ((org-agenda-files (list org-agenda-file-trading))
                      (org-agenda-overriding-header "💡 交易想法 Idea Pipeline:")
                      (org-tags-match-list-sublevels 'indented)
                      (org-agenda-sorting-strategy '(priority-down alpha))))
          (todo "WAIT|HOLD"
                ((org-agenda-files (list org-agenda-file-trading))
                 (org-agenda-overriding-header "⏳ 等待信号 Waiting Signals:")
                 (org-agenda-sorting-strategy '(todo-state-down priority-down)))))
         ((org-agenda-compact-blocks nil)
          (org-agenda-block-separator "────────────────────────────────────────")
          (org-agenda-start-with-log-mode nil)))

        ;; Inbox 整理视图 - 优化版本
        ("i" "📥 Inbox 收集箱整理 Inbox Processing"
         ((tags "LEVEL=2"
                ((org-agenda-overriding-header "📥 Inbox 标题下的所有条目 All Items under Inbox Heading:")
                 (org-agenda-files (list org-agenda-file-gtd))
                 (org-agenda-skip-function 'my/org-agenda-skip-if-not-inbox-child)
                 (org-agenda-sorting-strategy '(time-up))))
          (tags "INBOX+TODO=\"\""
                ((org-agenda-overriding-header "📥 带 INBOX 标签但未分类的条目 Unprocessed Items with INBOX tag:")
                 (org-tags-match-list-sublevels nil)
                 (org-agenda-sorting-strategy '(time-up))))
          (tags "INBOX+TODO=\"TODO\"|INBOX+TODO=\"NEXT\""
                ((org-agenda-overriding-header "✅ 已标记但未 Refile 的条目 Marked but Not Refiled:")
                 (org-tags-match-list-sublevels nil)
                 (org-agenda-sorting-strategy '(priority-down time-up))))
          (tags "REFILE"
                ((org-agenda-overriding-header "🏷️ 标记为 REFILE 的条目 Marked for Refile:")
                 (org-tags-match-list-sublevels nil)))
          (tags "SOMEDAY"
                ((org-agenda-overriding-header "💭 可能/将来 Someday/Maybe:")
                 (org-tags-match-list-sublevels nil))))
         ((org-agenda-compact-blocks nil)
          (org-agenda-block-separator "────────────────────────────────────────")
          (org-agenda-prefix-format '((tags . " %i %-12:c %s")))))

        ))

;;; org-download
(after! org
  (require 'org-download)
  ;; Drag-and-drop to `dired`
  (add-hook 'dired-mode-hook 'org-download-enable))

;; Option 2: Globally
(with-eval-after-load 'org (global-org-modern-mode))

;; 切换窗口
(global-set-key [C-tab] 'other-window)

    ;; org-agenda-files 已在前面设置
	;;(org-agenda-list t)
	;; 启动时设置为左右两个窗口
	;;(split-window-horizontally)
	;;(split-window-right)
	;;-(other-window 1)
	;; 右侧窗口自动显示日程表
    ;;-(switch-to-buffer "*Org Agenda*")
	;;-(other-window 1)

    ;; 自动显示日程表
    ;; org-agenda-files 已在前面设置
	;;(org-agenda-list t)
	
	; org-roam settings
	;;(add-hook 'after-init-hook 'org-roam-mode)
	
	
	
;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
   (setq display-line-numbers-type t)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.


							 
							 
						 
    ;; ---------------------- R, ESS设置 ----------------------------------
    (setq inferior-ess-r-program "C:/Program Files/R/R-4.4.2/bin/R.exe")
	(add-to-list 'auto-mode-alist '("\\.R$" . R-mode))
	

  
    ;; ESS Mode (.R file)
    (global-set-key [(meta i)] 'ess-eval-line-and-step)
    (global-set-key [(meta p)] 'ess-eval-function-or-paragraph-and-step)
    (global-set-key [(meta o)] 'ess-eval-region-and-step)
    (global-set-key [(meta b)] 'ess-eval-buffer)
	
	(defun yjw_R_operator ()
      "insert '<-'"
      (interactive)
      (insert " <- "))
	(global-set-key (kbd "_") 'yjw_R_operator)

    (defun then_R_operator ()
      "%>% operator or 'then' pipe operator"
      (interactive)
      (insert " %>%") ; note the space before the first %
      (reindent-then-newline-and-indent))
    (global-set-key (kbd "C-%") 'then_R_operator)
	
	;; “M-;”命令使用时插入的注释符由comment-start变量确定
	(add-hook 'ess-mode-hook (lambda () (setq comment-start "##-")))
	
	;; 注释/取消注释选中的区域
	(defun uncomment-region (beg end)
      "Like `comment-region' invoked with a C-u prefix arg."
      (interactive "r")
      (comment-region beg end -1))

    ;;(define-key ess-mode-map (kbd "C-d") 'comment-region)
    ;;(define-key ess-mode-map (kbd "C-S-d") 'uncomment-region)
	
	;;(map! :map ess-mode-map
     ;; :n "C-d" #'comment-region
	  ;;:n "C-S-d" #'uncomment-region)

  
    ;; "C-M-j"提高代码可读性:分隔线
    (defun insert-break-line()
      "Insert a break line at cursor point."
      (interactive)
      (insert "## =======================================================")
      (eval (newline-and-indent))
      (insert "## "))
    ;;(define-key ess-mode-map (kbd "C-M-u") 'insert-break-line)
    

    ;;(define-key ess-mode-map "\C-l" 'ess-eval-line-and-step)
    ;;(define-key ess-mode-map "\C-p" 'ess-eval-function-or-paragraph-and-step)
    ;;(define-key ess-mode-map "\C-r" 'ess-eval-region)
  
    ;; start with a file ending in ".R", 
    ;; emacs starts maximized, with two windows side by side, in one my source code file, and in the other the ESS R interpreter.
    ;; "M-x my-R-window-configuration RET" in an .R buffer.
    (defun my-R-window-configuration ()
      "Prepare the current emacs frame for R work."
      (interactive)
      ;; maximimize the current frame:
      (set-frame-parameter nil 'fullscreen 'maximized)
      ;; keep just the current window, presumably containing the R code
      (delete-other-windows)
      ;; create ESS R interaction buffer and go there
      (ess-switch-to-end-of-ESS)
      ;; go back to the code
      (other-window 1))
  
  
    (global-set-key (kbd "C-p") 'previous-line)            ;; 与ctrl+p一致
    (global-set-key (kbd "C-n") 'next-line)                ;; 下移动光标
    (global-set-key (kbd "C-f") 'forward-char)             ;; 向前移动一个字符
    (global-set-key (kbd "C-b") 'backward-char)            ;; 向后移动一个字符
    (global-set-key (kbd "C-a") 'move-beginning-of-line)   ;; 移到行首
    (global-set-key (kbd "C-e") 'move-end-of-line)         ;; 移到行尾
  
    

	
	;; ---------------------- R-markdown设置 ----------------------------------
	
    (use-package polymode :ensure t
      :mode (("\\.[SR]nw\\'" . poly-noweb+r-mode)
             ("\\.Rmd\\'" . Rmd-mode))
      :init
      (progn
        (defun Rmd-mode ()
          "ESS Markdown mode for Rmd files."
          (interactive)
          (setq load-path 
                (append (list "C:/Users/yangj/.emacs.d/yjw/polymode/" "C:/Users/yangj/.emacs.d/yjw/poly-markdown/" 
			                  "C:/Users/yangj/.emacs.d/yjw/poly-R/" "C:/Users/yangj/.emacs.d/yjw/poly-noweb/")
                        load-path)) 
          (require 'poly-R)
          (require 'poly-markdown)
          (R-mode)
          (yaml-mode)
          (poly-markdown+r-mode))

        ;; do this in R process
        ;; library (rmarkdown); render ("file_name.Rmd")
        (defun ess-rmarkdown ()
          (interactive)
          "Compile R markdown (.Rmd). Should work for any output type."
          "http://roughtheory.com/posts/ess-rmarkdown.html"
          ;; Check if attached R-session
          (condition-case nil
              (ess-get-process)
            (error
             (ess-switch-process)))
          (save-excursion
            (let* ((sprocess (ess-get-process ess-current-process-name))
                   (sbuffer (process-buffer sprocess))
                   (buf-coding (symbol-name buffer-file-coding-system))
                   (R-cmd
                    (format "library (rmarkdown); rmarkdown::render(\"%s\")"
                            buffer-file-name))
                   (message "Running rmarkdown on %s" buffer-file-name)
                   (ess-execute R-cmd 'buffer nil nil)
                   (switch-to-buffer rmd-buf)
                   (ess-show-buffer (buffer-name-sbuffer) nil)))))))
