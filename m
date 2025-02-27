Return-Path: <bpf+bounces-52793-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5D1EA48859
	for <lists+bpf@lfdr.de>; Thu, 27 Feb 2025 19:58:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B33CA1887A77
	for <lists+bpf@lfdr.de>; Thu, 27 Feb 2025 18:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1008E26BD8F;
	Thu, 27 Feb 2025 18:57:40 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0920215769;
	Thu, 27 Feb 2025 18:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740682659; cv=none; b=ZyTsvGAKv4VxSf1LF65JQexLNanbdbvoUGfgMjbRzvDNsjFXki0QL+fftO/yPLHddxUiLvjPvTyz4EJY+9YECcGTEIE0UC2b7vtxAgAmYHqTW9dDg+axU0yRwEzI7sXgi2/p61FL6OZ9CSzlywwFnsNROAPdZX0ChfLAsjHoqbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740682659; c=relaxed/simple;
	bh=75NhAFRF+JLlYAINhq+WwIi22Lhv7jwxXtxpD0YdsMY=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=rZ5nwDUGRkK0g2bCO9PXiluNYa4H7jlm6froCp5Qz9FhyVA3hR4gCQk0r8lO5PmlvCktYbk4KT5dwUM1ZQKZigHeHuw1WGw/GXta5jXN+09Lpw4F8u4nJdd/uhnPsvVPt3JbdmQWQmeOM1pMCn9PY9PCbmzav9I/X2UwN2GGNi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EF77C4CEE4;
	Thu, 27 Feb 2025 18:57:39 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tnj5T-00000009nSX-1GYc;
	Thu, 27 Feb 2025 13:58:23 -0500
Message-ID: <20250227185823.154996172@goodmis.org>
User-Agent: quilt/0.68
Date: Thu, 27 Feb 2025 13:58:08 -0500
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
Subject: [PATCH v4 4/4] ftrace: Add arguments to function tracer
References: <20250227185804.639525399@goodmis.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Sven Schnelle <svens@linux.ibm.com>

