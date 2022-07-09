;; Timed Lab 3
;; Student Name: Jimin Sun

;; Please read the PDF for full directions.
;; The pseudocode for the program you must implement is listed below; it is also listed in the PDF.
;; If there are any discrepancies between the PDF's pseudocode and the pseudocode below, notify a TA on Piazza quickly.
;; However, in the end, the pseudocode is just an example of a program that would fulfill the requirements specified in the PDF.

;; Pseudocode:
;;
;; ABS(x) {
;;     if (x < 0) {
;;         return -x;
;;     } else {
;;         return x;
;;     }
;; }
;;
;;
;;
;; POW3(x) {
;;     if (x == 0) {
;;         return 1;
;;     } else {
;;         return 3 * POW3(x - 1);
;;     }
;; }
;;
;;
;; MAP(array, length) {
;;     i = 0;
;;     while (i < length) {
;;         element = arr[i];
;;         if (i & 1 == 0) {
;;             result = ABS(element);
;;         } else {
;;             result = POW3(element);
;;         }
;;         arr[i] = result;
;;         i++;
;;     }
;; }

.orig x3000
HALT

STACK .fill xF000

; DO NOT MODIFY ABOVE


; START ABS SUBROUTINE
ABS
;CHECKPOINT1



    ; !!!!! WRITE YOUR CODE HERE !!!!!
ADD R6, R6, -4 ; allocate space
STR R7, R6, 2 ; save return address
STR R5, R6, 1 ; save old FP
ADD R5, R6, 0 ; copy SP to FP
ADD R6, R6, -5 ; make room for saved registers
STR R0, R5, -1
STR R1, R5, -2
STR R2, R5, -3
STR R3, R5, -4
STR R4, R5, -5
;;work of subroutine/ we can use R0 - R4
;---------------------------
;R4
;R3
;R2
;R1
;R0
;result  <-R5
;FR/old frame pointer (R5)
;RA/return address (R7)
;RV
;x = R5 + 4
;---------------------------
;; ABS(x) {
;;     if (x < 0) {
;;         return -x;
;;     } else {
;;         return x;
;;     }
;; }
LDR R0, R5, 4 ; R0 = x
BRzp ELSE ; >=
NOT R0, R0
ADD R0, R0, 1 ; R0 = -x
STR R0, R5, 3 ; RETURN
BR END

ELSE
LDR R0, R5, 4 ; R0 = x
STR R0, R5, 3 ; RETURN
BR END

END
LDR R4, R5, -5 ; restore R4
LDR R3, R5, -4 ; restore R3
LDR R2, R5, -3 ; restore R2
LDR R1, R5, -2 ; restore R1
LDR R0, R5, -1 ; restore R0
ADD R6, R5, 0 ; restore SP
LDR R5, R6, 1 ; restore FP
LDR R7, R6, 2 ; restore RA
ADD R6, R6, 3 ; pop RA, FP, 1st local variable
RET

; END ABS SUBROUTINE




; START POW3 SUBROUTINE
POW3



    ; !!!!! WRITE YOUR CODE HERE !!!!!
ADD R6, R6, -4 ; allocate space
STR R7, R6, 2 ; save return address
STR R5, R6, 1 ; save old FP
ADD R5, R6, 0 ; copy SP to FP
ADD R6, R6, -5 ; make room for saved registers
STR R0, R5, -1
STR R1, R5, -2
STR R2, R5, -3
STR R3, R5, -4
STR R4, R5, -5
;;work of subroutine/ we can use R0 - R4
;---------------------------
;R4
;R3
;R2
;R1
;R0
;result  <-R5
;FR/old frame pointer (R5)
;RA/return address (R7)
;RV
;x = R5 + 4
;---------------------------
;; POW3(x) {
;;     if (x == 0) {
;;         return 1;
;;     } else {
;;         return 3 * POW3(x - 1);
;;     }
;; }
; CHECKPOINT 2 : base case for POW3
LDR R0, R5, 4 ; R0 = x
BRz IF_POW
BRnp ELSE_POW

IF_POW AND R1, R1, 0
ADD R1, R1, 1 ; R1 = 1
STR R1, R5, 3 ; RETURN
BR END_POW

;;     } else {
;;         return 3 * POW3(x - 1);
;;     }

