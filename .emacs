;; valmick-setup

;; This is to start emacs from Dropbox
(setq inhibit-splash-screen t)
(setq inhibit-startup-message t)
;;(server-start)
;; Turn off annoying, IMHO, toolbars
(tool-bar-mode 0)

;;; === OS specific ===
;;; == windows issue ==
(setq w32-get-true-file-attributes nil)


;; == emacs coding settings ==
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







(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-agenda-files
   '("c:/Users/vguha/Downloads/officegit/Basics/org/20210922230718-proj_mvte.org" "c:/Users/vguha/Downloads/officegit/Basics/org/2021.org" "c:/Users/vguha/Downloads/officegit/Basics/org/20210922220304-proj_denc.org" "c:/Users/vguha/Downloads/officegit/Basics/org/20210922213510-proj_ssb_power_saving.org" "c:/Users/vguha/Downloads/officegit/Basics/org/20210922181820-know_srch.org" "c:/Users/vguha/Downloads/officegit/Basics/org/20210922163826-issue2.org" "c:/Users/vguha/Downloads/officegit/Basics/org/20210922163025-issue1.org" "c:/Users/vguha/Downloads/officegit/Basics/org/KNOW-TCM.org" "c:/Users/vguha/Downloads/officegit/Basics/org/README.org" "c:/Users/vguha/Downloads/officegit/Basics/org/IRAT/GapNotes.org" "c:/Users/vguha/Downloads/officegit/Basics/org/SRCH/srch.org" "c:/Users/vguha/Downloads/officegit/Basics/org/References.org" "c:/Users/vguha/Downloads/personalgit/todo.org" "c:/Users/vguha/Downloads/officegit/Basics/org/office.org" "c:/Users/vguha/Downloads/personalgit/mylog.org" "c:/Users/vguha/Downloads/personalgit/finance.org"))
 '(package-selected-packages
   '(deft marginalia vertico org-pdfview org-noter-pdftools org-noter helm emacsql-sqlite3 melancholy-theme doom-themes spacemacs-theme org-roam color-theme-modern zenburn-theme ox-epub ox-reveal org-elp markdown-preview-mode markdown-preview-eww markdown-mode org-inline-pdf default-text-scale use-package flycheck-aspell flymake-grammarly org-tree-slide org-attach-screenshot org-preview-html org-easy-img-insert org-download impatient-showdown ## yasnippet)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;;;;; org - configs ;;;;;

;; This removes the schedule and deadline of DONE in the agenda
;; Otherwise the agenda gets kinda all greens DONE and reds, it helps in minimal look
(setq org-agenda-skip-scheduled-if-done 1)
(setq org-agenda-skip-deadline-if-done 1)
;;;;;;;;;;;;;;;;;;;;;;;;;


(setq org-agenda-custom-commands
      '(("p" "Agenda and Home-related tasks"
         ((agenda "")
          (tags-todo "Y21|APRIL21-T|G1")
          (tags-todo "FIN")
          (tags-todo "WORK")
          ))
        ("o" "Agenda and Office-related tasks"
         ((agenda "")
          (tags-todo "WORK")
          ))))

;; My other libraries

