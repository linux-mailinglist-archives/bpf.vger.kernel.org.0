Return-Path: <bpf+bounces-70540-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3119EBC2C46
	for <lists+bpf@lfdr.de>; Tue, 07 Oct 2025 23:39:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2093C3E1F13
	for <lists+bpf@lfdr.de>; Tue,  7 Oct 2025 21:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BDB525785B;
	Tue,  7 Oct 2025 21:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BEQKNpmg"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB7F253F3D;
	Tue,  7 Oct 2025 21:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759873171; cv=none; b=PT75WCyIExniJ7eqtot9GhaaC0T7UWeOfxgTQMFJodsbNMQAy1OV4QdfT+7x6e7DaSsw3ydPAa/T/6vzcjz4RtNVrgypcUFkJeWgRcHa1LruhJI2ZgJD83sWt2EXQXUZJaNDUNxLmuflRXnSHpHu4TZo55QvtAoZVI9g3DiRdN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759873171; c=relaxed/simple;
	bh=RbmBYiPpCFuN1S5X77JBvvRnJR/euKv0kkHDqGcrugQ=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=DpW3mYRa+9kwOx8gCbAFpZF2QpAz7sG4tnLHc0FP1dNXiiX/Xm1CZb2YlM4fdy6VebSihnpnyN3uAUBUZHdw+7LTaMWPYAVsL0pmCiPFvUi3+xlDuXnA/IC64Wqhzwxs1Ur2vHbDK7ZDHPLvCZefLJyaRkiuQmdB33AwNAgDS7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BEQKNpmg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55638C113D0;
	Tue,  7 Oct 2025 21:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759873171;
	bh=RbmBYiPpCFuN1S5X77JBvvRnJR/euKv0kkHDqGcrugQ=;
	h=Date:From:To:Cc:Subject:References:From;
	b=BEQKNpmgpq2zgKNhmOwrMV1CwVc/Kp3EaHwUgA4TlnRItntfoq0i8fVf/p377t3Uj
	 JUHVWMfgO79Z2ZEOj482e8xW3QuW25T1R9SStthu9QqL70tmCbXB6F8B6T+hh7Qjey
	 DcCuiJnNO2MEYXw4E+BE9qJl2rJD33MA1xiGdR6IzKu4Yw4x5XoEJhD9tV9ollilw9
	 GowdwOtokB+t69f/DAUHE00sx9WjLG2c18gRp453vLFEy67ToolPCAthub/a6Ufgdc
	 Mdiw1hr2+HBEfsOUhfvQerl6/2tFwm6zJ+SponJAWnpyp9M5HNSfj1uL1fHXJ8wyP3
	 oAw0a7xD2j5aA==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1v6FQx-00000007XgD-3Zdc;
	Tue, 07 Oct 2025 17:41:23 -0400
Message-ID: <20251007214123.705413492@kernel.org>
User-Agent: quilt/0.68
Date: Tue, 07 Oct 2025 17:40:10 -0400
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
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Andrii Nakryiko <andrii@kernel.org>,
 Indu Bhagat <indu.bhagat@oracle.com>,
 "Jose E. Marchesi" <jemarch@gnu.org>,
 Beau Belgrave <beaub@linux.microsoft.com>,
 Jens Remus <jremus@linux.ibm.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Florian Weimer <fweimer@redhat.com>,
 Sam James <sam@gentoo.org>,
 Kees Cook <kees@kernel.org>,
 "Carlos O'Donell" <codonell@redhat.com>
Subject: [PATCH v16 2/4] perf: Support deferred user callchains
References: <20251007214008.080852573@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Josh Poimboeuf <jpoimboe@kernel.org>

If the user fault unwind is available (the one that will be used for
sframes), have perf be able to utilize it. Currently all user stack
traces are done at the request site. This mostly happens in interrupt or
NMI context where user space is only accessible if it is currently present
in memory. It is possible that the user stack was swapped out and is not
present, but mostly the use of sframes will require faulting in user pages
which will not be possible from interrupt context. Instead, add a frame
work that will delay the reading of the user space stack until the task
goes back to user space where faulting in pages is possible. This is also
advantageous as the user space stack doesn't change while in the kernel,
and this will also remove duplicate entries of user space stacks for a
long running system call being profiled.

A new perf context is created called PERF_CONTEXT_USER_DEFERRED. It is
added to the kernel callchain, usually when an interrupt or NMI is
triggered (but can be added to any callchain). When a deferred unwind is
required, it uses the new deferred unwind infrastructure.

