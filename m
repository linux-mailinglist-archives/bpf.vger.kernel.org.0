Return-Path: <bpf+bounces-58158-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D408AB5F87
	for <lists+bpf@lfdr.de>; Wed, 14 May 2025 00:36:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0082619E850E
	for <lists+bpf@lfdr.de>; Tue, 13 May 2025 22:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8A7D2206B2;
	Tue, 13 May 2025 22:35:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0C821CC6C;
	Tue, 13 May 2025 22:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747175727; cv=none; b=Z/qz3AxULFDOXOv7m5+Qfxy2WRC7QTioBnqqslrAcEr0hTASmg4hyLkBE5CZYR710qprYpL3Z+UTv2e5cwxocrMjq3kXxyPV2n8+kunx29WS+CCN14kDHmWtSlAGDPGYNkvS/tcWi1fFsDapzHx7FMpcVEmY2EXzJrgYBYOLrqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747175727; c=relaxed/simple;
	bh=LPJdAvV3vgiW3CunL+1Ufqd5avv0X4srOOM4scFLZac=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=W4HR9bH2cofhdQwQWXHg787Z7wTJUJIYxiFgvvfwEmChWqoYg4CqnX2dKrpVwHvuAwbAQIqHXHmjWav8WtI+xZrXyLPHsvBYPElh9xQTa1nYRpwTOQzEP93Q1Nh97dxMo+uhgYgLoGfrPdM4knROAA29SaIZezBLJCb+ywlgmc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6407FC4CEEB;
	Tue, 13 May 2025 22:35:27 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@goodmis.org>)
	id 1uEyE5-00000004sfZ-1EJW;
	Tue, 13 May 2025 18:35:53 -0400
Message-ID: <20250513223553.143567998@goodmis.org>
User-Agent: quilt/0.68
Date: Tue, 13 May 2025 18:34:48 -0400
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
 Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>,
 Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH v9 13/13] unwind: Clear unwind_mask on exit back to user space
References: <20250513223435.636200356@goodmis.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

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
 include/linux/unwind_deferred.h       | 23 ++++++-
 include/linux/unwind_deferred_types.h |  1 -
 kernel/unwind/deferred.c              | 96 +++++++++++++++++++--------
 3 files changed, 90 insertions(+), 30 deletions(-)

diff --git a/include/linux/unwind_deferred.h b/include/linux/unwind_deferred.h
index 1789c3624723..b3c8703fcc22 100644
--- a/include/linux/unwind_deferred.h
+++ b/include/linux/unwind_deferred.h
@@ -18,6 +18,14 @@ struct unwind_work {
 
 #ifdef CONFIG_UNWIND_USER
 
+#define UNWIND_PENDING_BIT	(BITS_PER_LONG - 1)
+#define UNWIND_PENDING		(1UL << UNWIND_PENDING_BIT)
+
+enum {
+	UNWIND_ALREADY_PENDING	= 1,
+	UNWIND_ALREADY_EXECUTED	= 2,
+};
+
 void unwind_task_init(struct task_struct *task);
 void unwind_task_free(struct task_struct *task);
 
@@ -29,7 +37,20 @@ void unwind_deferred_cancel(struct unwind_work *work);
 
 static __always_inline void unwind_exit_to_user_mode(void)
 {
-	if (unlikely(current->unwind_info.cache))
+	unsigned long bits;
+
+	/* Was there any unwinding? */
+	if (likely(!current->unwind_mask))
+		return;
+
+	bits = current->unwind_mask;
+	do {
+		/* Is a task_work going to run again before going back */
+		if (bits & UNWIND_PENDING)
+			return;
+	} while (!try_cmpxchg(&current->unwind_mask, &bits, 0UL));
+
+	if (likely(current->unwind_info.cache))
 		current->unwind_info.cache->nr_entries = 0;
 	current->unwind_info.timestamp = 0;
 }
diff --git a/include/linux/unwind_deferred_types.h b/include/linux/unwind_deferred_types.h
index ae27a02234b8..28811a9d4262 100644
--- a/include/linux/unwind_deferred_types.h
+++ b/include/linux/unwind_deferred_types.h
@@ -12,7 +12,6 @@ struct unwind_task_info {
 	struct callback_head	work;
 	u64			timestamp;
 	u64			nmi_timestamp;
-	int			pending;
 };
 
 #endif /* _LINUX_UNWIND_USER_DEFERRED_TYPES_H */
diff --git a/kernel/unwind/deferred.c b/kernel/unwind/deferred.c
index 5d6976ee648f..b0289a695b92 100644
--- a/kernel/unwind/deferred.c
+++ b/kernel/unwind/deferred.c
@@ -19,6 +19,11 @@ static LIST_HEAD(callbacks);
 static unsigned long unwind_mask;
 DEFINE_STATIC_SRCU(unwind_srcu);
 
+static inline bool unwind_pending(struct task_struct *task)
+{
+	return test_bit(UNWIND_PENDING_BIT, &task->unwind_mask);
+}
+
 /*
  * Read the task context timestamp, if this is the first caller then
  * it will set the timestamp.
@@ -107,15 +112,18 @@ static void unwind_deferred_task_work(struct callback_head *head)
 	struct unwind_task_info *info = container_of(head, struct unwind_task_info, work);
 	struct unwind_stacktrace trace;
 	struct unwind_work *work;
+	unsigned long bits;
 	u64 timestamp;
 	struct task_struct *task = current;
 	int idx;
 
-	if (WARN_ON_ONCE(!info->pending))
+	if (WARN_ON_ONCE(!unwind_pending(task)))
 		return;
 
-	/* Allow work to come in again */
-	WRITE_ONCE(info->pending, 0);
+	/* Clear pending bit but make sure to have the current bits */
+	bits = READ_ONCE(task->unwind_mask);
+	while (!try_cmpxchg(&task->unwind_mask, &bits, bits & ~UNWIND_PENDING_BIT))
+		;
 
 	/*
 	 * From here on out, the callback must always be called, even if it's
@@ -138,10 +146,8 @@ static void unwind_deferred_task_work(struct callback_head *head)
 	idx = srcu_read_lock(&unwind_srcu);
 	list_for_each_entry_srcu(work, &callbacks, list,
 				 srcu_read_lock_held(&unwind_srcu)) {
-		if (task->unwind_mask & (1UL << work->bit)) {
+		if (bits & (1UL << work->bit))
 			work->func(work, &trace, timestamp);
-			clear_bit(work->bit, &current->unwind_mask);
-		}
 	}
 	srcu_read_unlock(&unwind_srcu, idx);
 }
@@ -168,10 +174,13 @@ static int unwind_deferred_request_nmi(struct unwind_work *work, u64 *timestamp)
 		inited_timestamp = true;
 	}
 
-	if (current->unwind_mask & (1UL << work->bit))
-		return 1;
+	/* Is this already queued */
+	if (current->unwind_mask & (1UL << work->bit)) {
+		return unwind_pending(current) ? UNWIND_ALREADY_PENDING :
+			UNWIND_ALREADY_EXECUTED;
+	}
 
-	if (info->pending)
+	if (unwind_pending(current))
 		goto out;
 
 	ret = task_work_add(current, &info->work, TWA_NMI_CURRENT);
@@ -186,9 +195,17 @@ static int unwind_deferred_request_nmi(struct unwind_work *work, u64 *timestamp)
 		return ret;
 	}
 
