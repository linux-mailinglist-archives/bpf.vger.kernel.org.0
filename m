Return-Path: <bpf+bounces-71938-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BCF9C01F9F
	for <lists+bpf@lfdr.de>; Thu, 23 Oct 2025 17:05:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94DBA3AF0FA
	for <lists+bpf@lfdr.de>; Thu, 23 Oct 2025 15:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E44DD337104;
	Thu, 23 Oct 2025 15:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Zk6I2NEo"
X-Original-To: bpf@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4B4212B31;
	Thu, 23 Oct 2025 15:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761231622; cv=none; b=EZAxm/uiYIcfOU553NgEyWVRRnNpi9cRgrZr44jQ267E7JXfgV9xKFJaL6pO+I7D6KFuUNHXpUaWvikYbychs80AGqhfGwevkx+Jw5YNYM163wKhA4NVDS71h7AoApXvQiNvpENnRnMING1tDEnCeniFH/80DiIRf9d8Wg1QgAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761231622; c=relaxed/simple;
	bh=R0GeTZKfjIhHXP42wz7zEjRHdLp4ZwtqPklzi8TwTIU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oBramAcuyv/bFAr+9kbRAS69kv0Zw+vP6jL2F+9x7q4/FxE3HKmTEqjn6G8Q1hm9u9aXR4M0XPNx6kXgBC/D+9yqXEOlHS8hYqyaxQTjjxfdPzyedLDqEue88G99iMoivnvEKoIs2U9Maep8gies5Ft61CdvNESxdiAb07PXyTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Zk6I2NEo; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=GkE3Bt9DML1UUffNBHGmtz8BjgijwMfbmgx8DCpGxOo=; b=Zk6I2NEo2jeniivae/9Av2I7Sc
	1jRDgJIwo2yit97K1Nl0tSIMFRhGe7NsveZMqhL9xokH+NON1NE6FKHKJXD6hSScz3g9hxDDmJCde
	7r8pAckDLsq/GSVoGo3Qb/4JmO9C6IbFD0rEDZ6EXBVNmKrUqBJTwDcH36NBg8ShTRHDEJiGMZzLq
	lMVZaoR04tNR7UTJAhUG++UXmK2PWTEvldxGR+RQNVZZj1gfudQq9yEIytwLKzsZE9N313GXtmrVp
	9BEXQZw2MP2HR+lWS6p+s+U5yiiUKNEMO1G4L6ie98D7KRi37GpGLtN6H6qkVUA6sJ5YhHHpdoSlO
	1/a1Y3EA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBwnK-00000005rPs-1NKw;
	Thu, 23 Oct 2025 15:00:03 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 7E26230039F; Thu, 23 Oct 2025 17:00:02 +0200 (CEST)
Date: Thu, 23 Oct 2025 17:00:02 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Steven Rostedt <rostedt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org, x86@kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
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
	Florian Weimer <fweimer@redhat.com>, Sam James <sam@gentoo.org>,
	Kees Cook <kees@kernel.org>, Carlos O'Donell <codonell@redhat.com>
Subject: Re: [PATCH v16 0/4] perf: Support the deferred unwinding
 infrastructure
Message-ID: <20251023150002.GR4067720@noisy.programming.kicks-ass.net>
References: <20251007214008.080852573@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251007214008.080852573@kernel.org>

On Tue, Oct 07, 2025 at 05:40:08PM -0400, Steven Rostedt wrote:

>  include/linux/perf_event.h            |   9 +-
>  include/linux/unwind_deferred.h       |  15 ++
>  include/uapi/linux/perf_event.h       |  25 ++-
>  kernel/bpf/stackmap.c                 |   4 +-
>  kernel/events/callchain.c             |  14 +-
>  kernel/events/core.c                  | 362 +++++++++++++++++++++++++++++++++-
>  kernel/unwind/deferred.c              | 283 ++++++++++++++++++++++----
>  tools/include/uapi/linux/perf_event.h |  25 ++-
>  8 files changed, 686 insertions(+), 51 deletions(-)

After staring at this some, I mostly threw it all out and wrote the
below.

I also have some hackery on the userspace patches to go along with this,
and it all sits in my unwind/cleanup branch.

Trouble is, pretty much every unwind is 510 entries long -- this cannot
be right. I'm sure there's a silly mistake in unwind/user.c but I'm too
tired to find it just now. I'll try again tomorrow.
  
