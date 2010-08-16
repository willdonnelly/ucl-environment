#!r6rs
(library (ucl environment)
  (export getenv setenv unsetenv)
  (import (rnrs) (ucl ffi))

  (define libc (load-library "libc.so.6" "libc.so"))

  (define raw-getenv   (get-function libc "getenv"   '(string) 'pointer))
  (define raw-setenv   (get-function libc "setenv"   '(string string sint) 'sint))
  (define raw-unsetenv (get-function libc "unsetenv" '(string) 'sint))

  (define (getenv name)
    (let ((ptr (raw-getenv name)))
      (if (equal? (pointer->integer ptr) 0)
          #f
          (string-read ptr))))

  (define (setenv name val overwrite)
    (when (<= (string-length name) 0)
      (error 'setenv "name string is empty"))
    (unless (zero? (raw-setenv name val (if overwrite 1 0)))
      (error 'setenv "failed to set environment variable")))

  (define (unsetenv name)
    (when (<= (string-length name) 0)
      (error 'unsetenv "name string is empty"))
    (unless (zero? (raw-unsetenv name))
      (error 'unsetenv "failed to unset environment variable")))
)
