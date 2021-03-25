
;- Procedure: symbol-length

(define symbol-length
    (lambda (inSym)
        (if (symbol? inSym)
            (string-length (symbol->string inSym))
            0
        )
    )
)

;- Procedure: sequence?

(define sequence?
    (lambda (inSeq) 
        (if (not (null? inSeq)) 
            (if (= (symbol-length (car inSeq)) 1)
                (sequence? (cdr inSeq)) 
                #f
            
            )
            #t
        )
    )
)  

;- Procedure: same-sequence?

(define same-sequence?
    (lambda (inSeq1 inSeq2)
        (if ( and (sequence? inSeq1)  (sequence? inSeq2) )
               
                ( if(not (equal? inSeq1 inSeq2))
                #f
                #t
                )
            
            
            (error " Sequence1 and Sequence2 are not identical")
        )
    )
)


;- Procedure: reverse-sequence

(define reverse-sequence
    (lambda (inSeq)
        (if (sequence? inSeq)
            (if (null? inSeq)
            '()
            (append (reverse-sequence (cdr inSeq) ) (list (car inSeq) ) ))
            (error "The sequence is not a proper sequence" )
        )
    )
)

;- Procedure: palindrome?

(define palindrome?
    (lambda (inSeq)
        (if (sequence? inSeq) 
            (if (same-sequence? (reverse-sequence inSeq) inSeq) 
                #t
                #f
            )
        (error "The sequence is not a sequence and a palindrome")
        )
    )
)

;- Procedure: member?

(define member?
    (lambda (inSym inSeq)
            (if (and (sequence? inSeq) (symbol? inSym))
             (if( not(null? inSeq))
                 
                (if(equal?(car inSeq) inSym)
                    #t
                    (member? inSym (cdr inSeq))
                )

                #f
            )
        (error "The sequence is not a sequence and/or the symbol is not a symbol.")
            
        )
    )
)

;- Procedure: remove-member

(define remove-member
    (lambda (inSym inSeq)

        ( if (and (sequence? inSeq) (symbol? inSym) (member? inSym inSeq))
                (if (equal? inSym (car inSeq))
                (cdr inSeq)
                (cons (car inSeq) (remove-member inSym (cdr inSeq)))
                )
            
            (error "The sequence does not have the symbol, symbol couldn't removed.")
        )
    )
)
        

;- Procedure: anagram?

(define anagram?
    (lambda (inSeq1 inSeq2)
        (if (and (sequence? inSeq1) (sequence? inSeq2))

           (if( not ( and (null? inSeq1) (null? inSeq2)))
        
                    (if (not (member? (car inSeq1) inSeq2) )
                        #f
                        (anagram? (remove-member (car inSeq1) inSeq2) (remove-member (car inSeq1) inSeq1)) 
                    )
            #t
           )
            
            (error "Sequence 1 and/or Sequence 2 is not a proper sequence." )
        )    
    )
)

;- Procedure: anapoli?

(define anapoli?
    (lambda (inSeq1 inSeq2) 
        (if (and (sequence? inSeq1) (sequence? inSeq2)) 
            (if (palindrome? inSeq2)
                (if (anagram? inSeq1 inSeq2)
                    #t
                    #f
                )
                #f 
            )
        (error "Sequence 1 and/or Sequence 2 are not proper sequences hence sequence 1 can't be an anapoli." )   
        )
    )
)

(sequence? '(a b c)) 
(sequence? '()) 
(sequence? '(aa b c)) 
(sequence? '(a 1 c)) 
(sequence? '(a (b c)))  
(same-sequence? '(aa b) '(a b c))
(member? 'd '(aa b c))