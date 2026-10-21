#if __BYTE_ORDER == __BIG_ENDIAN
#define ENDIAN_SUFFIX "_be"
#else
#define ENDIAN_SUFFIX ""
#endif

/* same name as GCC: ld-musl-aarch64[_be]_ilp32.so.1 */
#define LDSO_ARCH "aarch64" ENDIAN_SUFFIX "_ilp32"

#define NO_LEGACY_INITFINI

#define TPOFF_K 0

#define REL_SYMBOLIC    R_AARCH64_P32_ABS32
#define REL_GOT         R_AARCH64_P32_GLOB_DAT
#define REL_PLT         R_AARCH64_P32_JUMP_SLOT
#define REL_RELATIVE    R_AARCH64_P32_RELATIVE
#define REL_COPY        R_AARCH64_P32_COPY
#define REL_DTPMOD      R_AARCH64_P32_TLS_DTPMOD
#define REL_DTPOFF      R_AARCH64_P32_TLS_DTPREL
#define REL_TPOFF       R_AARCH64_P32_TLS_TPREL
#define REL_TLSDESC     R_AARCH64_P32_TLSDESC

#define CRTJMP(pc,sp) __asm__ __volatile__( \
	"mov sp,%1 ; br %0" : : "r"((unsigned long long)(uintptr_t)(pc)), \
	"r"((unsigned long long)(uintptr_t)(sp)) : "memory" )
