Return-Path: <bpf+bounces-62614-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FA91AFC05B
	for <lists+bpf@lfdr.de>; Tue,  8 Jul 2025 04:02:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 894C23A88DE
	for <lists+bpf@lfdr.de>; Tue,  8 Jul 2025 02:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FF04228C9D;
	Tue,  8 Jul 2025 02:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HBpRaz8B"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79800221F0E;
	Tue,  8 Jul 2025 02:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751940051; cv=none; b=KpVFkPh7nygjvvUM+AtAPoBarlLeQckOgbcisa5I+uFQBV0mSMhPTPazMl8RerdL91SpLOL5QUqlExxtjohIQMgPL6o+N8zYzUv/GtW+zzevHMElH/Z7r18Wg8A7pEXJ5vvqcpJj1HQGF4HuPT/G860jbSK22YMGL/ff5twnjYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751940051; c=relaxed/simple;
	bh=L6VWwbnVUsGDvs8QB7GUB1MX7TM30QGw1T2rqOekzfo=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=ScVkw4/U1xjr0SgLe7jCdobUSWA3iEWKIttGYjNKmOPWmxwTjiHcOokhR01slZQCpKM7lLEUiBYMP+9JWxsbsidTviqH/bGxA/2u0Fx3syKeYZAEUBEB8QrDYczMAAcKLMsSzKa6Xzdd+UGnjOhOfXLQaI89EgzkT7+J7IUE5Rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HBpRaz8B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE2C6C4CEF4;
	Tue,  8 Jul 2025 02:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751940050;
	bh=L6VWwbnVUsGDvs8QB7GUB1MX7TM30QGw1T2rqOekzfo=;
	h=Date:From:To:Cc:Subject:References:From;
	b=HBpRaz8B36uabAOiL6ApbK4+PECsQOoGRG9ongPM/WMjVKkJlw22MDDwPcVAIhcUu
	 nA1l67j25kfcD8kEfxVCFuAj7p00IKShiz5pXPdOvx+lnGKVpfc2Ic81ARtGHTLVHU
	 nE7V0XAuS5WIE0yViYk9r3UAnpmHWYMLJJSW3hFHKqhKZ0znE7FLQpaEegX5muRvfS
	 EcFwWo0B0bTvKN1JM+LySoIZwPNeF72FCVZpsjE5IAab4v5FD5k8UrUg6uqzn2Hb0G
	 gD7kNvWi60oqccTX9Iq2VLdymy7TUfNSbCoHJTK7gjTp9JiavY3pQk/zdCGn6KUzeP
	 6XYDCdfBCLyEw==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1uYxdb-00000000D6b-0JwA;
	Mon, 07 Jul 2025 22:00:51 -0400
Message-ID: <20250708020050.928524258@kernel.org>
User-Agent: quilt/0.68
Date: Mon, 07 Jul 2025 22:00:09 -0400
From: Steven Rostedt <rostedt@kernel.org>
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
 Andrew Morton <akpm@linux-foundation.org>,
 Jens Axboe <axboe@kernel.dk>,
 Florian Weimer <fweimer@redhat.com>,
 Sam James <sam@gentoo.org>
Subject: [PATCH v13 06/11] perf: Support deferred user callchains
References: <20250708020003.565862284@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Josh Poimboeuf <jpoimboe@kernel.org>

Use the new unwind_deferred_trace() interface (if available) to defer
unwinds to task context.  This will allow the use of .sframe (when it
becomes available) and also prevents duplicate userspace unwinds.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Co-developed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
Changes since v11: https://lore.kernel.org/20250625231622.678033124@goodmis.org

- Removed deferred_request_nmi() and have NMIs just use the normal
  deferred_request() function. As Peter Zijlstra has stated, in_nmi() can
  nest because some exceptions set in_nmi() and another NMI could come in.

- Added test against PF_USER_WORKER as well as PF_KTHREAD

 include/linux/perf_event.h            |   7 +-
 include/uapi/linux/perf_event.h       |  19 +++-
 kernel/bpf/stackmap.c                 |   4 +-
 kernel/events/callchain.c             |  11 +-
 kernel/events/core.c                  | 149 +++++++++++++++++++++++++-
 tools/include/uapi/linux/perf_event.h |  19 +++-
 6 files changed, 201 insertions(+), 8 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 54e0d31afcad..c7d474391e51 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -53,6 +53,7 @@
 #include <linux/security.h>
 #include <linux/static_call.h>
 #include <linux/lockdep.h>
+#include <linux/unwind_deferred.h>
 
 #include <asm/local.h>
 
@@ -880,6 +881,10 @@ struct perf_event {
 	struct callback_head		pending_task;
 	unsigned int			pending_work;
 
+	unsigned int			pending_unwind_callback;
+	struct callback_head		pending_unwind_work;
+	struct rcuwait			pending_unwind_wait;
+
 	atomic_t			event_limit;
 
 	/* address range filters */
@@ -1720,7 +1725,7 @@ extern void perf_callchain_user(struct perf_callchain_entry_ctx *entry, struct p
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
index 808c0d7a31fa..d0e0da66a164 100644
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
index a594bd01d5bc..0e2af0a5eb12 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -5582,6 +5582,89 @@ static bool exclusive_event_installable(struct perf_event *event,
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
+	if (current->flags & (PF_KTHREAD | PF_USER_WORKER))
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
@@ -5649,6 +5732,7 @@ static void _free_event(struct perf_event *event)
 {
 	irq_work_sync(&event->pending_irq);
 	irq_work_sync(&event->pending_disable_irq);
+	perf_pending_unwind_sync(event);
 
 	unaccount_event(event);
 
@@ -8162,6 +8246,46 @@ static u64 perf_get_page_size(unsigned long addr)
 
 static struct perf_callchain_entry __empty_callchain = { .nr = 0, };
 
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
+	if ((current->flags & (PF_KTHREAD | PF_USER_WORKER)) ||
+	    !user_mode(task_pt_regs(current)))
+		return -EINVAL;
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
@@ -8172,6 +8296,8 @@ perf_callchain(struct perf_event *event, struct pt_regs *regs)
 	bool crosstask = event->ctx->task && event->ctx->task != current;
 	const u32 max_stack = event->attr.sample_max_stack;
 	struct perf_callchain_entry *callchain;
+	bool defer_user = IS_ENABLED(CONFIG_UNWIND_USER) && user &&
+			  event->attr.defer_callchain;
 
 	if (!current->mm)
 		user = false;
@@ -8179,8 +8305,21 @@ perf_callchain(struct perf_event *event, struct pt_regs *regs)
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
 
@@ -12850,6 +12989,8 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
 	event->pending_disable_irq = IRQ_WORK_INIT_HARD(perf_pending_disable);
 	init_task_work(&event->pending_task, perf_pending_task);
 
+	rcuwait_init(&event->pending_unwind_wait);
+
 	mutex_init(&event->mmap_mutex);
 	raw_spin_lock_init(&event->addr_filters.lock);
 
@@ -13018,6 +13159,10 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
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



