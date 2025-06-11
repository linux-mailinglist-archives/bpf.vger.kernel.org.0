Return-Path: <bpf+bounces-60278-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E360FAD47BC
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 03:07:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FDBA1892D8A
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 01:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62EA02A1CA;
	Wed, 11 Jun 2025 01:03:12 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB2D198A08;
	Wed, 11 Jun 2025 01:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749603792; cv=none; b=UeDNlH5I6c/XR8urFN+38vZHibgzPMXY79slz92S/m+XQhoJeWvTVRP8jxk4uLjAT3ltrltNn3Rg65y9R7/CeARBRmP7nabskXbLL9ITCS8L7b9D1EfiLdWKwi5UCsZBGriym9UsQjXGbiBrUk3MXkE7zUIqc8iLzmkOsHxFB+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749603792; c=relaxed/simple;
	bh=GqYTdIEKm0sSSny/CHrTeTKB9ADfwQz0Zv9+GC/L6wY=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=CQSPZQ9SBQ+FdhTomgNuMGYaKyTUEAlU2z+Z3piYqs9BE+hrhnCDBXYL3KT7xQI98fbsoy42VZNqIEOW9rrUvDlLvR8G6BxIw/sQyKBg5NWBkGCBbQSkwhkXE7prLSHD90s7OEkHw893UL1htR0DQIK/H3vdSORBDIZAgogyy04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf08.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id 92048161486;
	Wed, 11 Jun 2025 01:03:00 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: nevets@goodmis.org) by omf08.hostedemail.com (Postfix) with ESMTPA id 9D5B420026;
	Wed, 11 Jun 2025 01:02:57 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@goodmis.org>)
	id 1uP9tF-00000000vC9-2UdM;
	Tue, 10 Jun 2025 21:04:29 -0400
Message-ID: <20250611010429.444947502@goodmis.org>
User-Agent: quilt/0.68
Date: Tue, 10 Jun 2025 20:54:31 -0400
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
 Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v10 10/14] unwind: Clear unwind_mask on exit back to user space
References: <20250611005421.144238328@goodmis.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Rspamd-Queue-Id: 9D5B420026
X-Stat-Signature: fg59oueh9bbmdcgywstxwezj68kq6z7k
X-Rspamd-Server: rspamout06
X-Session-Marker: 6E657665747340676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19kkvNLFKGIvqZQFuAGv+HHUsJ3D+QpOYI=
X-HE-Tag: 1749603777-955215
X-HE-Meta: U2FsdGVkX19GyhXXr3bC7pMGje2l1+7iPJbbwKBw+mPbi8+R6BRNZtIseVl9+aEc1oGa9viHoSn4/OEYYIZ6HFHUWO93eLlXozVXjncfrVTErRQGP9DIFlSEhA2Fx+3R/hJADXJyO5lo8EkLQqveErYEtpgS/3DvfKlH2El+Z2jlZKagjivGmKnmwq5L+Zoh1QPsxJI6ydIWxfiBi8Kf3HjH8hyjRRTiQ/KEivkfFjoTSe27meWFgI8ew9Jpc8xAXJ0DyNxMYAZ584oB2sfoy+COm00wr2QC/E7F8leXhALhK7rKO/r2iz7wTbj+FjWTvk4rmcyPjSjOa+T+nNqMc971keP8D0q7aHCDq1fiGuqoMNClRFPnV9ed9mS/nn0zITiD/ydzOmWbVNX4VlP4j4EwNI+bzCvVrE7qLhkF3J8=

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
Changes since v9: https://lore.kernel.org/all/20250513223553.143567998@goodmis.org/

- Fix compare with ~UNWIND_PENDING_BIT to be ~UNWIND_PENDING

- Use BIT() macro for bit setting and testing

 include/linux/unwind_deferred.h       | 28 +++++++-
 include/linux/unwind_deferred_types.h |  1 -
 kernel/unwind/deferred.c              | 96 +++++++++++++++++++--------
 3 files changed, 93 insertions(+), 32 deletions(-)

diff --git a/include/linux/unwind_deferred.h b/include/linux/unwind_deferred.h
index 1789c3624723..426e21457606 100644
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
 
@@ -29,9 +37,23 @@ void unwind_deferred_cancel(struct unwind_work *work);
 
 static __always_inline void unwind_exit_to_user_mode(void)
 {
-	if (unlikely(current->unwind_info.cache))
-		current->unwind_info.cache->nr_entries = 0;
-	current->unwind_info.timestamp = 0;
+	struct unwind_task_info *info = &current->unwind_info;
+	unsigned long bits;
+
+	/* Was there any unwinding? */
+	if (likely(!info->unwind_mask))
+		return;
+
+	bits = info->unwind_mask;
+	do {
+		/* Is a task_work going to run again before going back */
+		if (bits & UNWIND_PENDING)
+			return;
+	} while (!try_cmpxchg(&info->unwind_mask, &bits, 0UL));
+
+	if (likely(info->cache))
+		info->cache->nr_entries = 0;
+	info->timestamp = 0;
 }
 
 #else /* !CONFIG_UNWIND_USER */
