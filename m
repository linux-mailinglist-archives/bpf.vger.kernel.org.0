Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B8CB493C57
	for <lists+bpf@lfdr.de>; Wed, 19 Jan 2022 15:57:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355355AbiASO5n (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 19 Jan 2022 09:57:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355366AbiASO5Z (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 19 Jan 2022 09:57:25 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AA1CC06173F;
        Wed, 19 Jan 2022 06:57:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1F6A8B8197E;
        Wed, 19 Jan 2022 14:57:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18141C004E1;
        Wed, 19 Jan 2022 14:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642604242;
        bh=Op7mH4KEnWauDXaI4rqBtjVwRxEE7z3ton+7Y4LnGdo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Nw68brpCU5wz6LRer3us5lbSevr39Iyhi9HkdrhYvCMNdWFEgkVrlKpP+QXgH6E1N
         TpXuU6B8xH2hy8q9r4sLsYMlmbJdO/PJKMSurqmp4vwBytm+QKANU+XXsevcymswQs
         tR/iOARz0JZ1Jfa5d44odVuGUuS7VHcTIF0FkPF2Q9wJx7RxkEwt8egJhqv8Pdpj49
         ifgFal8j5P6TL76m71dDTEcBFr4YYkRBbMzQSmyQG1XVyrqOoOhSLYhoF2+iZk9io7
         yylcgylGntUUqNyCcdDTKCgmIA3nS8o8EVvjh1l+utWRSblCiOoI4KOVLjiqCocPbM
         zo7Q0CDROZmpA==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>, Alexei Starovoitov <ast@kernel.org>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S . Miller" <davem@davemloft.net>
Subject: [RFC PATCH v3 4/9] rethook: x86: Add rethook x86 implementation
Date:   Wed, 19 Jan 2022 23:57:17 +0900
Message-Id: <164260423762.657731.14280896558231150997.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <164260419349.657731.13913104835063027148.stgit@devnote2>
References: <164260419349.657731.13913104835063027148.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add rethook for x86 implementation. Most of the code
has been copied from kretprobes on x86.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 arch/x86/Kconfig          |    1 
 arch/x86/kernel/Makefile  |    1 
 arch/x86/kernel/rethook.c |  115 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 117 insertions(+)
 create mode 100644 arch/x86/kernel/rethook.c

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 5c2ccb85f2ef..0a7d48a63787 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -219,6 +219,7 @@ config X86
 	select HAVE_KPROBES_ON_FTRACE
 	select HAVE_FUNCTION_ERROR_INJECTION
 	select HAVE_KRETPROBES
+	select HAVE_RETHOOK
 	select HAVE_KVM
 	select HAVE_LIVEPATCH			if X86_64
 	select HAVE_MIXED_BREAKPOINTS_REGS
diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index 2ff3e600f426..66593d8c4d74 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -106,6 +106,7 @@ obj-$(CONFIG_FUNCTION_GRAPH_TRACER) += ftrace.o
 obj-$(CONFIG_FTRACE_SYSCALLS)	+= ftrace.o
 obj-$(CONFIG_X86_TSC)		+= trace_clock.o
 obj-$(CONFIG_TRACING)		+= trace.o
+obj-$(CONFIG_RETHOOK)		+= rethook.o
 obj-$(CONFIG_CRASH_CORE)	+= crash_core_$(BITS).o
 obj-$(CONFIG_KEXEC_CORE)	+= machine_kexec_$(BITS).o
 obj-$(CONFIG_KEXEC_CORE)	+= relocate_kernel_$(BITS).o crash.o
diff --git a/arch/x86/kernel/rethook.c b/arch/x86/kernel/rethook.c
new file mode 100644
index 000000000000..f2f3b9526e43
--- /dev/null
+++ b/arch/x86/kernel/rethook.c
@@ -0,0 +1,115 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * x86 implementation of rethook. Mostly copied from arch/x86/kernel/kprobes/core.c.
+ */
+#include <linux/bug.h>
+#include <linux/rethook.h>
+#include <linux/kprobes.h>
+
+#include "kprobes/common.h"
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
+ * When a target function returns, this code saves registers and calls
+ * arch_rethook_trampoline_callback(), which calls the rethook handler.
+ */
+asm(
+	".text\n"
+	".global arch_rethook_trampoline\n"
+	".type arch_rethook_trampoline, @function\n"
+	"arch_rethook_trampoline:\n"
+#ifdef CONFIG_X86_64
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
+	"	ret\n"
+	".size arch_rethook_trampoline, .-arch_rethook_trampoline\n"
+);
+NOKPROBE_SYMBOL(arch_rethook_trampoline);
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
+
+void arch_rethook_prepare(struct rethook_node *rh, struct pt_regs *regs)
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

