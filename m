Return-Path: <bpf+bounces-36433-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF926948576
	for <lists+bpf@lfdr.de>; Tue,  6 Aug 2024 00:36:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 657AA1F239DA
	for <lists+bpf@lfdr.de>; Mon,  5 Aug 2024 22:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39E0B16F824;
	Mon,  5 Aug 2024 22:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qx3sZmy8"
X-Original-To: bpf@vger.kernel.org
Received: from out-176.mta0.migadu.com (out-176.mta0.migadu.com [91.218.175.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F8042A9F
	for <bpf@vger.kernel.org>; Mon,  5 Aug 2024 22:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722897389; cv=none; b=C2VkNjnARy+A8+4TEE8XTB0dIj+mn8YCHqA0WeMN2Ks4t0p7fzZkj08/YyxvPv/3pzP6xhqu2xwefhNJLy3bLC6hKCobVH7JuUwESA0b5R3qdUdkct4RGdWQD6FN8AVb4co3mL9I6eLjGa3K/4LjmvD3TlAYeuPbQ76UiakC4lI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722897389; c=relaxed/simple;
	bh=NAaH44Si0ucoApVJ/lzNvIyA9f+N6xIJmg3UXG1Lpjk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p5eNmZI61LAscXEac1TRkZ7XAAwaZ7V5lxxEAmiZJOZkcb4YQZX0goXlWJUeEvEMfRhGlhMlHX88vvGAGyItV0cARF8nE1px6NkcENDghSFXldUPOjg/qifsKJLSocJVXkpO63cyEtcfcCa8T9ozEmhjWrlsDzKd2g++p9On1Mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qx3sZmy8; arc=none smtp.client-ip=91.218.175.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <e42a26b6-1520-40b9-850a-28d660bd9149@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1722897383;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b3wTn+iacl+6SFiGcOleAnCeN3SFx1xPrjGmg8hYUec=;
	b=qx3sZmy8/ZiuPR9XeSUxS80KMGVxnA4zvXXvPZuvQsF+9X7JAan49ZGhiJ8J+ccQWjECv7
	h5sWsjQOenGFpFqbZ1k5CZcooy08fkdHkM8fzgh/r26nv38SY5cIg/DpQ/UPC0gJPtNFtg
	IJVaqKwrmTFrdRpGmUHm4MfhGUixkX4=
Date: Mon, 5 Aug 2024 15:36:17 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2] selftests/bpf: Fix arena_atomics selftest
 failure due to llvm change
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>
References: <20240803025928.4184433-1-yonghong.song@linux.dev>
 <CAADnVQKt8FQjuZKFTGbyf5uKGZ8gfjzSvC36CbZ7ENbkuCmopA@mail.gmail.com>
Content-Language: en-GB
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAADnVQKt8FQjuZKFTGbyf5uKGZ8gfjzSvC36CbZ7ENbkuCmopA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 8/5/24 10:53 AM, Alexei Starovoitov wrote:
> On Fri, Aug 2, 2024 at 7:59 PM Yonghong Song <yonghong.song@linux.dev> wrote:
>> Peilen Ye reported an issue ([1]) where for __sync_fetch_and_add(...) without
>> return value like
>>    __sync_fetch_and_add(&foo, 1);
>> llvm BPF backend generates locked insn e.g.
>>    lock *(u32 *)(r1 + 0) += r2
>>
>> If __sync_fetch_and_add(...) returns a value like
>>    res = __sync_fetch_and_add(&foo, 1);
>> llvm BPF backend generates like
>>    r2 = atomic_fetch_add((u32 *)(r1 + 0), r2)
>>
>> But 'lock *(u32 *)(r1 + 0) += r2' caused a problem in jit
>> since proper barrier is not inserted based on __sync_fetch_and_add() semantics.
>>
>> The above discrepancy is due to commit [2] where it tries to maintain backward
>> compatability since before commit [2], __sync_fetch_and_add(...) generates
>> lock insn in BPF backend.
>>
>> Based on discussion in [1], now it is time to fix the above discrepancy so we can
>> have proper barrier support in jit. llvm patch [3] made sure that __sync_fetch_and_add(...)
>> always generates atomic_fetch_add(...) insns. Now 'lock *(u32 *)(r1 + 0) += r2' can only
>> be generated by inline asm. The same for __sync_fetch_and_and(), __sync_fetch_and_or()
>> and __sync_fetch_and_xor().
>>
>> But the change in [3] caused arena_atomics selftest failure.
>>
>>    test_arena_atomics:PASS:arena atomics skeleton open 0 nsec
>>    libbpf: prog 'and': BPF program load failed: Permission denied
>>    libbpf: prog 'and': -- BEGIN PROG LOAD LOG --
>>    arg#0 reference type('UNKNOWN ') size cannot be determined: -22
>>    0: R1=ctx() R10=fp0
>>    ; if (pid != (bpf_get_current_pid_tgid() >> 32)) @ arena_atomics.c:87
>>    0: (18) r1 = 0xffffc90000064000       ; R1_w=map_value(map=arena_at.bss,ks=4,vs=4)
>>    2: (61) r6 = *(u32 *)(r1 +0)          ; R1_w=map_value(map=arena_at.bss,ks=4,vs=4) R6_w=scalar(smin=0,smax=umax=0xffffffff,var_off=(0x0; 0xffffffff))
>>    3: (85) call bpf_get_current_pid_tgid#14      ; R0_w=scalar()
>>    4: (77) r0 >>= 32                     ; R0_w=scalar(smin=0,smax=umax=0xffffffff,var_off=(0x0; 0xffffffff))
>>    5: (5d) if r0 != r6 goto pc+11        ; R0_w=scalar(smin=0,smax=umax=0xffffffff,var_off=(0x0; 0xffffffff)) R6_w=scalar(smin=0,smax=umax=0xffffffff,var_off=(0x0; 0x)
>>    ; __sync_fetch_and_and(&and64_value, 0x011ull << 32); @ arena_atomics.c:91
>>    6: (18) r1 = 0x100000000060           ; R1_w=scalar()
>>    8: (bf) r1 = addr_space_cast(r1, 0, 1)        ; R1_w=arena
>>    9: (18) r2 = 0x1100000000             ; R2_w=0x1100000000
>>    11: (db) r2 = atomic64_fetch_and((u64 *)(r1 +0), r2)
>>    BPF_ATOMIC stores into R1 arena is not allowed
>>    processed 9 insns (limit 1000000) max_states_per_insn 0 total_states 0 peak_states 0 mark_read 0
>>    -- END PROG LOAD LOG --
>>    libbpf: prog 'and': failed to load: -13
>>    libbpf: failed to load object 'arena_atomics'
>>    libbpf: failed to load BPF skeleton 'arena_atomics': -13
>>    test_arena_atomics:FAIL:arena atomics skeleton load unexpected error: -13 (errno 13)
>>    #3       arena_atomics:FAIL
>>
>> The reason of the failure is due to [4] where atomic{64,}_fetch_{and,or,xor}() are not
>> allowed by arena addresses. Without llvm patch [3], the compiler will generate 'lock ...'
>> insn and everything will work fine.
>>
>> This patch fixed the problem by using inline asms. Instead of __sync_fetch_and_{and,or,xor}() functions,
>> the inline asm with 'lock' insn is used and it will work with or without [3].
>> Note that three bpf programs ('and', 'or' and 'xor') are guarded with __BPF_FEATURE_ADDR_SPACE_CAST
>> as well to ensure compilation failure for llvm <= 18 version. Note that for llvm <= 18 where
>> addr_space_cast is not supported, all arena_atomics subtests are skipped with below message:
>>    test_arena_atomics:SKIP:no ENABLE_ATOMICS_TESTS or no addr_space_cast support in clang
>>    #3 arena_atomics:SKIP
>>
>>    [1] https://lore.kernel.org/bpf/ZqqiQQWRnz7H93Hc@google.com/T/#mb68d67bc8f39e35a0c3db52468b9de59b79f021f
>>    [2] https://github.com/llvm/llvm-project/commit/286daafd65129228e08a1d07aa4ca74488615744
>>    [3] https://github.com/llvm/llvm-project/pull/101428
>>    [4] d503a04f8bc0 ("bpf: Add support for certain atomics in bpf_arena to x86 JIT")
>>
>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>> ---
>>   .../selftests/bpf/progs/arena_atomics.c       | 63 ++++++++++++++++---
>>   1 file changed, 54 insertions(+), 9 deletions(-)
>>
>> Changelog:
>>    v1 -> v2:
>>      - Add __BPF_FEATURE_ADDR_SPACE_CAST to guard newly added asm codes for llvm >= 19
>>
>> diff --git a/tools/testing/selftests/bpf/progs/arena_atomics.c b/tools/testing/selftests/bpf/progs/arena_atomics.c
>> index bb0acd79d28a..dea54557fc00 100644
>> --- a/tools/testing/selftests/bpf/progs/arena_atomics.c
>> +++ b/tools/testing/selftests/bpf/progs/arena_atomics.c
>> @@ -5,6 +5,7 @@
>>   #include <bpf/bpf_tracing.h>
>>   #include <stdbool.h>
>>   #include "bpf_arena_common.h"
>> +#include "bpf_misc.h"
>>
>>   struct {
>>          __uint(type, BPF_MAP_TYPE_ARENA);
>> @@ -85,10 +86,24 @@ int and(const void *ctx)
>>   {
>>          if (pid != (bpf_get_current_pid_tgid() >> 32))
>>                  return 0;
>> -#ifdef ENABLE_ATOMICS_TESTS
>> +#if defined(ENABLE_ATOMICS_TESTS) && defined(__BPF_FEATURE_ADDR_SPACE_CAST)
>>
>> -       __sync_fetch_and_and(&and64_value, 0x011ull << 32);
>> -       __sync_fetch_and_and(&and32_value, 0x011);
>> +       asm volatile(
>> +               "r1 = addr_space_cast(%[and64_value], 0, 1);"
>> +               "lock *(u64 *)(r1 + 0) &= %[val]"
>> +               :
>> +               : __imm_ptr(and64_value),
>> +                 [val]"r"(0x011ull << 32)
>> +               : "r1"
>> +       );
>> +       asm volatile(
>> +               "r1 = addr_space_cast(%[and32_value], 0, 1);"
>> +               "lock *(u32 *)(r1 + 0) &= %[val]"
>> +               :
>> +               : __imm_ptr(and32_value),
>> +                 [val]"w"(0x011)
>> +               : "r1"
>> +       );
> Instead of inline asm there is a better way to do the same in C.
> https://godbolt.org/z/71PYx1oqE
>
> void foo(int a, _Atomic int *b)
> {
>   *b += a;
> }
>
> generates:
> lock *(u32 *)(r2 + 0) += r1

If you use latest llvm-project with
https://github.com/llvm/llvm-project/pull/101428
included, the above code will generate like

$ clang --target=bpf -O2 -c t.c && llvm-objdump -d t.o
t.o:    file format elf64-bpf
Disassembly of section .text:
0000000000000000 <foo>:
        0:       c3 12 00 00 01 00 00 00 r1 = atomic_fetch_add((u32 *)(r2 + 0x0), r1)
        1:       95 00 00 00 00 00 00 00 exit


With -mcpu=v3 the same code can be generated.

>
> but
> *b &= a;
>
> crashes llvm :( with
>
> <source>:3:5: error: unsupported atomic operation, please use 64 bit version
>      3 |  *b &= a;

It failed with the following llvm error message:
t.c:1:6: error: unsupported atomic operation, please use 64 bit version
     1 | void foo(int a, _Atomic int *b)
       |      ^
fatal error: error in backend: Cannot select: t8: i64,ch = AtomicLoadAnd<(load store seq_cst (s32) on %ir.b)> t0, t4, t2
   t4: i64,ch = CopyFromReg t0, Register:i64 %1
     t3: i64 = Register %1
   t2: i64,ch = CopyFromReg t0, Register:i64 %0
     t1: i64 = Register %0
In function: foo

>
> but works with -mcpu=v3

Yes. it does work with -mcpu=v3:

$ clang --target=bpf -O2 -mcpu=v3 -c t.c && llvm-objdump -d --mcpu=v3 t.o

t.o:    file format elf64-bpf
Disassembly of section .text:
0000000000000000 <foo>:
        0:       c3 12 00 00 51 00 00 00 w1 = atomic_fetch_and((u32 *)(r2 + 0x0), w1)
        1:       95 00 00 00 00 00 00 00 exit

NOTE: I need -mcpu=v3 for llvm-objdump to print asm code 'atomic_fetch_and' properly.
Will double check this.

For code:
void foo(int a, _Atomic int *b)
{
  *b &= a;
}

The initial IR generated by clang frontend is:

define dso_local void @foo(i32 noundef %a, ptr noundef %b) #0 {
entry:
   %a.addr = alloca i32, align 4
   %b.addr = alloca ptr, align 8
   store i32 %a, ptr %a.addr, align 4, !tbaa !3
   store ptr %b, ptr %b.addr, align 8, !tbaa !7
   %0 = load i32, ptr %a.addr, align 4, !tbaa !3
   %1 = load ptr, ptr %b.addr, align 8, !tbaa !7
   %2 = atomicrmw and ptr %1, i32 %0 seq_cst, align 4
   %3 = and i32 %2, %0
   ret void
}

Note that atomicrmw in the above. Eventually it optimized to

define dso_local void @foo(i32 noundef %a, ptr noundef %b) #0 {
entry:
   %0 = atomicrmw and ptr %b, i32 %a seq_cst, align 4
   ret void
}

The 'atomicrmw' is the same IR as generated by
__sync_fetch_and_*() and eventually will generate atomic_fetch_*() bpf 
insn.
Discussed with Andrii, and
another option is to specify relaxed consistency, so llvm
internal could translate it into locked insn. For example,

$ cat t1.c
#include <stdatomic.h>

void f(_Atomic int *i) {
   __c11_atomic_fetch_and(i, 1, memory_order_relaxed);
}

# to have gnu/stubs-32.h in the current directory to make it compile
[yhs@devvm1513.prn0 ~/tmp6]$ ls gnu
stubs-32.h
[yhs@devvm1513.prn0 ~/tmp6]$ clang --target=bpf -O2 -I. -c -mcpu=v3 t1.c

The initial IR:
define dso_local void @f(ptr noundef %i) #0 {
entry:
   %i.addr = alloca ptr, align 8
   %.atomictmp = alloca i32, align 4
   %atomic-temp = alloca i32, align 4
   store ptr %i, ptr %i.addr, align 8, !tbaa !3
   %0 = load ptr, ptr %i.addr, align 8, !tbaa !3
   store i32 1, ptr %.atomictmp, align 4, !tbaa !7
   %1 = load i32, ptr %.atomictmp, align 4
   %2 = atomicrmw and ptr %0, i32 %1 monotonic, align 4
   store i32 %2, ptr %atomic-temp, align 4
   %3 = load i32, ptr %atomic-temp, align 4, !tbaa !7
   ret void
}

The IR right before machine code generation:

define dso_local void @f(ptr nocapture noundef %i) local_unnamed_addr #0 {
entry:
   %0 = atomicrmw and ptr %i, i32 1 monotonic, align 4
   ret void
}

Maybe we could special process the above to generate
a locked insn if
   - atomicrmw operator
   - monotonic (related) consistency
   - return value is not used

So this will not violate original program semantics.
Does this sound a reasonable apporach?

>
> So let's make this test mcpu=v3 only and use normal C ?
>
> pw-bot: cr

