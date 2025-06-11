Return-Path: <bpf+bounces-60286-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE863AD4802
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 03:38:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBBF517CBDA
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 01:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A9F514830F;
	Wed, 11 Jun 2025 01:36:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FED113CA9C;
	Wed, 11 Jun 2025 01:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749605790; cv=none; b=tOqDJoHKieHximuRUE08ErL26PUzxMOaAmwYjp1Nc+l96FchVVxXiWpQjsX2gstDViDZ4gN+NgFpKD/xPPcAqAEui/U3nK+DUyUnXzsKREpWtLifR/tdaE7vk32FjdoeErn6MK3SQY5Oj0Tr8+ihT6VPXnSN0bZ4UQ3HPoye7fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749605790; c=relaxed/simple;
	bh=VzALJzGh0YI9XRUxji8XgeWDgefg4bpPnyPQavLdHkA=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=iroW795WhM/iAnhkoc2LAyTaG6ocRQ5HzKYz4BkXtvAncnrPF8KpBK1mUVzedNBwZqSeWz5OpgVTPQrHbZbR5bn6g9Pcy+pEeijeEm55yyzHtnVPZdwPgDEvYpZkWW2gn0GM+fLYJUpFjfd8xhjI7jyVaeBQIb+Ii8YOKIcqVyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf04.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id 880A481611;
	Wed, 11 Jun 2025 01:36:10 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: nevets@goodmis.org) by omf04.hostedemail.com (Postfix) with ESMTPA id 56B0C20030;
	Wed, 11 Jun 2025 01:36:07 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@goodmis.org>)
	id 1uPAPL-00000000wOw-2GLq;
	Tue, 10 Jun 2025 21:37:39 -0400
Message-ID: <20250611013739.390236324@goodmis.org>
User-Agent: quilt/0.68
Date: Tue, 10 Jun 2025 21:34:27 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org,
 x86@kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>,
 Jiri Olsa <jolsa@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Andrii Nakryiko <andrii@kernel.org>,
 Indu Bhagat <indu.bhagat@oracle.com>,
 "Jose E. Marchesi" <jemarch@gnu.org>,
 Beau Belgrave <beaub@linux.microsoft.com>,
 Jens Remus <jremus@linux.ibm.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v9 06/11] perf: Support deferred user callchains
References: <20250611013421.040264741@goodmis.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Rspamd-Queue-Id: 56B0C20030
X-Stat-Signature: qys9za778hubzcnzfrfxj43sr11agxdq
X-Rspamd-Server: rspamout05
X-Session-Marker: 6E657665747340676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+WphGNp6eEzOvTZi47Iutt+GvjTFAsEks=
X-HE-Tag: 1749605767-769610
X-HE-Meta: U2FsdGVkX1/5vWAZmrGMRNtmgX9axvtZZ/F0JKSyY69xYTxIoJZF5d5OJFG2JC0vHLTy+19TP1D3F1n0ebLQe935RqMHZOO5QhQ6uxyLwhnkXEMiaSY5bCfwp4fTJST6Pwc6y5HWdmqRiohKgJrRY0E9YT0n9EzNCSD/zGmuq4grWd1ZR9qIPMuo+wq2Y67NLlXzwqnjeutzTCVux9XDxFVf8OHAJa4jbX85Kr/AA3j+6RL+Nbq4z5UN+wvC/XCjAv56nNV7nWqq/LCuxlJdZo9M7mJ6jEwJVJeIV3nSWiqCdEw4xxSLI4vyenfdF0+iXgZiU9pY8D4Wbe7snmUCC/MMhYYt62zQrcSBcPvimXvfMKJj4egyYucTzE/sAcZ1SHh4nmxhWRngiHH2fY0RYv3RFfpH+8DrsItgdA0xPBsq6Zpkwff/vB7jaPhmz36Nsl8oTgEC9ndkz7n40XXK8wwkfFCRX1KmoymmTfG8J/8=

From: Josh Poimboeuf <jpoimboe@kernel.org>

