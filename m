Return-Path: <bpf+bounces-58660-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AFDD7ABFB9D
	for <lists+bpf@lfdr.de>; Wed, 21 May 2025 18:50:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96E699E74F8
	for <lists+bpf@lfdr.de>; Wed, 21 May 2025 16:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 606012609E7;
	Wed, 21 May 2025 16:50:07 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D3E822B8BD;
	Wed, 21 May 2025 16:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747846207; cv=none; b=UFNfH3HfFb00GonRRwSKE7WFDDM+NMddiluuiuyBgW/Qn6RUbdfElhZ7F2tkyVsUgR1hfr+0UZMC60gq8Tpsok2nnyifqMLpc+7+PDZByDXR6JnFxOlgccSIYIA0StxHfzOAjgo8rbXrJ/TduTw6t3InfDl7ri1/ECLtEZZnSaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747846207; c=relaxed/simple;
	bh=KDHDNEXCJtBLo58XVi0m4EyFpeQHgCOxlLteALixCYk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g2Ew0EgU7ZdAVsrXibmfmGQo+AcCS2M6bmYbYKaZZwaVB/9xnr4TDoKSvT+t4JW/47yopyjO9ltRHy6LgmehOTtc0W4PuWMpM3yzj6eRYiEXldrMPwgeBubFxMFqmSvSjSMKTtq7MtQOM15SI2iP0Nj7/jgVgpz/1NOi6oGbP1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E2D3C4CEE4;
	Wed, 21 May 2025 16:50:05 +0000 (UTC)
Date: Wed, 21 May 2025 12:50:48 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, x86@kernel.org,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Josh Poimboeuf
 <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar
 <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Thomas Gleixner
 <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Andrii
 Nakryiko <andrii@kernel.org>
Subject: Re: [PATCH v9 00/13] unwind_user: x86: Deferred unwinding
 infrastructure
Message-ID: <20250521125048.4d572d08@gandalf.local.home>
In-Reply-To: <20250520195549.17f6c2c7@gandalf.local.home>
References: <20250513223435.636200356@goodmis.org>
	<20250514132720.6b16880c@gandalf.local.home>
	<aCfMzJ-zN0JKKTjO@google.com>
	<20250521082605.b4bd632ef1312778ea51dd71@kernel.org>
	<20250520195549.17f6c2c7@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 20 May 2025 19:55:49 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> There's a proposal to move trace_sched_process_exit() to before exit_mm().
> If that happens, we could make that tracepoint a "faultable" tracepoint and
> then the unwind infrastructure could attach to it and do the unwinding from
> that tracepoint.

The below patch does work. It's just a PoC and would need to be broken up
and also cleaned up.

I created a TRACE_EVENT_FAULTABLE() that is basically just a
TRACE_EVENT_SYSCALL(), and used that for the sched_process_exit tracepoint.

I then had the unwinder attach to that tracepoint when the first unwind
callback is registered.

I had to change the check in the trace from testing PF_EXITING to just
current->mm is NULL.

But this does work for the exiting of a task:

-- Steve

diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
index a351763e6965..eb98bb61126e 100644
--- a/include/linux/tracepoint.h
+++ b/include/linux/tracepoint.h
@@ -617,6 +617,8 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 #define TRACE_EVENT_SYSCALL(name, proto, args, struct, assign,	\
 			    print, reg, unreg)			\
 	DECLARE_TRACE_SYSCALL(name, PARAMS(proto), PARAMS(args))
+#define TRACE_EVENT_FAULTABLE(name, proto, args, struct, assign, print)	\
+	DECLARE_TRACE_SYSCALL(name, PARAMS(proto), PARAMS(args))
 
 #define TRACE_EVENT_FLAGS(event, flag)
 
diff --git a/include/trace/define_trace.h b/include/trace/define_trace.h
index ed52d0506c69..b228424744fd 100644
--- a/include/trace/define_trace.h
+++ b/include/trace/define_trace.h
@@ -50,6 +50,10 @@
 #define TRACE_EVENT_SYSCALL(name, proto, args, struct, assign, print, reg, unreg) \
 	DEFINE_TRACE_SYSCALL(name, reg, unreg, PARAMS(proto), PARAMS(args))
 
+#undef TRACE_EVENT_FAULTABLE
+#define TRACE_EVENT_FAULTABLE(name, proto, args, struct, assign, print) \
+	DEFINE_TRACE_SYSCALL(name, NULL, NULL, PARAMS(proto), PARAMS(args))
+
 #undef TRACE_EVENT_NOP
 #define TRACE_EVENT_NOP(name, proto, args, struct, assign, print)
 
@@ -125,6 +129,7 @@
 #undef TRACE_EVENT_FN
 #undef TRACE_EVENT_FN_COND
 #undef TRACE_EVENT_SYSCALL
+#undef TRACE_EVENT_FAULTABLE
 #undef TRACE_EVENT_CONDITION
 #undef TRACE_EVENT_NOP
 #undef DEFINE_EVENT_NOP
diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
index 3bec9fb73a36..c6d7894970e3 100644
--- a/include/trace/events/sched.h
+++ b/include/trace/events/sched.h
@@ -326,13 +326,13 @@ DEFINE_EVENT(sched_process_template, sched_process_free,
 	     TP_ARGS(p));
 
 /*
- * Tracepoint for a task exiting.
+ * Tracepoint for a task exiting (allows faulting)
  * Note, it's a superset of sched_process_template and should be kept
  * compatible as much as possible. sched_process_exits has an extra
  * `group_dead` argument, so sched_process_template can't be used,
  * unfortunately, just like sched_migrate_task above.
  */
-TRACE_EVENT(sched_process_exit,
+TRACE_EVENT_FAULTABLE(sched_process_exit,
 
 	TP_PROTO(struct task_struct *p, bool group_dead),
 
diff --git a/include/trace/trace_events.h b/include/trace/trace_events.h
index 4f22136fd465..0ed57e7906d1 100644
--- a/include/trace/trace_events.h
+++ b/include/trace/trace_events.h
@@ -55,6 +55,16 @@
 			     PARAMS(print));		       \
 	DEFINE_EVENT(name, name, PARAMS(proto), PARAMS(args));
 
+#undef TRACE_EVENT_FAULTABLE
+#define TRACE_EVENT_FAULTABLE(name, proto, args, tstruct, assign, print) \
+	DECLARE_EVENT_SYSCALL_CLASS(name,		       \
+			     PARAMS(proto),		       \
+			     PARAMS(args),		       \
+			     PARAMS(tstruct),		       \
+			     PARAMS(assign),		       \
+			     PARAMS(print));		       \
+	DEFINE_EVENT(name, name, PARAMS(proto), PARAMS(args));
+
 #include "stages/stage1_struct_define.h"
 
 #undef DECLARE_EVENT_CLASS
diff --git a/kernel/unwind/deferred.c b/kernel/unwind/deferred.c
index 63d0237bad3e..7aad471f2887 100644
--- a/kernel/unwind/deferred.c
+++ b/kernel/unwind/deferred.c
@@ -11,6 +11,8 @@
 #include <linux/slab.h>
 #include <linux/mm.h>
 
+#include <trace/events/sched.h>
+
 #define UNWIND_MAX_ENTRIES 512
 
 /* Guards adding to or removing from the list of callbacks */
@@ -77,7 +79,7 @@ int unwind_deferred_trace(struct unwind_stacktrace *trace)
 	/* Should always be called from faultable context */
 	might_fault();
 
-	if (current->flags & PF_EXITING)
+	if (!current->mm)
 		return -EINVAL;
 
 	if (!info->cache) {
@@ -107,14 +109,14 @@ int unwind_deferred_trace(struct unwind_stacktrace *trace)
 	return 0;
 }
 
-static void unwind_deferred_task_work(struct callback_head *head)
+static void process_unwind_deferred(void)
 {
-	struct unwind_task_info *info = container_of(head, struct unwind_task_info, work);
+	struct task_struct *task = current;
+	struct unwind_task_info *info = &task->unwind_info;
 	struct unwind_stacktrace trace;
 	struct unwind_work *work;
 	unsigned long bits;
 	u64 timestamp;
-	struct task_struct *task = current;
 	int idx;
 
 	if (WARN_ON_ONCE(!unwind_pending(task)))
@@ -152,6 +155,21 @@ static void unwind_deferred_task_work(struct callback_head *head)
 	srcu_read_unlock(&unwind_srcu, idx);
 }
 
+static void unwind_deferred_task_work(struct callback_head *head)
+{
+	process_unwind_deferred();
+}
+
+static void unwind_deferred_callback(void *data, struct task_struct *p, bool group_dead)
+{
+	if (!unwind_pending(p))
+		return;
+
+	process_unwind_deferred();
+
+	task_work_cancel(p, &p->unwind_info.work);
+}
+
 static int unwind_deferred_request_nmi(struct unwind_work *work, u64 *timestamp)
 {
 	struct unwind_task_info *info = &current->unwind_info;
@@ -329,6 +347,10 @@ void unwind_deferred_cancel(struct unwind_work *work)
 	for_each_process_thread(g, t) {
 		clear_bit(bit, &t->unwind_mask);
 	}
+
+	/* Is this the last registered unwinding? */
+	if (!unwind_mask)
+		unregister_trace_sched_process_exit(unwind_deferred_callback, NULL);
 }
 
 int unwind_deferred_init(struct unwind_work *work, unwind_callback_t func)
@@ -341,6 +363,15 @@ int unwind_deferred_init(struct unwind_work *work, unwind_callback_t func)
 	if (unwind_mask == ~(UNWIND_PENDING))
 		return -EBUSY;
 
+	/* Is this the first registered unwinding? */
+	if (!unwind_mask) {
+		int ret;
+
+		ret = register_trace_sched_process_exit(unwind_deferred_callback, NULL);
+		if (ret < 0)
+			return ret;
+	}
+
 	work->bit = ffz(unwind_mask);
 	unwind_mask |= 1UL << work->bit;
 


