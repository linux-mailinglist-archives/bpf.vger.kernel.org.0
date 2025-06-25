Return-Path: <bpf+bounces-61603-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A169AE916E
	for <lists+bpf@lfdr.de>; Thu, 26 Jun 2025 00:57:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 958C94A7859
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 22:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A75A2F949D;
	Wed, 25 Jun 2025 22:57:06 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30A92F49E3;
	Wed, 25 Jun 2025 22:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750892225; cv=none; b=N0BsDT/EmaVxNGMrYH1s4XfjJmMiLteLCisHrBEdXOoeqrTjGkMCloogSg5L7QfO47UilwuIv0RoO0VtWzeb/jRuYXloQsmWa1GbYkmn2X1vfILmXaMB+8YngG9xIfix9SezK5EQ8W4k0Ra+Gig7wBSdGg0MNqOBQEJaABlZAaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750892225; c=relaxed/simple;
	bh=nYCNLIg1KRntUpgdqK18VcHOHOZYxatVKh1vAncVTdQ=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=VvTfkpXBb/weVF5NYdV7EQ1ibH3G9m6nw/PO4Vf68E3UpFCw/aICyiiv4hJ/FSAJG/oTSPg4gtHSeMIy9ykswK0nsPddao0BZQky8uxNxAD1AlI4fMX0WIKbRyJ4UV/xgyWqJNjE+pGdg+NBrIzo3yGlDwLAmNwSAQIxqPwrlZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf16.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id 3B0E31607A7;
	Wed, 25 Jun 2025 22:56:54 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: nevets@goodmis.org) by omf16.hostedemail.com (Postfix) with ESMTPA id EEAD320016;
	Wed, 25 Jun 2025 22:56:50 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@goodmis.org>)
	id 1uUZ3M-000000043gH-0d3e;
	Wed, 25 Jun 2025 18:57:16 -0400
Message-ID: <20250625225716.004109448@goodmis.org>
User-Agent: quilt/0.68
Date: Wed, 25 Jun 2025 18:56:07 -0400
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
Subject: [PATCH v11 07/14] unwind_user/deferred: Make unwind deferral requests NMI-safe
References: <20250625225600.555017347@goodmis.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Rspamd-Queue-Id: EEAD320016
X-Stat-Signature: frkkoexfjaia1s81fnex9umzf33qieyf
X-Rspamd-Server: rspamout06
X-Session-Marker: 6E657665747340676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19dcg96G3ZyymYWhYgW84cFvU9PReOWxoQ=
X-HE-Tag: 1750892210-536468
X-HE-Meta: U2FsdGVkX18AaT7amwqkanTaRw0qkfnKWvaBRWWXywqTD1UfXIRP9d8dtVev+Ads6Jt1ApvOB+mEQWkeSTMD5GhdYB6uovDJfT46CcYvmxGW2OjcBgqnIyb/i3yJiW8d3UHL7eZFHUnm1d+5XbpMMQp3PN3yVQ5b/N2+JEtJWfhY12/Rm6lBBQ74Z/ftU2BAMrBCfWDVmKOjOoyC9Y/oilQPBY6u5cIVvT15u36Yum9tANdnGrDqykbL8cFXQWUJ9qqxuY0mFJTpmzx3GpkB5m98Znp2iRjAcxI7RjfJVdp4O1oIEc9j1OSucBKLKNAj2FBm+zgPtOIVqyGLrcR8cZp/cvima+qVPfRAJrVU3ZzIueGGx6TFcmwAi+q2h4Jrahf+TDdNfpNEPZJ0e6/94cZr4dQzD4Ywdoe4nGkvmtm8zILBsoWji8NiSA1kZHXSuxBUiDM87ayHTpsggZRGexkR/fLSlKa0G1v+n8ddNsg=

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
Changse since v10: https://lore.kernel.org/20250611010428.938845449@goodmis.org

- Reworked to simply use a 64bit cmpxchg to update the timestamp.

- Removed Josh Poimboeuf's authorship as the commit is completely
  rewritten.

- Switch timestamp to local64_t type and pending to local_t type.

 include/linux/unwind_deferred.h       |  4 +-
 include/linux/unwind_deferred_types.h |  7 ++-
 kernel/unwind/deferred.c              | 74 ++++++++++++++++++++++-----
 3 files changed, 69 insertions(+), 16 deletions(-)

diff --git a/include/linux/unwind_deferred.h b/include/linux/unwind_deferred.h
index 26011b413142..718637777649 100644
--- a/include/linux/unwind_deferred.h
+++ b/include/linux/unwind_deferred.h
@@ -29,12 +29,12 @@ void unwind_deferred_cancel(struct unwind_work *work);
 static __always_inline void unwind_reset_info(void)
 {
 	/* Exit out early if this was never used */
-	if (likely(!current->unwind_info.timestamp))
+	if (likely(!local64_read(&current->unwind_info.timestamp)))
 		return;
 
 	if (current->unwind_info.cache)
 		current->unwind_info.cache->nr_entries = 0;
-	current->unwind_info.timestamp = 0;
+	local64_set(&current->unwind_info.timestamp, 0);
 }
 
 #else /* !CONFIG_UNWIND_USER */
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



