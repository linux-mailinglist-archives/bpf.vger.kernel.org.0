Return-Path: <bpf+bounces-31124-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3B498D7356
	for <lists+bpf@lfdr.de>; Sun,  2 Jun 2024 05:38:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B5D72821B7
	for <lists+bpf@lfdr.de>; Sun,  2 Jun 2024 03:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D67C93770D;
	Sun,  2 Jun 2024 03:37:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5BC2E3E9;
	Sun,  2 Jun 2024 03:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717299446; cv=none; b=G+G6ivSDpyqyB26Bm8ws/5Sh64XuPryaup/KalwSgpoaakJEshxDJASmz/p8bU/C9GYGFMOmsrF782PnyIaJB423oiq1uzV/GXW6cU+EMGGdD6uxoxFchZM8juF/suxC558gAOwMTDIt2QAfeCb6Xmhoj9TeO0SRQ0RGqfz8Fpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717299446; c=relaxed/simple;
	bh=A0U9sr9GFbpsRBnq39/LgmZBDUIWBAfS7ig9mkIzpvw=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=ogwAqk2ENAEh6kDP4MXQCiWHDOwu+FQwD6ly8cZXQVMOsb8mRB1/JR/1CLKLHDZOJTAiyKNHAvQQNVeiP5Nxg73CtgBMr7x21av8GXs6bWjNf6wBQWH/JFmR6VscCjI3Si4gJypytHRcT9KO7vY1UkyE7s+jHqZLFhAq+Jqi29U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7C0EC4DDE1;
	Sun,  2 Jun 2024 03:37:25 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1sDc3F-000000094Ow-0iNP;
	Sat, 01 Jun 2024 23:38:33 -0400
Message-ID: <20240602033833.030750126@goodmis.org>
User-Agent: quilt/0.68
Date: Sat, 01 Jun 2024 23:37:56 -0400
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
Subject: [PATCH v2 12/27] function_graph: Have the instances use their own ftrace_ops for
 filtering
References: <20240602033744.563858532@goodmis.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

Allow for instances to have their own ftrace_ops part of the fgraph_ops
that makes the funtion_graph tracer filter on the set_ftrace_filter file
of the instance and not the top instance.

This uses the new ftrace_startup_subops(), by using graph_ops as the
"manager ops" that defines the callback function and adds the functions
defined by the filters of the ops for each trace instance. The callback
defined by the manager ops will call the registered fgraph ops that were
added to the fgraph_array.