When tracing a single task and a user stack trace is required, perf will
call unwind_deferred_request(). This will trigger a task_work that on task
kernel space exit will call the perf function perf_event_deferred_task()
with the user stacktrace and a cookie (an identifier for that stack
trace).

This user stack trace will go into a new perf type called
PERF_RECORD_CALLCHAIN_DEFERRED.  The perf user space will need to attach
this stack trace to each of the previous kernel callchains for that task
with the PERF_CONTEXT_USER_DEFERRED context in them.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Co-developed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
Changes since v15: https://lore.kernel.org/20250825180801.727927527@kernel.org

- Peter Zijlstra pointed out that the code mostly duplicated the code of
  the unwind infrastructure, and had the same bugs as it had.
  The unwind infrastructure was updated to allow a tracer to use it for a
  single task. The perf code now uses that which greatly simplified
  this version over the previous one.

 include/linux/perf_event.h            |   5 +-
 include/uapi/linux/perf_event.h       |  20 ++++-
 kernel/bpf/stackmap.c                 |   4 +-
 kernel/events/callchain.c             |  11 ++-
 kernel/events/core.c                  | 110 +++++++++++++++++++++++++-
 tools/include/uapi/linux/perf_event.h |  20 ++++-
 6 files changed, 162 insertions(+), 8 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index fd1d91017b99..152e3dacff98 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -53,6 +53,7 @@
 #include <linux/security.h>
 #include <linux/static_call.h>
 #include <linux/lockdep.h>
+#include <linux/unwind_deferred.h>
 
 #include <asm/local.h>
 
@@ -880,6 +881,8 @@ struct perf_event {
 	struct callback_head		pending_task;
 	unsigned int			pending_work;
 
+	struct unwind_work		unwind_work;
+
 	atomic_t			event_limit;
 
 	/* address range filters */
@@ -1720,7 +1723,7 @@ extern void perf_callchain_user(struct perf_callchain_entry_ctx *entry, struct p
 extern void perf_callchain_kernel(struct perf_callchain_entry_ctx *entry, struct pt_regs *regs);
 extern struct perf_callchain_entry *
 get_perf_callchain(struct pt_regs *regs, bool kernel, bool user,
-		   u32 max_stack, bool crosstask, bool add_mark);
+		   u32 max_stack, bool crosstask, bool add_mark, bool defer_user);
 extern int get_callchain_buffers(int max_stack);
 extern void put_callchain_buffers(void);
 extern struct perf_callchain_entry *get_callchain_entry(int *rctx);
diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index 78a362b80027..20b8f890113b 100644
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
@@ -1239,6 +1240,22 @@ enum perf_event_type {
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
+	 *	u64				cookie;
+	 *	u64				nr;
+	 *	u64				ips[nr];
+	 *	struct sample_id		sample_id;
+	 * };
+	 */
+	PERF_RECORD_CALLCHAIN_DEFERRED		= 22,
+
 	PERF_RECORD_MAX,			/* non-ABI */
 };
 
