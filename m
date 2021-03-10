Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37481334267
	for <lists+bpf@lfdr.de>; Wed, 10 Mar 2021 17:05:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231282AbhCJQFE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 10 Mar 2021 11:05:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231718AbhCJQEd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 10 Mar 2021 11:04:33 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4045C061760;
        Wed, 10 Mar 2021 08:04:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=tKz4SitSoUdwuBfqIic/vYLXSfjTsz42VFoI20Izbfk=; b=nAbwjF1p4ePBPvf//1l4ZIAPyN
        PIuQUz9YdAiInX2e6t+5bllCe+yKjooEW8AM1OivHYNp62wwjfMmTfCldZbPLk+dU0D/CoaifkHdG
        txCRZhmif3jlcpUAbs902ramgajvrg8kjDYyBgufJqpb7MMNoMqu5w0TuP612t9c1xB7HNbX503+l
        dcVa296gRW4PFj6TbtDKnMTLn0jZQh2OFO+EqcnYX7uWWp9Bh2lBtuvX0rEWnR2ew9uenfpHj5lMr
        FJEm+odigbCegtLL6hSYRmSQhXL3NOfLyj0QRG3LP7NSkGaTU4+Kdiz4pGrYmw34u3mKctCXRQdmO
        5XcKHSBA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lK1Jr-003uVe-AG; Wed, 10 Mar 2021 16:04:20 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 35BDD3010CF;
        Wed, 10 Mar 2021 17:04:18 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2525820C99AA3; Wed, 10 Mar 2021 17:04:18 +0100 (CET)
Date:   Wed, 10 Mar 2021 17:04:18 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: The killing of ideal_nops[]
Message-ID: <YEjuArPJsSYDaYeI@hirez.programming.kicks-ass.net>
References: <20210309120519.7c6bbb97@gandalf.local.home>
 <YEfnnFUbizbJUQig@hirez.programming.kicks-ass.net>
 <362BD2A4-016D-4F6B-8974-92C84DC0DDB4@zytor.com>
 <YEiN+/Zp4uE/ISWD@hirez.programming.kicks-ass.net>
 <YEiS8Xws0tTFmMJp@hirez.programming.kicks-ass.net>
 <YEiZXtB74cnsLTx/@hirez.programming.kicks-ass.net>
 <YEid+HQnqgnt3iyY@hirez.programming.kicks-ass.net>
 <20210310091324.0c346d5f@oasis.local.home>
 <YEjWryS/9uB2y62O@hirez.programming.kicks-ass.net>
 <CAADnVQKMRWMuAJEJBPADactdKaGx4opg3y82m7fy59rRmA9Cog@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQKMRWMuAJEJBPADactdKaGx4opg3y82m7fy59rRmA9Cog@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Mar 10, 2021 at 07:48:08AM -0800, Alexei Starovoitov wrote:
> Ack for bpf bits.

Thanks!

> I think the cleanup is good from the point of having one way to do things.

Right, that was the motivation. Currently x86 is the sole architecture
(and thus weird and more complicated) where NOPs vary at runtime.

> Though I won't be surprised if somebody comes along with a patch
> to use different nops eventually.

I don't particularly care about the exact NOP encoding, as long as we
can all agree on it at build time. Having to either do boot time NOP
rewrites of everything or runtime compare against multiple NOPs is
complexity we don't need.

(and ideally the kernel and gas/clang .nops directives should agree with
one another, although that's not the case with the below patch for
32bit).

> When I first looked at it years ago I was wondering why segment selector
> prefix is not used. afaik windows was using it, because having cs: ds: nop
> makes intel use only one of the instruction decoders (the big and slow one)
> which allegedly saves power, since the pipeline has bubbles.
> Things could be completely different now in modern u-arches.

So we do use DS prefix for NOP[58] on 32bit. 64bit seems to prefer
OSP prefixes.

Below is the latest version which I just pushed out to my git tree so
that the robots can have a go at it.

---
Subject: x86: Remove dynamic NOP selection
From: Peter Zijlstra <peterz@infradead.org>
Date: Wed Mar 10 11:43:35 CET 2021

This ensures that a NOP is a NOP and not a random other instruction
that is also a NOP. It allows simplification of dynamic code patching
that wants to verify existing code before writing new instructions
(ftrace, jump_label, static_call, etc..).

Differentiating on NOPs is not a 'feature'.

After this FEATURE_NOPL is unused except for required-features for
x86_64. FEATURE_K8 is only used for PTI and FEATURE_K7 is unused.