---
 include/linux/perf_event.h            |    2 
 include/linux/unwind_deferred.h       |   12 -----
 include/linux/unwind_deferred_types.h |   13 +++++
 include/uapi/linux/perf_event.h       |   21 ++++++++-
 kernel/bpf/stackmap.c                 |    4 -
 kernel/events/callchain.c             |   14 +++++-
 kernel/events/core.c                  |   79 +++++++++++++++++++++++++++++++++-
 tools/include/uapi/linux/perf_event.h |   21 ++++++++-
 8 files changed, 146 insertions(+), 20 deletions(-)

--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1720,7 +1720,7 @@ extern void perf_callchain_user(struct p
 extern void perf_callchain_kernel(struct perf_callchain_entry_ctx *entry, struct pt_regs *regs);
 extern struct perf_callchain_entry *
 get_perf_callchain(struct pt_regs *regs, bool kernel, bool user,
-		   u32 max_stack, bool crosstask, bool add_mark);
+		   u32 max_stack, bool crosstask, bool add_mark, u64 defer_cookie);
 extern int get_callchain_buffers(int max_stack);
 extern void put_callchain_buffers(void);
 extern struct perf_callchain_entry *get_callchain_entry(int *rctx);
--- a/include/linux/unwind_deferred.h
+++ b/include/linux/unwind_deferred.h
@@ -6,18 +6,6 @@
 #include <linux/unwind_user.h>
 #include <linux/unwind_deferred_types.h>
 
