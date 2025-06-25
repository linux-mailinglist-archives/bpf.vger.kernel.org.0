Return-Path: <bpf+bounces-61608-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E6A6AE9177
	for <lists+bpf@lfdr.de>; Thu, 26 Jun 2025 00:58:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65C1E6A255C
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 22:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 146292FBFFE;
	Wed, 25 Jun 2025 22:57:07 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A212F49FD;
	Wed, 25 Jun 2025 22:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750892226; cv=none; b=gdjZEAx8fZzdoDOfrnHJoEBu3CLiLdNqtkR20mH+/Yz7cBCjL8Re4vYn8mUnNsNfFBsr7E8CUQOmaFBMWg59qVH0yFMb1O+xVOAhcqX7s7vzvViauqslP3omAga0XGVXyYcELo9IzPLFpOaIGRTfgDiUCSFtCN8Px9Tm5YUfBbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750892226; c=relaxed/simple;
	bh=1Y4IAOUTPRTsZW6urVoPv/yNdvVuf+N0nb8UxGBBX2Q=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=AYPpRv7ycVWs9UI2p00SIWqFKANTuooArA42LrtLxjxtldzZO6aJXlidVxXTmYgHaZ64fAthKVTDikoXhVW6AuCb28hUVgtmWmhOWIJUlQk8PEKQoOSGqMl3cdxzv2Le+N7xMip3Z88Suhzj0RzZr+REltcao4ntsTdc047I+gU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf16.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id AC452C0498;
	Wed, 25 Jun 2025 22:56:54 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: nevets@goodmis.org) by omf16.hostedemail.com (Postfix) with ESMTPA id 5427320018;
	Wed, 25 Jun 2025 22:56:51 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@goodmis.org>)
	id 1uUZ3M-000000043hj-2kN6;
	Wed, 25 Jun 2025 18:57:16 -0400
Message-ID: <20250625225716.505389511@goodmis.org>
User-Agent: quilt/0.68
Date: Wed, 25 Jun 2025 18:56:10 -0400
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
Subject: [PATCH v11 10/14] unwind: Clear unwind_mask on exit back to user space
References: <20250625225600.555017347@goodmis.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Rspamd-Queue-Id: 5427320018
X-Stat-Signature: bgjewwh59r6rm8gwsbkhj76g6gyw4ehu
X-Rspamd-Server: rspamout06
X-Session-Marker: 6E657665747340676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/DMv5rcPN00XpSzE3e2moQFrenZwwYQWA=
X-HE-Tag: 1750892211-687868
X-HE-Meta: U2FsdGVkX19VwOaHMufbSgyQ4jt/oq9LEQ5vAWneiG1+emyTPK9za4HScjZGRvtKk2t71rzacCCMYQMpYq55WvFCtc1nHvial4NCB2/BeIPsS34r81XWmz1tePAN6BVwUv2T7Dli1NQ4kupSHeXSNV+RkLRlWE6urNZ/GejC301h+iiP4104ns8mGSlH5ITmzwTmMFC/l1tX02JdBdZxvczRbAGMaX6Y7hoh90+nNOgSVHvIB+Yh1CskvyUjRgIhEUpkALGJBYkxW2K7gfbzXxsXjpumslO18hJJkF2goY67AYfiq0Dux9Ag+HOZIM1nj7SREDBz4T6Sdin2Jrlj1UFIZJUgkUZ9iXomor1EL5a69PjkzCcL8zalOAEKA/DIDHYZLUhpjt8CwGSL1N8eMA==

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
 include/linux/unwind_deferred.h       | 26 +++++++--
 include/linux/unwind_deferred_types.h |  1 -
 kernel/unwind/deferred.c              | 76 ++++++++++++++++++---------
 3 files changed, 74 insertions(+), 29 deletions(-)

diff --git a/include/linux/unwind_deferred.h b/include/linux/unwind_deferred.h
index 00656e903375..97983a13ebde 100644
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
 
@@ -29,12 +37,22 @@ void unwind_deferred_cancel(struct unwind_work *work);
 
 static __always_inline void unwind_reset_info(void)
 {
-	/* Exit out early if this was never used */
-	if (likely(!local64_read(&current->unwind_info.timestamp)))
+	struct unwind_task_info *info = &current->unwind_info;
+	unsigned long bits;
+
+	/* Was there any unwinding? */
+	if (likely(!info->unwind_mask))
 		return;
 
-	if (current->unwind_info.cache)
-		current->unwind_info.cache->nr_entries = 0;
+	bits = info->unwind_mask;
+	do {
+		/* Is a task_work going to run again before going back */
+		if (bits & UNWIND_PENDING)
+			return;
+	} while (!try_cmpxchg(&info->unwind_mask, &bits, 0UL));
+
+	if (likely(info->cache))
+		info->cache->nr_entries = 0;
 	local64_set(&current->unwind_info.timestamp, 0);
 }
 
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



