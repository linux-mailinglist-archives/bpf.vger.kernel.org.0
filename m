Return-Path: <bpf+bounces-57880-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F115AB1AF4
	for <lists+bpf@lfdr.de>; Fri,  9 May 2025 18:53:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEDC81C44F7A
	for <lists+bpf@lfdr.de>; Fri,  9 May 2025 16:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AB0C23CEF8;
	Fri,  9 May 2025 16:51:40 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF9C523AE9B;
	Fri,  9 May 2025 16:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746809499; cv=none; b=YjOliwnVwn8iQ6brQJOBbLCg5ygz5Yv6mn0R0VuePFIhHZImb0xGAD7M0RP8MnerjXpTrZs7DAwLTaM4X/2cO9sCWQ1rBu5lVCydFquzXCEBS5j5iQKwKxGnvcUNVlmqvmkAPoOOXpFY9/mclLXmLg2EzPjbjbfCqv0tvTVpzRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746809499; c=relaxed/simple;
	bh=svXgj5zjOA8Dv/75MaXTE0GK6R6LrHdzcoJzxaoTE3c=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=DmiIuBSgiNKDP12PZM/iUxuU23qlhHJSTAIJEVM2grf10AFkgP3t6I1vhIJEKlRHycpMuO9kul7XnY/qM5+JemtbAkJNEzJKL/kALIaBk1B1wJD+9Rn6h5PK+GYtYQgI1uyyi8esVD503jULFj4Qb4qe0/gmhpq6AP6w46Fjw6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A4BFC4CEF2;
	Fri,  9 May 2025 16:51:39 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@goodmis.org>)
	id 1uDQx1-00000002gHj-18R8;
	Fri, 09 May 2025 12:51:55 -0400
Message-ID: <20250509165155.124809873@goodmis.org>
User-Agent: quilt/0.68
Date: Fri, 09 May 2025 12:45:33 -0400
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
 Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH v8 09/18] unwind_user/deferred: Add deferred unwinding interface
References: <20250509164524.448387100@goodmis.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Josh Poimboeuf <jpoimboe@kernel.org>

Add an interface for scheduling task work to unwind the user space stack
before returning to user space. This solves several problems for its
callers:

  - Ensure the unwind happens in task context even if the caller may be
    running in NMI or interrupt context.

  - Avoid duplicate unwinds, whether called multiple times by the same
    caller or by different callers.

  - Take a timestamp when the first request comes in since the task
    entered the kernel. This will be returned to the calling function
    along with the stack trace when the task leaves the kernel. This
    timestamp can be used to correlate kernel unwinds/traces with the user
    unwind.

The timestamp is created to detect when the stacktrace is the same. It is
generated the first time a user space stacktrace is requested after the
task enters the kernel.

The timestamp is passed to the caller on request, and when the stacktrace is
generated upon returning to user space, it call the requester's callback
with the timestamp as well as the stacktrace.

Co-developed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
Changes since v7: https://lore.kernel.org/20250502165008.904786447@goodmis.org

- Use a timestamp instead of a "cookie"

- Updated comments to kerneldoc for unwind_deferred_request()

 include/linux/unwind_deferred.h       |  18 ++++
 include/linux/unwind_deferred_types.h |   3 +
 kernel/unwind/deferred.c              | 131 +++++++++++++++++++++++++-
 3 files changed, 151 insertions(+), 1 deletion(-)

diff --git a/include/linux/unwind_deferred.h b/include/linux/unwind_deferred.h
index 7d6cb2ffd084..a384eef719a3 100644
--- a/include/linux/unwind_deferred.h
+++ b/include/linux/unwind_deferred.h
@@ -2,9 +2,19 @@
 #ifndef _LINUX_UNWIND_USER_DEFERRED_H
 #define _LINUX_UNWIND_USER_DEFERRED_H
 
