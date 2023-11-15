Return-Path: <bpf+bounces-14492-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CDD7D7E58BB
	for <lists+bpf@lfdr.de>; Wed,  8 Nov 2023 15:26:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 820A82815CA
	for <lists+bpf@lfdr.de>; Wed,  8 Nov 2023 14:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 709431A5AD;
	Wed,  8 Nov 2023 14:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VkDX2D2f"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E622A1A29C;
	Wed,  8 Nov 2023 14:26:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38A90C433C8;
	Wed,  8 Nov 2023 14:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699453584;
	bh=ABSiSoBNpJN5rDip6XJSS0Vnuh3TywvGEmJw0obwVuw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VkDX2D2fCljsPpmH13ik5rcaCxQv3B8/LbHvXbdBqIFS6VBA60a4559I+kcw50CCg
	 S/63pYLoF4c316G2hZa+pL9PBTYnE5bsszH3n90kj+4YQI6WHgVagU2P7bEfFc5sR0
	 i9Cg6xvweDwPUADrze4RwgKTB8r4NmXQl6M1nF0irDmZL5VbqxzpKjuIEBMVfbz0dI
	 8q9xPrlQuDpYFesId5jYN1RZxbPrbgsun5XuocWbAJaWNwfLiPKcS2ZSGT2zag9FK9
	 2fUTsXrYCEcUP86wqb836MvKPGAq3CB2FVXsbXbzWUAWrB8toXSGCyOiMjIoxd8ivM
	 yIyWfHnsTFsxw==
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
Subject: [RFC PATCH v2 10/31] ftrace: Allow function_graph tracer to be enabled in instances
Date: Wed,  8 Nov 2023 23:26:18 +0900
Message-Id: <169945357839.55307.6047022466598056974.stgit@devnote2>
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

Now that function graph tracing can handle more than one user, allow it to
be enabled in the ftrace instances. Note, the filtering of the functions is
still joined by the top level set_ftrace_filter and friends, as well as the
graph and nograph files.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 Changes in v2:
  - Fix to remove set_graph_array() completely.
---
 include/linux/ftrace.h               |    1 +
 kernel/trace/ftrace.c                |    1 +
 kernel/trace/trace.h                 |   13 ++++++-
 kernel/trace/trace_functions.c       |    8 ++++
 kernel/trace/trace_functions_graph.c |   65 +++++++++++++++++++++-------------
 kernel/trace/trace_selftest.c        |    4 +-
 6 files changed, 64 insertions(+), 28 deletions(-)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 347627f012ce..80ec01e765bd 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -1069,6 +1069,7 @@ extern int ftrace_graph_entry_stub(struct ftrace_graph_ent *trace, struct fgraph
 struct fgraph_ops {
 	trace_func_graph_ent_t		entryfunc;
 	trace_func_graph_ret_t		retfunc;
+	void				*private;
 };
 
 /*
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 7ff5c454622a..83fbfb7b48f8 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -7319,6 +7319,7 @@ __init void ftrace_init_global_array_ops(struct trace_array *tr)
 	tr->ops = &global_ops;
 	tr->ops->private = tr;
 	ftrace_init_trace_array(tr);
+	init_array_fgraph_ops(tr);
 }
 
 void ftrace_init_array_ops(struct trace_array *tr, ftrace_func_t func)
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index ada49bf1fbc8..febb9c6d01c7 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -395,6 +395,9 @@ struct trace_array {
 	struct ftrace_ops	*ops;
 	struct trace_pid_list	__rcu *function_pids;
 	struct trace_pid_list	__rcu *function_no_pids;
+#ifdef CONFIG_FUNCTION_GRAPH_TRACER
+	struct fgraph_ops	*gops;
+#endif
 #ifdef CONFIG_DYNAMIC_FTRACE
 	/* All of these are protected by the ftrace_lock */
 	struct list_head	func_probes;
@@ -672,7 +675,6 @@ void print_trace_header(struct seq_file *m, struct trace_iterator *iter);
 
 void trace_graph_return(struct ftrace_graph_ret *trace, struct fgraph_ops *gops);
 int trace_graph_entry(struct ftrace_graph_ent *trace, struct fgraph_ops *gops);
-void set_graph_array(struct trace_array *tr);
 
 void tracing_start_cmdline_record(void);
 void tracing_stop_cmdline_record(void);
@@ -883,6 +885,9 @@ extern int __trace_graph_entry(struct trace_array *tr,
 extern void __trace_graph_return(struct trace_array *tr,
 				 struct ftrace_graph_ret *trace,
 				 unsigned int trace_ctx);
+extern void init_array_fgraph_ops(struct trace_array *tr);
+extern int allocate_fgraph_ops(struct trace_array *tr);
+extern void free_fgraph_ops(struct trace_array *tr);
 
 #ifdef CONFIG_DYNAMIC_FTRACE
 extern struct ftrace_hash __rcu *ftrace_graph_hash;
@@ -995,6 +1000,12 @@ print_graph_function_flags(struct trace_iterator *iter, u32 flags)
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
index 914331d8242c..f0758afa2f7d 100644
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


