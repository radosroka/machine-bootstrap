;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

(setq user-full-name "Radovan Sroka"
      user-mail-address "radovan.sroka@gmail.com")

(setq doom-theme 'doom-one)

(setq display-line-numbers-type t)

(setq org-directory "~/org/")

(use-package! ellama
  :init
  (require 'llm-ollama)
  (setopt ellama-provider
          (make-llm-ollama
           :chat-model "llama3"
           :embedding-model "nomic-embed-text")))

(map! :leader
      (:prefix ("l" . "llm")
       ;; Chat
       :desc "Chat"                    "c" #'ellama-chat
       :desc "Ask about region"        "a" #'ellama-ask-about
       :desc "Ask selection"           "s" #'ellama-ask-selection

       ;; Code
       :desc "Code complete"           "C" #'ellama-code-complete
       :desc "Code add"                "A" #'ellama-code-add
       :desc "Code edit"               "e" #'ellama-code-edit
       :desc "Code review"             "r" #'ellama-code-review
       :desc "Improve code"            "i" #'ellama-improve-code

       ;; Text
       :desc "Summarize"               "S" #'ellama-summarize
       :desc "Improve writing"         "w" #'ellama-improve-wording
       :desc "Fix grammar"             "g" #'ellama-improve-grammar
       :desc "Translate"               "t" #'ellama-translate))
