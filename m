Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B6EF42D6C6
	for <lists+bpf@lfdr.de>; Thu, 14 Oct 2021 12:07:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbhJNKJJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 14 Oct 2021 06:09:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbhJNKJI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 14 Oct 2021 06:09:08 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5107C061570
        for <bpf@vger.kernel.org>; Thu, 14 Oct 2021 03:07:03 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id x33-20020a9d37a4000000b0054733a85462so7496063otb.10
        for <bpf@vger.kernel.org>; Thu, 14 Oct 2021 03:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=c8yd2BwzgOZSLpunmdRT1UskyNQ+qfm5w94Kv3saZGY=;
        b=FE1F9iO3BxjKZLLUoab5XxTHMghjQhcTJ3NF+pNkBicfjGX2BOITyM5eCukzH6NFcy
         SxnrUAiikJmxgVlEyoQpsaD1cxHZsN+QHm1qruhre0HEfNoNW/CqMEvcHKEzp0XAspSa
         23beKNv4OAUYTy1IQ1EwfRK+Dl16Kf+dQSe6W8EmmQnAD8lsS6eEB6W8eeoeyoXnHZow
         Ft2nENTEQBbM1ZQjr3NrYzE1YomLRouUTy6SzHSCAariBp8mBcFocpddXTQRMLkJhaWh
         Hq/gFMCeeMSW3wSebmf5gAb26iU3TBKach++BRsf+d8WvRroiN9jcTaod55YWStMfQB+
         7otQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=c8yd2BwzgOZSLpunmdRT1UskyNQ+qfm5w94Kv3saZGY=;
        b=Sm7Op1bSXpwIkn5He+rJVuaCbuTZQK9nWS/RzxM0Ub63rVOaT5LvSBaNuJhUDMZ0NH
         xFtBYAeymBGiOhJn0JYI6qIMmNf5FTrCU+zsREtOS2E6QmfwPngBfkIQo1r+8PvgQrSl
         upDaWCMDZ2rkSKEdWqvpZ9q7VcUfL+Vuldsa0AP8qvBl7lmbRE4z3tZ9h1zFrN9C98EX
         2x63XOLHjlg0NAmws8NQmglpQjhRyW4CXJjA0tVQ/+enKKp9VMwEeKIJ1J4n1JtzI9T9
         Tv0ia8fIi4Ob282dC9kMbTiYaVuB+YmIDDeEqOTt8uyL6qtdiDva+1kPeawNgsc8UzD7
         eDIA==
X-Gm-Message-State: AOAM531wt2dCnht3GEXRcQoNt8+Qkg9LHAMt5tBG1Gvn5i6Arw9rYYwc
        UHMjOLQArpiMMmRg59kFcEDS/BYeKvwnm3URgcIqTV4WqHs=
X-Google-Smtp-Source: ABdhPJx/pHOJN1gvEl7ROdZMGON6pTxHooh89luk6kUOsP0YinCG4PnOlDC6NaMtqiMZNjeBE3MRrDbVrlvbz7wvEtU=
X-Received: by 2002:a9d:289:: with SMTP id 9mr1685698otl.172.1634206022590;
 Thu, 14 Oct 2021 03:07:02 -0700 (PDT)
MIME-Version: 1.0
From:   Pony Sew <poony20115@gmail.com>
Date:   Thu, 14 Oct 2021 18:06:51 +0800
Message-ID: <CAK-59YGfOXDCy8Wz45-8jquUA7+7YtdcU+Hs2u5LX=fGXWNvWQ@mail.gmail.com>
Subject: I'd like to make my simple BPF program CO-RE-able to some older
 Debian OS
To:     bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello!
I'm new to BPF CO-RE and I tried to write a simple BPF program. Here
are some informations about my Debian 11 amd64 main compilation
environment:


# uname -r
5.10.0-9-amd64

