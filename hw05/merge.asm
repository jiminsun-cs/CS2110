;;=============================================================
;; CS 2110 - Spring 2020
;; Homework 5 - Array Merge
;;=============================================================
;; Name: Jimin Sun
;;=============================================================

;; Pseudocode (see PDF for explanation):
;;
;; x = 0;
;; y = 0;
;; z = 0;
;; while (x < LENGTH_X && y < LENGTH_Y) {
;;   if (ARR_X[x] <= ARR_Y[y]) {
;;     ARR_RES[z] = ARR_X[x];
;;     z++;
;;     x++;
;;   } else {
;;     ARR_RES[z] = ARR_Y[y];
;;     z++;
;;     y++;
;;   }
;; }
;; while(x < ARRX.length) {
;;   ARR_RES[z] = ARR_X[x];
;;   z++;
;;   x++;
;; }
;; while (y < ARRY.length) {
;;   ARR_RES[z] = ARR_Y[y];
;;   z++;
;;   y++;
;; }

.orig x3000

;; put your code here
AND R0, R0, 0 ; x = 0
AND R1, R1, 0 ; y = 0
AND R2, R2, 0 ; z = 0

LOOP1
	LD R3, LENGTH_X
	LD R4, LENGTH_Y

	; if either x - LENGTH_X >= 0 or y - LENGTH_Y >= 0 break 
	ADD R5, R3, 0 ; R5 = length_x
	NOT R5, R5
	ADD R5, R5, #1 ; R5 = -length_x
	ADD R6, R5, R0 ; R6 = x - length_x

	BRzp ENDLOOP1; branch out if >= 0

	AND R5, R5, 0 ; clear R5
	AND R6, R6, 0 ; clear R6
	ADD R5, R4, 0 ; R5 = length_y
	NOT R5, R5
	ADD R5, R5, #1 ; R5 = -length_y
	ADD R6, R5, R1 ; R6 = y - length_y

	BRzp ENDLOOP1 ; branch to ENDLOOP1 if >= 0

;;;;;;;;;;;
	AND R3, R3, 0 ; clear R3
	AND R4, R4, 0 ; clear R4
	AND R5, R5, 0 ; clear R5
	AND R6, R6, 0 ; clear R6
	AND R7, R7, 0 ; clear R7
;;;;;;;;;;;

