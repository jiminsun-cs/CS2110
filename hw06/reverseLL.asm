;;=============================================================
;; CS 2110 - Spring 2020
;; Homework 6 - Reverse Linked List
;;=============================================================
;; Name: Jimin Sun
;;============================================================

;; In this file, you must implement the 'reverseLL' subroutine.

;; Little reminder from your friendly neighborhood 2110 TA staff: don't run
;; this directly by pressing 'RUN' in complx, since there is nothing put at
;; address x3000. Instead, load it and use 'Debug' -> 'Simulate
;; Subroutine Call' and choose the 'reverseLL' label.

.orig x3000
HALT

;; Pseudocode (see PDF for explanation):
;;
;; Arguments of reverseLL: Node head
;;
;; reverseLL(Node head) {
;;     // note that a NULL address is the same thing as the value 0
;;     if (head == NULL) {
;;         return NULL;
;;     }
;;     if (head.next == NULL) {
;;         return head;
;;     }
;;     Node tail = head.next;
;;     Node newHead = reverseLL(tail);
;;     tail.next = head;
;;     head.next = NULL;
;;     return newHead;
;; }
reverseLL

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
;;;;;;;;;;;
;R4     <-R6
;R3
;R2
;R1
;R0
;result  <-R5
;FR/old frame pointer (R5)
;RA/return address (R7)
;reverseLL(Node head)
;Node head = R5+4
LDR R1, R5, 4 ; R1 <- address of head node
;;     if (head == NULL) {
;;         return NULL;
;;     }
ADD R1, R1, 0
BRnp IFOUT1 ;; if null, go to next if
BRz IF1
; return null ;
IF1 AND R2, R2, 0 ; r2 = 0
STR R2, R5, 0 ; store 0 in R5 (result)
BRnzp END

IFOUT1
;;     if (head.next == NULL) {
;;         return head;
;;     }
LDR R4, R1, 0 ; R4  <- head.next
BRnp IFOUT2
BRz IF2
;return head;
IF2 STR R1, R5, 0 ; store R1 (head address) in R5
BRnzp END

IFOUT2
;;     Node tail = head.next;

LDR R3, R1, 0 ; tail (R3) <- head.next
;;     Node newHead = reverseLL(tail);
ADD R6, R6, -1 ; push tail
STR R3, R6, 0 ; push tail to stack
JSR reverseLL ;reverseLL(tail)
LDR R0, R6, 0 ; newHead (R0) = reverseLL(tail)

ADD R6, R6, 2 ; pop RV, arg1

;;     tail.next = head;
LDR R3, R3, 0 ; R3 = tail.next
LDR R3, R1, 0 ; tail.next = head
;;     head.next = NULL;
AND R3, R3, 0 ; R3 = 0

STR R3, R4, 0 ; R4 (head.next) = 0
;;     return newHead;
STR R0, R5, 0 ; return newHead
BRnzp END

END LDR R0, R5, 0 ; load return value to R0, assume R5 is final answer
STR R0, R5, 3 ; store return value to RV

END


END



;;;;;;;;;;;
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

;; The following is an example of a small linked list that starts at x4000.
;;
;; The first number (offset 0) contains the address of the next node in the
;; linked list, or zero if this is the final node.
;;
;; The second number (offset 1) contains the data of this node.
.orig x4000
.fill x4008
.fill 5
.end

.orig x4008
.fill x4010
.fill 12
.end

.orig x4010
.fill 0
.fill -7
.end
