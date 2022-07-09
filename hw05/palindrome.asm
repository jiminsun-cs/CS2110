;;=============================================================
;; CS 2110 - Fall 2020
;; Homework 5 - Palindrome
;;=============================================================
;; Name: Jimin Sun
;;=============================================================

;; Pseudocode (see PDF for explanation):
;;
;; string = "racecar";
;; len = 0;
;;
;; // to find the length of the string
;; while (string[len] != '\0') {
;;   len = len + 1;
;; }
;;
;; // to check whether the string is a palindrome
;; result = 1;
;; i = 0;
;; while (i < length) {
;;   if (string[i] != string[length - i - 1]) {
;;     result = 0;
;;     break;
;;   }
;;   i = i + 1;
;; }

.orig x3000

;; put your code here

AND R0, R0, 0
AND R1, R1, 0
AND R2, R2, 0
AND R3, R3, 0
AND R4, R4, 0
AND R5, R5, 0
AND R6, R6, 0
AND R7, R7, 0

LD R0, STRING ; R0 = String
AND R1, R1, 0 ; R1 = len = 0

;; while (string[len] != '\0') {
LOOP1
	ADD R2, R0, R1 ; R2 = Len + string
	LDR R3, R2, 0 ; R3 = string[len] value of
	BRz ENDLOOP1
	
	;; if satisfy condition of LOOP1
	ADD R1, R1, #1 ; len++
	BRnzp LOOP1 ; go back to LOOP1

ENDLOOP1
BRnzp NEXT

NEXT

AND R2, R2, 0 
ADD R2, R2, #1 ; R2 = result = 1
ST R2, ANSWER
AND R3, R3, 0 ; R3 = I
BRnzp LOOP2

LOOP2
	NOT R4, R1
	ADD R4, R4, #1 ; R4 = -length
	ADD R5, R4, R3 ; R5 = I - length
	BRzp ENDLOOP2 ; if I-length >= 0

;;   if (string[i] != string[length - i - 1]) {
;; 4 5 6 7
	;; length - I - 1
	AND R5, R5, 0 ; R5 = 0
	NOT R5, R3
	ADD R5, R5, #1 ; R5 = -I
	ADD R6, R1, R5 ; length - I
	ADD R6, R6, #-1 ; R6 = length - I - 1
	AND R4, R4, 0
	AND R7, R7, 0
	ADD R4, R0, R6 ; R4 = address of (string + R6)
	LDR R7, R4, 0 ; R7 = string[length - i - 1]
	
	AND R4, R4, 0
	AND R5, R5, 0
	
	ADD R4, R3, R0 ; R4 = I + string
	LDR R5, R4, 0 ; R5 = string[I]
	
	AND R4, R4, 0
	AND R6, R6, 0
	NOT R6, R7
	ADD R6, R6, #1 ; R6 = -string[length - i - 1]
	ADD R4, R5, R6 ; R4 = string[i] - string[length - i - 1]
	BRz EIF
	
	AND R2, R2, 0 ; result = 0
	ST R2, ANSWER
	BRnzp ENDLOOP2
	
	EIF
	ADD R3, R3, #1 ; I++
	BRnzp LOOP2

ENDLOOP2

HALT

ANSWER .blkw 1
STRING .fill x4000
.end

.orig x4000
.stringz "racecar"
.end
