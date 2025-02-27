Return-Path: <bpf+bounces-52792-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70D71A4885C
	for <lists+bpf@lfdr.de>; Thu, 27 Feb 2025 19:58:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C5A27A2596
	for <lists+bpf@lfdr.de>; Thu, 27 Feb 2025 18:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08D9526B97C;
	Thu, 27 Feb 2025 18:57:40 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 972311F5846;
	Thu, 27 Feb 2025 18:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740682659; cv=none; b=fHJSv8T6TxGKYoLNwM8ibrSxnjQr+gX5A0F8nDNfFd+bQYc88uzxR2jhNKeS4tPIz89f0tfKodW5v7GsYaaxi0IcEHKt3zhCDdLUiE79JfMroE3uT31jM/NT02WF2grH/PNVgyIuPYSaRbcVLA/Mqi169zUKZzV2f2Xv9srcti0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740682659; c=relaxed/simple;
	bh=DagFqMIJa8uuRMJxA+VJIa494CtgGToE2XAYGJaRNkk=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=gu3p3XCpTUdL/Xl9Qf4Rhj8B6/ucZeUw9Uro1ZgTWTP+IMHRxK2qydMCfHX0DV86lTUrSpU6oSCFPDp40/veCKKT1oLeogrGqFcfzR7SNKgYCTEBhjUS5zTQJdwSQEhKB3dCdG5ui+p06D+xHNQE9E0lz08VYmIaR2/T127GK6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C7CDC4CEE8;
	Thu, 27 Feb 2025 18:57:39 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tnj5S-00000009nRZ-41PN;
	Thu, 27 Feb 2025 13:58:22 -0500
Message-ID: <20250227185822.810321199@goodmis.org>
User-Agent: quilt/0.68
Date: Thu, 27 Feb 2025 13:58:06 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Sven Schnelle <svens@linux.ibm.com>,
 Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>,
 Guo Ren <guoren@kernel.org>,
 Donglin Peng <dolinux.peng@gmail.com>,
 Zheng Yejian <zhengyejian@huaweicloud.com>
Subject: [PATCH v4 2/4] ftrace: Add support for function argument to graph tracer
References: <20250227185804.639525399@goodmis.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Sven Schnelle <svens@linux.ibm.com>

Wire up the code to print function arguments in the function graph
tracer. This functionality can be enabled/disabled during runtime with
options/funcgraph-args.

Example usage:

6)              | dummy_xmit [dummy](skb = 0x8887c100, dev = 0x872ca000) {
6)              |   consume_skb(skb = 0x8887c100) {
6)              |     skb_release_head_state(skb = 0x8887c100) {
6)  0.178 us    |       sock_wfree(skb = 0x8887c100)
6)  0.627 us    |     }

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Co-developed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/Kconfig                 |   6 ++
 kernel/trace/trace.h                 |   1 +
 kernel/trace/trace_entries.h         |   7 +-
 kernel/trace/trace_functions_graph.c | 145 +++++++++++++++++++++------
 4 files changed, 124 insertions(+), 35 deletions(-)

diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index 60412c1012ef..033fba0633cf 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -268,6 +268,12 @@ config FUNCTION_TRACE_ARGS
 	depends on HAVE_FUNCTION_ARG_ACCESS_API
 	depends on DEBUG_INFO_BTF
 	default y
+	help
+	  If supported with function argument access API and BTF, then
+	  the function tracer and function graph tracer will support printing
+	  of function arguments. This feature is off by default, and can be
+	  enabled via the trace option func-args (for the function tracer) and
+	  funcgraph-args (for the function graph tracer)
 
 config DYNAMIC_FTRACE
 	bool "enable/disable function tracing dynamically"
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 9c21ba45b7af..6963cd83b6da 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -897,6 +897,7 @@ static __always_inline bool ftrace_hash_empty(struct ftrace_hash *hash)
 #define TRACE_GRAPH_PRINT_RETVAL        0x800
 #define TRACE_GRAPH_PRINT_RETVAL_HEX    0x1000
 #define TRACE_GRAPH_PRINT_RETADDR       0x2000
