Return-Path: <bpf+bounces-61597-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7E79AE9164
	for <lists+bpf@lfdr.de>; Thu, 26 Jun 2025 00:57:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D2023B820C
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 22:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C44E2F4301;
	Wed, 25 Jun 2025 22:57:00 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC8552877E4;
	Wed, 25 Jun 2025 22:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750892219; cv=none; b=P5I++vPx1xRtvAv7sRqEc96R7u+ffmw7HQ3bdbn2lZ7FY2tQfR/BwdAmLHfea7fctGId/Nm5YYeyswE3CmI01bWE11+10qs+BRAzcxBSZRQPu52Xhf/xysfUUYJbSYsmeoFrygN+/y82b+HdDOHx7IA3LP6uyCJMG4yZjAgU8LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750892219; c=relaxed/simple;
	bh=1REnszmbSgdI4pH4JSOyv7IfR9sppqawjYaSwndvGZM=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=i4blrTZqDfMInP1A4Sh3srLu1/0/YhdWizKIdyG4szkmaqTgD41LCVfIirbI4ITW/EvaYgieXSAh2eCHy/snDcmNR4Y2h6x1jxMDuJ2+kwZQcN4WM9oTDLdZ+KbzVdzwIZdOs8RadyIEDOFhZ9Enl5Xpx4XGp/Es7vLSxWLgWsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf20.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id 096E11A0784;
	Wed, 25 Jun 2025 22:56:53 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: nevets@goodmis.org) by omf20.hostedemail.com (Postfix) with ESMTPA id BED1020026;
	Wed, 25 Jun 2025 22:56:50 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@goodmis.org>)
	id 1uUZ3L-000000043fn-44eR;
	Wed, 25 Jun 2025 18:57:15 -0400
Message-ID: <20250625225715.825831885@goodmis.org>
User-Agent: quilt/0.68
Date: Wed, 25 Jun 2025 18:56:06 -0400
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
 Andrew Morton <akpm@linux-foundation.org>,
 Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v11 06/14] unwind_user/deferred: Add deferred unwinding interface
References: <20250625225600.555017347@goodmis.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Stat-Signature: m96k1dzifbzeeiaqp1dic47185xecsiy
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: BED1020026
X-Session-Marker: 6E657665747340676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18XVPStbC6q5tH+to2GD7pEUKCYL0SrhZs=
X-HE-Tag: 1750892210-680092
X-HE-Meta: U2FsdGVkX18ThzG8jFOu6pSSfHCNQ59UQUzTkHbG87f/lfHAKTv1ghnm8h9sRmpIkkHjiA3psUv0sSPQ6tQuG2gToLoPJSt0TdJISNidmGp1oLsrfT+hD3fCWS8qtTiGTqrIuKGJG3Paakp4/5C1Jwv9zFWPCXDwd8dtZBNjuvG48kO4ZMxrKCGSL4rtj1tUHqR2BLeSIF4XNvqOt3EE4oakAUPi1AqYuLFhmgVeT+IX9sHvDaTlPKCTeeprXsWhJkvT2fDjdXj2gJPdOWv4fxdww6rKw3pHy8bMdAishtc01EtOwVUhk1jlubGlxsAjr73J5pL7ZRfaEmEP6FQjyDnzf9IUXy6LAq5GXLF9jNje1quq/5wPtLiT45SoOHXf0FU+N5NzQVX2K8gcp6lqLaVwhC/4aqie3EfRQuH9lCA=

From: Josh Poimboeuf <jpoimboe@kernel.org>

Add an interface for scheduling task work to unwind the user space stack
before returning to user space. This solves several problems for its
callers:

  - Ensure the unwind happens in task context even if the caller may be
    running in interrupt context.

  - Avoid duplicate unwinds, whether called multiple times by the same
    caller or by different callers.

  - Take a timestamp when the first request comes in since the task
    entered the kernel. This will be returned to the calling function
    along with the stack trace when the task leaves the kernel. This
    timestamp can be used to correlate kernel unwinds/traces with the user
    unwind. For this to work properly, the architecture must have a
    local_clock() resolution that guarantees a different timestamp per
    a task systemcall.

The timestamp is created to detect when the stacktrace is the same. It is
generated the first time a user space stacktrace is requested after the
task enters the kernel.

The timestamp is passed to the caller on request, and when the stacktrace is
generated upon returning to user space, it will call the requester's callback
with the timestamp as well as the stacktrace.

A global list is created and protected by a global mutex that holds
tracers that register with the unwind infrastructure. The number of
registered tracers will be limited in future changes. Each perf program or
ftrace instance will register its own descriptor to use for deferred
unwind stack traces.

