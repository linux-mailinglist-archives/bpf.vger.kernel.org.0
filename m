Return-Path: <bpf+bounces-31238-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 002BF8D8975
	for <lists+bpf@lfdr.de>; Mon,  3 Jun 2024 21:09:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F7E51F25729
	for <lists+bpf@lfdr.de>; Mon,  3 Jun 2024 19:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7D2013CFAE;
	Mon,  3 Jun 2024 19:07:13 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B00613C9CB;
	Mon,  3 Jun 2024 19:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717441633; cv=none; b=GAAvrRAMwB0GCwu1HvzWgqGPk+yHrrPcUMXhCCh0eFZzNNLeZtrKRwiktNko/Rqu3HenPuyCng/fU/4Zibo0/oLKVuFKtyWEFhbNfYhp49kFdyPdD1CC6VAjmhEkj450Cmu6zg4Nq1iIydCd03INl6DJFE/N/ad2u764ZGQZyNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717441633; c=relaxed/simple;
	bh=5vP7LU+WvCSqhD95VhYGPJTlxUOvQQo+n/mkh1PhL1g=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=jzjCyyHTaHTmxShRjBa/C5ScQN6nklgeHLXDQaec5Mhh5C4aft5UmV9bjvOtfeW6wzj6bjDYdnJumgU8HSlMQgxrEJq13oERr8HWO0FUsuFGF7gUMID61EAEwc3JqnmozqELaUzZqge+vk+sCIkK6SrBzk0BASjilWOK5NQ1oSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93E46C4AF0D;
	Mon,  3 Jun 2024 19:07:12 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1sED2d-00000009Ttx-2ZsO;
	Mon, 03 Jun 2024 15:08:23 -0400
Message-ID: <20240603190823.472955399@goodmis.org>
User-Agent: quilt/0.68
Date: Mon, 03 Jun 2024 15:07:20 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
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
Subject: [PATCH v3 16/27] function_graph: Move set_graph_function tests to shadow stack global
 var
References: <20240603190704.663840775@goodmis.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

The use of the task->trace_recursion for the logic used for the
set_graph_function was a bit of an abuse of that variable. Now that there
exists global vars that are per stack for registered graph traces, use that
instead.

Link: https://lore.kernel.org/linux-trace-kernel/171509105520.162236.10339831553995971290.stgit@devnote2

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/linux/trace_recursion.h      |  5 +----
 kernel/trace/trace.h                 | 32 ++++++++++++++++++----------
 kernel/trace/trace_functions_graph.c |  6 +++---
 kernel/trace/trace_irqsoff.c         |  4 ++--
 kernel/trace/trace_sched_wakeup.c    |  4 ++--
 5 files changed, 29 insertions(+), 22 deletions(-)

