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
a problem because I use evil mode)"
  (insert (concat (demo-it-insert command speed)))
  (eshell-send-input))

(defun my-demo/eshell-exit ()
  "Exit the eshell I've been using"
  (insert (concat "exit"))
  (eshell-send-input)
  (demo-it-presentation-return-noadvance))

(defun my-demo/show-code (file)
  "Helper demo function that displays some source code"
  (demo-it-load-file file :right 1 90)
  (nlinum-mode -1)
  (evil-insert 1))

(defun my-demo/demo-it-presentation (file)
  "I want it to always disable nlinum at the start of the presentation"
  (demo-it-presentation file)
  (set-fill-column 70)
  (nlinum-mode -1)
  (demo-it-presentation-advance))

(defun my-demo/demo-it-title-sreen (file)
  "I want to disable nlinum on the title screen"
  (demo-it-title-screen file)
  (nlinum-mode -1))

;; Order the functions and forms for this presentation:
(demo-it-create :advance-mode :insert-fast :variable-width :windows-on-right :text-large :use-shell :fullscreen :hide-block-headers :hide-org-markers
                (my-demo/demo-it-title-sreen "test.org")
                (my-demo/demo-it-presentation "test.org")

                demo-it-presentation-advance

                (my-demo/show-code "novo.el")

                                        ; Start coding an elisp function
                (demo-it-insert "def")       ; Begin yasnippet template
                "TAB"                        ; Trigger yasnippet
                (demo-it-insert "some-func") ; The function name
                "TAB"                        ; Advance to parameters
                (demo-it-insert "x y")       ; parameters
                "TAB"                        ; Advance to parameters
                (demo-it-insert "Example function.")
                "TAB"                        ; Advance to interactive
                (demo-it-insert " ")         ; No need for this section
                "TAB"                        ; Advance to function body

                demo-it-presentation-return ; close file and advance

                                        ; Highlight the word init with yellow and remove all highlighting after
                                        ;(demo-it-presentation-highlight-phrase "init" :hi-yellow)
                                        ;demo-it-presentation-unhighlight-all

                                        ;(demo-it-show-image "~/Pictures/Wallpapers/death_of_socrates.png" :below -1 20)

                (my-demo/eshell-start "~" "Git Example" 30)
                (my-demo/eshell-command "ls" :instant)
                (my-demo/eshell-command "echo $EDITOR" :fast)
                (my-demo/eshell-exit)

                (find-file "~/alo.el")
                (demo-it-message-keybinding "C-x C-f" "find-file"))

(demo-it-start)
