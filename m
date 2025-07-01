Return-Path: <bpf+bounces-61909-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CE17AEEB62
	for <lists+bpf@lfdr.de>; Tue,  1 Jul 2025 02:54:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3982116C1CB
	for <lists+bpf@lfdr.de>; Tue,  1 Jul 2025 00:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80737189BB0;
	Tue,  1 Jul 2025 00:54:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC5670810;
	Tue,  1 Jul 2025 00:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751331263; cv=none; b=CWsjTLFatTraoKA9ZrCGzwWWEVqbo3Y/4PjCrFGH4J8HK1MM0DM8WgGmiDPRYJDKSYtfLOWQ+f+BWmp2Ur2Wvr1Wbv3moia9vE7QdrKX3r6t1nCD0AU/eFSxeo/QK4jLWt6Lo809ilAKupDpu2f9j5bWrsXebgLvAoQ7yD+6xAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751331263; c=relaxed/simple;
	bh=/fhP0G5w5Mdbxa/N1ajD+zL9+BN18lQDlsVO4FIlCbE=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=UJVOJsC7LRBGUSz7PJc/2rcwj+NXfLbG6reZbqDh18oVLs3MSd3XHz1pJcWl/8ODaavTQzSH9+ajU9S158J/hYi0m+VYkjQ5qQZ9RGIoNRGIu4A040/9Bdi/8cRN3ObD5cNfZtq5tPCNVfhDVprM7McZR+yp0Y4KhciNvD/Jrgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf18.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id 497BDC01F7;
	Tue,  1 Jul 2025 00:54:18 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: nevets@goodmis.org) by omf18.hostedemail.com (Postfix) with ESMTPA id D4B7930;
	Tue,  1 Jul 2025 00:54:14 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@goodmis.org>)
	id 1uWPGt-00000007NhD-30SH;
	Mon, 30 Jun 2025 20:54:51 -0400
Message-ID: <20250701005451.571473750@goodmis.org>
User-Agent: quilt/0.68
Date: Mon, 30 Jun 2025 20:53:27 -0400
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
 Jens Axboe <axboe@kernel.dk>,
 Florian Weimer <fweimer@redhat.com>
Subject: [PATCH v12 06/14] unwind_user/deferred: Add deferred unwinding interface
References: <20250701005321.942306427@goodmis.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Stat-Signature: 5s9d1ggaott1gj6zfy8c7c51xa1cehqn
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: D4B7930
X-Session-Marker: 6E657665747340676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18t4EHvimXWuG5Uw0QPGQCEJafeb1XXSI0=
X-HE-Tag: 1751331254-871883
X-HE-Meta: U2FsdGVkX1/SLFt6rq3TrYMtXp+jkc657ZLMPhCdlCDmW8qtTfHiavCD5KvbOdDuR0PdHbYG5ftVuSmCCRwa/AfdoA+XfNGp3w8GkEfcaH6+40etbazd+rCcizWVzdnKVf8PzPk+UQcngms5Kcu4pQGaDdliSKRAQGD+shTarquaTj9prNCRutSOx4AxNyJGksLeSJnNdl+7f7cL0swiKYS04c1olfNHRUZldP7pRm5/kmJnUhe5NA93MxCyq9rKeNvRsfXIyAl392awNkSHro65yUjEHGfMW0wKdF6UYTZnYAxz+jSX/EV/9rg1FpiXgrxwxF2mlkdfMm+DIEun60XMoin3eYCbyf5U+UbqWO8rpa56qKGMGEatE+Hf3z5IbxDO7rqy0gQXsG/AbaUGUc/KtGOOITDlLbvlFwkjxoU=

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
with the timestamp as well as the stacktrace. The timestamp is cleared
when it goes back to user space. Note, this currently adds another
conditional to the unwind_reset_info() path that is always called
returning to user space, but future changes will put this back to a single
conditional.

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
Changes since v11: https://lore.kernel.org/20250625225715.825831885@goodmis.org

- Still need to clear cache->nr_entries in unwind_reset_info even if
  timestamp is zero. This is because unwind_user_faultable() can be called
  directly and it requires nr_entries to be zeroed but it does not touch
  the timestamp.

 include/linux/unwind_deferred.h       |  24 +++++
 include/linux/unwind_deferred_types.h |   3 +
 kernel/unwind/deferred.c              | 139 +++++++++++++++++++++++++-
 3 files changed, 165 insertions(+), 1 deletion(-)

diff --git a/include/linux/unwind_deferred.h b/include/linux/unwind_deferred.h
index baacf4a1eb4c..c6548e8d64d1 100644
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
@@ -12,8 +22,19 @@ void unwind_task_free(struct task_struct *task);
 
 int unwind_user_faultable(struct unwind_stacktrace *trace);
 
+int unwind_deferred_init(struct unwind_work *work, unwind_callback_t func);
+int unwind_deferred_request(struct unwind_work *work, u64 *timestamp);
+void unwind_deferred_cancel(struct unwind_work *work);
+
 static __always_inline void unwind_reset_info(void)
 {
+	if (unlikely(current->unwind_info.timestamp))
+		current->unwind_info.timestamp = 0;
+	/*
+	 * As unwind_user_faultable() can be called directly and
+	 * depends on nr_entries being cleared on exit to user,
+	 * this needs to be a separate conditional.
+	 */
 	if (unlikely(current->unwind_info.cache))
 		current->unwind_info.cache->nr_entries = 0;
 }
@@ -24,6 +45,9 @@ static inline void unwind_task_init(struct task_struct *task) {}
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



