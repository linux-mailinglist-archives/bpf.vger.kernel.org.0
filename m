Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3C334F3500
	for <lists+bpf@lfdr.de>; Tue,  5 Apr 2022 15:42:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345837AbiDEJzI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 5 Apr 2022 05:55:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348650AbiDEJsM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 5 Apr 2022 05:48:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F2DE33EA6;
        Tue,  5 Apr 2022 02:34:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C0EFFB81C98;
        Tue,  5 Apr 2022 09:34:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14E90C385A3;
        Tue,  5 Apr 2022 09:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649151258;
        bh=BMCRwjjlfIbM/TUx+qbzoFbkQDj9Jg49pYE5HI9x5ZU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uKmOZ5seNEpToR8MuSNEsVJ2leBVvHeaapc2xV7SNxv4KPi3fIcR06QP9yqF3qoOu
         wmUB2Syw3RVtkF2RIMGIJR6QyLauTjLQg/CYdCmiaM204awVDb4DBZvpPmio0/bvba
         nK/rD7+Q3uqtjPA92XbJLw9LvStR7kq4AcBbPZVPOOUub1WIXFy1+JRKu3RFCETzH9
         kuhsXadlRwohAXxVQVvWwEGUSrjMjxgz2SdnE7KJDZjpGsK1rhMned6Xl9q/Ut22E1
         OGj+F2C6kN6erzo+jnlX3hu7MGTFViLK0UGeamv79v5f9IBsFuSM4tXX5B7w1YLEMF
         fUZVXgvVo9PjA==
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
Subject: [PATCH bpf 3/4] ARM: rethook: Replace kretprobe trampoline with rethook
Date:   Tue,  5 Apr 2022 18:34:11 +0900
Message-Id: <164915125136.982637.15305442546225954227.stgit@devnote2>
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

Replace the kretprob's trampoline code with the rethook on arm.
This also enables rethook support on arm. Most of the code has been
copied from kretprobe on arm.

The significant difference is that the rethook on mcount (ftrace)
support is added. If the rethook is called from the kprobes for
kretprobe, there is no problem to replace the LR register with
trampoline address because the LR register will be saved after
kprobe probed. However, the mcount call will be placed right after
making a stack frame for the function. This means we have to decode
the stackframe to find where the LR register is saved. With the
CONFIG_FRAME_POINTER, the frame pointer (FP register) is used.
Without that, rethook has to unwind one stack frame to find it.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 arch/arm/Kconfig                  |    1 
 arch/arm/include/asm/stacktrace.h |    5 +
 arch/arm/kernel/stacktrace.c      |   13 ++--
 arch/arm/probes/Makefile          |    1 
 arch/arm/probes/kprobes/core.c    |   62 ------------------
 arch/arm/probes/rethook.c         |  127 +++++++++++++++++++++++++++++++++++++
 6 files changed, 139 insertions(+), 70 deletions(-)
 create mode 100644 arch/arm/probes/rethook.c

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index c1251856ef77..cb56c848930a 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -110,6 +110,7 @@ config ARM
 	select HAVE_MOD_ARCH_SPECIFIC
 	select HAVE_NMI
 	select HAVE_OPTPROBES if !THUMB2_KERNEL
+	select HAVE_RETHOOK
 	select HAVE_PERF_EVENTS
 	select HAVE_PERF_REGS
 	select HAVE_PERF_USER_STACK_DUMP
