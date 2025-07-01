Return-Path: <bpf+bounces-61912-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95FDDAEEB68
	for <lists+bpf@lfdr.de>; Tue,  1 Jul 2025 02:55:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C3C0440497
	for <lists+bpf@lfdr.de>; Tue,  1 Jul 2025 00:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FAC219D8A2;
	Tue,  1 Jul 2025 00:54:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE9382899;
	Tue,  1 Jul 2025 00:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751331264; cv=none; b=m4oUAknd/cKSch7l+xUt8Wh95raODJHD4lSzNwGGvcnIZdFwXgbODnz/XLeLnN/IIfJKw6a63+yzzGh6GGCDJF4StjkP2+jumRzZME1ZSN27BcjtXIL648V1nISEtWinH+MQt8jwL6dU98CSIPQ/rMgyPg0Nzq8BjinILLYBSgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751331264; c=relaxed/simple;
	bh=8DwPUDxFGeovN8J1sg9//CEOBf440LfymehMpAW0Y4Y=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=ZsSUxWjZygegmpbaWDYbP3mHAoiF+zJEcTP53cqN6DyVPxpk9itBijd/xMfyOXfbFtx8ULreWB1L3+Eq+90aU+tG7DuUTAUq31dSY35q00gQnWcDVYurj/Yqz+G/triYHDpeTm8OtxQaUcGJ7Ud9efwTHSodMH3kmsysUvhUpRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf15.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id 1D98E80204;
	Tue,  1 Jul 2025 00:54:18 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: nevets@goodmis.org) by omf15.hostedemail.com (Postfix) with ESMTPA id 9048818;
	Tue,  1 Jul 2025 00:54:15 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@goodmis.org>)
	id 1uWPGu-00000007NjA-1dLi;
	Mon, 30 Jun 2025 20:54:52 -0400
Message-ID: <20250701005452.242933931@goodmis.org>
User-Agent: quilt/0.68
Date: Mon, 30 Jun 2025 20:53:31 -0400
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
Subject: [PATCH v12 10/14] unwind: Clear unwind_mask on exit back to user space
References: <20250701005321.942306427@goodmis.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Rspamd-Queue-Id: 9048818
X-Stat-Signature: xrfpg6zdcem1eqoio3yf8r5u36eexcu3
X-Rspamd-Server: rspamout06
X-Session-Marker: 6E657665747340676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX186K+NrTq+59RsrITaxZ8jpzL89X/lJ4m8=
X-HE-Tag: 1751331255-189999
X-HE-Meta: U2FsdGVkX1/bRHk4tKjHKexecRm3lzIqZW6cmW6JzvhZ1WqRLfjfE8n3sXFfeLTMUfeTUIx22pPtqc0w/9Z/ndGnGK/kUaCuY9xm5pozbWOgV8JZmz3bOpBYyUwd6CTlGXEp74QuDKdcDGz4v2Nc7V1qwsfC3Lh6aJsTTiCCjOpVJ2dArZJY8eORohsB9Yw6voekXY7idrpUTPKnjRbLKSS7tlq5RbU+NtVUJvIb7joLOI4s1WQyUflxvWGUk68W1+7kxScRuOftnMrZm64VZy+woA80QcwN15bh776Ld510GGT7Pq6q+SydubnNskXuUvw3kBg2x+tR8zo0HiPJM+/MwiRo8Egbi3MQFjpbMB+bNJ16BC01YHGgoLDp2tgDYgLhDHUSM7ZFZk7yMAqMR9UPEhM3aBzp9Nc9SP64cf4=

From: Steven Rostedt <rostedt@goodmis.org>

When testing the deferred unwinder by attaching deferred user space
stacktraces to events, a live lock happened. This was when the deferred
unwinding was added to the irqs_disabled event, which happens after the
task_work callbacks are called and before the task goes back to user
space.

The event callback would be registered when irqs were disabled, the
task_work would trigger, call the callback for this work and clear the
work's bit. Then before getting back to user space, irqs would be disabled
again, the event triggered again, and a new task_work registered. This
caused an infinite loop and the system hung.

To prevent this, clear the bits at the very last moment before going back
to user space and when instrumentation is disabled. That is in
unwind_exit_to_user_mode().

Move the pending bit from a value on the task_struct to the most
significant bit of the unwind_mask (saves space on the task_struct). This
will allow modifying the pending bit along with the work bits atomically.