+#include <linux/task_work.h>
 #include <linux/unwind_user.h>
 #include <linux/unwind_deferred_types.h>
 
+struct unwind_work;
+
+typedef void (*unwind_callback_t)(struct unwind_work *work, struct unwind_stacktrace *trace, u64 timestamp);
+
+struct unwind_work {
+	struct list_head		list;
+	unwind_callback_t		func;
+};
+
 #ifdef CONFIG_UNWIND_USER
 
 void unwind_task_init(struct task_struct *task);
@@ -12,10 +22,15 @@ void unwind_task_free(struct task_struct *task);
 
 int unwind_deferred_trace(struct unwind_stacktrace *trace);
 
+int unwind_deferred_init(struct unwind_work *work, unwind_callback_t func);
+int unwind_deferred_request(struct unwind_work *work, u64 *timestamp);
+void unwind_deferred_cancel(struct unwind_work *work);
+
 static __always_inline void unwind_exit_to_user_mode(void)
 {
 	if (unlikely(current->unwind_info.cache))
 		current->unwind_info.cache->nr_entries = 0;
+	current->unwind_info.timestamp = 0;
 }
 
 #else /* !CONFIG_UNWIND_USER */
@@ -24,6 +39,9 @@ static inline void unwind_task_init(struct task_struct *task) {}
 static inline void unwind_task_free(struct task_struct *task) {}
 
 static inline int unwind_deferred_trace(struct unwind_stacktrace *trace) { return -ENOSYS; }
+static inline int unwind_deferred_init(struct unwind_work *work, unwind_callback_t func) { return -ENOSYS; }
+static inline int unwind_deferred_request(struct unwind_work *work, u64 *timestamp) { return -ENOSYS; }
+static inline void unwind_deferred_cancel(struct unwind_work *work) {}
 
 static inline void unwind_exit_to_user_mode(void) {}
 
