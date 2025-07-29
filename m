Return-Path: <bpf+bounces-64651-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AE0AB152AB
	for <lists+bpf@lfdr.de>; Tue, 29 Jul 2025 20:24:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 368CA1886BED
	for <lists+bpf@lfdr.de>; Tue, 29 Jul 2025 18:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2065824C66F;
	Tue, 29 Jul 2025 18:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="csQGm8hO"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D46223C4FB;
	Tue, 29 Jul 2025 18:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753813431; cv=none; b=r1KXD2A1ShSSg1UpjS40O+UL6YT9JQfzlOejR6Ppimcv4myS9+O+uiTiUBXv+Y8CtloQ4MlxDEpZOtrgGoiCTUE2eu90VrzkhKOpeSzu1ADKn+S4Rvn5XAzOv3DNfKshoAUXa11dcL6PUXy8yPIhpkBScQPIxsYeippAXF9MzyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753813431; c=relaxed/simple;
	bh=HFeVDyR9JBBVbKhWWzJIJme4aJrJxG/IcKbvKHSIFDs=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=qc3SjP24cdk7moHHaSuZ2SpbkC6JfKclGukv4I7sPYpWXEufz8PlRhRe9iYW/3WvY/lyK/iXZcxE+UxXsmxgbipaY7UVecar4fh5w1nXZsh3wTG4x8IF0/bcuZ89bXY39blfPhEwb+APH5ny41nvdHRv8UrgUXXHFi+lbyvt72o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=csQGm8hO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33B9CC4AF0C;
	Tue, 29 Jul 2025 18:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753813431;
	bh=HFeVDyR9JBBVbKhWWzJIJme4aJrJxG/IcKbvKHSIFDs=;
	h=Date:From:To:Cc:Subject:References:From;
	b=csQGm8hOogEW+qb2floi+HgUkPM+KgI4BpzHToxOlJ0mZjdMJNNjiociwQ4AsciOT
	 VmSlrhfQ4opYYgBezJ82021wdUYMZQfMYmNSlSg3JknSngYBQBfNBgKh47f5ci1PMk
	 gYEJQMDpwfWZKmwSw7gLMJdLk5tfBhKBcNuBzA8nFPh9fyA33nkvGneR99aODYA1B3
	 50feFwdrrmJrITrjnYc3nT/TwhHkwotzKifv2MEz0E9Rpg4xPivGrAw+OF4SkQwhS3
	 irXFsq4yemRTMidAxML8D5c98Vk6LCS2IW20KGDZegBCxNiNbnosM3THr4eFtEpmp9
	 +lfGmQyMD9bOw==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1ugozd-0000000550u-44Ej;
	Tue, 29 Jul 2025 14:24:05 -0400
Message-ID: <20250729182405.822789300@kernel.org>
User-Agent: quilt/0.68
Date: Tue, 29 Jul 2025 14:23:10 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org
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
 Jens Axboe <axboe@kernel.dk>,
 Florian Weimer <fweimer@redhat.com>,
 Sam James <sam@gentoo.org>
Subject: [PATCH v16 06/10] unwind deferred: Use bitmask to determine which callbacks to call
References: <20250729182304.965835871@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

In order to know which registered callback requested a stacktrace for when
the task goes back to user space, add a bitmask to keep track of all
registered tracers. The bitmask is the size of long, which means that on a
32 bit machine, it can have at most 32 registered tracers, and on 64 bit,
it can have at most 64 registered tracers. This should not be an issue as
there should not be more than 10 (unless BPF can abuse this?).

When a tracer registers with unwind_deferred_init() it will get a bit
number assigned to it. When a tracer requests a stacktrace, it will have
its bit set within the task_struct. When the task returns back to user
space, it will call the callbacks for all the registered tracers where
their bits are set in the task's mask.

When a tracer is removed by the unwind_deferred_cancel() all current tasks
will clear the associated bit, just in case another tracer gets registered
immediately afterward and then gets their callback called unexpectedly.

To prevent live locks from happening if an event that happens between the
task_work and when the task goes back to user space, triggers the deferred
unwind, have the unwind_mask get cleared on exit to user space and not
after the callback is made.

Move the pending bit from a value on the task_struct to bit zero of the
unwind_mask (saves space on the task_struct). This will allow modifying
the pending bit along with the work bits atomically.

Instead of clearing a work's bit after its callback is called, it is
delayed until exit. If the work is requested again, the task_work is not
queued again and the request will be notified that the task has already been
called by returning a positive number (the same as if it was already
pending).

The pending bit is cleared before calling the callback functions but the
current work bits remain. If one of the called works registers again, it
will not trigger a task_work if its bit is still present in the task's
unwind_mask.

If a new work requests a deferred unwind, then it will set both the
pending bit and its own bit. Note this will also cause any work that was
previously queued and had their callback already executed to be executed
again. Future work will remove these spurious callbacks.