-struct unwind_work;
-
-typedef void (*unwind_callback_t)(struct unwind_work *work,
-				  struct unwind_stacktrace *trace,
-				  u64 cookie);
-
-struct unwind_work {
-	struct list_head		list;
-	unwind_callback_t		func;
-	int				bit;
-};
-
 #ifdef CONFIG_UNWIND_USER
 
 enum {
--- a/include/linux/unwind_deferred_types.h
+++ b/include/linux/unwind_deferred_types.h
@@ -39,4 +39,17 @@ struct unwind_task_info {
 	union unwind_task_id	id;
 };
 
+struct unwind_work;
+struct unwind_stacktrace;
+
+typedef void (*unwind_callback_t)(struct unwind_work *work,
+				  struct unwind_stacktrace *trace,
+				  u64 cookie);
+
+struct unwind_work {
+	struct list_head		list;
+	unwind_callback_t		func;
+	int				bit;
+};
+
 #endif /* _LINUX_UNWIND_USER_DEFERRED_TYPES_H */
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -463,7 +463,9 @@ struct perf_event_attr {
 				inherit_thread :  1, /* children only inherit if cloned with CLONE_THREAD */
 				remove_on_exec :  1, /* event is removed from task on exec */
 				sigtrap        :  1, /* send synchronous SIGTRAP on event */
-				__reserved_1   : 26;
+				defer_callchain:  1, /* request PERF_RECORD_CALLCHAIN_DEFERRED records */
+				defer_output   :  1, /* output PERF_RECORD_CALLCHAIN_DEFERRED records */
+				__reserved_1   : 24;
 
 	union {
 		__u32		wakeup_events;	  /* wake up every n events */
@@ -1239,6 +1241,22 @@ enum perf_event_type {
 	 */
 	PERF_RECORD_AUX_OUTPUT_HW_ID		= 21,
 
+	/*
+	 * This user callchain capture was deferred until shortly before
+	 * returning to user space.  Previous samples would have kernel
+	 * callchains only and they need to be stitched with this to make full
+	 * callchains.
+	 *
+	 * struct {
+	 *	struct perf_event_header	header;
+	 *	u64				cookie;
+	 *	u64				nr;
+	 *	u64				ips[nr];
+	 *	struct sample_id		sample_id;
+	 * };
+	 */
+	PERF_RECORD_CALLCHAIN_DEFERRED		= 22,
+
 	PERF_RECORD_MAX,			/* non-ABI */
 };
 
@@ -1269,6 +1287,7 @@ enum perf_callchain_context {
 	PERF_CONTEXT_HV				= (__u64)-32,
 	PERF_CONTEXT_KERNEL			= (__u64)-128,
 	PERF_CONTEXT_USER			= (__u64)-512,
+	PERF_CONTEXT_USER_DEFERRED		= (__u64)-640,
 
 	PERF_CONTEXT_GUEST			= (__u64)-2048,
 	PERF_CONTEXT_GUEST_KERNEL		= (__u64)-2176,
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -315,7 +315,7 @@ BPF_CALL_3(bpf_get_stackid, struct pt_re
 		max_depth = sysctl_perf_event_max_stack;
 
 	trace = get_perf_callchain(regs, kernel, user, max_depth,
-				   false, false);
+				   false, false, 0);
 
 	if (unlikely(!trace))
 		/* couldn't fetch the stack trace */
@@ -452,7 +452,7 @@ static long __bpf_get_stack(struct pt_re
 		trace = get_callchain_entry_for_task(task, max_depth);
 	else
 		trace = get_perf_callchain(regs, kernel, user, max_depth,
-					   crosstask, false);
+					   crosstask, false, 0);
 
 	if (unlikely(!trace) || trace->nr < skip) {
 		if (may_fault)
--- a/kernel/events/callchain.c
+++ b/kernel/events/callchain.c
@@ -218,7 +218,7 @@ static void fixup_uretprobe_trampoline_e
 
 struct perf_callchain_entry *
 get_perf_callchain(struct pt_regs *regs, bool kernel, bool user,
-		   u32 max_stack, bool crosstask, bool add_mark)
+		   u32 max_stack, bool crosstask, bool add_mark, u64 defer_cookie)
 {
 	struct perf_callchain_entry *entry;
 	struct perf_callchain_entry_ctx ctx;
@@ -251,6 +251,18 @@ get_perf_callchain(struct pt_regs *regs,
 			regs = task_pt_regs(current);
 		}
 
+		if (defer_cookie) {
+			/*
+			 * Foretell the coming of PERF_RECORD_CALLCHAIN_DEFERRED
+			 * which can be stitched to this one, and add
+			 * the cookie after it (it will be cut off when the
+			 * user stack is copied to the callchain).
+			 */
+			perf_callchain_store_context(&ctx, PERF_CONTEXT_USER_DEFERRED);
+			perf_callchain_store_context(&ctx, defer_cookie);
+			goto exit_put;
+		}
+
 		if (add_mark)
 			perf_callchain_store_context(&ctx, PERF_CONTEXT_USER);
 
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -56,6 +56,7 @@
 #include <linux/buildid.h>
 #include <linux/task_work.h>
 #include <linux/percpu-rwsem.h>
+#include <linux/unwind_deferred.h>
 
 #include "internal.h"
 
@@ -8200,6 +8201,8 @@ static u64 perf_get_page_size(unsigned l
 
 static struct perf_callchain_entry __empty_callchain = { .nr = 0, };
 
+static struct unwind_work perf_unwind_work;
+
 struct perf_callchain_entry *
 perf_callchain(struct perf_event *event, struct pt_regs *regs)
 {
@@ -8208,8 +8211,11 @@ perf_callchain(struct perf_event *event,
 		!(current->flags & (PF_KTHREAD | PF_USER_WORKER));
 	/* Disallow cross-task user callchains. */
 	bool crosstask = event->ctx->task && event->ctx->task != current;
+	bool defer_user = IS_ENABLED(CONFIG_UNWIND_USER) && user &&
+			  event->attr.defer_callchain;
 	const u32 max_stack = event->attr.sample_max_stack;
 	struct perf_callchain_entry *callchain;
+	u64 defer_cookie;
 
 	if (!current->mm)
 		user = false;
@@ -8217,8 +8223,13 @@ perf_callchain(struct perf_event *event,
 	if (!kernel && !user)
 		return &__empty_callchain;
 
-	callchain = get_perf_callchain(regs, kernel, user,
-				       max_stack, crosstask, true);
+	if (!(user && defer_user && !crosstask &&
+	      unwind_deferred_request(&perf_unwind_work, &defer_cookie) >= 0))
+		defer_cookie = 0;
+
+	callchain = get_perf_callchain(regs, kernel, user, max_stack,
+				       crosstask, true, defer_cookie);
+
 	return callchain ?: &__empty_callchain;
 }
 
@@ -10003,6 +10014,67 @@ void perf_event_bpf_event(struct bpf_pro
 	perf_iterate_sb(perf_event_bpf_output, &bpf_event, NULL);
 }
 
+struct perf_callchain_deferred_event {
+	struct unwind_stacktrace *trace;
+	struct {
+		struct perf_event_header	header;
+		u64				cookie;
+		u64				nr;
+		u64				ips[];
+	} event;
+};
+
+static void perf_callchain_deferred_output(struct perf_event *event, void *data)
+{
+	struct perf_callchain_deferred_event *deferred_event = data;
+	struct perf_output_handle handle;
+	struct perf_sample_data sample;
+	int ret, size = deferred_event->event.header.size;
+
+	if (!event->attr.defer_output)
+		return;
+
+	/* XXX do we really need sample_id_all for this ??? */
+	perf_event_header__init_id(&deferred_event->event.header, &sample, event);
+
+	ret = perf_output_begin(&handle, &sample, event,
+				deferred_event->event.header.size);
+	if (ret)
+		goto out;
+
+	perf_output_put(&handle, deferred_event->event);
+	for (int i = 0; i < deferred_event->trace->nr; i++) {
+		u64 entry = deferred_event->trace->entries[i];
+		perf_output_put(&handle, entry);
+	}
+	perf_event__output_id_sample(event, &handle, &sample);
+
+	perf_output_end(&handle);
+out:
+	deferred_event->event.header.size = size;
+}
+
+/* Deferred unwinding callback for task specific events */
+static void perf_unwind_deferred_callback(struct unwind_work *work,
+					 struct unwind_stacktrace *trace, u64 cookie)
+{
+	struct perf_callchain_deferred_event deferred_event = {
+		.trace = trace,
+		.event = {
+			.header = {
+				.type = PERF_RECORD_CALLCHAIN_DEFERRED,
+				.misc = PERF_RECORD_MISC_USER,
+				.size = sizeof(deferred_event.event) +
+					(trace->nr * sizeof(u64)),
+			},
+			.cookie = cookie,
+			.nr = trace->nr,
+		},
+	};
+
+	perf_iterate_sb(perf_callchain_deferred_output, &deferred_event, NULL);
+}
+
 struct perf_text_poke_event {
 	const void		*old_bytes;
 	const void		*new_bytes;
@@ -14799,6 +14871,9 @@ void __init perf_event_init(void)
 
 	idr_init(&pmu_idr);
 
+	unwind_deferred_init(&perf_unwind_work,
+			     perf_unwind_deferred_callback);
+
 	perf_event_init_all_cpus();
 	init_srcu_struct(&pmus_srcu);
 	perf_pmu_register(&perf_swevent, "software", PERF_TYPE_SOFTWARE);
--- a/tools/include/uapi/linux/perf_event.h
+++ b/tools/include/uapi/linux/perf_event.h
@@ -463,7 +463,9 @@ struct perf_event_attr {
 				inherit_thread :  1, /* children only inherit if cloned with CLONE_THREAD */
 				remove_on_exec :  1, /* event is removed from task on exec */
 				sigtrap        :  1, /* send synchronous SIGTRAP on event */
-				__reserved_1   : 26;
+				defer_callchain:  1, /* request PERF_RECORD_CALLCHAIN_DEFERRED records */
+				defer_output   :  1, /* output PERF_RECORD_CALLCHAIN_DEFERRED records */
+				__reserved_1   : 24;
 
 	union {
 		__u32		wakeup_events;	  /* wake up every n events */
@@ -1239,6 +1241,22 @@ enum perf_event_type {
 	 */
 	PERF_RECORD_AUX_OUTPUT_HW_ID		= 21,
 
+	/*
+	 * This user callchain capture was deferred until shortly before
+	 * returning to user space.  Previous samples would have kernel
+	 * callchains only and they need to be stitched with this to make full
+	 * callchains.
+	 *
+	 * struct {
+	 *	struct perf_event_header	header;
+	 *	u64				cookie;
+	 *	u64				nr;
+	 *	u64				ips[nr];
+	 *	struct sample_id		sample_id;
+	 * };
+	 */
+	PERF_RECORD_CALLCHAIN_DEFERRED		= 22,
+
 	PERF_RECORD_MAX,			/* non-ABI */
 };
 
@@ -1269,6 +1287,7 @@ enum perf_callchain_context {
 	PERF_CONTEXT_HV				= (__u64)-32,
 	PERF_CONTEXT_KERNEL			= (__u64)-128,
 	PERF_CONTEXT_USER			= (__u64)-512,
+	PERF_CONTEXT_USER_DEFERRED		= (__u64)-640,
 
 	PERF_CONTEXT_GUEST			= (__u64)-2048,
 	PERF_CONTEXT_GUEST_KERNEL		= (__u64)-2176,

