// ILP32: the descriptor, dtv entries and {modidx,off} are 32-bit words,
// the result is the 64-bit offset from tp

// size_t __tlsdesc_static(size_t *a)
// {
// 	return a[1];
// }
.global __tlsdesc_static
.hidden __tlsdesc_static
.type __tlsdesc_static,@function
__tlsdesc_static:
	mov w0,w0
	ldr w0,[x0,#4]
	ret

// size_t __tlsdesc_dynamic(size_t *a)
// {
// 	struct {size_t modidx,off;} *p = (void*)a[1];
// 	size_t *dtv = *(size_t**)(tp - 4);
// 	return dtv[p->modidx] + p->off - tp;
// }
.global __tlsdesc_dynamic
.hidden __tlsdesc_dynamic
.type __tlsdesc_dynamic,@function
__tlsdesc_dynamic:
	stp x1,x2,[sp,#-16]!
	mov w0,w0
	mrs x1,tpidr_el0      // tp
	ldr w0,[x0,#4]        // p
	ldp w0,w2,[x0]        // p->modidx, p->off
	sub x2,x2,x1          // p->off - tp
	ldr w1,[x1,#-4]       // dtv
	ldr w1,[x1,x0,lsl #2] // dtv[p->modidx]
	add x0,x1,x2          // dtv[p->modidx] + p->off - tp
	ldp x1,x2,[sp],#16
	ret