-	info->pending = 1;
+	/*
+	 * This is the first to set the PENDING_BIT, clear all others
+	 * as any other bit has already had their callback called, and
+	 * those callbacks should not be called again because of this
+	 * new callback. If they request another callback, then they
+	 * will get a new one.
+	 */
+	current->unwind_mask = UNWIND_PENDING;
 out:
-	return test_and_set_bit(work->bit, &current->unwind_mask);
+	return test_and_set_bit(work->bit, &current->unwind_mask) ?
+		UNWIND_ALREADY_PENDING : 0;
 }
 
 /**
@@ -211,15 +228,17 @@ static int unwind_deferred_request_nmi(struct unwind_work *work, u64 *timestamp)
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
-	int pending;
+	unsigned long old, bits;
 	int bit;
 	int ret;
 
@@ -241,28 +260,49 @@ int unwind_deferred_request(struct unwind_work *work, u64 *timestamp)
 
 	*timestamp = get_timestamp(info);
 
-	/* This is already queued */
-	if (current->unwind_mask & (1UL << bit))
-		return 1;
+	old = READ_ONCE(current->unwind_mask);
+
+	/* Is this already queued */
+	if (old & (1UL << bit)) {
+		/*
+		 * If pending is not set, it means this work's callback
+		 * was already called.
+		 */
+		return old & UNWIND_PENDING ? UNWIND_ALREADY_PENDING :
+			UNWIND_ALREADY_EXECUTED;
+	}
 
-	/* callback already pending? */
-	pending = READ_ONCE(info->pending);
-	if (pending)
+	if (unwind_pending(current))
 		goto out;
 
-	/* Claim the work unless an NMI just now swooped in to do so. */
-	if (!try_cmpxchg(&info->pending, &pending, 1))
+	/*
+	 * This is the first to enable another task_work for this task since
+	 * the task entered the kernel, or had already called the callbacks.
+	 * Set only the bit for this work and clear all others as they have
+	 * already had their callbacks called, and do not need to call them
+	 * again because of this work.
+	 */
+	bits = UNWIND_PENDING | (1 << bit);
+
+	/*
+	 * If the cmpxchg() fails, it means that an NMI came in and set
+	 * the pending bit as well as cleared the other bits. Just
+	 * jump to setting the bit for this work.
+	 */
+	if (!try_cmpxchg(&current->unwind_mask, &old, bits))
 		goto out;
 
 	/* The work has been claimed, now schedule it. */
 	ret = task_work_add(current, &info->work, TWA_RESUME);
-	if (WARN_ON_ONCE(ret)) {
-		WRITE_ONCE(info->pending, 0);
-		return ret;
-	}
+
+	if (WARN_ON_ONCE(ret))
+		WRITE_ONCE(current->unwind_mask, 0);
+
+	return ret;
 
  out:
-	return test_and_set_bit(work->bit, &current->unwind_mask);
+	return test_and_set_bit(work->bit, &current->unwind_mask) ?
+		UNWIND_ALREADY_PENDING : 0;
 }
 
 void unwind_deferred_cancel(struct unwind_work *work)
@@ -298,7 +338,7 @@ int unwind_deferred_init(struct unwind_work *work, unwind_callback_t func)
 	guard(mutex)(&callback_mutex);
 
 	/* See if there's a bit in the mask available */
-	if (unwind_mask == ~0UL)
+	if (unwind_mask == ~(UNWIND_PENDING))
 		return -EBUSY;
 
 	work->bit = ffz(unwind_mask);
-- 
2.47.2



