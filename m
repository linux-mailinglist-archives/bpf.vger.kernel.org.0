Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36DAA32D40A
	for <lists+bpf@lfdr.de>; Thu,  4 Mar 2021 14:21:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236071AbhCDNUv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 4 Mar 2021 08:20:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:45762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235987AbhCDNUa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 4 Mar 2021 08:20:30 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7036561477;
        Thu,  4 Mar 2021 13:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614863990;
        bh=pldFeLYn3TA1UGG+fl8e7F9EFUFCrhkJ8aM6LzE6Z+o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mJ56Uo9zmg+dvtuyRyiNJ7/+dLbbdB9HZQGec0vPndUsWskW0NfMArIK2VLC43cPv
         BHaUWpVmZwcmIfpkX4AHDmjpHDobam2Sm+JA5wu8RfYvT1P4z+lPnZhAUls9tqbkxl
         KAdPFbjoMmAO+758yzZljlskaKXDuwAE2a91FdXntpSz8XwMsHZXNAl2nuq+t+vBzR
         oQQpNScHCEiVXtNMn41uKoTzR934NH1sDlx7umiE8uV4XhhZ2m48sP5lhkdN4dMo5I
         WK1INiRYnHHUe8StFMSOSFbst+yuI9gvvYCDpLru0pO9HSPnkcF9wdsIi7769gPXWF
         Eehdv50fIHUoQ==
Date:   Thu, 4 Mar 2021 22:19:47 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     "Daniel Xu" <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>, kuba@kernel.org
Subject: Re: Broken kretprobe stack traces
Message-Id: <20210304221947.5a177ce2e1e94314e57c38a4@kernel.org>
In-Reply-To: <20210303092604.59aea82c@gandalf.local.home>
References: <1fed0793-391c-4c68-8d19-6dcd9017271d@www.fastmail.com>
        <20210303134828.39922eb167524bc7206c7880@kernel.org>
        <20210303092604.59aea82c@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 3 Mar 2021 09:26:04 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Wed, 3 Mar 2021 13:48:28 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > 
