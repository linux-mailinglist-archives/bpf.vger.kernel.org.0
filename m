Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6FF548B01B
	for <lists+bpf@lfdr.de>; Tue, 11 Jan 2022 16:00:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242802AbiAKPAr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 11 Jan 2022 10:00:47 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:49682 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243268AbiAKPAr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 11 Jan 2022 10:00:47 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9E1B461687;
        Tue, 11 Jan 2022 15:00:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46165C36AEB;
        Tue, 11 Jan 2022 15:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641913246;
        bh=LjMTXfEOH4fDg+1bjxIjI+knZF+5oxu4LbnwtJq5lUM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IN7cBiyGU0nBZSAuX3mCktLMcqUJxVHGorMcz7XJHYSjzJc1tjaKZQXmpOftcCIZO
         z+qshXlq0jVzYfK63Me3wYCOXLZvWyRWGMUgK4tSShffTL38vVcpi09/aP+mCJ3N6L
         f3SSqyGA09fR67V+HLVq9ENCevze8ys8k8rBBSRr2yJWaQcPDtUam+rQmnViKKGwYN
         k7gmguhSTK+ipxI8Vc2CQv9ArOi/5I7Mlo8Z9xrL4rUZHlE6cjQarblOY8CdB1DW9K
         JE+ZGH70RCx8jVzuwa7q3+ZkEq5UoYHMDYwLVLWNSQVt8j6H2leetBW2vRegcOmYJ8
         F4dq4ueS7mGkQ==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
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
Subject: [RFC PATCH 2/6] rethook: Add a generic return hook
Date:   Wed, 12 Jan 2022 00:00:41 +0900
Message-Id: <164191324119.806991.11671123002722404207.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <164191321766.806991.7930388561276940676.stgit@devnote2>
References: <164191321766.806991.7930388561276940676.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add a return hook framework which hooks the function
return. Most of the idea came from the kretprobe, but
this is independent from kretprobe.
Note that this is expected to be used with other
function entry hooking feature, like ftrace, fprobe,
adn kprobes. Eventually this will replace the
kretprobe (e.g. kprobe + rethook = kretprobe), but
at this moment, this is just a additional hook.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 include/linux/rethook.h |   74 +++++++++++++++
 include/linux/sched.h   |    3 +
 kernel/exit.c           |    2 
 kernel/fork.c           |    3 +
 kernel/trace/Kconfig    |   11 ++
 kernel/trace/Makefile   |    1 
 kernel/trace/rethook.c  |  226 +++++++++++++++++++++++++++++++++++++++++++++++
 7 files changed, 320 insertions(+)
 create mode 100644 include/linux/rethook.h
 create mode 100644 kernel/trace/rethook.c

