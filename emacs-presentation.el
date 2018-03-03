(require 'demo-it)

(defun my-demo/eshell-start (dir name height)
  "The demo-it way of opening up an eshell is not working for me (probably
because I use evil inside eshell) so I created this helper function to launch an
eshell instance."
  "!"
  (demo-it-hide-mode-line)
  (split-window-vertically height)
  (other-window 1)
  (eshell "new")
  (rename-buffer (concat "*Shell: " name "*"))
  (insert (concat "cd " dir))
  (eshell-send-input))

(defun my-demo/eshell-command (command speed)
  "Just to make it easier to write a command on the eshell (again, it is kind of
a problem because I use evil mode)."
  (insert (concat (demo-it-insert command speed)))
  (eshell-send-input))

(defun my-demo/eshell-exit ()
  "Exit the eshell I've been using."
  (insert (concat "exit"))
  (eshell-send-input)
  (demo-it-presentation-return-noadvance))

(defun my-demo/show-code (file)
  "Helper demo function that displays some source code."
  (demo-it-load-file file :right 1 80)
  (nlinum-mode -1)
  (evil-insert 1))

(defun my-demo/show-image (file side size width)
  "Helper function to remove nlinum from the image preview."
  (demo-it-show-image file side size width)
  (nlinum-mode -1))

(defun my-demo/blank-yasnippet ()
  "Insert a space than delete it."
  (demo-it-insert " ")
  (backward-delete-char 1))

(defun my-demo/show-eval-commands ()
  "A function to show the two different eval commands."
  (goto-line 8)
  (demo-it-insert ";; Podemos avaliar uma função com \"C-M-x\"\n")
  (goto-line 19)
  (demo-it-insert ";; Ou avaliamos a expressão antes do cursor com \"C-x C-e\"\n")
  (goto-line 5)
  (evil-normal-state)
  (evil-end-of-line))

(defun my-demo/goto-line-and-move-to-end (line)
  "What the name says."
  (goto-line line)
  (evil-end-of-line))

(defun my-demo/demo-it-presentation (file)
  "I want it to always disable nlinum at the start of the presentation"
  (demo-it-presentation file)
  (set-fill-column 60)
  (nlinum-mode -1)
  (flycheck-mode -1)
  (demo-it-presentation-advance))

(defun my-demo/demo-it-title-sreen (file)
  "I want to disable nlinum on the title screen"
  (demo-it-title-screen file)
  (nlinum-mode -1))

(setq org-tree-slide-header	nil
      org-tree-slide-slide-in-effect t
      org-tree-slide-cursor-init t
      org-tree-slide-heading-emphasis	t)

;; Order the functions and forms for this presentation:
(demo-it-create :advance-mode :insert-quickly :variable-width :windows-on-right :text-xx-large :use-shell :fullscreen :hide-block-headers :hide-org-markers
                (my-demo/demo-it-title-sreen "emacs-presentation.org")
                (my-demo/demo-it-presentation "emacs-presentation.org")

                (demo-it-presentation-advance)
                (demo-it-presentation-advance)
                (demo-it-presentation-advance)

                (my-demo/show-code "presentation.el")

                ;; Start coding an elisp function
                (demo-it-insert "def")       ; Begin yasnippet template
                "TAB"                        ; Trigger yasnippet
                (demo-it-insert "insert-line-below") ; The function name
                "TAB"                        ; Advance to parameters
                (my-demo/blank-yasnippet)
                "TAB"                        ; Advance to parameters
                (demo-it-insert "Insert line below the cursor without moving it.")
                "TAB"
                "TAB"
                (my-demo/blank-yasnippet)
                "TAB"                        ; Advance to function body
                (demo-it-insert "(let ((current-point (point)))\n(move-end-of-line 1)\n(open-line 1)\n(goto-char current-point))")

                (forward-char)
                (demo-it-insert "\n\n")

                (demo-it-insert "(defun insert-line-above ()\n\"Insert line above the cursor without moving it\"\n(interactive)\n(let ((current-point (point)))\n(move-beggining-of-line 1)\n(newline-and-indent)\n(indent-according-to-mode)\n(goto-char current-point)\n(forward-char)))\n\n")

                (demo-it-insert "(global-set-key (kbd \"C-S-n\") 'insert-line-below)\n")
                (demo-it-insert "(global-set-key (kbd \"C-S-o\") 'insert-line-above)\n\n\n\n\n\n\n")

                (demo-it-insert ";; Linha de testes 1\n;; Linha de testes 2\n;; Linha de testes 3\n;; Linha de testes 4\n;; Linha de testes 5\n")

                (my-demo/show-eval-commands)

                (my-demo/goto-line-and-move-to-end 18)

                (my-demo/goto-line-and-move-to-end 21)
                "C-x C-e"
                (my-demo/goto-line-and-move-to-end 22)
                "C-x C-e"

                (my-demo/goto-line-and-move-to-end 31)

                "C-S-o"
                "C-S-n"

                (demo-it-presentation-return) ; close file and advance

                (my-demo/eshell-start "~" "Eshell Example" 30)
                (my-demo/eshell-command "ls" :instant)
                (my-demo/eshell-command "ls -la | grep emacs" :fast)
                (my-demo/eshell-command "alias l 'ls -l'" :instant)
                (my-demo/eshell-exit)

                (demo-it-presentation-advance)

                (magit)

                (demo-it-presentation-return)

                (evil-next-line 4)
                (evil-append-line 1)

                "TAB"

                (demo-it-insert "*negrito*, " :fast)
                (demo-it-insert "/itálico/, " :fast)
                (demo-it-insert "=verbatim=, " :fast)
                (demo-it-insert "+striketrough+" :fast)

                (evil-next-line 5)

                "TAB"

                (demo-it-insert "+ Listas não ordenadas\n" :fast)
                "TAB"
                (demo-it-insert "- Pode ser feito com qualquer um\n" :fast)
                "TAB"
                (demo-it-insert "* Desses três caracteres + ou - ou *" :fast)

                (demo-it-presentation-advance)

                (evil-next-line 4)
                (evil-append-line 1)
                "TAB"

                (demo-it-insert "[[file:~/.emacs.d/init.org::*General configuration][Links to other files]]" :fast)

                (demo-it-presentation-advance)

                (demo-it-presentation-advance)

                (demo-it-presentation-advance)

                (demo-it-presentation-advance))

(demo-it-start)

(provide 'emacs-presentation)
;;; emacs-presentation.el ends here
