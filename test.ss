#!r6rs
(import (rnrs) (ucl environment) (ucl process))

(assert (equal? (getenv "HOME") (shell "echo $HOME")))

(assert (not (getenv "FOOBAR")))
(setenv "FOOBAR" "a" #f)
(assert (equal? "a" (getenv "FOOBAR")))
(setenv "FOOBAR" "b" #f)
(assert (equal? "a" (getenv "FOOBAR")))
(setenv "FOOBAR" "c" #t)
(assert (equal? "c" (getenv "FOOBAR")))
(unsetenv "FOOBAR")
(assert (not (getenv "FOOBAR")))

(display "success\n")
