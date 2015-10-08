;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;; CUSTOMIZATION ;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Load paths should be first because I will copying my .emacs to other machine as well
;;; Anything specific to paths needs to be done here
;;; This works for 24.2 --> now migrating to 24.3
;; valmick guha GeorgeBernardShaw7x30
(require 'gnus)
;;(require 'org-gnus)         
;;(setq tls-program '("C:/PROGRA~1/Git/bin/openssl.exe s_client -connect %h:%p -no_ssl2 -ign_eof"))

(defun buffer-kill-path ()
  "copy buffer's full path to kill ring"
  (interactive)
  (kill-new (buffer-file-name)))

(defun turn-headline-into-org-mode-link ()
  "Replace word at point by an Org mode link."
  (interactive)
  (when (org-at-heading-p)
    (let ((hl-text (nth 4 (org-heading-components))))
      (unless (or (null hl-text)
                  (org-string-match-p "^[ \t]*:[^:]+:$" hl-text))
        (beginning-of-line)
        (search-forward hl-text (point-at-eol))
        (kill-new
         (concat "[[" (buffer-file-name) "::" hl-text "][" hl-text "]]"))

         (point)))))


(setq
 python-shell-interpreter "C:\\Anaconda1\\python.exe"
 python-shell-interpreter-args
 "-i C:\\Anaconda1\\Scripts\\ipython-script.py")

  (setq ido-enable-flex-matching t)
  (setq ido-everywhere t)
  (ido-mode 1) 

(add-to-list 'load-path "c:/Dropbox/install/org-8.2.8/lisp")

(add-to-list 'load-path "c:/Dropbox/install/org-8.2.8/contrib/lisp") 

(defun my-personal()
  (interactive)
  (find-file "C:/Users/vguha/Desktop/READ/ImpData/Misc.gpg"))


 (defun my-gtd()
  (interactive)
  (find-file "C:/VVP/OFFICE/TaskList.org"))

 (defun my-dotemacs()
  (interactive)
  (find-file "C:/VVP/OrgMain/emacsSetup/start01.el"))

;;; Load dotemacs from common location
(load "C:/VVP/OrgMain/emacsSetup/start01.el")
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-agenda-files (quote ("c:/VVP/OrgMain/Subject/COMPSCI/LinuxVMM.org" "c:/VVP/OrgMain/TechNotes.org" "c:/VVP/OrgMain/MISC/MyOrg.org" "c:/VVP/PROJECTS/RAM_COMPRESSION_ZRAM/README.org" "c:/VVP/PROJECTS/IMAGE_SIZE/README.org" "c:/VVP/OrgMain/Target.org" "c:/VVP/OrgMain/Year2015.org" "c:/VVP/OrgMain/Courses.org" "c:/VVP/OrgMain/MyBook/MyNotes.org" "c:/VVP/OrgMain/EMBEDDED/Main.org" "c:/VVP/OrgMain/BAS_BEAR/BearMain.org" "c:/VVP/OrgMain/BAS_BEAR/BearBuild.org")))
 '(send-mail-function (quote smtpmail-send-it)))
 '(send-mail-function (quote smtpmail-send-it))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


;;;;;;;;;; install package
  (require 'package)
  (package-initialize)
  (add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)


(add-to-list 'load-path "c:/Dropbox/install/emacs-24.3/bin/.emacs.d")

(add-to-list 'load-path  "c:/Dropbox/install/emacs-24.3/bin")




(require 'xcscope)


;;;;;;;;;; This from Dropbox ;;;;;;;;;;;;;;



(require 'ob-python)
;;(require 'org-babel-gnuplot)
;;(require 'org-babel-c)

(add-to-list 'org-latex-classes
             '("resume-test"
               "\\documentclass[10pt]{article}
                 \\usepackage[hmargin=1.25cm, vmargin=1.5cm]{geometry}
                 \\usepackage{marvosym}
                 \\usepackage{ifsym}
                 \\usepackage{hyperref}
                 \\renewcommand{\\headrulewidth}{0pt}
                 \\newcommand{\\DTS}{\\textsc{DTS}}
            [NO-DEFAULT-PACKAGES]
            [NO-PACKAGES]"
               ("\\section{%s}" . "\\section*{%s}")
               ("\\subsection{%s}" . "\\subsection*{%s}")
               ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
               ("\\paragraph{%s}" . "\\paragraph*{%s}")
               ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))               
(setq org-export-latex-hyperref-format "\\ref{%s}")



(org-babel-do-load-languages
 'org-babel-load-languages
 '((emacs-lisp . t)
   (R . t)
   (C . t)
   (sh . t)
   (python . t)))

;;;;;; copy the path to kill buffer so that one
;;;;;; can copy it anyhere else wherever required

;; if not set it will always put actual image size
(setq org-image-actual-width nil)

(require 'ess-site)


(eval-after-load 'autoinsert
  '(define-auto-insert
     '("\\.org\\'" . "Org-mode skeleton")
     '("Org-mode auto header insert "
"#+STARTUP:hidestars" \n
"#+TITLE: " \n
"#+AUTHOR: " \n
"#+INCLUDE: c:/VVP/PROJECTS_2/ALL/LATEX_HEADER.org" \n
"#+OPTIONS: todo:nil toc:nil H:3 tags:nil ^:nil" \n
"#+EXCLUDE_TAGS: noexport done" \n
"#+SELECT_TAGS: " \n
"#+SELECT_TAGS: " \n
"#+LaTeX: \\begin{multicols}{2}       " > _ \n

       )))
