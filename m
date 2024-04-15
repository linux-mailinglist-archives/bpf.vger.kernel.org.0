Return-Path: <bpf+bounces-26775-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DE698A4FD2
	for <lists+bpf@lfdr.de>; Mon, 15 Apr 2024 14:55:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7D81283754
	for <lists+bpf@lfdr.de>; Mon, 15 Apr 2024 12:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE2077352B;
	Mon, 15 Apr 2024 12:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eW3sFnhy"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428DF73531;
	Mon, 15 Apr 2024 12:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713185390; cv=none; b=sg+b1UkwMt+Ai2VeXAa0Q69BKlg6Yf0YrM1ZNHOx3hZZ1tc1u1oz/Spi19dBVm55L5knrdcBHm6pSQ9wglVp3JdM5CHSbSkuITcGkew0xgSzu+IeaptOXpIHt5P1pYJIQ8/ODjsRCBserBbchp/VkHqGBZ474R6LNiqC5428mp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713185390; c=relaxed/simple;
	bh=sCJE3SQVsSrScjUihX9Qu3uW1hb21S4Z7y3Wy9pIfBM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dT2kb9eFS3yuXcQedTkxNfq48lqfmI8DikiL/qu7aXril7A4KZ/uYSP72xcBRvJdM8vwsfGraMvzrLX17ZxSDvuSlOhg/55aHBekSJDA+lXbfiqYpfZOCwiqIIAHFab/MtNwDN7LbBbew4rDn+JHinwgaSTsL6kbPhDg+PVBCDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eW3sFnhy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FDA6C113CC;
	Mon, 15 Apr 2024 12:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713185390;
	bh=sCJE3SQVsSrScjUihX9Qu3uW1hb21S4Z7y3Wy9pIfBM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eW3sFnhy0ERU7A2lsiBzLRlQHPa3Tf9BgLw1+REapHrQqFxOFhRCiSolr+U7w718B
	 +kGj7tzWsdiqW5gWXneNegNibK95H5J+hiW8u05axD3U4jiqH4Mp2m8/qJRXiSM3Db
	 al3lXb2PZMkj5szjbUvCvUYLHBapLUTFC8baFvRnQCvFc36KCx+zP3tpIKZoLNsJOV
	 sdB0v08zu9Xr6FaGPxIbuPXNTiPIFTpoS2m+MQucq56HLcoEN0wspH5vkISadCMiB1
	 VTLMv6vZVtO61IwKBGHJJ63VyjAdSXSHwGDb3K1sox+KqoiTB3dPIUpstHTz98VAWq
	 mQQu81UQyVsYw==
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
Subject: [PATCH v9 04/36] function_graph: Convert ret_stack to a series of longs
Date: Mon, 15 Apr 2024 21:49:43 +0900
Message-Id: <171318538352.254850.3995040761354390357.stgit@devnote2>
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

