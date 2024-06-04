Return-Path: <bpf+bounces-31315-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB9538FB5E7
	for <lists+bpf@lfdr.de>; Tue,  4 Jun 2024 16:45:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11D29B25336
	for <lists+bpf@lfdr.de>; Tue,  4 Jun 2024 14:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAFAA148823;
	Tue,  4 Jun 2024 14:42:15 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8042F145B15;
	Tue,  4 Jun 2024 14:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717512135; cv=none; b=YPf3l9JXjHyLNZwsuTuk6mLJS9XlN6hSi4wK6VD4iEFOrTdz6+e1dC4MXE8fQaullw6UYCIvB1TXkZHcUsw7ZNi9xE0WyKbw1VJDY+NbgRonaQH0yaOM/wDNi1rx7CZf9LERevXuRgxfvN7LmqGlstyDhhUjkl/jZbW3oztR9gI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717512135; c=relaxed/simple;
	bh=gwxWSDjJ6ZBmno0UkDC0BBNUvvuDtspNYwFi/Euql8o=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=ADUoYN//8oopL3hRPv+RFit7Xgnrxg2ROgbxoQfDyQGdr3NummvJM48dyG45RvgKQO23Z1vIdRSuWcPFHhD73Ht0FegTJwpL9gddbwEvZU+1jZVJWd0cYRUkNUXNyBlyv07bwFgSslAD6gGTidut4Tqp+aj2gThV1xGsX8c1T5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36268C4AF4D;
	Tue,  4 Jun 2024 14:42:15 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1sEVMd-00000000Yw5-0Ife;
	Tue, 04 Jun 2024 10:42:15 -0400
Message-ID: <20240604144214.931683001@goodmis.org>
User-Agent: quilt/0.68
Date: Tue, 04 Jun 2024 10:41:09 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Florent Revest <revest@chromium.org>,
 Martin KaFai Lau <martin.lau@linux.dev>,
 bpf <bpf@vger.kernel.org>,
 Sven Schnelle <svens@linux.ibm.com>,
 Alexei Starovoitov <ast@kernel.org>,
 Jiri Olsa <jolsa@kernel.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Alan Maguire <alan.maguire@oracle.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Guo Ren <guoren@kernel.org>
Subject: [for-next][PATCH 06/27] function_graph: Remove logic around ftrace_graph_entry and return
References: <20240604144103.293353991@goodmis.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

The function pointers ftrace_graph_entry and ftrace_graph_return are no
longer called via the function_graph tracer. Instead, an array structure is
now used that will allow for multiple users of the function_graph
infrastructure. The variables are still used by the architecture code for
non dynamic ftrace configs, where a test is made against them to see if
they point to the default stub function or not. This is how the static
function tracing knows to call into the function graph tracer
infrastructure or not.

Two new stub functions are made. entry_run() and return_run(). The
ftrace_graph_entry and ftrace_graph_return are set to them respectively
when the function graph tracer is enabled, and this will trigger the
architecture specific function graph code to be executed.

This also requires checking the global_ops hash for all calls into the
function_graph tracer.

Co-developed with Masami Hiramatsu:
Link: https://lore.kernel.org/linux-trace-kernel/171509097408.162236.17387844142114638932.stgit@devnote2
Link: https://lore.kernel.org/linux-trace-kernel/20240603190821.872127216@goodmis.org

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Florent Revest <revest@chromium.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>
Cc: bpf <bpf@vger.kernel.org>
Cc: Sven Schnelle <svens@linux.ibm.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Alan Maguire <alan.maguire@oracle.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Guo Ren <guoren@kernel.org>
Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/fgraph.c          | 67 ++++++++--------------------------
 kernel/trace/ftrace.c          |  2 -
 kernel/trace/ftrace_internal.h |  2 -
 3 files changed, 15 insertions(+), 56 deletions(-)

diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index 8de2a2662281..2b52afa03ab4 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -163,6 +163,17 @@ set_bitmap(struct task_struct *t, int offset, unsigned long bitmap)
 		(FGRAPH_TYPE_BITMAP << FGRAPH_TYPE_SHIFT) | FGRAPH_FRAME_OFFSET;
 }
 
+/* ftrace_graph_entry set to this to tell some archs to run function graph */
+static int entry_run(struct ftrace_graph_ent *trace)
+{
+	return 0;
+}
+
+/* ftrace_graph_return set to this to tell some archs to run function graph */
+static void return_run(struct ftrace_graph_ret *trace)
+{
+}
+
 /*
  * @offset: The offset into @t->ret_stack to find the ret_stack entry
  * @frame_offset: Where to place the offset into @t->ret_stack of that entry
@@ -675,7 +686,6 @@ extern void ftrace_stub_graph(struct ftrace_graph_ret *);
 /* The callbacks that hook a function */
 trace_func_graph_ret_t ftrace_graph_return = ftrace_stub_graph;
 trace_func_graph_ent_t ftrace_graph_entry = ftrace_graph_entry_stub;
