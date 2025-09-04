Return-Path: <bpf+bounces-67498-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E23F4B44749
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 22:27:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97F9C3B8A29
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 20:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5CED27FD64;
	Thu,  4 Sep 2025 20:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hPhmN8Uc"
X-Original-To: bpf@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07437253F05
	for <bpf@vger.kernel.org>; Thu,  4 Sep 2025 20:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757017657; cv=none; b=o3m8SbtUuo3FOr6noaaezLFkpbCIQtdwYAg7mX9iWPiKsAIqM1nmBIH26DaSGLF5HiALqMwqCQ+3mm8Vi4V3gewe+xapmeondBi5yDEH0QHcWB+82aR++efQefixmKHPyNjIGParHK/BQ0hxYqd45lF8do8ixVjSe6jDNofwWNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757017657; c=relaxed/simple;
	bh=Z5JjN9mCwFvcks1Mhymd7TTcqdH8SQnlByPxlycpaMw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=utT6/ipnr/rLjhgHh/7CVRHzxyE1TpychF6pCiQNAImrW3jiSl4Mm+ax/HrnHSkRcb0QV9X/5O3xq1k1GOqW6DlLWHmt4BaQsgfnLztJLvdogHIcDTbPoPFEIrEoIWyjZSO9Sk+SUiGYkQyZKd0sk02I3mGJ0ntp7MqubH8sR/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hPhmN8Uc; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <d75eb424-b399-4e17-800e-ca59d39cc10d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757017651;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4Q+xs8MBpst4BAhwZ37TRA0Py4ruiugrQDP0m5qxl0g=;
	b=hPhmN8UcDyIvRz0efOtp+sAzE7sqOWKEc03aiADtsmCfY3L1a9DsvbyfpmH6QUtIXhYoqQ
	sCwBVETj5cyllnqYeTvCG4mhwNRhttq1nXYBOB6/7b5E0YJ5DHLtNW60QbI8+I5xY0nKms
	mMl+Q9p4KB1FChFVLyC1Aj+NPEiJ1KY=
Date: Thu, 4 Sep 2025 13:27:26 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v1 bpf-next 00/11] BPF indirect jumps
Content-Language: en-GB
To: Anton Protopopov <a.s.protopopov@gmail.com>, bpf@vger.kernel.org,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Anton Protopopov <aspsk@isovalent.com>,
 Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman
 <eddyz87@gmail.com>, Quentin Monnet <qmo@kernel.org>