Co-developed with Masami Hiramatsu:
Link: https://lore.kernel.org/linux-trace-kernel/171509102088.162236.15758883237657317789.stgit@devnote2

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/linux/ftrace.h               |  1 +
 kernel/trace/fgraph.c                | 81 +++++++++++++++++-----------
 kernel/trace/ftrace.c                |  2 +-
 kernel/trace/trace.h                 | 15 +++---
 kernel/trace/trace_functions.c       |  2 +-
 kernel/trace/trace_functions_graph.c |  8 ++-
 6 files changed, 68 insertions(+), 41 deletions(-)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 63238a9a9270..8f865689e868 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -1046,6 +1046,7 @@ extern int ftrace_graph_entry_stub(struct ftrace_graph_ent *trace, struct fgraph
 struct fgraph_ops {
 	trace_func_graph_ent_t		entryfunc;
 	trace_func_graph_ret_t		retfunc;
+	struct ftrace_ops		ops; /* for the hash lists */
 	void				*private;
 	int				idx;
 };
diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index e39042c40937..3ef6db53c0bf 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -18,15 +18,6 @@
 #include "ftrace_internal.h"
 #include "trace.h"
 
-#ifdef CONFIG_DYNAMIC_FTRACE
-#define ASSIGN_OPS_HASH(opsname, val) \
-	.func_hash		= val, \
-	.local_hash.regex_lock	= __MUTEX_INITIALIZER(opsname.local_hash.regex_lock), \
-	.subop_list		= LIST_HEAD_INIT(opsname.subop_list),
-#else
-#define ASSIGN_OPS_HASH(opsname, val)
-#endif
-
 /*
  * FGRAPH_FRAME_SIZE:	Size in bytes of the meta data on the shadow stack
  * FGRAPH_FRAME_OFFSET:	Size in long words of the meta data frame
@@ -156,6 +147,13 @@ get_bitmap_bits(struct task_struct *t, int offset)
 	return (t->ret_stack[offset] >> FGRAPH_INDEX_SHIFT) & FGRAPH_INDEX_MASK;
 }
 
+/* For BITMAP type: set the bits in the bitmap bitmask at @offset on ret_stack */
+static inline void
+set_bitmap_bits(struct task_struct *t, int offset, unsigned long bitmap)
+{
+	t->ret_stack[offset] |= (bitmap << FGRAPH_INDEX_SHIFT);
+}
+
 /* Write the bitmap to the ret_stack at @offset (does index, offset and bitmask) */
 static inline void
 set_bitmap(struct task_struct *t, int offset, unsigned long bitmap)
@@ -382,7 +380,8 @@ int function_graph_enter(unsigned long ret, unsigned long func,
 		if (gops == &fgraph_stub)
 			continue;
 
-		if (gops->entryfunc(&trace, gops))
+		if (ftrace_ops_test(&gops->ops, func, NULL) &&
+		    gops->entryfunc(&trace, gops))
 			bitmap |= BIT(i);
 	}
 
@@ -665,16 +664,28 @@ unsigned long ftrace_graph_ret_addr(struct task_struct *task, int *idx,
 
 static struct ftrace_ops graph_ops = {
 	.func			= ftrace_graph_func,
-	.flags			= FTRACE_OPS_FL_INITIALIZED |
-				   FTRACE_OPS_FL_PID |
-				   FTRACE_OPS_GRAPH_STUB,
+	.flags			= FTRACE_OPS_GRAPH_STUB,
 #ifdef FTRACE_GRAPH_TRAMP_ADDR
 	.trampoline		= FTRACE_GRAPH_TRAMP_ADDR,
 	/* trampoline_size is only needed for dynamically allocated tramps */
 #endif
-	ASSIGN_OPS_HASH(graph_ops, &global_ops.local_hash)
 };
 
+void fgraph_init_ops(struct ftrace_ops *dst_ops,
+		     struct ftrace_ops *src_ops)
+{
+	dst_ops->flags = FTRACE_OPS_FL_PID | FTRACE_OPS_GRAPH_STUB;
+
+#ifdef CONFIG_DYNAMIC_FTRACE
+	if (src_ops) {
+		dst_ops->func_hash = &src_ops->local_hash;
+		mutex_init(&dst_ops->local_hash.regex_lock);
+		INIT_LIST_HEAD(&dst_ops->subop_list);
+		dst_ops->flags |= FTRACE_OPS_FL_INITIALIZED;
+	}
+#endif
+}
+
 void ftrace_graph_sleep_time_control(bool enable)
 {
 	fgraph_sleep_time = enable;
@@ -877,6 +888,7 @@ static int start_graph_tracing(void)
 
 int register_ftrace_graph(struct fgraph_ops *gops)
 {
+	int command = 0;
 	int ret = 0;
 	int i;
 
@@ -894,7 +906,7 @@ int register_ftrace_graph(struct fgraph_ops *gops)
 			break;
 	}
 	if (i >= FGRAPH_ARRAY_SIZE) {
-		ret = -EBUSY;
+		ret = -ENOSPC;
 		goto out;
 	}
 
@@ -908,18 +920,22 @@ int register_ftrace_graph(struct fgraph_ops *gops)
 	if (ftrace_graph_active == 1) {
 		register_pm_notifier(&ftrace_suspend_notifier);
 		ret = start_graph_tracing();
-		if (ret) {
-			ftrace_graph_active--;
-			goto out;
-		}
+		if (ret)
+			goto error;
 		/*
 		 * Some archs just test to see if these are not
 		 * the default function
 		 */
 		ftrace_graph_return = return_run;
 		ftrace_graph_entry = entry_run;
+		command = FTRACE_START_FUNC_RET;
+	}
 
-		ret = ftrace_startup(&graph_ops, FTRACE_START_FUNC_RET);
+	ret = ftrace_startup_subops(&graph_ops, &gops->ops, command);
+error:
+	if (ret) {
+		fgraph_array[i] = &fgraph_stub;
+		ftrace_graph_active--;
 	}
 out:
 	mutex_unlock(&ftrace_lock);
@@ -928,6 +944,7 @@ int register_ftrace_graph(struct fgraph_ops *gops)
 
 void unregister_ftrace_graph(struct fgraph_ops *gops)
 {
+	int command = 0;
 	int i;
 
 	mutex_lock(&ftrace_lock);
@@ -935,25 +952,29 @@ void unregister_ftrace_graph(struct fgraph_ops *gops)
 	if (unlikely(!ftrace_graph_active))
 		goto out;
 
-	for (i = 0; i < fgraph_array_cnt; i++)
-		if (gops == fgraph_array[i])
-			break;
-	if (i >= fgraph_array_cnt)
+	if (unlikely(gops->idx < 0 || gops->idx >= fgraph_array_cnt))
 		goto out;
 
-	fgraph_array[i] = &fgraph_stub;
-	if (i + 1 == fgraph_array_cnt) {
-		for (; i >= 0; i--)
-			if (fgraph_array[i] != &fgraph_stub)
-				break;
+	WARN_ON_ONCE(fgraph_array[gops->idx] != gops);
+
+	fgraph_array[gops->idx] = &fgraph_stub;
+	if (gops->idx + 1 == fgraph_array_cnt) {
+		i = gops->idx;
+		while (i >= 0 && fgraph_array[i] == &fgraph_stub)
+			i--;
 		fgraph_array_cnt = i + 1;
 	}
 
 	ftrace_graph_active--;
+
+	if (!ftrace_graph_active)
+		command = FTRACE_STOP_FUNC_RET;
+
+	ftrace_shutdown_subops(&graph_ops, &gops->ops, command);
+
 	if (!ftrace_graph_active) {
 		ftrace_graph_return = ftrace_stub_graph;
 		ftrace_graph_entry = ftrace_graph_entry_stub;
-		ftrace_shutdown(&graph_ops, FTRACE_STOP_FUNC_RET);
 		unregister_pm_notifier(&ftrace_suspend_notifier);
 		unregister_trace_sched_switch(ftrace_graph_probe_sched_switch, NULL);
 	}
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index e447b04c0c9c..3615614bd116 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -7793,7 +7793,7 @@ __init void ftrace_init_global_array_ops(struct trace_array *tr)
 	tr->ops = &global_ops;
 	tr->ops->private = tr;
 	ftrace_init_trace_array(tr);
-	init_array_fgraph_ops(tr);
+	init_array_fgraph_ops(tr, tr->ops);
 }
 
 void ftrace_init_array_ops(struct trace_array *tr, ftrace_func_t func)
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 9a70beb2cc46..f06b5ddd3580 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -894,8 +894,8 @@ extern int __trace_graph_entry(struct trace_array *tr,
 extern void __trace_graph_return(struct trace_array *tr,
 				 struct ftrace_graph_ret *trace,
 				 unsigned int trace_ctx);
-extern void init_array_fgraph_ops(struct trace_array *tr);
-extern int allocate_fgraph_ops(struct trace_array *tr);
+extern void init_array_fgraph_ops(struct trace_array *tr, struct ftrace_ops *ops);
+extern int allocate_fgraph_ops(struct trace_array *tr, struct ftrace_ops *ops);
 extern void free_fgraph_ops(struct trace_array *tr);
 
 #ifdef CONFIG_DYNAMIC_FTRACE
@@ -1003,18 +1003,19 @@ static inline bool ftrace_graph_ignore_func(struct ftrace_graph_ent *trace)
 		(fgraph_max_depth && trace->depth >= fgraph_max_depth);
 }
 
+void fgraph_init_ops(struct ftrace_ops *dst_ops,
+		     struct ftrace_ops *src_ops);
+
 #else /* CONFIG_FUNCTION_GRAPH_TRACER */
 static inline enum print_line_t
 print_graph_function_flags(struct trace_iterator *iter, u32 flags)
 {
 	return TRACE_TYPE_UNHANDLED;
 }
-static inline void init_array_fgraph_ops(struct trace_array *tr) { }
-static inline int allocate_fgraph_ops(struct trace_array *tr)
-{
-	return 0;
-}
 static inline void free_fgraph_ops(struct trace_array *tr) { }
+/* ftrace_ops may not be defined */
+#define init_array_fgraph_ops(tr, ops) do { } while (0)
+#define allocate_fgraph_ops(tr, ops) ({ 0; })
 #endif /* CONFIG_FUNCTION_GRAPH_TRACER */
 
 extern struct list_head ftrace_pids;
diff --git a/kernel/trace/trace_functions.c b/kernel/trace/trace_functions.c
index 8e8da0d0ee52..13bf2415245d 100644
--- a/kernel/trace/trace_functions.c
+++ b/kernel/trace/trace_functions.c
@@ -91,7 +91,7 @@ int ftrace_create_function_files(struct trace_array *tr,
 	if (!tr->ops)
 		return -EINVAL;
 
-	ret = allocate_fgraph_ops(tr);
+	ret = allocate_fgraph_ops(tr, tr->ops);
 	if (ret) {
 		kfree(tr->ops);
 		return ret;
diff --git a/kernel/trace/trace_functions_graph.c b/kernel/trace/trace_functions_graph.c
index 9ccc904a7703..7f30652f0e97 100644
--- a/kernel/trace/trace_functions_graph.c
+++ b/kernel/trace/trace_functions_graph.c
@@ -288,7 +288,7 @@ static struct fgraph_ops funcgraph_ops = {
 	.retfunc = &trace_graph_return,
 };
 
-int allocate_fgraph_ops(struct trace_array *tr)
+int allocate_fgraph_ops(struct trace_array *tr, struct ftrace_ops *ops)
 {
 	struct fgraph_ops *gops;
 
@@ -301,6 +301,9 @@ int allocate_fgraph_ops(struct trace_array *tr)
 
 	tr->gops = gops;
 	gops->private = tr;
+
+	fgraph_init_ops(&gops->ops, ops);
+
 	return 0;
 }
 
@@ -309,10 +312,11 @@ void free_fgraph_ops(struct trace_array *tr)
 	kfree(tr->gops);
 }
 
-__init void init_array_fgraph_ops(struct trace_array *tr)
+__init void init_array_fgraph_ops(struct trace_array *tr, struct ftrace_ops *ops)
 {
 	tr->gops = &funcgraph_ops;
 	funcgraph_ops.private = tr;
+	fgraph_init_ops(&tr->gops->ops, ops);
 }
 
 static int graph_trace_init(struct trace_array *tr)
-- 
2.43.0



