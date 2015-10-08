;; This is to start emacs from Dropbox
(setq inhibit-splash-screen t)
(setq inhibit-startup-message t)
(set-background-color "cornsilk")
;;; windows issue
(setq w32-get-true-file-attributes nil)
;;(server-start)
;; Turn off annoying, IMHO, toolbars
(tool-bar-mode 0)
;; Do not use the TAB character, insert spaces instead
(setq-default indent-tabs-mode nil) 
;; Turn on syntax coloring globally ("font-lock-mode")
(global-font-lock-mode 1)
(setq font-lock-maximum-decoration t)
;; Font lock colorization customizations
(defconst query-replace-highlight t)    ;highlight during query
(defconst search-highlight t)           ;highlight incremental search
(setq ls-lisp-dirs-first t)             ;display dirs first in dired

(show-paren-mode 1)
(setq line-number-mode t)
(setq toggle-truncate-lines 0)

;; Lets u treat *deleted* text or region outside emacs as text
;; there was issue that deleted text couldn't be copied to other
;; areas 
(delete-selection-mode t) 
(setq-default default-tab-width 4)
;; line number modes
(require 'linum)
(line-number-mode 1)
(column-number-mode 1)  ;; Line numbers on left most column
(global-linum-mode 1)

;; Both following are needed for auto return key after end of line
;;(setq-default fill-column 66)
;;(add-hook 'text-mode-hook 'turn-on-auto-fill) ;;http://www.emacswiki.org/emacs/AutoFillMode

(add-hook 'text-mode-hook 'turn-on-auto-fill)
(add-hook 'text-mode-hook
  '(lambda() (set-fill-column 66))) 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;; LOAD files     ;;;;;;;;;;;;
;;;;;;;;; PACKAGES       ;;;;;;;;;;;;
;;;;;;;;; Settings for packages ;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 (require 'cl)
 (require 'dired)
 (provide 'windmove)
 (windmove-default-keybindings)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;; ORG - Capture templates ;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; only if windows..
(if (string-equal system-type "windows-nt") 
    (progn
      (add-to-list 'exec-path "c:/Program Files (x86)/Mozilla Firefox/") 
	  ;; org-dropbox is for things that can be shared on dropbox
	  (setq org-dropbox   "C:/VVP/OrgMain/")
	  ;; org-directory is on my local system that cannot be shared - office related etc.
      (setq org-directory "C:/"))
  (progn                 
	;; this on my ubuntu machine - office [Need one for my home as well]
    (setq org-dropbox  "/local/mnt/workspace/Dropbox/")
    (ido-mode t)
    (icomplete-mode t)
    (abbrev-mode t)))

(if (string-equal system-name "erewhon")
    (progn
      (setq org-dropbox "/home/valmick/Dropbox/")
      (ido-mode t)
      (icomplete-mode t)
      (abbrev-mode t)))


(setq org-capture-templates
      '(("t" "Todo" entry (file+datetree (concat org-dropbox "/" "Year2015.org") "Tasks")
         "* TODO %? %^G\n  SCHEDULED: %T\n %x ")
        ("r" "Read or reading" entry (file+datetree (concat org-dropbox "/" "Year2015.org"))
         "* READ %? %^G\n  SCHEDULED: %T\n %x ")
        ("l" "Log" entry (file+datetree (concat org-dropbox "/" "Year2015.org"))
         "* LOG %? %^G\n %T\n %x ")
        ("s" "Test" entry (file+datetree (concat org-dropbox "/" "Year2015.org"))
         "* TEST %? %^G\n %T\n %A\n %x ")
        ("c" "Code notes" entry (file+datetree (concat org-dropbox "/" "CODE.org"))
         "* LOG %? %^G\n %T\n %A\n %x ")
      ))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;; Custom functions ;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; auto refresh with f5
(global-set-key
  (kbd "<f5>")
  (lambda (&optional force-reverting)
    "Interactive call to revert-buffer. Ignoring the auto-save
 file and not requesting for confirmation. When the current buffer
 is modified, the command refuses to revert it, unless you specify
 the optional argument: force-reverting to true."
    (interactive "P")
    (message "force-reverting value is %s" force-reverting)
    (if (or force-reverting (not (buffer-modified-p)))
        (revert-buffer :ignore-auto :noconfirm)
      (error "The buffer has been modified"))))

;;  -> Following is a good example on how to 
;;     write functions.
;;  -> Checkout Xah Lee's website for more details
(defun black-insert-task-template ()
  (interactive)
  (save-excursion
    (insert
"** TODO  :TASK:who:
"
))
  (forward-line 1)
  (insert-tab)
  (org-time-stamp 1)
  (backward-word 8)
  (backward-char 2))

(defun my-insert-date ()
  "Insert current date yyyy-mm-dd."
  (interactive)
  (when (use-region-p)
    (delete-region (region-beginning) (region-end) )
    )
  (insert (concat " " (format-time-string "%a: %d-%b-%Y %H:%M ")))
  )


(defun my-insert-date ()
  "Insert current date yyyy-mm-dd."
  (interactive)
  (insert (concat " " (format-time-string "%a: %d-%b-%Y %H:%M ")))
  )

(defun my-org-insert-date ()
  "Insert current date yyyy-mm-dd."
  (interactive)
  (insert (concat "SCHEDULED: <" (format-time-string "%Y-%m-%d %a %H:%M") ">"))
  )

(defun black-insert-log ()
  (interactive)
  (beginning-of-line)
  (insert
"** LOG "
)
  (my-insert-date)
  (newline-and-indent)
  (org-indent-line)
  (my-org-insert-date)
  (end-of-line)
  (newline-and-indent)
  )

;;
;; get the extension
;; 
 (defun get-ext (file-name)
   (car (cdr (split-string file-name "\\."))))
 
;; 
;; get the base name of the file
;;
 (defun base-name (file-name)
   (car (split-string file-name "\\.")))
 
 
 (defun dos2unix ()
   "Convert a DOS formatted text buffer to UNIX format"
   (interactive)
   (set-buffer-file-coding-system 'undecided-unix nil))
 
 (defun unix2dos ()
   "Convert a UNIX formatted text buffer to DOS format"
   (interactive)
   (set-buffer-file-coding-system 'undecided-dos nil))


;; (auto-insert-mode)
;; To insert things automatically based on file extensions
 ;; *NOTE* Trailing slash important
;; (setq auto-insert-directory "/path/to/template/directory/")
;; (setq auto-insert-query nil)
;; (define-auto-insert "\\.tex$" "my-latex-template.tex")

(defun my-org-latex-header ()
  (interactive)
  ;; position it at the start of file
  (insert (concat 
"#+TITLE:
#+AUTHIR: Valmick Guha
#+DATE:" (my-insert-date))))


;; org-mode setup for LaTeX 
(require 'ox-latex)
(unless (boundp 'org-export-latex-classes)
  (setq org-export-latex-classes nil))
(add-to-list 'org-export-latex-classes
             '("book"
               "\\documentclass{book}"
               ("\\part{%s}" . "\\part*{%s}")
               ("\\chapter{%s}" . "\\chapter*{%s}")
               ("\\section{%s}" . "\\section*{%s}")
               ("\\subsection{%s}" . "\\subsection*{%s}")
               ("\\subsubsection{%s}" . "\\subsubsection*{%s}"))
             )


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;; IDO ;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Needed for intelligent buffer mode
;;   (require 'ido)
;;   (ido-mode t)
;;   (setq ido-enable-flex-matching t) ; fuzzy matching is a must have
;;   (setq ido-everywhere t)
;;   (ido-mode t)



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;; ORG       ;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 ;; ORG mode settings
(setq org-enable-table-editor t)
(setq org-use-property-inheritance t) 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;; ORG-Tagging ;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(setq org-deadline-warning-days 7)
(setq org-log-done t)
(setq org-highest-priority ?A)  
(setq org-lowest-priority ?Z) 
(setq org-default-priority ?B)

;; http://orgmode.org/manual/Tag-groups.html#Tag-groups
(setq org-tag-alist '(
					  (:startgroup . nil)
					  ("@read" . nil)
					  (:grouptags . nil)
					  ("@read_office" . nil)
					  ("@read_study" . nil)
					  ("@read_nonfiction" . nil)
					  ("@read_fiction" . nil)
					  (:endgroup . nil)
					  ))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;; Put all your global-set-key here ;;;;;;
;;;;;;        Key mappings              ;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 (global-set-key "\C-ca" 'org-agenda)
 (global-set-key "\C-cl" 'goto-line)
 (global-set-key "\C-cs" 'isearch-forward)
 (global-set-key "\C-cr" 'isearch-backward)
 (global-set-key "\C-cm" 'set-mark-command)
 (global-set-key "\C-cg" 'goto-line)
 (global-set-key (kbd "<f9>") 'black-insert-log)
 (global-set-key "\C-cc" 'org-capture)
 (global-set-key (kbd "<f11>") 'turn-headline-into-org-mode-link)
 (global-set-key (kbd "<f12>") 'buffer-kill-path)
 (global-set-key (kbd "<f8>") 'my-save-word)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;; File Extension modes            ;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

 (setq auto-mode-alist  (cons (cons "\\.org$" 'org-mode) auto-mode-alist)) ;;org-mode
 (setq auto-mode-alist  (cons (cons "\\.txt$" 'org-mode) auto-mode-alist))


;; *IMP* :  net stop netlogon
;; *IMP* :  net start netlogon
;;; windows issue
(setq w32-get-true-file-attributes nil)
(remove-hook 'find-file-hooks 'vc-find-file-hook)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; mail setup
     (setq user-full-name "valmick guha")
     (setq user-mail-address "vguha@qti.qualcomm.com")
     (setq smtpmail-default-smtp-server "smtphost.qualcomm.com")
     
     (setq send-mail-command 'smtpmail-send-it) ; For mail-mode (Rmail)
     (setq message-send-mail-function 'smtpmail-send-it) ; For message-mode (Gnus)
;; org - mime setup for mail
;; flyspell mode for spell checking everywhere
(add-hook 'org-mode-hook 'turn-on-flyspell 'append)

(add-hook 'org-mode-hook
          (lambda ()
            (local-set-key (kbd "C-c M-o") 'bh/mail-subtree))
          'append)

(defun bh/mail-subtree ()
  (interactive)
  (org-mark-subtree)
  (org-mime-subtree))



;; setup the default browser
(setq browse-url-browser-function 'browse-url-generic
      browse-url-generic-program "firefox")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;; ORG custome agenda customization ;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  
;;  (setq org-agenda-custom-commands
;;        '(
;;           ("T" "Do today OK!! No Excuses!!" ((tags-todo "+PRIORITY=\"Z\"")))
;;           ;; Display priority tasks
;;           ;; Z --> A --> B --> C
;;           ("P" "Priority tasks" ((tags-todo "+PRIORITY=\"Z\"")
;;                                  (tags-todo "+PRIORITY=\"A\"")
;;                                  (tags-todo "+PRIORITY=\"B\"")
;;                                  (tags-todo "+PRIORITY=\"C\"")
;;                                  ))
;;           ;; Display InProgress tasks
;;           ("p" "Tasks INPROGRESS only" ((todo "INPROGRESS")))
;;           ;; Tasks TODO
;;           ("x" "Tasks TODO " ((todo "TODO")))
;;           ;; Tasks in WAIT state
;;           ("w" "Tasks wait " ((todo "WAIT")))         
;;           ;; My new composite agenda command
;;           ("v" "Composite data" 
;;            (
;;             (tags-todo "ISSUE")
;;             (tags-todo "-home+PRIORITY=\"Z\"")
;;             (tags-todo "-home+PRIORITY=\"A\"")
;;             (tags-todo "-home+PRIORITY=\"B\"")
;;             (tags-todo "-home+PRIORITY=\"C\"")
;;             ;; "TODO others" - TODOs, No priority, No me, No learning, No read, No home
;;             (tags-todo "-@me-learning-@read-home+TODO=\"TODO\"-PRIORITY=\"Z\"-PRIORITY=\"A\"-PRIORITY=\"B\"-PRIORITY=\"C\""  
;;                   ((org-agenda-overriding-header "           === ALL OTHERS TODOs  ===")))
;;             ;; "INPROGRESS my"
;;             (tags-todo "-home-@read+TODO=\"INPROGRESS\"-PRIORITY=\"Z\"-PRIORITY=\"A\"-PRIORITY=\"B\"-PRIORITY=\"C\""  
;;                   ((org-agenda-overriding-header "           === ALL INPROGRESS  ===")))
;;             ;; "TODOs my"
;;             (tags-todo "-@study+@me-@read-home+TODO=\"TODO\"-PRIORITY=\"Z\"-PRIORITY=\"A\"-PRIORITY=\"B\"-PRIORITY=\"C\""
;;                   ((org-agenda-overriding-header "           === ALL TODOs on me  ===")))
;;             ;; "WAIT - PAUSED & BLOCKED"
;;             (tags-todo "+TODO=\"WAIT\"-PRIORITY=\"Z\"-PRIORITY=\"A\"-PRIORITY=\"B\"-PRIORITY=\"C\""
;;                   ((org-agenda-overriding-header "           === ALL BLOCKED & PAUSED  ===")))
;;  
;;  )) ;; end of - Office
;;           ("H" "HOME Personal Task" 
;;            (
;;             (tags-todo "+home+PRIORITY=\"Z\"")
;;             (tags-todo "+home+PRIORITY=\"A\"")
;;             (tags-todo "+home+PRIORITY=\"B\"")
;;             (tags-todo "+home+PRIORITY=\"C\"")
;;             ;; "TODOs my HOME"
;;             (tags-todo "+home+TODO=\"TODO\"-PRIORITY=\"Z\"-PRIORITY=\"A\"-PRIORITY=\"B\"-PRIORITY=\"C\""
;;                   ((org-agenda-overriding-header "           === ALL My TODOs  ===")))
;;             ;; "READS"
;;             (tags-todo "+TODO=\"TODO\"+@read" ((org-agenda-overridding-header "=== What I am reading ===")))
;;             ;; "STUDY"
;;             (tags-todo "+TODO=\"TODO\"+@study" ((org-agenda-overridding-header "=== STUDY baba!! ===")))
;;             (tags-todo "+TODO=\"TODO\"+@resolution" ((org-agenda-overridding-header "=== What you wanna do with your life ???  ===")))
;;  )) ;; end of - home
;;  
;;           ("A" "Team individual details" 
;;            (
;;             (tags-todo "@gaurav")
;;             (tags-todo "@shaik")
;;             (tags-todo "@padmaja")
;;             (tags-todo "@balaji")
;;             (tags-todo "@kshitiz")
;;             (tags-todo "@deepan")
;;             (tags-todo "@venu")
;;             (tags-todo "@arun")
;;             (tags-todo "@srikanth")
;;             (tags-todo "@harsh")
;;             (tags-todo "@sudha")
;;             (tags-todo "@shridhar")
;;             (tags-todo "@deepak")
;;             (tags-todo "@sridher")
;;             (tags-todo "@who")
;;  ) nil ("C:/Users/vguha/Dropbox/TRACK/test.html")) ;; end of - team
;;           ("J" "All the Projects list out the tasks" 
;;            (
;;             (tags-todo "P_SA" ((org-agenda-overridding-header "=== SA+ ===")))
;;             (tags-todo "T_8916" ((org-agenda-overridding-header "=== 8916 ===")))
;;             (tags-todo "T_8994" ((org-agenda-overridding-header "=== 8994 ===")))
;;             (tags-todo "T_8909" ((org-agenda-overridding-header "=== 8909 ===")))
;;             (tags-todo "T_8939" ((org-agenda-overridding-header "=== 8939 ===")))
;;             (tags-todo "T_8084" ((org-agenda-overridding-header "=== 8939 ===")))
;;             (tags-todo "P_SRS" ((org-agenda-overridding-header "=== SRS ===")))
;;             (tags-todo "P_18" ((org-agenda-overridding-header "=== 1.8 A-Family ===")))
;;             (tags-todo "P_OTHERS-ISSUE" ((org-agenda-overridding-header "=== O T H E R S ===")))
;;  ) nil ("C:/Users/vguha/Dropbox/TRACK/test.html")) ;; end of - team
;;  
;;  )) ;; close the custom agenda
;;  

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;; org projects ;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 ;; ("project-name" :property value :property value ...)
 ;;          i.e., a well-formed property list with alternating keys and values
 ;;     or
 ;;        ("project-name" :components ("project-name" "project-name" ...))
     
(setq org-dropbox-absolute (concat org-dropbox "MyNotes/"))
(if (string-equal system-type "windows-nt")
(setq org-publish-project-alist 
	  '(
		;; Start insert your project details here
		("Dropbox-org"
		 :base-directory "C:/Users/vguha/Dropbox/MyNotes/"
		 :base-extension "org\\|py\\|cpp\\|c\\|txt"
		 :publishing-directory "C:/Users/vguha/Dropbox/MyNotes/"
		 :publishing-function org-publish-attachment
		 :exclude "el" ;; regexp allowed
		 :headline-levels 4
		 :section-numbers t
		 :with-toc t
		 :auto-sitemap t
         :recursive t
		 )
		("Publish-dropbox" :components ("Dropbox-org"))
		("office-org"
		 :base-directory "C:/VVP/"
		 :base-extension "org\\|py\\|cpp\\|c\\|txt\\|pdf"
		 :publishing-directory "C:/VVP/ORG/"
		 :publishing-function org-latex-publish-to-pdf 
		 :exclude "el" ;; regexp allowed
		 :headline-levels 4
		 :section-numbers t
		 :with-toc t
		 :auto-sitemap t
         :recursive t
		 )
		;; End of your project details....
		)))
(if (string-equal system-name "erewhon")
(setq org-publish-project-alist 
	  '(
		;; Start insert your project details here
		("Dropbox-org"
		 :base-directory "C:/VVP/OrgMain/emacsSEtup/"
		 :base-extension "org\\|py\\|cpp\\|c\\|pdf\\|txt"
		 :publishing-directory "/home/valmick/Dropbox/MyNotes/"
		 :publishing-function org-publish-attachment
		 :exclude "el" ;; regexp allowed
		 :headline-levels 4
		 :section-numbers t
		 :with-toc t
		 :auto-sitemap t
         :recursive t
		 )
		("Publish-dropbox" :components ("Dropbox-org"))
		;; End of your project details....
		)))

;; following function appends to end of file with below setting
(defun write-string-to-file (string file)
   ;;(interactive "sEnter the string: \nFFile to save to: ")
  ;;(message (concat file ":"  string))
     (when (file-writable-p file)
       (write-region string
                     (point-max)
                     file t)))

(defun add-to-org-agend-list (file-name)
  (concat "(add-to-list 'org-agenda-files (concat org-dropbox \"MyNotes/\" \"" (generate-and-search file-name) "\"))"))

(defun generate-and-search (absolute-filename)
    (when (string-match (concat "MyNotes/\\(.*" (file-name-nondirectory absolute-filename) "\\)") absolute-filename)
      (match-string 1 absolute-filename)
      ))

;; Follwing function adds the current buffer to org-agenda-files
(defun add-buffer-to-org-agenda-list ()
  (interactive)
  (write-string-to-file (add-to-org-agend-list (buffer-file-name)) (concat org-dropbox "MyNotes/emacsSetup/start01.el")))

(global-set-key (kbd "C-c v v") 'add-buffer-to-org-agenda-list)
;; How to test
;; (message (generate-and-search (buffer-file-name)))
;; c:/Users/vguha/Dropbox/MyNotes/emacsSetup/start01.el
;; (add-to-org-agend-list "test")
;; (add-buffer-to-org-agenda-list (buffer-file-name))
;; (add-to-list org-agenda-files "emacsSetup/start01.el")
;; (add-to-list 'org-agenda-files (concat org-dropbox "MyNotes/" "HomeTaskList.org"))
;; (add-to-list 'org-agenda-files (concat org-dropbox "MyNotes/" "Read.org"))
;; (add-to-list 'org-agenda-files (concat org-dropbox "MyNotes/" "English.org"))
(add-to-list 'org-agenda-files (concat org-dropbox "MyNotes/" "Year2015.org"))

(defun open-dropbox-project()
  (interactive)
  (find-file (concat org-dropbox "MyNotes/sitemap.org")))

(defun open-office-project()
  (interactive "p")
  (find-file (concat org-directory "sitemap.org")))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;; My Latex settings ;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq org-latex-create-formula-image-program 'dvipng)
;;(add-hook 'org-mode-hook 'turn-on-org-cdlatex)

;; setup the org project for the latex Settings(add-to-list 'org-export-latex-classes

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;; C-code settings  ;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq-default c-basic-offset 4)
(setq c-default-style "linux" c-basic-offset 4)




