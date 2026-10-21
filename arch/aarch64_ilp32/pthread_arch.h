static inline uintptr_t __get_tp()
{
	unsigned long long tp;
	__asm__ ("mrs %0,tpidr_el0" : "=r"(tp));
	return tp;
}

#define TLS_ABOVE_TP
/* the TCB is two pointers, 8 bytes for ILP32 (binutils TCB_SIZE) */
#define GAP_ABOVE_TP 8

#define MC_PC pc