diff --git a/include/linux/trace_recursion.h b/include/linux/trace_recursion.h
index 24ea8ac049b4..02e6afc6d7fe 100644
--- a/include/linux/trace_recursion.h
+++ b/include/linux/trace_recursion.h
@@ -44,9 +44,6 @@ enum {
  */
 	TRACE_IRQ_BIT,
 
-	/* Set if the function is in the set_graph_function file */
-	TRACE_GRAPH_BIT,
-
 	/*
 	 * In the very unlikely case that an interrupt came in
 	 * at a start of graph tracing, and we want to trace
@@ -60,7 +57,7 @@ enum {
 	 * that preempted a softirq start of a function that
 	 * preempted normal context!!!! Luckily, it can't be
 	 * greater than 3, so the next two bits are a mask
-	 * of what the depth is when we set TRACE_GRAPH_BIT
+	 * of what the depth is when we set TRACE_GRAPH_FL
 	 */
 
 	TRACE_GRAPH_DEPTH_START_BIT,
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index f06b5ddd3580..73919129e57c 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -898,11 +898,16 @@ extern void init_array_fgraph_ops(struct trace_array *tr, struct ftrace_ops *ops
 extern int allocate_fgraph_ops(struct trace_array *tr, struct ftrace_ops *ops);
 extern void free_fgraph_ops(struct trace_array *tr);
 
+enum {
+	TRACE_GRAPH_FL		= 1,
+};
+
 #ifdef CONFIG_DYNAMIC_FTRACE
 extern struct ftrace_hash __rcu *ftrace_graph_hash;
 extern struct ftrace_hash __rcu *ftrace_graph_notrace_hash;
 
-static inline int ftrace_graph_addr(struct ftrace_graph_ent *trace)
+static inline int
+ftrace_graph_addr(unsigned long *task_var, struct ftrace_graph_ent *trace)
 {
 	unsigned long addr = trace->func;
 	int ret = 0;
@@ -924,12 +929,11 @@ static inline int ftrace_graph_addr(struct ftrace_graph_ent *trace)
 	}
 
 	if (ftrace_lookup_ip(hash, addr)) {
-
 		/*
 		 * This needs to be cleared on the return functions
 		 * when the depth is zero.
 		 */
-		trace_recursion_set(TRACE_GRAPH_BIT);
+		*task_var |= TRACE_GRAPH_FL;
 		trace_recursion_set_depth(trace->depth);
 
 		/*
@@ -949,11 +953,14 @@ static inline int ftrace_graph_addr(struct ftrace_graph_ent *trace)
 	return ret;
 }
 
-static inline void ftrace_graph_addr_finish(struct ftrace_graph_ret *trace)
+static inline void
+ftrace_graph_addr_finish(struct fgraph_ops *gops, struct ftrace_graph_ret *trace)
 {
-	if (trace_recursion_test(TRACE_GRAPH_BIT) &&
+	unsigned long *task_var = fgraph_get_task_var(gops);
+
+	if ((*task_var & TRACE_GRAPH_FL) &&
 	    trace->depth == trace_recursion_depth())
-		trace_recursion_clear(TRACE_GRAPH_BIT);
+		*task_var &= ~TRACE_GRAPH_FL;
 }
 
 static inline int ftrace_graph_notrace_addr(unsigned long addr)
@@ -979,7 +986,7 @@ static inline int ftrace_graph_notrace_addr(unsigned long addr)
 	return ret;
 }
 #else
-static inline int ftrace_graph_addr(struct ftrace_graph_ent *trace)
+static inline int ftrace_graph_addr(unsigned long *task_var, struct ftrace_graph_ent *trace)
 {
 	return 1;
 }
@@ -988,17 +995,20 @@ static inline int ftrace_graph_notrace_addr(unsigned long addr)
 {
 	return 0;
 }
-static inline void ftrace_graph_addr_finish(struct ftrace_graph_ret *trace)
+static inline void ftrace_graph_addr_finish(struct fgraph_ops *gops, struct ftrace_graph_ret *trace)
 { }
 #endif /* CONFIG_DYNAMIC_FTRACE */
 
 extern unsigned int fgraph_max_depth;
 
-static inline bool ftrace_graph_ignore_func(struct ftrace_graph_ent *trace)
+static inline bool
+ftrace_graph_ignore_func(struct fgraph_ops *gops, struct ftrace_graph_ent *trace)
 {
+	unsigned long *task_var = fgraph_get_task_var(gops);
+
 	/* trace it when it is-nested-in or is a function enabled. */
-	return !(trace_recursion_test(TRACE_GRAPH_BIT) ||
-		 ftrace_graph_addr(trace)) ||
+	return !((*task_var & TRACE_GRAPH_FL) ||
+		 ftrace_graph_addr(task_var, trace)) ||
 		(trace->depth < 0) ||
 		(fgraph_max_depth && trace->depth >= fgraph_max_depth);
 }
diff --git a/kernel/trace/trace_functions_graph.c b/kernel/trace/trace_functions_graph.c
index 7f30652f0e97..66cce73e94f8 100644
--- a/kernel/trace/trace_functions_graph.c
+++ b/kernel/trace/trace_functions_graph.c
@@ -160,7 +160,7 @@ int trace_graph_entry(struct ftrace_graph_ent *trace,
 	if (!ftrace_trace_task(tr))
 		return 0;
 
-	if (ftrace_graph_ignore_func(trace))
+	if (ftrace_graph_ignore_func(gops, trace))
 		return 0;
 
 	if (ftrace_graph_ignore_irqs())
@@ -247,7 +247,7 @@ void trace_graph_return(struct ftrace_graph_ret *trace,
 	long disabled;
 	int cpu;
 
-	ftrace_graph_addr_finish(trace);
+	ftrace_graph_addr_finish(gops, trace);
 
 	if (trace_recursion_test(TRACE_GRAPH_NOTRACE_BIT)) {
 		trace_recursion_clear(TRACE_GRAPH_NOTRACE_BIT);
@@ -269,7 +269,7 @@ void trace_graph_return(struct ftrace_graph_ret *trace,
 static void trace_graph_thresh_return(struct ftrace_graph_ret *trace,
 				      struct fgraph_ops *gops)
 {
-	ftrace_graph_addr_finish(trace);
+	ftrace_graph_addr_finish(gops, trace);
 
 	if (trace_recursion_test(TRACE_GRAPH_NOTRACE_BIT)) {
 		trace_recursion_clear(TRACE_GRAPH_NOTRACE_BIT);
diff --git a/kernel/trace/trace_irqsoff.c b/kernel/trace/trace_irqsoff.c
index 5478f4c4f708..fce064e20570 100644
--- a/kernel/trace/trace_irqsoff.c
+++ b/kernel/trace/trace_irqsoff.c
@@ -184,7 +184,7 @@ static int irqsoff_graph_entry(struct ftrace_graph_ent *trace,
 	unsigned int trace_ctx;
 	int ret;
 
-	if (ftrace_graph_ignore_func(trace))
+	if (ftrace_graph_ignore_func(gops, trace))
 		return 0;
 	/*
 	 * Do not trace a function if it's filtered by set_graph_notrace.
@@ -214,7 +214,7 @@ static void irqsoff_graph_return(struct ftrace_graph_ret *trace,
 	unsigned long flags;
 	unsigned int trace_ctx;
 
-	ftrace_graph_addr_finish(trace);
+	ftrace_graph_addr_finish(gops, trace);
 
 	if (!func_prolog_dec(tr, &data, &flags))
 		return;
diff --git a/kernel/trace/trace_sched_wakeup.c b/kernel/trace/trace_sched_wakeup.c
index 49bcc812652c..130ca7e7787e 100644
--- a/kernel/trace/trace_sched_wakeup.c
+++ b/kernel/trace/trace_sched_wakeup.c
@@ -120,7 +120,7 @@ static int wakeup_graph_entry(struct ftrace_graph_ent *trace,
 	unsigned int trace_ctx;
 	int ret = 0;
 
-	if (ftrace_graph_ignore_func(trace))
+	if (ftrace_graph_ignore_func(gops, trace))
 		return 0;
 	/*
 	 * Do not trace a function if it's filtered by set_graph_notrace.
@@ -149,7 +149,7 @@ static void wakeup_graph_return(struct ftrace_graph_ret *trace,
 	struct trace_array_cpu *data;
 	unsigned int trace_ctx;
 
-	ftrace_graph_addr_finish(trace);
+	ftrace_graph_addr_finish(gops, trace);
 
 	if (!func_prolog_preempt_disable(tr, &data, &trace_ctx))
 		return;
-- 
2.43.0



