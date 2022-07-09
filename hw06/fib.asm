;;=======================================
;; CS 2110 - Spring 2020
;; HW6 - Recursive Fibonacci Sequence
;;=======================================
;; Name: Jimin Sun
;;=======================================

;; In this file, you must implement the 'fib' subroutine.

;; Little reminder from your friendly neighborhood 2110 TA staff: don't run
;; this directly by pressing 'RUN' in complx, since there is nothing put at
;; address x3000. Instead, load it and use 'Debug' -> 'Simulate
;; Subroutine Call' and choose the 'reverseLL' label.

.orig x3000
HALT

;; Pseudocode (see PDF for explanation):
;;
;; Arguments of Fibonacci number: integer n
;;
;; Pseudocode:
;; fib(int n) {
;;     if (n == 0) {
;;         return 0;
;;     } else if (n == 1) {
;;         return 1;
;;     } else {
;;         return fib(n - 1) + fib(n - 2);
;;     }
;; }
fib
;; YOUR CODE HERE
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
;;work of subroutine/ we can use R0 -R5

LDR R0, R5, 4 ; R0 = n
BRnp ELSE1
AND R0, R0, 0 ; R0 = 0
STR R0, R5, 3 ; return = 0
BR END
ELSE1
ADD R0, R0, -1 ; R0 = -1
LDR R1, R5, 4 ; R1 = n
ADD R0, R1, R0 ; R0 = n-1
;;     } else if (n == 1) {
;;         return 1;
BRnp ELSE2
AND R1, R1, 0 ; R1 = 0
ADD R1, R1, 1 ; R1 = 1
STR R1, R5, 3 ; return = 0
BR END
ELSE2
;;         return fib(n - 1) + fib(n - 2);
;;     }
;; push n-1
LDR R0, R5, 4 ; R0 = n
ADD R0, R0, -1 ; R0 = n - 1
ADD R6, R6, -1
STR R0, R6, 0 ; Store R0 to stack
JSR fib ; fib(n-1)
LDR R0, R6, 0 ; R0 =fib(n-1)
ADD R6, R6, 2 ; pop RV and 1 arg

LDR R1, R5, 4 ; R1 = n
ADD R1, R1, #-2 ; R1 = n - 2
ADD R6, R6, -1
STR R1, R6, 0 ; store R1 to stack
JSR fib ; fib(n-2)
LDR R2, R6, 0 ; R2 = fib(n-2)
ADD R6, R6, 2; pop RV and arg

AND R3, R3, 0
ADD R3, R0, R2 ; R3 = fib(n-1) + fib(n-2)
STR R3, R5, 3 ; return R3
BR END


//;;     if (n == 0) {
//LDR R0, R5, 4 ; R0 = n
//BRnp IFELSE1
//;;         return 0;
//AND R0, R0, 0 ; R0 = 0
//STR R0, R5, 3 ; return 0
//BR END
//;;     } else if (n == 1) {
//IFELSE1 AND R0, R0, 0;
//ADD R0, R0, #-1 ; R0 = -1
//LDR R1, R5, 4 ; R1 = n
//ADD R0, R0, R1; R0 = n - 1
//BRnp IFELSE2
//;;         return 1;
//AND R0, R0, 0 ; R0 = 0
//ADD R0, R0, 1 ; R0 = 1
//STR R0, R5, 3 ; return 1
//BR END
//;;     } else {
//;;         return fib(n - 1) + fib(n - 2);
//IFELSE2 LDR R0, R5, 4 ; push n-1
//ADD R0, R0, #-1 ; n - 1
//ADD R6, R6, -1
//STR R0, R6, 0 ; push R0 to stack
//JSR fib ; fib(n-1)
//LDR R0, R6, 0 ; R0 = fib(n-1)
//ADD R6, R6, 2 ; pop rv, arg1
//
//LDR R1, R5, 4 ; push n-2
//ADD R1, R1, #-2 ; R1 = n-2
//ADD R6, R6, -1 ; push n-1
//STR R1, R6, 0 ; push R1 to stack
//JSR fib
//LDR R2, R6, 0 ; R2 = fib(n-2)
//ADD R6, R6, 2
//
//AND R3, R3, 0
//ADD R3, R0, R2
//STR R3, R5, 3 ; return
//BR END
//

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

;; used by the autograder
STACK .fill xF000
.end
