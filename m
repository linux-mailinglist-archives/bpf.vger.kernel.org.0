Return-Path: <bpf+bounces-70542-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6233BC2C4C
	for <lists+bpf@lfdr.de>; Tue, 07 Oct 2025 23:39:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B9473E1CBE
	for <lists+bpf@lfdr.de>; Tue,  7 Oct 2025 21:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8894A2586C5;
	Tue,  7 Oct 2025 21:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sj0VhK6J"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8002550AF;
	Tue,  7 Oct 2025 21:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759873172; cv=none; b=LQzfWapsKyFiorNQLLIrf5Nlc6kL6AWY6GqMWELdM75Qg2Jk0nVJISf/7hOLNFFE7tntZUi1hZFdWoxGbAmQZM732B3gpHmK/UdC+uIhRKGIg2FUgbZY7kTA+gsLp+rlwbIRxnBPLg/5bL/0iyihMxDeJ2Giw7niYHSFDg7s6Fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759873172; c=relaxed/simple;
	bh=VcLags0CJY4WAx/UAO0GeWwJ+C1iWDfDYb8zS+Ww8eE=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=UO5RUOLlpScAW++eYl3RRtzSbEqcLDOP8S5ejIKghkpJRi3vbP4bDkNQ/RPDh6aTIqca0IlmuP04OSm5VDplu+ALxweADUbcE0YW+lwha6sOhZCFDKybJok/tTOZmyeZsVFcTvE3vX9NAxl3+Lyn7c7wF5dPDidUUCMj19cBh1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sj0VhK6J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9158EC4AF10;
	Tue,  7 Oct 2025 21:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759873171;
	bh=VcLags0CJY4WAx/UAO0GeWwJ+C1iWDfDYb8zS+Ww8eE=;
	h=Date:From:To:Cc:Subject:References:From;
	b=Sj0VhK6JcX5HmJh8mbjjgpnqoP3EJYs9UPCtiODpUmj/7PhlPOXmdQG4a8kIn/UHm
	 5eL03fB4fVSI/T86EuFoRHPeAtz3KRfSEiyQJedlIRgkD0uZ7dEzI+cmy5ThH8RYbX
	 vQy/6fe9YxVVIeqqAq+E45iOpxOYeodXjnjorhOf/HG3AC5BkqY7Lt5eB4OIzvuw7e
	 FrLtU92G6IgD9r86Dthj1teio8dd005ExnwPdGVl/Jlyyy/rSYwd8l/GgzCV8uInq0
	 rF5lDIIPOpMTxDrWtGv4p2hOSkf27QK4vq9GXMJwCHwyR0BMOoCaGsCKmfrBpiXgin
	 2YaJ3FfzlFvvw==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1v6FQy-00000007Xgh-05Jg;
	Tue, 07 Oct 2025 17:41:24 -0400
Message-ID: <20251007214123.872765932@kernel.org>
User-Agent: quilt/0.68
Date: Tue, 07 Oct 2025 17:40:11 -0400
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
 Florian Weimer <fweimer@redhat.com>,
 Sam James <sam@gentoo.org>,
 Kees Cook <kees@kernel.org>,
 "Carlos O'Donell" <codonell@redhat.com>
Subject: [PATCH v16 3/4] perf: Have the deferred request record the user context cookie
References: <20251007214008.080852573@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

When a request to have a deferred unwind is made, have the cookie
associated to the user context recorded in the event that represents that
request. It is added after the PERF_CONTEXT_USER_DEFERRED in the
callchain. That perf context is a marker of where to add the associated
user space stack trace in the callchain. Adding the cookie after that
marker will not affect the appending of the callchain as it will be
overwritten by the user space stack in the perf tool.