References: <20250816180631.952085-1-a.s.protopopov@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20250816180631.952085-1-a.s.protopopov@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 8/16/25 11:06 AM, Anton Protopopov wrote:
> This patchset implements a new type of map, instruction set, and uses
> it to build support for indirect branches in BPF (on x86). (The same
> map will be later used to provide support for indirect calls and static
> keys.) See [1], [2] for more context.
>
> This patch set is a follow-up on the initial RFC [3], now converted to
> normal version to trigger CI. Note that GCC and non-x86 archs are not
> supposed to work.
>
> Short table of contents:
>
>    * Patches 1-6 implement the new map of type
>      BPF_MAP_TYPE_INSN_SET and corresponding selftests. This map can
>      be used to track the "original -> xlated -> jitted mapping" for
>      a given program. Patches 5,6 add support for "blinded" variant.
>
>    * Patches 7,8,9 implement the support for indirect jumps
>
>    * Patches 10,11 add support for LLVM-compiled programs containing
>      indirect jumps.
>
> A special LLVM should be used for that, see [4] for the details and
> some related discussions. Due to this fact, selftests for indirect
> jumps which directly use `goto *rX` are commented out (such that
> CI can run).
>
> There is a list of TBDs (mostly, more selftests + some limitations
> like maximal map size), however, all the selftests which compile
> to contain an indirect jump work with this patchset.
>
> See individual patches for more details on implementation details.
>
> Changes since RFC:
>
>    * I've tried to address all the comments provided by Alexei and
>      Eduard in RFC. Will try to list the most important of them below.
>
>    * One big change: move from older LLVM version [5] to newer [4].
>      Now LLVM generates jump tables as symbols in the new special
>      section ".jumptables". Another part of this change is that
>      libbpf now doesn't try to link map load and goto *rX, as
>      1) this is absolutely not reliable 2) for some use cases this
>      is impossible (namely, when more than one jump table can be used
>      in the same gotox instruction).
>
>    * Added insn_successors() support (Alexei, Eduard). This includes
>      getting rid of the ugly bpf_insn_set_iter_xlated_offset()
>      interface (Eduard).
>
>    * Removed hack for the unreachable instruction, as new LLVM thank to
>      Eduard doesn't generate it.
>
>    * Set mem_size for direct map access properly instead of hacking.
>      Remove off>0 check. (Alexei)
>
>    * Do not allocate new memory for min_index/max_index (Alexei, Eduard)
>
>    * Information required during check_cfg is now cached to be reused
>      later (Alexei + general logic for supporting multiple JT per jump)
>
>    * Properly compare registers in regsafe (Alexei, Eduard)
>
>    * Remove support for JMP32 (Eduard)
>
>    * Better checks in adjust_ptr_min_max_vals (Eduard)
>
>    * More selftests were added (but still there's room for more) which
>      directly use gotox (Alexei)
>
>    * More checks and verbose messages added
>
>    * "unique pointers" are no more in the map
>
> Links:
>    1. https://lpc.events/event/18/contributions/1941/
>    2. https://lwn.net/Articles/1017439/
>    3. https://lore.kernel.org/bpf/20250615085943.3871208-1-a.s.protopopov@gmail.com/
>    4. https://github.com/llvm/llvm-project/pull/149715
>
> Anton Protopopov (11):
>    bpf: fix the return value of push_stack
>    bpf: save the start of functions in bpf_prog_aux
>    bpf, x86: add new map type: instructions array
>    selftests/bpf: add selftests for new insn_array map
>    bpf: support instructions arrays with constants blinding
>    selftests/bpf: test instructions arrays with blinding
>    bpf, x86: allow indirect jumps to r8...r15
>    bpf, x86: add support for indirect jumps
>    bpf: disasm: add support for BPF_JMP|BPF_JA|BPF_X
>    libbpf: support llvm-generated indirect jumps
>    selftests/bpf: add selftests for indirect jumps
>
>   arch/x86/net/bpf_jit_comp.c                   |  39 +-
>   include/linux/bpf.h                           |  30 +
>   include/linux/bpf_types.h                     |   1 +
>   include/linux/bpf_verifier.h                  |  20 +-
>   include/uapi/linux/bpf.h                      |  11 +
>   kernel/bpf/Makefile                           |   2 +-
>   kernel/bpf/bpf_insn_array.c                   | 350 ++++++++++
>   kernel/bpf/core.c                             |  20 +
>   kernel/bpf/disasm.c                           |   9 +
>   kernel/bpf/syscall.c                          |  22 +
>   kernel/bpf/verifier.c                         | 603 ++++++++++++++++--
>   .../bpf/bpftool/Documentation/bpftool-map.rst |   2 +-
>   tools/bpf/bpftool/map.c                       |   2 +-
>   tools/include/uapi/linux/bpf.h                |  11 +
>   tools/lib/bpf/libbpf.c                        | 159 ++++-
>   tools/lib/bpf/libbpf_probes.c                 |   4 +
>   tools/lib/bpf/linker.c                        |  12 +-
>   tools/testing/selftests/bpf/Makefile          |   4 +-
>   .../selftests/bpf/prog_tests/bpf_goto_x.c     | 132 ++++
>   .../selftests/bpf/prog_tests/bpf_insn_array.c | 498 +++++++++++++++
>   .../testing/selftests/bpf/progs/bpf_goto_x.c  | 384 +++++++++++
>   21 files changed, 2230 insertions(+), 85 deletions(-)
>   create mode 100644 kernel/bpf/bpf_insn_array.c
>   create mode 100644 tools/testing/selftests/bpf/prog_tests/bpf_goto_x.c
>   create mode 100644 tools/testing/selftests/bpf/prog_tests/bpf_insn_array.c
>   create mode 100644 tools/testing/selftests/bpf/progs/bpf_goto_x.c
>
After indirect jumps, the next natural steps will be supporting callx
and static key in bpf programs.

For static keys, currently, llvm supports gotol_or_nop/nop_or_gotol insns
(https://github.com/llvm/llvm-project/compare/main...aspsk:llvm-project:static-keys)
and these insns can only be used in inline asm.

For callx, there are two patterns, one is calling a particular func with
flow sensitive analysis, another is calling through call stable.

The following two examples are to call a partuclar func with current
variable to tracing register.

Example 1:

typedef int (*op_t)(int, int); static int add(int a, int b) { return a + 
b; } static int mul(int a, int b) { return a * b; } static int 
apply(op_t f, int a, int b) { // indirect call via function pointer 
return f(a, b); } int result(int i, int j) { op_t f; if (i + j) f = add; 
else f = mul; return apply(f, i, j); } The asm code:
result:                                 # @result
# %bb.0:
         w4 = w2
         w4 = -w4
         r3 = mul ll
         if w1 == w4 goto LBB0_2
# %bb.1:
         r3 = add ll
LBB0_2:
         callx r3
         exit

Example 2:

typedef int (*op_t)(int, int);

__attribute__((section("_add"))) static int add(int a, int b) { return a + b; }
__attribute__((section("_mul"))) static int mul(int a, int b) { return a * b; }

struct ctx {
   op_t f;
};

__attribute__((noinline)) static int apply(struct ctx *ctx, int a, int b) {
     // indirect call via function pointer
     return ctx->f(a, b);
}

int result(int i, int j) {
     int x = 2, y = 3;
     struct ctx ctx;

     if (i&2) ctx.f = add;
     else ctx.f = mul;
     int r1 = apply(&ctx, x, y);
     int r2 = apply(&ctx, x, y);

     return r1 + r2;
}

asm code:

result:                                 # @result
# %bb.0:
         w1 &= 2
         r2 = mul ll
         if w1 == 0 goto LBB0_2
# %bb.1:
         r2 = add ll
LBB0_2:
         *(u64 *)(r10 - 8) = r2
         r6 = r10
         r6 += -8
         r1 = r6
         call apply
         w7 = w0
         r1 = r6
         call apply
         w0 += w7
         exit
...
apply:                                  # @apply
# %bb.0:
         r3 = *(u64 *)(r1 + 0)
         w1 = 2
         w2 = 3
         callx r3
         exit

In the above two cases, current verifier can be enhanced to
track functions and eventuall 'callx r3' can find proper
targets.

Another pattern is to have a calltable (similar to jump table)
and callx will call one of functions based on calltable base
and an index. The example is below:

typedef int (*op_t)(int, int);

__attribute__((section("_add"))) static int add(int a, int b) { return a + b; }
__attribute__((section("_mul"))) static int mul(int a, int b) { return a * b; }

__attribute__((noinline)) static int apply(op_t *ops, int index, int a, int b) {
     // indirect call via function pointer
     return ops[index](a, b);
}

int result(int i, int j) {
     op_t ops[] = { add, mul, add, add, mul, mul };
     int x = 2, y = 3;

     int r1 = apply(ops, 0, x, y);
     int r2 = apply(ops, 4, x, y);

     return r1 + r2;
}

int result2(int i, int j) {
     op_t ops[] = { add, add, add, mul, mul };
     int x = 3, y = 2;

     int r1 = apply(ops, 1, x, y);
     int r2 = apply(ops, 2, x, y);

     return r1 + r2;
}


The related llvm IR:

@__const.result.ops = private unnamed_addr constant [6 x ptr] [ptr @add, ptr @mul, ptr @add, ptr @add, ptr @mul, ptr @mul], align 8
@__const.result2.ops = private unnamed_addr constant [5 x ptr] [ptr @add, ptr @add, ptr @add, ptr @mul, ptr @mul], align 8

; Function Attrs: nounwind
define dso_local i32 @result(i32 noundef %0, i32 noundef %1) local_unnamed_addr #0 {
   %3 = tail call fastcc i32 @apply(ptr noundef @__const.result.ops, i32 noundef 0, i32 noundef 2, i32 noundef 3)
   %4 = tail call fastcc i32 @apply(ptr noundef @__const.result.ops, i32 noundef 4, i32 noundef 2, i32 noundef 3)
   %5 = add nsw i32 %4, %3
   ret i32 %5
}
...
; Function Attrs: noinline nounwind
define internal fastcc i32 @apply(ptr noundef nonnull readonly captures(none) %0, i32 noundef range(i32 0, 5) %1, i32 noundef range(i32 2, 4) %2, i32 noundef range(i32 2, 4) %3) unnamed_addr #2 {
   %5 = zext nneg i32 %1 to i64
   %6 = getelementptr inbounds nuw ptr, ptr %0, i64 %5
   %7 = load ptr, ptr %6, align 8, !tbaa !3
   %8 = tail call i32 %7(i32 noundef %2, i32 noundef %3) #3
   ret i32 %8
}