Instead of clearing a work's bit after its callback is called, it is
delayed until exit. If the work is requested again, the task_work is not
queued again and the work will be notified that the task has already been
called (via UNWIND_ALREADY_EXECUTED return value).

The pending bit is cleared before calling the callback functions but the
current work bits remain. If one of the called works registers again, it
will not trigger a task_work if its bit is still present in the task's
unwind_mask.

If a new work registers, then it will set both the pending bit and its own
bit but clear the other work bits so that their callbacks do not get
called again.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
Changes since v11: https://lore.kernel.org/20250625225716.505389511@goodmis.org

- Still clear info->cache->nr_entries in unwind_reset_info()
  If unwind_user_faultable() is called directly (like perf will do)
  it still needs to clear the nr_entries as calling the function
  directly does not set the bit.

  Later code will change this so it has only one conditional to check
  when not enabled.

 include/linux/unwind_deferred.h       | 25 +++++++--
 include/linux/unwind_deferred_types.h |  1 -
 kernel/unwind/deferred.c              | 76 ++++++++++++++++++---------
 3 files changed, 74 insertions(+), 28 deletions(-)

diff --git a/include/linux/unwind_deferred.h b/include/linux/unwind_deferred.h
index 538b4b7968dc..d25a72fb21ef 100644
--- a/include/linux/unwind_deferred.h
+++ b/include/linux/unwind_deferred.h
@@ -18,6 +18,14 @@ struct unwind_work {
 
 #ifdef CONFIG_UNWIND_USER
 
+#define UNWIND_PENDING_BIT	(BITS_PER_LONG - 1)
+#define UNWIND_PENDING		BIT(UNWIND_PENDING_BIT)
+
+enum {
+	UNWIND_ALREADY_PENDING	= 1,
+	UNWIND_ALREADY_EXECUTED	= 2,
+};
+
 void unwind_task_init(struct task_struct *task);
 void unwind_task_free(struct task_struct *task);
 
@@ -29,15 +37,26 @@ void unwind_deferred_cancel(struct unwind_work *work);
 
 static __always_inline void unwind_reset_info(void)
 {
-	if (unlikely(local64_read(&current->unwind_info.timestamp)))
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
 		local64_set(&current->unwind_info.timestamp, 0);
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
index 5863bf4eb436..4308367f1887 100644
--- a/include/linux/unwind_deferred_types.h
+++ b/include/linux/unwind_deferred_types.h
@@ -15,7 +15,6 @@ struct unwind_task_info {
 	struct callback_head	work;
 	unsigned long		unwind_mask;
 	local64_t		timestamp;
-	local_t			pending;
 };
 
 #endif /* _LINUX_UNWIND_USER_DEFERRED_TYPES_H */
diff --git a/kernel/unwind/deferred.c b/kernel/unwind/deferred.c
index 7309c9e0e57a..e7e4442926d3 100644
--- a/kernel/unwind/deferred.c
+++ b/kernel/unwind/deferred.c
@@ -51,6 +51,11 @@ static LIST_HEAD(callbacks);
 static unsigned long unwind_mask;
 DEFINE_STATIC_SRCU(unwind_srcu);
 
+static inline bool unwind_pending(struct unwind_task_info *info)
+{
+	return test_bit(UNWIND_PENDING_BIT, &info->unwind_mask);
+}
+
 /*
  * Read the task context timestamp, if this is the first caller then
  * it will set the timestamp.
@@ -134,14 +139,17 @@ static void unwind_deferred_task_work(struct callback_head *head)
 	struct unwind_task_info *info = container_of(head, struct unwind_task_info, work);
 	struct unwind_stacktrace trace;
 	struct unwind_work *work;
+	unsigned long bits;
 	u64 timestamp;
 	int idx;
 
-	if (WARN_ON_ONCE(!local_read(&info->pending)))
+	if (WARN_ON_ONCE(!unwind_pending(info)))
 		return;
 
-	/* Allow work to come in again */
-	local_set(&info->pending, 0);
+	/* Clear pending bit but make sure to have the current bits */
+	bits = READ_ONCE(info->unwind_mask);
+	while (!try_cmpxchg(&info->unwind_mask, &bits, bits & ~UNWIND_PENDING))
+		;
 
 	/*
 	 * From here on out, the callback must always be called, even if it's
@@ -157,10 +165,8 @@ static void unwind_deferred_task_work(struct callback_head *head)
 	idx = srcu_read_lock(&unwind_srcu);
 	list_for_each_entry_srcu(work, &callbacks, list,
 				 srcu_read_lock_held(&unwind_srcu)) {
-		if (test_bit(work->bit, &info->unwind_mask)) {
+		if (test_bit(work->bit, &bits))
 			work->func(work, &trace, timestamp);
-			clear_bit(work->bit, &info->unwind_mask);
-		}
 	}
 	srcu_read_unlock(&unwind_srcu, idx);
 }
@@ -188,15 +194,17 @@ static void unwind_deferred_task_work(struct callback_head *head)
  * it has already been previously called for the same entry context, it will be
  * called again with the same stack trace and timestamp.
  *
- * Return: 1 if the the callback was already queued.
- *         0 if the callback successfully was queued.
+ * Return: 0 if the callback successfully was queued.
+ *         UNWIND_ALREADY_PENDING if the the callback was already queued.
+ *         UNWIND_ALREADY_EXECUTED if the callback was already called
+ *                (and will not be called again)
  *         Negative if there's an error.
  *         @timestamp holds the timestamp of the first request by any user
  */
 int unwind_deferred_request(struct unwind_work *work, u64 *timestamp)
 {
 	struct unwind_task_info *info = &current->unwind_info;
-	long pending;
+	unsigned long old, bits;
 	int bit;
 	int ret;
 
@@ -219,32 +227,52 @@ int unwind_deferred_request(struct unwind_work *work, u64 *timestamp)
 
 	*timestamp = get_timestamp(info);
 
-	/* This is already queued */
-	if (test_bit(bit, &info->unwind_mask))
-		return 1;
+	old = READ_ONCE(info->unwind_mask);
+
+	/* Is this already queued */
+	if (test_bit(bit, &old)) {
+		/*
+		 * If pending is not set, it means this work's callback
+		 * was already called.
+		 */
+		return old & UNWIND_PENDING ? UNWIND_ALREADY_PENDING :
+			UNWIND_ALREADY_EXECUTED;
+	}
 
-	/* callback already pending? */
-	pending = local_read(&info->pending);
-	if (pending)
+	if (unwind_pending(info))
 		goto out;
 
+	/*
+	 * This is the first to enable another task_work for this task since
+	 * the task entered the kernel, or had already called the callbacks.
+	 * Set only the bit for this work and clear all others as they have
+	 * already had their callbacks called, and do not need to call them
+	 * again because of this work.
+	 */
+	bits = UNWIND_PENDING | BIT(bit);
+
+	/*
+	 * If the cmpxchg() fails, it means that an NMI came in and set
+	 * the pending bit as well as cleared the other bits. Just
+	 * jump to setting the bit for this work.
+	 */
 	if (CAN_USE_IN_NMI) {
-		/* Claim the work unless an NMI just now swooped in to do so. */
-		if (!local_try_cmpxchg(&info->pending, &pending, 1))
+		if (!try_cmpxchg(&info->unwind_mask, &old, bits))
 			goto out;
 	} else {
-		local_set(&info->pending, 1);
+		info->unwind_mask = bits;
 	}
 
 	/* The work has been claimed, now schedule it. */
 	ret = task_work_add(current, &info->work, TWA_RESUME);
-	if (WARN_ON_ONCE(ret)) {
-		local_set(&info->pending, 0);
-		return ret;
-	}
 
+	if (WARN_ON_ONCE(ret))
+		WRITE_ONCE(info->unwind_mask, 0);
+
+	return ret;
  out:
-	return test_and_set_bit(bit, &info->unwind_mask);
+	return test_and_set_bit(bit, &info->unwind_mask) ?
+		UNWIND_ALREADY_PENDING : 0;
 }
 
 void unwind_deferred_cancel(struct unwind_work *work)
@@ -280,7 +308,7 @@ int unwind_deferred_init(struct unwind_work *work, unwind_callback_t func)
 	guard(mutex)(&callback_mutex);
 
 	/* See if there's a bit in the mask available */
-	if (unwind_mask == ~0UL)
+	if (unwind_mask == ~(UNWIND_PENDING))
 		return -EBUSY;
 
 	work->bit = ffz(unwind_mask);
-- 
2.47.2



