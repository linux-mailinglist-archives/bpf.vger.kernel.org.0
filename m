Return-Path: <bpf+bounces-30561-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B56358CED8D
	for <lists+bpf@lfdr.de>; Sat, 25 May 2024 04:37:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7DB51C2093C
	for <lists+bpf@lfdr.de>; Sat, 25 May 2024 02:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9936719BDC;
	Sat, 25 May 2024 02:36:54 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F72CA7A;
	Sat, 25 May 2024 02:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716604614; cv=none; b=jGmZB7NIjj/46+a9D3RFmN8ePrbNssrsA31GqOYN9Ju+TRIYZ7zhwtcHPl3Cipsnr23MMeQovOKn0Tp0ywVwAZo7mErGEdxisea+s/pMJwsT7HCEg8pEvzyAJQHmsuyENNbSb2zHhld/ZQnCbZpSVXtAMCbNY2cd8se65LUY06E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716604614; c=relaxed/simple;
	bh=X8ZBqqf7HgZ3njW4Ck0cHccdh9DSc7lb2897zitkOSQ=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=g4EqmXzgmajMXTwYJzmVql3Bs7WIM4BZYisfKCATFPn7iLIUtUNbUolmjZpvKOkjhTmVpS+193JtR+2qJtzyIGI7g0/scbB4WeWpH6JYueiqdUV7HZvZ4DmMOjjDMoAX74ufPa54LhRLFKcUg2Wl86Uijvz95BzAYr43O42Md5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2C82C4AF55;
	Sat, 25 May 2024 02:36:53 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1sAhHy-00000007DLY-2Wyj;
	Fri, 24 May 2024 22:37:42 -0400
Message-ID: <20240525023742.466162609@goodmis.org>
User-Agent: quilt/0.68
Date: Fri, 24 May 2024 22:37:00 -0400
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
Subject: [PATCH 08/20] ftrace: Allow function_graph tracer to be enabled in instances
References: <20240525023652.903909489@goodmis.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

Now that function graph tracing can handle more than one user, allow it to
be enabled in the ftrace instances. Note, the filtering of the functions is
still joined by the top level set_ftrace_filter and friends, as well as the
graph and nograph files.

