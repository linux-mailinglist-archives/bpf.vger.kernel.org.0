Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83D79338619
	for <lists+bpf@lfdr.de>; Fri, 12 Mar 2021 07:43:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231936AbhCLGm6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 12 Mar 2021 01:42:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:44246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229564AbhCLGme (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 12 Mar 2021 01:42:34 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8A2A964EB6;
        Fri, 12 Mar 2021 06:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615531353;
        bh=9se0kbSm4eP9dqqxCyvLWIBTb8rpukkjidNeFngG5Bk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ks32ILZIAzV2brfp5TpypMuHL30BozJqUMH259ZgCtZLjcEMf6yxBEyTScJvE3gdm
         sGAPgsqyOsps7f9vKRoF00JYkW6wBXtsA8Jx+z5Ucq6kj/EbhEtCR2Z4VMzxJPTcuG
         qH6nzZGHlDgtmOj9JO6DLRHkU3YT6qdH7vHzx2gkyP1xM7EqSi5GMb4+mQ6ZyPh4dT
         Dz7uqQu+NSMAQ6SJZTHPPX+x/AL3dGd68SmFfOo1wIouAsDWiIpA7bpD1ijz/1LUNo
         XlZ/hDHGa/GTAWzu1TiVibBsqz79OEtI7KAXldhbMXvTzOmKhEDEhgi4DLpD563bhm
         6AoyFjjeFhdoQ==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>
Cc:     X86 ML <x86@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>,
        Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, kuba@kernel.org, mingo@redhat.com,
        ast@kernel.org, tglx@linutronix.de, kernel-team@fb.com, yhs@fb.com,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [PATCH -tip v2 04/10] kprobes: stacktrace: Recover the address changed by kretprobe
Date:   Fri, 12 Mar 2021 15:42:28 +0900
Message-Id: <161553134798.1038734.10913826398325010608.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <161553130371.1038734.7661319550287837734.stgit@devnote2>
References: <161553130371.1038734.7661319550287837734.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Recover the return address on the stack which changed by the
kretprobe. Note that this does not recover the address on the
!current stack trace if CONFIG_ARCH_STACKWALK=n because old
stack trace interface doesn't lock the stack in the generic
stack_trace_save*() functions.

So with this patch, ftrace correctly shows the stacktrace
as below;

 # echo r vfs_read > kprobe_events
 # echo stacktrace > events/kprobes/r_vfs_read_0/trigger
 # echo 1 > events/kprobes/r_vfs_read_0/enable
 # echo 1 > options/sym-offset
 # less trace
...

              sh-132     [007] ...1    22.524917: <stack trace>
 => kretprobe_dispatcher+0x7d/0xc0
 => __kretprobe_trampoline_handler+0xdb/0x1b0
 => trampoline_handler+0x48/0x60
 => kretprobe_trampoline+0x2a/0x50
 => ksys_read+0x70/0xf0
 => __x64_sys_read+0x1a/0x20
 => do_syscall_64+0x38/0x50
 => entry_SYSCALL_64_after_hwframe+0x44/0xae
 => 0

The trampoline_handler+0x48 is actual call site address,
not modified by kretprobe.

Reported-by: Daniel Xu <dxu@dxuuu.xyz>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 Changes in v2:
  - Add is_kretprobe_trampoline() for checking address outside of
    kretprobe_find_ret_addr()
  - Remove unneeded addr from kretprobe_find_ret_addr()
  - Rename fixup_kretprobe_tramp_addr() to fixup_kretprobe_trampoline()
---
 include/linux/kprobes.h |   22 ++++++++++++++
 kernel/kprobes.c        |   73 ++++++++++++++++++++++++++++++-----------------
 kernel/stacktrace.c     |   22 ++++++++++++++
 3 files changed, 91 insertions(+), 26 deletions(-)

diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
index 65dadd4238a2..674b5adad281 100644
--- a/include/linux/kprobes.h
+++ b/include/linux/kprobes.h
@@ -215,6 +215,14 @@ static nokprobe_inline void *kretprobe_trampoline_addr(void)
 	return dereference_function_descriptor(kretprobe_trampoline);
 }
 
