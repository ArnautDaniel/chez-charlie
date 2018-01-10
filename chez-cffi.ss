(library-directories "~/thunderchez")
(import (chezscheme))
(import (irregex))
(import (ffi-utils))
(define cffi "c2ffi")

;;;Generate our sexps
(define (gen-cffi-sexp pathname output-name)
  (if (string? pathname)
      (system (string-append cffi " " pathname " -D sexp -o "
			     output-name ".sexp"))))
      
;;;

(define (get-cffi-types pathname)
  (let ((file (open-input-file pathname)))
    (let looper ((data (get-line file)))
      (cond
       ((eof-object? data) (begin
			     (close-input-port file)
			     '()))
       ((irregex-match-data? (irregex-search
			      "SDL_mixer" data))
	(begin
	  (cons (read file)
	  (looper (get-line file)))))
       (else
	(looper (get-line file)))))))

(define (filter-symbol lst sym)
  (filter (lambda (x) (symbol=? (car x) sym)) lst))

(define (arguments-for-typedef x)
  (caddr x))

(define (charlie-sym? str sym)
  (if (atom? sym)
      (symbol=? (string->symbol str) sym)
      #f))
  

(define (charlie-eval-args args)
  (cond
   ((charlie-sym? ":function-pointer" args)
    `*void)
   ((charlie-sym? ":enum" (car args))
    `uint16)
   ((or (charlie-sym? "struct" (car args))
	(charlie-sym? ":struct" (car args)))
    `(struct))))
  
(define (charlie-typedef-eval tpd)
  (let ((args (arguments-for-typedef tpd)))
    (cond
     ((and (not (charlie-sym? ":function-pointer" args))
	   (atom? args) tpd))
     (else
      `(define-ftype ,(cadr tpd) ,(charlie-eval-args args))))))

(define (charlie-struct-eval args)
  (let  ((name (cadr args))
         (data (cddr args)))
    `(define-ftype ,name ,(map (lambda (c) (charlie-convert-struct-args c))
                               data))))

(define (charlie-convert-struct-args datu)
  (cond
   ((and (list? (cadr datu)) (charlie-sym? ":pointer" (car (cadr datu))))
    `(,(car datu) ,(string->symbol (charlie-string-cut (symbol->string (cadr (cadr datu)))))))
   (else
    `(,(car datu) ,(string->symbol (charlie-string-cut (symbol->string (cadr datu))))))))

(define (produce-cffi-types pathname)     
  (let*
      ((data (get-cffi-types pathname))
       (typedefs (filter-symbol data 'typedef))
       (structs  (filter-symbol data 'struct))
       (enums    (filter-symbol data 'enum))
       (funcs    (filter-symbol data 'function)))
    (list (map charlie-typedef-eval typedefs)
          (map charlie-struct-eval structs))))
  
(define (enum-id enum-sexp)
  (caddr enum-sexp))  

(define (charlie-string-cut x)
  (if (string=? ":" (substring x 0 1))
      (string-downcase (substring x 1 (string-length x)))
      (string-downcase x)))
