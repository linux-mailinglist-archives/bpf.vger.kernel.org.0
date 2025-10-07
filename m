Return-Path: <bpf+bounces-70541-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A41C4BC2C49
	for <lists+bpf@lfdr.de>; Tue, 07 Oct 2025 23:39:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDED719A180E
	for <lists+bpf@lfdr.de>; Tue,  7 Oct 2025 21:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8597E2586C2;
	Tue,  7 Oct 2025 21:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EJ9fuBWT"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78EC254AE1;
	Tue,  7 Oct 2025 21:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759873172; cv=none; b=ngNX38pwCrDAguNSNjY5FOpFY84GWRwGMAQ6Rfe81QFODL2BzdetEnEYU0vfjX+EdSciETS5JI9Ry6Rbe/rG52PeAe5fvfvpUw+3ZPKHWBe7immTGVPME35sQrQvXAQ3QC6Ldn+02Ai/T0rzEzDyIMnfJ0E3dWSy6iIP1ILtlYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759873172; c=relaxed/simple;
	bh=zL+0EonX4yAc7B6yjhhjBannMKC0T+wNhNBCV0IzQeE=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=JQWAFGcUxUSUvedzooUh86Ra5Xa5iBqdEzFHZVgwlC8gDZ/42zI6bN5TMTDuIqWTwc8OrOagbNILXEj2Tvxv7Z83GyvWkxF6BRM+N947v+sh/Voo6vBYOtQUu7X6+3afpvY9Z+5xadGG3/BXWI+ZqIpWk3shBcCo0xH0cF+8PLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EJ9fuBWT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48D76C4CEFE;
	Tue,  7 Oct 2025 21:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759873171;
	bh=zL+0EonX4yAc7B6yjhhjBannMKC0T+wNhNBCV0IzQeE=;
	h=Date:From:To:Cc:Subject:References:From;
	b=EJ9fuBWTnqOj26UmHnoVgQ9ml5OG2YvYpbneUS3/AKdOhFgUI5Tz/Jl6NoLEf4zSv
	 X/U4GbgGewBKIEZCXlX9LipmjrVeUc2hCZmYbsjDbortRJrA6P+G6YM+UKQWCylFqp
	 NvYajZWan3a/k/TL3GYD97dCUGaSpVIBj2dDnw+JggLBKBgzyn+OLIkr59oXI3sAs9
	 q+dJeHNhdihvCOi47vmzKvGUXUV2Vw15pIMSkdLz24TpxVw5fnmW60bGYU7J0QLUia
	 CEUvu/UBitkZVCnLGS1tnjIFAnCdeN07i1FnQD6PRClu78vXG0R2rxqw7tzAgUibbq
	 1PLVktQ+cwctg==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1v6FQx-00000007Xfg-2sCb;
	Tue, 07 Oct 2025 17:41:23 -0400
Message-ID: <20251007214123.537465618@kernel.org>
User-Agent: quilt/0.68
Date: Tue, 07 Oct 2025 17:40:09 -0400
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
Subject: [PATCH v16 1/4] unwind: Add interface to allow tracing a single task
References: <20251007214008.080852573@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

If a tracer (namely perf) is only tracing a single task, it doesn't need
the full functionality of the deferred stacktrace infrastructure. That
infrastructure has a limited number of users as it needs to handle
multiple tracers that can trace multiple tasks at the same time, creating
a multi to multi relationship.

But for a tracer that is tracing a single task, that creates a single to
multi relationship (a tracer tracing a single task and a task that can
have several tracers tracing it). This allows for data to be allocated at
the time of initialization to let the tracer use its own task_work data
structures to attach to the task.

Add a new interface called unwind_deferred_task_init() that works similar
to the unwind_deferred_init(), but this interface is used when the tracer
will only ever trace a single task at the same time.

The unwind_work descriptor that is initialized during this init function
now has a struct callback_head field that is used to attach itself to a
task_work. The work->bit for this task is set to the UNWIND_PENDING_BIT
(but defined as UNWIND_TASK) to differentiate it from unwind_works that
are tracing any task, as their work->bit will be one of the allocated
bits in the unwind_mask.

