Return-Path: <bpf+bounces-32623-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE0D591119F
	for <lists+bpf@lfdr.de>; Thu, 20 Jun 2024 20:58:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83AD9288EFB
	for <lists+bpf@lfdr.de>; Thu, 20 Jun 2024 18:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28FB11B4C5E;
	Thu, 20 Jun 2024 18:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="trVR0iu4"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A01F61AD48B;
	Thu, 20 Jun 2024 18:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718909871; cv=none; b=YATjjkSKXyj/qXYs98ElUQ3vkVUwqw4Ez04FfzyVttiUUbE7qsU5HIUoG5NpkHC4OBjZyEVIe8Ip3rlF4KB+Co66aNlUyjSDBiOfq2MI0S3I0yHbY6naLn08h0a3T3tE69hc9N2vIyFIfQyZS70mLHbw7wt8kFi76PbV4MP8zeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718909871; c=relaxed/simple;
	bh=985gdIH0ppfk83Q1NEtcSEVKXPnJFOVze98CIIKBeis=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JsAH8+wFHIumOMpbUbHcBndAlXBYRZuxpXOsoYeIoLOfmK3cAMCUp5lLXhrc98ejZ2osuCvCpBbI3jKFEqoWOqbjNdqaV+lqLqtpsdqb2qoK9bY4Nqr/p0jWaZp/SXuoXWYBB/fsAX9gat9xy418iokP3GTXxFwjJuyNxYZ+9SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=trVR0iu4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C620C2BD10;
	Thu, 20 Jun 2024 18:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718909871;
	bh=985gdIH0ppfk83Q1NEtcSEVKXPnJFOVze98CIIKBeis=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=trVR0iu4hhVM57E5fuyGCzfbfCcOnY7aDX9RcPkymF8umOX9AcQFCXIjo4wd9Ni4Z
	 YmaasVehz/3SNtDbjiE1qSP3VLb1Rsw9abX6cQ2nxcswmPH209c0z+/6MmJVFRVL5Z
	 yL+wq+Z8hPIM+nlEGkfjGTRnZxqlXa5hdBo4feqXe22u0A8AhHdD15M3Deft8T6pmu
	 0qXDenCxEpwuzNo0P3+psCok+RWbVHQLjFOOpwUMovG9ZQ42Xt1KxL2hP2JdGv/Ak5
	 J9xnemYOyRo+ntSTpb8j9997fV4g/ersPcOcGWEcPKYkpkkzGrCUY0mfrSSL1AXg4J
	 XPv+BEtjk1M7g==
From: Naveen N Rao <naveen@kernel.org>
To: <linuxppc-dev@lists.ozlabs.org>,
	<linux-trace-kernel@vger.kernel.org>,
	<bpf@vger.kernel.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Song Liu <song@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>
Subject: [RFC PATCH v3 07/11] powerpc/ftrace: Add support for DYNAMIC_FTRACE_WITH_CALL_OPS
Date: Fri, 21 Jun 2024 00:24:10 +0530
Message-ID: <f30256eac7900ac56d4b68082904ad4aa3fdc44a.1718908016.git.naveen@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1718908016.git.naveen@kernel.org>
References: <cover.1718908016.git.naveen@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement support for DYNAMIC_FTRACE_WITH_CALL_OPS similar to the
arm64 implementation.

This works by patching-in a pointer to an associated ftrace_ops
structure before each traceable function. If multiple ftrace_ops are
associated with a call site, then a special ftrace_list_ops is used to
enable iterating over all the registered ftrace_ops. If no ftrace_ops
are associated with a call site, then a special ftrace_nop_ops structure
is used to render the ftrace call as a no-op. ftrace trampoline can then
read the associated ftrace_ops for a call site by loading from an offset
from the LR, and branch directly to the associated function.

The primary advantage with this approach is that we don't have to
iterate over all the registered ftrace_ops for call sites that have a
single ftrace_ops registered. This is the equivalent of implementing
support for dynamic ftrace trampolines, which set up a special ftrace
trampoline for each registered ftrace_ops and have individual call sites
branch into those directly.

A secondary advantage is that this gives us a way to add support for
direct ftrace callers without having to resort to using stubs. The
address of the direct call trampoline can be loaded from the ftrace_ops
structure.

To support this, we reserve a nop before each function on 32-bit
powerpc. For 64-bit powerpc, two nops are reserved before each
out-of-line stub. During ftrace activation, we update this location with
the associated ftrace_ops pointer. Then, on ftrace entry, we load from
this location and call into ftrace_ops->func().