;; Markdown
(add-to-list 'load-path "c:/Users/vguha/Downloads/personalgit/emacs-init/packages")


(autoload 'markdown-mode "markdown-mode"
   "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

(autoload 'gfm-mode "markdown-mode"
   "Major mode for editing GitHub Flavored Markdown files" t)
(add-to-list 'auto-mode-alist '("README\\.md\\'" . gfm-mode))


(setq org-clock-persist 'history)
(org-clock-persistence-insinuate)

(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "https://elpa.gnu.org/packages/")))
(package-initialize)

(require 'org-download)

;; Drag-and-drop to `dired`
(add-hook 'dired-mode-hook 'org-download-enable)

;; test trial for org-screenshot
;; Note org-attach-screenshot didn't work for me.. not really what I need
(require 'org-attach-screenshot)

;; this worked like a charm
;; Go to org file and do M-x my-org-screenshot
;;
;; Slight differnce is - this commands opens the snipping tool.
;; So I have to go to org and then hit the command.
(defun my-org-screenshot ()
  "Take a screenshot into a time stamped unique-named file in the
   same directory as the org-buffer and insert a link to this file."  
   (interactive)
   (setq filename
     (concat
       (make-temp-name
         (concat (buffer-file-name)
              "_"
              (format-time-string "%Y%m%d_%H%M%S_")) ) ".png"))
   (shell-command "snippingtool /clip")
   (shell-command (concat "powershell -command \"Add-Type -AssemblyName System.Windows.Forms;if ($([System.Windows.Forms.Clipboard]::ContainsImage())) {$image = [System.Windows.Forms.Clipboard]::GetImage();[System.Drawing.Bitmap]$image.Save('" filename "',[System.Drawing.Imaging.ImageFormat]::Png); Write-Output 'clipboard content saved as file'} else {Write-Output 'clipboard does not contain image data'}\""))
   (insert (concat "[[file:" filename "]]"))
   (org-display-inline-images))

(defun my-org-screenshot2 ()
  "Take a screenshot into a time stamped unique-named file in the
   same directory as the org-buffer and insert a link to this file."  
   (interactive)
   (setq filename
     (concat
       (make-temp-name
         (concat (buffer-file-name)
              "_"
              (format-time-string "%Y%m%d_%H%M%S_")) ) ".png"))

   (shell-command (concat "powershell -command \"Add-Type -AssemblyName System.Windows.Forms;if ($([System.Windows.Forms.Clipboard]::ContainsImage())) {$image = [System.Windows.Forms.Clipboard]::GetImage();[System.Drawing.Bitmap]$image.Save('" filename "',[System.Drawing.Imaging.ImageFormat]::Png); Write-Output 'clipboard content saved as file'} else {Write-Output 'clipboard does not contain image data'}\""))
   (insert "#+ATTR_ORG: :width 500\n")
    (indent-for-tab-command)
   (insert (concat "[[file:" filename "]]"))
   (org-display-inline-images)
   (org-inline-pdf-mode))

;; Take snip
(global-set-key (kbd "<f10>") 'my-org-screenshot)
;; Already there in clipboard
(global-set-key (kbd "<f9>") 'my-org-screenshot2)

;; org-tree-slide
;; lets see how this works
(require 'org-tree-slide)
(require 'flycheck-aspell)

;; TODO install languagetools

;; ORG linking between files
(global-set-key (kbd "C-c l") 'org-store-link)
(global-set-key (kbd "C-c C-l") 'org-insert-link)

;;; for org-tree-slied
(require 'use-package)

(defun efs/presentation-setup ()
  ;; Hide the mode line
  ;;(hide-mode-line-mode 1)

  ;; Display images inline
  (org-display-inline-images) ;; Can also use org-startup-with-inline-images

  ;; Scale the text.  The next line is for basic scaling:
  (setq text-scale-mode-amount 3)
  (text-scale-mode 1)
  )

  ;; This option is more advanced, allows you to scale other faces too
  ;; (setq-local face-remapping-alist '((default (:height 2.0) variable-pitch)
  ;;                                    (org-verbatim (:height 1.75) org-verbatim)
  ;;                                    (org-block (:height 1.25) org-block))))

(defun efs/presentation-end ()
  ;; Show the mode line again
  ;;(hide-mode-line-mode 0)

  ;; Turn off text scale mode (or use the next line if you didn't use text-scale-mode)
  ;; (text-scale-mode 0))

  ;; If you use face-remapping-alist, this clears the scaling:
  (setq-local face-remapping-alist '((default variable-pitch default)))
  (text-scale-mode 0)
  )

(use-package org-tree-slide
  :hook ((org-tree-slide-play . efs/presentation-setup)
         (org-tree-slide-stop . efs/presentation-end))
  :custom
  (org-tree-slide-slide-in-effect t)
  (org-tree-slide-activate-message "Presentation started!")
  (org-tree-slide-deactivate-message "Presentation finished!")
  (org-tree-slide-header t)
  (org-tree-slide-breadcrumbs " > ")
  (org-image-actual-width nil))


;;; ---------------------------
;;; theme
;; (load-theme 'zenburn t)
;; use variable-pitch fonts for some headings and titles
;; (setq zenburn-use-variable-pitch t)

;; scale headings in org-mode
;; (setq zenburn-scale-org-headlines t)



;; scale headings in outline-mode
;; (setq zenburn-scale-outline-headlines t)
;; (load-theme 'aliceblue t t)
;; (enable-theme 'aliceblue)

;;; set the background as I am finding the contrast of
;;; over blue very difficult
;(set-background-color "white")

;; == Windows == OS specific ==
(use-package emacsql-sqlite3
  :ensure t
  :init
  (add-to-list 'exec-path "c:/Users/vguha/Downloads/emacs-27.1-x86_64/bin")
)



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
(global-set-key "\C-cc" 'org-capture)
(global-set-key (kbd "<f11>") 'turn-headline-into-org-mode-link)
(global-set-key (kbd "<f12>") 'buffer-kill-path)
(global-set-key "\C-cnf" 'org-roam-node-find)
(global-set-key "\C-cni" 'org-roam-node-insert)
(global-set-key "\C-cnl" 'org-roam-buffer-toggle)




(require 'ob-plantuml)
(org-babel-do-load-languages
 'org-babel-load-languages
 '((emacs-lisp . t)
   (plantuml . t)
   (python . t)))


(setq-default frame-title-format
              '(:eval
                (format ">> %s %s"
                        (buffer-name)
                        (cond
                         (buffer-file-truename
                          (concat "(" buffer-file-truename ")"))
                         (dired-directory
                          (concat "{" dired-directory "}"))
                         (t
                          "[no file]")))))

(use-package helm :ensure t :config (helm-mode))

(use-package org-roam
  :init
  (setq org-roam-v2-ack t)
  (setq dw/daily-note-filename "%<%Y-%m-%d>.org"
        dw/daily-note-header "#+title: %<%Y-%m-%d %a>\n\n[[roam:%<%Y-%B>]]\n\n"
        vg/misc "%<%Y-%m-%d>.org"
        vg/notes-header "#+title: %<%Y-%m-%d %a>\n\n#+roam_tags: all misc agenda\n\n\n")
  :custom
  (org-roam-directory "c:/Users/vguha/Downloads/officegit/Basics/org")
  (org-roam-dailies-directory "Journal/")
  (org-roam-completion-everywhere t)
  (org-roam-capture-templates
    '(("d" "default" plain "%?"
       :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org"
                          "#+title: ${title}\n")
       :unnarrowed t)
      ("i" "issue" entry
       "* TODO <ISSUE> %?\n  %T\n  %a\n  %i"
       :if-new (file+head  "%<%Y%m%d%H%M%S>-${slug}.org"
                           "#+title: ${title}\n#+roam_tags: ISSUE agenda\n#+filetags: ISSUE agenda\n#+category: ${title}")
       :unnarrowed t)
      ("g" "IRAT" entry
       "* TODO <IRAT> %?\n  %T\n  %a\n  %i"
       :if-new (file+head  "%<%Y%m%d%H%M%S>-${slug}.org"
                           "#+title: ${title}\n#+roam_tags: IRAT agenda\n#+filetags: IRAT agenda\n#+category: ${title}")
       :unnarrowed t)
      ("d" "DENC" entry
       "* TODO <DENC> %?\n  %T\n  %a\n  %i"
       :if-new (file+head  "%<%Y%m%d%H%M%S>-${slug}.org"
                           "#+title: ${title}\n#+roam_tags: DENC agenda\n#+filetags: DENC agenda\n#+category: ${title}")
       :unnarrowed t)
       ("k" "knowledge" entry
       "* TODO <KNOW> %?\n  %T\n  %a\n  %i"
       :if-new (file+head  "%<%Y%m%d%H%M%S>-${slug}.org"
                           "#+title: ${title}\n#+roam_tags: KNOW agenda\n#+filetags: KNOW agenda\n#+category: ${title}")
       :unnarrowed t)        
      ("m" "MISC" entry
       "** TODO %?\n    SCHEDULED %T\n  %a\n  %i"
       :if-new (file+head+olp  "%<%Y>.org"
                                "#+title: ${title}\n#+roam_tags: KNOW agenda\n#+filetags: KNOW agenda\n#+category: ${title}"
                               ("Notes"))
       :empty-lines 1)
      ("h" "HOME" entry
       "* TODO <HOME> %?\n  %T\n  %a\n  %i"
       :if-new (file+head  "%<%Y%m%d%H%M%S>-${slug}.org"
                           "#+title: ${title}\n#+roam_tags: MISC agenda\n#+filetags: MISC agenda\n#+category: ${title}")
       :unnarrowed t)       
    ))
  (org-roam-dailies-capture-templates
   `(("d" "default" entry
      "* %?"
      :if-new (file+head ,dw/daily-note-filename
                         ,dw/daily-note-header))
     ("t" "task" entry
      "* TODO %?\n  %U\n  %a\n  %i"
      :if-new (file+head+olp ,dw/daily-note-filename
                             ,dw/daily-note-header
                             ("Tasks"))
      :empty-lines 1)
     ("l" "log entry" entry
      "* %<%I:%M %p> - %?"
      :if-new (file+head+olp ,dw/daily-note-filename
                             ,dw/daily-note-header
                             ("Log")))
     ("j" "journal" entry
      "* %<%I:%M %p> - Journal  :journal:\n\n%?\n\n"
      :if-new (file+head+olp ,dw/daily-note-filename
                             ,dw/daily-note-header
                             ("Log")))
     ("m" "meeting" entry
      "* %<%I:%M %p> - %^{Meeting Title}  :meetings:\n\n%?\n\n"
      :if-new (file+head+olp ,dw/daily-note-filename
                             ,dw/daily-note-header
                             ("Log")))))
  :bind (("C-c n l"   . org-roam-buffer-toggle)
         ("C-c n f"   . org-roam-node-find)
         ("C-c n d"   . org-roam-dailies-find-date)
         ("C-c n c"   . org-roam-dailies-capture-today)
         ("C-c n C r" . org-roam-dailies-capture-tomorrow)
         ("C-c n t"   . org-roam-dailies-goto-today)
         ("C-c n y"   . org-roam-dailies-goto-yesterday)
         ("C-c n r"   . org-roam-dailies-goto-tomorrow)
         ("C-c n g"   . org-roam-graph)
         :map org-mode-map
         (("C-c n i" . org-roam-node-insert)
          ;("C-c n I" . org-roam-insert-immediate)
          ))
  :config
  (org-roam-db-autosync-mode))

;; PDF Tools
(use-package pdf-tools
  :ensure t
  :config
  (pdf-tools-install))


(use-package vertico
  :ensure t
  :bind (:map vertico-map
         ("C-j" . vertico-next)
         ("C-k" . vertico-previous)
         ("C-f" . vertico-exit)
         :map minibuffer-local-map
         ("M-h" . backward-kill-word))
  :custom
  (vertico-cycle t)
  :init
  (vertico-mode))

(use-package savehist
  :init
  (savehist-mode))

(use-package marginalia
  :after vertico
  :ensure t
  :custom
  (marginalia-annotators '(marginalia-annotators-heavy marginalia-annotators-light nil))
  :init
  (marginalia-mode))



(use-package deft
  :config
  (setq deft-directory "c:/Users/vguha/Downloads/officegit/Basics/org"
        deft-recursive t
        deft-strip-summary-regexp ":PROPERTIES:\n\\(.+\n\\)+:END:\n"
        deft-extensions '("md" "org")
        deft-use-filename-as-title t)
  :bind
  ("C-c n d" . deft))