The rest of the calls are the same. That is, the unwind_deferred_request()
and unwind_deferred_cancel() are called on this, and these functions will
know that this unwind_work descriptor traces a single task. Even the
callback function works the same.

If a tracer were to try to use this unwind_work on multiple tasks at the
same time, it will simply fail to attach to the second task if one is
already pending a deferred stacktrace, and a WARN_ON is produced.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/linux/unwind_deferred.h |  15 ++
 kernel/unwind/deferred.c        | 283 +++++++++++++++++++++++++++-----
 2 files changed, 255 insertions(+), 43 deletions(-)

diff --git a/include/linux/unwind_deferred.h b/include/linux/unwind_deferred.h
index f4743c8cff4c..6f0f04ba538d 100644
--- a/include/linux/unwind_deferred.h
+++ b/include/linux/unwind_deferred.h
@@ -2,6 +2,7 @@
 #ifndef _LINUX_UNWIND_USER_DEFERRED_H
 #define _LINUX_UNWIND_USER_DEFERRED_H
 
+#include <linux/rcuwait.h>
 #include <linux/task_work.h>
 #include <linux/unwind_user.h>
 #include <linux/unwind_deferred_types.h>
@@ -15,6 +16,9 @@ typedef void (*unwind_callback_t)(struct unwind_work *work,
 struct unwind_work {
 	struct list_head		list;
 	unwind_callback_t		func;
+	struct callback_head 		work;
+	struct task_struct		*task;
+	struct rcuwait			wait;
 	int				bit;
 };
 
@@ -32,11 +36,22 @@ enum {
 	UNWIND_USED		= BIT(UNWIND_USED_BIT)
 };
 
+/*
+ * UNWIND_PENDING is set in the task's info->unwind_mask when
+ * a deferred unwind is requested on that task. If the unwind
+ * descriptor is used only to trace a specific task, it's bit
+ * is the UNWIND_PENDING_BIT. This gets set as the work->bit
+ * and is to distinguish unwind_work descriptors that trace
+ * a single task from those that trace all tasks.
+ */
+#define UNWIND_TASK	UNWIND_PENDING_BIT
+
 void unwind_task_init(struct task_struct *task);
 void unwind_task_free(struct task_struct *task);
 
 int unwind_user_faultable(struct unwind_stacktrace *trace);
 
+int unwind_deferred_task_init(struct unwind_work *work, unwind_callback_t func);
 int unwind_deferred_init(struct unwind_work *work, unwind_callback_t func);
 int unwind_deferred_request(struct unwind_work *work, u64 *cookie);
 void unwind_deferred_cancel(struct unwind_work *work);
diff --git a/kernel/unwind/deferred.c b/kernel/unwind/deferred.c
index ceeeff562302..f34b60713a4b 100644
--- a/kernel/unwind/deferred.c
+++ b/kernel/unwind/deferred.c
@@ -44,6 +44,7 @@ static inline bool try_assign_cnt(struct unwind_task_info *info, u32 cnt)
 /* Guards adding to or removing from the list of callbacks */
 static DEFINE_MUTEX(callback_mutex);
 static LIST_HEAD(callbacks);
+static LIST_HEAD(task_callbacks);
 
 #define RESERVED_BITS	(UNWIND_PENDING | UNWIND_USED)
 
@@ -155,12 +156,18 @@ static void process_unwind_deferred(struct task_struct *task)
 	unsigned long bits;
 	u64 cookie;
 
-	if (WARN_ON_ONCE(!unwind_pending(info)))
-		return;
-
 	/* Clear pending bit but make sure to have the current bits */
 	bits = atomic_long_fetch_andnot(UNWIND_PENDING,
 					&info->unwind_mask);
+
+	/* Remove the callbacks that were already completed */
+	if (info->cache)
+		bits &= ~(info->cache->unwind_completed);
+
+	/* If all callbacks have already been done, there's nothing to do */
+	if (!bits)
+		return;
+
 	/*
 	 * From here on out, the callback must always be called, even if it's
 	 * just an empty trace.
@@ -170,9 +177,6 @@ static void process_unwind_deferred(struct task_struct *task)
 
 	unwind_user_faultable(&trace);
 
-	if (info->cache)
-		bits &= ~(info->cache->unwind_completed);
-
 	cookie = info->id.id;
 
 	guard(srcu)(&unwind_srcu);
@@ -186,11 +190,95 @@ static void process_unwind_deferred(struct task_struct *task)
 	}
 }
 
-static void unwind_deferred_task_work(struct callback_head *head)
+/* Callback for an unwind work that traces all tasks */
+static void unwind_deferred_work(struct callback_head *head)
 {
 	process_unwind_deferred(current);
 }
 
+/* Get the trace for an unwind work that traces a single task */
+static void get_deferred_task_stacktrace(struct task_struct *task,
+					 struct unwind_stacktrace *trace,
+					 u64 *cookie, bool clear_pending)
+{
+	struct unwind_task_info *info = &task->unwind_info;
+
+	if (clear_pending)
+		atomic_long_andnot(UNWIND_PENDING, &info->unwind_mask);
+
+	trace->nr = 0;
+	trace->entries = NULL;
+
+	unwind_user_faultable(trace);
+
+	*cookie = info->id.id;
+}
+
+/* Callback for an unwind work that only traces this task */
+static void unwind_deferred_task_work(struct callback_head *head)
+{
+	struct unwind_work *work = container_of(head, struct unwind_work, work);
+	struct unwind_task_info *info = &current->unwind_info;
+	struct unwind_stacktrace trace;
+	u64 cookie;
+
+	guard(srcu)(&unwind_srcu);
+
+	/* Always clear the pending bit when this is called */
+	atomic_long_andnot(UNWIND_PENDING, &info->unwind_mask);
+
+	/* Is this work being canceled? */
+	if (unlikely(work->bit < 0))
+		work->task = NULL;
+
+	if (!work->task)
+		goto out;
+
+	/*
+	 * From here on out, the callback must always be called, even if it's
+	 * just an empty trace.
+	 */
+	get_deferred_task_stacktrace(current, &trace, &cookie, false);
+	work->func(work, &trace, cookie);
+	work->task = NULL;
+out:
+	/* Synchronize with cancel_unwind_task() */
+	rcuwait_wake_up(&work->wait);
+}
+
+/* Flush any pending work for an exiting task */
+static void process_unwind_tasks(struct task_struct *task)
+{
+	struct unwind_stacktrace trace;
+	struct unwind_work *work;
+	u64 cookie = 0;
+
+	guard(srcu)(&unwind_srcu);
+
+	/* The task is exiting, flush any pending per task unwind works */
+	list_for_each_entry_srcu(work, &task_callbacks, list,
+				 srcu_read_lock_held(&unwind_srcu)) {
+		if (work->task != task)
+			continue;
+
+		/* There may be waiters in cancel_unwind_task() */
+		if (work->bit < 0)
+			goto wakeup;
+
+		task_work_cancel(task, &work->work);
+
+		/* Only need to get the trace once */
+		if (!cookie)
+			get_deferred_task_stacktrace(task, &trace,
+						     &cookie, true);
+		work->func(work, &trace, cookie);
+wakeup:
+		work->task = NULL;
+		/* Synchronize with cancel_unwind_task() */
+		rcuwait_wake_up(&work->wait);
+	}
+}
+
 void unwind_deferred_task_exit(struct task_struct *task)
 {
 	struct unwind_task_info *info = &current->unwind_info;
@@ -199,10 +287,80 @@ void unwind_deferred_task_exit(struct task_struct *task)
 		return;
 
 	process_unwind_deferred(task);
+	process_unwind_tasks(task);
 
 	task_work_cancel(task, &info->work);
 }
 
+static int queue_unwind_task(struct unwind_work *work, int twa_mode,
+			     struct unwind_task_info *info)
+{
+	struct task_struct *task = READ_ONCE(work->task);
+	int ret;
+
+	if (task) {
+		/* Did the tracer break its contract? */
+		WARN_ON_ONCE(task != current);
+		return 1;
+	}
+
+	if (!try_cmpxchg(&work->task, &task, current))
+		return 1;
+
+	/* The work has been claimed, now schedule it. */
+	ret = task_work_add(current, &work->work, twa_mode);
+
+	if (WARN_ON_ONCE(ret))
+		work->task = NULL;
+	else
+		atomic_long_or(UNWIND_PENDING, &info->unwind_mask);
+
+	return ret;
+}
+
+static int queue_unwind_work(struct unwind_work *work, int twa_mode,
+			     struct unwind_task_info *info)
+{
+	unsigned long bit = BIT(work->bit);
+	unsigned long old, bits;
+	int ret;
+
+	/* Check if the unwind_work only traces this task */
+	if (work->bit == UNWIND_TASK)
+		return queue_unwind_task(work, twa_mode, info);
+
+	old = atomic_long_read(&info->unwind_mask);
+
+	/* Is this already queued or executed */
+	if (old & bit)
+		return 1;
+
+	/*
+	 * This work's bit hasn't been set yet. Now set it with the PENDING
+	 * bit and fetch the current value of unwind_mask. If ether the
+	 * work's bit or PENDING was already set, then this is already queued
+	 * to have a callback.
+	 */
+	bits = UNWIND_PENDING | bit;
+	old = atomic_long_fetch_or(bits, &info->unwind_mask);
+	if (old & bits) {
+		/*
+		 * If the work's bit was set, whatever set it had better
+		 * have also set pending and queued a callback.
+		 */
+		WARN_ON_ONCE(!(old & UNWIND_PENDING));
+		return old & bit;
+	}
+
+	/* The work has been claimed, now schedule it. */
+	ret = task_work_add(current, &info->work, twa_mode);
+
+	if (WARN_ON_ONCE(ret))
+		atomic_long_set(&info->unwind_mask, 0);
+
+	return ret;
+}
+
 /**
  * unwind_deferred_request - Request a user stacktrace on task kernel exit
  * @work: Unwind descriptor requesting the trace
@@ -232,9 +390,6 @@ int unwind_deferred_request(struct unwind_work *work, u64 *cookie)
 {
 	struct unwind_task_info *info = &current->unwind_info;
 	int twa_mode = TWA_RESUME;
-	unsigned long old, bits;
-	unsigned long bit;
-	int ret;
 
 	*cookie = 0;
 
@@ -254,47 +409,45 @@ int unwind_deferred_request(struct unwind_work *work, u64 *cookie)
 	}
 
 	/* Do not allow cancelled works to request again */
-	bit = READ_ONCE(work->bit);
-	if (WARN_ON_ONCE(bit < 0))
+	if (WARN_ON_ONCE(READ_ONCE(work->bit) < 0))
 		return -EINVAL;
 
-	/* Only need the mask now */
-	bit = BIT(bit);
-
 	guard(irqsave)();
 
 	*cookie = get_cookie(info);
 
-	old = atomic_long_read(&info->unwind_mask);
+	return queue_unwind_work(work, twa_mode, info);
+}
 