Co-developed with Masami Hiramatsu:
Link: https://lore.kernel.org/linux-trace-kernel/171509099743.162236.1699959255446248163.stgit@devnote2

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/linux/ftrace.h               |  1 +
 kernel/trace/ftrace.c                |  1 +
 kernel/trace/trace.h                 | 13 +++++-
 kernel/trace/trace_functions.c       |  8 ++++
 kernel/trace/trace_functions_graph.c | 65 +++++++++++++++++-----------
 kernel/trace/trace_selftest.c        |  4 +-
 6 files changed, 64 insertions(+), 28 deletions(-)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 032974f55c5b..f7a948337d39 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -1041,6 +1041,7 @@ extern int ftrace_graph_entry_stub(struct ftrace_graph_ent *trace, struct fgraph
 struct fgraph_ops {
 	trace_func_graph_ent_t		entryfunc;
 	trace_func_graph_ret_t		retfunc;
+	void				*private;
 	int				idx;
 };
 
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index d18387c0642d..b85f00b0ffe7 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -7327,6 +7327,7 @@ __init void ftrace_init_global_array_ops(struct trace_array *tr)
 	tr->ops = &global_ops;
 	tr->ops->private = tr;
 	ftrace_init_trace_array(tr);
+	init_array_fgraph_ops(tr);
 }
 
 void ftrace_init_array_ops(struct trace_array *tr, ftrace_func_t func)
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 2575ec243350..a5070f9b977b 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -397,6 +397,9 @@ struct trace_array {
 	struct ftrace_ops	*ops;
 	struct trace_pid_list	__rcu *function_pids;
 	struct trace_pid_list	__rcu *function_no_pids;
+#ifdef CONFIG_FUNCTION_GRAPH_TRACER
+	struct fgraph_ops	*gops;
+#endif
 #ifdef CONFIG_DYNAMIC_FTRACE
 	/* All of these are protected by the ftrace_lock */
 	struct list_head	func_probes;
@@ -681,7 +684,6 @@ void print_trace_header(struct seq_file *m, struct trace_iterator *iter);
 
 void trace_graph_return(struct ftrace_graph_ret *trace, struct fgraph_ops *gops);
 int trace_graph_entry(struct ftrace_graph_ent *trace, struct fgraph_ops *gops);
-void set_graph_array(struct trace_array *tr);
 
 void tracing_start_cmdline_record(void);
 void tracing_stop_cmdline_record(void);
@@ -892,6 +894,9 @@ extern int __trace_graph_entry(struct trace_array *tr,
 extern void __trace_graph_return(struct trace_array *tr,
 				 struct ftrace_graph_ret *trace,
 				 unsigned int trace_ctx);
+extern void init_array_fgraph_ops(struct trace_array *tr);
+extern int allocate_fgraph_ops(struct trace_array *tr);
+extern void free_fgraph_ops(struct trace_array *tr);
 
 #ifdef CONFIG_DYNAMIC_FTRACE
 extern struct ftrace_hash __rcu *ftrace_graph_hash;
@@ -1004,6 +1009,12 @@ print_graph_function_flags(struct trace_iterator *iter, u32 flags)
 {
 	return TRACE_TYPE_UNHANDLED;
 }
+static inline void init_array_fgraph_ops(struct trace_array *tr) { }
+static inline int allocate_fgraph_ops(struct trace_array *tr)
+{
+	return 0;
+}
+static inline void free_fgraph_ops(struct trace_array *tr) { }
 #endif /* CONFIG_FUNCTION_GRAPH_TRACER */
 
 extern struct list_head ftrace_pids;
diff --git a/kernel/trace/trace_functions.c b/kernel/trace/trace_functions.c
index 9f1bfbe105e8..8e8da0d0ee52 100644
--- a/kernel/trace/trace_functions.c
+++ b/kernel/trace/trace_functions.c
@@ -80,6 +80,7 @@ void ftrace_free_ftrace_ops(struct trace_array *tr)
 int ftrace_create_function_files(struct trace_array *tr,
 				 struct dentry *parent)
 {
+	int ret;
 	/*
 	 * The top level array uses the "global_ops", and the files are
 	 * created on boot up.
@@ -90,6 +91,12 @@ int ftrace_create_function_files(struct trace_array *tr,
 	if (!tr->ops)
 		return -EINVAL;
 
+	ret = allocate_fgraph_ops(tr);
+	if (ret) {
+		kfree(tr->ops);
+		return ret;
+	}
+
 	ftrace_create_filter_files(tr->ops, parent);
 
 	return 0;
@@ -99,6 +106,7 @@ void ftrace_destroy_function_files(struct trace_array *tr)
 {
 	ftrace_destroy_filter_files(tr->ops);
 	ftrace_free_ftrace_ops(tr);
+	free_fgraph_ops(tr);
 }
 
 static ftrace_func_t select_trace_function(u32 flags_val)
diff --git a/kernel/trace/trace_functions_graph.c b/kernel/trace/trace_functions_graph.c
index b7b142b65299..9ccc904a7703 100644
--- a/kernel/trace/trace_functions_graph.c
+++ b/kernel/trace/trace_functions_graph.c
@@ -83,8 +83,6 @@ static struct tracer_flags tracer_flags = {
 	.opts = trace_opts
 };
 
-static struct trace_array *graph_array;
-
 /*
  * DURATION column is being also used to display IRQ signs,
  * following values are used by print_graph_irq and others
@@ -132,7 +130,7 @@ static inline int ftrace_graph_ignore_irqs(void)
 int trace_graph_entry(struct ftrace_graph_ent *trace,
 		      struct fgraph_ops *gops)
 {
-	struct trace_array *tr = graph_array;
+	struct trace_array *tr = gops->private;
 	struct trace_array_cpu *data;
 	unsigned long flags;
 	unsigned int trace_ctx;
@@ -242,7 +240,7 @@ void __trace_graph_return(struct trace_array *tr,
 void trace_graph_return(struct ftrace_graph_ret *trace,
 			struct fgraph_ops *gops)
 {
-	struct trace_array *tr = graph_array;
+	struct trace_array *tr = gops->private;
 	struct trace_array_cpu *data;
 	unsigned long flags;
 	unsigned int trace_ctx;
@@ -268,15 +266,6 @@ void trace_graph_return(struct ftrace_graph_ret *trace,
 	local_irq_restore(flags);
 }
 
-void set_graph_array(struct trace_array *tr)
-{
-	graph_array = tr;
-
-	/* Make graph_array visible before we start tracing */
-
-	smp_mb();
-}
-
 static void trace_graph_thresh_return(struct ftrace_graph_ret *trace,
 				      struct fgraph_ops *gops)
 {
@@ -294,25 +283,53 @@ static void trace_graph_thresh_return(struct ftrace_graph_ret *trace,
 		trace_graph_return(trace, gops);
 }
 
-static struct fgraph_ops funcgraph_thresh_ops = {
-	.entryfunc = &trace_graph_entry,
-	.retfunc = &trace_graph_thresh_return,
-};
-
 static struct fgraph_ops funcgraph_ops = {
 	.entryfunc = &trace_graph_entry,
 	.retfunc = &trace_graph_return,
 };
 
+int allocate_fgraph_ops(struct trace_array *tr)
+{
+	struct fgraph_ops *gops;
+
+	gops = kzalloc(sizeof(*gops), GFP_KERNEL);
+	if (!gops)
+		return -ENOMEM;
+
+	gops->entryfunc = &trace_graph_entry;
+	gops->retfunc = &trace_graph_return;
+
+	tr->gops = gops;
+	gops->private = tr;
+	return 0;
+}
+
+void free_fgraph_ops(struct trace_array *tr)
+{
+	kfree(tr->gops);
+}
+
+__init void init_array_fgraph_ops(struct trace_array *tr)
+{
+	tr->gops = &funcgraph_ops;
+	funcgraph_ops.private = tr;
+}
+
 static int graph_trace_init(struct trace_array *tr)
 {
 	int ret;
 
-	set_graph_array(tr);
+	tr->gops->entryfunc = trace_graph_entry;
+
 	if (tracing_thresh)
-		ret = register_ftrace_graph(&funcgraph_thresh_ops);
+		tr->gops->retfunc = trace_graph_thresh_return;
 	else
-		ret = register_ftrace_graph(&funcgraph_ops);
+		tr->gops->retfunc = trace_graph_return;
+
+	/* Make gops functions are visible before we start tracing */
+	smp_mb();
+
+	ret = register_ftrace_graph(tr->gops);
 	if (ret)
 		return ret;
 	tracing_start_cmdline_record();
@@ -323,10 +340,7 @@ static int graph_trace_init(struct trace_array *tr)
 static void graph_trace_reset(struct trace_array *tr)
 {
 	tracing_stop_cmdline_record();
-	if (tracing_thresh)
-		unregister_ftrace_graph(&funcgraph_thresh_ops);
-	else
-		unregister_ftrace_graph(&funcgraph_ops);
+	unregister_ftrace_graph(tr->gops);
 }
 
 static int graph_trace_update_thresh(struct trace_array *tr)
@@ -1365,6 +1379,7 @@ static struct tracer graph_trace __tracer_data = {
 	.print_header	= print_graph_headers,
 	.flags		= &tracer_flags,
 	.set_flag	= func_graph_set_flag,
+	.allow_instances = true,
 #ifdef CONFIG_FTRACE_SELFTEST
 	.selftest	= trace_selftest_startup_function_graph,
 #endif
diff --git a/kernel/trace/trace_selftest.c b/kernel/trace/trace_selftest.c
index 56f269c0560a..f8f55fd79e53 100644
--- a/kernel/trace/trace_selftest.c
+++ b/kernel/trace/trace_selftest.c
@@ -813,7 +813,7 @@ trace_selftest_startup_function_graph(struct tracer *trace,
 	 * to detect and recover from possible hangs
 	 */
 	tracing_reset_online_cpus(&tr->array_buffer);
-	set_graph_array(tr);
+	fgraph_ops.private = tr;
 	ret = register_ftrace_graph(&fgraph_ops);
 	if (ret) {
 		warn_failed_init_tracer(trace, ret);
@@ -856,7 +856,7 @@ trace_selftest_startup_function_graph(struct tracer *trace,
 	cond_resched();
 
 	tracing_reset_online_cpus(&tr->array_buffer);
-	set_graph_array(tr);
+	fgraph_ops.private = tr;
 
 	/*
 	 * Some archs *cough*PowerPC*cough* add characters to the
-- 
2.43.0



