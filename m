Return-Path: <bpf+bounces-48722-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CDDAA0FDB7
	for <lists+bpf@lfdr.de>; Tue, 14 Jan 2025 01:54:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89AB016970F
	for <lists+bpf@lfdr.de>; Tue, 14 Jan 2025 00:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81B3F3594A;
	Tue, 14 Jan 2025 00:54:52 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D02C19A;
	Tue, 14 Jan 2025 00:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736816092; cv=none; b=BUdow/C+P82XIDrQnkYr7N7bw07qXV8ogLLEd2ECawBBg566oi5reLRJeBtZFrm9CkXDb5iPw+iF3zS6WyMo/fLCgi/zG/kQgKcZstWBG1c4JieZzv0XEgCUduSfXwqU7NoYC11xWawPlLiAyFP2WnFSg52qW6bmckfUZN4V4kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736816092; c=relaxed/simple;
	bh=YyyP5iEAtdC2GEN7aXFQn4mxbYuUGfB0r9DopWrXUCk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MJvqmnsOMnY7yKU7sC6PA/tMjP1W6El56MiHAtxceZtTR7Sup/lljFe3PA0Fs3bsTtfR56xJHXtDkAJX4wmLqNfLxKA/Ku8Mc9iqqAEn0zmYkRV//xVryRLUWQVoik0CqbSIH0HoAupdau8O/f04z4Osml7H1ZzqqUwnWKaXkUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E96DC4CEE2;
	Tue, 14 Jan 2025 00:54:50 +0000 (UTC)
Date: Mon, 13 Jan 2025 19:54:49 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Jiri Olsa <olsajiri@gmail.com>, Alexei Starovoitov
 <alexei.starovoitov@gmail.com>, Florent Revest <revest@chromium.org>,
 linux-trace-kernel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, bpf <bpf@vger.kernel.org>, Alexei
 Starovoitov <ast@kernel.org>, Alan Maguire <alan.maguire@oracle.com>, Mark
 Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH] fgraph: Move trace_clock_local() for return time to
 function_graph tracer
Message-ID: <20250113195449.72ab5d81@gandalf.local.home>
In-Reply-To: <173665959558.1629214.16724136597211810729.stgit@devnote2>
References: <Z3aSuql3fnXMVMoM@krava>
	<173665959558.1629214.16724136597211810729.stgit@devnote2>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 12 Jan 2025 14:26:35 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Since the ftrace_graph_ret::rettime is only referred in the function_graph
> tracer, the trace_clock_local() call in fgraph is just an overhead for
> other fgraph users.
> 
> Move the trace_clock_local() for recording return time to function_graph
> tracer and the rettime field is just zeroed in the fgraph side.
> That rettime field is updated by one of the function_graph tracer and
> cached for other function_graph tracer instances.
> 
> According to Jiri's report[1], removing this function will gain fprobe
> performance ~27%.
> 
> [1] https://lore.kernel.org/all/Z3aSuql3fnXMVMoM@krava/
> 
> Reported-by: Jiri Olsa <olsajiri@gmail.com>
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

I'd rather just nuke the calltime and rettime from struct ftrace_graph_ret.

How about something like this instead?

[ based on: https://lore.kernel.org/linux-trace-kernel/20250113183124.61767419@gandalf.local.home/ ]

I can start testing it (it compiles and boots).

 include/linux/ftrace.h               |  2 --
 kernel/trace/fgraph.c                |  1 -
 kernel/trace/trace.h                 |  4 +++-
 kernel/trace/trace_entries.h         |  8 +++----
 kernel/trace/trace_functions_graph.c | 33 ++++++++++++++++------------
 kernel/trace/trace_irqsoff.c         |  5 +++--
 kernel/trace/trace_sched_wakeup.c    |  6 +++--
 7 files changed, 33 insertions(+), 26 deletions(-)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index aa9ddd1e4bb6..848ddf0d8f89 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -1061,8 +1061,6 @@ struct ftrace_graph_ret {
 	int depth;
 	/* Number of functions that overran the depth limit for current task */
 	unsigned int overrun;
-	unsigned long long calltime;
-	unsigned long long rettime;
 } __packed;
 
 struct fgraph_ops;
diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index 30e3ddc8a8a8..a7e6c8488b7f 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -818,7 +818,6 @@ static unsigned long __ftrace_return_to_handler(struct fgraph_ret_regs *ret_regs
 		return (unsigned long)panic;
 	}
 
-	trace.rettime = trace_clock_local();
 #ifdef CONFIG_FUNCTION_GRAPH_RETVAL
 	trace.retval = fgraph_ret_regs_return_value(ret_regs);
 #endif
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 9691b47b5f3d..467a8143fbb9 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -911,7 +911,9 @@ extern int __trace_graph_retaddr_entry(struct trace_array *tr,
 				unsigned long retaddr);
 extern void __trace_graph_return(struct trace_array *tr,
 				 struct ftrace_graph_ret *trace,
-				 unsigned int trace_ctx);
+				 unsigned int trace_ctx,
+				 u64 calltime, u64 rettime);
+
 extern void init_array_fgraph_ops(struct trace_array *tr, struct ftrace_ops *ops);
 extern int allocate_fgraph_ops(struct trace_array *tr, struct ftrace_ops *ops);
 extern void free_fgraph_ops(struct trace_array *tr);