-	/* Is this already queued or executed */
-	if (old & bit)
-		return 1;
+static void cancel_unwind_task(struct unwind_work *work)
+{
+	struct task_struct *task;
 
-	/*
-	 * This work's bit hasn't been set yet. Now set it with the PENDING
-	 * bit and fetch the current value of unwind_mask. If ether the
-	 * work's bit or PENDING was already set, then this is already queued
-	 * to have a callback.
-	 */
-	bits = UNWIND_PENDING | bit;
-	old = atomic_long_fetch_or(bits, &info->unwind_mask);
-	if (old & bits) {
+	task = READ_ONCE(work->task);
+
+	if (!task || !task_work_cancel(task, &work->work)) {
 		/*
-		 * If the work's bit was set, whatever set it had better
-		 * have also set pending and queued a callback.
+		 * If the task_work_cancel() fails to cancel it could mean that
+		 * the task_work is just about to execute. This needs to wait
+		 * until the work->func() is finished before returning.
+		 * This is required because the SRCU section may not have been
+		 * entered yet, and the synchronize_srcu() will not wait for it.
 		 */
-		WARN_ON_ONCE(!(old & UNWIND_PENDING));
-		return old & bit;
+		if (task) {
+			rcuwait_wait_event(&work->wait, work->task == NULL,
+				   TASK_UNINTERRUPTIBLE);
+		}
 	}
 
-	/* The work has been claimed, now schedule it. */
-	ret = task_work_add(current, &info->work, twa_mode);
-
-	if (WARN_ON_ONCE(ret))
-		atomic_long_set(&info->unwind_mask, 0);
+	/*
+	 * Needed to protect loop in process_unwind_tasks().
+	 * This also guarantees that unwind_deferred_task_work() is
+	 * completely done and the work structure is no longer referenced.
+	 */
+	synchronize_srcu(&unwind_srcu);
 
-	return ret;
+	/* Still set task to NULL if task_work_cancel() succeeded */
+	work->task = NULL;
 }
 
 void unwind_deferred_cancel(struct unwind_work *work)
@@ -307,16 +460,24 @@ void unwind_deferred_cancel(struct unwind_work *work)
 
 	bit = work->bit;
 
-	/* No work should be using a reserved bit */
-	if (WARN_ON_ONCE(BIT(bit) & RESERVED_BITS))
+	/* Was it initialized ? */
+	if (!bit)
 		return;
 
-	guard(mutex)(&callback_mutex);
-	list_del_rcu(&work->list);
+	scoped_guard(mutex, &callback_mutex) {
+		list_del_rcu(&work->list);
+	}
 
 	/* Do not allow any more requests and prevent callbacks */
 	work->bit = -1;
 
+	if (bit == UNWIND_TASK)
+		return cancel_unwind_task(work);
+
+	/* No work should be using a reserved bit */
+	if (WARN_ON_ONCE(BIT(bit) & RESERVED_BITS))
+		return;
+
 	__clear_bit(bit, &unwind_mask);
 
 	synchronize_srcu(&unwind_srcu);
@@ -330,6 +491,17 @@ void unwind_deferred_cancel(struct unwind_work *work)
 	}
 }
 
