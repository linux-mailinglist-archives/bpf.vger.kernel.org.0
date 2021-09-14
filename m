Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E449640B19D
	for <lists+bpf@lfdr.de>; Tue, 14 Sep 2021 16:42:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233688AbhINOna (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Sep 2021 10:43:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:36492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234802AbhINOmZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Sep 2021 10:42:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 44317610A2;
        Tue, 14 Sep 2021 14:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631630468;
        bh=m0w+6fZCQCy0gdqhL8LsWosP3J2P38jldAkchB4zGxA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z8GUc9DbBXmu3rz+XaPACjxWQOYx8iGI1XzJ5Rx/rQR/h04j5+mN8gPAp7M34RRQN
         WAHUXEe0L7tMKnyjlvzbb8kn9DUQ1Mcq+6GK061+8sBoVkJ3ypY1bUcCQkp7COy3XU
         w7stJaCeVipdaucHrz+5GTzKmZBoEdGx0g0UbS0xYaXsSCe3btbR1akLgmm8UDqkrp
         Sca36kUV9uqgVwQA5KoEIHFPZS/w0/tOCNX18qB0/90kF+oY5/8NhoZe9gDZ5FRupM
         LH4lTKxU1ruYb66CIFfm4VNdX4jiGeQTX+KtSkRBpyTLKrUceqZfjUekSQCBcoCptp
         qsB87gR6Khw0Q==
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
Subject: [PATCH -tip v11 16/27] kprobes: Add kretprobe_find_ret_addr() for searching return address
Date:   Tue, 14 Sep 2021 23:41:04 +0900
Message-Id: <163163046461.489837.1044778356430293962.stgit@devnote2>
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

Introduce kretprobe_find_ret_addr() and is_kretprobe_trampoline().
These APIs will be used by the ORC stack unwinder and ftrace, so that
they can check whether the given address points kretprobe trampoline
code and query the correct return address in that case.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Tested-by: Andrii Nakryiko <andrii@kernel.org>
---
 Changes in v10:
  - Add a document about kretprobe_find_ret_addr() and check cur == NULL.
 Changes in v9:
  - Update changelog to explain why this is introduced.
  - Move the prototype of kretprobe_find_ret_addr() and is_kretprobe_trampoline()
    in the same place.
  - Make __kretprobe_find_ret_addr() return 'kprobe_opcode_t *'.
  - Update comments in the __kretprobe_trampoline_handler().
 Changes in v6:
  - Replace BUG_ON() with WARN_ON_ONCE() in __kretprobe_trampoline_handler().
 Changes in v3:
  - Remove generic stacktrace fixup. Instead, it should be solved in
    each unwinder. This just provide the generic interface.
 Changes in v2:
  - Add is_kretprobe_trampoline() for checking address outside of
    kretprobe_find_ret_addr()
  - Remove unneeded addr from kretprobe_find_ret_addr()
  - Rename fixup_kretprobe_tramp_addr() to fixup_kretprobe_trampoline()
---
 include/linux/kprobes.h |   22 +++++++++
 kernel/kprobes.c        |  109 ++++++++++++++++++++++++++++++++++++-----------
 2 files changed, 105 insertions(+), 26 deletions(-)

diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
index b6b2370f4a4c..6d47a9da1e0a 100644
--- a/include/linux/kprobes.h
+++ b/include/linux/kprobes.h
@@ -505,6 +505,28 @@ static inline bool is_kprobe_optinsn_slot(unsigned long addr)
 }
 #endif /* !CONFIG_OPTPROBES */
 