> > > 
> > > I think (can't prove) this used to work:  
> 
> Would be good to find out if it did.
> 
> > 
> > I'm not sure the bpftrace had correctly handled it or not.
> > 
> > > 
> > >     # bpftrace -e 'kretprobe:__tcp_retransmit_skb { @[kstack()] = count() }'
> > >     Attaching 1 probe...
> > >     ^C
> > > 
> > >     @[
> > >         kretprobe_trampoline+0
> > >     ]: 1  
> > 
> > Would you know how the bpftrace stacktracer rewinds the stack entries?
> > FYI, ftrace does it in trace_seq_print_sym()@kernel/trace/trace_output.c
> > 
> 
> The difference between trace events and normal function tracing stack
> traces is that it keeps its original return address. But kretprobes (and
> function graph tracing, and some bpf trampolines too) modify the return
> pointer, and that could possibly cause havoc with the stack trace.

BTW, I think if the stack tracer passes the nth of kretprobe_trampoline
or a cursor, kretprobe can find the correct return address from given task.

I've made a patch to do that only for the CONFIG_ARCH_STACKWALK=y

Here is an example on x86. 

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
 => 0

------

From 77a785a3a0791171b570830d0b2f099f8a4ba337 Mon Sep 17 00:00:00 2001
From: Masami Hiramatsu <mhiramat@kernel.org>
Date: Thu, 4 Mar 2021 14:19:24 +0900
Subject: [PATCH] kprobes: stacktrace: Recover the address changed by kretprobe

Recover the return address on the stack which changed by the
kretprobe.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 include/linux/kprobes.h |  3 ++
 kernel/kprobes.c        | 81 +++++++++++++++++++++++++++--------------
 kernel/stacktrace.c     | 26 +++++++++++++
 3 files changed, 82 insertions(+), 28 deletions(-)

diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
index 1883a4a9f16a..a022e507d829 100644
--- a/include/linux/kprobes.h
+++ b/include/linux/kprobes.h
@@ -205,6 +205,9 @@ extern void arch_prepare_kretprobe(struct kretprobe_instance *ri,
 				   struct pt_regs *regs);
 extern int arch_trampoline_kprobe(struct kprobe *p);
 
+unsigned long kretprobe_real_stack_tsk(struct task_struct *tsk,
+				       unsigned long addr,
+				       struct llist_node **cur);
 /* If the trampoline handler called from a kprobe, use this version */
 unsigned long __kretprobe_trampoline_handler(struct pt_regs *regs,
 				void *trampoline_address,
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 745f08fdd7a6..b3d9dbd6086f 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1863,46 +1863,56 @@ unsigned long __weak arch_deref_entry_point(void *entry)
 
 #ifdef CONFIG_KRETPROBES
 
-unsigned long __kretprobe_trampoline_handler(struct pt_regs *regs,
-					     void *trampoline_address,
-					     void *frame_pointer)
+/* This assumes the tsk is current or the task which is not running. */
+unsigned long kretprobe_real_stack_tsk(struct task_struct *tsk,
+				       unsigned long addr,
+				       struct llist_node **cur)
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
+	if (addr != (unsigned long)&kretprobe_trampoline)
+		return addr;
 
-		BUG_ON(ri->fp != frame_pointer);
+	if (!node)
+		node = tsk->kretprobe_instances.first;
+	else
+		node = node->next;
 
-		if (ri->ret_addr != trampoline_address) {
-			correct_ret_addr = ri->ret_addr;
-			/*
-			 * This is the real return address. Any other
-			 * instances associated with this task are for
-			 * other calls deeper on the call stack
-			 */
-			goto found;
+	while (node) {
+		ri = container_of(node, struct kretprobe_instance, llist);
+		if (ri->ret_addr != (void *)&kretprobe_trampoline) {
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
 
-found:
-	/* Unlink all nodes for this frame. */
-	current->kretprobe_instances.first = node->next;
-	node->next = NULL;
+unsigned long __kretprobe_trampoline_handler(struct pt_regs *regs,
+					     void *trampoline_address,
+					     void *frame_pointer)
+{
+	kprobe_opcode_t *correct_ret_addr = NULL;
+	struct kretprobe_instance *ri = NULL;
+	struct llist_node *first, *node = NULL;
+	struct kretprobe *rp;
 
-	/* Run them..  */
+	/* Find correct address and all nodes for this frame. */
+	correct_ret_addr = (void*)kretprobe_real_stack_tsk(current,
+				(unsigned long)&kretprobe_trampoline, &node);
+	if (!correct_ret_addr) {
+		pr_err("Oops! Kretprobe fails to find correct return address.\n");
+		BUG_ON(1);
+	}
+
+	/* Run them. */
+	first = current->kretprobe_instances.first;
 	while (first) {
 		ri = container_of(first, struct kretprobe_instance, llist);
-		first = first->next;
+
+		BUG_ON(ri->fp != frame_pointer);
 
 		rp = get_kretprobe(ri);
 		if (rp && rp->handler) {
@@ -1913,6 +1923,21 @@ unsigned long __kretprobe_trampoline_handler(struct pt_regs *regs,
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
index 9f8117c7cfdd..416f357e64b8 100644
--- a/kernel/stacktrace.c
+++ b/kernel/stacktrace.c
@@ -13,6 +13,7 @@
 #include <linux/export.h>
 #include <linux/kallsyms.h>
 #include <linux/stacktrace.h>
+#include <linux/kprobes.h>
 
 /**
  * stack_trace_print - Print the entries in the stack trace
@@ -76,6 +77,10 @@ struct stacktrace_cookie {
 	unsigned int	size;
 	unsigned int	skip;
 	unsigned int	len;
+#ifdef CONFIG_KRETPROBES
+	struct llist_node *cur;
+	struct task_struct *tsk;
+#endif
 };
 
 static bool stack_trace_consume_entry(void *cookie, unsigned long addr)
@@ -89,6 +94,7 @@ static bool stack_trace_consume_entry(void *cookie, unsigned long addr)
 		c->skip--;
 		return true;
 	}
+	addr = kretprobe_real_stack_tsk(c->tsk, addr, &c->cur);
 	c->store[c->len++] = addr;
 	return c->len < c->size;
 }
@@ -116,6 +122,10 @@ unsigned int stack_trace_save(unsigned long *store, unsigned int size,
 		.store	= store,
 		.size	= size,
 		.skip	= skipnr + 1,
+#ifdef CONFIG_KRETPROBES
+		.cur	= NULL,
+		.tsk	= current,
+#endif
 	};
 
 	arch_stack_walk(consume_entry, &c, current, NULL);
@@ -141,6 +151,10 @@ unsigned int stack_trace_save_tsk(struct task_struct *tsk, unsigned long *store,
 		.size	= size,
 		/* skip this function if they are tracing us */
 		.skip	= skipnr + (current == tsk),
+#ifdef CONFIG_KRETPROBES
+		.cur	= NULL,
+		.tsk	= tsk,
+#endif
 	};
 
 	if (!try_get_task_stack(tsk))
@@ -168,6 +182,10 @@ unsigned int stack_trace_save_regs(struct pt_regs *regs, unsigned long *store,
 		.store	= store,
 		.size	= size,
 		.skip	= skipnr,
+#ifdef CONFIG_KRETPROBES
+		.cur	= NULL,
+		.tsk	= current,
+#endif
 	};
 
 	arch_stack_walk(consume_entry, &c, current, regs);
@@ -194,6 +212,10 @@ int stack_trace_save_tsk_reliable(struct task_struct *tsk, unsigned long *store,
 	struct stacktrace_cookie c = {
 		.store	= store,
 		.size	= size,
+#ifdef CONFIG_KRETPROBES
+		.cur	= NULL,
+		.tsk	= tsk,
+#endif
 	};
 	int ret;
 
@@ -224,6 +246,10 @@ unsigned int stack_trace_save_user(unsigned long *store, unsigned int size)
 	struct stacktrace_cookie c = {
 		.store	= store,
 		.size	= size,
+#ifdef CONFIG_KRETPROBES
+		.cur	= NULL,
+		.tsk	= current,
+#endif
 	};
 	mm_segment_t fs;
 
-- 
2.25.1




Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