-static trace_func_graph_ent_t __ftrace_graph_entry = ftrace_graph_entry_stub;
 
 /* Try to assign a return stack array on FTRACE_RETSTACK_ALLOC_SIZE tasks. */
 static int alloc_retstack_tasklist(unsigned long **ret_stack_list)
@@ -758,46 +768,6 @@ ftrace_graph_probe_sched_switch(void *ignore, bool preempt,
 	}
 }
 
-static int ftrace_graph_entry_test(struct ftrace_graph_ent *trace)
-{
-	if (!ftrace_ops_test(&global_ops, trace->func, NULL))
-		return 0;
-	return __ftrace_graph_entry(trace);
-}
-
-/*
- * The function graph tracer should only trace the functions defined
- * by set_ftrace_filter and set_ftrace_notrace. If another function
- * tracer ops is registered, the graph tracer requires testing the
- * function against the global ops, and not just trace any function
- * that any ftrace_ops registered.
- */
-void update_function_graph_func(void)
-{
-	struct ftrace_ops *op;
-	bool do_test = false;
-
-	/*
-	 * The graph and global ops share the same set of functions
-	 * to test. If any other ops is on the list, then
-	 * the graph tracing needs to test if its the function
-	 * it should call.
-	 */
-	do_for_each_ftrace_op(op, ftrace_ops_list) {
-		if (op != &global_ops && op != &graph_ops &&
-		    op != &ftrace_list_end) {
-			do_test = true;
-			/* in double loop, break out with goto */
-			goto out;
-		}
-	} while_for_each_ftrace_op(op);
- out:
-	if (do_test)
-		ftrace_graph_entry = ftrace_graph_entry_test;
-	else
-		ftrace_graph_entry = __ftrace_graph_entry;
-}
-
 static DEFINE_PER_CPU(unsigned long *, idle_ret_stack);
 
 static void
@@ -939,18 +909,12 @@ int register_ftrace_graph(struct fgraph_ops *gops)
 			ftrace_graph_active--;
 			goto out;
 		}
-
-		ftrace_graph_return = gops->retfunc;
-
 		/*
-		 * Update the indirect function to the entryfunc, and the
-		 * function that gets called to the entry_test first. Then
-		 * call the update fgraph entry function to determine if
-		 * the entryfunc should be called directly or not.
+		 * Some archs just test to see if these are not
+		 * the default function
 		 */
-		__ftrace_graph_entry = gops->entryfunc;
-		ftrace_graph_entry = ftrace_graph_entry_test;
-		update_function_graph_func();
+		ftrace_graph_return = return_run;
+		ftrace_graph_entry = entry_run;
 
 		ret = ftrace_startup(&graph_ops, FTRACE_START_FUNC_RET);
 	}
@@ -986,7 +950,6 @@ void unregister_ftrace_graph(struct fgraph_ops *gops)
 	if (!ftrace_graph_active) {
 		ftrace_graph_return = ftrace_stub_graph;
 		ftrace_graph_entry = ftrace_graph_entry_stub;
-		__ftrace_graph_entry = ftrace_graph_entry_stub;
 		ftrace_shutdown(&graph_ops, FTRACE_STOP_FUNC_RET);
 		unregister_pm_notifier(&ftrace_suspend_notifier);
 		unregister_trace_sched_switch(ftrace_graph_probe_sched_switch, NULL);
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 65208d3b5ed9..789950a4f977 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -235,8 +235,6 @@ static void update_ftrace_function(void)
 		func = ftrace_ops_list_func;
 	}
 
-	update_function_graph_func();
-
 	/* If there's no change, then do nothing more here */
 	if (ftrace_trace_function == func)
 		return;
diff --git a/kernel/trace/ftrace_internal.h b/kernel/trace/ftrace_internal.h
index 5012c04f92c0..19eddcb91584 100644
--- a/kernel/trace/ftrace_internal.h
+++ b/kernel/trace/ftrace_internal.h
@@ -42,10 +42,8 @@ ftrace_ops_test(struct ftrace_ops *ops, unsigned long ip, void *regs)
 
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 extern int ftrace_graph_active;
-void update_function_graph_func(void);
 #else /* !CONFIG_FUNCTION_GRAPH_TRACER */
 # define ftrace_graph_active 0
-static inline void update_function_graph_func(void) { }
 #endif /* CONFIG_FUNCTION_GRAPH_TRACER */
 
 #else /* !CONFIG_FUNCTION_TRACER */
-- 
2.43.0



