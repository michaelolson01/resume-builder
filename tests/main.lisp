(defpackage resume-builder/tests/main
  (:use :cl
        :resume-builder
        :rove))
(in-package :resume-builder/tests/main)

;; NOTE: To run this test file, execute `(asdf:test-system :resume-builder)' in your Lisp.

(deftest test-target-1
  (testing "should (= 1 1) to be true"
    (ok (= 1 1))))