Use the new unwind_deferred_trace() interface (if available) to defer
unwinds to task context.  This will allow the use of .sframe (when it
becomes available) and also prevents duplicate userspace unwinds.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Co-developed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 arch/Kconfig                          |   3 +
 include/linux/perf_event.h            |   7 +-
 include/uapi/linux/perf_event.h       |  19 ++-
 kernel/bpf/stackmap.c                 |   4 +-
 kernel/events/callchain.c             |  11 +-
 kernel/events/core.c                  | 168 +++++++++++++++++++++++++-
 tools/include/uapi/linux/perf_event.h |  19 ++-
 7 files changed, 223 insertions(+), 8 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 2c41d3072910..f4c75d09674a 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -446,6 +446,9 @@ config HAVE_UNWIND_USER_COMPAT_FP
 	bool
 	depends on HAVE_UNWIND_USER_FP
 
+config HAVE_PERF_CALLCHAIN_DEFERRED
+	bool
+
 config HAVE_PERF_REGS
 	bool
 	help
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 75a0413172b1..416d55d2e81b 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -53,6 +53,7 @@
 #include <linux/security.h>
 #include <linux/static_call.h>
 #include <linux/lockdep.h>
+#include <linux/unwind_deferred.h>
 
 #include <asm/local.h>
 