; Function Attrs: nounwind
define dso_local i32 @result2(i32 noundef %0, i32 noundef %1) local_unnamed_addr #0 {
   %3 = tail call fastcc i32 @apply(ptr noundef @__const.result2.ops, i32 noundef 1, i32 noundef 3, i32 noundef 2)
   %4 = tail call fastcc i32 @apply(ptr noundef @__const.result2.ops, i32 noundef 2, i32 noundef 3, i32 noundef 2)
   %5 = add nsw i32 %4, %3
   ret i32 %5
}

To make
    @__const.result.ops = private unnamed_addr constant [6 x ptr] [ptr @add, ptr @mul, ptr @add, ptr @add, ptr @mul, ptr @mul], align 8
explicit for call table, the llvm changed the call table name (with a llvm hack) to be like
    BPF.__const.result.ops

The llvm hack on top of https://github.com/llvm/llvm-project/pull/149715:

commit 7b3d21831d2e2ccc77ec09553297e955e480eb96 (HEAD -> jumptable-v17-callx)
Author: Yonghong Song <yonghong.song@linux.dev>
Date:   Thu Sep 4 10:02:56 2025 -0700

     callx

diff --git a/llvm/lib/Target/BPF/BPFCheckAndAdjustIR.cpp b/llvm/lib/Target/BPF/BPFCheckAndAdjustIR.cpp
index b202b20291af..3d6a2c047d7b 100644
--- a/llvm/lib/Target/BPF/BPFCheckAndAdjustIR.cpp
+++ b/llvm/lib/Target/BPF/BPFCheckAndAdjustIR.cpp
@@ -55,6 +55,7 @@ private:
    bool sinkMinMax(Module &M);
    bool removeGEPBuiltins(Module &M);
    bool insertASpaceCasts(Module &M);
