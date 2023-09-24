Return-Path: <bpf+bounces-10717-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D89C97AC9B0
	for <lists+bpf@lfdr.de>; Sun, 24 Sep 2023 15:37:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id E13F61C20905
	for <lists+bpf@lfdr.de>; Sun, 24 Sep 2023 13:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3295CA58;
	Sun, 24 Sep 2023 13:37:07 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D856ADE;
	Sun, 24 Sep 2023 13:37:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56F92C433C8;
	Sun, 24 Sep 2023 13:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695562627;
	bh=F+SQMPQuFwuNvF2/gAvfM3FFfKmhMFYc8ubpZC9kP40=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UOSw5wFF1cOxb0v3+RYbN3I6PSGUuE2ntY/dy6Iwkp0YZhWizfjusW6NbHsvgCQ/b
	 tfvjknFeR5VfLV7gE0TfgTBj9E0rVhj2D6YY7xO9JiZSyWbpECwSuWNsVELn0CdIQl
	 8slXKQhlZnNIX7c63f1ZZ0mM9nMAtck4WiBFv/kl2cRHcDkEClM1BCGkvStq481CZJ
	 17bWdAyMdmZtl4UERvk5l+aHYStgYS8i2GLsuGgzGoIfPJCS6uvmrmoZXhTk/nsrIK
	 lRv2ESr1lLGq2m3v6dUpjWrPn9T0ICaLilPwUb5vwlPUUxIZUFdzeAhOYZL4PmiUJw
	 sXYzDLUl/ThTA==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Florent Revest <revest@chromium.org>
Cc: linux-trace-kernel@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	bpf <bpf@vger.kernel.org>,
	Sven Schnelle <svens@linux.ibm.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alan Maguire <alan.maguire@oracle.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Guo Ren <guoren@kernel.org>
Subject: [PATCH v5 06/12] fprobe: rethook: Use ftrace_regs in fprobe exit handler and rethook
Date: Sun, 24 Sep 2023 22:37:00 +0900
Message-Id: <169556262030.146934.16624533747935252102.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <169556254640.146934.5654329452696494756.stgit@devnote2>
References: <169556254640.146934.5654329452696494756.stgit@devnote2>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Change the fprobe exit handler and rethook to use ftrace_regs structure
instead of pt_regs. This also introduce HAVE_PT_REGS_TO_FTRACE_REGS_CAST
which means the ftrace_regs's memory layout is equal to the pt_regs so
that those are able to cast. Only if it is enabled, kretprobe will use
rethook since kretprobe requires pt_regs for backward compatibility.

This means the archs which currently implement rethook for kretprobes
needs to set that flag and it must ensure struct ftrace_regs is same as
pt_regs.
If not, it must be either disabling kretprobe or implementing kretprobe
trampoline separately from rethook trampoline.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
Acked-by: Florent Revest <revest@chromium.org>
---
 Changes in v3:
  - Config rename to HAVE_PT_REGS_TO_FTRACE_REGS_CAST
  - Use ftrace_regs_* APIs instead of ftrace_get_regs().
 Changes in v4:
  - Add static_assert() to ensure at least the size of pt_regs
    and ftrace_regs are same if HAVE_PT_REGS_TO_FTRACE_REGS_CAST=y.
 Changes in v5:
  - Add s390 rethook update by Sven Schnelle.
  - Add loongarch rethook update.
  - Add riscv rethook update (with saving regs.s0 in ftrace)
