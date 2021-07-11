Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6006C3C3CEB
	for <lists+bpf@lfdr.de>; Sun, 11 Jul 2021 15:37:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232981AbhGKNi1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 11 Jul 2021 09:38:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:48768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232793AbhGKNi1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 11 Jul 2021 09:38:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BBD066121E;
        Sun, 11 Jul 2021 13:35:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626010540;
        bh=HVWJVV3AxF5eKYTvIU5DcgSdiLjIbrMxW2PriCsOf18=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=elHx+x9JgSl6MwSCgfVTbgcd1JuulcgYT5W9o3XsB2oBo3jsiHXWztNpSJLA7HNrh
         cNsKL9CzjB+/jOsmw5MQUaRF1/4xNDQftFKLErEZbuRHkurzrNsMgIGPULNmggFrUX
         8pOaQJKPsnGjPWcBMLsmx+MocWxnoFbHCHIyww5rKex9uKMKNHruvAidXemIFXpgxR
         anNd2yG4FWybXnxYAw1xod6FL4KQw5k+XupP04opvw2Ol35RRt2qYMFHA5oePC8rrD
         LyjkAGXaWYQLSDye8/OQFAx/HPRH4JXs8+ZrM7OdjV2AhMYiIWAta/CqJ8QhB3LVqb
         Mmf0VlYwZKZZw==
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
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Subject: [PATCH -tip v9 05/14] kprobes: Add kretprobe_find_ret_addr() for searching return address
Date:   Sun, 11 Jul 2021 22:35:31 +0900
Message-Id: <162601053091.1318837.12853354526881294955.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <162601048053.1318837.1550594515476777588.stgit@devnote2>
References: <162601048053.1318837.1550594515476777588.stgit@devnote2>
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
 include/linux/kprobes.h |   22 +++++++++++
 kernel/kprobes.c        |   91 ++++++++++++++++++++++++++++++++++-------------
 2 files changed, 87 insertions(+), 26 deletions(-)

diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
index 8dcfb9cd1bf0..4715a67d39fc 100644
--- a/include/linux/kprobes.h
+++ b/include/linux/kprobes.h
@@ -502,6 +502,28 @@ static inline bool is_kprobe_optinsn_slot(unsigned long addr)
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
index f9a075374522..8f7d659eb277 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1868,45 +1868,69 @@ static struct notifier_block kprobe_exceptions_nb = {
 
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
+unsigned long kretprobe_find_ret_addr(struct task_struct *tsk, void *fp,
+				      struct llist_node **cur)
+{
+	struct kretprobe_instance *ri = NULL;
+	kprobe_opcode_t *ret;
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
@@ -1917,6 +1941,21 @@ unsigned long __kretprobe_trampoline_handler(struct pt_regs *regs,
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