For 64-bit powerpc, we ensure that the out-of-line stub area is
doubleword aligned so that ftrace_ops address can be updated atomically.

Signed-off-by: Naveen N Rao <naveen@kernel.org>
---
 arch/powerpc/Kconfig                       |  1 +
 arch/powerpc/Makefile                      |  4 ++
 arch/powerpc/include/asm/ftrace.h          |  5 +-
 arch/powerpc/kernel/asm-offsets.c          |  4 ++
 arch/powerpc/kernel/trace/ftrace.c         | 59 +++++++++++++++++++++-
 arch/powerpc/kernel/trace/ftrace_entry.S   | 34 ++++++++++---
 arch/powerpc/tools/gen-ftrace-pfe-stubs.sh |  5 +-
 7 files changed, 101 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index dd7efca2275a..fde64ad19de5 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -235,6 +235,7 @@ config PPC
 	select HAVE_DEBUG_STACKOVERFLOW
 	select HAVE_DYNAMIC_FTRACE
 	select HAVE_DYNAMIC_FTRACE_WITH_ARGS	if ARCH_USING_PATCHABLE_FUNCTION_ENTRY || MPROFILE_KERNEL || PPC32
+	select HAVE_DYNAMIC_FTRACE_WITH_CALL_OPS if FTRACE_PFE_OUT_OF_LINE || (PPC32 && ARCH_USING_PATCHABLE_FUNCTION_ENTRY)
 	select HAVE_DYNAMIC_FTRACE_WITH_REGS	if ARCH_USING_PATCHABLE_FUNCTION_ENTRY || MPROFILE_KERNEL || PPC32
 	select HAVE_EBPF_JIT
 	select HAVE_EFFICIENT_UNALIGNED_ACCESS
diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index bb920d48ec6e..c3e577dea137 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -158,8 +158,12 @@ KBUILD_CPPFLAGS	+= -DCC_USING_PATCHABLE_FUNCTION_ENTRY
 ifdef CONFIG_FTRACE_PFE_OUT_OF_LINE
 CC_FLAGS_FTRACE := -fpatchable-function-entry=1
 else
+ifdef CONFIG_DYNAMIC_FTRACE_WITH_CALL_OPS # PPC32 only
+CC_FLAGS_FTRACE := -fpatchable-function-entry=3,1
+else
 CC_FLAGS_FTRACE := -fpatchable-function-entry=2
 endif
+endif
 else
 CC_FLAGS_FTRACE := -pg
 ifdef CONFIG_MPROFILE_KERNEL
diff --git a/arch/powerpc/include/asm/ftrace.h b/arch/powerpc/include/asm/ftrace.h
index 9da1da0f87b4..938cecf72eb1 100644
--- a/arch/powerpc/include/asm/ftrace.h
+++ b/arch/powerpc/include/asm/ftrace.h
@@ -137,8 +137,11 @@ static inline u8 this_cpu_get_ftrace_enabled(void) { return 1; }
 extern unsigned int ftrace_tramp_text[], ftrace_tramp_init[];
 #ifdef CONFIG_FTRACE_PFE_OUT_OF_LINE
 struct ftrace_pfe_stub {
+#ifdef CONFIG_DYNAMIC_FTRACE_WITH_CALL_OPS
+	struct ftrace_ops *ftrace_op;
+#endif
 	u32	insn[4];
-};
+} __aligned(sizeof(unsigned long));
 extern struct ftrace_pfe_stub ftrace_pfe_stub_text[], ftrace_pfe_stub_inittext[];
 extern unsigned long ftrace_pfe_stub_text_count, ftrace_pfe_stub_inittext_count;
 #endif
diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index 5f1a411d714c..a11ea5f4d86a 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -678,5 +678,9 @@ int main(void)
 	DEFINE(FTRACE_PFE_STUB_SIZE, sizeof(struct ftrace_pfe_stub));
 #endif
 
+#ifdef CONFIG_DYNAMIC_FTRACE_WITH_CALL_OPS
+	OFFSET(FTRACE_OPS_FUNC, ftrace_ops, func);
+#endif
+
 	return 0;
 }
diff --git a/arch/powerpc/kernel/trace/ftrace.c b/arch/powerpc/kernel/trace/ftrace.c
index 9f3c10307331..028548312c23 100644
--- a/arch/powerpc/kernel/trace/ftrace.c
+++ b/arch/powerpc/kernel/trace/ftrace.c
@@ -38,8 +38,11 @@ unsigned long ftrace_call_adjust(unsigned long addr)
 		return 0;
 
 	if (IS_ENABLED(CONFIG_ARCH_USING_PATCHABLE_FUNCTION_ENTRY) &&
-	    !IS_ENABLED(CONFIG_FTRACE_PFE_OUT_OF_LINE))
+	    !IS_ENABLED(CONFIG_FTRACE_PFE_OUT_OF_LINE)) {
 		addr += MCOUNT_INSN_SIZE;
+		if (IS_ENABLED(CONFIG_DYNAMIC_FTRACE_WITH_CALL_OPS))
+			addr += MCOUNT_INSN_SIZE;
+	}
 
 	return addr;
 }