The cookie will be used to match the cookie that is saved when the
deferred callchain is recorded. The perf tool will be able to use the
cooking saved at the request to know if the callchain that was recorded
when the task goes back to user space is for that event. If there were
dropped events after the request was made where it dropped the calltrace
that happened when the task went back to user space and then came back
into the kernel and a new request was dropped, but then the record started
again and it recorded a new callchain going back to user space, this
callchain would not be for the initial request. The cookie matching will
prevent this scenario from happening.

The cookie prevents:

  record kernel stack trace with PERF_CONTEXT_USER_DEFERRED

  [ dropped events starts here ]

  record user stack trace - DROPPED

  [enters user space ]
  [exits user space back to the kernel ]

  record kernel stack trace with PERF_CONTEXT_USER_DEFERRED - DROPPED!

  [ events stop being dropped here ]

  record user stack trace

Without a differentiating "cookie" identifier, the user space tool will
incorrectly attach the last recorded user stack trace to the first kernel
stack trace with the PERF_CONTEXT_USER_DEFERRED, as using the TID is not
enough to identify this situation.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/linux/perf_event.h            |  2 +-
 include/uapi/linux/perf_event.h       |  5 +++++
 kernel/bpf/stackmap.c                 |  4 ++--
 kernel/events/callchain.c             |  9 ++++++---
 kernel/events/core.c                  | 12 ++++++------
 tools/include/uapi/linux/perf_event.h |  5 +++++
 6 files changed, 25 insertions(+), 12 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 152e3dacff98..a0f95f751b44 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1723,7 +1723,7 @@ extern void perf_callchain_user(struct perf_callchain_entry_ctx *entry, struct p
 extern void perf_callchain_kernel(struct perf_callchain_entry_ctx *entry, struct pt_regs *regs);
 extern struct perf_callchain_entry *
 get_perf_callchain(struct pt_regs *regs, bool kernel, bool user,
-		   u32 max_stack, bool crosstask, bool add_mark, bool defer_user);
+		   u32 max_stack, bool crosstask, bool add_mark, u64 defer_cookie);
 extern int get_callchain_buffers(int max_stack);
 extern void put_callchain_buffers(void);
 extern struct perf_callchain_entry *get_callchain_entry(int *rctx);
diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index 20b8f890113b..79232e85a8fc 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -1282,6 +1282,11 @@ enum perf_bpf_event_type {
 #define PERF_MAX_STACK_DEPTH			127
 #define PERF_MAX_CONTEXTS_PER_STACK		  8
 
+/*
+ * The PERF_CONTEXT_USER_DEFERRED has two items (context and cookie)
+ */
+#define PERF_DEFERRED_ITEMS			2
+
 enum perf_callchain_context {
 	PERF_CONTEXT_HV				= (__u64)-32,
 	PERF_CONTEXT_KERNEL			= (__u64)-128,
diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index 339f7cbbcf36..ef6021111fe3 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -315,7 +315,7 @@ BPF_CALL_3(bpf_get_stackid, struct pt_regs *, regs, struct bpf_map *, map,
 		max_depth = sysctl_perf_event_max_stack;
 
 	trace = get_perf_callchain(regs, kernel, user, max_depth,
-				   false, false, false);
+				   false, false, 0);
 
 	if (unlikely(!trace))
 		/* couldn't fetch the stack trace */
@@ -452,7 +452,7 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
 		trace = get_callchain_entry_for_task(task, max_depth);
 	else
 		trace = get_perf_callchain(regs, kernel, user, max_depth,
-					   crosstask, false, false);
+					   crosstask, false, 0);
 
 	if (unlikely(!trace) || trace->nr < skip) {
 		if (may_fault)
diff --git a/kernel/events/callchain.c b/kernel/events/callchain.c
index d0e0da66a164..b9c7e00725d6 100644
--- a/kernel/events/callchain.c
+++ b/kernel/events/callchain.c
@@ -218,7 +218,7 @@ static void fixup_uretprobe_trampoline_entries(struct perf_callchain_entry *entr
 
 struct perf_callchain_entry *
 get_perf_callchain(struct pt_regs *regs, bool kernel, bool user,
-		   u32 max_stack, bool crosstask, bool add_mark, bool defer_user)
+		   u32 max_stack, bool crosstask, bool add_mark, u64 defer_cookie)
 {
 	struct perf_callchain_entry *entry;
 	struct perf_callchain_entry_ctx ctx;
@@ -251,12 +251,15 @@ get_perf_callchain(struct pt_regs *regs, bool kernel, bool user,
 			regs = task_pt_regs(current);
 		}
 
-		if (defer_user) {
+		if (defer_cookie) {
 			/*
 			 * Foretell the coming of PERF_RECORD_CALLCHAIN_DEFERRED
-			 * which can be stitched to this one.
+			 * which can be stitched to this one, and add
+			 * the cookie after it (it will be cut off when the
+			 * user stack is copied to the callchain).
 			 */
 			perf_callchain_store_context(&ctx, PERF_CONTEXT_USER_DEFERRED);
+			perf_callchain_store_context(&ctx, defer_cookie);
 			goto exit_put;
 		}
 
diff --git a/kernel/events/core.c b/kernel/events/core.c
index be94b437e7e0..f003a1f9497a 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -8262,10 +8262,9 @@ static struct perf_callchain_entry __empty_callchain = { .nr = 0, };
  *      0 : if it performed the queuing
  *    < 0 : if it did not get queued.
  */
-static int deferred_request(struct perf_event *event)
+static int deferred_request(struct perf_event *event, u64 *defer_cookie)
 {
 	struct unwind_work *work = &event->unwind_work;
-	u64 cookie;
 
 	/* Only defer for task events */
 	if (!event->ctx->task)
@@ -8275,7 +8274,7 @@ static int deferred_request(struct perf_event *event)
 	    !user_mode(task_pt_regs(current)))
 		return -EINVAL;
 
-	return unwind_deferred_request(work, &cookie);
+	return unwind_deferred_request(work, defer_cookie);
 }
 
 struct perf_callchain_entry *
@@ -8288,6 +8287,7 @@ perf_callchain(struct perf_event *event, struct pt_regs *regs)
 	bool crosstask = event->ctx->task && event->ctx->task != current;
 	const u32 max_stack = event->attr.sample_max_stack;
 	struct perf_callchain_entry *callchain;
+	u64 defer_cookie = 0;
 	bool defer_user = IS_ENABLED(CONFIG_UNWIND_USER) && user &&
 			  event->attr.defer_callchain;
 
@@ -8302,15 +8302,15 @@ perf_callchain(struct perf_event *event, struct pt_regs *regs)
 		return &__empty_callchain;
 
 	if (defer_user) {
-		int ret = deferred_request(event);
+		int ret = deferred_request(event, &defer_cookie);
 		if (!ret)
 			local_inc(&event->ctx->nr_no_switch_fast);
 		else if (ret < 0)
-			defer_user = false;
+			defer_cookie = 0;
 	}
 
 	callchain = get_perf_callchain(regs, kernel, user, max_stack,
-				       crosstask, true, defer_user);
+				       crosstask, true, defer_cookie);
 
 	return callchain ?: &__empty_callchain;
 }
diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
index 20b8f890113b..79232e85a8fc 100644
--- a/tools/include/uapi/linux/perf_event.h
+++ b/tools/include/uapi/linux/perf_event.h
@@ -1282,6 +1282,11 @@ enum perf_bpf_event_type {
 #define PERF_MAX_STACK_DEPTH			127
 #define PERF_MAX_CONTEXTS_PER_STACK		  8
 
+/*
+ * The PERF_CONTEXT_USER_DEFERRED has two items (context and cookie)
+ */
+#define PERF_DEFERRED_ITEMS			2
+
 enum perf_callchain_context {
 	PERF_CONTEXT_HV				= (__u64)-32,
 	PERF_CONTEXT_KERNEL			= (__u64)-128,
-- 
2.50.1