# llc --version
LLVM (http://llvm.org/):
  LLVM version 14.0.0git
  Optimized build.
  Default target: x86_64-unknown-linux-gnu
  Host CPU: skylake

  Registered Targets:
    aarch64    - AArch64 (little endian)
    aarch64_32 - AArch64 (little endian ILP32)
    aarch64_be - AArch64 (big endian)
    amdgcn     - AMD GCN GPUs
    arm        - ARM
    arm64      - ARM64 (little endian)
    arm64_32   - ARM64 (little endian ILP32)
    armeb      - ARM (big endian)
    avr        - Atmel AVR Microcontroller
    bpf        - BPF (host endian)
    bpfeb      - BPF (big endian)
    bpfel      - BPF (little endian)
    hexagon    - Hexagon
    lanai      - Lanai
    mips       - MIPS (32-bit big endian)
    mips64     - MIPS (64-bit big endian)
    mips64el   - MIPS (64-bit little endian)
    mipsel     - MIPS (32-bit little endian)
    msp430     - MSP430 [experimental]
    nvptx      - NVIDIA PTX 32-bit
    nvptx64    - NVIDIA PTX 64-bit
    ppc32      - PowerPC 32
    ppc32le    - PowerPC 32 LE
    ppc64      - PowerPC 64
    ppc64le    - PowerPC 64 LE
    r600       - AMD GPUs HD2XXX-HD6XXX
    riscv32    - 32-bit RISC-V
    riscv64    - 64-bit RISC-V
    sparc      - Sparc
    sparcel    - Sparc LE
    sparcv9    - Sparc V9
    systemz    - SystemZ
    thumb      - Thumb
    thumbeb    - Thumb (big endian)
    wasm32     - WebAssembly 32-bit
    wasm64     - WebAssembly 64-bit
    x86        - 32-bit X86: Pentium-Pro and above
    x86-64     - 64-bit X86: EM64T and AMD64
    xcore      - XCore

# clang --version
clang version 14.0.0 (https://github.com/llvm/llvm-project.git
5f4c91583ee772a6ce2c4f192e25b07e6075eb00)
Target: x86_64-unknown-linux-gnu
Thread model: posix
InstalledDir: /usr/bin

# gcc --version
gcc (Debian 10.2.1-6) 10.2.1 20210110
Copyright (C) 2020 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

# make --version
GNU Make 4.3
Built for x86_64-pc-linux-gnu
Copyright (C) 1988-2020 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.

# bpftool --version
bpftool v5.10.70
features:


Here are two programs -- "hello" and "maps" -- that I wrote, five
files in total.
Including "hello.c", "hello.bpf.c", "maps.h", "maps.c", and "maps.bpf.c":


hello.c:

#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>
#include <sys/resource.h>

#include <bpf/libbpf.h>
#include <bpf/bpf.h>
#include "hello.skel.h"

void read_trace_pipe(void)
{
int trace_fd;

trace_fd = open("/sys/kernel/debug/tracing/trace_pipe", O_RDONLY, 0);
if (trace_fd < 0)
return;

while (1) {
static char buf[4096];
ssize_t sz;

sz = read(trace_fd, buf, sizeof(buf) - 1);
if (sz > 0) {
buf[sz] = 0;
puts(buf);
}
}
}

int main(void)
{
struct hello_bpf *obj;
int err = 0;

struct rlimit rlim = {
.rlim_cur = 512UL << 20,
.rlim_max = 512UL << 20,
};

err = setrlimit(RLIMIT_MEMLOCK, &rlim);
if (err) {
fprintf(stderr, "failed to change rlimit\n");
return 1;
}


obj = hello_bpf__open();
if (!obj) {
fprintf(stderr, "failed to open and/or load BPF object\n");
return 1;
}

err = hello_bpf__load(obj);
if (err) {
fprintf(stderr, "failed to load BPF object %d\n", err);
goto cleanup;
}

err = hello_bpf__attach(obj);
if (err) {
fprintf(stderr, "failed to attach BPF programs\n");
goto cleanup;
}

read_trace_pipe();

cleanup:
hello_bpf__destroy(obj);
return err != 0;
}


hello.bpf.c:

#include "vmlinux.h"
#include <bpf/bpf_helpers.h>

SEC("tracepoint/syscalls/sys_enter_execve")
int tracepoint__syscalls__sys_enter_execve(struct
trace_event_raw_sys_enter *ctx)
{
bpf_printk("Hello world!\n");
return 0;
}

char LICENSE[] SEC("license") = "GPL";


maps.h:

#ifndef _MAPS_H
#define _MAPS_H

#define TASK_COMM_LEN 16

struct event {
char comm[TASK_COMM_LEN];
pid_t pid;
uid_t uid;
};

#endif


maps.c:

#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>
#include <sys/resource.h>
#include <argp.h>

#include <bpf/libbpf.h>
#include <bpf/bpf.h>

#include "maps.skel.h"
#include "maps.h"

static struct env {
bool verbose;
} env = {
.verbose = false,
};

const char *argp_program_version = "bpf loggin example";
const char argp_program_doc[] =
"An example BPF CO-RE application that demonstrates a libbpf maps set up\n";
static const struct argp_option opts[] = {
{NULL, 'h', NULL, OPTION_HIDDEN, "Show the full help"},
{"verbose", 'v', NULL, 0, "verbose debug output"},
{},
};

int libbpf_print_fn(enum libbpf_print_level level,
const char *format, va_list args)
{
if (level == LIBBPF_DEBUG && !env.verbose) {
return 0;
}

return vfprintf(stderr, format, args);
}

static error_t parse_arg(int key, char *arg, struct argp_state *state)
{
switch (key) {
case 'v':
env.verbose = true;
break;
case 'h':
argp_usage(state);
break;
default:
return ARGP_ERR_UNKNOWN;

}

return 0;
}

static int print_execs(int fd)
{
int err;
struct event ev;
pid_t lookup_key = 0, next_key;

while (!bpf_map_get_next_key(fd, &lookup_key, &next_key)) {
err = bpf_map_lookup_elem(fd, &next_key, &ev);
if (err < 0) {
fprintf(stderr, "failed to lookup exec: %d\n", err);
return -1;
}
printf("\nProcess Name = %s, uid = %u, pid = %u\n", ev.comm, ev.uid, ev.pid);
err = bpf_map_delete_elem(fd, &next_key);
if (err < 0) {
fprintf(stderr, "failed to cleanup execs : %d\n", err);
return -1;
}
lookup_key = next_key;
}

return 0;
}

int main(int argc, char **argv) {
struct maps_bpf *obj;
int err = 0;
struct rlimit rlim = {
.rlim_cur = 512UL << 20,
.rlim_max = 512UL << 20,
};
const struct argp argp = {
.options = opts,
.parser = parse_arg,
.doc = argp_program_doc,
};
int fd;

err = setrlimit(RLIMIT_MEMLOCK, &rlim);
if (err) {
fprintf(stderr, "failed to change rlimit\n");
return 1;
}

err = argp_parse(&argp, argc, argv, 0, NULL, NULL);
if (err) {
fprintf(stderr, "failed to parse command line arguments\n");
return 1;
}

libbpf_set_print(libbpf_print_fn);
obj = maps_bpf__open();
if (!obj) {
fprintf(stderr, "failed to open and/or load BPF object\n");
return 1;
}

err = maps_bpf__load(obj);
if (err) {
fprintf(stderr, "failed to load BPF object %d\n", err);
goto cleanup;
}

err = maps_bpf__attach(obj);
if (err) {
fprintf(stderr, "failed to attach BPF programs\n");
goto cleanup;
}

fd = bpf_map__fd(obj->maps.execs);

printf("printing executed commands\n");

while (1) {
print_execs(fd);
fd = bpf_map__fd(obj->maps.execs);
}

cleanup:
maps_bpf__destroy(obj);
return err != 0;
}


maps.bpf.c:

#include "vmlinux.h"
#include <bpf/bpf_helpers.h>
#include "maps.h"

struct {
__uint(type, BPF_MAP_TYPE_HASH);
__uint(max_entries, 128);
__type(key, pid_t);
__type(value, struct event);
} execs SEC(".maps");

SEC("tracepoint/syscalls/sys_enter_execve")
int tracepoint__syscalls__sys_enter_execve(struct
trace_event_raw_sys_enter *ctx)
{
struct event *event;
pid_t pid;
u64 id;
uid_t uid = (u32) bpf_get_current_uid_gid();

id = bpf_get_current_pid_tgid();
pid = (pid_t)id;

if (bpf_map_update_elem(&execs, &pid, &((struct event){}), 1)) {
return 0;
}

event = bpf_map_lookup_elem(&execs, &pid);
if (!event) {
return 0;
}

event->pid = pid;
event->uid = uid;
bpf_get_current_comm(&event->comm, sizeof(event->comm));

/*
if (bpf_map_update_elem(&execs, &pid, event, 2)) {
return 0;
}
*/

return 0;
}

char LICENSE[] SEC("license") = "GPL";


And here is how I compile them:


bpftool btf dump file /sys/kernel/btf/vmlinux format c > vmlinux.h
clang -g -O2 -target bpf -D__TARGET_ARCH_x86_64 -I . -c hello.bpf.c -o
hello.bpf.o
bpftool gen skeleton hello.bpf.o > hello.skel.h
clang -g -O2 -Wall -I . -c hello.c -o hello.o
git clone https://github.com/libbpf/libbpf
cd libbpf/src
make BUILD_STATIC_ONLY=1 OBJDIR=../build/libbpf DESTDIR=../build
INCLUDEDIR= LIBDIR= UAPIDIR= install
cd ../../
clang -Wall -O2 -g hello.o libbpf/build/libbpf.a -lelf -lz -o hello
clang -g -O2 -target bpf -D__TARGET_ARCH_x86_64 -I . -c maps.bpf.c -o maps.bpf.o
bpftool gen skeleton maps.bpf.o > maps.skel.h
clang -g -O2 -Wall -I . -c maps.c -o maps.o
clang -Wall -O2 -g maps.o libbpf/build/libbpf.a -lelf -lz -o maps


Both binaries are executable on Debian 11. Then I tried to move them
into Debain 9 and Debian 10.
Here are some informations about Debian9:


# uname -r
4.9.0-16-amd64

# grep BPF /boot/config-4.9.0-16-amd64
CONFIG_BPF=y
CONFIG_BPF_SYSCALL=y
# CONFIG_BPF_JIT_ALWAYS_ON is not set
CONFIG_NETFILTER_XT_MATCH_BPF=m
CONFIG_NET_CLS_BPF=m
CONFIG_NET_ACT_BPF=m
CONFIG_BPF_JIT=y
CONFIG_HAVE_EBPF_JIT=y
CONFIG_BPF_EVENTS=y
CONFIG_TEST_BPF=m

# ./hello
libbpf: kernel doesn't support global data
libbpf: failed to load object 'hello_bpf'
libbpf: failed to load BPF skeleton 'hello_bpf': -95
failed to load BPF object -95

# ./maps
libbpf: load bpf program failed: Permission denied
libbpf: -- BEGIN DUMP LOG ---
libbpf:
0: (85) call 15
1: (bf) r6 = r0
2: (85) call 14
3: (63) *(u32 *)(r10 -4) = r0
4: (b7) r1 = 0
5: (7b) *(u64 *)(r10 -32) = r1
6: (7b) *(u64 *)(r10 -24) = r1
7: (7b) *(u64 *)(r10 -16) = r1
8: (bf) r2 = r10
9: (07) r2 += -4
10: (bf) r3 = r10
11: (07) r3 += -32
12: (18) r1 = 0xffff88253a768480
14: (b7) r4 = 1
15: (85) call 2
16: (55) if r0 != 0x0 goto pc+12
 R0=inv,min_value=0,max_value=0 R6=inv R10=fp
17: (bf) r2 = r10
18: (07) r2 += -4
19: (18) r1 = 0xffff88253a768480
21: (85) call 1
22: (15) if r0 == 0x0 goto pc+6
 R0=map_value(ks=4,vs=24,id=0),min_value=0,max_value=0 R6=inv R10=fp
23: (61) r1 = *(u32 *)(r10 -4)
24: (63) *(u32 *)(r0 +20) = r6
25: (63) *(u32 *)(r0 +16) = r1
26: (bf) r1 = r0
27: (b7) r2 = 16
28: (85) call 16
R1 type=map_value expected=fp

libbpf: -- END LOG --
libbpf: failed to load program 'tracepoint__syscalls__sys_enter_execve'
libbpf: failed to load object 'maps_bpf'
libbpf: failed to load BPF skeleton 'maps_bpf': -4007
failed to load BPF object -4007

Both binaries failed on Debian 9. Now to Debian 10:

# uname -r
4.19.0-17-amd64

# grep BPF /boot/config-4.19.0-17-amd64
CONFIG_CGROUP_BPF=y
CONFIG_BPF=y
CONFIG_BPF_SYSCALL=y
# CONFIG_BPF_JIT_ALWAYS_ON is not set
CONFIG_IPV6_SEG6_BPF=y
CONFIG_NETFILTER_XT_MATCH_BPF=m
# CONFIG_BPFILTER is not set
CONFIG_NET_CLS_BPF=m
CONFIG_NET_ACT_BPF=m
CONFIG_BPF_JIT=y
CONFIG_BPF_STREAM_PARSER=y
CONFIG_LWTUNNEL_BPF=y
CONFIG_HAVE_EBPF_JIT=y
CONFIG_BPF_EVENTS=y
# CONFIG_BPF_KPROBE_OVERRIDE is not set
CONFIG_TEST_BPF=m

# ./hello
libbpf: Error loading BTF: Invalid argument(22)
libbpf: magic: 0xeb9f
version: 1
flags: 0x0
hdr_len: 24
type_off: 0
type_len: 464
str_off: 464
str_len: 415
btf_total_size: 903
[1] PTR (anon) type_id=2
[2] STRUCT trace_event_raw_sys_enter size=64 vlen=4
ent type_id=3 bits_offset=0
id type_id=7 bits_offset=64
args type_id=9 bits_offset=128
__data type_id=12 bits_offset=512
[3] STRUCT trace_entry size=8 vlen=4
type type_id=4 bits_offset=0
flags type_id=5 bits_offset=16
preempt_count type_id=5 bits_offset=24
pid type_id=6 bits_offset=32
[4] INT unsigned short size=2 bits_offset=0 nr_bits=16 encoding=(none)
[5] INT unsigned char size=1 bits_offset=0 nr_bits=8 encoding=(none)
[6] INT int size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
[7] INT long size=8 bits_offset=0 nr_bits=64 encoding=SIGNED
[8] INT unsigned long size=8 bits_offset=0 nr_bits=64 encoding=(none)
[9] ARRAY (anon) type_id=8 index_type_id=10 nr_elems=6
[10] INT __ARRAY_SIZE_TYPE__ size=4 bits_offset=0 nr_bits=32 encoding=(none)
[11] INT char size=1 bits_offset=0 nr_bits=8 encoding=SIGNED
[12] ARRAY (anon) type_id=11 index_type_id=10 nr_elems=0
[13] ENUM (anon) size=4 vlen=1
ctx val=1
[14] TYPEDEF tracepoint__syscalls__sys_enter_execve type_id=13
[15] CONST (anon) type_id=11
[16] ARRAY (anon) type_id=15 index_type_id=10 nr_elems=14
[17] INT tracepoint__syscalls__sys_enter_execve.____fmt size=1
bits_offset=0 nr_bits=8 encoding=(none)
[18] ARRAY (anon) type_id=11 index_type_id=10 nr_elems=4
[19] INT LICENSE size=1 bits_offset=0 nr_bits=8 encoding=(none)
[20] STRUCT _rodata size=14 vlen=1
tracepoint__syscalls__sys_enter_execve.____fmt type_id=17
bits_offset=0 Invalid name

libbpf: Error loading .BTF into kernel: -22. BTF is optional, ignoring.
libbpf: kernel doesn't support global data
libbpf: failed to load object 'hello_bpf'
libbpf: failed to load BPF skeleton 'hello_bpf': -95
failed to load BPF object -95

# ./maps
printing executed commands


"hello" failed on Debian 10, but "maps" succeeded. How can I improve
my result? Maybe make them CO-RE-able on Debain 9?
