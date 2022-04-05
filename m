Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 053054F2CCF
	for <lists+bpf@lfdr.de>; Tue,  5 Apr 2022 13:33:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346819AbiDEJzN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 5 Apr 2022 05:55:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348731AbiDEJs3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 5 Apr 2022 05:48:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2D85403E5;
        Tue,  5 Apr 2022 02:34:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 76077B81CB3;
        Tue,  5 Apr 2022 09:34:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D98CBC385A2;
        Tue,  5 Apr 2022 09:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649151271;
        bh=LAFR0U8z2ATEUDfuQs2HtqiBTXOtY+cWH5gxvruL69g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=plKAaLGluFz/cApJ5yio6fQXV5HKiaqbxlApUKtouzQ0FddVpMqn5rdItfNfIjI4l
         jiV+MoMRw/hLMTT7WqP7gUmOHLWQ3W1O+LQUOppXA8eWujYNWhy05rSHwVc3PrgID1
         DVNUfxN30EadxzQsttH5jdde6QvaFbqkjhMF4xXDPkOikhBRasYK2C+A+I7SeEzMmu
         BIFGVnokkmQRxNWY09Q/oOUsR0tzLE5D90IhRn+nXV/73mN2aBUpGtn2DpZjF8ZPjx
         akvK6RTgi6+xKMcJ5ba+BDX+qhsTUtJGFZmzP4xJvCcGNB6xFdfPHnuT3dd7S5DS0w
         SJsCqQBb/V4SQ==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Shubham Bansal <illusionist.neo@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>, bpf@vger.kernel.org,
        kernel-team@fb.com, Jiri Olsa <jolsa@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH bpf 4/4] arm64: rethook: Replace kretprobe trampoline with rethook
Date:   Tue,  5 Apr 2022 18:34:24 +0900
Message-Id: <164915126392.982637.10302202550404803304.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <164915121498.982637.12787715964983738566.stgit@devnote2>
References: <164915121498.982637.12787715964983738566.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Replace the kretprobe's trampoline code with the rethook on arm64.
The rethook on arm64 is almost renamed from kretprobe trampoline
code. The mechanism is completely same.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 arch/arm64/Kconfig                            |    1 
 arch/arm64/include/asm/kprobes.h              |    2 -
 arch/arm64/include/asm/stacktrace.h           |    2 -
 arch/arm64/kernel/Makefile                    |    1 
 arch/arm64/kernel/probes/Makefile             |    1 
 arch/arm64/kernel/probes/kprobes.c            |   15 ----
 arch/arm64/kernel/probes/kprobes_trampoline.S |   86 -------------------------
 arch/arm64/kernel/rethook.c                   |   26 +++++++
 arch/arm64/kernel/rethook_trampoline.S        |   87 +++++++++++++++++++++++++
 arch/arm64/kernel/stacktrace.c                |    9 +--
 10 files changed, 121 insertions(+), 109 deletions(-)
 delete mode 100644 arch/arm64/kernel/probes/kprobes_trampoline.S
 create mode 100644 arch/arm64/kernel/rethook.c
 create mode 100644 arch/arm64/kernel/rethook_trampoline.S

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 57c4c995965f..7d2945930283 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -204,6 +204,7 @@ config ARM64
 	select HAVE_SYSCALL_TRACEPOINTS
 	select HAVE_KPROBES
 	select HAVE_KRETPROBES
+	select HAVE_RETHOOK
 	select HAVE_GENERIC_VDSO
 	select IOMMU_DMA if IOMMU_SUPPORT
 	select IRQ_DOMAIN
diff --git a/arch/arm64/include/asm/kprobes.h b/arch/arm64/include/asm/kprobes.h
index 05cd82eeca13..4ac558058377 100644
--- a/arch/arm64/include/asm/kprobes.h
+++ b/arch/arm64/include/asm/kprobes.h
@@ -39,8 +39,6 @@ void arch_remove_kprobe(struct kprobe *);
 int kprobe_fault_handler(struct pt_regs *regs, unsigned int fsr);
 int kprobe_exceptions_notify(struct notifier_block *self,
 			     unsigned long val, void *data);
-void __kretprobe_trampoline(void);
-void __kprobes *trampoline_probe_handler(struct pt_regs *regs);
 
 #endif /* CONFIG_KPROBES */
 #endif /* _ARM_KPROBES_H */