;;   if (ARR_X[x] <= ARR_Y[y]) {

	LD R3, ARR_X ; R3 holds address of ARR_X
	LD R4, ARR_Y ; R4 holds address of ARR_Y

	ADD R5, R0, R3 ; R5 = ARR_X + x
	LDR R6, R5, #0 ; R6 = ARR_X[ARR_X + x]
	
	AND R5, R5, 0 ; clear R5
	ADD R5, R1, R4 ; R5 = ARR_Y + y
	LDR R7, R5, #0 ; R7 = ARR_Y[ARR_Y + y]

	AND R5, R5, 0 ; clear R5
	; if ARR_X[x] - ARR_Y[y] > 0, break out if, go to else
	NOT R7, R7
	ADD R7, R7, #1
	ADD R5, R6, R7 ; R5 = ARR_X[x] - ARR_Y[y]
	BRp ELSE1 ; if above is positive, go to ELSE1

;;     ARR_RES[z] = ARR_X[x];
	AND R3, R3, 0 ; clear R3
	AND R4, R4, 0 ; clear R4
	AND R5, R5, 0 ; clear R5
;; R6 = ARR_X[ARR_X + x]
	LD R3, ARR_RES ; R3 holds address of ARR_RES
	ADD R4, R2, R3 ; R4 = z + ARR_RES
	STR R6, R4, #0
;;     z++;
;;     x++;
	ADD R2, R2, #1
	ADD R0, R0, #1
	BR EIF
; else{
ELSE1
	AND R3, R3, 0 ; clear R3
	AND R4, R4, 0 ; clear R4
	AND R5, R5, 0 ; clear R5
	AND R6, R6, 0 ; clear R6
	AND R7, R7, 0 ; clear R7

;;     ARR_RES[z] = ARR_Y[y];

	LD R3, ARR_RES ; R3 holds address of ARR_RES
	LD R4, ARR_Y ; R4 holds address of ARR_Y

	ADD R5, R2, R3 ; R5 = ARR_RES + z

	ADD R6, R1, R4 ; R6 = ARR_Y + y
	LDR R7, R6, #0 ; R7 = ARR_Y[ARR_Y + y]

	STR R7, R5, #0

;;     z++;
;;     y++;
	ADD R2, R2, #1
	ADD R1, R1, #1
	BR EIF

EIF

BR LOOP1

BR ENDLOOP1

ENDLOOP1 ;; end of first while loop

	;; reset
	AND R3, R3, 0 ; clear R3
	AND R4, R4, 0 ; clear R4
	AND R5, R5, 0 ; clear R5
	AND R6, R6, 0 ; clear R6
	AND R7, R7, 0 ; clear R7

;; while(x < ARRX.length) {
	;; x - ARR_X.length
	;; if x - ARR_X.length pz, break out while loop
	;; R0 = x
LOOP2
	LD R3, LENGTH_X
	ADD R4, R3, 0 ; R4 = LENGTH_X
	NOT R4, R4
	ADD R4, R4, #1 ; R4 = -LENGTH_X
	ADD R5, R0, R4 ; R5 = X - LENGTH_X
	BRzp ENDLOOP2 ; if R5 >= 0, go to endloop2
;;   ARR_RES[z] = ARR_X[x];
	AND R3, R3, 0 ; clear R3
	LD R6, ARR_RES ; R6 holds address of ARR_RES
	ADD R7, R6, R2 ; R7 = z + ARR_RES
	LDR R3, R7, #0 ; R3 = ARR_RES[ARR_RES + z]

	AND R4, R4, 0 ; clear R4
	AND R5, R5, 0 ; clear R5
	LD R4, ARR_X ; R4 holds address of ARR_X
	ADD R5, R4, R0 ; R5 = x + ARR_X
	AND R4, R4, 0 ; CLEAR R4
	LDR R4, R5, #0 ; R4 = ARR_X[ARR_X + x]
	
	STR R4, R7, #0
;;   z++;
;;   x++;
	ADD R2, R2, #1
	ADD R0, R0, #1
	BR LOOP2
;; }
BR ENDLOOP2

ENDLOOP2

	;; reset
	AND R3, R3, 0 ; clear R3
	AND R4, R4, 0 ; clear R4
	AND R5, R5, 0 ; clear R5
	AND R6, R6, 0 ; clear R6
	AND R7, R7, 0 ; clear R7

;; while(y < LENGTH_Y) {
	;; y - LENGTH_Y
	;; if y - LENGTH_Y pz, break out while loop
	;; R0 = x
LOOP3
	LD R3, LENGTH_Y
	ADD R4, R3, 0 ; R4 = LENGTH_Y
	NOT R4, R4
	ADD R4, R4, #1 ; R4 = -LENGTH_Y
	ADD R5, R1, R4 ; R5 = y - LENGTH_Y
	BRzp ENDLOOP3 ; if R5 >= 0, go to endloop2

;;   ARR_RES[z] = ARR_Y[y];
	AND R3, R3, 0 ; clear R3
	LD R6, ARR_RES ; R6 holds address of ARR_RES
	ADD R7, R6, R2 ; R7 = z + ARR_RES
	LDR R3, R7, #0 ; R3 = ARR_RES[ARR_RES + z]

	AND R4, R4, 0 ; clear R4
	AND R5, R5, 0 ; clear R5
	LD R4, ARR_Y ; R4 holds address of ARR_X
	ADD R5, R4, R1 ; R5 = y + ARR_Y
	AND R4, R4, 0 ; CLEAR R4
	LDR R4, R5, #0 ; R4 = ARR_Y[ARR_Y + y]
	STR R4, R7, #0
;;   z++;
;;   y++;
	ADD R2, R2, #1
	ADD R1, R1, #1
	BR LOOP3
;; }
ENDLOOP3


HALT

ARR_X      .fill x4000
ARR_Y      .fill x4100
ARR_RES    .fill x4200

LENGTH_X   .fill 5
LENGTH_Y   .fill 7
LENGTH_RES .fill 12

.end

.orig x4000
.fill 1
.fill 5
.fill 10
.fill 11
.fill 12
.end

.orig x4100
.fill 3
.fill 4
.fill 6
.fill 9
.fill 15
.fill 16
.fill 17
.end