+static nokprobe_inline bool is_kretprobe_trampoline(unsigned long addr)
+{
+	return (void *)addr == kretprobe_trampoline_addr();
+}
+
+unsigned long kretprobe_find_ret_addr(struct task_struct *tsk,
+				      struct llist_node **cur);
+
 /* If the trampoline handler called from a kprobe, use this version */
 unsigned long __kretprobe_trampoline_handler(struct pt_regs *regs,
 					     void *frame_pointer);
@@ -514,6 +522,20 @@ static inline bool is_kprobe_optinsn_slot(unsigned long addr)
 }
 #endif
 
+#if !defined(CONFIG_KRETPROBES)
+static nokprobe_inline bool is_kretprobe_trampoline(unsigned long addr)
+{
+	return false;
+}
+
+static nokprobe_inline
+unsigned long kretprobe_find_ret_addr(struct task_struct *tsk,
+				      struct llist_node **cur)
+{
+	return 0;
+}
+#endif
+
 /* Returns true if kprobes handled the fault */
 static nokprobe_inline bool kprobe_page_fault(struct pt_regs *regs,
 					      unsigned int trap)
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 75c0a58c19c2..2550521ff64d 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1858,45 +1858,51 @@ static struct notifier_block kprobe_exceptions_nb = {
 
 #ifdef CONFIG_KRETPROBES
 
-unsigned long __kretprobe_trampoline_handler(struct pt_regs *regs,
-					     void *frame_pointer)
+/* This assumes the tsk is current or the task which is not running. */
+unsigned long kretprobe_find_ret_addr(struct task_struct *tsk,
+				      struct llist_node **cur)
 {
-	kprobe_opcode_t *correct_ret_addr = NULL;
 	struct kretprobe_instance *ri = NULL;
-	struct llist_node *first, *node;
-	struct kretprobe *rp;
+	struct llist_node *node = *cur;
+
+	if (!node)
+		node = tsk->kretprobe_instances.first;
+	else
+		node = node->next;
 
-	/* Find all nodes for this frame. */
-	first = node = current->kretprobe_instances.first;
 	while (node) {
 		ri = container_of(node, struct kretprobe_instance, llist);
-
-		BUG_ON(ri->fp != frame_pointer);
-
 		if (ri->ret_addr != kretprobe_trampoline_addr()) {
-			correct_ret_addr = ri->ret_addr;
-			/*
-			 * This is the real return address. Any other
-			 * instances associated with this task are for
-			 * other calls deeper on the call stack
-			 */
-			goto found;
+			*cur = node;
+			return (unsigned long)ri->ret_addr;
 		}
-
 		node = node->next;
 	}
-	pr_err("Oops! Kretprobe fails to find correct return address.\n");
-	BUG_ON(1);
+	return 0;
+}
+NOKPROBE_SYMBOL(kretprobe_find_ret_addr);
 
-found:
-	/* Unlink all nodes for this frame. */
-	current->kretprobe_instances.first = node->next;
-	node->next = NULL;
+unsigned long __kretprobe_trampoline_handler(struct pt_regs *regs,
+					     void *frame_pointer)
+{
+	kprobe_opcode_t *correct_ret_addr = NULL;
+	struct kretprobe_instance *ri = NULL;
+	struct llist_node *first, *node = NULL;
+	struct kretprobe *rp;
+
+	/* Find correct address and all nodes for this frame. */
+	correct_ret_addr = (void *)kretprobe_find_ret_addr(current, &node);
+	if (!correct_ret_addr) {
+		pr_err("Oops! Kretprobe fails to find correct return address.\n");
+		BUG_ON(1);
+	}
 
-	/* Run them..  */
+	/* Run them. */
+	first = current->kretprobe_instances.first;
 	while (first) {
 		ri = container_of(first, struct kretprobe_instance, llist);
-		first = first->next;
+
+		BUG_ON(ri->fp != frame_pointer);
 
 		rp = get_kretprobe(ri);
 		if (rp && rp->handler) {
@@ -1907,6 +1913,21 @@ unsigned long __kretprobe_trampoline_handler(struct pt_regs *regs,
 			rp->handler(ri, regs);
 			__this_cpu_write(current_kprobe, prev);
 		}
+		if (first == node)
+			break;
+
+		first = first->next;
+	}
+
+	/* Unlink all nodes for this frame. */
+	first = current->kretprobe_instances.first;
+	current->kretprobe_instances.first = node->next;
+	node->next = NULL;
+
+	/* Recycle them.  */
+	while (first) {
+		ri = container_of(first, struct kretprobe_instance, llist);
+		first = first->next;
 
 		recycle_rp_inst(ri);
 	}
diff --git a/kernel/stacktrace.c b/kernel/stacktrace.c
index 9f8117c7cfdd..511287069473 100644
--- a/kernel/stacktrace.c
+++ b/kernel/stacktrace.c
@@ -13,6 +13,7 @@
 #include <linux/export.h>
 #include <linux/kallsyms.h>
 #include <linux/stacktrace.h>
+#include <linux/kprobes.h>
 
 /**
  * stack_trace_print - Print the entries in the stack trace
@@ -69,6 +70,18 @@ int stack_trace_snprint(char *buf, size_t size, const unsigned long *entries,
 }
 EXPORT_SYMBOL_GPL(stack_trace_snprint);
 
+static void fixup_kretprobe_trampoline(unsigned long *store, unsigned int len,
+				       struct task_struct *tsk)
+{
+	struct llist_node *cur = NULL;
+
+	while (len--) {
+		if (is_kretprobe_trampoline(*store))
+			*store = kretprobe_find_ret_addr(tsk, &cur);
+		store++;
+	}
+}
+
 #ifdef CONFIG_ARCH_STACKWALK
 
 struct stacktrace_cookie {
@@ -119,6 +132,7 @@ unsigned int stack_trace_save(unsigned long *store, unsigned int size,
 	};
 
 	arch_stack_walk(consume_entry, &c, current, NULL);
+	fixup_kretprobe_trampoline(store, c.len, current);
 	return c.len;
 }
 EXPORT_SYMBOL_GPL(stack_trace_save);
@@ -147,6 +161,7 @@ unsigned int stack_trace_save_tsk(struct task_struct *tsk, unsigned long *store,
 		return 0;
 
 	arch_stack_walk(consume_entry, &c, tsk, NULL);
+	fixup_kretprobe_trampoline(store, c.len, tsk);
 	put_task_stack(tsk);
 	return c.len;
 }
@@ -171,6 +186,7 @@ unsigned int stack_trace_save_regs(struct pt_regs *regs, unsigned long *store,
 	};
 
 	arch_stack_walk(consume_entry, &c, current, regs);
+	fixup_kretprobe_trampoline(store, c.len, current);
 	return c.len;
 }
 
@@ -205,6 +221,8 @@ int stack_trace_save_tsk_reliable(struct task_struct *tsk, unsigned long *store,
 		return 0;
 
 	ret = arch_stack_walk_reliable(consume_entry, &c, tsk);
+	if (!ret)
+		fixup_kretprobe_trampoline(store, c.len, tsk);
 	put_task_stack(tsk);
 	return ret ? ret : c.len;
 }
@@ -276,6 +294,8 @@ unsigned int stack_trace_save(unsigned long *store, unsigned int size,
 	};
 
 	save_stack_trace(&trace);
+	fixup_kretprobe_trampoline(store, trace.nr_entries, current);
+
 	return trace.nr_entries;
 }
 EXPORT_SYMBOL_GPL(stack_trace_save);
@@ -323,6 +343,8 @@ unsigned int stack_trace_save_regs(struct pt_regs *regs, unsigned long *store,
 	};
 
 	save_stack_trace_regs(regs, &trace);
+	fixup_kretprobe_trampoline(store, trace.nr_entries, current);
+
 	return trace.nr_entries;
 }
 

