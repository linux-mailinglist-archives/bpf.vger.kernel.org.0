Return-Path: <bpf+bounces-64403-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E203FB12480
	for <lists+bpf@lfdr.de>; Fri, 25 Jul 2025 20:58:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5374FAE1F41
	for <lists+bpf@lfdr.de>; Fri, 25 Jul 2025 18:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CE2525BF00;
	Fri, 25 Jul 2025 18:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GNQ+ve4Z"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8232A25A2AA;
	Fri, 25 Jul 2025 18:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753469854; cv=none; b=U8hM91ak5CeFRquDLI/rrdedMdRUOTpER/59hWhoCbOx65kxYP1LYeJjCwgTZkQPIZtszGbCl/ns5A+jJhiIxXD7e0D8MisBD0W1t22UelsLtmaRRwCmtGo60oajGkLh27Tbrm6ju62HkILlzGQTZVC1bxOX00Yuvp+zchdVGuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753469854; c=relaxed/simple;
	bh=axx8cAZE1UNuBrcLl+MLx4cug9SsQWJxXwkKQ1emt00=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=Nv0qTUO3IW9ecL7nXAcfXAMd1TX1dP0u07eEiP23HrhKdY0mq+gs/jem26Wv8a2AjTpleo4JKV27tJTVbGiepnDRV1J9ehwtHGBh1PvKLBdkXlwzoNg9ba11rJ8hfafr+HiiR/5rgJpmRKj8Gj+x70dl/MDWqKT6SJ/DA7tUJRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GNQ+ve4Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1915CC4AF11;
	Fri, 25 Jul 2025 18:57:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753469854;
	bh=axx8cAZE1UNuBrcLl+MLx4cug9SsQWJxXwkKQ1emt00=;
	h=Date:From:To:Cc:Subject:References:From;
	b=GNQ+ve4ZNJndmXegGUZ0pHyWbbzeV46TLr9+t0xbVeEME1XLFZhemRxk+oDR6XlX7
	 XMvRnyFxxTcyY6OnRPMGR2jCxicpISGJSWc623p1JFFX6d97TTA/Ge3ckoMNoqIyCF
	 fYb8ZumQphFOs33LJ11ISvKvwICtuXZWux4V8TGvUjonxoccKgmU7rqvymMmnHy1lw
	 Qrhqyojxy4QxpIowYvOljW/PuLIW+fZyIFyJhHNL/Gw5l6m2T3boO4wacMck2IZws0
	 4BvuWlOuC2RVBwyGQs5RfvxtXgaz7Tqwb5C1N01dEII784kPwNMdcO443vxCST5suS
	 k5KvBk+Nwe7vg==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1ufNbw-00000001N5S-0EVc;
	Fri, 25 Jul 2025 14:57:40 -0400
Message-ID: <20250725185739.906767342@kernel.org>
User-Agent: quilt/0.68
Date: Fri, 25 Jul 2025 14:55:17 -0400
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
Subject: [PATCH v15 05/10] unwind_user/deferred: Make unwind deferral requests NMI-safe
References: <20250725185512.673587297@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

Make unwind_deferred_request() NMI-safe so tracers in NMI context can
call it and safely request a user space stacktrace when the task exits.

Note, this is only allowed for architectures that implement a safe
cmpxchg. If an architecture requests a deferred stack trace from NMI
context that does not support a safe NMI cmpxchg, it will get an -EINVAL
and trigger a warning. For those architectures, they would need another
method (perhaps an irqwork), to request a deferred user space stack trace.
That can be dealt with later if one of theses architectures require this
feature.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/unwind/deferred.c | 52 +++++++++++++++++++++++++++++++++-------
 1 file changed, 44 insertions(+), 8 deletions(-)

diff --git a/kernel/unwind/deferred.c b/kernel/unwind/deferred.c
index 2cbae2ada309..c5ac087d2396 100644
--- a/kernel/unwind/deferred.c
+++ b/kernel/unwind/deferred.c
@@ -12,6 +12,31 @@
 #include <linux/slab.h>
 #include <linux/mm.h>
 
+/*
+ * For requesting a deferred user space stack trace from NMI context
+ * the architecture must support a safe cmpxchg in NMI context.
+ * For those architectures that do not have that, then it cannot ask
+ * for a deferred user space stack trace from an NMI context. If it
+ * does, then it will get -EINVAL.
+ */
+#if defined(CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG)
+# define CAN_USE_IN_NMI		1
+static inline bool try_assign_cnt(struct unwind_task_info *info, u32 cnt)
+{
+	u32 old = 0;
+
+	return try_cmpxchg(&info->id.cnt, &old, cnt);
+}
+#else
+# define CAN_USE_IN_NMI		0
+/* When NMIs are not allowed, this always succeeds */
+static inline bool try_assign_cnt(struct unwind_task_info *info, u32 cnt)
+{
+	info->id.cnt = cnt;
+	return true;
+}
+#endif
+
 /* Make the cache fit in a 4K page */
 #define UNWIND_MAX_ENTRIES					\
 	((SZ_4K - sizeof(struct unwind_cache)) / sizeof(long))
@@ -42,14 +67,13 @@ static DEFINE_PER_CPU(u32, unwind_ctx_ctr);
 static u64 get_cookie(struct unwind_task_info *info)
 {
 	u32 cnt = 1;
-	u32 old = 0;
 
 	if (info->id.cpu)
 		return info->id.id;
 
 	/* LSB is always set to ensure 0 is an invalid value */
 	cnt |= __this_cpu_read(unwind_ctx_ctr) + 2;
-	if (try_cmpxchg(&info->id.cnt, &old, cnt)) {
+	if (try_assign_cnt(info, cnt)) {
 		/* Update the per cpu counter */
 		__this_cpu_write(unwind_ctx_ctr, cnt);
 	}
@@ -167,31 +191,43 @@ static void unwind_deferred_task_work(struct callback_head *head)
 int unwind_deferred_request(struct unwind_work *work, u64 *cookie)
 {
 	struct unwind_task_info *info = &current->unwind_info;
+	long pending;
 	int ret;
 
 	*cookie = 0;
 
-	if (WARN_ON_ONCE(in_nmi()))
-		return -EINVAL;
-
 	if ((current->flags & (PF_KTHREAD | PF_EXITING)) ||
 	    !user_mode(task_pt_regs(current)))
 		return -EINVAL;
 
+	/*
+	 * NMI requires having safe cmpxchg operations.
+	 * Trigger a warning to make it obvious that an architecture
+	 * is using this in NMI when it should not be.
+	 */
+	if (WARN_ON_ONCE(!CAN_USE_IN_NMI && in_nmi()))
+		return -EINVAL;
+
 	guard(irqsave)();
 
 	*cookie = get_cookie(info);
 
 	/* callback already pending? */
-	if (info->pending)
+	pending = READ_ONCE(info->pending);
+	if (pending)
+		return 1;
+
+	/* Claim the work unless an NMI just now swooped in to do so. */
+	if (!try_cmpxchg(&info->pending, &pending, 1))
 		return 1;
 
 	/* The work has been claimed, now schedule it. */
 	ret = task_work_add(current, &info->work, TWA_RESUME);
-	if (WARN_ON_ONCE(ret))
+	if (WARN_ON_ONCE(ret)) {
+		WRITE_ONCE(info->pending, 0);
 		return ret;
+	}
 
-	info->pending = 1;
 	return 0;
 }
 
-- 
2.47.2