diff --git a/include/linux/rethook.h b/include/linux/rethook.h
new file mode 100644
index 000000000000..2622bcd5213a
--- /dev/null
+++ b/include/linux/rethook.h
@@ -0,0 +1,74 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Return hooking with list-based shadow stack.
+ */
+#ifndef _LINUX_RETHOOK_H
+#define _LINUX_RETHOOK_H
+
+#include <linux/compiler.h>
+#include <linux/freelist.h>
+#include <linux/llist.h>
+#include <linux/rcupdate.h>
+#include <linux/refcount.h>
+
+struct rethook_node;
+
+typedef void (*rethook_handler_t) (struct rethook_node *, void *, struct pt_regs *);
+
+struct rethook {
+	void			*data;
+	rethook_handler_t	handler;
+	struct freelist_head	pool;
+	refcount_t		ref;
+	struct rcu_head		rcu;
+};
+
+struct rethook_node {
+	union {
+		struct freelist_node freelist;
+		struct rcu_head      rcu;
+	};
+	struct llist_node	llist;
+	struct rethook		*rethook;
+	unsigned long		ret_addr;
+	unsigned long		frame;
+};
+
+int rethook_node_init(struct rethook_node *node);
+
+struct rethook *rethook_alloc(void *data, rethook_handler_t handler);
+void rethook_free(struct rethook *rh);
+void rethook_add_node(struct rethook *rh, struct rethook_node *node);
+
+struct rethook_node *rethook_try_get(struct rethook *rh);
+void rethook_node_recycle(struct rethook_node *node);
+void rethook_hook_current(struct rethook_node *node, struct pt_regs *regs);
+
+unsigned long rethook_find_ret_addr(struct task_struct *tsk, unsigned long frame,
+				    struct llist_node **cur);
+
+/* Arch dependent code must implement this and trampoline code */
+void arch_rethook_prepare(struct rethook_node *node, struct pt_regs *regs);
+void arch_rethook_trampoline(void);
+
+static inline bool is_rethook_trampoline(unsigned long addr)
+{
+	return addr == (unsigned long)arch_rethook_trampoline;
+}
+
+/* If the architecture needs a fixup the return address, implement it. */
+void arch_rethook_fixup_return(struct pt_regs *regs,
+			       unsigned long correct_ret_addr);
+
+/* Generic trampoline handler, arch code must prepare asm stub */
+unsigned long rethook_trampoline_handler(struct pt_regs *regs,
+					 unsigned long frame);
+
+#ifdef CONFIG_RETHOOK
+void rethook_flush_task(struct task_struct *tk);
+#else
+#define rethook_flush_task(tsk)	do { } while (0)
+#endif
+
+#endif
+
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 78c351e35fec..2bfabf5355b7 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1473,6 +1473,9 @@ struct task_struct {
 #ifdef CONFIG_KRETPROBES
 	struct llist_head               kretprobe_instances;
 #endif
+#ifdef CONFIG_RETHOOK
+	struct llist_head               rethooks;
+#endif
 
 #ifdef CONFIG_ARCH_HAS_PARANOID_L1D_FLUSH
 	/*
diff --git a/kernel/exit.c b/kernel/exit.c
index f702a6a63686..a39a321c1f37 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -64,6 +64,7 @@
 #include <linux/compat.h>
 #include <linux/io_uring.h>
 #include <linux/kprobes.h>
+#include <linux/rethook.h>
 
 #include <linux/uaccess.h>
 #include <asm/unistd.h>
@@ -169,6 +170,7 @@ static void delayed_put_task_struct(struct rcu_head *rhp)
 	struct task_struct *tsk = container_of(rhp, struct task_struct, rcu);
 
 	kprobe_flush_task(tsk);
+	rethook_flush_task(tsk);
 	perf_event_delayed_put(tsk);
 	trace_sched_process_free(tsk);
 	put_task_struct(tsk);
diff --git a/kernel/fork.c b/kernel/fork.c
index 3244cc56b697..ffae38be64c4 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2282,6 +2282,9 @@ static __latent_entropy struct task_struct *copy_process(
 #ifdef CONFIG_KRETPROBES
 	p->kretprobe_instances.first = NULL;
 #endif
+#ifdef CONFIG_RETHOOK
+	p->rethooks.first = NULL;
+#endif
 
 	/*
 	 * Ensure that the cgroup subsystem policies allow the new process to be
diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index 45a3618a20a7..9328724258dc 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -10,6 +10,17 @@ config USER_STACKTRACE_SUPPORT
 config NOP_TRACER
 	bool
 
+config HAVE_RETHOOK
+	bool
+
+config RETHOOK
+	bool
+	depends on HAVE_RETHOOK
+	help
+	  Enable generic return hooking feature. This is an internal
+	  API, which will be used by other function-entry hooking
+	  feature like fprobe and kprobes.
+
 config HAVE_FUNCTION_TRACER
 	bool
 	help
diff --git a/kernel/trace/Makefile b/kernel/trace/Makefile
index 47a37a3bb974..c68fdacbf9ef 100644
--- a/kernel/trace/Makefile
+++ b/kernel/trace/Makefile
@@ -98,6 +98,7 @@ obj-$(CONFIG_UPROBE_EVENTS) += trace_uprobe.o
 obj-$(CONFIG_BOOTTIME_TRACING) += trace_boot.o
 obj-$(CONFIG_FTRACE_RECORD_RECURSION) += trace_recursion_record.o
 obj-$(CONFIG_FPROBES) += fprobes.o
+obj-$(CONFIG_RETHOOK) += rethook.o
 
 obj-$(CONFIG_TRACEPOINT_BENCHMARK) += trace_benchmark.o
 
diff --git a/kernel/trace/rethook.c b/kernel/trace/rethook.c
new file mode 100644
index 000000000000..80c0584e8497
--- /dev/null
+++ b/kernel/trace/rethook.c
@@ -0,0 +1,226 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#define pr_fmt(fmt) "rethook: " fmt
+
+#include <linux/bug.h>
+#include <linux/kallsyms.h>
+#include <linux/kprobes.h>
+#include <linux/preempt.h>
+#include <linux/rethook.h>
+#include <linux/slab.h>
+#include <linux/sort.h>
+
+/* Return hook list (shadow stack by list) */
+
+void rethook_flush_task(struct task_struct *tk)
+{
+	struct rethook_node *rhn;
+	struct llist_node *node;
+
+	preempt_disable();
+
+	node = __llist_del_all(&tk->rethooks);
+	while (node) {
+		rhn = container_of(node, struct rethook_node, llist);
+		node = node->next;
+		rethook_node_recycle(rhn);
+	}
+
+	preempt_enable();
+}
+
+static void rethook_free_rcu(struct rcu_head *head)
+{
+	struct rethook *rh = container_of(head, struct rethook, rcu);
+	struct rethook_node *rhn;
+	struct freelist_node *node;
+	int count = 1;
+
+	node = rh->pool.head;
+	while (node) {
+		rhn = container_of(node, struct rethook_node, freelist);
+		node = node->next;
+		kfree(rhn);
+		count++;
+	}
+
+	/* The rh->ref is the number of pooled node + 1 */
+	if (refcount_sub_and_test(count, &rh->ref))
+		kfree(rh);
+}
+
+void rethook_free(struct rethook *rh)
+{
+	rh->handler = NULL;
+	rh->data = NULL;
+
+	call_rcu(&rh->rcu, rethook_free_rcu);
+}
+
+/*
+ * @handler must not NULL. @handler == NULL means this rethook is
+ * going to be freed.
+ */
+struct rethook *rethook_alloc(void *data, rethook_handler_t handler)
+{
+	struct rethook *rh = kzalloc(sizeof(struct rethook), GFP_KERNEL);
+
+	if (!rh || !handler)
+		return NULL;
+
+	rh->data = data;
+	rh->handler = handler;
+	rh->pool.head = NULL;
+	refcount_set(&rh->ref, 1);
+
+	return rh;
+}
+
+void rethook_add_node(struct rethook *rh, struct rethook_node *node)
+{
+	node->rethook = rh;
+	freelist_add(&node->freelist, &rh->pool);
+	refcount_inc(&rh->ref);
+}
+
+static void free_rethook_node_rcu(struct rcu_head *head)
+{
+	struct rethook_node *node = container_of(head, struct rethook_node, rcu);
+
+	if (refcount_dec_and_test(&node->rethook->ref))
+		kfree(node->rethook);
+	kfree(node);
+}
+
+void rethook_node_recycle(struct rethook_node *node)
+{
+	if (likely(READ_ONCE(node->rethook->handler)))
+		freelist_add(&node->freelist, &node->rethook->pool);
+	else
+		call_rcu(&node->rcu, free_rethook_node_rcu);
+}
+
+struct rethook_node *rethook_try_get(struct rethook *rh)
+{
+	struct freelist_node *fn;
+
+	/* Check whether @rh is going to be freed. */
+	if (unlikely(!READ_ONCE(rh->handler)))
+		return NULL;
+
+	fn = freelist_try_get(&rh->pool);
+	if (!fn)
+		return NULL;
+
+	return container_of(fn, struct rethook_node, freelist);
+}
+
+void rethook_hook_current(struct rethook_node *node, struct pt_regs *regs)
+{
+	arch_rethook_prepare(node, regs);
+	__llist_add(&node->llist, &current->rethooks);
+}
+
+/* This assumes the 'tsk' is the current task or the is not running. */
+static unsigned long __rethook_find_ret_addr(struct task_struct *tsk,
+					     struct llist_node **cur)
+{
+	struct rethook_node *rh = NULL;
+	struct llist_node *node = *cur;
+
+	if (!node)
+		node = tsk->rethooks.first;
+	else
+		node = node->next;
+
+	while (node) {
+		rh = container_of(node, struct rethook_node, llist);
+		if (rh->ret_addr != (unsigned long)arch_rethook_trampoline) {
+			*cur = node;
+			return rh->ret_addr;
+		}
+		node = node->next;
+	}
+	return 0;
+}
+NOKPROBE_SYMBOL(__rethook_find_ret_addr);
+
+/**
+ * rethook_find_ret_addr -- Find correct return address modified by rethook
+ * @tsk: Target task
+ * @frame: A frame pointer
+ * @cur: a storage of the loop cursor llist_node pointer for next call
+ *
+ * Find the correct return address modified by a rethook on @tsk in unsigned
+ * long type. If it finds the return address, this returns that address value,
+ * or this returns 0.
+ * The @tsk must be 'current' or a task which is not running. @frame is a hint
+ * to get the currect return address - which is compared with the
+ * rethook::frame field. The @cur is a loop cursor for searching the
+ * kretprobe return addresses on the @tsk. The '*@cur' should be NULL at the
+ * first call, but '@cur' itself must NOT NULL.
+ */
+unsigned long rethook_find_ret_addr(struct task_struct *tsk, unsigned long frame,
+				    struct llist_node **cur)
+{
+	struct rethook_node *rhn = NULL;
+	unsigned long ret;
+
+	if (WARN_ON_ONCE(!cur))
+		return 0;
+
+	do {
+		ret = __rethook_find_ret_addr(tsk, cur);
+		if (!ret)
+			break;
+		rhn = container_of(*cur, struct rethook_node, llist);
+	} while (rhn->frame != frame);
+
+	return ret;
+}
+NOKPROBE_SYMBOL(rethook_find_ret_addr);
+
+void __weak arch_rethook_fixup_return(struct pt_regs *regs,
+				      unsigned long correct_ret_addr)
+{
+	/*
+	 * Do nothing by default. If the architecture which uses a
+	 * frame pointer to record real return address on the stack,
+	 * it should fill this function to fixup the return address
+	 * so that stacktrace works from the rethook handler.
+	 */
+}
+
+unsigned long rethook_trampoline_handler(struct pt_regs *regs,
+					 unsigned long frame)
+{
+	struct rethook_node *rhn;
+	struct llist_node *first, *node = NULL;
+	unsigned long correct_ret_addr = __rethook_find_ret_addr(current, &node);
+
+	if (!correct_ret_addr) {
+		pr_err("rethook: Return address not found! Maybe there is a bug in the kernel\n");
+		BUG_ON(1);
+	}
+
+	instruction_pointer_set(regs, correct_ret_addr);
+	arch_rethook_fixup_return(regs, correct_ret_addr);
+
+	first = current->rethooks.first;
+	current->rethooks.first = node->next;
+	node->next = NULL;
+
+	while (first) {
+		rhn = container_of(first, struct rethook_node, llist);
+		if (WARN_ON_ONCE(rhn->frame != frame))
+			break;
+		if (rhn->rethook->handler)
+			rhn->rethook->handler(rhn, rhn->rethook->data, regs);
+
+		first = first->next;
+		rethook_node_recycle(rhn);
+	}
+
+	return correct_ret_addr;
+}
+