---
 arch/Kconfig                       |    1 +
 arch/loongarch/Kconfig             |    1 +
 arch/loongarch/kernel/rethook.c    |   10 +++++-----
 arch/loongarch/kernel/rethook.h    |    4 ++--
 arch/riscv/kernel/mcount-dyn.S     |    2 ++
 arch/riscv/kernel/probes/rethook.c |   12 ++++++------
 arch/riscv/kernel/probes/rethook.h |    6 ++++--
 arch/s390/Kconfig                  |    1 +
 arch/s390/kernel/rethook.c         |   10 ++++++----
 arch/s390/kernel/rethook.h         |    2 +-
 arch/x86/Kconfig                   |    1 +
 arch/x86/kernel/rethook.c          |   13 +++++++------
 include/linux/fprobe.h             |    2 +-
 include/linux/ftrace.h             |    6 ++++++
 include/linux/rethook.h            |   11 ++++++-----
 kernel/kprobes.c                   |   10 ++++++++--
 kernel/trace/Kconfig               |    7 +++++++
 kernel/trace/bpf_trace.c           |    6 +++++-
 kernel/trace/fprobe.c              |    6 +++---
 kernel/trace/rethook.c             |   16 ++++++++--------
 kernel/trace/trace_fprobe.c        |    6 +++++-
 lib/test_fprobe.c                  |    6 +++---
 samples/fprobe/fprobe_example.c    |    2 +-
 23 files changed, 90 insertions(+), 51 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 12d51495caec..300d76c2ad77 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -191,6 +191,7 @@ config KRETPROBE_ON_RETHOOK
 	def_bool y
 	depends on HAVE_RETHOOK
 	depends on KRETPROBES
+	depends on HAVE_PT_REGS_TO_FTRACE_REGS_CAST || !HAVE_DYNAMIC_FTRACE_WITH_ARGS
 	select RETHOOK
 
 config USER_RETURN_NOTIFIER
diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index e14396a2ddcb..258e9bee1503 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -108,6 +108,7 @@ config LOONGARCH
 	select HAVE_DMA_CONTIGUOUS
 	select HAVE_DYNAMIC_FTRACE
 	select HAVE_DYNAMIC_FTRACE_WITH_ARGS
+	select HAVE_PT_REGS_TO_FTRACE_REGS_CAST
 	select HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
 	select HAVE_DYNAMIC_FTRACE_WITH_REGS
 	select HAVE_EBPF_JIT
diff --git a/arch/loongarch/kernel/rethook.c b/arch/loongarch/kernel/rethook.c
index db1c5f5024fd..d718327d1e88 100644
--- a/arch/loongarch/kernel/rethook.c
+++ b/arch/loongarch/kernel/rethook.c
@@ -8,19 +8,19 @@
 #include "rethook.h"
 
 /* This is called from arch_rethook_trampoline() */
-unsigned long __used arch_rethook_trampoline_callback(struct pt_regs *regs)
+unsigned long __used arch_rethook_trampoline_callback(struct ftrace_regs *fregs)
 {
-	return rethook_trampoline_handler(regs, 0);
+	return rethook_trampoline_handler(fregs, 0);
 }
 NOKPROBE_SYMBOL(arch_rethook_trampoline_callback);
 
-void arch_rethook_prepare(struct rethook_node *rhn, struct pt_regs *regs, bool mcount)
+void arch_rethook_prepare(struct rethook_node *rhn, struct ftrace_regs *fregs, bool mcount)
 {
 	rhn->frame = 0;
-	rhn->ret_addr = regs->regs[1];
+	rhn->ret_addr = fregs->regs.regs[1];
 
 	/* replace return addr with trampoline */
-	regs->regs[1] = (unsigned long)arch_rethook_trampoline;
+	fregs->regs.regs[1] = (unsigned long)arch_rethook_trampoline;
 }
 NOKPROBE_SYMBOL(arch_rethook_prepare);
 
diff --git a/arch/loongarch/kernel/rethook.h b/arch/loongarch/kernel/rethook.h
index 3f1c1edf0d0b..0643a8d6a8dd 100644
--- a/arch/loongarch/kernel/rethook.h
+++ b/arch/loongarch/kernel/rethook.h
@@ -2,7 +2,7 @@
 #ifndef __LOONGARCH_RETHOOK_H
 #define __LOONGARCH_RETHOOK_H
 
