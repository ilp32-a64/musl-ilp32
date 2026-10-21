// ILP32: zero-extend the pointer and size arguments, then the aarch64 memcpy
.global memcpy
.hidden __memcpy_aarch64
.type memcpy,%function
memcpy:
	mov w0, w0
	mov w1, w1
	mov w2, w2
	b __memcpy_aarch64

#define memcpy __memcpy_aarch64
#include "../aarch64/memcpy.S"