@@ -1269,6 +1286,7 @@ enum perf_callchain_context {
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
index 28de3baff792..be94b437e7e0 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -5582,6 +5582,67 @@ static bool exclusive_event_installable(struct perf_event *event,
 	return true;
 }
 
+static void perf_pending_unwind_sync(struct perf_event *event)
+{
+	struct unwind_work *work = &event->unwind_work;
+
+	unwind_deferred_cancel(work);
+}
+
+struct perf_callchain_deferred_event {
+	struct perf_event_header	header;
+	u64				cookie;
+	u64				nr;
+	u64				ips[];
+};
+
+static void perf_event_callchain_deferred(struct perf_event *event,
+					  struct unwind_stacktrace *trace,
+					  u64 cookie)
+{
+	struct perf_callchain_deferred_event deferred_event;
+	u64 callchain_context = PERF_CONTEXT_USER;
+	struct perf_output_handle handle;
+	struct perf_sample_data data;
+	u64 nr;
+
+	nr = trace->nr + 1 ; /* '+1' == callchain_context */
+
+	deferred_event.header.type = PERF_RECORD_CALLCHAIN_DEFERRED;
+	deferred_event.header.misc = PERF_RECORD_MISC_USER;
+	deferred_event.header.size = sizeof(deferred_event) + (nr * sizeof(u64));
+
+	deferred_event.nr = nr;
+	deferred_event.cookie = cookie;
+
+	perf_event_header__init_id(&deferred_event.header, &data, event);
+
+	if (perf_output_begin(&handle, &data, event, deferred_event.header.size))
+		return;
+
+	perf_output_put(&handle, deferred_event);
+	perf_output_put(&handle, callchain_context);
+	/* trace->entries[] are not guaranteed to be 64bit */
+	for (int i = 0; i < trace->nr; i++) {
+		u64 entry = trace->entries[i];
+		perf_output_put(&handle, entry);
+	}
+	perf_event__output_id_sample(event, &handle, &data);
+
+	perf_output_end(&handle);
+}
+
+/* Deferred unwinding callback for task specific events */
+static void perf_event_deferred_task(struct unwind_work *work,
+				     struct unwind_stacktrace *trace, u64 cookie)
+{
+	struct perf_event *event = container_of(work, struct perf_event, unwind_work);
+
+	perf_event_callchain_deferred(event, trace, cookie);
+
+	local_dec(&event->ctx->nr_no_switch_fast);
+}
+
 static void perf_free_addr_filters(struct perf_event *event);
 
 /* vs perf_event_alloc() error */
@@ -5649,6 +5710,7 @@ static void _free_event(struct perf_event *event)
 {
 	irq_work_sync(&event->pending_irq);
 	irq_work_sync(&event->pending_disable_irq);
+	perf_pending_unwind_sync(event);
 
 	unaccount_event(event);
 
@@ -8194,6 +8256,28 @@ static u64 perf_get_page_size(unsigned long addr)
 
 static struct perf_callchain_entry __empty_callchain = { .nr = 0, };
 
+/*
+ * Returns:
+*     > 0 : if already queued.
+ *      0 : if it performed the queuing
+ *    < 0 : if it did not get queued.
+ */
+static int deferred_request(struct perf_event *event)
+{
+	struct unwind_work *work = &event->unwind_work;
+	u64 cookie;
+
+	/* Only defer for task events */
+	if (!event->ctx->task)
+		return -EINVAL;
+
+	if ((current->flags & (PF_KTHREAD | PF_USER_WORKER)) ||
+	    !user_mode(task_pt_regs(current)))
+		return -EINVAL;
+
+	return unwind_deferred_request(work, &cookie);
+}
+
 struct perf_callchain_entry *
 perf_callchain(struct perf_event *event, struct pt_regs *regs)
 {
@@ -8204,6 +8288,8 @@ perf_callchain(struct perf_event *event, struct pt_regs *regs)
 	bool crosstask = event->ctx->task && event->ctx->task != current;
 	const u32 max_stack = event->attr.sample_max_stack;
 	struct perf_callchain_entry *callchain;
+	bool defer_user = IS_ENABLED(CONFIG_UNWIND_USER) && user &&
+			  event->attr.defer_callchain;
 
 	if (!current->mm)
 		user = false;
@@ -8211,8 +8297,21 @@ perf_callchain(struct perf_event *event, struct pt_regs *regs)
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
 
@@ -13046,6 +13145,13 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
 		}
 	}
 
+	if (event->attr.defer_callchain) {
+		if (task) {
+			err = unwind_deferred_task_init(&event->unwind_work,
+							perf_event_deferred_task);
+		}
+	}
+
 	err = security_perf_event_alloc(event);
 	if (err)
 		return ERR_PTR(err);
diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
index 78a362b80027..20b8f890113b 100644
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
@@ -1239,6 +1240,22 @@ enum perf_event_type {
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
+	 *	u64				cookie;
+	 *	u64				nr;
+	 *	u64				ips[nr];
+	 *	struct sample_id		sample_id;
+	 * };
+	 */
+	PERF_RECORD_CALLCHAIN_DEFERRED		= 22,
+
 	PERF_RECORD_MAX,			/* non-ABI */
 };
 
@@ -1269,6 +1286,7 @@ enum perf_callchain_context {
 	PERF_CONTEXT_HV				= (__u64)-32,
 	PERF_CONTEXT_KERNEL			= (__u64)-128,
 	PERF_CONTEXT_USER			= (__u64)-512,
+	PERF_CONTEXT_USER_DEFERRED		= (__u64)-640,
 
 	PERF_CONTEXT_GUEST			= (__u64)-2048,
 	PERF_CONTEXT_GUEST_KERNEL		= (__u64)-2176,
-- 
2.50.1



