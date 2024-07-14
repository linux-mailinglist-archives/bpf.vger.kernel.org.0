Return-Path: <bpf+bounces-34756-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E4DC9930917
	for <lists+bpf@lfdr.de>; Sun, 14 Jul 2024 10:30:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49614B21186
	for <lists+bpf@lfdr.de>; Sun, 14 Jul 2024 08:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C755473458;
	Sun, 14 Jul 2024 08:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IXlYsV0s"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4251B7173C;
	Sun, 14 Jul 2024 08:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720945756; cv=none; b=c5xmoT2FogTdK5X4GTCNM1Uq0KskbvKryz+FANGZGKopCgIa/i1UBxAW1qzbUEnuiuou86rkudHn7qK8EmQJZBGeRhRUICr2WmAMab+pAfarb998m5AfP3Qx16J1om0gDmriAXRAokGLcPrqs/c3QFGcaMKN8tHcp3+GSj2wKgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720945756; c=relaxed/simple;
	bh=lm+IQu0UYKXj8LIs7koonBvkrQUealW2J/yiZC306Mc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DiLH1cOOXofc1xzbPWOGf09sFrMGHGtkmZl720RRiW2xaykwJ5/5SicbPCCmAVO7n8gpcYV70NAa9QzkyAbgyRl4L0w5ndH+XbvJ8I1V2aUS9Y2CvtSj18eOBBkK/gPRWVQ5w5eFlWAJpj321kie653dgIs2nFvBvpfKCb4WMVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IXlYsV0s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A5B7C4AF0A;
	Sun, 14 Jul 2024 08:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720945755;
	bh=lm+IQu0UYKXj8LIs7koonBvkrQUealW2J/yiZC306Mc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IXlYsV0soTpAS/FwG1H1OqUtVhbgFuomGKDzMym8Nwu/E4YSjJ6QT1MKQVhoB48jU
	 NjSyvZzxuoGQC96+ec8vTWlSWSihOPdVhqQgw3MYcnzsiRfRRs99H8gfUXHhpzvEFc
	 Z18+vWUhywojUDykp8yMsOeb3YV4s6t64TATaVimRPC+KcLgMm6tvTJUc4JGQXXVMh
	 llL04Ks496IXu5OWCbiacCW5Wzaz83g7wbT9SwNppsX5VKflI8ufMMZR4ZA+ezEATd
	 D0uDY4RraWWilRhawy7nwNdujfBQx/JIfZiT0bx2G2+WxAxh0S9yV4S4AR0v0XLRy/
	 x5Yltjh9DugpA==
From: Naveen N Rao <naveen@kernel.org>
To: <linuxppc-dev@lists.ozlabs.org>,
	<linux-trace-kernel@vger.kernel.org>,
	<bpf@vger.kernel.org>,
	linux-kbuild@vger.kernel.org,
	<linux-kernel@vger.kernel.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Hari Bathini <hbathini@linux.ibm.com>,
	Mahesh Salgaonkar <mahesh@linux.ibm.com>,
	Vishal Chourasia <vishalc@linux.ibm.com>
Subject: [RFC PATCH v4 15/17] powerpc/ftrace: Add support for DYNAMIC_FTRACE_WITH_DIRECT_CALLS
Date: Sun, 14 Jul 2024 13:57:51 +0530
Message-ID: <bbaff53b526f73d77b5e09d010f600bd0fdb12b4.1720942106.git.naveen@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1720942106.git.naveen@kernel.org>
References: <cover.1720942106.git.naveen@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for DYNAMIC_FTRACE_WITH_DIRECT_CALLS similar to the arm64
implementation.

ftrace direct calls allow custom trampolines to be called into directly
from function ftrace call sites, bypassing the ftrace trampoline
completely. This functionality is currently utilized by BPF trampolines
to hook into kernel function entries.

Since we have limited relative branch range, we support ftrace direct
calls through support for DYNAMIC_FTRACE_WITH_CALL_OPS. In this
approach, ftrace trampoline is not entirely bypassed. Rather, it is
re-purposed into a stub that reads direct_call field from the associated
ftrace_ops structure and branches into that, if it is not NULL. For
this, it is sufficient if we can ensure that the ftrace trampoline is
reachable from all traceable functions.

When multiple ftrace_ops are associated with a call site, we utilize a
call back to set pt_regs->orig_gpr3 that can then be tested on the
return path from the ftrace trampoline to branch into the direct caller.