+#define TRACE_GRAPH_ARGS		0x4000
 #define TRACE_GRAPH_PRINT_FILL_SHIFT	28
 #define TRACE_GRAPH_PRINT_FILL_MASK	(0x3 << TRACE_GRAPH_PRINT_FILL_SHIFT)
 
diff --git a/kernel/trace/trace_entries.h b/kernel/trace/trace_entries.h
index fbfb396905a6..77a8ba3bc1e3 100644
--- a/kernel/trace/trace_entries.h
+++ b/kernel/trace/trace_entries.h
@@ -72,17 +72,18 @@ FTRACE_ENTRY_REG(function, ftrace_entry,
 );
 
 /* Function call entry */
-FTRACE_ENTRY_PACKED(funcgraph_entry, ftrace_graph_ent_entry,
+FTRACE_ENTRY(funcgraph_entry, ftrace_graph_ent_entry,
 
 	TRACE_GRAPH_ENT,
 
 	F_STRUCT(
 		__field_struct(	struct ftrace_graph_ent,	graph_ent	)
 		__field_packed(	unsigned long,	graph_ent,	func		)
-		__field_packed(	int,		graph_ent,	depth		)
+		__field_packed(	unsigned long,	graph_ent,	depth		)
+		__dynamic_array(unsigned long,	args				)
 	),
 
-	F_printk("--> %ps (%d)", (void *)__entry->func, __entry->depth)
+	F_printk("--> %ps (%lu)", (void *)__entry->func, __entry->depth)
 );
 
 #ifdef CONFIG_FUNCTION_GRAPH_RETADDR
diff --git a/kernel/trace/trace_functions_graph.c b/kernel/trace/trace_functions_graph.c
index 136c750b0b4d..5049fe25ceef 100644
--- a/kernel/trace/trace_functions_graph.c
+++ b/kernel/trace/trace_functions_graph.c
@@ -70,6 +70,10 @@ static struct tracer_opt trace_opts[] = {
 #ifdef CONFIG_FUNCTION_GRAPH_RETADDR
 	/* Display function return address ? */
 	{ TRACER_OPT(funcgraph-retaddr, TRACE_GRAPH_PRINT_RETADDR) },
+#endif
+#ifdef CONFIG_FUNCTION_TRACE_ARGS
+	/* Display function arguments ? */
+	{ TRACER_OPT(funcgraph-args, TRACE_GRAPH_ARGS) },
 #endif
 	/* Include sleep time (scheduled out) between entry and return */
 	{ TRACER_OPT(sleep-time, TRACE_GRAPH_SLEEP_TIME) },
@@ -110,25 +114,43 @@ static void
 print_graph_duration(struct trace_array *tr, unsigned long long duration,
 		     struct trace_seq *s, u32 flags);
 
-int __trace_graph_entry(struct trace_array *tr,
-				struct ftrace_graph_ent *trace,
-				unsigned int trace_ctx)
+static int __graph_entry(struct trace_array *tr, struct ftrace_graph_ent *trace,
+			 unsigned int trace_ctx, struct ftrace_regs *fregs)
 {
 	struct ring_buffer_event *event;
 	struct trace_buffer *buffer = tr->array_buffer.buffer;
 	struct ftrace_graph_ent_entry *entry;
+	int size;
 
-	event = trace_buffer_lock_reserve(buffer, TRACE_GRAPH_ENT,
-					  sizeof(*entry), trace_ctx);
+	/* If fregs is defined, add FTRACE_REGS_MAX_ARGS long size words */
+	size = sizeof(*entry) + (FTRACE_REGS_MAX_ARGS * !!fregs * sizeof(long));
+
+	event = trace_buffer_lock_reserve(buffer, TRACE_GRAPH_ENT, size, trace_ctx);
 	if (!event)
 		return 0;
-	entry	= ring_buffer_event_data(event);
-	entry->graph_ent			= *trace;
+
+	entry = ring_buffer_event_data(event);
+	entry->graph_ent = *trace;
+
+#ifdef CONFIG_HAVE_FUNCTION_ARG_ACCESS_API
+	if (fregs) {
+		for (int i = 0; i < FTRACE_REGS_MAX_ARGS; i++)
+			entry->args[i] = ftrace_regs_get_argument(fregs, i);
+	}
+#endif
+
 	trace_buffer_unlock_commit_nostack(buffer, event);
 
 	return 1;
 }
 
+int __trace_graph_entry(struct trace_array *tr,
+				struct ftrace_graph_ent *trace,
+				unsigned int trace_ctx)
+{
+	return __graph_entry(tr, trace, trace_ctx, NULL);
+}
+
 #ifdef CONFIG_FUNCTION_GRAPH_RETADDR
 int __trace_graph_retaddr_entry(struct trace_array *tr,
 				struct ftrace_graph_ent *trace,
@@ -174,9 +196,9 @@ struct fgraph_times {
 	unsigned long long		sleeptime; /* may be optional! */
 };
 
-int trace_graph_entry(struct ftrace_graph_ent *trace,
-		      struct fgraph_ops *gops,
-		      struct ftrace_regs *fregs)
+static int graph_entry(struct ftrace_graph_ent *trace,
+		       struct fgraph_ops *gops,
+		       struct ftrace_regs *fregs)
 {
 	unsigned long *task_var = fgraph_get_task_var(gops);
 	struct trace_array *tr = gops->private;
@@ -246,7 +268,7 @@ int trace_graph_entry(struct ftrace_graph_ent *trace,
 			unsigned long retaddr = ftrace_graph_top_ret_addr(current);
 			ret = __trace_graph_retaddr_entry(tr, trace, trace_ctx, retaddr);
 		} else {
-			ret = __trace_graph_entry(tr, trace, trace_ctx);
+			ret = __graph_entry(tr, trace, trace_ctx, fregs);
 		}
 	}
 	preempt_enable_notrace();
@@ -254,6 +276,20 @@ int trace_graph_entry(struct ftrace_graph_ent *trace,
 	return ret;
 }
 
+int trace_graph_entry(struct ftrace_graph_ent *trace,
+		      struct fgraph_ops *gops,
+		      struct ftrace_regs *fregs)
+{
+	return graph_entry(trace, gops, NULL);
+}
+
+static int trace_graph_entry_args(struct ftrace_graph_ent *trace,
+				  struct fgraph_ops *gops,
+				  struct ftrace_regs *fregs)
+{
+	return graph_entry(trace, gops, fregs);
+}
+
 static void
 __trace_graph_function(struct trace_array *tr,
 		unsigned long ip, unsigned int trace_ctx)
@@ -418,7 +454,10 @@ static int graph_trace_init(struct trace_array *tr)
 {
 	int ret;
 
-	tr->gops->entryfunc = trace_graph_entry;
+	if (tracer_flags_is_set(TRACE_GRAPH_ARGS))
+		tr->gops->entryfunc = trace_graph_entry_args;
+	else
+		tr->gops->entryfunc = trace_graph_entry;
 
 	if (tracing_thresh)
 		tr->gops->retfunc = trace_graph_thresh_return;
@@ -775,7 +814,7 @@ static void print_graph_retaddr(struct trace_seq *s, struct fgraph_retaddr_ent_e
 
 static void print_graph_retval(struct trace_seq *s, struct ftrace_graph_ent_entry *entry,
 				struct ftrace_graph_ret *graph_ret, void *func,
-				u32 opt_flags, u32 trace_flags)
+				u32 opt_flags, u32 trace_flags, int args_size)
 {
 	unsigned long err_code = 0;
 	unsigned long retval = 0;
@@ -809,7 +848,14 @@ static void print_graph_retval(struct trace_seq *s, struct ftrace_graph_ent_entr
 		if (entry->ent.type != TRACE_GRAPH_RETADDR_ENT)
 			print_retaddr = false;
 
-		trace_seq_printf(s, "%ps();", func);
+		trace_seq_printf(s, "%ps", func);
+
+		if (args_size >= FTRACE_REGS_MAX_ARGS * sizeof(long)) {
+			print_function_args(s, entry->args, (unsigned long)func);
+			trace_seq_putc(s, ';');
+		} else
+			trace_seq_puts(s, "();");
+
 		if (print_retval || print_retaddr)
 			trace_seq_puts(s, " /*");
 		else
@@ -836,7 +882,8 @@ static void print_graph_retval(struct trace_seq *s, struct ftrace_graph_ent_entr
 
 #else
 
-#define print_graph_retval(_seq, _ent, _ret, _func, _opt_flags, _trace_flags) do {} while (0)
+#define print_graph_retval(_seq, _ent, _ret, _func, _opt_flags, _trace_flags, args_size) \
+	do {} while (0)
 
 #endif
 
@@ -852,10 +899,14 @@ print_graph_entry_leaf(struct trace_iterator *iter,
 	struct ftrace_graph_ret *graph_ret;
 	struct ftrace_graph_ent *call;
 	unsigned long long duration;
+	unsigned long ret_func;
 	unsigned long func;
+	int args_size;
 	int cpu = iter->cpu;
 	int i;
 
+	args_size = iter->ent_size - offsetof(struct ftrace_graph_ent_entry, args);
+
 	graph_ret = &ret_entry->ret;
 	call = &entry->graph_ent;
 	duration = ret_entry->rettime - ret_entry->calltime;
@@ -887,16 +938,25 @@ print_graph_entry_leaf(struct trace_iterator *iter,
 	for (i = 0; i < call->depth * TRACE_GRAPH_INDENT; i++)
 		trace_seq_putc(s, ' ');
 
+	ret_func = graph_ret->func + iter->tr->text_delta;
+
 	/*
 	 * Write out the function return value or return address
 	 */
 	if (flags & (__TRACE_GRAPH_PRINT_RETVAL | __TRACE_GRAPH_PRINT_RETADDR)) {
 		print_graph_retval(s, entry, graph_ret,
 				   (void *)graph_ret->func + iter->tr->text_delta,
-				   flags, tr->trace_flags);
+				   flags, tr->trace_flags, args_size);
 	} else {
-		trace_seq_printf(s, "%ps();\n", (void *)func);
+		trace_seq_printf(s, "%ps", (void *)ret_func);
+
+		if (args_size >= FTRACE_REGS_MAX_ARGS * sizeof(long)) {
+			print_function_args(s, entry->args, ret_func);
+			trace_seq_putc(s, ';');
+		} else
+			trace_seq_puts(s, "();");
 	}
+	trace_seq_printf(s, "\n");
 
 	print_graph_irq(iter, graph_ret->func, TRACE_GRAPH_RET,
 			cpu, iter->ent->pid, flags);
@@ -913,6 +973,7 @@ print_graph_entry_nested(struct trace_iterator *iter,
 	struct fgraph_data *data = iter->private;
 	struct trace_array *tr = iter->tr;
 	unsigned long func;
+	int args_size;
 	int i;
 
 	if (data) {
@@ -937,7 +998,17 @@ print_graph_entry_nested(struct trace_iterator *iter,
 
 	func = call->func + iter->tr->text_delta;
 
-	trace_seq_printf(s, "%ps() {", (void *)func);
+	trace_seq_printf(s, "%ps", (void *)func);
+
+	args_size = iter->ent_size - offsetof(struct ftrace_graph_ent_entry, args);
+
+	if (args_size >= FTRACE_REGS_MAX_ARGS * sizeof(long))
+		print_function_args(s, entry->args, func);
+	else
+		trace_seq_puts(s, "()");
+
+	trace_seq_puts(s, " {");
+
 	if (flags & __TRACE_GRAPH_PRINT_RETADDR  &&
 		entry->ent.type == TRACE_GRAPH_RETADDR_ENT)
 		print_graph_retaddr(s, (struct fgraph_retaddr_ent_entry *)entry,
@@ -1107,21 +1178,38 @@ print_graph_entry(struct ftrace_graph_ent_entry *field, struct trace_seq *s,
 			struct trace_iterator *iter, u32 flags)
 {
 	struct fgraph_data *data = iter->private;
-	struct ftrace_graph_ent *call = &field->graph_ent;
+	struct ftrace_graph_ent *call;
 	struct ftrace_graph_ret_entry *leaf_ret;
 	static enum print_line_t ret;
 	int cpu = iter->cpu;
+	/*
+	 * print_graph_entry() may consume the current event,
+	 * thus @field may become invalid, so we need to save it.
+	 * sizeof(struct ftrace_graph_ent_entry) is very small,
+	 * it can be safely saved at the stack.
+	 */
+	struct ftrace_graph_ent_entry *entry;
+	u8 save_buf[sizeof(*entry) + FTRACE_REGS_MAX_ARGS * sizeof(long)];
+
+	/* The ent_size is expected to be as big as the entry */
+	if (iter->ent_size > sizeof(save_buf))
+		iter->ent_size = sizeof(save_buf);
+
+	entry = (void *)save_buf;
+	memcpy(entry, field, iter->ent_size);
+
+	call = &entry->graph_ent;
 
 	if (check_irq_entry(iter, flags, call->func, call->depth))
 		return TRACE_TYPE_HANDLED;
 
 	print_graph_prologue(iter, s, TRACE_GRAPH_ENT, call->func, flags);
 
-	leaf_ret = get_return_for_leaf(iter, field);
+	leaf_ret = get_return_for_leaf(iter, entry);
 	if (leaf_ret)
-		ret = print_graph_entry_leaf(iter, field, leaf_ret, s, flags);
+		ret = print_graph_entry_leaf(iter, entry, leaf_ret, s, flags);
 	else
-		ret = print_graph_entry_nested(iter, field, s, cpu, flags);
+		ret = print_graph_entry_nested(iter, entry, s, cpu, flags);
 
 	if (data) {
 		/*
@@ -1195,7 +1283,8 @@ print_graph_return(struct ftrace_graph_ret_entry *retentry, struct trace_seq *s,
 	 * funcgraph-retval option is enabled.
 	 */
 	if (flags & __TRACE_GRAPH_PRINT_RETVAL) {
-		print_graph_retval(s, NULL, trace, (void *)func, flags, tr->trace_flags);
+		print_graph_retval(s, NULL, trace, (void *)func, flags,
+				   tr->trace_flags, 0);
 	} else {
 		/*
 		 * If the return function does not have a matching entry,
@@ -1323,16 +1412,8 @@ print_graph_function_flags(struct trace_iterator *iter, u32 flags)
 
 	switch (entry->type) {
 	case TRACE_GRAPH_ENT: {
-		/*
-		 * print_graph_entry() may consume the current event,
-		 * thus @field may become invalid, so we need to save it.
-		 * sizeof(struct ftrace_graph_ent_entry) is very small,
-		 * it can be safely saved at the stack.
-		 */
-		struct ftrace_graph_ent_entry saved;
 		trace_assign_type(field, entry);
-		saved = *field;
-		return print_graph_entry(&saved, s, iter, flags);
+		return print_graph_entry(field, s, iter, flags);
 	}
 #ifdef CONFIG_FUNCTION_GRAPH_RETADDR
 	case TRACE_GRAPH_RETADDR_ENT: {
-- 
2.47.2