AFAICT this negatively affects lots of 32bit (DONTCARE) and 32bit on
64bit CPUs (CARELESS) and early AMD K8 which is from 2003 and almost
2 decades old by now (SHRUG).

Everything x86_64 since AMD K10 (2007) is using p6_nops.

And per FEATURE_NOPL being required for x86_64, all those CPUs can use
p6_nops. So stop caring about NOPs, simplify things and get on with
life.

(more cleanups possible)

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/jump_label.h    |   12 --
 arch/x86/include/asm/nops.h          |  180 ++++++++++---------------------
 arch/x86/include/asm/special_insns.h |    4 
 arch/x86/kernel/alternative.c        |  198 +++--------------------------------
 arch/x86/kernel/ftrace.c             |    4 
 arch/x86/kernel/jump_label.c         |   32 +----
 arch/x86/kernel/kprobes/core.c       |    2 
 arch/x86/kernel/setup.c              |    1 
 arch/x86/kernel/static_call.c        |    4 
 arch/x86/net/bpf_jit_comp.c          |    8 -
 10 files changed, 98 insertions(+), 347 deletions(-)

--- a/arch/x86/include/asm/jump_label.h
+++ b/arch/x86/include/asm/jump_label.h
@@ -6,12 +6,6 @@
 
 #define JUMP_LABEL_NOP_SIZE 5
 
-#ifdef CONFIG_X86_64
-# define STATIC_KEY_INIT_NOP P6_NOP5_ATOMIC
-#else
-# define STATIC_KEY_INIT_NOP GENERIC_NOP5_ATOMIC
-#endif
-
 #include <asm/asm.h>
 #include <asm/nops.h>
 