+#ifdef CONFIG_KRETPROBES
+static nokprobe_inline bool is_kretprobe_trampoline(unsigned long addr)
+{
+	return (void *)addr == kretprobe_trampoline_addr();
+}
+
+unsigned long kretprobe_find_ret_addr(struct task_struct *tsk, void *fp,
+				      struct llist_node **cur);
+#else
+static nokprobe_inline bool is_kretprobe_trampoline(unsigned long addr)
+{
+	return false;
+}
+
+static nokprobe_inline
+unsigned long kretprobe_find_ret_addr(struct task_struct *tsk, void *fp,
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
index 6ed755111eea..833f07f33115 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1863,45 +1863,87 @@ static struct notifier_block kprobe_exceptions_nb = {
 
 #ifdef CONFIG_KRETPROBES
 
-unsigned long __kretprobe_trampoline_handler(struct pt_regs *regs,
-					     void *frame_pointer)
+/* This assumes the 'tsk' is the current task or the is not running. */
+static kprobe_opcode_t *__kretprobe_find_ret_addr(struct task_struct *tsk,
+						  struct llist_node **cur)
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
+			return ri->ret_addr;
 		}
-
 		node = node->next;
 	}
-	pr_err("kretprobe: Return address not found, not execute handler. Maybe there is a bug in the kernel.\n");
-	BUG_ON(1);
+	return NULL;
+}
+NOKPROBE_SYMBOL(__kretprobe_find_ret_addr);
 
-found:
-	/* Unlink all nodes for this frame. */
-	current->kretprobe_instances.first = node->next;
-	node->next = NULL;
+/**
+ * kretprobe_find_ret_addr -- Find correct return address modified by kretprobe
+ * @tsk: Target task
+ * @fp: A frame pointer
+ * @cur: a storage of the loop cursor llist_node pointer for next call
+ *
+ * Find the correct return address modified by a kretprobe on @tsk in unsigned
+ * long type. If it finds the return address, this returns that address value,
+ * or this returns 0.
+ * The @tsk must be 'current' or a task which is not running. @fp is a hint
+ * to get the currect return address - which is compared with the
+ * kretprobe_instance::fp field. The @cur is a loop cursor for searching the
+ * kretprobe return addresses on the @tsk. The '*@cur' should be NULL at the
+ * first call, but '@cur' itself must NOT NULL.
+ */
+unsigned long kretprobe_find_ret_addr(struct task_struct *tsk, void *fp,
+				      struct llist_node **cur)
+{
+	struct kretprobe_instance *ri = NULL;
+	kprobe_opcode_t *ret;
+
+	if (WARN_ON_ONCE(!cur))
+		return 0;
+
+	do {
+		ret = __kretprobe_find_ret_addr(tsk, cur);
+		if (!ret)
+			break;
+		ri = container_of(*cur, struct kretprobe_instance, llist);
+	} while (ri->fp != fp);
 
-	/* Run them..  */
+	return (unsigned long)ret;
+}
+NOKPROBE_SYMBOL(kretprobe_find_ret_addr);
+
+unsigned long __kretprobe_trampoline_handler(struct pt_regs *regs,
+					     void *frame_pointer)
+{
+	kprobe_opcode_t *correct_ret_addr = NULL;
+	struct kretprobe_instance *ri = NULL;
+	struct llist_node *first, *node = NULL;
+	struct kretprobe *rp;
+
+	/* Find correct address and all nodes for this frame. */
+	correct_ret_addr = __kretprobe_find_ret_addr(current, &node);
+	if (!correct_ret_addr) {
+		pr_err("kretprobe: Return address not found, not execute handler. Maybe there is a bug in the kernel.\n");
+		BUG_ON(1);
+	}
+
+	/* Run the user handler of the nodes. */
+	first = current->kretprobe_instances.first;
 	while (first) {
 		ri = container_of(first, struct kretprobe_instance, llist);
-		first = first->next;
+
+		if (WARN_ON_ONCE(ri->fp != frame_pointer))
+			break;
 
 		rp = get_kretprobe(ri);
 		if (rp && rp->handler) {
@@ -1912,6 +1954,21 @@ unsigned long __kretprobe_trampoline_handler(struct pt_regs *regs,
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
+	/* Recycle free instances. */
+	while (first) {
+		ri = container_of(first, struct kretprobe_instance, llist);
+		first = first->next;
 
 		recycle_rp_inst(ri);
 	}