diff --git a/arch/arm/include/asm/stacktrace.h b/arch/arm/include/asm/stacktrace.h
index 3e78f921b8b2..76a70b25863e 100644
--- a/arch/arm/include/asm/stacktrace.h
+++ b/arch/arm/include/asm/stacktrace.h
@@ -17,7 +17,8 @@ struct stackframe {
 
 	/* address of the LR value on the stack */
 	unsigned long *lr_addr;
-#ifdef CONFIG_KRETPROBES
+
+#if defined(CONFIG_RETHOOK)
 	struct llist_node *kr_cur;
 	struct task_struct *tsk;
 #endif
@@ -30,7 +31,7 @@ void arm_get_current_stackframe(struct pt_regs *regs, struct stackframe *frame)
 		frame->sp = regs->ARM_sp;
 		frame->lr = regs->ARM_lr;
 		frame->pc = regs->ARM_pc;
-#ifdef CONFIG_KRETPROBES
+#if defined(CONFIG_RETHOOK)
 		frame->kr_cur = NULL;
 		frame->tsk = current;
 #endif
diff --git a/arch/arm/kernel/stacktrace.c b/arch/arm/kernel/stacktrace.c
index b5efecb3d730..6df085ecdf41 100644
--- a/arch/arm/kernel/stacktrace.c
+++ b/arch/arm/kernel/stacktrace.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 #include <linux/export.h>
 #include <linux/kprobes.h>
+#include <linux/rethook.h>
 #include <linux/sched.h>
 #include <linux/sched/debug.h>
 #include <linux/stacktrace.h>
@@ -66,10 +67,10 @@ int notrace unwind_frame(struct stackframe *frame)
 	frame->sp = *(unsigned long *)(fp - 8);
 	frame->pc = *(unsigned long *)(fp - 4);
 #endif
-#ifdef CONFIG_KRETPROBES
-	if (is_kretprobe_trampoline(frame->pc))
-		frame->pc = kretprobe_find_ret_addr(frame->tsk,
-					(void *)frame->fp, &frame->kr_cur);
+#ifdef CONFIG_RETHOOK
+	if (is_rethook_trampoline(frame->pc))
+		frame->pc = rethook_find_ret_addr(frame->tsk, frame->fp,
+						  &frame->kr_cur);
 #endif
 
 	return 0;
@@ -163,7 +164,7 @@ static noinline void __save_stack_trace(struct task_struct *tsk,
 here:
 		frame.pc = (unsigned long)&&here;
 	}
-#ifdef CONFIG_KRETPROBES
+#ifdef CONFIG_RETHOOK
 	frame.kr_cur = NULL;
 	frame.tsk = tsk;
 #endif
@@ -184,7 +185,7 @@ void save_stack_trace_regs(struct pt_regs *regs, struct stack_trace *trace)
 	frame.sp = regs->ARM_sp;
 	frame.lr = regs->ARM_lr;
 	frame.pc = regs->ARM_pc;
-#ifdef CONFIG_KRETPROBES
+#ifdef CONFIG_RETHOOK
 	frame.kr_cur = NULL;
 	frame.tsk = current;
 #endif
diff --git a/arch/arm/probes/Makefile b/arch/arm/probes/Makefile
index 8b0ea5ace100..10c083a22223 100644
--- a/arch/arm/probes/Makefile
+++ b/arch/arm/probes/Makefile
@@ -6,3 +6,4 @@ obj-$(CONFIG_KPROBES)		+= decode-thumb.o
 else
 obj-$(CONFIG_KPROBES)		+= decode-arm.o
 endif
+obj-$(CONFIG_RETHOOK)		+= rethook.o
diff --git a/arch/arm/probes/kprobes/core.c b/arch/arm/probes/kprobes/core.c
index 9090c3a74dcc..2f01f8267cc3 100644
--- a/arch/arm/probes/kprobes/core.c
+++ b/arch/arm/probes/kprobes/core.c
@@ -365,68 +365,6 @@ int __kprobes kprobe_exceptions_notify(struct notifier_block *self,
 	return NOTIFY_DONE;
 }
 
-/*
- * When a retprobed function returns, trampoline_handler() is called,
- * calling the kretprobe's handler. We construct a struct pt_regs to
- * give a view of registers r0-r11, sp, lr, and pc to the user
- * return-handler. This is not a complete pt_regs structure, but that
- * should be enough for stacktrace from the return handler with or
- * without pt_regs.
- */
-void __naked __kprobes __kretprobe_trampoline(void)
-{
-	__asm__ __volatile__ (
-#ifdef CONFIG_FRAME_POINTER
-		"ldr	lr, =__kretprobe_trampoline	\n\t"
-	/* __kretprobe_trampoline makes a framepointer on pt_regs. */
-#ifdef CONFIG_CC_IS_CLANG
-		"stmdb	sp, {sp, lr, pc}	\n\t"
-		"sub	sp, sp, #12		\n\t"
-		/* In clang case, pt_regs->ip = lr. */
-		"stmdb	sp!, {r0 - r11, lr}	\n\t"
-		/* fp points regs->r11 (fp) */
-		"add	fp, sp,	#44		\n\t"
-#else /* !CONFIG_CC_IS_CLANG */
-		/* In gcc case, pt_regs->ip = fp. */
-		"stmdb	sp, {fp, sp, lr, pc}	\n\t"
-		"sub	sp, sp, #16		\n\t"
-		"stmdb	sp!, {r0 - r11}		\n\t"
-		/* fp points regs->r15 (pc) */
-		"add	fp, sp, #60		\n\t"
-#endif /* CONFIG_CC_IS_CLANG */
-#else /* !CONFIG_FRAME_POINTER */
-		"sub	sp, sp, #16		\n\t"
-		"stmdb	sp!, {r0 - r11}		\n\t"
-#endif /* CONFIG_FRAME_POINTER */
-		"mov	r0, sp			\n\t"
-		"bl	trampoline_handler	\n\t"
-		"mov	lr, r0			\n\t"
-		"ldmia	sp!, {r0 - r11}		\n\t"
-		"add	sp, sp, #16		\n\t"
-#ifdef CONFIG_THUMB2_KERNEL
-		"bx	lr			\n\t"
-#else
-		"mov	pc, lr			\n\t"
-#endif
-		: : : "memory");
-}
-
-/* Called from __kretprobe_trampoline */
-static __used __kprobes void *trampoline_handler(struct pt_regs *regs)
-{
-	return (void *)kretprobe_trampoline_handler(regs, (void *)regs->ARM_fp);
-}
-
-void __kprobes arch_prepare_kretprobe(struct kretprobe_instance *ri,
-				      struct pt_regs *regs)
-{
-	ri->ret_addr = (kprobe_opcode_t *)regs->ARM_lr;
-	ri->fp = (void *)regs->ARM_fp;
-
-	/* Replace the return addr with trampoline addr. */
-	regs->ARM_lr = (unsigned long)&__kretprobe_trampoline;
-}
-
 int __kprobes arch_trampoline_kprobe(struct kprobe *p)
 {
 	return 0;
diff --git a/arch/arm/probes/rethook.c b/arch/arm/probes/rethook.c
new file mode 100644
index 000000000000..598a2b579b91
--- /dev/null
+++ b/arch/arm/probes/rethook.c
@@ -0,0 +1,127 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * arm implementation of rethook. Mostly copied from arch/arm/probes/kprobes/core.c
+ */
+
+#include <linux/kprobes.h>
+#include <linux/rethook.h>
+
+#include <asm/stacktrace.h>
+
+/* Called from arch_rethook_trampoline */
+static __used notrace unsigned long arch_rethook_trampoline_callback(struct pt_regs *regs)
+{
+	return rethook_trampoline_handler(regs, regs->ARM_fp);
+}
+NOKPROBE_SYMBOL(arch_rethook_trampoline_callback);
+
+/*
+ * When a rethook'ed function returns, it returns to arch_rethook_trampoline
+ * which calls rethook callback. We construct a struct pt_regs to
+ * give a view of registers r0-r11, sp, lr, and pc to the user
+ * return-handler. This is not a complete pt_regs structure, but that
+ * should be enough for stacktrace from the return handler with or
+ * without pt_regs.
+ */
+asm(
+	".text\n"
+	".global arch_rethook_trampoline\n"
+	".type arch_rethook_trampoline, %function\n"
+	"arch_rethook_trampoline:\n"
+#ifdef CONFIG_FRAME_POINTER
+	"adr	lr, .			\n\t"
+	/* this makes a framepointer on pt_regs. */
+#ifdef CONFIG_CC_IS_CLANG
+	"stmdb	sp, {sp, lr, pc}	\n\t"
+	"sub	sp, sp, #12		\n\t"
+	/* In clang case, pt_regs->ip = lr. */
+	"stmdb	sp!, {r0 - r11, lr}	\n\t"
+	/* fp points regs->r11 (fp) */
+	"add	fp, sp,	#44		\n\t"
+#else /* !CONFIG_CC_IS_CLANG */
+	/* In gcc case, pt_regs->ip = fp. */
+	"stmdb	sp, {fp, sp, lr, pc}	\n\t"
+	"sub	sp, sp, #16		\n\t"
+	"stmdb	sp!, {r0 - r11}		\n\t"
+	/* fp points regs->r15 (pc) */
+	"add	fp, sp, #60		\n\t"
+#endif /* CONFIG_CC_IS_CLANG */
+#else /* !CONFIG_FRAME_POINTER */
+	"sub	sp, sp, #16		\n\t"
+	"stmdb	sp!, {r0 - r11}		\n\t"
+#endif /* CONFIG_FRAME_POINTER */
+	"mov	r0, sp			\n\t"
+	"bl	arch_rethook_trampoline_callback	\n\t"
+	"mov	lr, r0			\n\t"
+	"ldmia	sp!, {r0 - r11}		\n\t"
+	"add	sp, sp, #16		\n\t"
+#ifdef CONFIG_THUMB2_KERNEL
+	"bx	lr			\n\t"
+#else
+	"mov	pc, lr			\n\t"
+#endif
+	".size arch_rethook_trampoline, .-arch_rethook_trampoline\n"
+);
+NOKPROBE_SYMBOL(arch_rethook_trampoline);
+
+/*
+ * At the entry of function with mcount, if the FRAME_POINTER is enabled,
+ * the stack and registers are prepared for the mcount function as below.
+ *
+ * mov     ip, sp
+ * push    {fp, ip, lr, pc}
+ * sub     fp, ip, #4	; FP[0] = PC, FP[-4] = LR, and FP[-12] = call-site FP.
+ * push    {lr}
+ * bl      <__gnu_mcount_nc> ; call ftrace
+ *
+ * And when returning from the function, call-site FP, SP and PC are restored
+ * from stack as below;
+ *
+ * ldm     sp, {fp, sp, pc}
+ *
+ * Thus, if the arch_rethook_prepare() is called from real function entry,
+ * it must change the LR and save FP in pt_regs. But if it is called via
+ * mcount context (ftrace), it must change the LR on stack, which is next
+ * to the PC (= FP[-4]), and save the FP value at FP[-12].
+ *
+ * If the FRAME_POINTER is disabled, we have to use arm unwinder to find where
+ * the LR is stored.
+ */
+int notrace arch_rethook_prepare(struct rethook_node *rh, struct pt_regs *regs, bool mcount)
+{
+	unsigned long *lr_addr;
+	int ret;
+
+	if (mcount) {
+		/* Clang + mcount case is not supported yet. */
+		if (IS_ENABLED(CONFIG_CC_IS_CLANG))
+			return -EOPNOTSUPP;
+		if (IS_ENABLED(CONFIG_FRAME_POINTER)) {
+			lr_addr = (unsigned long *)(regs->ARM_fp - 4);
+			rh->frame = *(unsigned long *)(regs->ARM_fp - 12);
+		} else {
+			struct stackframe frame;
+
+			arm_get_current_stackframe(regs, &frame);
+			ret = unwind_frame(&frame);
+			if (ret < 0)
+				return -EINVAL;
+
+			if (frame.lr_addr)
+				lr_addr = frame.lr_addr;
+			else
+				lr_addr = &regs->ARM_lr;
+			rh->frame = regs->ARM_fp;
+		}
+	} else {
+		lr_addr = &regs->ARM_lr;
+		rh->frame = regs->ARM_fp;
+	}
+
+	/* Replace the return addr with trampoline addr. */
+	rh->ret_addr = *lr_addr;
+	*lr_addr = (unsigned long)arch_rethook_trampoline;
+
+	return 0;
+}
+NOKPROBE_SYMBOL(arch_rethook_prepare);

