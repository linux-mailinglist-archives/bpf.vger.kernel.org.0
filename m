Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1355034A752
	for <lists+bpf@lfdr.de>; Fri, 26 Mar 2021 13:31:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbhCZMbJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Mar 2021 08:31:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:53536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230311AbhCZMah (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 26 Mar 2021 08:30:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 251FD61948;
        Fri, 26 Mar 2021 12:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616761837;
        bh=JRj98AwQ1oExN3PtE2Kd1LBWPt7ablXsd9kQQcSUitU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ajEomi9HvCV2SHXKgRgopyCB2EgC4GTSWqLsIBIcDAO2Msq3U8Gnsv8akWXsMfBGa
         uYmLH5fhHC3tLWxG2EvbzsXx9Q0TNeXoHK8+3fhWYdF1+MAREpRUoGxTGxGpjhtS1d
         UX2cftIGCyto7P45aOYufUSkI6Y+oZPi9o9hmPJG3OHW0HKyeYNKMwKL6+3GHUyKFI
         GOLFRsYdg/Bvkn+UUbBWvN4YRvvKSiQYRY4OVS4kOpPY2L2ITGsE2+aH0N3bdX0zQn
         TNa2leJaAKuQVo0ZlU3SYALYqzkYxfbcCb2aQxR0OKUoQOChhl4LNP4+PViQMJgOlN
         reQN627EwJy5g==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>
Cc:     X86 ML <x86@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>,
        Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, kuba@kernel.org, mingo@redhat.com,
        ast@kernel.org, tglx@linutronix.de, kernel-team@fb.com, yhs@fb.com,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        linux-ia64@vger.kernel.org,
        Abhishek Sagar <sagar.abhishek@gmail.com>
Subject: [PATCH -tip v5 11/12] x86/unwind: Recover kretprobe trampoline entry
Date:   Fri, 26 Mar 2021 21:30:31 +0900
Message-Id: <161676183146.330141.12978911757114113363.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <161676170650.330141.6214727134265514123.stgit@devnote2>
References: <161676170650.330141.6214727134265514123.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Since the kretprobe replaces the function return address with
the kretprobe_trampoline on the stack, x86 unwinders can not
continue the stack unwinding at that point, or record
kretprobe_trampoline instead of correct return address.

To fix this issue, find the correct return address from task's
kretprobe_instances as like as function-graph tracer does.

With this fix, the unwinder can correctly unwind the stack
from kretprobe event on x86, as below.

           <...>-135     [003] ...1     6.722338: r_full_proxy_read_0: (vfs_read+0xab/0x1a0 <- full_proxy_read)
           <...>-135     [003] ...1     6.722377: <stack trace>
 => kretprobe_trace_func+0x209/0x2f0
 => kretprobe_dispatcher+0x4a/0x70
 => __kretprobe_trampoline_handler+0xca/0x150
 => trampoline_handler+0x44/0x70
 => kretprobe_trampoline+0x2a/0x50
 => vfs_read+0xab/0x1a0
 => ksys_read+0x5f/0xe0
 => do_syscall_64+0x33/0x40
 => entry_SYSCALL_64_after_hwframe+0x44/0xae


Reported-by: Daniel Xu <dxu@dxuuu.xyz>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Suggested-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
  Changes in v5:
   - Fix the case of interrupt happens on kretprobe_trampoline+0.
  Changes in v3:
   - Split out the kretprobe side patch
   - Fix build error when CONFIG_KRETPROBES=n.
  Changes in v2:
   - Remove kretprobe wrapper functions from unwind_orc.c
   - Do not fixup state->ip when unwinding with regs because
     kretprobe fixup instruction pointer before calling handler.
---
 arch/x86/include/asm/unwind.h  |   23 +++++++++++++++++++++++
 arch/x86/kernel/unwind_frame.c |    4 ++--
 arch/x86/kernel/unwind_guess.c |    3 +--
 arch/x86/kernel/unwind_orc.c   |   19 +++++++++++++++----
 4 files changed, 41 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/unwind.h b/arch/x86/include/asm/unwind.h
index 70fc159ebe69..36d3971c0a2c 100644
--- a/arch/x86/include/asm/unwind.h
+++ b/arch/x86/include/asm/unwind.h
@@ -4,6 +4,7 @@
 
 #include <linux/sched.h>
 #include <linux/ftrace.h>
+#include <linux/kprobes.h>
 #include <asm/ptrace.h>
 #include <asm/stacktrace.h>
 
@@ -15,6 +16,7 @@ struct unwind_state {
 	unsigned long stack_mask;
 	struct task_struct *task;
 	int graph_idx;
+	struct llist_node *kr_cur;
 	bool error;
 #if defined(CONFIG_UNWINDER_ORC)
 	bool signal, full_regs;
@@ -99,6 +101,27 @@ void unwind_module_init(struct module *mod, void *orc_ip, size_t orc_ip_size,
 			void *orc, size_t orc_size) {}
 #endif
 
+static inline
+unsigned long unwind_recover_kretprobe(struct unwind_state *state,
+				       unsigned long addr, unsigned long *addr_p)
+{
+	return is_kretprobe_trampoline(addr) ?
+		kretprobe_find_ret_addr(state->task, addr_p, &state->kr_cur) :
+		addr;
+}
+
+/* Recover the return address modified by instrumentation (e.g. kretprobe) */
+static inline
+unsigned long unwind_recover_ret_addr(struct unwind_state *state,
+				     unsigned long addr, unsigned long *addr_p)
+{
+	unsigned long ret;
+
+	ret = ftrace_graph_ret_addr(state->task, &state->graph_idx,
+				    addr, addr_p);
+	return unwind_recover_kretprobe(state, ret, addr_p);
+}
+
 /*
  * This disables KASAN checking when reading a value from another task's stack,
  * since the other task could be running on another CPU and could have poisoned
diff --git a/arch/x86/kernel/unwind_frame.c b/arch/x86/kernel/unwind_frame.c
index d7c44b257f7f..24e33b44b2be 100644
--- a/arch/x86/kernel/unwind_frame.c
+++ b/arch/x86/kernel/unwind_frame.c
@@ -3,6 +3,7 @@
 #include <linux/sched/task.h>
 #include <linux/sched/task_stack.h>
 #include <linux/interrupt.h>
+#include <linux/kprobes.h>
 #include <asm/sections.h>
 #include <asm/ptrace.h>
 #include <asm/bitops.h>
@@ -240,8 +241,7 @@ static bool update_stack_state(struct unwind_state *state,
 	else {
 		addr_p = unwind_get_return_address_ptr(state);
 		addr = READ_ONCE_TASK_STACK(state->task, *addr_p);
-		state->ip = ftrace_graph_ret_addr(state->task, &state->graph_idx,
-						  addr, addr_p);
+		state->ip = unwind_recover_ret_addr(state, addr, addr_p);
 	}
 
 	/* Save the original stack pointer for unwind_dump(): */
diff --git a/arch/x86/kernel/unwind_guess.c b/arch/x86/kernel/unwind_guess.c
index c49f10ffd8cd..884d68a6e714 100644
--- a/arch/x86/kernel/unwind_guess.c
+++ b/arch/x86/kernel/unwind_guess.c
@@ -15,8 +15,7 @@ unsigned long unwind_get_return_address(struct unwind_state *state)
 
 	addr = READ_ONCE_NOCHECK(*state->sp);
 
-	return ftrace_graph_ret_addr(state->task, &state->graph_idx,
-				     addr, state->sp);
+	return unwind_recover_ret_addr(state, addr, state->sp);
 }
 EXPORT_SYMBOL_GPL(unwind_get_return_address);
 
diff --git a/arch/x86/kernel/unwind_orc.c b/arch/x86/kernel/unwind_orc.c
index a1202536fc57..c70dfeea4552 100644
--- a/arch/x86/kernel/unwind_orc.c
+++ b/arch/x86/kernel/unwind_orc.c
@@ -2,6 +2,7 @@
 #include <linux/objtool.h>
 #include <linux/module.h>
 #include <linux/sort.h>
+#include <linux/kprobes.h>
 #include <asm/ptrace.h>
 #include <asm/stacktrace.h>
 #include <asm/unwind.h>
@@ -534,9 +535,8 @@ bool unwind_next_frame(struct unwind_state *state)
 		if (!deref_stack_reg(state, ip_p, &state->ip))
 			goto err;
 
-		state->ip = ftrace_graph_ret_addr(state->task, &state->graph_idx,
-						  state->ip, (void *)ip_p);
-
+		state->ip = unwind_recover_ret_addr(state, state->ip,
+						    (unsigned long *)ip_p);
 		state->sp = sp;
 		state->regs = NULL;
 		state->prev_regs = NULL;
@@ -549,7 +549,15 @@ bool unwind_next_frame(struct unwind_state *state)
 					 (void *)orig_ip);
 			goto err;
 		}
-
+		/*
+		 * There is a small chance to interrupt at the entry of
+		 * kretprobe_trampoline where the ORC info doesn't exist.
+		 * That point is right after the RET to kretprobe_trampoline
+		 * which was modified return address. So the @addr_p must
+		 * be right before the regs->sp.
+		 */
+		state->ip = unwind_recover_kretprobe(state, state->ip,
+				(unsigned long *)(state->sp - sizeof(long)));
 		state->regs = (struct pt_regs *)sp;
 		state->prev_regs = NULL;
 		state->full_regs = true;
@@ -562,6 +570,9 @@ bool unwind_next_frame(struct unwind_state *state)
 					 (void *)orig_ip);
 			goto err;
 		}
+		/* See UNWIND_HINT_TYPE_REGS case comment. */
+		state->ip = unwind_recover_kretprobe(state, state->ip,
+				(unsigned long *)(state->sp - sizeof(long)));
 
 		if (state->full_regs)
 			state->prev_regs = state->regs;

