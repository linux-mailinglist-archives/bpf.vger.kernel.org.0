Return-Path: <bpf+bounces-61915-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4BC8AEEB6E
	for <lists+bpf@lfdr.de>; Tue,  1 Jul 2025 02:55:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEE05440463
	for <lists+bpf@lfdr.de>; Tue,  1 Jul 2025 00:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 990B01D54C2;
	Tue,  1 Jul 2025 00:54:25 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CBEB16F0FE;
	Tue,  1 Jul 2025 00:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751331265; cv=none; b=Ce666ndAG2ckKhDQ3bVJPx54b9WgiYG96kRPcdH4A2q6DFXof3wo+FiQWK5w/FRcuT1EOFs+ipF3YQEqp3qfWGSFmP0dX0U1zGFrqNBHMavjO6zXy+8PHVdw3ueJWBwGsoIupc0bDh2c1z0kvE1sfxGDgQA1dWPHvMJ5cfQVRts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751331265; c=relaxed/simple;
	bh=1wS6lakLpdteLnsr88ulp7l7j3pQT8qjs+yZVHKMq4U=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=ETzQPeJyxxqAxWo7aKSyfXDFM/Zy8lrJ5PecVNE50R2fyjn5oNUbBAx5epqi+YP02QKNwwcEuFI3RJlboJ17U6BMO9YaXo/wCHBfeAC48qUizF/CLf2X9PAaS8liJt6QnHi23lHHUKbCkuMb0h3mnKDQd7/RcdH7Z4jDJ43XRqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf10.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id A7A1E1A01FD;
	Tue,  1 Jul 2025 00:54:18 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: nevets@goodmis.org) by omf10.hostedemail.com (Postfix) with ESMTPA id 1B48332;
	Tue,  1 Jul 2025 00:54:15 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@goodmis.org>)
	id 1uWPGt-00000007Nhh-3iMF;
	Mon, 30 Jun 2025 20:54:51 -0400
Message-ID: <20250701005451.737614486@goodmis.org>
User-Agent: quilt/0.68
Date: Mon, 30 Jun 2025 20:53:28 -0400
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
Subject: [PATCH v12 07/14] unwind_user/deferred: Make unwind deferral requests NMI-safe
References: <20250701005321.942306427@goodmis.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Stat-Signature: 7z9e4fs7ybwjdnz9x7y9zk9wnq3aw1y7
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 1B48332
X-Session-Marker: 6E657665747340676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+gF0XbNysM/GqWHbUi2JRP7t9ZL6/Vm78=
X-HE-Tag: 1751331255-438644
X-HE-Meta: U2FsdGVkX1/xLg5aS2WODqWxEAGHGdPtWfOluZKKdNvKKS7qO0N90CsoaNDWcX4eq1Wi5fFRzH0MvdMbhJCOo3IZY2eKNFj9HRnwByQ9fpR7O3gu2wrCPErGMAWuvHEH1uPb5wvBpdHgeB1jgV5pyMryzDktJ7tWZ7riCob61CFt0n2zthIsL9KAhgFpTVNmjCd5YGtJxSoMFjBo7M3U+ivtI21L6WFq16ykq8mDiTUuH5X99rJIhKpss9N813nX1OSW5dUld1LmJNQcCddadbD/qQXfKb+9uSKlJzA9xk6innXRwmjej4vJWYY8l9Uu1uSPt6UGgSN1zUVWrhxa2MtljipiBR6NyPzwkHl21zJUxCnJf3/vG4zE8qBGfcvd/LeY6a9kNPI8+27AizX82lMKfd6+hlQoJXqY4mnAigRo+na9z8VLTUtzBMSPM66hr+Xk/bHH2eFCBni3+JXtTg==

From: Steven Rostedt <rostedt@goodmis.org>

Make unwind_deferred_request() NMI-safe so tracers in NMI context can
call it and safely request a user space stacktrace when the task exits.

Note, this is only allowed for architectures that implement a safe 64 bit
cmpxchg. Which rules out some 32bit architectures and even some 64 bit
ones.  If an architecture requests a deferred stack trace from NMI context
that does not support a safe NMI 64 bit cmpxchg, it will get an -EINVAL.
For those architectures, they would need another method (perhaps an
irqwork), to request a deferred user space stack trace. That can be dealt
with later if one of theses architectures require this feature.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/linux/unwind_deferred.h       |  4 +-
 include/linux/unwind_deferred_types.h |  7 ++-
 kernel/unwind/deferred.c              | 74 ++++++++++++++++++++++-----
 3 files changed, 69 insertions(+), 16 deletions(-)