diff --git a/include/linux/unwind_deferred_types.h b/include/linux/unwind_deferred_types.h
index 780b00c07208..f384e7f45783 100644
--- a/include/linux/unwind_deferred_types.h
+++ b/include/linux/unwind_deferred_types.h
@@ -13,7 +13,6 @@ struct unwind_task_info {
 	unsigned long		unwind_mask;
 	u64			timestamp;
 	u64			nmi_timestamp;
-	int			pending;
 };
 
 #endif /* _LINUX_UNWIND_USER_DEFERRED_TYPES_H */
diff --git a/kernel/unwind/deferred.c b/kernel/unwind/deferred.c
index e44538a2be6c..8a6caaae04d3 100644
--- a/kernel/unwind/deferred.c
+++ b/kernel/unwind/deferred.c
@@ -19,6 +19,11 @@ static LIST_HEAD(callbacks);
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
@@ -107,14 +112,17 @@ static void unwind_deferred_task_work(struct callback_head *head)
 	struct unwind_task_info *info = container_of(head, struct unwind_task_info, work);
 	struct unwind_stacktrace trace;
 	struct unwind_work *work;
+	unsigned long bits;
 	u64 timestamp;
 	int idx;
 
-	if (WARN_ON_ONCE(!info->pending))
+	if (WARN_ON_ONCE(!unwind_pending(info)))
 		return;
 
-	/* Allow work to come in again */
-	WRITE_ONCE(info->pending, 0);
+	/* Clear pending bit but make sure to have the current bits */
+	bits = READ_ONCE(info->unwind_mask);
+	while (!try_cmpxchg(&info->unwind_mask, &bits, bits & ~UNWIND_PENDING))
+		;
 
 	/*
 	 * From here on out, the callback must always be called, even if it's
@@ -137,10 +145,8 @@ static void unwind_deferred_task_work(struct callback_head *head)
 	idx = srcu_read_lock(&unwind_srcu);
 	list_for_each_entry_srcu(work, &callbacks, list,
 				 srcu_read_lock_held(&unwind_srcu)) {
-		if (info->unwind_mask & BIT(work->bit)) {
+		if (bits & BIT(work->bit))
 			work->func(work, &trace, timestamp);
-			clear_bit(work->bit, &info->unwind_mask);
-		}
 	}
 	srcu_read_unlock(&unwind_srcu, idx);
 }
@@ -167,10 +173,13 @@ static int unwind_deferred_request_nmi(struct unwind_work *work, u64 *timestamp)
 		inited_timestamp = true;
 	}
 
-	if (info->unwind_mask & BIT(work->bit))
-		return 1;
+	/* Is this already queued */
+	if (info->unwind_mask & BIT(work->bit)) {
+		return unwind_pending(info) ? UNWIND_ALREADY_PENDING :
+			UNWIND_ALREADY_EXECUTED;
+	}
 
-	if (info->pending)
+	if (unwind_pending(info))
 		goto out;
 
 	ret = task_work_add(current, &info->work, TWA_NMI_CURRENT);
@@ -185,9 +194,17 @@ static int unwind_deferred_request_nmi(struct unwind_work *work, u64 *timestamp)
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
+	info->unwind_mask = UNWIND_PENDING;
 out:
-	return test_and_set_bit(work->bit, &info->unwind_mask);
+	return test_and_set_bit(work->bit, &info->unwind_mask) ?
+		UNWIND_ALREADY_PENDING : 0;
 }
 
 /**
@@ -210,15 +227,17 @@ static int unwind_deferred_request_nmi(struct unwind_work *work, u64 *timestamp)
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
 
@@ -240,28 +259,49 @@ int unwind_deferred_request(struct unwind_work *work, u64 *timestamp)
 
 	*timestamp = get_timestamp(info);
 
-	/* This is already queued */
-	if (info->unwind_mask & BIT(bit))
-		return 1;
+	old = READ_ONCE(info->unwind_mask);
+
+	/* Is this already queued */
+	if (old & BIT(bit)) {
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
+	if (unwind_pending(info))
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
+	bits = UNWIND_PENDING | BIT(bit);
+
+	/*
+	 * If the cmpxchg() fails, it means that an NMI came in and set
+	 * the pending bit as well as cleared the other bits. Just
+	 * jump to setting the bit for this work.
+	 */
+	if (!try_cmpxchg(&info->unwind_mask, &old, bits))
 		goto out;
 
 	/* The work has been claimed, now schedule it. */
 	ret = task_work_add(current, &info->work, TWA_RESUME);
-	if (WARN_ON_ONCE(ret)) {
-		WRITE_ONCE(info->pending, 0);
-		return ret;
-	}
+
+	if (WARN_ON_ONCE(ret))
+		WRITE_ONCE(info->unwind_mask, 0);
+
+	return ret;
 
  out:
-	return test_and_set_bit(work->bit, &info->unwind_mask);
+	return test_and_set_bit(work->bit, &info->unwind_mask) ?
+		UNWIND_ALREADY_PENDING : 0;
 }
 
 void unwind_deferred_cancel(struct unwind_work *work)
@@ -297,7 +337,7 @@ int unwind_deferred_init(struct unwind_work *work, unwind_callback_t func)
 	guard(mutex)(&callback_mutex);
 
 	/* See if there's a bit in the mask available */
-	if (unwind_mask == ~0UL)
+	if (unwind_mask == ~(UNWIND_PENDING))
 		return -EBUSY;
 
 	work->bit = ffz(unwind_mask);
-- 
2.47.2