Wire up the code to print function arguments in the function tracer.
This functionality can be enabled/disabled during runtime with
options/func-args.

        ping-689     [004] b....    77.170220: dummy_xmit(skb = 0x82904800, dev = 0x882d0000) <-dev_hard_start_xmit

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Co-developed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace.c              | 14 ++++++++--
 kernel/trace/trace.h              |  4 ++-
 kernel/trace/trace_entries.h      |  5 ++--
 kernel/trace/trace_functions.c    | 46 +++++++++++++++++++++++++++----
 kernel/trace/trace_irqsoff.c      | 12 ++++++--
 kernel/trace/trace_output.c       | 18 ++++++++++--
 kernel/trace/trace_sched_wakeup.c |  4 +--
 7 files changed, 85 insertions(+), 18 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 0e6d517e74e0..cb13c88abfd6 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -2878,13 +2878,16 @@ trace_buffer_unlock_commit_nostack(struct trace_buffer *buffer,
 
 void
 trace_function(struct trace_array *tr, unsigned long ip, unsigned long
-	       parent_ip, unsigned int trace_ctx)
+	       parent_ip, unsigned int trace_ctx, struct ftrace_regs *fregs)
 {
 	struct trace_buffer *buffer = tr->array_buffer.buffer;
 	struct ring_buffer_event *event;
 	struct ftrace_entry *entry;
+	int size = sizeof(*entry);
 
-	event = __trace_buffer_lock_reserve(buffer, TRACE_FN, sizeof(*entry),
+	size += FTRACE_REGS_MAX_ARGS * !!fregs * sizeof(long);
+
+	event = __trace_buffer_lock_reserve(buffer, TRACE_FN, size,
 					    trace_ctx);
 	if (!event)
 		return;
@@ -2892,6 +2895,13 @@ trace_function(struct trace_array *tr, unsigned long ip, unsigned long
 	entry->ip			= ip;
 	entry->parent_ip		= parent_ip;
 
+#ifdef CONFIG_HAVE_FUNCTION_ARG_ACCESS_API
+	if (fregs) {
+		for (int i = 0; i < FTRACE_REGS_MAX_ARGS; i++)
+			entry->args[i] = ftrace_regs_get_argument(fregs, i);
+	}
+#endif
+
 	if (static_branch_unlikely(&trace_function_exports_enabled))
 		ftrace_exports(event, TRACE_EXPORT_FUNCTION);
 	__buffer_unlock_commit(buffer, event);
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 6963cd83b6da..32da87f45010 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -21,6 +21,7 @@
 #include <linux/workqueue.h>
 #include <linux/ctype.h>
 #include <linux/once_lite.h>
+#include <linux/ftrace_regs.h>
 
 #include "pid_list.h"
 
@@ -697,7 +698,8 @@ unsigned long trace_total_entries(struct trace_array *tr);
 void trace_function(struct trace_array *tr,
 		    unsigned long ip,
 		    unsigned long parent_ip,
-		    unsigned int trace_ctx);
+		    unsigned int trace_ctx,
+		    struct ftrace_regs *regs);
 void trace_graph_function(struct trace_array *tr,
 		    unsigned long ip,
 		    unsigned long parent_ip,
diff --git a/kernel/trace/trace_entries.h b/kernel/trace/trace_entries.h
index 77a8ba3bc1e3..ee40d4e6ad1c 100644
--- a/kernel/trace/trace_entries.h
+++ b/kernel/trace/trace_entries.h
@@ -61,8 +61,9 @@ FTRACE_ENTRY_REG(function, ftrace_entry,
 	TRACE_FN,
 
 	F_STRUCT(
-		__field_fn(	unsigned long,	ip		)
-		__field_fn(	unsigned long,	parent_ip	)
+		__field_fn(	unsigned long,		ip		)
+		__field_fn(	unsigned long,		parent_ip	)
+		__dynamic_array( unsigned long,		args		)
 	),
 
 	F_printk(" %ps <-- %ps",
diff --git a/kernel/trace/trace_functions.c b/kernel/trace/trace_functions.c
index df56f9b76010..98ccf3f00c51 100644
--- a/kernel/trace/trace_functions.c
+++ b/kernel/trace/trace_functions.c
@@ -25,6 +25,9 @@ static void
 function_trace_call(unsigned long ip, unsigned long parent_ip,
 		    struct ftrace_ops *op, struct ftrace_regs *fregs);
 static void
+function_args_trace_call(unsigned long ip, unsigned long parent_ip,
+			 struct ftrace_ops *op, struct ftrace_regs *fregs);
+static void
 function_stack_trace_call(unsigned long ip, unsigned long parent_ip,
 			  struct ftrace_ops *op, struct ftrace_regs *fregs);
 static void
@@ -42,9 +45,10 @@ enum {
 	TRACE_FUNC_NO_OPTS		= 0x0, /* No flags set. */
 	TRACE_FUNC_OPT_STACK		= 0x1,
 	TRACE_FUNC_OPT_NO_REPEATS	= 0x2,
+	TRACE_FUNC_OPT_ARGS		= 0x4,
 
 	/* Update this to next highest bit. */
-	TRACE_FUNC_OPT_HIGHEST_BIT	= 0x4
+	TRACE_FUNC_OPT_HIGHEST_BIT	= 0x8
 };
 
 #define TRACE_FUNC_OPT_MASK	(TRACE_FUNC_OPT_HIGHEST_BIT - 1)
@@ -114,6 +118,8 @@ static ftrace_func_t select_trace_function(u32 flags_val)
 	switch (flags_val & TRACE_FUNC_OPT_MASK) {
 	case TRACE_FUNC_NO_OPTS:
 		return function_trace_call;
+	case TRACE_FUNC_OPT_ARGS:
+		return function_args_trace_call;
 	case TRACE_FUNC_OPT_STACK:
 		return function_stack_trace_call;
 	case TRACE_FUNC_OPT_NO_REPEATS:
@@ -220,7 +226,34 @@ function_trace_call(unsigned long ip, unsigned long parent_ip,
 
 	data = this_cpu_ptr(tr->array_buffer.data);
 	if (!atomic_read(&data->disabled))
-		trace_function(tr, ip, parent_ip, trace_ctx);
+		trace_function(tr, ip, parent_ip, trace_ctx, NULL);
+
+	ftrace_test_recursion_unlock(bit);
+}
+
+static void
+function_args_trace_call(unsigned long ip, unsigned long parent_ip,
+			 struct ftrace_ops *op, struct ftrace_regs *fregs)
+{
+	struct trace_array *tr = op->private;
+	struct trace_array_cpu *data;
+	unsigned int trace_ctx;
+	int bit;
+	int cpu;
+
+	if (unlikely(!tr->function_enabled))
+		return;
+
+	bit = ftrace_test_recursion_trylock(ip, parent_ip);
+	if (bit < 0)
+		return;
+
+	trace_ctx = tracing_gen_ctx();
+
+	cpu = smp_processor_id();
+	data = per_cpu_ptr(tr->array_buffer.data, cpu);
+	if (!atomic_read(&data->disabled))
+		trace_function(tr, ip, parent_ip, trace_ctx, fregs);
 
 	ftrace_test_recursion_unlock(bit);
 }
@@ -270,7 +303,7 @@ function_stack_trace_call(unsigned long ip, unsigned long parent_ip,
 
 	if (likely(disabled == 1)) {
 		trace_ctx = tracing_gen_ctx_flags(flags);
-		trace_function(tr, ip, parent_ip, trace_ctx);
+		trace_function(tr, ip, parent_ip, trace_ctx, NULL);
 #ifdef CONFIG_UNWINDER_FRAME_POINTER
 		if (ftrace_pids_enabled(op))
 			skip++;
@@ -349,7 +382,7 @@ function_no_repeats_trace_call(unsigned long ip, unsigned long parent_ip,
 	trace_ctx = tracing_gen_ctx_dec();
 	process_repeats(tr, ip, parent_ip, last_info, trace_ctx);
 
-	trace_function(tr, ip, parent_ip, trace_ctx);
+	trace_function(tr, ip, parent_ip, trace_ctx, NULL);
 
 out:
 	ftrace_test_recursion_unlock(bit);
@@ -389,7 +422,7 @@ function_stack_no_repeats_trace_call(unsigned long ip, unsigned long parent_ip,
 		trace_ctx = tracing_gen_ctx_flags(flags);
 		process_repeats(tr, ip, parent_ip, last_info, trace_ctx);
 
-		trace_function(tr, ip, parent_ip, trace_ctx);
+		trace_function(tr, ip, parent_ip, trace_ctx, NULL);
 		__trace_stack(tr, trace_ctx, STACK_SKIP);
 	}
 
@@ -403,6 +436,9 @@ static struct tracer_opt func_opts[] = {
 	{ TRACER_OPT(func_stack_trace, TRACE_FUNC_OPT_STACK) },
 #endif
 	{ TRACER_OPT(func-no-repeats, TRACE_FUNC_OPT_NO_REPEATS) },
+#ifdef CONFIG_FUNCTION_TRACE_ARGS
+	{ TRACER_OPT(func-args, TRACE_FUNC_OPT_ARGS) },
+#endif
 	{ } /* Always set a last empty entry */
 };
 
diff --git a/kernel/trace/trace_irqsoff.c b/kernel/trace/trace_irqsoff.c
index 7294ad676379..c8bfa7310a91 100644
--- a/kernel/trace/trace_irqsoff.c
+++ b/kernel/trace/trace_irqsoff.c
@@ -150,7 +150,7 @@ irqsoff_tracer_call(unsigned long ip, unsigned long parent_ip,
 
 	trace_ctx = tracing_gen_ctx_flags(flags);
 
-	trace_function(tr, ip, parent_ip, trace_ctx);
+	trace_function(tr, ip, parent_ip, trace_ctx, fregs);
 
 	atomic_dec(&data->disabled);
 }
@@ -295,11 +295,17 @@ __trace_function(struct trace_array *tr,
 	if (is_graph(tr))
 		trace_graph_function(tr, ip, parent_ip, trace_ctx);
 	else
-		trace_function(tr, ip, parent_ip, trace_ctx);
+		trace_function(tr, ip, parent_ip, trace_ctx, NULL);
 }
 
 #else
-#define __trace_function trace_function
+static inline void
+__trace_function(struct trace_array *tr,
+		 unsigned long ip, unsigned long parent_ip,
+		 unsigned int trace_ctx)
+{
+	return trace_function(tr, ip, parent_ip, trace_ctx, NULL);
+}
 
 static enum print_line_t irqsoff_print_line(struct trace_iterator *iter)
 {
diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
index 4b721cd4f21d..b51ee9373773 100644
--- a/kernel/trace/trace_output.c
+++ b/kernel/trace/trace_output.c
@@ -1090,12 +1090,15 @@ enum print_line_t trace_nop_print(struct trace_iterator *iter, int flags,
 }
 
 static void print_fn_trace(struct trace_seq *s, unsigned long ip,
-			   unsigned long parent_ip, long delta, int flags)
+			   unsigned long parent_ip, long delta,
+			   unsigned long *args, int flags)
 {
 	ip += delta;
 	parent_ip += delta;
 
 	seq_print_ip_sym(s, ip, flags);
+	if (args)
+		print_function_args(s, args, ip);
 
 	if ((flags & TRACE_ITER_PRINT_PARENT) && parent_ip) {
 		trace_seq_puts(s, " <-");
@@ -1109,10 +1112,19 @@ static enum print_line_t trace_fn_trace(struct trace_iterator *iter, int flags,
 {
 	struct ftrace_entry *field;
 	struct trace_seq *s = &iter->seq;
+	unsigned long *args;
+	int args_size;
 
 	trace_assign_type(field, iter->ent);
 
-	print_fn_trace(s, field->ip, field->parent_ip, iter->tr->text_delta, flags);
+	args_size = iter->ent_size - offsetof(struct ftrace_entry, args);
+	if (args_size >= FTRACE_REGS_MAX_ARGS * sizeof(long))
+		args = field->args;
+	else
+		args = NULL;
+
+	print_fn_trace(s, field->ip, field->parent_ip, iter->tr->text_delta,
+		       args, flags);
 	trace_seq_putc(s, '\n');
 
 	return trace_handle_return(s);
@@ -1785,7 +1797,7 @@ trace_func_repeats_print(struct trace_iterator *iter, int flags,
 
 	trace_assign_type(field, iter->ent);
 
-	print_fn_trace(s, field->ip, field->parent_ip, iter->tr->text_delta, flags);
+	print_fn_trace(s, field->ip, field->parent_ip, iter->tr->text_delta, NULL, flags);
 	trace_seq_printf(s, " (repeats: %u, last_ts:", field->count);
 	trace_print_time(s, iter,
 			 iter->ts - FUNC_REPEATS_GET_DELTA_TS(field));
diff --git a/kernel/trace/trace_sched_wakeup.c b/kernel/trace/trace_sched_wakeup.c
index af30586f1aea..c9ba4259e03e 100644
--- a/kernel/trace/trace_sched_wakeup.c
+++ b/kernel/trace/trace_sched_wakeup.c
@@ -242,7 +242,7 @@ wakeup_tracer_call(unsigned long ip, unsigned long parent_ip,
 		return;
 
 	local_irq_save(flags);
-	trace_function(tr, ip, parent_ip, trace_ctx);
+	trace_function(tr, ip, parent_ip, trace_ctx, fregs);
 	local_irq_restore(flags);
 
 	atomic_dec(&data->disabled);
@@ -327,7 +327,7 @@ __trace_function(struct trace_array *tr,
 	if (is_graph(tr))
 		trace_graph_function(tr, ip, parent_ip, trace_ctx);
 	else
-		trace_function(tr, ip, parent_ip, trace_ctx);
+		trace_function(tr, ip, parent_ip, trace_ctx, NULL);
 }
 
 static int wakeup_flag_changed(struct trace_array *tr, u32 mask, int set)
-- 
2.47.2