ELSE_POW LDR R0, R5, 4 ; R0 = x
ADD R0, R0, -1 ; R0 = x - 1
ADD R6, R6, -1 ;
STR R0, R6, 0 ; Store R0 to stack
JSR POW3
LDR R1, R6, 0 ; R1 = POW3(n-1)
ADD R6, R6, 2 ; pop RV and 1 arg
AND R2, R2, 0
ADD R2, R1, R1 ; R2 = 2 * pow3(n-1)
ADD R2, R2, R1 ; R2 = 3 * pow3(n-1)
STR R2, R5, 3 ; RET
BR END_POW

END_POW
LDR R4, R5, -5 ; restore R4
LDR R3, R5, -4 ; restore R3
LDR R2, R5, -3 ; restore R2
LDR R1, R5, -2 ; restore R1
LDR R0, R5, -1 ; restore R0
ADD R6, R5, 0 ; restore SP
LDR R5, R6, 1 ; restore FP
LDR R7, R6, 2 ; restore RA
ADD R6, R6, 3 ; pop RA, FP, 1st local variable
RET
; END POW3 SUBROUTINE




; START MAP SUBROUTINE
MAP



    ; !!!!! WRITE YOUR CODE HERE !!!!!
ADD R6, R6, -4 ; allocate space
STR R7, R6, 2 ; save return address
STR R5, R6, 1 ; save old FP
ADD R5, R6, 0 ; copy SP to FP
ADD R6, R6, -5 ; make room for saved registers
STR R0, R5, -1
STR R1, R5, -2
STR R2, R5, -3
STR R3, R5, -4
STR R4, R5, -5

;;work of subroutine/ we can use R0 - R4
;---------------------------
;R4
;R3
;R2
;R1
;R0
;result  <-R5
;FR/old frame pointer (R5)
;RA/return address (R7)
;RV
;array = R5 + 4
;length = R5 + 5
;---------------------------
;; MAP(array, length) {
;;     i = 0;
;;     while (i < length) {
;;         element = arr[i];
;;         if (i & 1 == 0) {
;;             result = ABS(element);
;;         } else {
;;             result = POW3(element);
;;         }
;;         arr[i] = result;
;;         i++;
;;     }
;; WHILE_OUT
;; }


AND R0, R0, 0 ; R0 = i = 0
LDR R2, R5, 5 ; R2 = length
AND R3, R3, 0
NOT R2, R2
ADD R3, R2, 1 ; R3 = -length
ADD R3, R0, R3 ; R3 = i - length

WHILE ; i - length >= 0 --> break out
BRzp WHILE_OUT
;;         element = arr[i];
LDR R1, R5, 4 ; R1 = arr
ADD R1, R1, R0 ; R1 = arr + i
LDR R2, R1, 0 ; R2 (element) = arr[i]

;;         if (i & 1 == 0) {
;;AND R3, R3, 0
AND R3, R0, 1 ; if zero, move to IF_MAP
BRz IF_MAP
BRnp ELSE_MAP

IF_MAP
;;             result = ABS(element);
ADD R6, R6, -1 ; push element
STR R2, R6, 0
JSR ABS
LDR R4, R6, 0 ; R4 = ABS(element)
ADD R6, R6, 2 ; pop rv, var
BRnzp ELSE_OUT_MAP

ELSE_MAP
;;             result = POW3(element);
ADD R6, R6, -1 ; push element
STR R2, R6, 0
JSR POW3
LDR R4, R6, 0 ; R4 = POW3(element)
ADD R6, R6, 2 ; pop rv, var
BRnzp ELSE_OUT_MAP

ELSE_OUT_MAP
;;         arr[i] = result;
;; result = R4
;;         i++;

STR R4, R1, 0 ; store result to address of  arr+i
ADD R0, R0, 1 ; i++

LDR R2, R5, 5 ; R2=length
NOT R2, R2
ADD R2, R2, 1 ; R2 = -length
ADD R2, R0, R2

BR WHILE

WHILE_OUT
BRnzp END_MAP
END_MAP



LDR R4, R5, -5 ; restore R4
LDR R3, R5, -4 ; restore R3
LDR R2, R5, -3 ; restore R2
LDR R1, R5, -2 ; restore R1
LDR R0, R5, -1 ; restore R0
ADD R6, R5, 0 ; restore SP
LDR R5, R6, 1 ; restore FP
LDR R7, R6, 2 ; restore RA
ADD R6, R6, 3 ; pop RA, FP, 1st local variable
RET
; END MAP SUBROUTINE


; ARRAY FOR TESTING
ARRAY .fill x4000
.end

.orig x4000
.fill -2
.fill 5
.fill 3
.fill 2
.fill -6
.fill 0
.end
