(library-directories "~/thunderchez")
(import (chezscheme))
(import (irregex))
(import (ffi-utils))
(define cffi "c2ffi")

;;;TODO
;;;Structure definitions
;;;Function definitions
;;;Expand type conversions
;;;Lispify names (i.e. replace _ with -)
;;;also lowercase everything

;;;Doneish
;;;Enum definitions
;;;Basic type definitions

(define-ftype uint8 unsigned-8)
(define-ftype uint16 unsigned-16)
(define-ftype sint16 integer-16)
(define-ftype uint32 unsigned-32)
(define-ftype sint32 integer-32)
(define-ftype sint64 integer-64)
(define-ftype uint64 integer-64)
(define-ftype size-t uint32)
(define-ftype file (struct))
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
  
(define (typedef-false-filter x)
  (filter (lambda (k) (not (and (not (list? k)) (symbol=? 'nope k))))
	  x))

(define (produce-cffi-types pathname)   
  (let*
      ((data (get-cffi-types pathname))
       (typedefs (filter-symbol data 'typedef))
       (structs  (filter-symbol data 'struct))
       (enums    (filter-symbol data 'enum))
       (funcs    (filter-symbol data 'function))
       (dahs (make-hash-table)))
    (process-enums enums dahs)
    (process-structs structs dahs)
    (typedef-false-filter (process-typedefs typedefs dahs))))

(define (process-enums enums dahs)
  (map (lambda (c) (put-hash-table! dahs (caddr c)
				    (cdddr c)))
       enums))

(define (process-structs structs dahs)
  (map (lambda (c) (put-hash-table! dahs (cadr c)
				    (cddr c)))
       structs))

(define (typedef-name x)
  (cadr x))

(define (typedef-args x)
  (cddr x))

(define (process-typedefs typedef dahs)
  (map (lambda (c) (process-indi c dahs))
       typedef))

(define (process-final-enum name args dahs)
  (let ((datalst (get-hash-table dahs args 0)))
    `(define-enumeration* ,name ,(map (lambda (k)
					(car k)) datalst))))

;;;Fix this idiot :P
(define (process-indi typedef dahs)
  (let ((name (typedef-name typedef))
	(args (typedef-args typedef)))
    (if (not (equal? 0 (get-hash-table dahs name 0)))
	'nope
	(let ((evaled (charlie-arg-eval args)))
	  (cond
	   ((and (not (= (length evaled) 1))
		 (charlie-sym? "eval-enum"  (car evaled)))
	    (process-final-enum name (cadr evaled) dahs))
	       (else
		`(define-ftype ,name ,(car evaled))))))))


(define (charlie-arg-eval args)
  (cond
   ((null? args) '())
   ((list? (car args))
    (append (charlie-list-eval (car args))
	    (charlie-arg-eval (cdr args))))
   ((charlie-sym? ":function-pointer" (car args))
    (cons `void* (charlie-arg-eval (cdr args))))
   (else
    (cons (string->symbol (charlie-string-cut (symbol->string (car args))))
	  (charlie-arg-eval (cdr args))))))

(define (charlie-list-eval arg)
  (cond
   ((charlie-sym? ":enum" (car arg))
    `(eval-enum ,(caddr arg)))
   ((or (charlie-sym? ":struct" (car arg))
	(charlie-sym? "struct" (car arg)))
    (cond
     ((>= 2 (length arg))
      `((struct)))
     (else
      `((struct)))))
   (else
    `(unsupported!))))
   
(define (charlie-string-cut x)
  (if (string=? ":" (substring x 0 1))
      (string-downcase (substring x 1 (string-length x)))
      (string-downcase x)))