-unsigned long arch_rethook_trampoline_callback(struct pt_regs *regs);
-void arch_rethook_prepare(struct rethook_node *rhn, struct pt_regs *regs, bool mcount);
+unsigned long arch_rethook_trampoline_callback(struct ftrace_regs *fregs);
+void arch_rethook_prepare(struct rethook_node *rhn, struct ftrace_regs *fregs, bool mcount);
 
 #endif
diff --git a/arch/riscv/kernel/mcount-dyn.S b/arch/riscv/kernel/mcount-dyn.S
index 84963680eff4..184f76394ab8 100644
--- a/arch/riscv/kernel/mcount-dyn.S
+++ b/arch/riscv/kernel/mcount-dyn.S
@@ -20,6 +20,8 @@
 
 	/* Save t0 as epc for ftrace_regs_get_instruction_pointer() */
 	REG_S	t0, PT_EPC(sp)
+	/* Save s0  for reading frame pointer (read only) */
+	REG_S	s0, PT_S0(sp)
 	REG_S	a0, PT_A0(sp)
 	REG_S	a1, PT_A1(sp)
 	REG_S	a2, PT_A2(sp)
diff --git a/arch/riscv/kernel/probes/rethook.c b/arch/riscv/kernel/probes/rethook.c
index 5c27c1f50989..052fa1a363e6 100644
--- a/arch/riscv/kernel/probes/rethook.c
+++ b/arch/riscv/kernel/probes/rethook.c
@@ -8,20 +8,20 @@
 #include "rethook.h"
 
 /* This is called from arch_rethook_trampoline() */
-unsigned long __used arch_rethook_trampoline_callback(struct pt_regs *regs)
+unsigned long __used arch_rethook_trampoline_callback(struct ftrace_regs *fregs)
 {
-	return rethook_trampoline_handler(regs, regs->s0);
+	return rethook_trampoline_handler(fregs, fregs->regs.s0);
 }
 
 NOKPROBE_SYMBOL(arch_rethook_trampoline_callback);
 
-void arch_rethook_prepare(struct rethook_node *rhn, struct pt_regs *regs, bool mcount)
+void arch_rethook_prepare(struct rethook_node *rhn, struct ftrace_regs *fregs, bool mcount)
 {
-	rhn->ret_addr = regs->ra;
-	rhn->frame = regs->s0;
+	rhn->ret_addr = fregs->regs.ra;
+	rhn->frame = fregs->regs.s0;
 
 	/* replace return addr with trampoline */
-	regs->ra = (unsigned long)arch_rethook_trampoline;
+	fregs->regs.ra = (unsigned long)arch_rethook_trampoline;
 }
 
 NOKPROBE_SYMBOL(arch_rethook_prepare);
diff --git a/arch/riscv/kernel/probes/rethook.h b/arch/riscv/kernel/probes/rethook.h
index 4758f7e3ce88..f4ce353d2008 100644
--- a/arch/riscv/kernel/probes/rethook.h
+++ b/arch/riscv/kernel/probes/rethook.h
@@ -2,7 +2,9 @@
 #ifndef __RISCV_RETHOOK_H
 #define __RISCV_RETHOOK_H
 
-unsigned long arch_rethook_trampoline_callback(struct pt_regs *regs);
-void arch_rethook_prepare(struct rethook_node *rhn, struct pt_regs *regs, bool mcount);
+#include <linux/ftrace.h>
+
+unsigned long arch_rethook_trampoline_callback(struct ftrace_regs *fregs);
+void arch_rethook_prepare(struct rethook_node *rhn, struct ftrace_regs *fregs, bool mcount);
 
 #endif
diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index ae29e4392664..5aedb4320e7c 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -167,6 +167,7 @@ config S390
 	select HAVE_DMA_CONTIGUOUS
 	select HAVE_DYNAMIC_FTRACE
 	select HAVE_DYNAMIC_FTRACE_WITH_ARGS
+	select HAVE_PT_REGS_TO_FTRACE_REGS_CAST
 	select HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
 	select HAVE_DYNAMIC_FTRACE_WITH_REGS
 	select HAVE_EBPF_JIT if HAVE_MARCH_Z196_FEATURES