Note, in the function unwind_deferred_task_work() that gets called when
returning to user space, it uses a global mutex for synchronization which
will cause a big bottleneck. This will be replaced by SRCU, but that
change adds some complex synchronization that deservers its own commit.

Co-developed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
Changes since v10: https://lore.kernel.org/20250611010428.770214773@goodmis.org

- Added comment stating that the clock used for the timestamp must have a
  resolution that will guarantee that two system called back to back will
  have a different timestamp.

- Use timestamp being zero to exit out early in unwind_reset_info() so
  that there's no writes when not used. (Peter Zijlstra)

- Update change log to mention that each perf program and ftrace intance
  will register with the deferred unwinder. (Peter Zijlstra).

- Update change log to express that unwind_deferred_task_work() uses a
  global lock but will later be replaced with SRCU. (Peter Zijlstra)

 include/linux/unwind_deferred.h       |  24 ++++-
 include/linux/unwind_deferred_types.h |   3 +
 kernel/unwind/deferred.c              | 139 +++++++++++++++++++++++++-
 3 files changed, 164 insertions(+), 2 deletions(-)

diff --git a/include/linux/unwind_deferred.h b/include/linux/unwind_deferred.h
index baacf4a1eb4c..26011b413142 100644
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
@@ -12,10 +22,19 @@ void unwind_task_free(struct task_struct *task);
 
 int unwind_user_faultable(struct unwind_stacktrace *trace);
 
+int unwind_deferred_init(struct unwind_work *work, unwind_callback_t func);
+int unwind_deferred_request(struct unwind_work *work, u64 *timestamp);
+void unwind_deferred_cancel(struct unwind_work *work);
+
 static __always_inline void unwind_reset_info(void)
 {
-	if (unlikely(current->unwind_info.cache))
+	/* Exit out early if this was never used */
+	if (likely(!current->unwind_info.timestamp))
+		return;
+
+	if (current->unwind_info.cache)
 		current->unwind_info.cache->nr_entries = 0;
+	current->unwind_info.timestamp = 0;
 }
 
 #else /* !CONFIG_UNWIND_USER */
@@ -24,6 +43,9 @@ static inline void unwind_task_init(struct task_struct *task) {}
 static inline void unwind_task_free(struct task_struct *task) {}
 
 static inline int unwind_user_faultable(struct unwind_stacktrace *trace) { return -ENOSYS; }
+static inline int unwind_deferred_init(struct unwind_work *work, unwind_callback_t func) { return -ENOSYS; }
+static inline int unwind_deferred_request(struct unwind_work *work, u64 *timestamp) { return -ENOSYS; }
+static inline void unwind_deferred_cancel(struct unwind_work *work) {}
 
 static inline void unwind_reset_info(void) {}
 
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
index 96368a5aa522..d5f2c004a5b0 100644
--- a/kernel/unwind/deferred.c
+++ b/kernel/unwind/deferred.c
@@ -2,16 +2,43 @@
 /*
  * Deferred user space unwinding
  */
+#include <linux/sched/task_stack.h>
+#include <linux/unwind_deferred.h>
+#include <linux/sched/clock.h>
+#include <linux/task_work.h>
 #include <linux/kernel.h>
 #include <linux/sched.h>
 #include <linux/sizes.h>
 #include <linux/slab.h>
-#include <linux/unwind_deferred.h>
+#include <linux/mm.h>
 
 /* Make the cache fit in a 4K page */
 #define UNWIND_MAX_ENTRIES					\
 	((SZ_4K - sizeof(struct unwind_cache)) / sizeof(long))
 
+/* Guards adding to and reading the list of callbacks */
+static DEFINE_MUTEX(callback_mutex);
+static LIST_HEAD(callbacks);
+
+/*
+ * Read the task context timestamp, if this is the first caller then
+ * it will set the timestamp.
+ *
+ * For this to work properly, the timestamp (local_clock()) must
+ * have a resolution that will guarantee a different timestamp
+ * everytime a task makes a system call. That is, two short
+ * system calls back to back must have a different timestamp.
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
  * unwind_user_faultable - Produce a user stacktrace in faultable context
  * @trace: The descriptor that will store the user stacktrace
@@ -62,11 +89,120 @@ int unwind_user_faultable(struct unwind_stacktrace *trace)
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
+	unwind_user_faultable(&trace);
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
+ * Note, the architecture must have a local_clock() implementation that
+ * guarantees a different timestamp per task systemcall.
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
@@ -74,4 +210,5 @@ void unwind_task_free(struct task_struct *task)
 	struct unwind_task_info *info = &task->unwind_info;
 
 	kfree(info->cache);
+	task_work_cancel(task, &info->work);
 }
-- 
2.47.2



