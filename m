Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02E6E4E7E8E
	for <lists+bpf@lfdr.de>; Sat, 26 Mar 2022 03:27:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbiCZC3A (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 25 Mar 2022 22:29:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbiCZC27 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 25 Mar 2022 22:28:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D9F0176D1F;
        Fri, 25 Mar 2022 19:27:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AAEAA61972;
        Sat, 26 Mar 2022 02:27:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFD6FC004DD;
        Sat, 26 Mar 2022 02:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648261643;
        bh=hNrpqOoO2578w+TA05hd744LEWz+PdBF/tRrXJcELak=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OGyXjiGkmSZ57NBblvjMgsg1ux3f65yAuouTOn8pJPHiZnaElguMczunCy/CEK3wl
         8QKHMK4bl+yuPfvM9lzn5gmfFPtvb8cUHuyM4NrBU2m7ydpL/sjmBtaj83AQvFQ5XG
         FlyOrU0jHqLPbkmpk/scwz7GhWnlfS34r3EpHB/hj9eul8I9jfhfPiNgf+UiO49y9h
         zo7Ml8wGvdSwY63gpOAgIG/MIY29YE+fIIvvAdxE6wB9l+g1/Iijybp8jAerpk8sOd
         Rt/OCbYWwP8327m75iPgSaS5qddWEO7bulvbnU4vNpdJpRs8jScR1jWIzqd/2/yYJ+
         kEx6eaa8PSKWQ==
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
Subject: [PATCH bpf-next v3 2/4] x86,rethook,kprobes: Replace kretprobe with rethook on x86
Date:   Sat, 26 Mar 2022 11:27:17 +0900
Message-Id: <164826163692.2455864.13745421016848209527.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <164826160914.2455864.505359679001055158.stgit@devnote2>
References: <164826160914.2455864.505359679001055158.stgit@devnote2>
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
Tested-by: Jiri Olsa <jolsa@kernel.org>
---
 Changes in v3:
  - Add a temporary mitigation for bpf-next tree.
 Changes in v2:
  - Fix remaining unwind_recover_kretprobe() with unwind_recover_rethook()
    (Thanks Peter!)
  - Replace remaining "kretprobe" with "rethook" in comment.
---
 arch/x86/Kconfig                 |    1 
 arch/x86/include/asm/unwind.h    |   23 +++----
 arch/x86/kernel/Makefile         |    1 
 arch/x86/kernel/kprobes/common.h |    1 
 arch/x86/kernel/kprobes/core.c   |  106 --------------------------------
 arch/x86/kernel/rethook.c        |  125 ++++++++++++++++++++++++++++++++++++++
 arch/x86/kernel/unwind_orc.c     |   10 ++-
 7 files changed, 144 insertions(+), 123 deletions(-)
 create mode 100644 arch/x86/kernel/rethook.c

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index b037fe7be374..f7eb3937f1ad 100644
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
index 6290712cb36d..b986434035f9 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -801,18 +801,6 @@ set_current_kprobe(struct kprobe *p, struct pt_regs *regs,
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
@@ -1013,100 +1001,6 @@ int kprobe_int3_handler(struct pt_regs *regs)
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
index 000000000000..af7e6713a07a
--- /dev/null
+++ b/arch/x86/kernel/rethook.c
@@ -0,0 +1,125 @@
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
+#ifndef ANNOTATE_NOENDBR
+#define ANNOTATE_NOENDBR
+#endif
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
+	/* Push a fake return address to tell the unwinder it's a rethook. */
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
+	/* Push a fake return address to tell the unwinder it's a rethook. */
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
diff --git a/arch/x86/kernel/unwind_orc.c b/arch/x86/kernel/unwind_orc.c
index 2de3c8c5eba9..794fdef2501a 100644
--- a/arch/x86/kernel/unwind_orc.c
+++ b/arch/x86/kernel/unwind_orc.c
@@ -550,15 +550,15 @@ bool unwind_next_frame(struct unwind_state *state)
 		}
 		/*
 		 * There is a small chance to interrupt at the entry of
-		 * __kretprobe_trampoline() where the ORC info doesn't exist.
-		 * That point is right after the RET to __kretprobe_trampoline()
+		 * arch_rethook_trampoline() where the ORC info doesn't exist.
+		 * That point is right after the RET to arch_rethook_trampoline()
 		 * which was modified return address.
-		 * At that point, the @addr_p of the unwind_recover_kretprobe()
+		 * At that point, the @addr_p of the unwind_recover_rethook()
 		 * (this has to point the address of the stack entry storing
 		 * the modified return address) must be "SP - (a stack entry)"
 		 * because SP is incremented by the RET.
 		 */
-		state->ip = unwind_recover_kretprobe(state, state->ip,
+		state->ip = unwind_recover_rethook(state, state->ip,
 				(unsigned long *)(state->sp - sizeof(long)));
 		state->regs = (struct pt_regs *)sp;
 		state->prev_regs = NULL;
@@ -573,7 +573,7 @@ bool unwind_next_frame(struct unwind_state *state)
 			goto err;
 		}
 		/* See UNWIND_HINT_TYPE_REGS case comment. */
-		state->ip = unwind_recover_kretprobe(state, state->ip,
+		state->ip = unwind_recover_rethook(state, state->ip,
 				(unsigned long *)(state->sp - sizeof(long)));
 
 		if (state->full_regs)