@@ -23,7 +17,7 @@
 static __always_inline bool arch_static_branch(struct static_key * const key, const bool branch)
 {
 	asm_volatile_goto("1:"
-		".byte " __stringify(STATIC_KEY_INIT_NOP) "\n\t"
+		".byte " __stringify(BYTES_NOP5) "\n\t"
 		".pushsection __jump_table,  \"aw\" \n\t"
 		_ASM_ALIGN "\n\t"
 		".long 1b - ., %l[l_yes] - . \n\t"
@@ -63,7 +57,7 @@ static __always_inline bool arch_static_
 	.long		\target - .Lstatic_jump_after_\@
 .Lstatic_jump_after_\@:
 	.else
-	.byte		STATIC_KEY_INIT_NOP
+	.byte		BYTES_NOP5
 	.endif
 	.pushsection __jump_table, "aw"
 	_ASM_ALIGN
@@ -75,7 +69,7 @@ static __always_inline bool arch_static_
 .macro STATIC_JUMP_IF_FALSE target, key, def
 .Lstatic_jump_\@:
 	.if \def
-	.byte		STATIC_KEY_INIT_NOP
+	.byte		BYTES_NOP5
 	.else
 	/* Equivalent to "jmp.d32 \target" */
 	.byte		0xe9
--- a/arch/x86/include/asm/nops.h
+++ b/arch/x86/include/asm/nops.h
@@ -4,89 +4,58 @@
 
 /*
  * Define nops for use with alternative() and for tracing.
+ */
+
+#ifndef CONFIG_64BIT
+
+/*
+ * Generic 32bit nops from GAS:
+ *
+ * 1: nop
+ * 2: movl %esi,%esi
+ * 3: leal 0x00(%esi),%esi
+ * 4: leal 0x00(,%esi,1),%esi
+ * 5: leal %ds:0x00(,%esi,1),%esi
+ * 6: leal 0x00000000(%esi),%esi
+ * 7: leal 0x00000000(,%esi,1),%esi
+ * 8: leal %ds:0x00000000(,%esi,1),%esi
  *
- * *_NOP5_ATOMIC must be a single instruction.
+ * Except 5 and 8, which are DS prefixed 4 and 7 resp, where GAS would emit 2
+ * nop instructions.
  */
+#define BYTES_NOP1	0x90
+#define BYTES_NOP2	0x89,0xf6
+#define BYTES_NOP3	0x8d,0x76,0x00
+#define BYTES_NOP4	0x8d,0x74,0x26,0x00
+#define BYTES_NOP5	0x3e,BYTES_NOP4
+#define BYTES_NOP6	0x8d,0xb6,0x00,0x00,0x00,0x00
+#define BYTES_NOP7	0x8d,0xb4,0x26,0x00,0x00,0x00,0x00
+#define BYTES_NOP8	0x3e,BYTES_NOP7
+
+#else
 
-#define NOP_DS_PREFIX 0x3e
+/*
+ * Generic 64bit nops from GAS:
+ *
+ * 1: nop
+ * 2: osp nop
+ * 3: nopl (%eax)
+ * 4: nopl 0x00(%eax)
+ * 5: nopl 0x00(%eax,%eax,1)
+ * 6: osp nopl 0x00(%eax,%eax,1)
+ * 7: nopl 0x00000000(%eax)
+ * 8: nopl 0x00000000(%eax,%eax,1)
+ */
+#define BYTES_NOP1	0x90
+#define BYTES_NOP2	0x66,BYTES_NOP1
+#define BYTES_NOP3	0x0f,0x1f,0x00
+#define BYTES_NOP4	0x0f,0x1f,0x40,0x00
+#define BYTES_NOP5	0x0f,0x1f,0x44,0x00,0x00
+#define BYTES_NOP6	0x66,BYTES_NOP5
+#define BYTES_NOP7	0x0f,0x1f,0x80,0x00,0x00,0x00,0x00
+#define BYTES_NOP8	0x0f,0x1f,0x84,0x00,0x00,0x00,0x00,0x00
 
-/* generic versions from gas
-   1: nop
-   the following instructions are NOT nops in 64-bit mode,
-   for 64-bit mode use K8 or P6 nops instead
-   2: movl %esi,%esi
-   3: leal 0x00(%esi),%esi
-   4: leal 0x00(,%esi,1),%esi
-   6: leal 0x00000000(%esi),%esi
-   7: leal 0x00000000(,%esi,1),%esi
-*/
-#define GENERIC_NOP1 0x90
-#define GENERIC_NOP2 0x89,0xf6
-#define GENERIC_NOP3 0x8d,0x76,0x00
-#define GENERIC_NOP4 0x8d,0x74,0x26,0x00
-#define GENERIC_NOP5 GENERIC_NOP1,GENERIC_NOP4
-#define GENERIC_NOP6 0x8d,0xb6,0x00,0x00,0x00,0x00
-#define GENERIC_NOP7 0x8d,0xb4,0x26,0x00,0x00,0x00,0x00
-#define GENERIC_NOP8 GENERIC_NOP1,GENERIC_NOP7
-#define GENERIC_NOP5_ATOMIC NOP_DS_PREFIX,GENERIC_NOP4
-
-/* Opteron 64bit nops
-   1: nop
-   2: osp nop
-   3: osp osp nop
-   4: osp osp osp nop
-*/
-#define K8_NOP1 GENERIC_NOP1
-#define K8_NOP2	0x66,K8_NOP1
-#define K8_NOP3	0x66,K8_NOP2
-#define K8_NOP4	0x66,K8_NOP3
-#define K8_NOP5	K8_NOP3,K8_NOP2
-#define K8_NOP6	K8_NOP3,K8_NOP3
-#define K8_NOP7	K8_NOP4,K8_NOP3
-#define K8_NOP8	K8_NOP4,K8_NOP4
-#define K8_NOP5_ATOMIC 0x66,K8_NOP4
-
-/* K7 nops
-   uses eax dependencies (arbitrary choice)
-   1: nop
-   2: movl %eax,%eax
-   3: leal (,%eax,1),%eax
-   4: leal 0x00(,%eax,1),%eax
-   6: leal 0x00000000(%eax),%eax
-   7: leal 0x00000000(,%eax,1),%eax
-*/
-#define K7_NOP1	GENERIC_NOP1
-#define K7_NOP2	0x8b,0xc0
-#define K7_NOP3	0x8d,0x04,0x20
-#define K7_NOP4	0x8d,0x44,0x20,0x00
-#define K7_NOP5	K7_NOP4,K7_NOP1
-#define K7_NOP6	0x8d,0x80,0,0,0,0
-#define K7_NOP7	0x8D,0x04,0x05,0,0,0,0
-#define K7_NOP8	K7_NOP7,K7_NOP1
-#define K7_NOP5_ATOMIC NOP_DS_PREFIX,K7_NOP4
-
-/* P6 nops
-   uses eax dependencies (Intel-recommended choice)
-   1: nop
-   2: osp nop
-   3: nopl (%eax)
-   4: nopl 0x00(%eax)
-   5: nopl 0x00(%eax,%eax,1)
-   6: osp nopl 0x00(%eax,%eax,1)
-   7: nopl 0x00000000(%eax)
-   8: nopl 0x00000000(%eax,%eax,1)
-   Note: All the above are assumed to be a single instruction.
-	There is kernel code that depends on this.
-*/
-#define P6_NOP1	GENERIC_NOP1
-#define P6_NOP2	0x66,0x90
-#define P6_NOP3	0x0f,0x1f,0x00
-#define P6_NOP4	0x0f,0x1f,0x40,0
-#define P6_NOP5	0x0f,0x1f,0x44,0x00,0
-#define P6_NOP6	0x66,0x0f,0x1f,0x44,0x00,0
-#define P6_NOP7	0x0f,0x1f,0x80,0,0,0,0
-#define P6_NOP8	0x0f,0x1f,0x84,0x00,0,0,0,0
-#define P6_NOP5_ATOMIC P6_NOP5
+#endif /* CONFIG_64BIT */
 
 #ifdef __ASSEMBLY__
 #define _ASM_MK_NOP(x) .byte x
@@ -94,54 +63,19 @@
 #define _ASM_MK_NOP(x) ".byte " __stringify(x) "\n"
 #endif
 
-#if defined(CONFIG_MK7)
-#define ASM_NOP1 _ASM_MK_NOP(K7_NOP1)
-#define ASM_NOP2 _ASM_MK_NOP(K7_NOP2)
-#define ASM_NOP3 _ASM_MK_NOP(K7_NOP3)
-#define ASM_NOP4 _ASM_MK_NOP(K7_NOP4)
-#define ASM_NOP5 _ASM_MK_NOP(K7_NOP5)
-#define ASM_NOP6 _ASM_MK_NOP(K7_NOP6)
-#define ASM_NOP7 _ASM_MK_NOP(K7_NOP7)
-#define ASM_NOP8 _ASM_MK_NOP(K7_NOP8)
-#define ASM_NOP5_ATOMIC _ASM_MK_NOP(K7_NOP5_ATOMIC)
-#elif defined(CONFIG_X86_P6_NOP)
-#define ASM_NOP1 _ASM_MK_NOP(P6_NOP1)
-#define ASM_NOP2 _ASM_MK_NOP(P6_NOP2)
-#define ASM_NOP3 _ASM_MK_NOP(P6_NOP3)
-#define ASM_NOP4 _ASM_MK_NOP(P6_NOP4)
-#define ASM_NOP5 _ASM_MK_NOP(P6_NOP5)
-#define ASM_NOP6 _ASM_MK_NOP(P6_NOP6)
-#define ASM_NOP7 _ASM_MK_NOP(P6_NOP7)
-#define ASM_NOP8 _ASM_MK_NOP(P6_NOP8)
-#define ASM_NOP5_ATOMIC _ASM_MK_NOP(P6_NOP5_ATOMIC)
-#elif defined(CONFIG_X86_64)
-#define ASM_NOP1 _ASM_MK_NOP(K8_NOP1)
-#define ASM_NOP2 _ASM_MK_NOP(K8_NOP2)
-#define ASM_NOP3 _ASM_MK_NOP(K8_NOP3)
-#define ASM_NOP4 _ASM_MK_NOP(K8_NOP4)
-#define ASM_NOP5 _ASM_MK_NOP(K8_NOP5)
-#define ASM_NOP6 _ASM_MK_NOP(K8_NOP6)
-#define ASM_NOP7 _ASM_MK_NOP(K8_NOP7)
-#define ASM_NOP8 _ASM_MK_NOP(K8_NOP8)
-#define ASM_NOP5_ATOMIC _ASM_MK_NOP(K8_NOP5_ATOMIC)
-#else
-#define ASM_NOP1 _ASM_MK_NOP(GENERIC_NOP1)
-#define ASM_NOP2 _ASM_MK_NOP(GENERIC_NOP2)
-#define ASM_NOP3 _ASM_MK_NOP(GENERIC_NOP3)
-#define ASM_NOP4 _ASM_MK_NOP(GENERIC_NOP4)
-#define ASM_NOP5 _ASM_MK_NOP(GENERIC_NOP5)
-#define ASM_NOP6 _ASM_MK_NOP(GENERIC_NOP6)
-#define ASM_NOP7 _ASM_MK_NOP(GENERIC_NOP7)
-#define ASM_NOP8 _ASM_MK_NOP(GENERIC_NOP8)
-#define ASM_NOP5_ATOMIC _ASM_MK_NOP(GENERIC_NOP5_ATOMIC)
-#endif
+#define ASM_NOP1 _ASM_MK_NOP(BYTES_NOP1)
+#define ASM_NOP2 _ASM_MK_NOP(BYTES_NOP2)
+#define ASM_NOP3 _ASM_MK_NOP(BYTES_NOP3)
+#define ASM_NOP4 _ASM_MK_NOP(BYTES_NOP4)
+#define ASM_NOP5 _ASM_MK_NOP(BYTES_NOP5)
+#define ASM_NOP6 _ASM_MK_NOP(BYTES_NOP6)
+#define ASM_NOP7 _ASM_MK_NOP(BYTES_NOP7)
+#define ASM_NOP8 _ASM_MK_NOP(BYTES_NOP8)
 
 #define ASM_NOP_MAX 8
-#define NOP_ATOMIC5 (ASM_NOP_MAX+1)	/* Entry for the 5-byte atomic NOP */
 
 #ifndef __ASSEMBLY__
-extern const unsigned char * const *ideal_nops;
-extern void arch_init_ideal_nops(void);
+extern const unsigned char * const x86_nops[];
 #endif
 
 #endif /* _ASM_X86_NOPS_H */
--- a/arch/x86/include/asm/special_insns.h
+++ b/arch/x86/include/asm/special_insns.h
@@ -214,7 +214,7 @@ static inline void clflush(volatile void
 
 static inline void clflushopt(volatile void *__p)
 {
-	alternative_io(".byte " __stringify(NOP_DS_PREFIX) "; clflush %P0",
+	alternative_io(".byte 0x3e; clflush %P0",
 		       ".byte 0x66; clflush %P0",
 		       X86_FEATURE_CLFLUSHOPT,
 		       "+m" (*(volatile char __force *)__p));
@@ -225,7 +225,7 @@ static inline void clwb(volatile void *_
 	volatile struct { char x[64]; } *p = __p;
 
 	asm volatile(ALTERNATIVE_2(
-		".byte " __stringify(NOP_DS_PREFIX) "; clflush (%[pax])",
+		".byte 0x3e; clflush (%[pax])",
 		".byte 0x66; clflush (%[pax])", /* clflushopt (%%rax) */
 		X86_FEATURE_CLFLUSHOPT,
 		".byte 0x66, 0x0f, 0xae, 0x30",  /* clwb (%%rax) */
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -74,186 +74,30 @@ do {									\
 	}								\
 } while (0)
 
-/*
- * Each GENERIC_NOPX is of X bytes, and defined as an array of bytes
- * that correspond to that nop. Getting from one nop to the next, we
- * add to the array the offset that is equal to the sum of all sizes of
- * nops preceding the one we are after.
- *
- * Note: The GENERIC_NOP5_ATOMIC is at the end, as it breaks the
- * nice symmetry of sizes of the previous nops.
- */
-#if defined(GENERIC_NOP1) && !defined(CONFIG_X86_64)
-static const unsigned char intelnops[] =
+const unsigned char x86nops[] =
 {
-	GENERIC_NOP1,
-	GENERIC_NOP2,
-	GENERIC_NOP3,
-	GENERIC_NOP4,
-	GENERIC_NOP5,
-	GENERIC_NOP6,
-	GENERIC_NOP7,
-	GENERIC_NOP8,
-	GENERIC_NOP5_ATOMIC
-};
-static const unsigned char * const intel_nops[ASM_NOP_MAX+2] =
-{
-	NULL,
-	intelnops,
-	intelnops + 1,
-	intelnops + 1 + 2,
-	intelnops + 1 + 2 + 3,
-	intelnops + 1 + 2 + 3 + 4,
-	intelnops + 1 + 2 + 3 + 4 + 5,
-	intelnops + 1 + 2 + 3 + 4 + 5 + 6,
-	intelnops + 1 + 2 + 3 + 4 + 5 + 6 + 7,
-	intelnops + 1 + 2 + 3 + 4 + 5 + 6 + 7 + 8,
+	BYTES_NOP1,
+	BYTES_NOP2,
+	BYTES_NOP3,
+	BYTES_NOP4,
+	BYTES_NOP5,
+	BYTES_NOP6,
+	BYTES_NOP7,
+	BYTES_NOP8,
 };
-#endif
 
-#ifdef K8_NOP1
-static const unsigned char k8nops[] =
-{
-	K8_NOP1,
-	K8_NOP2,
-	K8_NOP3,
-	K8_NOP4,
-	K8_NOP5,
-	K8_NOP6,
-	K8_NOP7,
-	K8_NOP8,
-	K8_NOP5_ATOMIC
-};
-static const unsigned char * const k8_nops[ASM_NOP_MAX+2] =
-{
-	NULL,
-	k8nops,
-	k8nops + 1,
-	k8nops + 1 + 2,
-	k8nops + 1 + 2 + 3,
-	k8nops + 1 + 2 + 3 + 4,
-	k8nops + 1 + 2 + 3 + 4 + 5,
-	k8nops + 1 + 2 + 3 + 4 + 5 + 6,
-	k8nops + 1 + 2 + 3 + 4 + 5 + 6 + 7,
-	k8nops + 1 + 2 + 3 + 4 + 5 + 6 + 7 + 8,
-};
-#endif
-
-#if defined(K7_NOP1) && !defined(CONFIG_X86_64)
-static const unsigned char k7nops[] =
-{
-	K7_NOP1,
-	K7_NOP2,
-	K7_NOP3,
-	K7_NOP4,
-	K7_NOP5,
-	K7_NOP6,
-	K7_NOP7,
-	K7_NOP8,
-	K7_NOP5_ATOMIC
-};
-static const unsigned char * const k7_nops[ASM_NOP_MAX+2] =
-{
-	NULL,
-	k7nops,
-	k7nops + 1,
-	k7nops + 1 + 2,
-	k7nops + 1 + 2 + 3,
-	k7nops + 1 + 2 + 3 + 4,
-	k7nops + 1 + 2 + 3 + 4 + 5,
-	k7nops + 1 + 2 + 3 + 4 + 5 + 6,
-	k7nops + 1 + 2 + 3 + 4 + 5 + 6 + 7,
-	k7nops + 1 + 2 + 3 + 4 + 5 + 6 + 7 + 8,
-};
-#endif
-
-#ifdef P6_NOP1
-static const unsigned char p6nops[] =
-{
-	P6_NOP1,
-	P6_NOP2,
-	P6_NOP3,
-	P6_NOP4,
-	P6_NOP5,
-	P6_NOP6,
-	P6_NOP7,
-	P6_NOP8,
-	P6_NOP5_ATOMIC
-};
-static const unsigned char * const p6_nops[ASM_NOP_MAX+2] =
+const unsigned char * const x86_nops[ASM_NOP_MAX+1] =
 {
 	NULL,
-	p6nops,
-	p6nops + 1,
-	p6nops + 1 + 2,
-	p6nops + 1 + 2 + 3,
-	p6nops + 1 + 2 + 3 + 4,
-	p6nops + 1 + 2 + 3 + 4 + 5,
-	p6nops + 1 + 2 + 3 + 4 + 5 + 6,
-	p6nops + 1 + 2 + 3 + 4 + 5 + 6 + 7,
-	p6nops + 1 + 2 + 3 + 4 + 5 + 6 + 7 + 8,
+	x86nops,
+	x86nops + 1,
+	x86nops + 1 + 2,
+	x86nops + 1 + 2 + 3,
+	x86nops + 1 + 2 + 3 + 4,
+	x86nops + 1 + 2 + 3 + 4 + 5,
+	x86nops + 1 + 2 + 3 + 4 + 5 + 6,
+	x86nops + 1 + 2 + 3 + 4 + 5 + 6 + 7,
 };
-#endif
-
-/* Initialize these to a safe default */
-#ifdef CONFIG_X86_64
-const unsigned char * const *ideal_nops = p6_nops;
-#else
-const unsigned char * const *ideal_nops = intel_nops;
-#endif
-
-void __init arch_init_ideal_nops(void)
-{
-	switch (boot_cpu_data.x86_vendor) {
-	case X86_VENDOR_INTEL:
-		/*
-		 * Due to a decoder implementation quirk, some
-		 * specific Intel CPUs actually perform better with
-		 * the "k8_nops" than with the SDM-recommended NOPs.
-		 */
-		if (boot_cpu_data.x86 == 6 &&
-		    boot_cpu_data.x86_model >= 0x0f &&
-		    boot_cpu_data.x86_model != 0x1c &&
-		    boot_cpu_data.x86_model != 0x26 &&
-		    boot_cpu_data.x86_model != 0x27 &&
-		    boot_cpu_data.x86_model < 0x30) {
-			ideal_nops = k8_nops;
-		} else if (boot_cpu_has(X86_FEATURE_NOPL)) {
-			   ideal_nops = p6_nops;
-		} else {
-#ifdef CONFIG_X86_64
-			ideal_nops = k8_nops;
-#else
-			ideal_nops = intel_nops;
-#endif
-		}
-		break;
-
-	case X86_VENDOR_HYGON:
-		ideal_nops = p6_nops;
-		return;
-
-	case X86_VENDOR_AMD:
-		if (boot_cpu_data.x86 > 0xf) {
-			ideal_nops = p6_nops;
-			return;
-		}
-
-		fallthrough;
-
-	default:
-#ifdef CONFIG_X86_64
-		ideal_nops = k8_nops;
-#else
-		if (boot_cpu_has(X86_FEATURE_K8))
-			ideal_nops = k8_nops;
-		else if (boot_cpu_has(X86_FEATURE_K7))
-			ideal_nops = k7_nops;
-		else
-			ideal_nops = intel_nops;
-#endif
-	}
-}
 
 /* Use this to add nops to a buffer, then text_poke the whole buffer. */
 static void __init_or_module add_nops(void *insns, unsigned int len)
@@ -262,7 +106,7 @@ static void __init_or_module add_nops(vo
 		unsigned int noplen = len;
 		if (noplen > ASM_NOP_MAX)
 			noplen = ASM_NOP_MAX;
-		memcpy(insns, ideal_nops[noplen], noplen);
+		memcpy(insns, x86_nops[noplen], noplen);
 		insns += noplen;
 		len -= noplen;
 	}
@@ -1302,13 +1146,13 @@ static void text_poke_loc_init(struct te
 	default: /* assume NOP */
 		switch (len) {
 		case 2: /* NOP2 -- emulate as JMP8+0 */
-			BUG_ON(memcmp(emulate, ideal_nops[len], len));
+			BUG_ON(memcmp(emulate, x86_nops[len], len));
 			tp->opcode = JMP8_INSN_OPCODE;
 			tp->rel32 = 0;
 			break;
 
 		case 5: /* NOP5 -- emulate as JMP32+0 */
-			BUG_ON(memcmp(emulate, ideal_nops[NOP_ATOMIC5], len));
+			BUG_ON(memcmp(emulate, x86_nops[len], len));
 			tp->opcode = JMP32_INSN_OPCODE;
 			tp->rel32 = 0;
 			break;
--- a/arch/x86/kernel/ftrace.c
+++ b/arch/x86/kernel/ftrace.c
@@ -66,7 +66,7 @@ int ftrace_arch_code_modify_post_process
 
 static const char *ftrace_nop_replace(void)
 {
-	return ideal_nops[NOP_ATOMIC5];
+	return x86_nops[5];
 }
 
 static const char *ftrace_call_replace(unsigned long ip, unsigned long addr)
@@ -377,7 +377,7 @@ create_trampoline(struct ftrace_ops *ops
 		ip = trampoline + (jmp_offset - start_offset);
 		if (WARN_ON(*(char *)ip != 0x75))
 			goto fail;
-		ret = copy_from_kernel_nofault(ip, ideal_nops[2], 2);
+		ret = copy_from_kernel_nofault(ip, x86_nops[2], 2);
 		if (ret < 0)
 			goto fail;
 	}
--- a/arch/x86/kernel/jump_label.c
+++ b/arch/x86/kernel/jump_label.c
@@ -28,10 +28,8 @@ static void bug_at(const void *ip, int l
 }
 
 static const void *
-__jump_label_set_jump_code(struct jump_entry *entry, enum jump_label_type type, int init)
+__jump_label_set_jump_code(struct jump_entry *entry, enum jump_label_type type)
 {
-	const unsigned char default_nop[] = { STATIC_KEY_INIT_NOP };
-	const unsigned char *ideal_nop = ideal_nops[NOP_ATOMIC5];
 	const void *expect, *code;
 	const void *addr, *dest;
 	int line;
@@ -41,10 +39,8 @@ __jump_label_set_jump_code(struct jump_e
 
 	code = text_gen_insn(JMP32_INSN_OPCODE, addr, dest);
 
-	if (init) {
-		expect = default_nop; line = __LINE__;
-	} else if (type == JUMP_LABEL_JMP) {
-		expect = ideal_nop; line = __LINE__;
+	if (type == JUMP_LABEL_JMP) {
+		expect = x86_nops[5]; line = __LINE__;
 	} else {
 		expect = code; line = __LINE__;
 	}
@@ -53,7 +49,7 @@ __jump_label_set_jump_code(struct jump_e
 		bug_at(addr, line);
 
 	if (type == JUMP_LABEL_NOP)
-		code = ideal_nop;
+		code = x86_nops[5];
 
 	return code;
 }
@@ -62,7 +58,7 @@ static inline void __jump_label_transfor
 					  enum jump_label_type type,
 					  int init)
 {
-	const void *opcode = __jump_label_set_jump_code(entry, type, init);
+	const void *opcode = __jump_label_set_jump_code(entry, type);
 
 	/*
 	 * As long as only a single processor is running and the code is still
@@ -113,7 +109,7 @@ bool arch_jump_label_transform_queue(str
 	}
 
 	mutex_lock(&text_mutex);
-	opcode = __jump_label_set_jump_code(entry, type, 0);
+	opcode = __jump_label_set_jump_code(entry, type);
 	text_poke_queue((void *)jump_entry_code(entry),
 			opcode, JUMP_LABEL_NOP_SIZE, NULL);
 	mutex_unlock(&text_mutex);
@@ -136,22 +132,6 @@ static enum {
 __init_or_module void arch_jump_label_transform_static(struct jump_entry *entry,
 				      enum jump_label_type type)
 {
-	/*
-	 * This function is called at boot up and when modules are
-	 * first loaded. Check if the default nop, the one that is
-	 * inserted at compile time, is the ideal nop. If it is, then
-	 * we do not need to update the nop, and we can leave it as is.
-	 * If it is not, then we need to update the nop to the ideal nop.
-	 */
-	if (jlstate == JL_STATE_START) {
-		const unsigned char default_nop[] = { STATIC_KEY_INIT_NOP };
-		const unsigned char *ideal_nop = ideal_nops[NOP_ATOMIC5];
-
-		if (memcmp(ideal_nop, default_nop, 5) != 0)
-			jlstate = JL_STATE_UPDATE;
-		else
-			jlstate = JL_STATE_NO_UPDATE;
-	}
 	if (jlstate == JL_STATE_UPDATE)
 		jump_label_transform(entry, type, 1);
 }
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -229,7 +229,7 @@ __recover_probed_insn(kprobe_opcode_t *b
 		return 0UL;
 
 	if (faddr)
-		memcpy(buf, ideal_nops[NOP_ATOMIC5], 5);
+		memcpy(buf, x86_nops[5], 5);
 	else
 		buf[0] = kp->opcode;
 	return (unsigned long)buf;
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -822,7 +822,6 @@ void __init setup_arch(char **cmdline_p)
 
 	idt_setup_early_traps();
 	early_cpu_init();
-	arch_init_ideal_nops();
 	jump_label_init();
 	static_call_init();
 	early_ioremap_init();
--- a/arch/x86/kernel/static_call.c
+++ b/arch/x86/kernel/static_call.c
@@ -34,7 +34,7 @@ static void __ref __static_call_transfor
 		break;
 
 	case NOP:
-		code = ideal_nops[NOP_ATOMIC5];
+		code = x86_nops[5];
 		break;
 
 	case JMP:
@@ -66,7 +66,7 @@ static void __static_call_validate(void
 			return;
 	} else {
 		if (opcode == CALL_INSN_OPCODE ||
-		    !memcmp(insn, ideal_nops[NOP_ATOMIC5], 5) ||
+		    !memcmp(insn, x86_nops[5], 5) ||
 		    !memcmp(insn, xor5rax, 5))
 			return;
 	}
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -282,7 +282,7 @@ static void emit_prologue(u8 **pprog, u3
 	/* BPF trampoline can be made to work without these nops,
 	 * but let's waste 5 bytes for now and optimize later
 	 */
-	memcpy(prog, ideal_nops[NOP_ATOMIC5], cnt);
+	memcpy(prog, x86_nops[5], cnt);
 	prog += cnt;
 	if (!ebpf_from_cbpf) {
 		if (tail_call_reachable && !is_subprog)
@@ -330,7 +330,7 @@ static int __bpf_arch_text_poke(void *ip
 				void *old_addr, void *new_addr,
 				const bool text_live)
 {
-	const u8 *nop_insn = ideal_nops[NOP_ATOMIC5];
+	const u8 *nop_insn = x86_nops[5];
 	u8 old_insn[X86_PATCH_SIZE];
 	u8 new_insn[X86_PATCH_SIZE];
 	u8 *prog;
@@ -560,7 +560,7 @@ static void emit_bpf_tail_call_direct(st
 	if (stack_depth)
 		EMIT3_off32(0x48, 0x81, 0xC4, round_up(stack_depth, 8));
 
-	memcpy(prog, ideal_nops[NOP_ATOMIC5], X86_PATCH_SIZE);
+	memcpy(prog, x86_nops[5], X86_PATCH_SIZE);
 	prog += X86_PATCH_SIZE;
 	/* out: */
 
@@ -881,7 +881,7 @@ static int emit_nops(u8 **pprog, int len
 			noplen = ASM_NOP_MAX;
 
 		for (i = 0; i < noplen; i++)
-			EMIT1(ideal_nops[noplen][i]);
+			EMIT1(x86_nops[noplen][i]);
 		len -= noplen;
 	}
 
