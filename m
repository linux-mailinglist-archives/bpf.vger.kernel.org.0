Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBF954E6D37
	for <lists+bpf@lfdr.de>; Fri, 25 Mar 2022 05:29:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354546AbiCYEan (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 25 Mar 2022 00:30:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354254AbiCYEam (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 25 Mar 2022 00:30:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 746FCC6810;
        Thu, 24 Mar 2022 21:29:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 104E0615BB;
        Fri, 25 Mar 2022 04:29:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D493C340E9;
        Fri, 25 Mar 2022 04:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648182547;
        bh=u62JfnzmRAb1bWKykz9x0iZwQhPOgr12qSrgPcduMyI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E+cBv9PYRjnOuriXc1tg2qequgpOXRttoXwHXE9uOhAEFqRb2lihuNJXmHmDyIux0
         /M8+dlGMGrqu2ODfTZACVEezHYI1dhhz0DhwcUU7y0LkFV7Tp/WPAjHV6QtJgwPS6E
         Hhsve+nPcij6hiq2sCQmqRkY0uXQ8ETELXNWo+DbvvU6PDbdVeMpMb5bwLP1soO/vg
         TjQ/TlHETa1jUtGUym6qu6zqrxe3HyygFXqvYbAb5ebaoEsPsHHKacxjuFBN6esM+5
         bWmsKUd+K4BdJMhrfetE9r1RRv3otr4/HgWtJ+wV5vpXQOEv4W7aNcH5+0KDp2qEcd
         jASgJNRA2fQxA==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        kernel-janitors@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next 2/2] rethook: kprobes: x86: Replace kretprobe with rethook on x86
Date:   Fri, 25 Mar 2022 13:29:01 +0900
Message-Id: <164818254148.2252200.5054811796192907193.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <164818251899.2252200.7306353689206167903.stgit@devnote2>
References: <164818251899.2252200.7306353689206167903.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Replaces the kretprobe code with rethook on x86. With this patch,
kretprobe on x86 uses the rethook instead of kretprobe specific
trampoline code.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 arch/x86/Kconfig                 |    1 
 arch/x86/include/asm/unwind.h    |   23 +++----
 arch/x86/kernel/Makefile         |    1 
 arch/x86/kernel/kprobes/common.h |    1 
 arch/x86/kernel/kprobes/core.c   |  107 ----------------------------------
 arch/x86/kernel/rethook.c        |  121 ++++++++++++++++++++++++++++++++++++++
 6 files changed, 135 insertions(+), 119 deletions(-)
 create mode 100644 arch/x86/kernel/rethook.c

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index db3bedcbf6be..e85b52a6f612 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -224,6 +224,7 @@ config X86
 	select HAVE_KPROBES_ON_FTRACE
 	select HAVE_FUNCTION_ERROR_INJECTION
 	select HAVE_KRETPROBES
+	select HAVE_RETHOOK
 	select HAVE_KVM
 	select HAVE_LIVEPATCH			if X86_64
 	select HAVE_MIXED_BREAKPOINTS_REGS
diff --git a/arch/x86/include/asm/unwind.h b/arch/x86/include/asm/unwind.h
index 2a1f8734416d..7cede4dc21f0 100644
--- a/arch/x86/include/asm/unwind.h
+++ b/arch/x86/include/asm/unwind.h
@@ -4,7 +4,7 @@
 
 #include <linux/sched.h>
 #include <linux/ftrace.h>
-#include <linux/kprobes.h>
+#include <linux/rethook.h>
 #include <asm/ptrace.h>
 #include <asm/stacktrace.h>
 
@@ -16,7 +16,7 @@ struct unwind_state {
 	unsigned long stack_mask;
 	struct task_struct *task;
 	int graph_idx;
-#ifdef CONFIG_KRETPROBES
+#if defined(CONFIG_RETHOOK)
 	struct llist_node *kr_cur;
 #endif
 	bool error;
@@ -104,19 +104,18 @@ void unwind_module_init(struct module *mod, void *orc_ip, size_t orc_ip_size,
 #endif
 
 static inline
-unsigned long unwind_recover_kretprobe(struct unwind_state *state,
-				       unsigned long addr, unsigned long *addr_p)
+unsigned long unwind_recover_rethook(struct unwind_state *state,
+				     unsigned long addr, unsigned long *addr_p)
 {
-#ifdef CONFIG_KRETPROBES
-	return is_kretprobe_trampoline(addr) ?
-		kretprobe_find_ret_addr(state->task, addr_p, &state->kr_cur) :
-		addr;
-#else
-	return addr;
+#ifdef CONFIG_RETHOOK
+	if (is_rethook_trampoline(addr))
+		return rethook_find_ret_addr(state->task, (unsigned long)addr_p,
+					     &state->kr_cur);
 #endif
+	return addr;
 }
 
-/* Recover the return address modified by kretprobe and ftrace_graph. */
+/* Recover the return address modified by rethook and ftrace_graph. */
 static inline
 unsigned long unwind_recover_ret_addr(struct unwind_state *state,
 				     unsigned long addr, unsigned long *addr_p)
@@ -125,7 +124,7 @@ unsigned long unwind_recover_ret_addr(struct unwind_state *state,
 
 	ret = ftrace_graph_ret_addr(state->task, &state->graph_idx,
 				    addr, addr_p);
-	return unwind_recover_kretprobe(state, ret, addr_p);
+	return unwind_recover_rethook(state, ret, addr_p);
 }
 
 /*
diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index 6462e3dd98f4..c41ef42adbe8 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -103,6 +103,7 @@ obj-$(CONFIG_FUNCTION_GRAPH_TRACER) += ftrace.o
 obj-$(CONFIG_FTRACE_SYSCALLS)	+= ftrace.o
 obj-$(CONFIG_X86_TSC)		+= trace_clock.o
 obj-$(CONFIG_TRACING)		+= trace.o
+obj-$(CONFIG_RETHOOK)		+= rethook.o
 obj-$(CONFIG_CRASH_CORE)	+= crash_core_$(BITS).o
 obj-$(CONFIG_KEXEC_CORE)	+= machine_kexec_$(BITS).o
 obj-$(CONFIG_KEXEC_CORE)	+= relocate_kernel_$(BITS).o crash.o
diff --git a/arch/x86/kernel/kprobes/common.h b/arch/x86/kernel/kprobes/common.h
index 7d3a2e2daf01..c993521d4933 100644
--- a/arch/x86/kernel/kprobes/common.h
+++ b/arch/x86/kernel/kprobes/common.h
@@ -6,6 +6,7 @@
 
 #include <asm/asm.h>
 #include <asm/frame.h>
+#include <asm/insn.h>
 
 #ifdef CONFIG_X86_64
 
diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
index 8ef933c03afa..7c4ab8870da4 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -811,18 +811,6 @@ set_current_kprobe(struct kprobe *p, struct pt_regs *regs,
 		= (regs->flags & X86_EFLAGS_IF);
 }
 
-void arch_prepare_kretprobe(struct kretprobe_instance *ri, struct pt_regs *regs)
-{
-	unsigned long *sara = stack_addr(regs);
-
-	ri->ret_addr = (kprobe_opcode_t *) *sara;
-	ri->fp = sara;
-
-	/* Replace the return addr with trampoline addr */
-	*sara = (unsigned long) &__kretprobe_trampoline;
-}
-NOKPROBE_SYMBOL(arch_prepare_kretprobe);
-
 static void kprobe_post_process(struct kprobe *cur, struct pt_regs *regs,
 			       struct kprobe_ctlblk *kcb)
 {
@@ -1023,101 +1011,6 @@ int kprobe_int3_handler(struct pt_regs *regs)
 }
 NOKPROBE_SYMBOL(kprobe_int3_handler);
 
-/*
- * When a retprobed function returns, this code saves registers and
- * calls trampoline_handler() runs, which calls the kretprobe's handler.
- */
-asm(
-	".text\n"
-	".global __kretprobe_trampoline\n"
-	".type __kretprobe_trampoline, @function\n"
-	"__kretprobe_trampoline:\n"
-#ifdef CONFIG_X86_64
-	ANNOTATE_NOENDBR
-	/* Push a fake return address to tell the unwinder it's a kretprobe. */
-	"	pushq $__kretprobe_trampoline\n"
-	UNWIND_HINT_FUNC
-	/* Save the 'sp - 8', this will be fixed later. */
-	"	pushq %rsp\n"
-	"	pushfq\n"
-	SAVE_REGS_STRING
-	"	movq %rsp, %rdi\n"
-	"	call trampoline_handler\n"
-	RESTORE_REGS_STRING
-	/* In trampoline_handler(), 'regs->flags' is copied to 'regs->sp'. */
-	"	addq $8, %rsp\n"
-	"	popfq\n"
-#else
-	/* Push a fake return address to tell the unwinder it's a kretprobe. */
-	"	pushl $__kretprobe_trampoline\n"
-	UNWIND_HINT_FUNC
-	/* Save the 'sp - 4', this will be fixed later. */
-	"	pushl %esp\n"
-	"	pushfl\n"
-	SAVE_REGS_STRING
-	"	movl %esp, %eax\n"
-	"	call trampoline_handler\n"
-	RESTORE_REGS_STRING
-	/* In trampoline_handler(), 'regs->flags' is copied to 'regs->sp'. */
-	"	addl $4, %esp\n"
-	"	popfl\n"
-#endif
-	ASM_RET
-	".size __kretprobe_trampoline, .-__kretprobe_trampoline\n"
-);
-NOKPROBE_SYMBOL(__kretprobe_trampoline);
-/*
- * __kretprobe_trampoline() skips updating frame pointer. The frame pointer
- * saved in trampoline_handler() points to the real caller function's
- * frame pointer. Thus the __kretprobe_trampoline() doesn't have a
- * standard stack frame with CONFIG_FRAME_POINTER=y.
- * Let's mark it non-standard function. Anyway, FP unwinder can correctly
- * unwind without the hint.
- */
-STACK_FRAME_NON_STANDARD_FP(__kretprobe_trampoline);
-
-/* This is called from kretprobe_trampoline_handler(). */
-void arch_kretprobe_fixup_return(struct pt_regs *regs,
-				 kprobe_opcode_t *correct_ret_addr)
-{
-	unsigned long *frame_pointer = &regs->sp + 1;
-
-	/* Replace fake return address with real one. */
-	*frame_pointer = (unsigned long)correct_ret_addr;
-}
-
-/*
- * Called from __kretprobe_trampoline
- */
-__used __visible void trampoline_handler(struct pt_regs *regs)
-{
-	unsigned long *frame_pointer;
-
-	/* fixup registers */
-	regs->cs = __KERNEL_CS;
-#ifdef CONFIG_X86_32
-	regs->gs = 0;
-#endif
-	regs->ip = (unsigned long)&__kretprobe_trampoline;
-	regs->orig_ax = ~0UL;
-	regs->sp += sizeof(long);
-	frame_pointer = &regs->sp + 1;
-
-	/*
-	 * The return address at 'frame_pointer' is recovered by the
-	 * arch_kretprobe_fixup_return() which called from the
-	 * kretprobe_trampoline_handler().
-	 */
-	kretprobe_trampoline_handler(regs, frame_pointer);
-
-	/*
-	 * Copy FLAGS to 'pt_regs::sp' so that __kretprobe_trapmoline()
-	 * can do RET right after POPF.
-	 */
-	regs->sp = regs->flags;
-}
-NOKPROBE_SYMBOL(trampoline_handler);
-
 int kprobe_fault_handler(struct pt_regs *regs, int trapnr)
 {
 	struct kprobe *cur = kprobe_running();
diff --git a/arch/x86/kernel/rethook.c b/arch/x86/kernel/rethook.c
new file mode 100644
index 000000000000..3e916361c33b
--- /dev/null
+++ b/arch/x86/kernel/rethook.c
@@ -0,0 +1,121 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * x86 implementation of rethook. Mostly copied from arch/x86/kernel/kprobes/core.c.
+ */
+#include <linux/bug.h>
+#include <linux/rethook.h>
+#include <linux/kprobes.h>
+#include <linux/objtool.h>
+
+#include "kprobes/common.h"
+
+__visible void arch_rethook_trampoline_callback(struct pt_regs *regs);
+
+/*
+ * When a target function returns, this code saves registers and calls
+ * arch_rethook_trampoline_callback(), which calls the rethook handler.
+ */
+asm(
+	".text\n"
+	".global arch_rethook_trampoline\n"
+	".type arch_rethook_trampoline, @function\n"
+	"arch_rethook_trampoline:\n"
+#ifdef CONFIG_X86_64
+	ANNOTATE_NOENDBR	/* This is only jumped from ret instruction */
+	/* Push a fake return address to tell the unwinder it's a kretprobe. */
+	"	pushq $arch_rethook_trampoline\n"
+	UNWIND_HINT_FUNC
+	/* Save the 'sp - 8', this will be fixed later. */
+	"	pushq %rsp\n"
+	"	pushfq\n"
+	SAVE_REGS_STRING
+	"	movq %rsp, %rdi\n"
+	"	call arch_rethook_trampoline_callback\n"
+	RESTORE_REGS_STRING
+	/* In the callback function, 'regs->flags' is copied to 'regs->sp'. */
+	"	addq $8, %rsp\n"
+	"	popfq\n"
+#else
+	/* Push a fake return address to tell the unwinder it's a kretprobe. */
+	"	pushl $arch_rethook_trampoline\n"
+	UNWIND_HINT_FUNC
+	/* Save the 'sp - 4', this will be fixed later. */
+	"	pushl %esp\n"
+	"	pushfl\n"
+	SAVE_REGS_STRING
+	"	movl %esp, %eax\n"
+	"	call arch_rethook_trampoline_callback\n"
+	RESTORE_REGS_STRING
+	/* In the callback function, 'regs->flags' is copied to 'regs->sp'. */
+	"	addl $4, %esp\n"
+	"	popfl\n"
+#endif
+	ASM_RET
+	".size arch_rethook_trampoline, .-arch_rethook_trampoline\n"
+);
+NOKPROBE_SYMBOL(arch_rethook_trampoline);
+
+/*
+ * Called from arch_rethook_trampoline
+ */
+__used __visible void arch_rethook_trampoline_callback(struct pt_regs *regs)
+{
+	unsigned long *frame_pointer;
+
+	/* fixup registers */
+	regs->cs = __KERNEL_CS;
+#ifdef CONFIG_X86_32
+	regs->gs = 0;
+#endif
+	regs->ip = (unsigned long)&arch_rethook_trampoline;
+	regs->orig_ax = ~0UL;
+	regs->sp += sizeof(long);
+	frame_pointer = &regs->sp + 1;
+
+	/*
+	 * The return address at 'frame_pointer' is recovered by the
+	 * arch_rethook_fixup_return() which called from this
+	 * rethook_trampoline_handler().
+	 */
+	rethook_trampoline_handler(regs, (unsigned long)frame_pointer);
+
+	/*
+	 * Copy FLAGS to 'pt_regs::sp' so that arch_rethook_trapmoline()
+	 * can do RET right after POPF.
+	 */
+	regs->sp = regs->flags;
+}
+NOKPROBE_SYMBOL(arch_rethook_trampoline_callback);
+
+/*
+ * arch_rethook_trampoline() skips updating frame pointer. The frame pointer
+ * saved in arch_rethook_trampoline_callback() points to the real caller
+ * function's frame pointer. Thus the arch_rethook_trampoline() doesn't have
+ * a standard stack frame with CONFIG_FRAME_POINTER=y.
+ * Let's mark it non-standard function. Anyway, FP unwinder can correctly
+ * unwind without the hint.
+ */
+STACK_FRAME_NON_STANDARD_FP(arch_rethook_trampoline);
+
+/* This is called from rethook_trampoline_handler(). */
+void arch_rethook_fixup_return(struct pt_regs *regs,
+			       unsigned long correct_ret_addr)
+{
+	unsigned long *frame_pointer = &regs->sp + 1;
+
+	/* Replace fake return address with real one. */
+	*frame_pointer = correct_ret_addr;
+}
+NOKPROBE_SYMBOL(arch_rethook_fixup_return);
+
+void arch_rethook_prepare(struct rethook_node *rh, struct pt_regs *regs, bool mcount)
+{
+	unsigned long *stack = (unsigned long *)regs->sp;
+
+	rh->ret_addr = stack[0];
+	rh->frame = regs->sp;
+
+	/* Replace the return addr with trampoline addr */
+	stack[0] = (unsigned long) arch_rethook_trampoline;
+}
+NOKPROBE_SYMBOL(arch_rethook_prepare);