Signed-off-by: Naveen N Rao <naveen@kernel.org>
---
 arch/powerpc/Kconfig                     |   1 +
 arch/powerpc/include/asm/ftrace.h        |  15 +++
 arch/powerpc/kernel/asm-offsets.c        |   3 +
 arch/powerpc/kernel/trace/ftrace.c       |   9 ++
 arch/powerpc/kernel/trace/ftrace_entry.S | 114 +++++++++++++++++------
 5 files changed, 113 insertions(+), 29 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index cb6031d86dc9..29aab3770415 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -236,6 +236,7 @@ config PPC
 	select HAVE_DYNAMIC_FTRACE
 	select HAVE_DYNAMIC_FTRACE_WITH_ARGS	if ARCH_USING_PATCHABLE_FUNCTION_ENTRY || MPROFILE_KERNEL || PPC32
 	select HAVE_DYNAMIC_FTRACE_WITH_CALL_OPS if PPC_FTRACE_OUT_OF_LINE || (PPC32 && ARCH_USING_PATCHABLE_FUNCTION_ENTRY)
+	select HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS if HAVE_DYNAMIC_FTRACE_WITH_CALL_OPS
 	select HAVE_DYNAMIC_FTRACE_WITH_REGS	if ARCH_USING_PATCHABLE_FUNCTION_ENTRY || MPROFILE_KERNEL || PPC32
 	select HAVE_EBPF_JIT
 	select HAVE_EFFICIENT_UNALIGNED_ACCESS
diff --git a/arch/powerpc/include/asm/ftrace.h b/arch/powerpc/include/asm/ftrace.h
index 267bd52fef21..2f1a6d25838d 100644
--- a/arch/powerpc/include/asm/ftrace.h
+++ b/arch/powerpc/include/asm/ftrace.h
@@ -150,6 +150,21 @@ extern unsigned int ftrace_ool_stub_text_end_count, ftrace_ool_stub_text_count,
 #endif
 void ftrace_free_init_tramp(void);
 unsigned long ftrace_call_adjust(unsigned long addr);
+
+#ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
+/*
+ * When an ftrace registered caller is tracing a function that is also set by a
+ * register_ftrace_direct() call, it needs to be differentiated in the
+ * ftrace_caller trampoline so that the direct call can be invoked after the
+ * other ftrace ops. To do this, place the direct caller in the orig_gpr3 field
+ * of pt_regs. This tells ftrace_caller that there's a direct caller.
+ */
+static inline void arch_ftrace_set_direct_caller(struct ftrace_regs *fregs, unsigned long addr)
+{
+	struct pt_regs *regs = &fregs->regs;
+	regs->orig_gpr3 = addr;
+}
+#endif /* CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS */
 #else
 static inline void ftrace_free_init_tramp(void) { }
 static inline unsigned long ftrace_call_adjust(unsigned long addr) { return addr; }
diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index 60d1e388c2ba..dbd56264a8bc 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -680,6 +680,9 @@ int main(void)
 
 #ifdef CONFIG_DYNAMIC_FTRACE_WITH_CALL_OPS
 	OFFSET(FTRACE_OPS_FUNC, ftrace_ops, func);
+#ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
+	OFFSET(FTRACE_OPS_DIRECT_CALL, ftrace_ops, direct_call);
+#endif
 #endif
 
 	return 0;
