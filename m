Return-Path: <bpf+bounces-31111-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C0778D7344
	for <lists+bpf@lfdr.de>; Sun,  2 Jun 2024 05:37:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEDF61F216FC
	for <lists+bpf@lfdr.de>; Sun,  2 Jun 2024 03:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03370BE78;
	Sun,  2 Jun 2024 03:37:25 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AABA11720;
	Sun,  2 Jun 2024 03:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717299444; cv=none; b=Xk+cfzQvxA6dTgfSU+DW2v5RIcIFJL4OnY0iINH2D0KH7vyCqaph/LWWZVUCnTy5Wqv2vP4KjPYWZHflol9WhqMz9n66NZUF06I7jB2F5CuHLqOqwLB21JE+MBXmbnd4eKp1PrEguVDlKS8V+qbTzvcWYL3Zr+3+4QBo/2Vs48E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717299444; c=relaxed/simple;
	bh=gYmnuxroUnKcPJEbo40Fe17qNPPlV/8BKIflXLRQpJg=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=uBQl2t5IIoP5WDBfZ/mhUAyzez4ORnrgU/fyNXOJICrg229HyVjWasFW1UABrtpmGJqzS5znBctKCmDUVdA69bFPqs2WTfhclMrCIpcoaHbo/IJ0g/kvdHoG2mCyni/59UqEwPgON6exOkwRLYGs1VGhCt3chgt0voLbXkOWN9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3845AC32789;
	Sun,  2 Jun 2024 03:37:24 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1sDc3D-000000094JV-1cT5;
	Sat, 01 Jun 2024 23:38:31 -0400
Message-ID: <20240602033831.245657702@goodmis.org>
User-Agent: quilt/0.68
Date: Sat, 01 Jun 2024 23:37:45 -0400
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
Subject: [PATCH v2 01/27] function_graph: Convert ret_stack to a series of longs
References: <20240602033744.563858532@goodmis.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

In order to make it possible to have multiple callbacks registered with the
function_graph tracer, the retstack needs to be converted from an array of
ftrace_ret_stack structures to an array of longs. This will allow to store
the list of callbacks on the stack for the return side of the functions.

