(defsystem "resume-builder"
  :version "0.1.0"
  :author "Michael Olson"
  :license "MIT"
  :depends-on ("mito")
  :components ((:module "src"
                :components
                ((:file "main"))))
  :description "Build a resume using latex, a job description, and a skill database"
  :in-order-to ((test-op (test-op "resume-builder/tests"))))

(defsystem "resume-builder/tests"
  :author "Michael Olson"
  :license "MIT"
  :depends-on ("resume-builder"
               "rove")
  :components ((:module "tests"
                :components
                ((:file "main"))))
  :description "Test system for resume-builder"
  :perform (test-op (op c) (symbol-call :rove :run c)))
