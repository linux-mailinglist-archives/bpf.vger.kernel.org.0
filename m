Return-Path: <bpf+bounces-14496-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DFF0D7E58C6
	for <lists+bpf@lfdr.de>; Wed,  8 Nov 2023 15:27:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8061BB20E64
	for <lists+bpf@lfdr.de>; Wed,  8 Nov 2023 14:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B49731A70B;
	Wed,  8 Nov 2023 14:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iCCx/cta"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D7F8199DA;
	Wed,  8 Nov 2023 14:27:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 868F3C433C7;
	Wed,  8 Nov 2023 14:27:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699453629;
	bh=fGXN2qZeLvCA8Erebbw3zTWQfZLdoNHyNwm1QJyPyZ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iCCx/cta6/+goovuazbQZpAUIUo/SxNVtoIfX2VjVwi4ZWueMW+MLKgTI+L8rMYuu
	 e8999EOQdQZU+p61SayKteJcfs93lrpwv/NeT3eqwlRbeYRoyDckAkK5ZP/yDqIbvF
	 wk5TjGbfsB4qrvC53kTNmkSgua58eXr2pV54C23QBpQlNi2b1JqHvj9oS1d6GnjpuZ
	 PAK2do9SNmTWjXGKQ/aEfLqy72pLK+2xfVZSo3mQYwxFYQX/0GrDZBGq6f+NCkeUwh
	 SSaHp6b9pM2G91HVf3qK4PKMZGQCTkwJQCHA0WRGWrtsNuRokYG50OCdx9q8H3Xky9
	 jpd1x1R4yOXnw==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Florent Revest <revest@chromium.org>
Cc: linux-trace-kernel@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	bpf <bpf@vger.kernel.org>,
	Sven Schnelle <svens@linux.ibm.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alan Maguire <alan.maguire@oracle.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Guo Ren <guoren@kernel.org>
Subject: [RFC PATCH v2 14/31] function_graph: Move set_graph_function tests to shadow stack global var
Date: Wed,  8 Nov 2023 23:27:04 +0900
Message-Id: <169945362406.55307.7939383981224458445.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <169945345785.55307.5003201137843449313.stgit@devnote2>
References: <169945345785.55307.5003201137843449313.stgit@devnote2>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Steven Rostedt (VMware) <rostedt@goodmis.org>

The use of the task->trace_recursion for the logic used for the
set_graph_funnction was a bit of an abuse of that variable. Now that there
exists global vars that are per stack for registered graph traces, use that
instead.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 include/linux/trace_recursion.h      |    5 +----
 kernel/trace/trace.h                 |   32 +++++++++++++++++++++-----------
 kernel/trace/trace_functions_graph.c |    6 +++---
 kernel/trace/trace_irqsoff.c         |    4 ++--
 kernel/trace/trace_sched_wakeup.c    |    4 ++--
 5 files changed, 29 insertions(+), 22 deletions(-)

diff --git a/include/linux/trace_recursion.h b/include/linux/trace_recursion.h
index d48cd92d2364..2efd5ec46d7f 100644
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
index f77322e3b177..60d38709ab91 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -889,11 +889,16 @@ extern void init_array_fgraph_ops(struct trace_array *tr, struct ftrace_ops *ops
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
@@ -915,12 +920,11 @@ static inline int ftrace_graph_addr(struct ftrace_graph_ent *trace)
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
@@ -940,11 +944,14 @@ static inline int ftrace_graph_addr(struct ftrace_graph_ent *trace)
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
@@ -971,7 +978,7 @@ static inline int ftrace_graph_notrace_addr(unsigned long addr)
 }
 
 #else
-static inline int ftrace_graph_addr(struct ftrace_graph_ent *trace)
+static inline int ftrace_graph_addr(unsigned long *task_var, struct ftrace_graph_ent *trace)
 {
 	return 1;
 }
@@ -980,17 +987,20 @@ static inline int ftrace_graph_notrace_addr(unsigned long addr)
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


