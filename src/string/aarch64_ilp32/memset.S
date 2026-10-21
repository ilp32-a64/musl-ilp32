// ILP32: zero-extend the pointer and size arguments, then the aarch64 memset
.global memset
.hidden __memset_aarch64
.type memset,%function
memset:
	mov w0, w0
	mov w1, w1
	mov w2, w2
	b __memset_aarch64

#define memset __memset_aarch64
#include "../aarch64/memset.S"
