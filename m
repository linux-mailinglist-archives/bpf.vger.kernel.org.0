Return-Path: <bpf+bounces-26787-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 776728A506B
	for <lists+bpf@lfdr.de>; Mon, 15 Apr 2024 15:09:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0449E1F211A2
	for <lists+bpf@lfdr.de>; Mon, 15 Apr 2024 13:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 781CF79B99;
	Mon, 15 Apr 2024 12:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A0Hk94Rn"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F044A73174;
	Mon, 15 Apr 2024 12:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713185522; cv=none; b=PzbE4/YZpEES8niw1EmTgHzgHTznt3uwyVxvsZ/XPMf79lVVZkixV1do1koM2qDltKw8LPVOm/st+x8N9jOFn/8I9uevUMKMvURzCTritJSQeSGZboDQy3Gq5aSIRUKw2ZRT1SgNvaK+qIZKSrsSU+nf4cq7OtUyJQG2n5VJWPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713185522; c=relaxed/simple;
	bh=upkE71EFcFZZ8U2YRvIl16mE4YJ93aXJ464Vspfbo7g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WVJOb1Vw4Vx0s9ll0UEiwcqVh1s0CwaWnXKZZpE5QseWs9BZK97FN9Bd78geDb+JIPdsLnOu8QPn39Wfzuguue0HTIWjgOg5iDxWb0HVv4hcwrCSgkhZMYrCbkdJ6t2SobLr8t07oMjsIsKMoEIIHh4hcui9P+wJw6pCpJHdhJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A0Hk94Rn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13352C113CC;
	Mon, 15 Apr 2024 12:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713185521;
	bh=upkE71EFcFZZ8U2YRvIl16mE4YJ93aXJ464Vspfbo7g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A0Hk94RnN6lrZ9wSLJQsYR8gnLkFwCzMoVFm5OxpPt4FnW0ZHHyquWzEXJsL+3uxZ
	 O2zysHKLv7a6tTrBeKoGiENVRzwbc2qOKT4w9f6K10AumxrrpnHFKZjY1AyA7jObRJ
	 C6P9z25XUgc/Hn7ykX3phQJfFL1S4W0FPBO7R7FVmJ49kL+ZM9Ljft+RQt0ezN1qx7
	 MjXtvnPy7S5SxaOkEAkq038UOqXU1E3AbbalFqzWro2Ml2ATEezixMx41NBGhr/Akr
	 E0DPYz7PZnpTz6W71duAxw2wUWqzoCJ3ZYl33rstNz0nAObBRZYtz+OUG2qowg7q0s
	 94R+5O2r8ISoQ==
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
Subject: [PATCH v9 15/36] function_graph: Move set_graph_function tests to shadow stack global var
Date: Mon, 15 Apr 2024 21:51:54 +0900
Message-Id: <171318551480.254850.7411048404206473141.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <171318533841.254850.15841395205784342850.stgit@devnote2>
References: <171318533841.254850.15841395205784342850.stgit@devnote2>
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
index 9995d6b00a93..c7c7e7c9f700 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -897,11 +897,16 @@ extern void init_array_fgraph_ops(struct trace_array *tr, struct ftrace_ops *ops
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
@@ -923,12 +928,11 @@ static inline int ftrace_graph_addr(struct ftrace_graph_ent *trace)
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
@@ -948,11 +952,14 @@ static inline int ftrace_graph_addr(struct ftrace_graph_ent *trace)
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


