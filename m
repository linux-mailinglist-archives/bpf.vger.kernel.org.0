Return-Path: <bpf+bounces-62591-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 833DEAFBFD8
	for <lists+bpf@lfdr.de>; Tue,  8 Jul 2025 03:24:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4226B4253BB
	for <lists+bpf@lfdr.de>; Tue,  8 Jul 2025 01:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8185E21A425;
	Tue,  8 Jul 2025 01:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ABMpsFq5"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29551F91C8;
	Tue,  8 Jul 2025 01:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751937838; cv=none; b=ubugdq/I0AmDVyTQ5BBN2FZj6KO51HKvuRkXrL3ol7Xj76OyEDOcOMGuAQrA4uZnD0RawoC693KW0wggZ71f+ts4+KkL1Wq56kk5pL3ZOpauxTiUOO+ZmKl0FxOnpqB0sMSf6vE8FPp8A6Qs093uRKYn50wet+bxejKtAK/NHyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751937838; c=relaxed/simple;
	bh=qmTEwDoeegk7DD73bMEZwWggpkWe2bUx5X2J9A6ubDE=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=a/8CWOx1v7n+Y50CnA4tglAvUevnyyLPgBnc9LubyJZdmfe7NoBezDbHV2oEXnLB+doNABoy7kAHNG2mxTnKGG4wv19iJNlxv7hYWk4kjrLU5duXg3dbkD32twOpSLvvvYzHG/0x//fRRLUzHQFkmG2PsI5uW1e6obU+XXyw/0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ABMpsFq5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E4C0C116C6;
	Tue,  8 Jul 2025 01:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751937838;
	bh=qmTEwDoeegk7DD73bMEZwWggpkWe2bUx5X2J9A6ubDE=;
	h=Date:From:To:Cc:Subject:References:From;
	b=ABMpsFq5ogBTw2mZdesdOlvilhqxiLOkUmMkmHEynEGEMsNoSxqH8MYB+ci5NBnd1
	 hylAfBbOO5rhPTnuWb+Ao/PO70RGc+YSEvX5zGmvxfIPdSOouHJ7b8YoBI23ApAVE4
	 thd5gD0BkW8NmiBbXJ7RS4ZxPaerRr7mbUULBaISKpO8m85XAQUJ5iTNw9rFLkZvMJ
	 hkTO2N5ntt3Xi2hLWhO7Ucidc7d+hiYLyoBq2m3to/fptm92LbeZfiUQbKIqkkQkkY
	 gt51ziYIUHX8uFmKd263Ple9rJRFli9kfZMwGogMObVy10zqsgSGfedtqHsu1NkiJe
	 a7VRJWcDXcjrw==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1uYx3u-00000000Brw-3PCt;
	Mon, 07 Jul 2025 21:23:58 -0400
Message-ID: <20250708012358.659547758@kernel.org>
User-Agent: quilt/0.68
Date: Mon, 07 Jul 2025 21:22:45 -0400
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
Subject: [PATCH v13 06/14] unwind_user/deferred: Add deferred unwinding interface
References: <20250708012239.268642741@kernel.org>
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
    running in interrupt context.

  - Avoid duplicate unwinds, whether called multiple times by the same
    caller or by different callers.

  - Create a "context cookie" which allows trace post-processing to
    correlate kernel unwinds/traces with the user unwind.

A concept of a "cookie" is created to detect when the stacktrace is the
same. A cookie is generated the first time a user space stacktrace is
requested after the task enters the kernel. As the stacktrace is saved on
the task_struct while the task is in the kernel, if another request comes
in, if the cookie is still the same, it will use the saved stacktrace,
and not have to regenerate one.

The cookie is passed to the caller on request, and when the stacktrace is
generated upon returning to user space, it call the requester's callback
with the cookie as well as the stacktrace. The cookie is cleared
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
Changes since v12: https://lore.kernel.org/20250701005451.571473750@goodmis.org

- Replaced the timestamp with the generated cookie logic again. Instead of
  using a 64 bit word where the CPU part of the cookie is just 12 bits,
  make it two 32 bit words, where the CPU that the cookie is generated on
  is one word and the second word is just a per cpu counter. This allows
  for just using a 32 bit cmpxchg which works on all archs that have safe
  NMI cmpxchg.

 include/linux/unwind_deferred.h       |  24 ++++
 include/linux/unwind_deferred_types.h |  12 ++
 kernel/unwind/deferred.c              | 159 +++++++++++++++++++++++++-
 3 files changed, 194 insertions(+), 1 deletion(-)

