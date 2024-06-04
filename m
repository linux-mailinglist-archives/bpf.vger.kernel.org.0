Return-Path: <bpf+bounces-31324-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0EFE8FB5E6
	for <lists+bpf@lfdr.de>; Tue,  4 Jun 2024 16:45:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 845CA283065
	for <lists+bpf@lfdr.de>; Tue,  4 Jun 2024 14:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E55E149C62;
	Tue,  4 Jun 2024 14:42:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D42171BA;
	Tue,  4 Jun 2024 14:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717512137; cv=none; b=lG5wMIiYyejN8KhkQAYFQWFtwVsRyjxc9s/uMuY51TYyLC9CvRAXfaNYfeT81r4MNPmrqqdMYF7W/v1V3v3Q/DsWgcgpsrudTul29GfrNSiV43bvn/PG40c9d+YwjhCfIVKFBmjPOh4hrzW3vD3mTx5kXwELUaNLAhYj0eMkalQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717512137; c=relaxed/simple;
	bh=3LIdj7MeTAYW/ya7pNWfrRivBY+9Ty7JAfRpJe8bI6k=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=YKZ1S6sIm+rGlZuLPSgB3Wc+Kt5HkKXFJm54KThsl2Icdz3ZntIBAuUfOW6YHPTzp3dLNDBLvRFXv5M8SR6rkEETIfD/dc1YK4buLXgD4xO/cnpnHZ9eTB3PXDAmfe8il0d27yiqISdSPxBs1x18jiRUmUrdsRxsG0kp+mhAw0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1050AC32786;
	Tue,  4 Jun 2024 14:42:17 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1sEVMe-00000000Z0W-2DzG;
	Tue, 04 Jun 2024 10:42:16 -0400
Message-ID: <20240604144216.387251916@goodmis.org>
User-Agent: quilt/0.68
Date: Tue, 04 Jun 2024 10:41:18 -0400
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
Subject: [for-next][PATCH 15/27] function_graph: Add "task variables" per task for fgraph_ops
References: <20240604144103.293353991@goodmis.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

Add a "task variables" array on the tasks shadow ret_stack that is the
size of longs for each possible registered fgraph_ops. That's a total
of 16, taking up 8 * 16 = 128 bytes (out of a page size 4k).

This will allow for fgraph_ops to do specific features on a per task basis
having a way to maintain state for each task.

Co-developed with Masami Hiramatsu:
Link: https://lore.kernel.org/linux-trace-kernel/171509104383.162236.12239656156685718550.stgit@devnote2
Link: https://lore.kernel.org/linux-trace-kernel/20240603190823.308806126@goodmis.org

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
 include/linux/ftrace.h |  1 +
 kernel/trace/fgraph.c  | 74 +++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 74 insertions(+), 1 deletion(-)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index e31ec8516de1..82cfc8e09cfd 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -1089,6 +1089,7 @@ ftrace_graph_get_ret_stack(struct task_struct *task, int skip);
 
 unsigned long ftrace_graph_ret_addr(struct task_struct *task, int *idx,
 				    unsigned long ret, unsigned long *retp);
+unsigned long *fgraph_get_task_var(struct fgraph_ops *gops);
 
 /*
  * Sometimes we don't want to trace a function with the function
diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index 7fd9b03bd170..baa08249ffd5 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -54,6 +54,10 @@
  * on the return of the function being traced, this is what will be on the
  * task's shadow ret_stack: (the stack grows upward)
  *
+ *  ret_stack[SHADOW_STACK_OFFSET]
+ * | SHADOW_STACK_TASK_VARS(ret_stack)[15]      |
+ * ...
+ * | SHADOW_STACK_TASK_VARS(ret_stack)[0]       |
  *  ret_stack[SHADOW_STACK_MAX_OFFSET]
  * ...
  * |                                            | <- task->curr_ret_stack
@@ -116,11 +120,19 @@ enum {
 #define SHADOW_STACK_SIZE	(PAGE_SIZE)
 #define SHADOW_STACK_OFFSET	(SHADOW_STACK_SIZE / sizeof(long))
 /* Leave on a buffer at the end */
