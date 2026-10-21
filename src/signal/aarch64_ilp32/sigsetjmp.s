// sigjmp_buf for ILP32: __jb[22] 0..175, __fl 176 (4 bytes), __ss 180..307.
// __sigsetjmp_tail saves the signal mask (_NSIG/8 = 8 bytes) at __ss, 180..187,
// so x30 and x19 are kept after it, at 200 and 192 (LP64 uses __fl for x30).
.global sigsetjmp
.global __sigsetjmp
.type sigsetjmp,%function
.type __sigsetjmp,%function
sigsetjmp:
__sigsetjmp:
	mov w0, w0 // ILP32: zero-extend the pointer argument
	cbz w1,setjmp

	str x30,[x0,#200]
	str x19,[x0,#192]
	mov x19,x0

	bl setjmp

	mov w1,w0
	mov x0,x19
	ldr x30,[x0,#200]
	ldr x19,[x0,#192]

.hidden __sigsetjmp_tail
	b __sigsetjmp_tail
