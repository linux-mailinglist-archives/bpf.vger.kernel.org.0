Return-Path: <bpf+bounces-62595-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13CC0AFBFDE
	for <lists+bpf@lfdr.de>; Tue,  8 Jul 2025 03:24:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4606E4A36AB
	for <lists+bpf@lfdr.de>; Tue,  8 Jul 2025 01:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0543222154F;
	Tue,  8 Jul 2025 01:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dZ+DM3QR"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7037921883F;
	Tue,  8 Jul 2025 01:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751937839; cv=none; b=TfmuXDN80sghdZ2HEBc3BA8xlshcW/xPaWPPHnHfu8GvOwuFQkeMLBEZ8aFKjOkgi55DxoOmWMf5MyJf94bKY+XpnOVbqnlI0chConQeNaYvRJ8Pd/koIgK+8JWcq1F9ahB+DEDxi+yYVLULJRE6Q7l0T/HPq2/2T3ghDbYnz9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751937839; c=relaxed/simple;
	bh=I4Lv6KjOHCwzaJFkkDd/S0x5we6FReZBQbJgHE2LzPg=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=ZeYtdC5DfpnMbS68vPduD+R8MU60S6oNMMooszl4r3/qeMpra978iHhNVFZECFuedACmEwYNBWyS1VGlWFaEcAMtd6ZJH3Av0StDYFex+v5mTVljQInB44XawkVJqVQ1SFk4HXB04Gnjpf2wVJGBXD+3/h1A27BXjvBe88foM3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dZ+DM3QR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D999C4CEF7;
	Tue,  8 Jul 2025 01:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751937839;
	bh=I4Lv6KjOHCwzaJFkkDd/S0x5we6FReZBQbJgHE2LzPg=;
	h=Date:From:To:Cc:Subject:References:From;
	b=dZ+DM3QR5KwnFgrC6SKF84Su1Qndhzttsdj5F/xvjicbxKb30WOHpt2ijjF639ZqE
	 dTBYxLtKofW4Sj2zRRJ4Vro42IFm8UH/6rPv+YuvhpPXx+clqROpfcoUbAg4jlY2ai
	 DlXE6riNAHOxIK6eT0Y5frOEAcbUX8Hnl2XQXX6RwpxXqnkHcqZEDsL/e5lSKVaRjH
	 1o+3LuLDQ/7s9c4GVAsx7zTytnYtPiE/UQGUHakkxpfm56BsqUXWWySdxuKsdhfKI8
	 wVvYi0t6IeBNW4Dt74gch2ysIXvFxGXxAxgiMDhPYVwOe9GrbN7y8zEBM06YabK1Ot
	 UtlnimzaSOJaw==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1uYx3v-00000000Btw-253w;
	Mon, 07 Jul 2025 21:23:59 -0400
Message-ID: <20250708012359.345060579@kernel.org>
User-Agent: quilt/0.68
Date: Mon, 07 Jul 2025 21:22:49 -0400
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
Subject: [PATCH v13 10/14] unwind: Clear unwind_mask on exit back to user space
References: <20250708012239.268642741@kernel.org>
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
Changes since v12: https://lore.kernel.org/20250701005452.242933931@goodmis.org

- Removed no longer used local.h headers from unwind_deferred_types.h

 include/linux/unwind_deferred.h       | 25 +++++++--
 include/linux/unwind_deferred_types.h |  3 --
 kernel/unwind/deferred.c              | 76 ++++++++++++++++++---------
 3 files changed, 74 insertions(+), 30 deletions(-)

diff --git a/include/linux/unwind_deferred.h b/include/linux/unwind_deferred.h
index 12bffdb0648e..587e120c0fd6 100644
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
index 7a03a8672b0d..db6c65daf185 100644
--- a/include/linux/unwind_deferred_types.h
+++ b/include/linux/unwind_deferred_types.h
@@ -2,8 +2,6 @@
 #ifndef _LINUX_UNWIND_USER_DEFERRED_TYPES_H
 #define _LINUX_UNWIND_USER_DEFERRED_TYPES_H
 
-#include <asm/local.h>
-
 struct unwind_cache {
 	unsigned int		nr_entries;
 	unsigned long		entries[];
@@ -23,7 +21,6 @@ struct unwind_task_info {
 	struct callback_head	work;
 	unsigned long		unwind_mask;
 	union unwind_task_id	id;
-	local_t			pending;
 };
 
 #endif /* _LINUX_UNWIND_USER_DEFERRED_TYPES_H */
diff --git a/kernel/unwind/deferred.c b/kernel/unwind/deferred.c
index 9aed9866f460..256458f3eafe 100644
--- a/kernel/unwind/deferred.c
+++ b/kernel/unwind/deferred.c
@@ -47,6 +47,11 @@ static LIST_HEAD(callbacks);
 static unsigned long unwind_mask;
 DEFINE_STATIC_SRCU(unwind_srcu);
 
+static inline bool unwind_pending(struct unwind_task_info *info)
+{
+	return test_bit(UNWIND_PENDING_BIT, &info->unwind_mask);
+}
+
 /*
  * This is a unique percpu identifier for a given task entry context.
  * Conceptually, it's incremented every time the CPU enters the kernel from
@@ -143,14 +148,17 @@ static void unwind_deferred_task_work(struct callback_head *head)
 	struct unwind_task_info *info = container_of(head, struct unwind_task_info, work);
 	struct unwind_stacktrace trace;
 	struct unwind_work *work;
+	unsigned long bits;
 	u64 cookie;
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
@@ -166,10 +174,8 @@ static void unwind_deferred_task_work(struct callback_head *head)
 	idx = srcu_read_lock(&unwind_srcu);
 	list_for_each_entry_srcu(work, &callbacks, list,
 				 srcu_read_lock_held(&unwind_srcu)) {
-		if (test_bit(work->bit, &info->unwind_mask)) {
+		if (test_bit(work->bit, &bits))
 			work->func(work, &trace, cookie);
-			clear_bit(work->bit, &info->unwind_mask);
-		}
 	}
 	srcu_read_unlock(&unwind_srcu, idx);
 }
@@ -194,15 +200,17 @@ static void unwind_deferred_task_work(struct callback_head *head)
  * because it has already been previously called for the same entry context,
  * it will be called again with the same stack trace and cookie.
  *
- * Return: 1 if the the callback was already queued.
- *         0 if the callback successfully was queued.
+ * Return: 0 if the callback successfully was queued.
+ *         UNWIND_ALREADY_PENDING if the the callback was already queued.
+ *         UNWIND_ALREADY_EXECUTED if the callback was already called
+ *                (and will not be called again)
  *         Negative if there's an error.
  *         @cookie holds the cookie of the first request by any user
  */
 int unwind_deferred_request(struct unwind_work *work, u64 *cookie)
 {
 	struct unwind_task_info *info = &current->unwind_info;
-	long pending;
+	unsigned long old, bits;
 	int bit;
 	int ret;
 
@@ -225,32 +233,52 @@ int unwind_deferred_request(struct unwind_work *work, u64 *cookie)
 
 	*cookie = get_cookie(info);
 
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
@@ -286,7 +314,7 @@ int unwind_deferred_init(struct unwind_work *work, unwind_callback_t func)
 	guard(mutex)(&callback_mutex);
 
 	/* See if there's a bit in the mask available */
-	if (unwind_mask == ~0UL)
+	if (unwind_mask == ~(UNWIND_PENDING))
 		return -EBUSY;
 
 	work->bit = ffz(unwind_mask);
-- 
2.47.2