diff --git a/kernel/trace/trace_entries.h b/kernel/trace/trace_entries.h
index 82fd174ebbe0..fbfb396905a6 100644
--- a/kernel/trace/trace_entries.h
+++ b/kernel/trace/trace_entries.h
@@ -124,8 +124,8 @@ FTRACE_ENTRY_PACKED(funcgraph_exit, ftrace_graph_ret_entry,
 		__field_packed(	unsigned long,	ret,		retval	)
 		__field_packed(	int,		ret,		depth	)
 		__field_packed(	unsigned int,	ret,		overrun	)
-		__field_packed(	unsigned long long, ret,	calltime)
-		__field_packed(	unsigned long long, ret,	rettime	)
+		__field(unsigned long long,	calltime		)
+		__field(unsigned long long,	rettime			)
 	),
 
 	F_printk("<-- %ps (%d) (start: %llx  end: %llx) over: %d retval: %lx",
@@ -146,8 +146,8 @@ FTRACE_ENTRY_PACKED(funcgraph_exit, ftrace_graph_ret_entry,
 		__field_packed(	unsigned long,	ret,		func	)
 		__field_packed(	int,		ret,		depth	)
 		__field_packed(	unsigned int,	ret,		overrun	)
-		__field_packed(	unsigned long long, ret,	calltime)
-		__field_packed(	unsigned long long, ret,	rettime	)
+		__field(unsigned long long,	calltime		)
+		__field(unsigned long long,	rettime			)
 	),
 
 	F_printk("<-- %ps (%d) (start: %llx  end: %llx) over: %d",
diff --git a/kernel/trace/trace_functions_graph.c b/kernel/trace/trace_functions_graph.c
index 5504b5e4e7b4..7bff133c1543 100644
--- a/kernel/trace/trace_functions_graph.c
+++ b/kernel/trace/trace_functions_graph.c
@@ -270,12 +270,10 @@ __trace_graph_function(struct trace_array *tr,
 	struct ftrace_graph_ret ret = {
 		.func     = ip,
 		.depth    = 0,
-		.calltime = time,
-		.rettime  = time,
 	};
 
 	__trace_graph_entry(tr, &ent, trace_ctx);
-	__trace_graph_return(tr, &ret, trace_ctx);
+	__trace_graph_return(tr, &ret, trace_ctx, time, time);
 }
 
 void
@@ -287,8 +285,9 @@ trace_graph_function(struct trace_array *tr,
 }
 
 void __trace_graph_return(struct trace_array *tr,
-				struct ftrace_graph_ret *trace,
-				unsigned int trace_ctx)
+			  struct ftrace_graph_ret *trace,
+			  unsigned int trace_ctx,
+			  u64 calltime, u64 rettime)
 {
 	struct ring_buffer_event *event;
 	struct trace_buffer *buffer = tr->array_buffer.buffer;
@@ -300,6 +299,8 @@ void __trace_graph_return(struct trace_array *tr,
 		return;
 	entry	= ring_buffer_event_data(event);
 	entry->ret				= *trace;
+	entry->calltime				= calltime;
+	entry->rettime				= rettime;
 	trace_buffer_unlock_commit_nostack(buffer, event);
 }
 
@@ -322,10 +323,13 @@ void trace_graph_return(struct ftrace_graph_ret *trace,
 	struct fgraph_times *ftimes;
 	unsigned long flags;
 	unsigned int trace_ctx;
+	u64 calltime, rettime;
 	long disabled;
 	int size;
 	int cpu;
 
+	rettime = trace_clock_local();
+
 	ftrace_graph_addr_finish(gops, trace);
 
 	if (*task_var & TRACE_GRAPH_NOTRACE) {
@@ -339,7 +343,7 @@ void trace_graph_return(struct ftrace_graph_ret *trace,
 
 	handle_nosleeptime(trace, ftimes, size);
 
-	trace->calltime = ftimes->calltime;
+	calltime = ftimes->calltime;
 
 	local_irq_save(flags);
 	cpu = raw_smp_processor_id();
@@ -347,7 +351,7 @@ void trace_graph_return(struct ftrace_graph_ret *trace,
 	disabled = atomic_inc_return(&data->disabled);
 	if (likely(disabled == 1)) {
 		trace_ctx = tracing_gen_ctx_flags(flags);
-		__trace_graph_return(tr, trace, trace_ctx);
+		__trace_graph_return(tr, trace, trace_ctx, calltime, rettime);
 	}
 	atomic_dec(&data->disabled);
 	local_irq_restore(flags);
@@ -372,10 +376,8 @@ static void trace_graph_thresh_return(struct ftrace_graph_ret *trace,
 
 	handle_nosleeptime(trace, ftimes, size);
 
-	trace->calltime = ftimes->calltime;
-
 	if (tracing_thresh &&
-	    (trace->rettime - ftimes->calltime < tracing_thresh))
+	    (trace_clock_local() - ftimes->calltime < tracing_thresh))
 		return;
 	else
 		trace_graph_return(trace, gops);
@@ -861,7 +863,7 @@ print_graph_entry_leaf(struct trace_iterator *iter,
 
 	graph_ret = &ret_entry->ret;
 	call = &entry->graph_ent;
-	duration = graph_ret->rettime - graph_ret->calltime;
+	duration = ret_entry->rettime - ret_entry->calltime;
 
 	func = call->func + iter->tr->text_delta;
 
@@ -1142,11 +1144,14 @@ print_graph_entry(struct ftrace_graph_ent_entry *field, struct trace_seq *s,
 }
 
 static enum print_line_t
-print_graph_return(struct ftrace_graph_ret *trace, struct trace_seq *s,
+print_graph_return(struct ftrace_graph_ret_entry *retentry, struct trace_seq *s,
 		   struct trace_entry *ent, struct trace_iterator *iter,
 		   u32 flags)
 {
-	unsigned long long duration = trace->rettime - trace->calltime;
+	struct ftrace_graph_ret *trace = &retentry->ret;
+	u64 calltime = retentry->calltime;
+	u64 rettime = retentry->rettime;
+	unsigned long long duration = rettime - calltime;
 	struct fgraph_data *data = iter->private;
 	struct trace_array *tr = iter->tr;
 	unsigned long func;
@@ -1347,7 +1352,7 @@ print_graph_function_flags(struct trace_iterator *iter, u32 flags)
 	case TRACE_GRAPH_RET: {
 		struct ftrace_graph_ret_entry *field;
 		trace_assign_type(field, entry);
-		return print_graph_return(&field->ret, s, entry, iter, flags);
+		return print_graph_return(field, s, entry, iter, flags);
 	}
 	case TRACE_STACK:
 	case TRACE_FN:
diff --git a/kernel/trace/trace_irqsoff.c b/kernel/trace/trace_irqsoff.c
index a4e799c1e767..1d3646ce9c34 100644
--- a/kernel/trace/trace_irqsoff.c
+++ b/kernel/trace/trace_irqsoff.c
@@ -221,6 +221,7 @@ static void irqsoff_graph_return(struct ftrace_graph_ret *trace,
 	unsigned long flags;
 	unsigned int trace_ctx;
 	u64 *calltime;
+	u64 rettime;
 	int size;
 
 	ftrace_graph_addr_finish(gops, trace);
@@ -228,13 +229,13 @@ static void irqsoff_graph_return(struct ftrace_graph_ret *trace,
 	if (!func_prolog_dec(tr, &data, &flags))
 		return;
 
+	rettime = trace_clock_local();
 	calltime = fgraph_retrieve_data(gops->idx, &size);
 	if (!calltime)
 		return;
-	trace->calltime = *calltime;
 
 	trace_ctx = tracing_gen_ctx_flags(flags);
-	__trace_graph_return(tr, trace, trace_ctx);
+	__trace_graph_return(tr, trace, trace_ctx, *calltime, rettime);
 	atomic_dec(&data->disabled);
 }
 
diff --git a/kernel/trace/trace_sched_wakeup.c b/kernel/trace/trace_sched_wakeup.c
index c58292e424d5..c4bbaae2a2a3 100644
--- a/kernel/trace/trace_sched_wakeup.c
+++ b/kernel/trace/trace_sched_wakeup.c
@@ -156,6 +156,7 @@ static void wakeup_graph_return(struct ftrace_graph_ret *trace,
 	struct trace_array_cpu *data;
 	unsigned int trace_ctx;
 	u64 *calltime;
+	u64 rettime;
 	int size;
 
 	ftrace_graph_addr_finish(gops, trace);
@@ -163,12 +164,13 @@ static void wakeup_graph_return(struct ftrace_graph_ret *trace,
 	if (!func_prolog_preempt_disable(tr, &data, &trace_ctx))
 		return;
 
+	rettime = trace_clock_local();
+
 	calltime = fgraph_retrieve_data(gops->idx, &size);
 	if (!calltime)
 		return;
-	trace->calltime = *calltime;
 
-	__trace_graph_return(tr, trace, trace_ctx);
+	__trace_graph_return(tr, trace, trace_ctx, *calltime, rettime);
 	atomic_dec(&data->disabled);
 
 	preempt_enable_notrace();
-- 
2.45.2

-- Steve