+  bool renameCallTableGlobal(Module &M);
  };
  } // End anonymous namespace
  
@@ -527,12 +528,39 @@ bool BPFCheckAndAdjustIR::insertASpaceCasts(Module &M) {
    return Changed;
  }
  
+bool BPFCheckAndAdjustIR::renameCallTableGlobal(Module &M) {
+  bool Changed = false;
+  for (GlobalVariable &Global : M.globals()) {
+    if (Global.getLinkage() != GlobalValue::PrivateLinkage)
+      continue;
+    if (!Global.isConstant() || !Global.hasInitializer())
+      continue;
+
+    Constant *CV = dyn_cast<Constant>(Global.getInitializer());
+    if (!CV)
+      continue;
+    ConstantArray *CA = dyn_cast<ConstantArray>(CV);
+    if (!CA)
+      continue;
+
+    for (unsigned i = 1, e = CA->getNumOperands(); i != e; ++i) {
+      if (!dyn_cast<Function>(CA->getOperand(i)))
+        continue;
+    }
+    Global.setName("BPF." + Global.getName());
+    Global.setLinkage(GlobalValue::LinkageTypes::InternalLinkage);
+    Global.setSection(".calltables");
+    Changed = true;
+  }
+
+  return Changed;
+}
+
  bool BPFCheckAndAdjustIR::adjustIR(Module &M) {
    bool Changed = removePassThroughBuiltin(M);
    Changed = removeCompareBuiltin(M) || Changed;
    Changed = sinkMinMax(M) || Changed;
    Changed = removeGEPBuiltins(M) || Changed;
    Changed = insertASpaceCasts(M) || Changed;
+  Changed = renameCallTableGlobal(M) || Changed;
    return Changed;
  }


At the end, we will have asm code:

result:                                 # @result
# %bb.0:
         r1 = BPF.__const.result.ops ll
         w2 = 0
         w3 = 2
         w4 = 3
         call apply
         w6 = w0
         r1 = BPF.__const.result.ops ll
         w2 = 4
         w3 = 2
         w4 = 3
         call apply
         w0 += w6
         exit
.Lfunc_end0:
         .size   result, .Lfunc_end0-result
...
  apply:                                  # @apply
# %bb.0:
         r2 = w2
         r2 <<= 3
         r1 += r2
         r5 = *(u64 *)(r1 + 0)
         w1 = w3
         w2 = w4
         callx r5
         exit
.Lfunc_end3:
         .size   apply, .Lfunc_end3-apply
...
         .section        .calltables,"a",@progbits
         .p2align        3, 0x0
