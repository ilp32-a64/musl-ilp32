typedef int32_t int_fast16_t;
typedef int32_t int_fast32_t;
typedef uint32_t uint_fast16_t;
typedef uint32_t uint_fast32_t;

#define INT_FAST16_MIN  INT32_MIN
#define INT_FAST32_MIN  INT32_MIN

#define INT_FAST16_MAX  INT32_MAX
#define INT_FAST32_MAX  INT32_MAX

#define UINT_FAST16_MAX UINT32_MAX
#define UINT_FAST32_MAX UINT32_MAX

#define INTPTR_MIN      INT32_MIN
#define INTPTR_MAX      INT32_MAX
#define UINTPTR_MAX     UINT32_MAX
#define PTRDIFF_MIN     (-1-0x7fffffffL)
#define PTRDIFF_MAX     0x7fffffffL
#define SIZE_MAX        0xffffffffUL