diff --git a/arch/arm64/include/asm/stacktrace.h b/arch/arm64/include/asm/stacktrace.h
index e77cdef9ca29..f781874f1609 100644
--- a/arch/arm64/include/asm/stacktrace.h
+++ b/arch/arm64/include/asm/stacktrace.h
@@ -58,7 +58,7 @@ struct stackframe {
 	DECLARE_BITMAP(stacks_done, __NR_STACK_TYPES);
 	unsigned long prev_fp;
 	enum stack_type prev_type;
-#ifdef CONFIG_KRETPROBES
+#if defined(CONFIG_RETHOOK)
 	struct llist_node *kr_cur;
 #endif
 };
diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index 986837d7ec82..62e033b1b095 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -60,6 +60,7 @@ obj-$(CONFIG_ACPI_NUMA)			+= acpi_numa.o
 obj-$(CONFIG_ARM64_ACPI_PARKING_PROTOCOL)	+= acpi_parking_protocol.o
 obj-$(CONFIG_PARAVIRT)			+= paravirt.o
 obj-$(CONFIG_RANDOMIZE_BASE)		+= kaslr.o
+obj-$(CONFIG_RETHOOK)			+= rethook.o rethook_trampoline.o
 obj-$(CONFIG_HIBERNATION)		+= hibernate.o hibernate-asm.o
 obj-$(CONFIG_ELF_CORE)			+= elfcore.o
 obj-$(CONFIG_KEXEC_CORE)		+= machine_kexec.o relocate_kernel.o	\
diff --git a/arch/arm64/kernel/probes/Makefile b/arch/arm64/kernel/probes/Makefile
index 8e4be92e25b1..1fa58cda64ff 100644
--- a/arch/arm64/kernel/probes/Makefile
+++ b/arch/arm64/kernel/probes/Makefile
@@ -1,6 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_KPROBES)		+= kprobes.o decode-insn.o	\
-				   kprobes_trampoline.o		\
 				   simulate-insn.o
 obj-$(CONFIG_UPROBES)		+= uprobes.o decode-insn.o	\
 				   simulate-insn.o
diff --git a/arch/arm64/kernel/probes/kprobes.c b/arch/arm64/kernel/probes/kprobes.c
index d9dfa82c1f18..4a3cc266e77e 100644
--- a/arch/arm64/kernel/probes/kprobes.c
+++ b/arch/arm64/kernel/probes/kprobes.c
@@ -399,21 +399,6 @@ int __init arch_populate_kprobe_blacklist(void)
 	return ret;
 }
 
