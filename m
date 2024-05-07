Return-Path: <bpf+bounces-28851-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AFA98BE568
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 16:14:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF031B2BA5B
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 14:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B91D715FCFE;
	Tue,  7 May 2024 14:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a8yABE/E"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4BB15FA88;
	Tue,  7 May 2024 14:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715091050; cv=none; b=uujsEKNwdzrXbkxXDUeNPWINMdO8ZK+xGVjlL5TisubJLASFNVKeqTrybLBizp6dU++Z1PHZtKJIXGwcjN6Tq3+EtZbDRAMOFUKPpcoOUThJGA2Q4AqTs/Q2Jz7eWvHrsEvNbzfFJR0JOw72xskyKIqF1v4nMb+T2SJ0PKLt3oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715091050; c=relaxed/simple;
	bh=qWvu9ZFCjlBOu1i63Fm0oy0TG0/H41kpL9VGm49UIW4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U3flft7/gbMrXPt4jTuZaWXmpFnJMAeTc+YmxP2Chv4FCYipSV/9uA2mrM38oZSNAAUdmXSn8rexH/BT4lR/ZBdZEDuG0qPrl0EtLxuAfoolym5R7J6Kr3fT3RTly83RQWvmdlBZm42PtDh/sF0L3MOclaDlgvKJlpzPo3Nhneo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a8yABE/E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 347ADC2BBFC;
	Tue,  7 May 2024 14:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715091049;
	bh=qWvu9ZFCjlBOu1i63Fm0oy0TG0/H41kpL9VGm49UIW4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a8yABE/ERlCeBj4KAGDbgpNSOoOviKqSn+sgt2TcKsgWcHPCBskzoOE6aDTUgI/nW
	 fpOI2dmq1V7u0oxdz+CuWG/I/AnsIGfgKdvyNciSPol/FaW3EYEZ5ujANc8HO3bDzC
	 OY3bnDGuSW2hLp0jpqEw7jMu1xl1h2nTr2hlp5Do8PuY0IlJjs0VmCAiDZBj+KghOO
	 AvKBhKhyqRiH1cIKlJWVI6GLEyGPVI6nHWEwCb4xpAxfxjpx8UGcHhvRa36q4BKLE+
	 6D+oQJ/r1ZSGgc4qKk7lRnABPx5fHlTRdPbuHVdNJ6BVrcJteLUBLhdP3T9JxXMRCg
	 6NgfKRf3xQX5Q==
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
Subject: [PATCH v10 14/36] function_graph: Add "task variables" per task for fgraph_ops
Date: Tue,  7 May 2024 23:10:43 +0900
Message-Id: <171509104383.162236.12239656156685718550.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <171509088006.162236.7227326999861366050.stgit@devnote2>
References: <171509088006.162236.7227326999861366050.stgit@devnote2>
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

Add a "task variables" array on the tasks shadow ret_stack that is the
size of longs for each possible registered fgraph_ops. That's a total
of 16, taking up 8 * 16 = 128 bytes (out of a page size 4k).

This will allow for fgraph_ops to do specific features on a per task basis
having a way to maintain state for each task.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 Changes in v10:
  - Explain where the task vars is placed in shadow stack.
 Changes in v3:
  - Move fgraph_ops::idx to previous patch in the series.
 Changes in v2:
  - Make description lines shorter than 76 chars.
---
 include/linux/ftrace.h |    1 +
 kernel/trace/fgraph.c  |   74 +++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 74 insertions(+), 1 deletion(-)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index b11af9d88438..97f7d1cf4f8f 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -1116,6 +1116,7 @@ ftrace_graph_get_ret_stack(struct task_struct *task, int skip);
 
 unsigned long ftrace_graph_ret_addr(struct task_struct *task, int *idx,
 				    unsigned long ret, unsigned long *retp);
+unsigned long *fgraph_get_task_var(struct fgraph_ops *gops);
 
 /*
  * Sometimes we don't want to trace a function with the function
diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index c00a299decb1..3498e8fd8e53 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -46,6 +46,10 @@
  * on the return of the function being traced, this is what will be on the
  * task's shadow ret_stack: (the stack grows upward)
  *
+ *  ret_stack[SHADOW_STACK_IN_WORD]
+ * | SHADOW_STACK_TASK_VARS(ret_stack)[15]      |
+ * ...
+ * | SHADOW_STACK_TASK_VARS(ret_stack)[0]       |
  *  ret_stack[SHADOW_STACK_MAX_OFFSET]
  * ...
  * |                                            | <- task->curr_ret_stack
@@ -90,10 +94,18 @@ enum {
 #define SHADOW_STACK_SIZE (PAGE_SIZE)
 #define SHADOW_STACK_IN_WORD (SHADOW_STACK_SIZE / sizeof(long))
 /* Leave on a buffer at the end */
-#define SHADOW_STACK_MAX_OFFSET (SHADOW_STACK_IN_WORD - (FGRAPH_FRAME_OFFSET + 1))
+#define SHADOW_STACK_MAX_OFFSET				\
+	(SHADOW_STACK_IN_WORD - (FGRAPH_FRAME_OFFSET + 1 + FGRAPH_ARRAY_SIZE))
 
 #define RET_STACK(t, offset) ((struct ftrace_ret_stack *)(&(t)->ret_stack[offset]))
 
+/*
+ * Each fgraph_ops has a reservered unsigned long at the end (top) of the
+ * ret_stack to store task specific state.
+ */
+#define SHADOW_STACK_TASK_VARS(ret_stack) \
+	((unsigned long *)(&(ret_stack)[SHADOW_STACK_IN_WORD - FGRAPH_ARRAY_SIZE]))
+
 DEFINE_STATIC_KEY_FALSE(kill_ftrace_graph);
 int ftrace_graph_active;
 
@@ -184,6 +196,44 @@ static void return_run(struct ftrace_graph_ret *trace, struct fgraph_ops *ops)
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
@@ -793,6 +843,7 @@ static int alloc_retstack_tasklist(unsigned long **ret_stack_list)
 
 		if (t->ret_stack == NULL) {
 			atomic_set(&t->trace_overrun, 0);
+			ret_stack_init_task_vars(ret_stack_list[start]);
 			t->curr_ret_stack = 0;
 			t->curr_ret_depth = -1;
 			/* Make sure the tasks see the 0 first: */
@@ -853,6 +904,7 @@ static void
 graph_init_task(struct task_struct *t, unsigned long *ret_stack)
 {
 	atomic_set(&t->trace_overrun, 0);
+	ret_stack_init_task_vars(ret_stack);
 	t->ftrace_timestamp = 0;
 	t->curr_ret_stack = 0;
 	t->curr_ret_depth = -1;
@@ -951,6 +1003,24 @@ static int start_graph_tracing(void)
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
 
 	ret = ftrace_startup(&gops->ops, command);