diff --git a/include/linux/unwind_deferred_types.h b/include/linux/unwind_deferred_types.h
index db5b54b18828..5df264cf81ad 100644
--- a/include/linux/unwind_deferred_types.h
+++ b/include/linux/unwind_deferred_types.h
@@ -9,6 +9,9 @@ struct unwind_cache {
 
 struct unwind_task_info {
 	struct unwind_cache	*cache;
+	struct callback_head	work;
+	u64			timestamp;
+	int			pending;
 };
 
 #endif /* _LINUX_UNWIND_USER_DEFERRED_TYPES_H */
diff --git a/kernel/unwind/deferred.c b/kernel/unwind/deferred.c
index e3913781c8c6..b76c704ddc6d 100644
--- a/kernel/unwind/deferred.c
+++ b/kernel/unwind/deferred.c
@@ -2,13 +2,35 @@
 /*
  * Deferred user space unwinding
  */
+#include <linux/sched/task_stack.h>
+#include <linux/unwind_deferred.h>
+#include <linux/sched/clock.h>
+#include <linux/task_work.h>
 #include <linux/kernel.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
-#include <linux/unwind_deferred.h>
+#include <linux/mm.h>
 
 #define UNWIND_MAX_ENTRIES 512
 
+/* Guards adding to and reading the list of callbacks */
+static DEFINE_MUTEX(callback_mutex);
+static LIST_HEAD(callbacks);
+
+/*
+ * Read the task context timestamp, if this is the first caller then
+ * it will set the timestamp.
+ */
+static u64 get_timestamp(struct unwind_task_info *info)
+{
+	lockdep_assert_irqs_disabled();
+
+	if (!info->timestamp)
+		info->timestamp = local_clock();
+
+	return info->timestamp;
+}
+
 /**
  * unwind_deferred_trace - Produce a user stacktrace in faultable context
  * @trace: The descriptor that will store the user stacktrace
@@ -59,11 +81,117 @@ int unwind_deferred_trace(struct unwind_stacktrace *trace)
 	return 0;
 }
 
+static void unwind_deferred_task_work(struct callback_head *head)
+{
+	struct unwind_task_info *info = container_of(head, struct unwind_task_info, work);
+	struct unwind_stacktrace trace;
+	struct unwind_work *work;
+	u64 timestamp;
+
+	if (WARN_ON_ONCE(!info->pending))
+		return;
+
+	/* Allow work to come in again */
+	WRITE_ONCE(info->pending, 0);
+
+	/*
+	 * From here on out, the callback must always be called, even if it's
+	 * just an empty trace.
+	 */
+	trace.nr = 0;
+	trace.entries = NULL;
+
+	unwind_deferred_trace(&trace);
+
+	timestamp = info->timestamp;
+
+	guard(mutex)(&callback_mutex);
+	list_for_each_entry(work, &callbacks, list) {
+		work->func(work, &trace, timestamp);
+	}
+}
+
+/**
+ * unwind_deferred_request - Request a user stacktrace on task exit
+ * @work: Unwind descriptor requesting the trace
+ * @timestamp: The time stamp of the first request made for this task
+ *
+ * Schedule a user space unwind to be done in task work before exiting the
+ * kernel.
+ *
+ * The returned @timestamp output is the timestamp of the very first request
+ * for a user space stacktrace for this task since it entered the kernel.
+ * It can be from a request by any caller of this infrastructure.
+ * Its value will also be passed to the callback function.  It can be
+ * used to stitch kernel and user stack traces together in post-processing.
+ *
+ * It's valid to call this function multiple times for the same @work within
+ * the same task entry context.  Each call will return the same timestamp
+ * while the task hasn't left the kernel. If the callback is not pending because
+ * it has already been previously called for the same entry context, it will be
+ * called again with the same stack trace and timestamp.
+ *
+ * Return: 1 if the the callback was already queued.
+ *         0 if the callback successfully was queued.
+ *         Negative if there's an error.
+ *         @timestamp holds the timestamp of the first request by any user
+ */
+int unwind_deferred_request(struct unwind_work *work, u64 *timestamp)
+{
+	struct unwind_task_info *info = &current->unwind_info;
+	int ret;
+
+	*timestamp = 0;
+
+	if (WARN_ON_ONCE(in_nmi()))
+		return -EINVAL;
+
+	if ((current->flags & (PF_KTHREAD | PF_EXITING)) ||
+	    !user_mode(task_pt_regs(current)))
+		return -EINVAL;
+
+	guard(irqsave)();
+
+	*timestamp = get_timestamp(info);
+
+	/* callback already pending? */
+	if (info->pending)
+		return 1;
+
+	/* The work has been claimed, now schedule it. */
+	ret = task_work_add(current, &info->work, TWA_RESUME);
+	if (WARN_ON_ONCE(ret))
+		return ret;
+
+	info->pending = 1;
+	return 0;
+}
+
+void unwind_deferred_cancel(struct unwind_work *work)
+{
+	if (!work)
+		return;
+
+	guard(mutex)(&callback_mutex);
+	list_del(&work->list);
+}
+
+int unwind_deferred_init(struct unwind_work *work, unwind_callback_t func)
+{
+	memset(work, 0, sizeof(*work));
+
+	guard(mutex)(&callback_mutex);
+	list_add(&work->list, &callbacks);
+	work->func = func;
+	return 0;
+}
+
 void unwind_task_init(struct task_struct *task)
 {
 	struct unwind_task_info *info = &task->unwind_info;
 
 	memset(info, 0, sizeof(*info));
+	init_task_work(&info->work, unwind_deferred_task_work);
 }
 
 void unwind_task_free(struct task_struct *task)
@@ -71,4 +199,5 @@ void unwind_task_free(struct task_struct *task)
 	struct unwind_task_info *info = &task->unwind_info;
 
 	kfree(info->cache);
+	task_work_cancel(task, &info->work);
 }
-- 
2.47.2