Link: https://lore.kernel.org/linux-trace-kernel/171509092742.162236.4427737821399314856.stgit@devnote2

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/linux/sched.h |   2 +-
 kernel/trace/fgraph.c | 136 +++++++++++++++++++++++++-----------------
 2 files changed, 83 insertions(+), 55 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 61591ac6eab6..352939dab3a5 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1402,7 +1402,7 @@ struct task_struct {
 	int				curr_ret_depth;
 
 	/* Stack of return addresses for return function tracing: */
-	struct ftrace_ret_stack		*ret_stack;
+	unsigned long			*ret_stack;
 
 	/* Timestamp for last schedule: */
 	unsigned long long		ftrace_timestamp;
diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index a130b2d898f7..c62e6db718a0 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -25,6 +25,30 @@
 #define ASSIGN_OPS_HASH(opsname, val)
 #endif
 
+/*
+ * FGRAPH_FRAME_SIZE:	Size in bytes of the meta data on the shadow stack
+ * FGRAPH_FRAME_OFFSET:	Size in long words of the meta data frame
+ * SHADOW_STACK_SIZE:	The size in bytes of the entire shadow stack
+ * SHADOW_STACK_OFFSET:	The size in long words of the shadow stack
+ * SHADOW_STACK_MAX_OFFSET: The max offset of the stack for a new frame to be added
+ */
+#define FGRAPH_FRAME_SIZE	sizeof(struct ftrace_ret_stack)
+#define FGRAPH_FRAME_OFFSET	(ALIGN(FGRAPH_FRAME_SIZE, sizeof(long)) / sizeof(long))
+#define SHADOW_STACK_SIZE (PAGE_SIZE)
+#define SHADOW_STACK_OFFSET			\
+	(ALIGN(SHADOW_STACK_SIZE, sizeof(long)) / sizeof(long))
+/* Leave on a buffer at the end */
+#define SHADOW_STACK_MAX_INDEX (SHADOW_STACK_OFFSET - FGRAPH_FRAME_OFFSET)
+
+/*
+ * RET_STACK():		Return the frame from a given @offset from task @t
+ * RET_STACK_INC():	Reserve one frame size on the stack.
+ * RET_STACK_DEC():	Remove one frame size from the stack.
+ */
+#define RET_STACK(t, index) ((struct ftrace_ret_stack *)(&(t)->ret_stack[index]))
+#define RET_STACK_INC(c) ({ c += FGRAPH_FRAME_OFFSET; })
+#define RET_STACK_DEC(c) ({ c -= FGRAPH_FRAME_OFFSET; })
+
 DEFINE_STATIC_KEY_FALSE(kill_ftrace_graph);
 int ftrace_graph_active;
 
@@ -69,6 +93,7 @@ static int
 ftrace_push_return_trace(unsigned long ret, unsigned long func,
 			 unsigned long frame_pointer, unsigned long *retp)
 {
+	struct ftrace_ret_stack *ret_stack;
 	unsigned long long calltime;
 	int index;
 
@@ -85,23 +110,25 @@ ftrace_push_return_trace(unsigned long ret, unsigned long func,
 	smp_rmb();
 
 	/* The return trace stack is full */
-	if (current->curr_ret_stack == FTRACE_RETFUNC_DEPTH - 1) {
+	if (current->curr_ret_stack >= SHADOW_STACK_MAX_INDEX) {
 		atomic_inc(&current->trace_overrun);
 		return -EBUSY;
 	}
 
 	calltime = trace_clock_local();
 
-	index = ++current->curr_ret_stack;
+	index = current->curr_ret_stack;
+	RET_STACK_INC(current->curr_ret_stack);
+	ret_stack = RET_STACK(current, index);
 	barrier();
-	current->ret_stack[index].ret = ret;
-	current->ret_stack[index].func = func;
-	current->ret_stack[index].calltime = calltime;
+	ret_stack->ret = ret;
+	ret_stack->func = func;
+	ret_stack->calltime = calltime;
 #ifdef HAVE_FUNCTION_GRAPH_FP_TEST
-	current->ret_stack[index].fp = frame_pointer;
+	ret_stack->fp = frame_pointer;
 #endif
 #ifdef HAVE_FUNCTION_GRAPH_RET_ADDR_PTR
-	current->ret_stack[index].retp = retp;
+	ret_stack->retp = retp;
 #endif
 	return 0;
 }
@@ -137,7 +164,7 @@ int function_graph_enter(unsigned long ret, unsigned long func,
 
 	return 0;
  out_ret:
-	current->curr_ret_stack--;
+	RET_STACK_DEC(current->curr_ret_stack);
  out:
 	current->curr_ret_depth--;
 	return -EBUSY;
@@ -148,11 +175,13 @@ static void
 ftrace_pop_return_trace(struct ftrace_graph_ret *trace, unsigned long *ret,
 			unsigned long frame_pointer)
 {
+	struct ftrace_ret_stack *ret_stack;
 	int index;
 
 	index = current->curr_ret_stack;
+	RET_STACK_DEC(index);
 
-	if (unlikely(index < 0 || index >= FTRACE_RETFUNC_DEPTH)) {
+	if (unlikely(index < 0 || index > SHADOW_STACK_MAX_INDEX)) {
 		ftrace_graph_stop();
 		WARN_ON(1);
 		/* Might as well panic, otherwise we have no where to go */
@@ -160,6 +189,7 @@ ftrace_pop_return_trace(struct ftrace_graph_ret *trace, unsigned long *ret,
 		return;
 	}
 
+	ret_stack = RET_STACK(current, index);
 #ifdef HAVE_FUNCTION_GRAPH_FP_TEST
 	/*
 	 * The arch may choose to record the frame pointer used
@@ -175,22 +205,22 @@ ftrace_pop_return_trace(struct ftrace_graph_ret *trace, unsigned long *ret,
 	 * Note, -mfentry does not use frame pointers, and this test
 	 *  is not needed if CC_USING_FENTRY is set.
 	 */
-	if (unlikely(current->ret_stack[index].fp != frame_pointer)) {
+	if (unlikely(ret_stack->fp != frame_pointer)) {
 		ftrace_graph_stop();
 		WARN(1, "Bad frame pointer: expected %lx, received %lx\n"
 		     "  from func %ps return to %lx\n",
 		     current->ret_stack[index].fp,
 		     frame_pointer,
-		     (void *)current->ret_stack[index].func,
-		     current->ret_stack[index].ret);
+		     (void *)ret_stack->func,
+		     ret_stack->ret);
 		*ret = (unsigned long)panic;
 		return;
 	}
 #endif
 
-	*ret = current->ret_stack[index].ret;
-	trace->func = current->ret_stack[index].func;
-	trace->calltime = current->ret_stack[index].calltime;
+	*ret = ret_stack->ret;
+	trace->func = ret_stack->func;
+	trace->calltime = ret_stack->calltime;
 	trace->overrun = atomic_read(&current->trace_overrun);
 	trace->depth = current->curr_ret_depth--;
 	/*
@@ -251,7 +281,7 @@ static unsigned long __ftrace_return_to_handler(struct fgraph_ret_regs *ret_regs
 	 * curr_ret_stack is after that.
 	 */
 	barrier();
-	current->curr_ret_stack--;
+	RET_STACK_DEC(current->curr_ret_stack);
 
 	if (unlikely(!ret)) {
 		ftrace_graph_stop();
@@ -294,12 +324,13 @@ unsigned long ftrace_return_to_handler(unsigned long frame_pointer)
 struct ftrace_ret_stack *
 ftrace_graph_get_ret_stack(struct task_struct *task, int idx)
 {
-	idx = task->curr_ret_stack - idx;
+	int index = task->curr_ret_stack;
 
-	if (idx >= 0 && idx <= task->curr_ret_stack)
-		return &task->ret_stack[idx];
+	index -= FGRAPH_FRAME_OFFSET * (idx + 1);
+	if (index < 0)
+		return NULL;
 
-	return NULL;
+	return RET_STACK(task, index);
 }
 
 /**
@@ -321,18 +352,20 @@ ftrace_graph_get_ret_stack(struct task_struct *task, int idx)
 unsigned long ftrace_graph_ret_addr(struct task_struct *task, int *idx,
 				    unsigned long ret, unsigned long *retp)
 {
+	struct ftrace_ret_stack *ret_stack;
 	int index = task->curr_ret_stack;
 	int i;
 
 	if (ret != (unsigned long)dereference_kernel_function_descriptor(return_to_handler))
 		return ret;
 
-	if (index < 0)
-		return ret;
+	RET_STACK_DEC(index);
 
-	for (i = 0; i <= index; i++)
-		if (task->ret_stack[i].retp == retp)
-			return task->ret_stack[i].ret;
+	for (i = index; i >= 0; RET_STACK_DEC(i)) {
+		ret_stack = RET_STACK(task, i);
+		if (ret_stack->retp == retp)
+			return ret_stack->ret;
+	}
 
 	return ret;
 }
@@ -346,14 +379,15 @@ unsigned long ftrace_graph_ret_addr(struct task_struct *task, int *idx,
 		return ret;
 
 	task_idx = task->curr_ret_stack;
+	RET_STACK_DEC(task_idx);
 
 	if (!task->ret_stack || task_idx < *idx)
 		return ret;
 
 	task_idx -= *idx;
-	(*idx)++;
+	RET_STACK_INC(*idx);
 
-	return task->ret_stack[task_idx].ret;
+	return RET_STACK(task, task_idx);
 }
 #endif /* HAVE_FUNCTION_GRAPH_RET_ADDR_PTR */
 
@@ -391,7 +425,7 @@ trace_func_graph_ent_t ftrace_graph_entry = ftrace_graph_entry_stub;
 static trace_func_graph_ent_t __ftrace_graph_entry = ftrace_graph_entry_stub;
 
 /* Try to assign a return stack array on FTRACE_RETSTACK_ALLOC_SIZE tasks. */
-static int alloc_retstack_tasklist(struct ftrace_ret_stack **ret_stack_list)
+static int alloc_retstack_tasklist(unsigned long **ret_stack_list)
 {
 	int i;
 	int ret = 0;
@@ -399,10 +433,7 @@ static int alloc_retstack_tasklist(struct ftrace_ret_stack **ret_stack_list)
 	struct task_struct *g, *t;
 
 	for (i = 0; i < FTRACE_RETSTACK_ALLOC_SIZE; i++) {
-		ret_stack_list[i] =
-			kmalloc_array(FTRACE_RETFUNC_DEPTH,
-				      sizeof(struct ftrace_ret_stack),
-				      GFP_KERNEL);
+		ret_stack_list[i] = kmalloc(SHADOW_STACK_SIZE, GFP_KERNEL);
 		if (!ret_stack_list[i]) {
 			start = 0;
 			end = i;
@@ -420,9 +451,9 @@ static int alloc_retstack_tasklist(struct ftrace_ret_stack **ret_stack_list)
 
 		if (t->ret_stack == NULL) {
 			atomic_set(&t->trace_overrun, 0);
-			t->curr_ret_stack = -1;
+			t->curr_ret_stack = 0;
 			t->curr_ret_depth = -1;
-			/* Make sure the tasks see the -1 first: */
+			/* Make sure the tasks see the 0 first: */
 			smp_wmb();
 			t->ret_stack = ret_stack_list[start++];
 		}
@@ -442,6 +473,7 @@ ftrace_graph_probe_sched_switch(void *ignore, bool preempt,
 				struct task_struct *next,
 				unsigned int prev_state)
 {
+	struct ftrace_ret_stack *ret_stack;
 	unsigned long long timestamp;
 	int index;
 
@@ -466,8 +498,11 @@ ftrace_graph_probe_sched_switch(void *ignore, bool preempt,
 	 */
 	timestamp -= next->ftrace_timestamp;
 
-	for (index = next->curr_ret_stack; index >= 0; index--)
-		next->ret_stack[index].calltime += timestamp;
+	for (index = next->curr_ret_stack - FGRAPH_FRAME_OFFSET; index >= 0; ) {
+		ret_stack = RET_STACK(next, index);
+		ret_stack->calltime += timestamp;
+		index -= FGRAPH_FRAME_OFFSET;
+	}
 }
 
 static int ftrace_graph_entry_test(struct ftrace_graph_ent *trace)
@@ -510,10 +545,10 @@ void update_function_graph_func(void)
 		ftrace_graph_entry = __ftrace_graph_entry;
 }
 
-static DEFINE_PER_CPU(struct ftrace_ret_stack *, idle_ret_stack);
+static DEFINE_PER_CPU(unsigned long *, idle_ret_stack);
 
 static void
-graph_init_task(struct task_struct *t, struct ftrace_ret_stack *ret_stack)
+graph_init_task(struct task_struct *t, unsigned long *ret_stack)
 {
 	atomic_set(&t->trace_overrun, 0);
 	t->ftrace_timestamp = 0;
@@ -528,7 +563,7 @@ graph_init_task(struct task_struct *t, struct ftrace_ret_stack *ret_stack)
  */
 void ftrace_graph_init_idle_task(struct task_struct *t, int cpu)
 {
-	t->curr_ret_stack = -1;
+	t->curr_ret_stack = 0;
 	t->curr_ret_depth = -1;
 	/*
 	 * The idle task has no parent, it either has its own
@@ -538,14 +573,11 @@ void ftrace_graph_init_idle_task(struct task_struct *t, int cpu)
 		WARN_ON(t->ret_stack != per_cpu(idle_ret_stack, cpu));
 
 	if (ftrace_graph_active) {
-		struct ftrace_ret_stack *ret_stack;
+		unsigned long *ret_stack;
 
 		ret_stack = per_cpu(idle_ret_stack, cpu);
 		if (!ret_stack) {
-			ret_stack =
-				kmalloc_array(FTRACE_RETFUNC_DEPTH,
-					      sizeof(struct ftrace_ret_stack),
-					      GFP_KERNEL);
+			ret_stack = kmalloc(SHADOW_STACK_SIZE, GFP_KERNEL);
 			if (!ret_stack)
 				return;
 			per_cpu(idle_ret_stack, cpu) = ret_stack;
@@ -559,15 +591,13 @@ void ftrace_graph_init_task(struct task_struct *t)
 {
 	/* Make sure we do not use the parent ret_stack */
 	t->ret_stack = NULL;
-	t->curr_ret_stack = -1;
+	t->curr_ret_stack = 0;
 	t->curr_ret_depth = -1;
 
 	if (ftrace_graph_active) {
-		struct ftrace_ret_stack *ret_stack;
+		unsigned long *ret_stack;
 
-		ret_stack = kmalloc_array(FTRACE_RETFUNC_DEPTH,
-					  sizeof(struct ftrace_ret_stack),
-					  GFP_KERNEL);
+		ret_stack = kmalloc(SHADOW_STACK_SIZE, GFP_KERNEL);
 		if (!ret_stack)
 			return;
 		graph_init_task(t, ret_stack);
@@ -576,7 +606,7 @@ void ftrace_graph_init_task(struct task_struct *t)
 
 void ftrace_graph_exit_task(struct task_struct *t)
 {
-	struct ftrace_ret_stack	*ret_stack = t->ret_stack;
+	unsigned long *ret_stack = t->ret_stack;
 
 	t->ret_stack = NULL;
 	/* NULL must become visible to IRQs before we free it: */
@@ -588,12 +618,10 @@ void ftrace_graph_exit_task(struct task_struct *t)
 /* Allocate a return stack for each task */
 static int start_graph_tracing(void)
 {
-	struct ftrace_ret_stack **ret_stack_list;
+	unsigned long **ret_stack_list;
 	int ret, cpu;
 
-	ret_stack_list = kmalloc_array(FTRACE_RETSTACK_ALLOC_SIZE,
-				       sizeof(struct ftrace_ret_stack *),
-				       GFP_KERNEL);
+	ret_stack_list = kmalloc(SHADOW_STACK_SIZE, GFP_KERNEL);
 
 	if (!ret_stack_list)
 		return -ENOMEM;
-- 
2.43.0