@@ -842,6 +843,10 @@ struct perf_event {
 	struct callback_head		pending_task;
 	unsigned int			pending_work;
 
+	unsigned int			pending_unwind_callback;
+	struct callback_head		pending_unwind_work;
+	struct rcuwait			pending_unwind_wait;
+
 	atomic_t			event_limit;
 
 	/* address range filters */
@@ -1682,7 +1687,7 @@ extern void perf_callchain_user(struct perf_callchain_entry_ctx *entry, struct p
 extern void perf_callchain_kernel(struct perf_callchain_entry_ctx *entry, struct pt_regs *regs);
 extern struct perf_callchain_entry *
 get_perf_callchain(struct pt_regs *regs, bool kernel, bool user,
-		   u32 max_stack, bool crosstask, bool add_mark);
+		   u32 max_stack, bool crosstask, bool add_mark, bool defer_user);
 extern int get_callchain_buffers(int max_stack);
 extern void put_callchain_buffers(void);
 extern struct perf_callchain_entry *get_callchain_entry(int *rctx);
diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index 78a362b80027..184740d1e79d 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -463,7 +463,8 @@ struct perf_event_attr {
 				inherit_thread :  1, /* children only inherit if cloned with CLONE_THREAD */
 				remove_on_exec :  1, /* event is removed from task on exec */
 				sigtrap        :  1, /* send synchronous SIGTRAP on event */
-				__reserved_1   : 26;
+				defer_callchain:  1, /* generate PERF_RECORD_CALLCHAIN_DEFERRED records */
+				__reserved_1   : 25;
 
 	union {
 		__u32		wakeup_events;	  /* wake up every n events */
@@ -1239,6 +1240,21 @@ enum perf_event_type {
 	 */
 	PERF_RECORD_AUX_OUTPUT_HW_ID		= 21,
 
+	/*
+	 * This user callchain capture was deferred until shortly before
+	 * returning to user space.  Previous samples would have kernel
+	 * callchains only and they need to be stitched with this to make full
+	 * callchains.
+	 *
+	 * struct {
+	 *	struct perf_event_header	header;
+	 *	u64				nr;
+	 *	u64				ips[nr];
+	 *	struct sample_id		sample_id;
+	 * };
+	 */
+	PERF_RECORD_CALLCHAIN_DEFERRED		= 22,
+
 	PERF_RECORD_MAX,			/* non-ABI */
 };
 
@@ -1269,6 +1285,7 @@ enum perf_callchain_context {
 	PERF_CONTEXT_HV				= (__u64)-32,
 	PERF_CONTEXT_KERNEL			= (__u64)-128,
 	PERF_CONTEXT_USER			= (__u64)-512,
+	PERF_CONTEXT_USER_DEFERRED		= (__u64)-640,
 
 	PERF_CONTEXT_GUEST			= (__u64)-2048,
 	PERF_CONTEXT_GUEST_KERNEL		= (__u64)-2176,
diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index ec3a57a5fba1..339f7cbbcf36 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -315,7 +315,7 @@ BPF_CALL_3(bpf_get_stackid, struct pt_regs *, regs, struct bpf_map *, map,
 		max_depth = sysctl_perf_event_max_stack;
 
 	trace = get_perf_callchain(regs, kernel, user, max_depth,
-				   false, false);
+				   false, false, false);
 
 	if (unlikely(!trace))
 		/* couldn't fetch the stack trace */
@@ -452,7 +452,7 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
 		trace = get_callchain_entry_for_task(task, max_depth);
 	else
 		trace = get_perf_callchain(regs, kernel, user, max_depth,
-					   crosstask, false);
+					   crosstask, false, false);
 
 	if (unlikely(!trace) || trace->nr < skip) {
 		if (may_fault)
diff --git a/kernel/events/callchain.c b/kernel/events/callchain.c
index 2798c0c9f782..50c637e960b9 100644
--- a/kernel/events/callchain.c
+++ b/kernel/events/callchain.c
@@ -218,7 +218,7 @@ static void fixup_uretprobe_trampoline_entries(struct perf_callchain_entry *entr
 
 struct perf_callchain_entry *
 get_perf_callchain(struct pt_regs *regs, bool kernel, bool user,
-		   u32 max_stack, bool crosstask, bool add_mark)
+		   u32 max_stack, bool crosstask, bool add_mark, bool defer_user)
 {
 	struct perf_callchain_entry *entry;
 	struct perf_callchain_entry_ctx ctx;
@@ -251,6 +251,15 @@ get_perf_callchain(struct pt_regs *regs, bool kernel, bool user,
 			regs = task_pt_regs(current);
 		}
 
+		if (defer_user) {
+			/*
+			 * Foretell the coming of PERF_RECORD_CALLCHAIN_DEFERRED
+			 * which can be stitched to this one.
+			 */
+			perf_callchain_store_context(&ctx, PERF_CONTEXT_USER_DEFERRED);
+			goto exit_put;
+		}
+
 		if (add_mark)
 			perf_callchain_store_context(&ctx, PERF_CONTEXT_USER);
 
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 55d5d4ded7ab..5a31f5c30299 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -5564,6 +5564,89 @@ static bool exclusive_event_installable(struct perf_event *event,
 	return true;
 }
 
+static void perf_pending_unwind_sync(struct perf_event *event)
+{
+	might_sleep();
+
+	if (!event->pending_unwind_callback)
+		return;
+
+	/*
+	 * If the task is queued to the current task's queue, we
+	 * obviously can't wait for it to complete. Simply cancel it.
+	 */
+	if (task_work_cancel(current, &event->pending_unwind_work)) {
+		event->pending_unwind_callback = 0;
+		local_dec(&event->ctx->nr_no_switch_fast);
+		return;
+	}
+
+	/*
+	 * All accesses related to the event are within the same RCU section in
+	 * perf_event_callchain_deferred(). The RCU grace period before the
+	 * event is freed will make sure all those accesses are complete by then.
+	 */
+	rcuwait_wait_event(&event->pending_unwind_wait, !event->pending_unwind_callback, TASK_UNINTERRUPTIBLE);
+}
+
+struct perf_callchain_deferred_event {
+	struct perf_event_header	header;
+	u64				nr;
+	u64				ips[];
+};
+
+static void perf_event_callchain_deferred(struct callback_head *work)
+{
+	struct perf_event *event = container_of(work, struct perf_event, pending_unwind_work);
+	struct perf_callchain_deferred_event deferred_event;
+	u64 callchain_context = PERF_CONTEXT_USER;
+	struct unwind_stacktrace trace;
+	struct perf_output_handle handle;
+	struct perf_sample_data data;
+	u64 nr;
+
+	if (!event->pending_unwind_callback)
+		return;
+
+	if (unwind_deferred_trace(&trace) < 0)
+		goto out;
+
+	/*
+	 * All accesses to the event must belong to the same implicit RCU
+	 * read-side critical section as the ->pending_unwind_callback reset.
+	 * See comment in perf_pending_unwind_sync().
+	 */
+	guard(rcu)();
+
+	if (current->flags & PF_KTHREAD)
+		goto out;
+
+	nr = trace.nr + 1 ; /* '+1' == callchain_context */
+
+	deferred_event.header.type = PERF_RECORD_CALLCHAIN_DEFERRED;
+	deferred_event.header.misc = PERF_RECORD_MISC_USER;
+	deferred_event.header.size = sizeof(deferred_event) + (nr * sizeof(u64));
+
+	deferred_event.nr = nr;
+
+	perf_event_header__init_id(&deferred_event.header, &data, event);
+
+	if (perf_output_begin(&handle, &data, event, deferred_event.header.size))
+		goto out;
+
+	perf_output_put(&handle, deferred_event);
+	perf_output_put(&handle, callchain_context);
+	perf_output_copy(&handle, trace.entries, trace.nr * sizeof(u64));
+	perf_event__output_id_sample(event, &handle, &data);
+
+	perf_output_end(&handle);
+
+out:
+	event->pending_unwind_callback = 0;
+	local_dec(&event->ctx->nr_no_switch_fast);
+	rcuwait_wake_up(&event->pending_unwind_wait);
+}
+
 static void perf_free_addr_filters(struct perf_event *event);
 
 /* vs perf_event_alloc() error */
@@ -5631,6 +5714,7 @@ static void _free_event(struct perf_event *event)
 {
 	irq_work_sync(&event->pending_irq);
 	irq_work_sync(&event->pending_disable_irq);
+	perf_pending_unwind_sync(event);
 
 	unaccount_event(event);
 
@@ -8140,6 +8224,65 @@ static u64 perf_get_page_size(unsigned long addr)
 
 static struct perf_callchain_entry __empty_callchain = { .nr = 0, };
 
+/* Returns the same as deferred_request() below */
+static int deferred_request_nmi(struct perf_event *event)
+{
+	struct callback_head *work = &event->pending_unwind_work;
+	int ret;
+
+	if (event->pending_unwind_callback)
+		return 1;
+
+	ret = task_work_add(current, work, TWA_NMI_CURRENT);
+	if (ret)
+		return ret;
+
+	event->pending_unwind_callback = 1;
+	return 0;
+}
+
+/*
+ * Returns:
+*     > 0 : if already queued.
+ *      0 : if it performed the queuing
+ *    < 0 : if it did not get queued.
+ */
+static int deferred_request(struct perf_event *event)
+{
+	struct callback_head *work = &event->pending_unwind_work;
+	int pending;
+	int ret;
+
+	/* Only defer for task events */
+	if (!event->ctx->task)
+		return -EINVAL;
+
+	if ((current->flags & PF_KTHREAD) || !user_mode(task_pt_regs(current)))
+		return -EINVAL;
+
+	if (in_nmi())
+		return deferred_request_nmi(event);
+
+	guard(irqsave)();
+
+	/* callback already pending? */
+	pending = READ_ONCE(event->pending_unwind_callback);
+	if (pending)
+		return 1;
+
+	/* Claim the work unless an NMI just now swooped in to do so. */
+	if (!try_cmpxchg(&event->pending_unwind_callback, &pending, 1))
+		return 1;
+
+	/* The work has been claimed, now schedule it. */
+	ret = task_work_add(current, work, TWA_RESUME);
+	if (WARN_ON_ONCE(ret)) {
+		WRITE_ONCE(event->pending_unwind_callback, 0);
+		return ret;
+	}
+	return 0;
+}
+
 struct perf_callchain_entry *
 perf_callchain(struct perf_event *event, struct pt_regs *regs)
 {
@@ -8150,12 +8293,27 @@ perf_callchain(struct perf_event *event, struct pt_regs *regs)
 	bool crosstask = event->ctx->task && event->ctx->task != current;
 	const u32 max_stack = event->attr.sample_max_stack;
 	struct perf_callchain_entry *callchain;
+	bool defer_user = IS_ENABLED(CONFIG_UNWIND_USER) && user &&
+			  event->attr.defer_callchain;
 
 	if (!kernel && !user)
 		return &__empty_callchain;
 
-	callchain = get_perf_callchain(regs, kernel, user,
-				       max_stack, crosstask, true);
+	/* Disallow cross-task callchains. */
+	if (event->ctx->task && event->ctx->task != current)
+		return &__empty_callchain;
+
+	if (defer_user) {
+		int ret = deferred_request(event);
+		if (!ret)
+			local_inc(&event->ctx->nr_no_switch_fast);
+		else if (ret < 0)
+			defer_user = false;
+	}
+
+	callchain = get_perf_callchain(regs, kernel, user, max_stack,
+				       crosstask, true, defer_user);
+
 	return callchain ?: &__empty_callchain;
 }
 
@@ -12818,6 +12976,8 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
 	event->pending_disable_irq = IRQ_WORK_INIT_HARD(perf_pending_disable);
 	init_task_work(&event->pending_task, perf_pending_task);
 
+	rcuwait_init(&event->pending_unwind_wait);
+
 	mutex_init(&event->mmap_mutex);
 	raw_spin_lock_init(&event->addr_filters.lock);
 
@@ -12986,6 +13146,10 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
 	if (err)
 		return ERR_PTR(err);
 
+	if (event->attr.defer_callchain)
+		init_task_work(&event->pending_unwind_work,
+			       perf_event_callchain_deferred);
+
 	/* symmetric to unaccount_event() in _free_event() */
 	account_event(event);
 
diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
index 78a362b80027..184740d1e79d 100644
--- a/tools/include/uapi/linux/perf_event.h
+++ b/tools/include/uapi/linux/perf_event.h
@@ -463,7 +463,8 @@ struct perf_event_attr {
 				inherit_thread :  1, /* children only inherit if cloned with CLONE_THREAD */
 				remove_on_exec :  1, /* event is removed from task on exec */
 				sigtrap        :  1, /* send synchronous SIGTRAP on event */
-				__reserved_1   : 26;
+				defer_callchain:  1, /* generate PERF_RECORD_CALLCHAIN_DEFERRED records */
+				__reserved_1   : 25;
 
 	union {
 		__u32		wakeup_events;	  /* wake up every n events */
@@ -1239,6 +1240,21 @@ enum perf_event_type {
 	 */
 	PERF_RECORD_AUX_OUTPUT_HW_ID		= 21,
 
+	/*
+	 * This user callchain capture was deferred until shortly before
+	 * returning to user space.  Previous samples would have kernel
+	 * callchains only and they need to be stitched with this to make full
+	 * callchains.
+	 *
+	 * struct {
+	 *	struct perf_event_header	header;
+	 *	u64				nr;
+	 *	u64				ips[nr];
+	 *	struct sample_id		sample_id;
+	 * };
+	 */
+	PERF_RECORD_CALLCHAIN_DEFERRED		= 22,
+
 	PERF_RECORD_MAX,			/* non-ABI */
 };
 
@@ -1269,6 +1285,7 @@ enum perf_callchain_context {
 	PERF_CONTEXT_HV				= (__u64)-32,
 	PERF_CONTEXT_KERNEL			= (__u64)-128,
 	PERF_CONTEXT_USER			= (__u64)-512,
+	PERF_CONTEXT_USER_DEFERRED		= (__u64)-640,
 
 	PERF_CONTEXT_GUEST			= (__u64)-2048,
 	PERF_CONTEXT_GUEST_KERNEL		= (__u64)-2176,
-- 
2.47.2