diff --git a/arch/s390/kernel/rethook.c b/arch/s390/kernel/rethook.c
index af10e6bdd34e..4e86c0a1a064 100644
--- a/arch/s390/kernel/rethook.c
+++ b/arch/s390/kernel/rethook.c
@@ -3,8 +3,9 @@
 #include <linux/kprobes.h>
 #include "rethook.h"
 
-void arch_rethook_prepare(struct rethook_node *rh, struct pt_regs *regs, bool mcount)
+void arch_rethook_prepare(struct rethook_node *rh, struct ftrace_regs *fregs, bool mcount)
 {
+	struct pt_regs *regs = (struct pt_regs *)fregs;
 	rh->ret_addr = regs->gprs[14];
 	rh->frame = regs->gprs[15];
 
@@ -13,10 +14,11 @@ void arch_rethook_prepare(struct rethook_node *rh, struct pt_regs *regs, bool mc
 }
 NOKPROBE_SYMBOL(arch_rethook_prepare);
 
-void arch_rethook_fixup_return(struct pt_regs *regs,
+void arch_rethook_fixup_return(struct ftrace_regs *fregs,
 			       unsigned long correct_ret_addr)
 {
 	/* Replace fake return address with real one. */
+	struct pt_regs *regs = (struct pt_regs *)fregs;
 	regs->gprs[14] = correct_ret_addr;
 }
 NOKPROBE_SYMBOL(arch_rethook_fixup_return);
@@ -24,9 +26,9 @@ NOKPROBE_SYMBOL(arch_rethook_fixup_return);
 /*
  * Called from arch_rethook_trampoline
  */
-unsigned long arch_rethook_trampoline_callback(struct pt_regs *regs)
+unsigned long arch_rethook_trampoline_callback(struct ftrace_regs *fregs)
 {
-	return rethook_trampoline_handler(regs, regs->gprs[15]);
+	return rethook_trampoline_handler(fregs, fregs->regs.gprs[15]);
 }
 NOKPROBE_SYMBOL(arch_rethook_trampoline_callback);
 
diff --git a/arch/s390/kernel/rethook.h b/arch/s390/kernel/rethook.h
index 32f069eed3f3..0fe62424fc78 100644
--- a/arch/s390/kernel/rethook.h
+++ b/arch/s390/kernel/rethook.h
@@ -2,6 +2,6 @@
 #ifndef __S390_RETHOOK_H
 #define __S390_RETHOOK_H
 
-unsigned long arch_rethook_trampoline_callback(struct pt_regs *regs);
+unsigned long arch_rethook_trampoline_callback(struct ftrace_regs *fregs);
 
 #endif
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 66bfabae8814..daca05e10956 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -209,6 +209,7 @@ config X86
 	select HAVE_DYNAMIC_FTRACE
 	select HAVE_DYNAMIC_FTRACE_WITH_REGS
 	select HAVE_DYNAMIC_FTRACE_WITH_ARGS	if X86_64
+	select HAVE_PT_REGS_TO_FTRACE_REGS_CAST	if X86_64
 	select HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
 	select HAVE_SAMPLE_FTRACE_DIRECT	if X86_64
 	select HAVE_SAMPLE_FTRACE_DIRECT_MULTI	if X86_64
diff --git a/arch/x86/kernel/rethook.c b/arch/x86/kernel/rethook.c
index 8a1c0111ae79..d714d0276c93 100644
--- a/arch/x86/kernel/rethook.c
+++ b/arch/x86/kernel/rethook.c
@@ -83,7 +83,8 @@ __used __visible void arch_rethook_trampoline_callback(struct pt_regs *regs)
 	 * arch_rethook_fixup_return() which called from this
 	 * rethook_trampoline_handler().
 	 */
-	rethook_trampoline_handler(regs, (unsigned long)frame_pointer);
+	rethook_trampoline_handler((struct ftrace_regs *)regs,
+				   (unsigned long)frame_pointer);
 
 	/*
 	 * Copy FLAGS to 'pt_regs::ss' so that arch_rethook_trapmoline()
@@ -104,22 +105,22 @@ NOKPROBE_SYMBOL(arch_rethook_trampoline_callback);
 STACK_FRAME_NON_STANDARD_FP(arch_rethook_trampoline);
 
 /* This is called from rethook_trampoline_handler(). */
-void arch_rethook_fixup_return(struct pt_regs *regs,
+void arch_rethook_fixup_return(struct ftrace_regs *fregs,
 			       unsigned long correct_ret_addr)
 {
-	unsigned long *frame_pointer = (void *)(regs + 1);
+	unsigned long *frame_pointer = (void *)(fregs + 1);
 
 	/* Replace fake return address with real one. */
 	*frame_pointer = correct_ret_addr;
 }
 NOKPROBE_SYMBOL(arch_rethook_fixup_return);
 
-void arch_rethook_prepare(struct rethook_node *rh, struct pt_regs *regs, bool mcount)
+void arch_rethook_prepare(struct rethook_node *rh, struct ftrace_regs *fregs, bool mcount)
 {
-	unsigned long *stack = (unsigned long *)regs->sp;
+	unsigned long *stack = (unsigned long *)ftrace_regs_get_stack_pointer(fregs);
 
 	rh->ret_addr = stack[0];
-	rh->frame = regs->sp;
+	rh->frame = (unsigned long)stack;
 
 	/* Replace the return addr with trampoline addr */
 	stack[0] = (unsigned long) arch_rethook_trampoline;
diff --git a/include/linux/fprobe.h b/include/linux/fprobe.h
index 36c0595f7b93..b9c0c216dedb 100644
--- a/include/linux/fprobe.h
+++ b/include/linux/fprobe.h
@@ -38,7 +38,7 @@ struct fprobe {
 			     unsigned long ret_ip, struct ftrace_regs *regs,
 			     void *entry_data);
 	void (*exit_handler)(struct fprobe *fp, unsigned long entry_ip,
-			     unsigned long ret_ip, struct pt_regs *regs,
+			     unsigned long ret_ip, struct ftrace_regs *regs,
 			     void *entry_data);
 };
 
diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 15f4865a4083..39a765c71f7e 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -159,6 +159,12 @@ struct ftrace_regs {
 
 #endif /* !CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS || !CONFIG_FUNCTION_TRACER */
 
+#ifdef CONFIG_HAVE_PT_REGS_TO_FTRACE_REGS_CAST
+
+static_assert(sizeof(struct pt_regs) == sizeof(struct ftrace_regs));
+
+#endif /* CONFIG_HAVE_PT_REGS_TO_FTRACE_REGS_CAST */
+
 static __always_inline struct pt_regs *ftrace_get_regs(struct ftrace_regs *fregs)
 {
 	if (!fregs)
diff --git a/include/linux/rethook.h b/include/linux/rethook.h
index 26b6f3c81a76..138d64c8b67b 100644
--- a/include/linux/rethook.h
+++ b/include/linux/rethook.h
@@ -7,6 +7,7 @@
 
 #include <linux/compiler.h>
 #include <linux/freelist.h>
+#include <linux/ftrace.h>
 #include <linux/kallsyms.h>
 #include <linux/llist.h>
 #include <linux/rcupdate.h>
@@ -14,7 +15,7 @@
 
 struct rethook_node;
 
-typedef void (*rethook_handler_t) (struct rethook_node *, void *, unsigned long, struct pt_regs *);
+typedef void (*rethook_handler_t) (struct rethook_node *, void *, unsigned long, struct ftrace_regs *);
 
 /**
  * struct rethook - The rethook management data structure.
@@ -64,12 +65,12 @@ void rethook_free(struct rethook *rh);
 void rethook_add_node(struct rethook *rh, struct rethook_node *node);
 struct rethook_node *rethook_try_get(struct rethook *rh);
 void rethook_recycle(struct rethook_node *node);
-void rethook_hook(struct rethook_node *node, struct pt_regs *regs, bool mcount);
+void rethook_hook(struct rethook_node *node, struct ftrace_regs *regs, bool mcount);
 unsigned long rethook_find_ret_addr(struct task_struct *tsk, unsigned long frame,
 				    struct llist_node **cur);
 
 /* Arch dependent code must implement arch_* and trampoline code */
-void arch_rethook_prepare(struct rethook_node *node, struct pt_regs *regs, bool mcount);
+void arch_rethook_prepare(struct rethook_node *node, struct ftrace_regs *regs, bool mcount);
 void arch_rethook_trampoline(void);
 
 /**
@@ -84,11 +85,11 @@ static inline bool is_rethook_trampoline(unsigned long addr)
 }
 
 /* If the architecture needs to fixup the return address, implement it. */
-void arch_rethook_fixup_return(struct pt_regs *regs,
+void arch_rethook_fixup_return(struct ftrace_regs *regs,
 			       unsigned long correct_ret_addr);
 
 /* Generic trampoline handler, arch code must prepare asm stub */
-unsigned long rethook_trampoline_handler(struct pt_regs *regs,
+unsigned long rethook_trampoline_handler(struct ftrace_regs *regs,
 					 unsigned long frame);
 
 #ifdef CONFIG_RETHOOK
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 0c6185aefaef..821dff656149 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -2132,7 +2132,11 @@ static int pre_handler_kretprobe(struct kprobe *p, struct pt_regs *regs)
 	if (rp->entry_handler && rp->entry_handler(ri, regs))
 		rethook_recycle(rhn);
 	else
-		rethook_hook(rhn, regs, kprobe_ftrace(p));
+		/*
+		 * We can cast pt_regs to ftrace_regs because this depends on
+		 * HAVE_PT_REGS_TO_FTRACE_REGS_CAST.
+		 */
+		rethook_hook(rhn, (struct ftrace_regs *)regs, kprobe_ftrace(p));
 
 	return 0;
 }
@@ -2140,9 +2144,11 @@ NOKPROBE_SYMBOL(pre_handler_kretprobe);
 
 static void kretprobe_rethook_handler(struct rethook_node *rh, void *data,
 				      unsigned long ret_addr,
-				      struct pt_regs *regs)
+				      struct ftrace_regs *fregs)
 {
 	struct kretprobe *rp = (struct kretprobe *)data;
+	/* Ditto, this depends on HAVE_PT_REGS_TO_FTRACE_REGS_CAST. */
+	struct pt_regs *regs = (struct pt_regs *)fregs;
 	struct kretprobe_instance *ri;
 	struct kprobe_ctlblk *kcb;
 
diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index 976fd594b446..d56304276318 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -57,6 +57,13 @@ config HAVE_DYNAMIC_FTRACE_WITH_ARGS
 	 This allows for use of ftrace_regs_get_argument() and
 	 ftrace_regs_get_stack_pointer().
 
+config HAVE_PT_REGS_TO_FTRACE_REGS_CAST
+	bool
+	help
+	 If this is set, the memory layout of the ftrace_regs data structure
+	 is the same as the pt_regs. So the pt_regs is possible to be casted
+	 to ftrace_regs.
+
 config HAVE_DYNAMIC_FTRACE_NO_PATCHABLE
 	bool
 	help
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index efb3c265cad8..8bb003ce7bb2 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -2745,10 +2745,14 @@ kprobe_multi_link_handler(struct fprobe *fp, unsigned long fentry_ip,
 
 static void
 kprobe_multi_link_exit_handler(struct fprobe *fp, unsigned long fentry_ip,
-			       unsigned long ret_ip, struct pt_regs *regs,
+			       unsigned long ret_ip, struct ftrace_regs *fregs,
 			       void *data)
 {
 	struct bpf_kprobe_multi_link *link;
+	struct pt_regs *regs = ftrace_get_regs(fregs);
+
+	if (!regs)
+		return;
 
 	link = container_of(fp, struct bpf_kprobe_multi_link, fp);
 	kprobe_multi_link_prog_run(link, get_entry_ip(fentry_ip), regs);
diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
index 07deb52df44a..dfddc7e8424e 100644
--- a/kernel/trace/fprobe.c
+++ b/kernel/trace/fprobe.c
@@ -53,7 +53,7 @@ static inline void __fprobe_handler(unsigned long ip, unsigned long parent_ip,
 		if (ret)
 			rethook_recycle(rh);
 		else
-			rethook_hook(rh, ftrace_get_regs(fregs), true);
+			rethook_hook(rh, fregs, true);
 	}
 }
 
@@ -120,7 +120,7 @@ static void fprobe_kprobe_handler(unsigned long ip, unsigned long parent_ip,
 }
 
 static void fprobe_exit_handler(struct rethook_node *rh, void *data,
-				unsigned long ret_ip, struct pt_regs *regs)
+				unsigned long ret_ip, struct ftrace_regs *fregs)
 {
 	struct fprobe *fp = (struct fprobe *)data;
 	struct fprobe_rethook_node *fpr;
@@ -141,7 +141,7 @@ static void fprobe_exit_handler(struct rethook_node *rh, void *data,
 		return;
 	}
 
-	fp->exit_handler(fp, fpr->entry_ip, ret_ip, regs,
+	fp->exit_handler(fp, fpr->entry_ip, ret_ip, fregs,
 			 fp->entry_data_size ? (void *)fpr->data : NULL);
 	ftrace_test_recursion_unlock(bit);
 }
diff --git a/kernel/trace/rethook.c b/kernel/trace/rethook.c
index 5eb9b598f4e9..7c5cf9d5910c 100644
--- a/kernel/trace/rethook.c
+++ b/kernel/trace/rethook.c
@@ -189,7 +189,7 @@ NOKPROBE_SYMBOL(rethook_try_get);
 /**
  * rethook_hook() - Hook the current function return.
  * @node: The struct rethook node to hook the function return.
- * @regs: The struct pt_regs for the function entry.
+ * @fregs: The struct ftrace_regs for the function entry.
  * @mcount: True if this is called from mcount(ftrace) context.
  *
  * Hook the current running function return. This must be called when the
@@ -199,9 +199,9 @@ NOKPROBE_SYMBOL(rethook_try_get);
  * from the real function entry (e.g. kprobes) @mcount must be set false.
  * This is because the way to hook the function return depends on the context.
  */
-void rethook_hook(struct rethook_node *node, struct pt_regs *regs, bool mcount)
+void rethook_hook(struct rethook_node *node, struct ftrace_regs *fregs, bool mcount)
 {
-	arch_rethook_prepare(node, regs, mcount);
+	arch_rethook_prepare(node, fregs, mcount);
 	__llist_add(&node->llist, &current->rethooks);
 }
 NOKPROBE_SYMBOL(rethook_hook);
@@ -269,7 +269,7 @@ unsigned long rethook_find_ret_addr(struct task_struct *tsk, unsigned long frame
 }
 NOKPROBE_SYMBOL(rethook_find_ret_addr);
 
-void __weak arch_rethook_fixup_return(struct pt_regs *regs,
+void __weak arch_rethook_fixup_return(struct ftrace_regs *fregs,
 				      unsigned long correct_ret_addr)
 {
 	/*
@@ -281,7 +281,7 @@ void __weak arch_rethook_fixup_return(struct pt_regs *regs,
 }
 
 /* This function will be called from each arch-defined trampoline. */
-unsigned long rethook_trampoline_handler(struct pt_regs *regs,
+unsigned long rethook_trampoline_handler(struct ftrace_regs *fregs,
 					 unsigned long frame)
 {
 	struct llist_node *first, *node = NULL;
@@ -295,7 +295,7 @@ unsigned long rethook_trampoline_handler(struct pt_regs *regs,
 		BUG_ON(1);
 	}
 
-	instruction_pointer_set(regs, correct_ret_addr);
+	ftrace_regs_set_instruction_pointer(fregs, correct_ret_addr);
 
 	/*
 	 * These loops must be protected from rethook_free_rcu() because those
@@ -315,7 +315,7 @@ unsigned long rethook_trampoline_handler(struct pt_regs *regs,
 		handler = READ_ONCE(rhn->rethook->handler);
 		if (handler)
 			handler(rhn, rhn->rethook->data,
-				correct_ret_addr, regs);
+				correct_ret_addr, fregs);
 
 		if (first == node)
 			break;
@@ -323,7 +323,7 @@ unsigned long rethook_trampoline_handler(struct pt_regs *regs,
 	}
 
 	/* Fixup registers for returning to correct address. */
-	arch_rethook_fixup_return(regs, correct_ret_addr);
+	arch_rethook_fixup_return(fregs, correct_ret_addr);
 
 	/* Unlink used shadow stack */
 	first = current->rethooks.first;
diff --git a/kernel/trace/trace_fprobe.c b/kernel/trace/trace_fprobe.c
index 71bf38d698f1..c60d0d9f1a95 100644
--- a/kernel/trace/trace_fprobe.c
+++ b/kernel/trace/trace_fprobe.c
@@ -341,10 +341,14 @@ static int fentry_dispatcher(struct fprobe *fp, unsigned long entry_ip,
 NOKPROBE_SYMBOL(fentry_dispatcher);
 
 static void fexit_dispatcher(struct fprobe *fp, unsigned long entry_ip,
-			     unsigned long ret_ip, struct pt_regs *regs,
+			     unsigned long ret_ip, struct ftrace_regs *fregs,
 			     void *entry_data)
 {
 	struct trace_fprobe *tf = container_of(fp, struct trace_fprobe, fp);
+	struct pt_regs *regs = ftrace_get_regs(fregs);
+
+	if (!regs)
+		return;
 
 	if (trace_probe_test_flag(&tf->tp, TP_FLAG_TRACE))
 		fexit_trace_func(tf, entry_ip, ret_ip, regs);
diff --git a/lib/test_fprobe.c b/lib/test_fprobe.c
index ff607babba18..d1e80653bf0c 100644
--- a/lib/test_fprobe.c
+++ b/lib/test_fprobe.c
@@ -59,9 +59,9 @@ static notrace int fp_entry_handler(struct fprobe *fp, unsigned long ip,
 
 static notrace void fp_exit_handler(struct fprobe *fp, unsigned long ip,
 				    unsigned long ret_ip,
-				    struct pt_regs *regs, void *data)
+				    struct ftrace_regs *fregs, void *data)
 {
-	unsigned long ret = regs_return_value(regs);
+	unsigned long ret = ftrace_regs_return_value(fregs);
 
 	KUNIT_EXPECT_FALSE(current_test, preemptible());
 	if (ip != target_ip) {
@@ -89,7 +89,7 @@ static notrace int nest_entry_handler(struct fprobe *fp, unsigned long ip,
 
 static notrace void nest_exit_handler(struct fprobe *fp, unsigned long ip,
 				      unsigned long ret_ip,
-				      struct pt_regs *regs, void *data)
+				      struct ftrace_regs *fregs, void *data)
 {
 	KUNIT_EXPECT_FALSE(current_test, preemptible());
 	KUNIT_EXPECT_EQ(current_test, ip, target_nest_ip);
diff --git a/samples/fprobe/fprobe_example.c b/samples/fprobe/fprobe_example.c
index 1545a1aac616..d476d1f07538 100644
--- a/samples/fprobe/fprobe_example.c
+++ b/samples/fprobe/fprobe_example.c
@@ -67,7 +67,7 @@ static int sample_entry_handler(struct fprobe *fp, unsigned long ip,
 }
 
 static void sample_exit_handler(struct fprobe *fp, unsigned long ip,
-				unsigned long ret_ip, struct pt_regs *regs,
+				unsigned long ret_ip, struct ftrace_regs *regs,
 				void *data)
 {
 	unsigned long rip = ret_ip;