diff --git a/include/linux/unwind_deferred.h b/include/linux/unwind_deferred.h
index baacf4a1eb4c..14efd8c027aa 100644
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
+typedef void (*unwind_callback_t)(struct unwind_work *work, struct unwind_stacktrace *trace, u64 cookie);
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
+int unwind_deferred_request(struct unwind_work *work, u64 *cookie);
+void unwind_deferred_cancel(struct unwind_work *work);
+
 static __always_inline void unwind_reset_info(void)
 {
+	if (unlikely(current->unwind_info.id.id))
+		current->unwind_info.id.id = 0;
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
index db5b54b18828..79b4f8cece53 100644
--- a/include/linux/unwind_deferred_types.h
+++ b/include/linux/unwind_deferred_types.h
@@ -7,8 +7,20 @@ struct unwind_cache {
 	unsigned long		entries[];
 };
 
+
+union unwind_task_id {
+	struct {
+		u32		cpu;
+		u32		cnt;
+	};
+	u64			id;
+};
+
 struct unwind_task_info {
 	struct unwind_cache	*cache;
+	struct callback_head	work;
+	union unwind_task_id	id;
+	int			pending;
 };
 
 #endif /* _LINUX_UNWIND_USER_DEFERRED_TYPES_H */
diff --git a/kernel/unwind/deferred.c b/kernel/unwind/deferred.c
index 96368a5aa522..b1faaa55e5d5 100644
--- a/kernel/unwind/deferred.c
+++ b/kernel/unwind/deferred.c
@@ -2,16 +2,66 @@
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
+ * This is a unique percpu identifier for a given task entry context.
+ * Conceptually, it's incremented every time the CPU enters the kernel from
+ * user space, so that each "entry context" on the CPU gets a unique ID.  In
+ * reality, as an optimization, it's only incremented on demand for the first
+ * deferred unwind request after a given entry-from-user.
+ *
+ * It's combined with the CPU id to make a systemwide-unique "context cookie".
+ */
+static DEFINE_PER_CPU(u32, unwind_ctx_ctr);
+
+/*
+ * The context cookie is a unique identifier that is assigned to a user
+ * space stacktrace. As the user space stacktrace remains the same while
+ * the task is in the kernel, the cookie is an identifier for the stacktrace.
+ * Although it is possible for the stacktrace to get another cookie if another
+ * request is made after the cookie was cleared and before reentering user
+ * space.
+ */
+static u64 get_cookie(struct unwind_task_info *info)
+{
+	u32 cpu_cnt;
+	u32 cnt;
+	u32 old = 0;
+
+	if (info->id.cpu)
+		return info->id.id;
+
+	cpu_cnt = __this_cpu_read(unwind_ctx_ctr);
+	cpu_cnt += 2;
+	cnt = cpu_cnt | 1; /* Always make non zero */
+
+	if (try_cmpxchg(&info->id.cnt, &old, cnt)) {
+		/* Update the per cpu counter */
+		__this_cpu_write(unwind_ctx_ctr, cpu_cnt);
+	}
+	/* Interrupts are disabled, the CPU will always be same */
+	info->id.cpu = smp_processor_id() + 1; /* Must be non zero */
+
+	return info->id.id;
+}
+
 /**
  * unwind_user_faultable - Produce a user stacktrace in faultable context
  * @trace: The descriptor that will store the user stacktrace
@@ -62,11 +112,117 @@ int unwind_user_faultable(struct unwind_stacktrace *trace)
 	return 0;
 }
 
+static void unwind_deferred_task_work(struct callback_head *head)
+{
+	struct unwind_task_info *info = container_of(head, struct unwind_task_info, work);
+	struct unwind_stacktrace trace;
+	struct unwind_work *work;
+	u64 cookie;
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
+	cookie = info->id.id;
+
+	guard(mutex)(&callback_mutex);
+	list_for_each_entry(work, &callbacks, list) {
+		work->func(work, &trace, cookie);
+	}
+}
+
+/**
+ * unwind_deferred_request - Request a user stacktrace on task exit
+ * @work: Unwind descriptor requesting the trace
+ * @cookie: The cookie of the first request made for this task
+ *
+ * Schedule a user space unwind to be done in task work before exiting the
+ * kernel.
+ *
+ * The returned @cookie output is the generated cookie of the very first
+ * request for a user space stacktrace for this task since it entered the
+ * kernel. It can be from a request by any caller of this infrastructure.
+ * Its value will also be passed to the callback function.  It can be
+ * used to stitch kernel and user stack traces together in post-processing.
+ *
+ * It's valid to call this function multiple times for the same @work within
+ * the same task entry context.  Each call will return the same cookie
+ * while the task hasn't left the kernel. If the callback is not pending
+ * because it has already been previously called for the same entry context,
+ * it will be called again with the same stack trace and cookie.
+ *
+ * Return: 1 if the the callback was already queued.
+ *         0 if the callback successfully was queued.
+ *         Negative if there's an error.
+ *         @cookie holds the cookie of the first request by any user
+ */
+int unwind_deferred_request(struct unwind_work *work, u64 *cookie)
+{
+	struct unwind_task_info *info = &current->unwind_info;
+	int ret;
+
+	*cookie = 0;
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
+	*cookie = get_cookie(info);
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
@@ -74,4 +230,5 @@ void unwind_task_free(struct task_struct *task)
 	struct unwind_task_info *info = &task->unwind_info;
 
 	kfree(info->cache);
+	task_work_cancel(task, &info->work);
 }
-- 
2.47.2