In order to make it possible to have multiple callbacks registered with the
function_graph tracer, the retstack needs to be converted from an array of
ftrace_ret_stack structures to an array of longs. This will allow to store
the list of callbacks on the stack for the return side of the functions.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 include/linux/sched.h |    2 -
 kernel/trace/fgraph.c |  124 ++++++++++++++++++++++++++++---------------------
 2 files changed, 71 insertions(+), 55 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 3c2abbc587b4..e453ad8d2d79 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1396,7 +1396,7 @@ struct task_struct {
 	int				curr_ret_depth;
 
 	/* Stack of return addresses for return function tracing: */
-	struct ftrace_ret_stack		*ret_stack;
+	unsigned long			*ret_stack;
 
 	/* Timestamp for last schedule: */
 	unsigned long long		ftrace_timestamp;
diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index c83c005e654e..30edeb6d4aa9 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -25,6 +25,18 @@
 #define ASSIGN_OPS_HASH(opsname, val)
 #endif
 
+#define FGRAPH_RET_SIZE sizeof(struct ftrace_ret_stack)
+#define FGRAPH_RET_INDEX (ALIGN(FGRAPH_RET_SIZE, sizeof(long)) / sizeof(long))
+#define SHADOW_STACK_SIZE (PAGE_SIZE)
+#define SHADOW_STACK_INDEX			\
+	(ALIGN(SHADOW_STACK_SIZE, sizeof(long)) / sizeof(long))
+/* Leave on a buffer at the end */
+#define SHADOW_STACK_MAX_INDEX (SHADOW_STACK_INDEX - FGRAPH_RET_INDEX)
+
+#define RET_STACK(t, index) ((struct ftrace_ret_stack *)(&(t)->ret_stack[index]))
+#define RET_STACK_INC(c) ({ c += FGRAPH_RET_INDEX; })
+#define RET_STACK_DEC(c) ({ c -= FGRAPH_RET_INDEX; })
+
 DEFINE_STATIC_KEY_FALSE(kill_ftrace_graph);
 int ftrace_graph_active;
 
@@ -69,6 +81,7 @@ static int
 ftrace_push_return_trace(unsigned long ret, unsigned long func,
 			 unsigned long frame_pointer, unsigned long *retp)
 {
+	struct ftrace_ret_stack *ret_stack;
 	unsigned long long calltime;
 	int index;
 
@@ -85,23 +98,25 @@ ftrace_push_return_trace(unsigned long ret, unsigned long func,
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
@@ -148,7 +163,7 @@ int function_graph_enter(unsigned long ret, unsigned long func,
 
 	return 0;
  out_ret:
-	current->curr_ret_stack--;
+	RET_STACK_DEC(current->curr_ret_stack);
  out:
 	current->curr_ret_depth--;
 	return -EBUSY;
@@ -159,11 +174,13 @@ static void
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
@@ -171,6 +188,7 @@ ftrace_pop_return_trace(struct ftrace_graph_ret *trace, unsigned long *ret,
 		return;
 	}
 
+	ret_stack = RET_STACK(current, index);
 #ifdef HAVE_FUNCTION_GRAPH_FP_TEST
 	/*
 	 * The arch may choose to record the frame pointer used
@@ -186,22 +204,22 @@ ftrace_pop_return_trace(struct ftrace_graph_ret *trace, unsigned long *ret,
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
@@ -262,7 +280,7 @@ static unsigned long __ftrace_return_to_handler(struct fgraph_ret_regs *ret_regs
 	 * curr_ret_stack is after that.
 	 */
 	barrier();
-	current->curr_ret_stack--;
+	RET_STACK_DEC(current->curr_ret_stack);
 
 	if (unlikely(!ret)) {
 		ftrace_graph_stop();
@@ -305,12 +323,13 @@ unsigned long ftrace_return_to_handler(unsigned long frame_pointer)
 struct ftrace_ret_stack *
 ftrace_graph_get_ret_stack(struct task_struct *task, int idx)
 {
-	idx = task->curr_ret_stack - idx;
+	int index = task->curr_ret_stack;
 
-	if (idx >= 0 && idx <= task->curr_ret_stack)
-		return &task->ret_stack[idx];
+	index -= FGRAPH_RET_INDEX * (idx + 1);
+	if (index < 0)
+		return NULL;
 
-	return NULL;
+	return RET_STACK(task, index);
 }
 
 /**
@@ -332,18 +351,20 @@ ftrace_graph_get_ret_stack(struct task_struct *task, int idx)
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
@@ -357,14 +378,15 @@ unsigned long ftrace_graph_ret_addr(struct task_struct *task, int *idx,
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
 
@@ -402,7 +424,7 @@ trace_func_graph_ent_t ftrace_graph_entry = ftrace_graph_entry_stub;
 static trace_func_graph_ent_t __ftrace_graph_entry = ftrace_graph_entry_stub;
 
 /* Try to assign a return stack array on FTRACE_RETSTACK_ALLOC_SIZE tasks. */
-static int alloc_retstack_tasklist(struct ftrace_ret_stack **ret_stack_list)
+static int alloc_retstack_tasklist(unsigned long **ret_stack_list)
 {
 	int i;
 	int ret = 0;
@@ -410,10 +432,7 @@ static int alloc_retstack_tasklist(struct ftrace_ret_stack **ret_stack_list)
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
@@ -431,9 +450,9 @@ static int alloc_retstack_tasklist(struct ftrace_ret_stack **ret_stack_list)
 
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
@@ -453,6 +472,7 @@ ftrace_graph_probe_sched_switch(void *ignore, bool preempt,
 				struct task_struct *next,
 				unsigned int prev_state)
 {
+	struct ftrace_ret_stack *ret_stack;
 	unsigned long long timestamp;
 	int index;
 
@@ -477,8 +497,11 @@ ftrace_graph_probe_sched_switch(void *ignore, bool preempt,
 	 */
 	timestamp -= next->ftrace_timestamp;
 
-	for (index = next->curr_ret_stack; index >= 0; index--)
-		next->ret_stack[index].calltime += timestamp;
+	for (index = next->curr_ret_stack - FGRAPH_RET_INDEX; index >= 0; ) {
+		ret_stack = RET_STACK(next, index);
+		ret_stack->calltime += timestamp;
+		index -= FGRAPH_RET_INDEX;
+	}
 }
 
 static int ftrace_graph_entry_test(struct ftrace_graph_ent *trace)
@@ -521,10 +544,10 @@ void update_function_graph_func(void)
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
@@ -539,7 +562,7 @@ graph_init_task(struct task_struct *t, struct ftrace_ret_stack *ret_stack)
  */
 void ftrace_graph_init_idle_task(struct task_struct *t, int cpu)
 {
-	t->curr_ret_stack = -1;
+	t->curr_ret_stack = 0;
 	t->curr_ret_depth = -1;
 	/*
 	 * The idle task has no parent, it either has its own
@@ -549,14 +572,11 @@ void ftrace_graph_init_idle_task(struct task_struct *t, int cpu)
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
@@ -570,15 +590,13 @@ void ftrace_graph_init_task(struct task_struct *t)
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
@@ -587,7 +605,7 @@ void ftrace_graph_init_task(struct task_struct *t)
 
 void ftrace_graph_exit_task(struct task_struct *t)
 {
-	struct ftrace_ret_stack	*ret_stack = t->ret_stack;
+	unsigned long *ret_stack = t->ret_stack;
 
 	t->ret_stack = NULL;
 	/* NULL must become visible to IRQs before we free it: */
@@ -599,12 +617,10 @@ void ftrace_graph_exit_task(struct task_struct *t)
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


