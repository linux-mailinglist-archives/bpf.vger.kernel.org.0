Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3ED2D32EF20
	for <lists+bpf@lfdr.de>; Fri,  5 Mar 2021 16:40:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230473AbhCEPkA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 5 Mar 2021 10:40:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:52206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230519AbhCEPjp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 5 Mar 2021 10:39:45 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E95306508D;
        Fri,  5 Mar 2021 15:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614958785;
        bh=tXNR3OI+49D/F1EXrm2FYXsVYaGxlsMw8mNw6dTnUHc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lMD9HnBN5WfJFE2by36bgGKkdZYTQDFOwU8GsLZ/QD5ydjm6UjE+HcjsmHa9ioK10
         HRSTBprSmW5MByfulWXaQ+FZmhNw/5UpEUY19TRMs5N80PgQQPQJV+GbkRW3l+Tn0/
         48J+R9smxhDPJlMxpgYJsmk0iaaRV9s16AQt4ZdFxQ4uhdtjYJdTxAzoVOf0VmYvE+
         FhXoXgphl5YtfW7YRcod8GzWLT4R3lxBs+6tCj2dyw0SW4XG41SvZ9/Rg8hV2CudFG
         r6PYMHRVjnzpr0JXwbS4JXTdpLUhsMFK52i08ZFcbVhmSAqcgacBs9EMQV2cdFkKmb
         D1Ywb6NKfNq8g==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>
Cc:     X86 ML <x86@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>,
        Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, kuba@kernel.org, mingo@redhat.com,
        ast@kernel.org, tglx@linutronix.de, kernel-team@fb.com, yhs@fb.com
Subject: [PATCH -tip 4/5] kprobes: stacktrace: Recover the address changed by kretprobe
Date:   Sat,  6 Mar 2021 00:39:41 +0900
Message-Id: <161495878099.346821.8297865741375138221.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <161495873696.346821.10161501768906432924.stgit@devnote2>
References: <161495873696.346821.10161501768906432924.stgit@devnote2>
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
 include/linux/kprobes.h |   13 ++++++++
 kernel/kprobes.c        |   79 ++++++++++++++++++++++++++++++++---------------
 kernel/stacktrace.c     |   21 ++++++++++++
 3 files changed, 87 insertions(+), 26 deletions(-)

diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
index 9596b6b15bd0..d8dd9f026de9 100644
--- a/include/linux/kprobes.h
+++ b/include/linux/kprobes.h
@@ -215,6 +215,10 @@ static nokprobe_inline void *kretprobe_trampoline_addr(void)
 	return dereference_function_descriptor(kretprobe_trampoline);
 }
 
+unsigned long kretprobe_find_ret_addr(unsigned long addr,
+				      struct task_struct *tsk,
+				      struct llist_node **cur);
+
 /* If the trampoline handler called from a kprobe, use this version */
 unsigned long __kretprobe_trampoline_handler(struct pt_regs *regs,
 					     void *frame_pointer);
@@ -514,6 +518,15 @@ static inline bool is_kprobe_optinsn_slot(unsigned long addr)
 }
 #endif
 
