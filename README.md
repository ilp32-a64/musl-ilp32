# musl for AArch64 ILP32

[musl](https://musl.libc.org/) with a port to AArch64 ILP32 (`aarch64_ilp32`):
64-bit Arm code with 32-bit `long` and pointers, which uses less memory and
keeps the full AArch64 instruction set
([performance](https://github.com/ilp32-a64/llvm-ilp32/blob/main/docs/benchmarks.md)).

Upstream musl has no AArch64 ILP32 port. The arm64 ILP32 kernel ABI was
discussed with the musl list in 2015, and GCC has named a musl ILP32 dynamic
linker since then, but no musl port was published; to our knowledge this is the
first working one.

This default branch only holds this file. The library is in the branch below.

## Branches

| Branch | Base | Status |
|---|---|---|
| `ilp32-1.2.5` | musl 1.2.5 | current |

## Use

**The easiest way is OpenWrt**: [openwrt-ilp32](https://github.com/ilp32-a64/openwrt-ilp32)
includes this port; select the ILP32 ABI in menuconfig.

**On its own**: build the toolchain with
[test-ilp32](https://github.com/ilp32-a64/test-ilp32), then:

```
git clone -b ilp32-1.2.5 https://github.com/ilp32-a64/musl-ilp32.git ~/work/musl-ilp32
musl/toolchain/build-stage1.sh                        # in test-ilp32, once
musl/toolchain/build-stage2.sh <ilp32-6.12.y kernel tree>
export PATH=~/work/ilp32-musl/toolchain/out/bin:$PATH # $MUSL_WORK/toolchain/out/bin
aarch64-linux-musl_ilp32-gcc -O2 hello.c -o hello
```

`build-stage2.sh` builds the branch checked out in `~/work/musl-ilp32` (or `MUSL_SRC`), so
check out `ilp32-1.2.5` there: this default branch has no source.

## ilp32-1.2.5

- **Four commits on musl 1.2.5**: the port, the types GCC expects, the aarch64
  math functions, and the removal of the time32/stat64 system call numbers.
- **Year 2038 safe**: 64-bit `time_t`, only the time64 system calls.
- **Dynamic linker**: `/lib/ld-musl-aarch64_ilp32.so.1`.
- **Kernel with the ILP32 ABI**, such as
  [linux-ilp32](https://github.com/ilp32-a64/linux-ilp32) branch `ilp32-6.12.y`.
- **Security features**: pointer authentication (clang `pac-ret`) needs no musl
  change; unwinding through signed frames (C++ exceptions) needs a libgcc fix,
  which both openwrt-ilp32 (toolchain patch 990) and the test-ilp32 toolchain
  (`musl/toolchain/patches/gcc-14.3.0`) carry.
  BTI is not supported yet ([issue #1](https://github.com/ilp32-a64/musl-ilp32/issues/1)).
- **Testing**: in QEMU, its own tests pass; libc-test passes 453 of 480, and
  the other 27 also fail with the LP64 musl.

## License

MIT, see `COPYRIGHT` in the `ilp32-1.2.5` branch.