The use of atomic_long bit operations were suggested by Peter Zijlstra:
Link: https://lore.kernel.org/all/20250715102912.GQ1613200@noisy.programming.kicks-ass.net/
The unwind_mask could not be converted to atomic_long_t do to atomic_long
not having all the bit operations needed by unwind_mask. Instead it
follows other use cases in the kernel and just typecasts the unwind_mask
to atomic_long_t when using the two atomic_long functions.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/linux/unwind_deferred.h       | 26 +++++++-
 include/linux/unwind_deferred_types.h |  2 +-
 kernel/unwind/deferred.c              | 87 +++++++++++++++++++++------
 3 files changed, 92 insertions(+), 23 deletions(-)

diff --git a/include/linux/unwind_deferred.h b/include/linux/unwind_deferred.h
index 14efd8c027aa..337ead927d4d 100644
--- a/include/linux/unwind_deferred.h
+++ b/include/linux/unwind_deferred.h
@@ -13,10 +13,19 @@ typedef void (*unwind_callback_t)(struct unwind_work *work, struct unwind_stackt
 struct unwind_work {
 	struct list_head		list;
 	unwind_callback_t		func;
+	int				bit;
 };
 
 #ifdef CONFIG_UNWIND_USER
 
+enum {
+	UNWIND_PENDING_BIT = 0,
+};
+
+enum {
+	UNWIND_PENDING		= BIT(UNWIND_PENDING_BIT),
+};
+
 void unwind_task_init(struct task_struct *task);
 void unwind_task_free(struct task_struct *task);
 
@@ -28,15 +37,26 @@ void unwind_deferred_cancel(struct unwind_work *work);
 
 static __always_inline void unwind_reset_info(void)
 {
-	if (unlikely(current->unwind_info.id.id))
+	struct unwind_task_info *info = &current->unwind_info;
+	unsigned long bits;
+
+	/* Was there any unwinding? */
+	if (unlikely(info->unwind_mask)) {
+		bits = info->unwind_mask;
+		do {
+			/* Is a task_work going to run again before going back */
+			if (bits & UNWIND_PENDING)
+				return;
+		} while (!try_cmpxchg(&info->unwind_mask, &bits, 0UL));
 		current->unwind_info.id.id = 0;
+	}
 	/*
 	 * As unwind_user_faultable() can be called directly and
 	 * depends on nr_entries being cleared on exit to user,
 	 * this needs to be a separate conditional.
 	 */
-	if (unlikely(current->unwind_info.cache))
-		current->unwind_info.cache->nr_entries = 0;
+	if (unlikely(info->cache))
+		info->cache->nr_entries = 0;
 }
 
 #else /* !CONFIG_UNWIND_USER */
diff --git a/include/linux/unwind_deferred_types.h b/include/linux/unwind_deferred_types.h
index 104c477d5609..5dc9cda141ff 100644
--- a/include/linux/unwind_deferred_types.h
+++ b/include/linux/unwind_deferred_types.h
@@ -29,10 +29,10 @@ union unwind_task_id {
 };
 
 struct unwind_task_info {
+	unsigned long		unwind_mask;
 	struct unwind_cache	*cache;
 	struct callback_head	work;
 	union unwind_task_id	id;
-	int			pending;
 };
 
 #endif /* _LINUX_UNWIND_USER_DEFERRED_TYPES_H */
diff --git a/kernel/unwind/deferred.c b/kernel/unwind/deferred.c
index c5ac087d2396..e19f02ef416d 100644
--- a/kernel/unwind/deferred.c
+++ b/kernel/unwind/deferred.c
@@ -45,6 +45,16 @@ static inline bool try_assign_cnt(struct unwind_task_info *info, u32 cnt)
 static DEFINE_MUTEX(callback_mutex);
 static LIST_HEAD(callbacks);
 
+#define RESERVED_BITS	(UNWIND_PENDING)
+
+/* Zero'd bits are available for assigning callback users */
+static unsigned long unwind_mask = RESERVED_BITS;
+
+static inline bool unwind_pending(struct unwind_task_info *info)
+{
+	return test_bit(UNWIND_PENDING_BIT, &info->unwind_mask);
+}
+
 /*
  * This is a unique percpu identifier for a given task entry context.
  * Conceptually, it's incremented every time the CPU enters the kernel from
@@ -138,14 +148,15 @@ static void unwind_deferred_task_work(struct callback_head *head)
 	struct unwind_task_info *info = container_of(head, struct unwind_task_info, work);
 	struct unwind_stacktrace trace;
 	struct unwind_work *work;
+	unsigned long bits;
 	u64 cookie;
 
-	if (WARN_ON_ONCE(!info->pending))
+	if (WARN_ON_ONCE(!unwind_pending(info)))
 		return;
 
-	/* Allow work to come in again */
-	WRITE_ONCE(info->pending, 0);
-
+	/* Clear pending bit but make sure to have the current bits */
+	bits = atomic_long_fetch_andnot(UNWIND_PENDING,
+				  (atomic_long_t *)&info->unwind_mask);
 	/*
 	 * From here on out, the callback must always be called, even if it's
 	 * just an empty trace.
@@ -159,7 +170,8 @@ static void unwind_deferred_task_work(struct callback_head *head)
 
 	guard(mutex)(&callback_mutex);
 	list_for_each_entry(work, &callbacks, list) {
-		work->func(work, &trace, cookie);
+		if (test_bit(work->bit, &bits))
+			work->func(work, &trace, cookie);
 	}
 }
 
@@ -183,15 +195,16 @@ static void unwind_deferred_task_work(struct callback_head *head)
  * because it has already been previously called for the same entry context,
  * it will be called again with the same stack trace and cookie.
  *
- * Return: 1 if the the callback was already queued.
- *         0 if the callback successfully was queued.
+ * Return: 0 if the callback successfully was queued.
+ *         1 if the callback is pending or was already executed.
  *         Negative if there's an error.
  *         @cookie holds the cookie of the first request by any user
  */
 int unwind_deferred_request(struct unwind_work *work, u64 *cookie)
 {
 	struct unwind_task_info *info = &current->unwind_info;
-	long pending;
+	unsigned long old, bits;
+	unsigned long bit = BIT(work->bit);
 	int ret;
 
 	*cookie = 0;
@@ -212,32 +225,59 @@ int unwind_deferred_request(struct unwind_work *work, u64 *cookie)
 
 	*cookie = get_cookie(info);
 
-	/* callback already pending? */
-	pending = READ_ONCE(info->pending);
-	if (pending)
-		return 1;
+	old = READ_ONCE(info->unwind_mask);
 
-	/* Claim the work unless an NMI just now swooped in to do so. */
-	if (!try_cmpxchg(&info->pending, &pending, 1))
+	/* Is this already queued or executed */
+	if (old & bit)
 		return 1;
 
+	/*
+	 * This work's bit hasn't been set yet. Now set it with the PENDING
+	 * bit and fetch the current value of unwind_mask. If ether the
+	 * work's bit or PENDING was already set, then this is already queued
+	 * to have a callback.
+	 */
+	bits = UNWIND_PENDING | bit;
+	old = atomic_long_fetch_or(bits, (atomic_long_t *)&info->unwind_mask);
+	if (old & bits) {
+		/*
+		 * If the work's bit was set, whatever set it had better
+		 * have also set pending and queued a callback.
+		 */
+		WARN_ON_ONCE(!(old & UNWIND_PENDING));
+		return old & bit;
+	}
+
 	/* The work has been claimed, now schedule it. */
 	ret = task_work_add(current, &info->work, TWA_RESUME);
-	if (WARN_ON_ONCE(ret)) {
-		WRITE_ONCE(info->pending, 0);
-		return ret;
-	}
 
-	return 0;
+	if (WARN_ON_ONCE(ret))
+		WRITE_ONCE(info->unwind_mask, 0);
+
+	return ret;
 }
 
 void unwind_deferred_cancel(struct unwind_work *work)
 {
+	struct task_struct *g, *t;
+
 	if (!work)
 		return;
 
+	/* No work should be using a reserved bit */
+	if (WARN_ON_ONCE(BIT(work->bit) & RESERVED_BITS))
+		return;
+
 	guard(mutex)(&callback_mutex);
 	list_del(&work->list);
+
+	__clear_bit(work->bit, &unwind_mask);
+
+	guard(rcu)();
+	/* Clear this bit from all threads */
+	for_each_process_thread(g, t) {
+		clear_bit(work->bit, &t->unwind_info.unwind_mask);
+	}
 }
 
 int unwind_deferred_init(struct unwind_work *work, unwind_callback_t func)
@@ -245,6 +285,14 @@ int unwind_deferred_init(struct unwind_work *work, unwind_callback_t func)
 	memset(work, 0, sizeof(*work));
 
 	guard(mutex)(&callback_mutex);
+
+	/* See if there's a bit in the mask available */
+	if (unwind_mask == ~0UL)
+		return -EBUSY;
+
+	work->bit = ffz(unwind_mask);
+	__set_bit(work->bit, &unwind_mask);
+
 	list_add(&work->list, &callbacks);
 	work->func = func;
 	return 0;
@@ -256,6 +304,7 @@ void unwind_task_init(struct task_struct *task)
 
 	memset(info, 0, sizeof(*info));
 	init_task_work(&info->work, unwind_deferred_task_work);
+	info->unwind_mask = 0;
 }
 
 void unwind_task_free(struct task_struct *task)
-- 
2.47.2



