Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85D7C40B1B8
	for <lists+bpf@lfdr.de>; Tue, 14 Sep 2021 16:43:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234781AbhINOon (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Sep 2021 10:44:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:37916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234359AbhINOnw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Sep 2021 10:43:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E4C53610CE;
        Tue, 14 Sep 2021 14:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631630555;
        bh=juSmhxL2xpDmE4nzcIHTKDR3pzJZ+yWbGObEWpwCpho=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PZ/qNmAZcrQwVPCzPPCGH9wQ6R45z0vu/AUPStlFjpz9ePnkbLSL8Q+xNXd+FW5wB
         fi+glgnyZc6ft830YvM6QTjNDiPrtdKXIULLrO8vJZudR1IvHe4ZbMTG8Dg7QuqzZk
         VXNJ4/TVQd/V2qwfmmrnWpymFeKfTrKo8vFDV++Il25NqRRmgkNxj11ixNE0wIgdbh
         NBFFogEoyjZ6uix7qvRp4fyk3eK/BYJB7vqgUnZle7mHks0NckGaPewStHldHnY+Cs
         QSfuZi/+ZVaK26zCdzrRuPQLQasxMIjweiAiNQ6VV/1q5jy0PTBlUvcR469UNrP8ep
         FBcXyzXwQ4wbA==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@kernel.org>
Cc:     X86 ML <x86@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>,
        Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, kuba@kernel.org, mingo@redhat.com,
        ast@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>, kernel-team@fb.com,
        yhs@fb.com, linux-ia64@vger.kernel.org,
        Abhishek Sagar <sagar.abhishek@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Paul McKenney <paulmck@kernel.org>
Subject: [PATCH -tip v11 25/27] x86/unwind: Recover kretprobe trampoline entry
Date:   Tue, 14 Sep 2021 23:42:31 +0900
Message-Id: <163163055130.489837.5161749078833497255.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <163163030719.489837.2236069935502195491.stgit@devnote2>
References: <163163030719.489837.2236069935502195491.stgit@devnote2>
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
Tested-by: Andrii Nakryiko <andrii@kernel.org>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
  Changes in v9:
   - Update comment so that it explains why the strange address passed
     to unwind_recover_kretprobe().
  Changes in v7:
   - Remove superfluous #include <linux/kprobes.h>.
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
 arch/x86/kernel/unwind_frame.c |    3 +--
 arch/x86/kernel/unwind_guess.c |    3 +--
 arch/x86/kernel/unwind_orc.c   |   21 +++++++++++++++++----
 4 files changed, 42 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/unwind.h b/arch/x86/include/asm/unwind.h
index 70fc159ebe69..fca2e783e3ce 100644
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
+/* Recover the return address modified by kretprobe and ftrace_graph. */
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
index d7c44b257f7f..8e1c50c86e5d 100644
--- a/arch/x86/kernel/unwind_frame.c
+++ b/arch/x86/kernel/unwind_frame.c
@@ -240,8 +240,7 @@ static bool update_stack_state(struct unwind_state *state,
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
index a1202536fc57..e6f7592790af 100644
--- a/arch/x86/kernel/unwind_orc.c
+++ b/arch/x86/kernel/unwind_orc.c
@@ -534,9 +534,8 @@ bool unwind_next_frame(struct unwind_state *state)
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
@@ -549,7 +548,18 @@ bool unwind_next_frame(struct unwind_state *state)
 					 (void *)orig_ip);
 			goto err;
 		}
-
+		/*
+		 * There is a small chance to interrupt at the entry of
+		 * __kretprobe_trampoline() where the ORC info doesn't exist.
+		 * That point is right after the RET to __kretprobe_trampoline()
+		 * which was modified return address.
+		 * At that point, the @addr_p of the unwind_recover_kretprobe()
+		 * (this has to point the address of the stack entry storing
+		 * the modified return address) must be "SP - (a stack entry)"
+		 * because SP is incremented by the RET.
+		 */
+		state->ip = unwind_recover_kretprobe(state, state->ip,
+				(unsigned long *)(state->sp - sizeof(long)));
 		state->regs = (struct pt_regs *)sp;
 		state->prev_regs = NULL;
 		state->full_regs = true;
@@ -562,6 +572,9 @@ bool unwind_next_frame(struct unwind_state *state)
 					 (void *)orig_ip);
 			goto err;
 		}
+		/* See UNWIND_HINT_TYPE_REGS case comment. */
+		state->ip = unwind_recover_kretprobe(state, state->ip,
+				(unsigned long *)(state->sp - sizeof(long)));
 
 		if (state->full_regs)
 			state->prev_regs = state->regs;