diff --git a/include/linux/unwind_deferred.h b/include/linux/unwind_deferred.h
index c6548e8d64d1..73f6cac53530 100644
--- a/include/linux/unwind_deferred.h
+++ b/include/linux/unwind_deferred.h
@@ -28,8 +28,8 @@ void unwind_deferred_cancel(struct unwind_work *work);
 
 static __always_inline void unwind_reset_info(void)
 {
-	if (unlikely(current->unwind_info.timestamp))
-		current->unwind_info.timestamp = 0;
+	if (unlikely(local64_read(&current->unwind_info.timestamp)))
+		local64_set(&current->unwind_info.timestamp, 0);
 	/*
 	 * As unwind_user_faultable() can be called directly and
 	 * depends on nr_entries being cleared on exit to user,
diff --git a/include/linux/unwind_deferred_types.h b/include/linux/unwind_deferred_types.h
index 5df264cf81ad..0d722e877473 100644
--- a/include/linux/unwind_deferred_types.h
+++ b/include/linux/unwind_deferred_types.h
@@ -2,6 +2,9 @@
 #ifndef _LINUX_UNWIND_USER_DEFERRED_TYPES_H
 #define _LINUX_UNWIND_USER_DEFERRED_TYPES_H
 
+#include <asm/local64.h>
+#include <asm/local.h>
+
 struct unwind_cache {
 	unsigned int		nr_entries;
 	unsigned long		entries[];
@@ -10,8 +13,8 @@ struct unwind_cache {
 struct unwind_task_info {
 	struct unwind_cache	*cache;
 	struct callback_head	work;
-	u64			timestamp;
-	int			pending;
+	local64_t		timestamp;
+	local_t			pending;
 };
 
 #endif /* _LINUX_UNWIND_USER_DEFERRED_TYPES_H */
diff --git a/kernel/unwind/deferred.c b/kernel/unwind/deferred.c
index d5f2c004a5b0..dd36e58c8cad 100644
--- a/kernel/unwind/deferred.c
+++ b/kernel/unwind/deferred.c
@@ -12,6 +12,35 @@
 #include <linux/slab.h>
 #include <linux/mm.h>
 
+/*
+ * For requesting a deferred user space stack trace from NMI context
+ * the architecture must support a 64bit safe cmpxchg in NMI context.
+ * For those architectures that do not have that, then it cannot ask
+ * for a deferred user space stack trace from an NMI context. If it
+ * does, then it will get -EINVAL.
+ */
+#if defined(CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG) && \
+	!defined(CONFIG_GENERIC_ATOMIC64)
+# define CAN_USE_IN_NMI		1
+static inline u64 assign_timestamp(struct unwind_task_info *info,
+				   u64 timestamp)
+{
+	u64 old = 0;
+	if (!local64_try_cmpxchg(&info->timestamp, &old, timestamp))
+		timestamp = old;
+	return timestamp;
+}
+#else
+# define CAN_USE_IN_NMI		0
+static inline u64 assign_timestamp(struct unwind_task_info *info,
+				   u64 timestamp)
+{
+	/* For archs that do not allow NMI here */
+	local64_set(&info->timestamp, timestamp);
+	return timestamp;
+}
+#endif
+
 /* Make the cache fit in a 4K page */
 #define UNWIND_MAX_ENTRIES					\
 	((SZ_4K - sizeof(struct unwind_cache)) / sizeof(long))
@@ -31,12 +60,21 @@ static LIST_HEAD(callbacks);
  */
 static u64 get_timestamp(struct unwind_task_info *info)
 {
+	u64 timestamp;
+
 	lockdep_assert_irqs_disabled();
 
-	if (!info->timestamp)
-		info->timestamp = local_clock();
+	/*
+	 * Note, the timestamp is generated on the first request.
+	 * If it exists here, then the timestamp is earlier than
+	 * this request and it means that this request will be
+	 * valid for the stracktrace.
+	 */
+	timestamp = local64_read(&info->timestamp);
+	if (timestamp)
+		return timestamp;
 
-	return info->timestamp;
+	return assign_timestamp(info, local_clock());
 }
 
 /**
@@ -96,11 +134,11 @@ static void unwind_deferred_task_work(struct callback_head *head)
 	struct unwind_work *work;
 	u64 timestamp;
 
-	if (WARN_ON_ONCE(!info->pending))
+	if (WARN_ON_ONCE(!local_read(&info->pending)))
 		return;
 
 	/* Allow work to come in again */
-	WRITE_ONCE(info->pending, 0);
+	local_set(&info->pending, 0);
 
 	/*
 	 * From here on out, the callback must always be called, even if it's
@@ -111,7 +149,7 @@ static void unwind_deferred_task_work(struct callback_head *head)
 
 	unwind_user_faultable(&trace);
 
-	timestamp = info->timestamp;
+	timestamp = local64_read(&info->timestamp);
 
 	guard(mutex)(&callback_mutex);
 	list_for_each_entry(work, &callbacks, list) {
@@ -150,31 +188,43 @@ static void unwind_deferred_task_work(struct callback_head *head)
 int unwind_deferred_request(struct unwind_work *work, u64 *timestamp)
 {
 	struct unwind_task_info *info = &current->unwind_info;
+	long pending;
 	int ret;
 
 	*timestamp = 0;
 
-	if (WARN_ON_ONCE(in_nmi()))
-		return -EINVAL;
-
 	if ((current->flags & (PF_KTHREAD | PF_EXITING)) ||
 	    !user_mode(task_pt_regs(current)))
 		return -EINVAL;
 
+	/* NMI requires having safe 64 bit cmpxchg operations */
+	if (!CAN_USE_IN_NMI && in_nmi())
+		return -EINVAL;
+
 	guard(irqsave)();
 
 	*timestamp = get_timestamp(info);
 
 	/* callback already pending? */
-	if (info->pending)
+	pending = local_read(&info->pending);
+	if (pending)
 		return 1;
 
+	if (CAN_USE_IN_NMI) {
+		/* Claim the work unless an NMI just now swooped in to do so. */
+		if (!local_try_cmpxchg(&info->pending, &pending, 1))
+			return 1;
+	} else {
+		local_set(&info->pending, 1);
+	}
+
 	/* The work has been claimed, now schedule it. */
 	ret = task_work_add(current, &info->work, TWA_RESUME);
-	if (WARN_ON_ONCE(ret))
+	if (WARN_ON_ONCE(ret)) {
+		local_set(&info->pending, 0);
 		return ret;
+	}
 
-	info->pending = 1;
 	return 0;
 }
 
-- 
2.47.2



