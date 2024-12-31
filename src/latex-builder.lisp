(in-package :resume-builder)

(defun latex-header ()
  "The header text for the latex document (not the resume itself)"
  (format t "\\documentclass{article}~%"))