BPF.__const.result.ops:
         .quad   add
         .quad   mul
         .quad   add
         .quad   add
         .quad   mul
         .quad   mul
         .size   BPF.__const.result.ops, 48

         .type   BPF.__const.result2.ops,@object # @BPF.__const.result2.ops
         .p2align        3, 0x0
BPF.__const.result2.ops:
         .quad   add
         .quad   add
         .quad   add
         .quad   mul
         .quad   mul
         .size   BPF.__const.result2.ops, 40

$ llvm-readelf -s t.o
...
      2: 0000000000000000    48 OBJECT  LOCAL  DEFAULT     6 BPF.__const.result.ops
      8: 0000000000000030    40 OBJECT  LOCAL  DEFAULT     6 BPF.__const.result2.ops
      9: 0000000000000000     0 SECTION LOCAL  DEFAULT     6 .calltables

0000000000000000 <result>:
        0:       18 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 r1 = 0x0 ll
                 0000000000000000:  R_BPF_64_64  .calltables
        2:       b4 02 00 00 00 00 00 00 w2 = 0x0
        3:       b4 03 00 00 02 00 00 00 w3 = 0x2
        4:       b4 04 00 00 03 00 00 00 w4 = 0x3
        5:       85 10 00 00 09 00 00 00 call 0x9
        6:       bc 06 00 00 00 00 00 00 w6 = w0
        7:       18 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 r1 = 0x0 ll
                 0000000000000038:  R_BPF_64_64  .calltables
        9:       b4 02 00 00 04 00 00 00 w2 = 0x4
       10:       b4 03 00 00 02 00 00 00 w3 = 0x2
       11:       b4 04 00 00 03 00 00 00 w4 = 0x3
       12:       85 10 00 00 02 00 00 00 call 0x2
       13:       0c 60 00 00 00 00 00 00 w0 += w6
       14:       95 00 00 00 00 00 00 00 exit
...
00000000000000b8 <result2>:
       23:       18 01 00 00 30 00 00 00 00 00 00 00 00 00 00 00 r1 = 0x30 ll
                 00000000000000b8:  R_BPF_64_64  .calltables
       25:       b4 02 00 00 01 00 00 00 w2 = 0x1
       26:       b4 03 00 00 03 00 00 00 w3 = 0x3
       27:       b4 04 00 00 02 00 00 00 w4 = 0x2
       28:       85 10 00 00 f2 ff ff ff call -0xe
       29:       bc 06 00 00 00 00 00 00 w6 = w0
       30:       18 01 00 00 30 00 00 00 00 00 00 00 00 00 00 00 r1 = 0x30 ll
                 00000000000000f0:  R_BPF_64_64  .calltables
       32:       b4 02 00 00 02 00 00 00 w2 = 0x2
       33:       b4 03 00 00 03 00 00 00 w3 = 0x3
       34:       b4 04 00 00 02 00 00 00 w4 = 0x2
       35:       85 10 00 00 eb ff ff ff call -0x15
       36:       0c 60 00 00 00 00 00 00 w0 += w6
       37:       95 00 00 00 00 00 00 00 exit


Relocation section '.rel.calltables' at offset 0x3d0 contains 11 entries:
     Offset             Info             Type               Symbol's Value  Symbol's Name
0000000000000000  0000000400000002 R_BPF_64_ABS64         0000000000000000 _add
0000000000000008  0000000600000002 R_BPF_64_ABS64         0000000000000000 _mul
0000000000000010  0000000400000002 R_BPF_64_ABS64         0000000000000000 _add
0000000000000018  0000000400000002 R_BPF_64_ABS64         0000000000000000 _add
0000000000000020  0000000600000002 R_BPF_64_ABS64         0000000000000000 _mul
0000000000000028  0000000600000002 R_BPF_64_ABS64         0000000000000000 _mul
0000000000000030  0000000400000002 R_BPF_64_ABS64         0000000000000000 _add
0000000000000038  0000000400000002 R_BPF_64_ABS64         0000000000000000 _add
0000000000000040  0000000400000002 R_BPF_64_ABS64         0000000000000000 _add
0000000000000048  0000000600000002 R_BPF_64_ABS64         0000000000000000 _mul
0000000000000050  0000000600000002 R_BPF_64_ABS64         0000000000000000 _mul

For the disasm code, the first two relocations clearly points to
BPF.__const.result.ops, and the next two relocations point to
BPF.__const.result2.ops.