@@ -241,6 +244,46 @@ static int ftrace_init_pfe_stub(struct module *mod, struct dyn_ftrace *rec)
 #endif
 }
 
+#ifdef CONFIG_DYNAMIC_FTRACE_WITH_CALL_OPS
+static const struct ftrace_ops *powerpc_rec_get_ops(struct dyn_ftrace *rec)
+{
+	const struct ftrace_ops *ops = NULL;
+
+	if (rec->flags & FTRACE_FL_CALL_OPS_EN) {
+		ops = ftrace_find_unique_ops(rec);
+		WARN_ON_ONCE(!ops);
+	}
+
+	if (!ops)
+		ops = &ftrace_list_ops;
+
+	return ops;
+}
+
+static int ftrace_rec_set_ops(struct dyn_ftrace *rec, const struct ftrace_ops *ops)
+{
+	if (IS_ENABLED(CONFIG_FTRACE_PFE_OUT_OF_LINE))
+		return patch_ulong((void *)(ftrace_get_pfe_stub(rec) - sizeof(unsigned long)),
+				   (unsigned long)ops);
+	else
+		return patch_ulong((void *)(rec->ip - MCOUNT_INSN_SIZE - sizeof(unsigned long)),
+				   (unsigned long)ops);
+}
+
+static int ftrace_rec_set_nop_ops(struct dyn_ftrace *rec)
+{
+	return ftrace_rec_set_ops(rec, &ftrace_nop_ops);
+}
+
+static int ftrace_rec_update_ops(struct dyn_ftrace *rec)
+{
+	return ftrace_rec_set_ops(rec, powerpc_rec_get_ops(rec));
+}
+#else
+static int ftrace_rec_set_nop_ops(struct dyn_ftrace *rec) { return 0; }
+static int ftrace_rec_update_ops(struct dyn_ftrace *rec) { return 0; }
+#endif
+
 #ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
 int ftrace_modify_call(struct dyn_ftrace *rec, unsigned long old_addr, unsigned long addr)
 {
@@ -271,6 +314,10 @@ int ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
 	if (!ret)
 		ret = ftrace_modify_code(ip, old, new);
 
+	ret = ftrace_rec_update_ops(rec);
+	if (ret)
+		return ret;
+
 	if (!ret && IS_ENABLED(CONFIG_FTRACE_PFE_OUT_OF_LINE))
 		ret = ftrace_modify_code(rec->ip, ppc_inst(PPC_RAW_NOP()),
 			 ppc_inst(PPC_RAW_BRANCH((long)ftrace_get_pfe_stub(rec) - (long)rec->ip)));
@@ -322,16 +369,19 @@ void ftrace_replace_code(int enable)
 		case FTRACE_UPDATE_MODIFY_CALL:
 			ret = ftrace_get_call_inst(rec, new_addr, &new_call_inst);
 			ret |= ftrace_get_call_inst(rec, addr, &call_inst);
+			ret |= ftrace_rec_update_ops(rec);
 			old = call_inst;
 			new = new_call_inst;
 			break;
 		case FTRACE_UPDATE_MAKE_NOP:
 			ret = ftrace_get_call_inst(rec, addr, &call_inst);
+			ret |= ftrace_rec_set_nop_ops(rec);
 			old = call_inst;
 			new = nop_inst;
 			break;
 		case FTRACE_UPDATE_MAKE_CALL:
 			ret = ftrace_get_call_inst(rec, new_addr, &call_inst);
+			ret |= ftrace_rec_update_ops(rec);
 			old = nop_inst;
 			new = call_inst;
 			break;
@@ -443,6 +493,13 @@ int ftrace_update_ftrace_func(ftrace_func_t func)
 	ppc_inst_t old, new;
 	int ret;
 
+	/*
+	 * When using CALL_OPS, the function to call is associated with the
+	 * call site, and we don't have a global function pointer to update.
+	 */
+	if (IS_ENABLED(CONFIG_DYNAMIC_FTRACE_WITH_CALL_OPS))
+		return 0;
+
 	old = ppc_inst_read((u32 *)&ftrace_call);
 	new = ftrace_create_branch_inst(ip, ppc_function_entry(func), 1);
 	ret = ftrace_modify_code(ip, old, new);
diff --git a/arch/powerpc/kernel/trace/ftrace_entry.S b/arch/powerpc/kernel/trace/ftrace_entry.S
index b1cbef24f18f..a76aedd970a6 100644
--- a/arch/powerpc/kernel/trace/ftrace_entry.S
+++ b/arch/powerpc/kernel/trace/ftrace_entry.S
@@ -85,11 +85,21 @@
 	/* Save callee's TOC in the ABI compliant location */
 	std	r2, STK_GOT(r1)
 	LOAD_PACA_TOC()		/* get kernel TOC in r2 */
+#endif
+
+#ifdef CONFIG_DYNAMIC_FTRACE_WITH_CALL_OPS
+	/* r7 points to the instruction following the call to ftrace */
+	PPC_LL	r5, -(MCOUNT_INSN_SIZE*2 + SZL)(r7)
+	PPC_LL	r12, FTRACE_OPS_FUNC(r5)
+	mtctr	r12
+#else /* !CONFIG_DYNAMIC_FTRACE_WITH_CALL_OPS */
+#ifdef CONFIG_PPC64
 	LOAD_REG_ADDR(r3, function_trace_op)
 	ld	r5,0(r3)
 #else
 	lis	r3,function_trace_op@ha
 	lwz	r5,function_trace_op@l(r3)
+#endif
 #endif
 
 	/* Save special regs */
@@ -196,20 +206,30 @@
 #endif
 .endm
 
-_GLOBAL(ftrace_regs_caller)
-	ftrace_regs_entry 1
-	/* ftrace_call(r3, r4, r5, r6) */
+.macro ftrace_regs_func allregs
+#ifdef CONFIG_DYNAMIC_FTRACE_WITH_CALL_OPS
+	bctrl
+#else
+	.if \allregs == 1
 .globl ftrace_regs_call
 ftrace_regs_call:
+	.else
+.globl ftrace_call
+ftrace_call:
+	.endif
+	/* ftrace_call(r3, r4, r5, r6) */
 	bl	ftrace_stub
+#endif
+.endm
+
+_GLOBAL(ftrace_regs_caller)
+	ftrace_regs_entry 1
+	ftrace_regs_func 1
 	ftrace_regs_exit 1
 
 _GLOBAL(ftrace_caller)
 	ftrace_regs_entry 0
-	/* ftrace_call(r3, r4, r5, r6) */
-.globl ftrace_call
-ftrace_call:
-	bl	ftrace_stub
+	ftrace_regs_func 0
 	ftrace_regs_exit 0
 
 _GLOBAL(ftrace_stub)
diff --git a/arch/powerpc/tools/gen-ftrace-pfe-stubs.sh b/arch/powerpc/tools/gen-ftrace-pfe-stubs.sh
index ec95e99aff14..f23d3f74e029 100755
--- a/arch/powerpc/tools/gen-ftrace-pfe-stubs.sh
+++ b/arch/powerpc/tools/gen-ftrace-pfe-stubs.sh
@@ -24,12 +24,13 @@ num_pfe_stubs_inittext=$(${CROSS_COMPILE}objdump -r -j __patchable_function_entr
 
 cat > ${arch_vmlinux_S} <<EOF
 #include <asm/asm-offsets.h>
+#include <asm/ppc_asm.h>
 #include <linux/linkage.h>
 
 .pushsection .tramp.ftrace.text,"aw"
 SYM_DATA(ftrace_pfe_stub_text_count, .long ${num_pfe_stubs_text})
 
-SYM_CODE_START(ftrace_pfe_stub_text)
+SYM_START(ftrace_pfe_stub_text, SYM_L_GLOBAL, .balign SZL)
 	.space ${num_pfe_stubs_text} * FTRACE_PFE_STUB_SIZE
 SYM_CODE_END(ftrace_pfe_stub_text)
 .popsection
@@ -37,7 +38,7 @@ SYM_CODE_END(ftrace_pfe_stub_text)
 .pushsection .tramp.ftrace.init,"aw"
 SYM_DATA(ftrace_pfe_stub_inittext_count, .long ${num_pfe_stubs_inittext})
 
-SYM_CODE_START(ftrace_pfe_stub_inittext)
+SYM_START(ftrace_pfe_stub_inittext, SYM_L_GLOBAL, .balign SZL)
 	.space ${num_pfe_stubs_inittext} * FTRACE_PFE_STUB_SIZE
 SYM_CODE_END(ftrace_pfe_stub_inittext)
 .popsection
-- 
2.45.2


