(defun insert-line-below ()
  "Insert line below the cursor without moving it."
  (interactive)
  (let ((current-point (point)))
    (move-end-of-line 1)
    (open-line 1)
    (goto-char current-point)))
;; Podemos avaliar uma função com "C-M-x"

(defun insert-line-above ()
  "Insert line above the cursor without moving it"
  (interactive)
  (let ((current-point (point)))
    (move-beggining-of-line 1)
    (newline-and-indent)
    (indent-according-to-mode)
    (goto-char current-point)
    (forward-char)))
;; Ou avaliamos a expressão antes do cursor com "C-x C-e"

(global-set-key (kbd "C-S-n") 'insert-line-below)
(global-set-key (kbd "C-S-o") 'insert-line-above)






;; Linha de testes 1
;; Linha de testes 2

;; Linha de testes 3

;; Linha de testes 4
;; Linha de testes 5