+#if !defined(CONFIG_KPROBES) || !defined(CONFIG_KRETPROBES)
+static inline unsigned long kretprobe_find_ret_addr(unsigned long addr,
+					      struct task_struct *tsk,
+					      struct llist_node **cur)
+{
+	return addr;
+}
+#endif
+
 /* Returns true if kprobes handled the fault */
 static nokprobe_inline bool kprobe_page_fault(struct pt_regs *regs,
 					      unsigned int trap)
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 75c0a58c19c2..76b5e6b03bef 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1858,45 +1858,57 @@ static struct notifier_block kprobe_exceptions_nb = {
 
 #ifdef CONFIG_KRETPROBES
 
-unsigned long __kretprobe_trampoline_handler(struct pt_regs *regs,
-					     void *frame_pointer)
+/* This assumes the tsk is current or the task which is not running. */
+unsigned long kretprobe_find_ret_addr(unsigned long addr,
+				      struct task_struct *tsk,
+				      struct llist_node **cur)
 {
-	kprobe_opcode_t *correct_ret_addr = NULL;
 	struct kretprobe_instance *ri = NULL;
-	struct llist_node *first, *node;
-	struct kretprobe *rp;
+	struct llist_node *node = *cur;
 
-	/* Find all nodes for this frame. */
-	first = node = current->kretprobe_instances.first;
-	while (node) {
-		ri = container_of(node, struct kretprobe_instance, llist);
+	if (addr != (unsigned long)kretprobe_trampoline_addr())
+		return addr;
 
-		BUG_ON(ri->fp != frame_pointer);
+	if (!node)
+		node = tsk->kretprobe_instances.first;
+	else
+		node = node->next;
 
+	while (node) {
+		ri = container_of(node, struct kretprobe_instance, llist);
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
+	correct_ret_addr = (void *)kretprobe_find_ret_addr(
+			(unsigned long)kretprobe_trampoline_addr(),
+			current, &node);
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
@@ -1907,6 +1919,21 @@ unsigned long __kretprobe_trampoline_handler(struct pt_regs *regs,
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
index 9f8117c7cfdd..c224858366e7 100644
--- a/kernel/stacktrace.c
+++ b/kernel/stacktrace.c
@@ -13,6 +13,7 @@
 #include <linux/export.h>
 #include <linux/kallsyms.h>
 #include <linux/stacktrace.h>
+#include <linux/kprobes.h>
 
 /**
  * stack_trace_print - Print the entries in the stack trace
@@ -69,6 +70,17 @@ int stack_trace_snprint(char *buf, size_t size, const unsigned long *entries,
 }
 EXPORT_SYMBOL_GPL(stack_trace_snprint);
 
+static void fixup_kretprobe_tramp_addr(unsigned long *store, unsigned int len,
+				       struct task_struct *tsk)
+{
+	struct llist_node *cur = NULL;
+
+	while (len--) {
+		*store = kretprobe_find_ret_addr(*store, tsk, &cur);
+		store++;
+	}
+}
+
 #ifdef CONFIG_ARCH_STACKWALK
 
 struct stacktrace_cookie {
@@ -119,6 +131,7 @@ unsigned int stack_trace_save(unsigned long *store, unsigned int size,
 	};
 
 	arch_stack_walk(consume_entry, &c, current, NULL);
+	fixup_kretprobe_tramp_addr(store, c.len, current);
 	return c.len;
 }
 EXPORT_SYMBOL_GPL(stack_trace_save);
@@ -147,6 +160,7 @@ unsigned int stack_trace_save_tsk(struct task_struct *tsk, unsigned long *store,
 		return 0;
 
 	arch_stack_walk(consume_entry, &c, tsk, NULL);
+	fixup_kretprobe_tramp_addr(store, c.len, tsk);
 	put_task_stack(tsk);
 	return c.len;
 }
@@ -171,6 +185,7 @@ unsigned int stack_trace_save_regs(struct pt_regs *regs, unsigned long *store,
 	};
 
 	arch_stack_walk(consume_entry, &c, current, regs);
+	fixup_kretprobe_tramp_addr(store, c.len, current);
 	return c.len;
 }
 
@@ -205,6 +220,8 @@ int stack_trace_save_tsk_reliable(struct task_struct *tsk, unsigned long *store,
 		return 0;
 
 	ret = arch_stack_walk_reliable(consume_entry, &c, tsk);
+	if (!ret)
+		fixup_kretprobe_tramp_addr(store, c.len, tsk);
 	put_task_stack(tsk);
 	return ret ? ret : c.len;
 }
@@ -276,6 +293,8 @@ unsigned int stack_trace_save(unsigned long *store, unsigned int size,
 	};
 
 	save_stack_trace(&trace);
+	fixup_kretprobe_tramp_addr(store, trace.nr_entries, current);
+
 	return trace.nr_entries;
 }
 EXPORT_SYMBOL_GPL(stack_trace_save);
@@ -323,6 +342,8 @@ unsigned int stack_trace_save_regs(struct pt_regs *regs, unsigned long *store,
 	};
 
 	save_stack_trace_regs(regs, &trace);
+	fixup_kretprobe_tramp_addr(store, trace.nr_entries, current);
+
 	return trace.nr_entries;
 }
 