diff --git a/arch/powerpc/kernel/trace/ftrace.c b/arch/powerpc/kernel/trace/ftrace.c
index 291c6c3d3a78..4316a7cfbdb8 100644
--- a/arch/powerpc/kernel/trace/ftrace.c
+++ b/arch/powerpc/kernel/trace/ftrace.c
@@ -150,6 +150,15 @@ static int ftrace_get_call_inst(struct dyn_ftrace *rec, unsigned long addr, ppc_
 	else
 		ip = rec->ip;
 
+	if (!is_offset_in_branch_range(addr - ip) && addr != FTRACE_ADDR && addr != FTRACE_REGS_ADDR) {
+		/* This can only happen with ftrace direct */
+		if (!IS_ENABLED(CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS)) {
+			pr_err("0x%lx (0x%lx): Unexpected target address 0x%lx\n", ip, rec->ip, addr);
+			return -EINVAL;
+		}
+		addr = FTRACE_ADDR;
+	}
+
 	if (is_offset_in_branch_range(addr - ip))
 		/* Within range */
 		stub = addr;
diff --git a/arch/powerpc/kernel/trace/ftrace_entry.S b/arch/powerpc/kernel/trace/ftrace_entry.S
index c019380bdd6a..eea4cb3737a8 100644
--- a/arch/powerpc/kernel/trace/ftrace_entry.S
+++ b/arch/powerpc/kernel/trace/ftrace_entry.S
@@ -33,14 +33,38 @@
  * and then arrange for the ftrace function to be called.
  */
 .macro	ftrace_regs_entry allregs
-	/* Save the original return address in A's stack frame */
-	PPC_STL		r0, LRSAVE(r1)
 	/* Create a minimal stack frame for representing B */
 	PPC_STLU	r1, -STACK_FRAME_MIN_SIZE(r1)
 
 	/* Create our stack frame + pt_regs */
 	PPC_STLU	r1,-SWITCH_FRAME_SIZE(r1)
 
+	.if \allregs == 1
+	SAVE_GPRS(11, 12, r1)
+	.endif
+
+	/* Get the _mcount() call site out of LR */
+	mflr	r11
+
+#ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
+	/* Load the ftrace_op */
+	PPC_LL	r12, -(MCOUNT_INSN_SIZE*2 + SZL)(r11)
+
+	/* Load direct_call from the ftrace_op */
+	PPC_LL	r12, FTRACE_OPS_DIRECT_CALL(r12)
+	PPC_LCMPI r12, 0
+	.if \allregs == 1
+	bne	.Lftrace_direct_call_regs
+	.else
+	bne	.Lftrace_direct_call
+	.endif
+#endif
+
+	/* Save the previous LR in pt_regs->link */
+	PPC_STL	r0, _LINK(r1)
+	/* Also save it in A's stack frame */
+	PPC_STL	r0, SWITCH_FRAME_SIZE+STACK_FRAME_MIN_SIZE+LRSAVE(r1)
+
 	/* Save all gprs to pt_regs */
 	SAVE_GPR(0, r1)
 	SAVE_GPRS(3, 10, r1)
@@ -54,7 +78,7 @@
 
 	.if \allregs == 1
 	SAVE_GPR(2, r1)
-	SAVE_GPRS(11, 31, r1)
+	SAVE_GPRS(13, 31, r1)
 	.else
 #if defined(CONFIG_LIVEPATCH_64) || defined(CONFIG_PPC_FTRACE_OUT_OF_LINE)
 	SAVE_GPR(14, r1)
@@ -67,20 +91,15 @@
 
 	.if \allregs == 1
 	/* Load special regs for save below */
+	mfcr	r7
 	mfmsr   r8
 	mfctr   r9
 	mfxer   r10
-	mfcr	r11
 	.else
 	/* Clear MSR to flag as ftrace_caller versus frace_regs_caller */
 	li	r8, 0
 	.endif
 
-	/* Get the _mcount() call site out of LR */
-	mflr	r7
-	/* Save the read LR in pt_regs->link */
-	PPC_STL	r0, _LINK(r1)
-
 #ifdef CONFIG_PPC64
 	/* Save callee's TOC in the ABI compliant location */
 	std	r2, STK_GOT(r1)
@@ -88,8 +107,8 @@
 #endif
 
 #ifdef CONFIG_DYNAMIC_FTRACE_WITH_CALL_OPS
-	/* r7 points to the instruction following the call to ftrace */
-	PPC_LL	r5, -(MCOUNT_INSN_SIZE*2 + SZL)(r7)
+	/* r11 points to the instruction following the call to ftrace */
+	PPC_LL	r5, -(MCOUNT_INSN_SIZE*2 + SZL)(r11)
 	PPC_LL	r12, FTRACE_OPS_FUNC(r5)
 	mtctr	r12
 #else /* !CONFIG_DYNAMIC_FTRACE_WITH_CALL_OPS */
@@ -105,45 +124,51 @@
 	/* Save special regs */
 	PPC_STL	r8, _MSR(r1)
 	.if \allregs == 1
+	PPC_STL	r7, _CCR(r1)
 	PPC_STL	r9, _CTR(r1)
 	PPC_STL	r10, _XER(r1)
-	PPC_STL	r11, _CCR(r1)
 	.endif
 
+#ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
+	/* Clear orig_gpr3 to later detect ftrace_direct call */
+	li	r7, 0
+	PPC_STL	r7, ORIG_GPR3(r1)
+#endif
+
 #ifdef CONFIG_PPC_FTRACE_OUT_OF_LINE
 	/* Save our real return address in nvr for return */
 	.if \allregs == 0
 	SAVE_GPR(15, r1)
 	.endif
-	mr	r15, r7
+	mr	r15, r11
 	/*
-	 * We want the ftrace location in the function, but our lr (in r7)
+	 * We want the ftrace location in the function, but our lr (in r11)
 	 * points at the 'mtlr r0' instruction in the out of line stub.  To
 	 * recover the ftrace location, we read the branch instruction in the
 	 * stub, and adjust our lr by the branch offset.
 	 *
 	 * See ftrace_init_ool_stub() for the profile sequence.
 	 */
-	lwz	r8, MCOUNT_INSN_SIZE(r7)
+	lwz	r8, MCOUNT_INSN_SIZE(r11)
 	slwi	r8, r8, 6
 	srawi	r8, r8, 6
-	add	r3, r7, r8
+	add	r3, r11, r8
 	/*
 	 * Override our nip to point past the branch in the original function.
 	 * This allows reliable stack trace and the ftrace stack tracer to work as-is.
 	 */
-	add	r7, r3, MCOUNT_INSN_SIZE
+	add	r11, r3, MCOUNT_INSN_SIZE
 #else
 	/* Calculate ip from nip-4 into r3 for call below */
-	subi    r3, r7, MCOUNT_INSN_SIZE
+	subi    r3, r11, MCOUNT_INSN_SIZE
 #endif
 
 	/* Save NIP as pt_regs->nip */
-	PPC_STL	r7, _NIP(r1)
+	PPC_STL	r11, _NIP(r1)
 	/* Also save it in B's stackframe header for proper unwind */
-	PPC_STL	r7, LRSAVE+SWITCH_FRAME_SIZE(r1)
+	PPC_STL	r11, LRSAVE+SWITCH_FRAME_SIZE(r1)
 #if defined(CONFIG_LIVEPATCH_64) || defined(CONFIG_PPC_FTRACE_OUT_OF_LINE)
-	mr	r14, r7		/* remember old NIP */
+	mr	r14, r11	/* remember old NIP */
 #endif
 
 	/* Put the original return address in r4 as parent_ip */
@@ -154,14 +179,32 @@
 .endm
 
 .macro	ftrace_regs_exit allregs
+#ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
+	/* Check orig_gpr3 to detect ftrace_direct call */
+	PPC_LL	r3, ORIG_GPR3(r1)
+	PPC_LCMPI cr1, r3, 0
+	mtctr	r3
+#endif
+
+	/* Restore possibly modified LR */
+	PPC_LL	r0, _LINK(r1)
+
 #ifndef CONFIG_PPC_FTRACE_OUT_OF_LINE
 	/* Load ctr with the possibly modified NIP */
 	PPC_LL	r3, _NIP(r1)
-	mtctr	r3
-
 #ifdef CONFIG_LIVEPATCH_64
 	cmpd	r14, r3		/* has NIP been altered? */
 #endif
+
+#ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
+	beq	cr1,2f
+	mtlr	r3
+	b	3f
+#endif
+2:	mtctr	r3
+	mtlr	r0
+3:
+
 #else /* !CONFIG_PPC_FTRACE_OUT_OF_LINE */
 	/* Load LR with the possibly modified NIP */
 	PPC_LL	r3, _NIP(r1)
@@ -185,12 +228,6 @@
 #endif
 	.endif
 
-	/* Restore possibly modified LR */
-	PPC_LL	r0, _LINK(r1)
-#ifndef CONFIG_PPC_FTRACE_OUT_OF_LINE
-	mtlr	r0
-#endif
-
 #ifdef CONFIG_PPC64
 	/* Restore callee's TOC */
 	ld	r2, STK_GOT(r1)
@@ -203,8 +240,12 @@
         /* Based on the cmpd above, if the NIP was altered handle livepatch */
 	bne-	livepatch_handler
 #endif
+
 	/* jump after _mcount site */
 #ifdef CONFIG_PPC_FTRACE_OUT_OF_LINE
+#ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
+	bnectr	cr1
+#endif
 	/*
 	 * Return with blr to keep the link stack balanced. The function profiling sequence
 	 * uses 'mtlr r0' to restore LR.
@@ -260,6 +301,21 @@ ftrace_no_trace:
 #endif
 #endif
 
+#ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
+.Lftrace_direct_call_regs:
+	mtctr	r12
+	REST_GPRS(11, 12, r1)
+	addi	r1, r1, SWITCH_FRAME_SIZE+STACK_FRAME_MIN_SIZE
+	bctr
+.Lftrace_direct_call:
+	mtctr	r12
+	addi	r1, r1, SWITCH_FRAME_SIZE+STACK_FRAME_MIN_SIZE
+	bctr
+SYM_FUNC_START(ftrace_stub_direct_tramp)
+	blr
+SYM_FUNC_END(ftrace_stub_direct_tramp)
+#endif
+
 #ifdef CONFIG_LIVEPATCH_64
 	/*
 	 * This function runs in the mcount context, between two functions. As
-- 
2.45.2


