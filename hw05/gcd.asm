;;=============================================================
;; CS 2110 - Spring 2021
;; Homework 5 - Iterative GCD
;;=============================================================
;; Name: Jimin Sun
;;=============================================================

;; Pseudocode (see PDF for explanation):
;;
;; a = (argument 1);
;; b = (argument 2);
;; ANSWER = 0;
;;
;; while (a != b) {
;;   if (a > b) {
;;     a = a - b;
;;   } else {
;;     b = b - a;
;;   }
;; }
;; ANSWER = a;

.orig x3000

;; put your code here
; R0 = answer
AND R0, R0, 0
; LOAD A, B
LD R1, A
LD R2, B

LOOP ;start while loop

; BREAK IF A - B == 0
NOT R3, R2 
ADD R3, R3, #1 ;R3 = -B
ADD R4, R1, R3 ; R4 = A-B


BRz ENDWHILE ;if A-B == 0, break

BRnz ELSE; A-B <= 0, then else
ADD R1, R1, R3 ; a = a - b

BRnzp END ;skip past else

ELSE ADD R5, R1, #0
NOT R5, R5
ADD R5, R5, #1
ADD R2, R2, R5 ; b = b - a
     
END

BR LOOP;branch back to while

ENDWHILE
ADD R0, R1, 0
ST R0, ANSWER


HALT

A .fill 20
B .fill 19

ANSWER .blkw 1

.end