-#define SHADOW_STACK_MAX_OFFSET (SHADOW_STACK_OFFSET - (FGRAPH_FRAME_OFFSET + 1))
+#define SHADOW_STACK_MAX_OFFSET				\
+	(SHADOW_STACK_OFFSET - (FGRAPH_FRAME_OFFSET + 1 + FGRAPH_ARRAY_SIZE))
 
 /* RET_STACK():		Return the frame from a given @offset from task @t */
 #define RET_STACK(t, offset) ((struct ftrace_ret_stack *)(&(t)->ret_stack[offset]))
 
+/*
+ * Each fgraph_ops has a reservered unsigned long at the end (top) of the
+ * ret_stack to store task specific state.
+ */
+#define SHADOW_STACK_TASK_VARS(ret_stack) \
+	((unsigned long *)(&(ret_stack)[SHADOW_STACK_OFFSET - FGRAPH_ARRAY_SIZE]))
+
 DEFINE_STATIC_KEY_FALSE(kill_ftrace_graph);
 int ftrace_graph_active;
 
@@ -211,6 +223,44 @@ static void return_run(struct ftrace_graph_ret *trace, struct fgraph_ops *ops)
 {
 }
 
+static void ret_stack_set_task_var(struct task_struct *t, int idx, long val)
+{
+	unsigned long *gvals = SHADOW_STACK_TASK_VARS(t->ret_stack);
+
+	gvals[idx] = val;
+}
+
+static unsigned long *
+ret_stack_get_task_var(struct task_struct *t, int idx)
+{
+	unsigned long *gvals = SHADOW_STACK_TASK_VARS(t->ret_stack);
+
+	return &gvals[idx];
+}
+
+static void ret_stack_init_task_vars(unsigned long *ret_stack)
+{
+	unsigned long *gvals = SHADOW_STACK_TASK_VARS(ret_stack);
+
+	memset(gvals, 0, sizeof(*gvals) * FGRAPH_ARRAY_SIZE);
+}
+
+/**
+ * fgraph_get_task_var - retrieve a task specific state variable
+ * @gops: The ftrace_ops that owns the task specific variable
+ *
+ * Every registered fgraph_ops has a task state variable
+ * reserved on the task's ret_stack. This function returns the
+ * address to that variable.
+ *
+ * Returns the address to the fgraph_ops @gops tasks specific
+ * unsigned long variable.
+ */
+unsigned long *fgraph_get_task_var(struct fgraph_ops *gops)
+{
+	return ret_stack_get_task_var(current, gops->idx);
+}
+
 /*
  * @offset: The offset into @t->ret_stack to find the ret_stack entry
  * @frame_offset: Where to place the offset into @t->ret_stack of that entry
@@ -766,6 +816,7 @@ static int alloc_retstack_tasklist(unsigned long **ret_stack_list)
 
 		if (t->ret_stack == NULL) {
 			atomic_set(&t->trace_overrun, 0);
+			ret_stack_init_task_vars(ret_stack_list[start]);
 			t->curr_ret_stack = 0;
 			t->curr_ret_depth = -1;
 			/* Make sure the tasks see the 0 first: */
@@ -826,6 +877,7 @@ static void
 graph_init_task(struct task_struct *t, unsigned long *ret_stack)
 {
 	atomic_set(&t->trace_overrun, 0);
+	ret_stack_init_task_vars(ret_stack);
 	t->ftrace_timestamp = 0;
 	t->curr_ret_stack = 0;
 	t->curr_ret_depth = -1;
@@ -959,6 +1011,24 @@ static int start_graph_tracing(void)
 	return ret;
 }
 
+static void init_task_vars(int idx)
+{
+	struct task_struct *g, *t;
+	int cpu;
+
+	for_each_online_cpu(cpu) {
+		if (idle_task(cpu)->ret_stack)
+			ret_stack_set_task_var(idle_task(cpu), idx, 0);
+	}
+
+	read_lock(&tasklist_lock);
+	for_each_process_thread(g, t) {
+		if (t->ret_stack)
+			ret_stack_set_task_var(t, idx, 0);
+	}
+	read_unlock(&tasklist_lock);
+}
+
 int register_ftrace_graph(struct fgraph_ops *gops)
 {
 	int command = 0;
@@ -997,6 +1067,8 @@ int register_ftrace_graph(struct fgraph_ops *gops)
 		ftrace_graph_return = return_run;
 		ftrace_graph_entry = entry_run;
 		command = FTRACE_START_FUNC_RET;
+	} else {
+		init_task_vars(gops->idx);
 	}
 
 	/* Always save the function, and reset at unregistering */
-- 
2.43.0