-void __kprobes __used *trampoline_probe_handler(struct pt_regs *regs)
-{
-	return (void *)kretprobe_trampoline_handler(regs, (void *)regs->regs[29]);
-}
-
-void __kprobes arch_prepare_kretprobe(struct kretprobe_instance *ri,
-				      struct pt_regs *regs)
-{
-	ri->ret_addr = (kprobe_opcode_t *)regs->regs[30];
-	ri->fp = (void *)regs->regs[29];
-
-	/* replace return addr (x30) with trampoline */
-	regs->regs[30] = (long)&__kretprobe_trampoline;
-}
-
 int __kprobes arch_trampoline_kprobe(struct kprobe *p)
 {
 	return 0;
diff --git a/arch/arm64/kernel/probes/kprobes_trampoline.S b/arch/arm64/kernel/probes/kprobes_trampoline.S
deleted file mode 100644
index 9a6499bed58b..000000000000
--- a/arch/arm64/kernel/probes/kprobes_trampoline.S
+++ /dev/null
@@ -1,86 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * trampoline entry and return code for kretprobes.
- */
-
-#include <linux/linkage.h>
-#include <asm/asm-offsets.h>
-#include <asm/assembler.h>
-
-	.text
-
-	.macro	save_all_base_regs
-	stp x0, x1, [sp, #S_X0]
-	stp x2, x3, [sp, #S_X2]
-	stp x4, x5, [sp, #S_X4]
-	stp x6, x7, [sp, #S_X6]
-	stp x8, x9, [sp, #S_X8]
-	stp x10, x11, [sp, #S_X10]
-	stp x12, x13, [sp, #S_X12]
-	stp x14, x15, [sp, #S_X14]
-	stp x16, x17, [sp, #S_X16]
-	stp x18, x19, [sp, #S_X18]
-	stp x20, x21, [sp, #S_X20]
-	stp x22, x23, [sp, #S_X22]
-	stp x24, x25, [sp, #S_X24]
-	stp x26, x27, [sp, #S_X26]
-	stp x28, x29, [sp, #S_X28]
-	add x0, sp, #PT_REGS_SIZE
-	stp lr, x0, [sp, #S_LR]
-	/*
-	 * Construct a useful saved PSTATE
-	 */
-	mrs x0, nzcv
-	mrs x1, daif
-	orr x0, x0, x1
-	mrs x1, CurrentEL
-	orr x0, x0, x1
-	mrs x1, SPSel
-	orr x0, x0, x1
-	stp xzr, x0, [sp, #S_PC]
-	.endm
-
-	.macro	restore_all_base_regs
-	ldr x0, [sp, #S_PSTATE]
-	and x0, x0, #(PSR_N_BIT | PSR_Z_BIT | PSR_C_BIT | PSR_V_BIT)
-	msr nzcv, x0
-	ldp x0, x1, [sp, #S_X0]
-	ldp x2, x3, [sp, #S_X2]
-	ldp x4, x5, [sp, #S_X4]
-	ldp x6, x7, [sp, #S_X6]
-	ldp x8, x9, [sp, #S_X8]
-	ldp x10, x11, [sp, #S_X10]
-	ldp x12, x13, [sp, #S_X12]
-	ldp x14, x15, [sp, #S_X14]
-	ldp x16, x17, [sp, #S_X16]
-	ldp x18, x19, [sp, #S_X18]
-	ldp x20, x21, [sp, #S_X20]
-	ldp x22, x23, [sp, #S_X22]
-	ldp x24, x25, [sp, #S_X24]
-	ldp x26, x27, [sp, #S_X26]
-	ldp x28, x29, [sp, #S_X28]
-	.endm
-
-SYM_CODE_START(__kretprobe_trampoline)
-	sub sp, sp, #PT_REGS_SIZE
-
-	save_all_base_regs
-
-	/* Setup a frame pointer. */
-	add x29, sp, #S_FP
-
-	mov x0, sp
-	bl trampoline_probe_handler
-	/*
-	 * Replace trampoline address in lr with actual orig_ret_addr return
-	 * address.
-	 */
-	mov lr, x0
-
-	/* The frame pointer (x29) is restored with other registers. */
-	restore_all_base_regs
-
-	add sp, sp, #PT_REGS_SIZE
-	ret
-
-SYM_CODE_END(__kretprobe_trampoline)
diff --git a/arch/arm64/kernel/rethook.c b/arch/arm64/kernel/rethook.c
new file mode 100644
index 000000000000..78bb6b968de5
--- /dev/null
+++ b/arch/arm64/kernel/rethook.c
@@ -0,0 +1,26 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Generic return hook for arm64.
+ * Most of the code is copied from arch/arm64/kernel/probes/kprobes.c
+ */
+
+#include <linux/kprobes.h>
+#include <linux/rethook.h>
+
+/* This is called from arch_rethook_trampoline() */
+unsigned long __used arch_rethook_trampoline_callback(struct pt_regs *regs)
+{
+	return rethook_trampoline_handler(regs, regs->regs[29]);
+}
+NOKPROBE_SYMBOL(arch_rethook_trampoline_callback);
+
+int arch_rethook_prepare(struct rethook_node *rhn, struct pt_regs *regs, bool mcount)
+{
+	rhn->ret_addr = regs->regs[30];
+	rhn->frame = regs->regs[29];
+
+	/* replace return addr (x30) with trampoline */
+	regs->regs[30] = (u64)arch_rethook_trampoline;
+	return 0;
+}
+NOKPROBE_SYMBOL(arch_rethook_prepare);
diff --git a/arch/arm64/kernel/rethook_trampoline.S b/arch/arm64/kernel/rethook_trampoline.S
new file mode 100644
index 000000000000..146d4553674c
--- /dev/null
+++ b/arch/arm64/kernel/rethook_trampoline.S
@@ -0,0 +1,87 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * trampoline entry and return code for rethook.
+ * Renamed from arch/arm64/kernel/probes/kprobes_trampoline.S
+ */
+
+#include <linux/linkage.h>
+#include <asm/asm-offsets.h>
+#include <asm/assembler.h>
+
+	.text
+
+	.macro	save_all_base_regs
+	stp x0, x1, [sp, #S_X0]
+	stp x2, x3, [sp, #S_X2]
+	stp x4, x5, [sp, #S_X4]
+	stp x6, x7, [sp, #S_X6]
+	stp x8, x9, [sp, #S_X8]
+	stp x10, x11, [sp, #S_X10]
+	stp x12, x13, [sp, #S_X12]
+	stp x14, x15, [sp, #S_X14]
+	stp x16, x17, [sp, #S_X16]
+	stp x18, x19, [sp, #S_X18]
+	stp x20, x21, [sp, #S_X20]
+	stp x22, x23, [sp, #S_X22]
+	stp x24, x25, [sp, #S_X24]
+	stp x26, x27, [sp, #S_X26]
+	stp x28, x29, [sp, #S_X28]
+	add x0, sp, #PT_REGS_SIZE
+	stp lr, x0, [sp, #S_LR]
+	/*
+	 * Construct a useful saved PSTATE
+	 */
+	mrs x0, nzcv
+	mrs x1, daif
+	orr x0, x0, x1
+	mrs x1, CurrentEL
+	orr x0, x0, x1
+	mrs x1, SPSel
+	orr x0, x0, x1
+	stp xzr, x0, [sp, #S_PC]
+	.endm
+
+	.macro	restore_all_base_regs
+	ldr x0, [sp, #S_PSTATE]
+	and x0, x0, #(PSR_N_BIT | PSR_Z_BIT | PSR_C_BIT | PSR_V_BIT)
+	msr nzcv, x0
+	ldp x0, x1, [sp, #S_X0]
+	ldp x2, x3, [sp, #S_X2]
+	ldp x4, x5, [sp, #S_X4]
+	ldp x6, x7, [sp, #S_X6]
+	ldp x8, x9, [sp, #S_X8]
+	ldp x10, x11, [sp, #S_X10]
+	ldp x12, x13, [sp, #S_X12]
+	ldp x14, x15, [sp, #S_X14]
+	ldp x16, x17, [sp, #S_X16]
+	ldp x18, x19, [sp, #S_X18]
+	ldp x20, x21, [sp, #S_X20]
+	ldp x22, x23, [sp, #S_X22]
+	ldp x24, x25, [sp, #S_X24]
+	ldp x26, x27, [sp, #S_X26]
+	ldp x28, x29, [sp, #S_X28]
+	.endm
+
+SYM_CODE_START(arch_rethook_trampoline)
+	sub sp, sp, #PT_REGS_SIZE
+
+	save_all_base_regs
+
+	/* Setup a frame pointer. */
+	add x29, sp, #S_FP
+
+	mov x0, sp
+	bl arch_rethook_trampoline_callback
+	/*
+	 * Replace trampoline address in lr with actual orig_ret_addr return
+	 * address.
+	 */
+	mov lr, x0
+
+	/* The frame pointer (x29) is restored with other registers. */
+	restore_all_base_regs
+
+	add sp, sp, #PT_REGS_SIZE
+	ret
+
+SYM_CODE_END(arch_rethook_trampoline)
diff --git a/arch/arm64/kernel/stacktrace.c b/arch/arm64/kernel/stacktrace.c
index e4103e085681..5b717af4b555 100644
--- a/arch/arm64/kernel/stacktrace.c
+++ b/arch/arm64/kernel/stacktrace.c
@@ -8,6 +8,7 @@
 #include <linux/export.h>
 #include <linux/ftrace.h>
 #include <linux/kprobes.h>
+#include <linux/rethook.h>
 #include <linux/sched.h>
 #include <linux/sched/debug.h>
 #include <linux/sched/task_stack.h>
@@ -38,7 +39,7 @@ static notrace void start_backtrace(struct stackframe *frame, unsigned long fp,
 {
 	frame->fp = fp;
 	frame->pc = pc;
-#ifdef CONFIG_KRETPROBES
+#if defined(CONFIG_RETHOOK)
 	frame->kr_cur = NULL;
 #endif
 
@@ -134,9 +135,9 @@ static int notrace unwind_frame(struct task_struct *tsk,
 		frame->pc = orig_pc;
 	}
 #endif /* CONFIG_FUNCTION_GRAPH_TRACER */
-#ifdef CONFIG_KRETPROBES
-	if (is_kretprobe_trampoline(frame->pc))
-		frame->pc = kretprobe_find_ret_addr(tsk, (void *)frame->fp, &frame->kr_cur);
+#ifdef CONFIG_RETHOOK
+	if (is_rethook_trampoline(frame->pc))
+		frame->pc = rethook_find_ret_addr(tsk, frame->fp, &frame->kr_cur);
 #endif
 
 	return 0;

