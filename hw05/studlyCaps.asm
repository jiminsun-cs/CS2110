;;=============================================================
;; CS 2110 - Fall 2021
;; Homework 5 - Studly Caps!
;;=============================================================
;; Name: Jimin Sun
;;=============================================================

;; Pseudocode (see PDF for explanation)
;;
;; string = "TWENTY 1 ten";
;; i = 0;
;; while (string[i] != 0) {
;;   if (i % 2 == 0) {
;;   // should be lowercase
;;     if ('A' <= string[i] <= 'Z') {
;;       string[i] = string[i] | 32;
;;     }
;;   } else {
;;   // should be uppercase
;;     if ('a' <= string[i] <= 'z') {
;;       string[i] = string[i] & ~32;
;;     }
;;   }

;; ELSEOUT

;;   i++;
;; }

.orig x3000

;; put your code here


AND R0, R0, 1
LD R0, STRING ; R0 = STRING
AND R1, R1, 0 ; R1 = i
AND R2, R2, 0
AND R3, R3, 0

LOOP
;; while (string[i] != 0) {
	
	ADD R2, R0, R1 ; R2 = i + string
	LDR R3, R2, #0 ; R3 = string[I]
	BRz ENDLOOP
	
	;;   if (i % 2 == 0) {

	AND R2, R2, 0 ; clear R2
	AND R2, R1, 1 ; R2 = R1 & 1 - if R2 is zero, then it is multiple of 2
	BRnp ELSE

	;;     if ('A' <= string[i] <= 'Z') {
	AND R2, R2, 0 ; clear R2
	LD R2, UPPERA ; R2 = UPPERA
	AND R4, R4, 0 ; clear R4
	LD R4, UPPERZ ; R4 = UPPERZ

	;; R3 = string[I]
	AND R5, R5, 0
	AND R6, R6, 0
	ADD R5, R3, 0
	NOT R5, R5
	ADD R5, R5, 1 ; R5 = -string[I]
	ADD R6, R5, R2 ; R6 = UPPERA - string[I]
	BRp ELSEOUT

	AND R5, R5, 0
	AND R6, R6, 0
	ADD R5, R4, 0
	NOT R5, R5
	ADD R5, R5, 1 ; R5 = -Z
	ADD R6, R5, R3 ; R6 = string[I] - Z
	BRp ELSEOUT	

	
;;       string[i] = string[i] | 32;
	AND R4, R4, 0
	AND R5, R5, 0
	AND R6, R6, 0
	AND R7, R7, 0

	ADD R7, R7, #15
	ADD R7, R7, #15
	ADD R7, R7, #2


	AND R4, R3, R7 ; R4 = R3 % 32 -> if this is zero, go to ADDTHIRTYTWO
	BRz ADDTHIRTYTWO
	
	ADDTHIRTYTWO ;;;;;;;;;;;
	ADD R5, R3, R7 ; R5 = string[I] + 32
	;;store it back to string[I] address
	AND R2, R2, 0 ; clear R2 / R0 = String, R1 = I
	ADD R2, R0, R1 ; R2 = string+I
	STR R5, R2, #0 ; store R5 to add at str+I
	BRnzp ELSEOUT ;;;;;;;;;;;

	;; return same
	AND R2, R2, 0 ; clear R2 / R0 = String, R1 = I
	ADD R2, R0, R1 ; R2 = string+I
	STR R3, R2, #0
	BRnzp ELSEOUT
	


	ELSE
;;   } else {
	AND R5, R5, 0
	AND R6, R6, 0
	AND R7, R7, 0 
	;; if (’a’ <= string[i] <= ’z’) {
	AND R2, R2, 0 ; clear R2
	LD R2, LOWERA ; R2 = LOWERA
	AND R4, R4, 0 ; clear R4
	LD R4, LOWERZ ; R4 = LOWERZ

	;; R3 = string[I]
	NOT R5, R3
	ADD R5, R5, 1 ; R5 = -string[I]
	ADD R6, R5, R2 ; R6 = LOWERA - string[I]
	BRp ELSEOUT

	AND R5, R5, 0
	AND R6, R6, 0
	NOT R5, R4
	ADD R5, R5, 1 ; R5 = -z
	ADD R6, R5, R3 ; R6 = string[I] - z
	BRp ELSEOUT	

;;       string[i] = string[i] & ~32;
	AND R4, R4, 0
	AND R5, R5, 0
	AND R6, R6, 0
	AND R7, R7, 0
	;; R3 = string[I]
	ADD R7, R7, #15
	ADD R7, R7, #15
	ADD R7, R7, #2
	
	NOT R7, R7 ; ~32
	
	AND R4, R3, R7 ; R4 = string[I] & ~32
	;;BRz RETURNSAME

	;;RETURNSAME
	;;AND R2, R2, 0 ; clear R2 / R0 = String, R1 = I
	;;ADD R2, R0, R1 ; R2 = string+I
	;;STR R3, R2, #0 ; 
	;;BR ELSEOUT

	;; if not RETURNSAME, 
	
	;;ADD R5, R3, #-15 
	;;ADD R5, R5, #-15
	;;ADD R5, R5, #-2
	AND R2, R2, 0 ; clear R2 / R0 = String, R1 = I
	ADD R2, R0, R1 ; R2 = string+I
	STR R4, R2, #0 ; 
	BR ELSEOUT

	ELSEOUT
	ADD R1, R1, #1 ; I++

BR LOOP

ENDLOOP

HALT

UPPERA .fill x41    ;; A in ASCII
UPPERZ .fill x5A	;; Z in ASCII
LOWERA .fill x61	;; a in ASCII
LOWERZ .fill x7A	;; z in ASCII

STRING .fill x4000
.end

.orig x4000
.stringz "TWENTY ONE TEN"
.end
