// __clone(func, stack, flags, arg, ptid, tls, ctid)
//         x0,   x1,    w2,    x3,  x4,   x5,  x6

// syscall(SYS_clone, flags, stack, ptid, tls, ctid)
//         x8,        x0,    x1,    x2,   x3,  x4

.global __clone
.hidden __clone
.type   __clone,%function
__clone:
	// ILP32: zero-extend the pointer arguments
	mov w0,w0
	mov w1,w1
	mov w3,w3
	mov w4,w4
	mov w5,w5
	mov w6,w6
	// align stack and save func,arg
	and x1,x1,#-16
	stp x0,x3,[x1,#-16]!

	// syscall
	uxtw x0,w2
	mov x2,x4
	mov x3,x5
	mov x4,x6
	mov x8,#220 // SYS_clone
	svc #0

	cbz x0,1f
	// parent
	ret
	// child
1:	ldp x1,x0,[sp],#16
	blr x1
	mov x8,#93 // SYS_exit
	svc #0