+/**
+ * unwind_deferred_init - Init unwind_work that traces any task
+ * @work: The unwind_work descriptor to initialize
+ * @func: The callback function that will have the stacktrace
+ *
+ * Initialize a work that can trace any task. There's only a limited
+ * number of these that can be allocated.
+ *
+ * Returns 0 on success or -EBUSY if the limit of these unwind_works have
+ *   been exceeded.
+ */
 int unwind_deferred_init(struct unwind_work *work, unwind_callback_t func)
 {
 	memset(work, 0, sizeof(*work));
@@ -348,12 +520,37 @@ int unwind_deferred_init(struct unwind_work *work, unwind_callback_t func)
 	return 0;
 }
 
+/**
+ * unwind_deferred_task_init - Init unwind_work that traces a single task
+ * @work: The unwind_work descriptor to initialize
+ * @func: The callback function that will have the stacktrace
+ *
+ * Initialize a work that will always trace only a single task. It is
+ * up to the caller to make sure that the unwind_deferred_requeust()
+ * will always be called on the same task for the @work descriptor.
+ *
+ * Note, unlike unwind_deferred_init() there is no limit of these works
+ * that can be initialized and used.
+ */
+int unwind_deferred_task_init(struct unwind_work *work, unwind_callback_t func)
+{
+	memset(work, 0, sizeof(*work));
+	work->bit = UNWIND_TASK;
+	init_task_work(&work->work, unwind_deferred_task_work);
+	work->func = func;
+	rcuwait_init(&work->wait);
+
+	guard(mutex)(&callback_mutex);
+	list_add_rcu(&work->list, &task_callbacks);
+	return 0;
+}
+
 void unwind_task_init(struct task_struct *task)
 {
 	struct unwind_task_info *info = &task->unwind_info;
 
 	memset(info, 0, sizeof(*info));
-	init_task_work(&info->work, unwind_deferred_task_work);
+	init_task_work(&info->work, unwind_deferred_work);
 	atomic_long_set(&info->unwind_mask, 0);
 }
 
-- 
2.50.1



