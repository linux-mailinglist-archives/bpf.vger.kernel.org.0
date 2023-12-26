Return-Path: <bpf+bounces-18676-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 891B981E7F9
	for <lists+bpf@lfdr.de>; Tue, 26 Dec 2023 16:24:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F3AE2831A6
	for <lists+bpf@lfdr.de>; Tue, 26 Dec 2023 15:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E13D24F201;
	Tue, 26 Dec 2023 15:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q4e5se8z"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C3EE4F5E6;
	Tue, 26 Dec 2023 15:24:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD4CDC433C7;
	Tue, 26 Dec 2023 15:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703604264;
	bh=BGAak0KFhacfUDu3YPkyyOsPKNSVj6u+WkKnuYyn9uI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Q4e5se8zKQsEYs9Oy6dXIRwQh3eXfea26L/FuAYUARdRv4wfWfvVxbhRkmGmmEjf6
	 G3QgltEbQin85vVOi8GNbc1x7o0XcgaThjGRCrr5Alyd7aRowxDb9Fnl7QX/5gmmHf
	 os4NKVxHKEPPya4NfVwzJxKN/1iaL6Iew/lUse7JMft3JjMpSW1+0W/oWCqOqNE9Uz
	 rmvhJRL8mWyftDevY6R10mV0I2X5JpdFG04aIn/tlakHqZqOGM4FYb7lcy9F2tTqJ/
	 zeFWbd4tW/ta3f1LjNtJHJW2XwwwnFF03npuwUeelusS9fqZAU2Gi7+bvQldQQPFXi
	 +J59+KgsGQEWw==
Date: Wed, 27 Dec 2023 00:24:20 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Masami Hiramatsu (Google) <mhiramat@kernel.org>, Steven Rostedt
 <rostedt@goodmis.org>, Jiri Olsa <jolsa@kernel.org>
Cc: Jiri Olsa <olsajiri@gmail.com>, Alexei Starovoitov
 <alexei.starovoitov@gmail.com>, Steven Rostedt <rostedt@goodmis.org>,
 Florent Revest <revest@chromium.org>, linux-trace-kernel@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, bpf <bpf@vger.kernel.org>, Sven Schnelle
 <svens@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>, Arnaldo
 Carvalho de Melo <acme@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Alan Maguire <alan.maguire@oracle.com>, Mark Rutland
 <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>, Thomas
 Gleixner <tglx@linutronix.de>, Guo Ren <guoren@kernel.org>
Subject: Re: [PATCH v5 06/34] function_graph: Allow multiple users to attach
 to function graph
Message-Id: <20231227002420.40ec3c815df0c5fdab8d458c@kernel.org>
In-Reply-To: <20231220004540.0af568c69ecaf9170430a383@kernel.org>
References: <170290509018.220107.1347127510564358608.stgit@devnote2>
	<170290516454.220107.14775763404510245361.stgit@devnote2>
	<ZYGZWWqwtSP82Sja@krava>
	<20231220004540.0af568c69ecaf9170430a383@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi,

On Wed, 20 Dec 2023 00:45:40 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> OK, I think we need a "rsrv_ret_stack" index. Basically new one will do;
> 
> (1) increment rsrv_ret_stack
> (2) write a reserve type entry
> (3) set curr_ret_stack = rsrv_ret_stack
> 
> And before those,
> 
> (0) if rsrv_ret_stack != curr_ret_stack, write a reserve type entry at
>     rsrv_ret_stack for the previous frame (which offset can be read
>     from curr_ret_stack)
> 
> Than it will never be broken.
> (of course when decrement curr_ret_stack, rsrv_ret_stack is also decremented)
> 

So here is an additional patch for this issue. I'll make v6 with this.

Thanks,

From 4da1ec7b679052a131ecdeebd2e1a9db767c5c24 Mon Sep 17 00:00:00 2001
From: Masami Hiramatsu <mhiramat@kernel.org>
Date: Wed, 27 Dec 2023 00:09:09 +0900
Subject: [PATCH] function_graph: Improve push operation for several interrupts

Improve push and data reserve operation on the shadow stack for
several sequencial interrupts.

To push a ret_stack or data entry on the shadow stack, we need to
prepare an index (offset) entry before updating the stack pointer
(curr_ret_stack) so that unwinder from interrupts can find the
next return address from the shadow stack. Currently we do write index,
update the curr_ret_stack, and rewrite it again. But that is not enough
for the case if two interrupts happens and the first one breaks it.
For example,

 1. write reserved index entry at ret_stack[new_index - 1] and ret addr.
 2. interrupt comes.
    2.1. push new index and ret addr on ret_stack.
    2.2. pop it. (corrupt entries on new_index - 1)
 3. return from interrupt.
 4. update curr_ret_stack = new_index
 5. interrupt comes again.
    5.1. unwind <------ may not work.

To avoid this issue, this introduces a new rsrv_ret_stack stack
reservation pointer and a new push code (slow path) to commit
previous reserved code forcibly.

 0. update rsrv_ret_stack = new_index.
 1. write reserved index entry at ret_stack[new_index - 1] and ret addr.
 2. interrupt comes.
    2.0. if rsrv_ret_stack != curr_ret_stack, add reserved index
        entry on ret_stack[rsrv_ret_stack - 1] to point the previous
	ret_stack pointed by ret_stack[curr_ret_stack - 1]. and
	update curr_ret_stack = rsrv_ret_stack.
    2.1. push new index and ret addr on ret_stack.
    2.2. pop it. (corrupt entries on new_index - 1)
 3. return from interrupt.
 4. update curr_ret_stack = new_index
 5. interrupt comes again.
    5.1. unwind works, because curr_ret_stack points the previously
        saved ret_stack.
    5.2. this can do push/pop operations too.
6. return from interrupt.
7. rewrite reserved index entry at ret_stack[new_index] again.

This maybe a bit heavier but safer.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 include/linux/sched.h |   1 +
 kernel/trace/fgraph.c | 133 ++++++++++++++++++++++++++++++------------
 2 files changed, 97 insertions(+), 37 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 4dab30f00211..fda551e1aade 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1387,6 +1387,7 @@ struct task_struct {
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 	/* Index of current stored address in ret_stack: */
 	int				curr_ret_stack;
+	int				rsrv_ret_stack;
 	int				curr_ret_depth;
 
 	/* Stack of return addresses for return function tracing: */
diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index 47f389834b50..bf7a6eebff75 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -298,31 +298,47 @@ void *fgraph_reserve_data(int idx, int size_bytes)
 	unsigned long val;
 	void *data;
 	int curr_ret_stack = current->curr_ret_stack;
+	int rsrv_ret_stack = current->rsrv_ret_stack;
 	int data_size;
 
 	if (size_bytes > FGRAPH_MAX_DATA_SIZE)
 		return NULL;
 
+	/*
+	 * Since this API is used after pushing ret_stack, curr_ret_stack
+	 * should be synchronized with rsrv_ret_stack.
+	 */
+	if (WARN_ON_ONCE(curr_ret_stack != rsrv_ret_stack))
+		return NULL;
+
 	/* Convert to number of longs + data word */
 	data_size = DIV_ROUND_UP(size_bytes, sizeof(long));
 
 	val = get_fgraph_entry(current, curr_ret_stack - 1);
 	data = &current->ret_stack[curr_ret_stack];
 
-	curr_ret_stack += data_size + 1;
-	if (unlikely(curr_ret_stack >= SHADOW_STACK_MAX_INDEX))
+	rsrv_ret_stack += data_size + 1;
+	if (unlikely(rsrv_ret_stack >= SHADOW_STACK_MAX_INDEX))
 		return NULL;
 
 	val = make_fgraph_data(idx, data_size, __get_index(val) + data_size + 1);
 
-	/* Set the last word to be reserved */
-	current->ret_stack[curr_ret_stack - 1] = val;
-
-	/* Make sure interrupts see this */
+	/* Extend the reserved-ret_stack at first */
+	current->rsrv_ret_stack = rsrv_ret_stack;
+	/* And sync with interrupts, to see the new rsrv_ret_stack */
+	barrier();
+	/*
+	 * The same reason as the push, this entry must be here before updating
+	 * the curr_ret_stack. But any interrupt comes before updating
+	 * curr_ret_stack, it may commit it with different reserve entry.
+	 * Thus we need to write the data entry after update the curr_ret_stack
+	 * again. And these operations must be ordered.
+	 */
+	current->ret_stack[rsrv_ret_stack - 1] = val;
 	barrier();
-	current->curr_ret_stack = curr_ret_stack;
-	/* Again sync with interrupts, and reset reserve */
-	current->ret_stack[curr_ret_stack - 1] = val;
+	current->curr_ret_stack = rsrv_ret_stack;
+	barrier();
+	current->ret_stack[rsrv_ret_stack - 1] = val;
 
 	return data;
 }
@@ -403,7 +419,16 @@ get_ret_stack(struct task_struct *t, int offset, int *index)
 		return NULL;
 
 	idx = get_ret_stack_index(t, --offset);
-	if (WARN_ON_ONCE(idx <= 0 || idx > offset))
+	/*
+	 * This can happen if an interrupt comes just before the first push
+	 * increments the curr_ret_stack, and that interrupt pushes another
+	 * entry. In that case, the frist push is forcibly committed with a
+	 * reserved entry which points -1 stack index.
+	 */
+	if (unlikely(idx > offset))
+		return NULL;
+
+	if (WARN_ON_ONCE(idx <= 0))
 		return NULL;
 
 	offset -= idx;
@@ -473,7 +498,7 @@ ftrace_push_return_trace(unsigned long ret, unsigned long func,
 	struct ftrace_ret_stack *ret_stack;
 	unsigned long long calltime;
 	unsigned long val;
-	int index;
+	int index, rindex;
 
 	if (unlikely(ftrace_graph_is_dead()))
 		return -EBUSY;
@@ -481,17 +506,37 @@ ftrace_push_return_trace(unsigned long ret, unsigned long func,
 	if (!current->ret_stack)
 		return -EBUSY;
 
-	/*
-	 * At first, check whether the previous fgraph callback is pushed by
-	 * the fgraph on the same function entry.
-	 * But if @func is the self tail-call function, we also need to ensure
-	 * the ret_stack is not for the previous call by checking whether the
-	 * bit of @fgraph_idx is set or not.
-	 */
-	ret_stack = get_ret_stack(current, current->curr_ret_stack, &index);
-	if (ret_stack && ret_stack->func == func &&
-	    !is_fgraph_index_set(current, index + FGRAPH_RET_INDEX, fgraph_idx))
-		return index + FGRAPH_RET_INDEX;
+	index = READ_ONCE(current->curr_ret_stack);
+	rindex = READ_ONCE(current->rsrv_ret_stack);
+	if (unlikely(index != rindex)) {
+		/*
+		 * This interrupts during pushing operation. Commit previous
+		 * push temporarily with reserved entry.
+		 */
+		if (unlikely(index <= 0))
+			/* This will make ret_stack[index - 1] points -1 */
+			val = rindex - index;
+		else
+			val = get_ret_stack_index(current, index - 1) +
+			      rindex - index;
+		current->ret_stack[rindex - 1] = val;
+		/* Forcibly commit it */
+		current->curr_ret_stack = index = rindex;
+	} else {
+		/*
+		 * At first, check whether the previous fgraph callback is pushed by
+		 * the fgraph on the same function entry.
+		 * But if @func is the self tail-call function, we also need to ensure
+		 * the ret_stack is not for the previous call by checking whether the
+		 * bit of @fgraph_idx is set or not.
+		 */
+		ret_stack = get_ret_stack(current, index, &index);
+		if (ret_stack && ret_stack->func == func &&
+		    !is_fgraph_index_set(current, index + FGRAPH_RET_INDEX, fgraph_idx))
+			return index + FGRAPH_RET_INDEX;
+		/* Since get_ret_stack() writes 'index', so recover it. */
+		index = rindex;
+	}
 
 	val = (FGRAPH_TYPE_RESERVED << FGRAPH_TYPE_SHIFT) | FGRAPH_RET_INDEX;
 
@@ -511,38 +556,45 @@ ftrace_push_return_trace(unsigned long ret, unsigned long func,
 
 	calltime = trace_clock_local();
 
-	index = READ_ONCE(current->curr_ret_stack);
 	ret_stack = RET_STACK(current, index);
 	index += FGRAPH_RET_INDEX;
 
-	/* ret offset = FGRAPH_RET_INDEX ; type = reserved */
+	/*
+	 * At first, reserve the ret_stack. Beyond this point, any interrupt
+	 * will only overwrite ret_stack[index] by a reserved entry which points
+	 * the previous ret_stack or -1.
+	 */
+	current->rsrv_ret_stack = index + 1;
+	/* And ensure that the following happens after reserved */
+	barrier();
+
 	current->ret_stack[index] = val;
 	ret_stack->ret = ret;
 	/*
 	 * The unwinders expect curr_ret_stack to point to either zero
-	 * or an index where to find the next ret_stack. Even though the
-	 * ret stack might be bogus, we want to write the ret and the
-	 * index to find the ret_stack before we increment the stack point.
-	 * If an interrupt comes in now before we increment the curr_ret_stack
-	 * it may blow away what we wrote. But that's fine, because the
-	 * index will still be correct (even though the 'ret' won't be).
-	 * What we worry about is the index being correct after we increment
-	 * the curr_ret_stack and before we update that index, as if an
-	 * interrupt comes in and does an unwind stack dump, it will need
-	 * at least a correct index!
+	 * or an index where to find the next ret_stack which has actual ret
+	 * address. Thus we want to write the ret and the index to find the
+	 * ret_stack before we increment the curr_ret_stack.
 	 */
 	barrier();
 	current->curr_ret_stack = index + 1;
 	/*
+	 * There are two possibilities here.
+	 * - More than one interrupts push/pop their entry between update
+	 *   rsrv_ret_stack and curr_ret_stack. In this case, curr_ret_stack
+	 *   is already equal to the rsrv_ret_stack and
+	 *   current->ret_stack[index] is overwritten by reserved entry which
+	 *   points the previous ret_stack. But ret_stack->ret is not.
+	 * - Or, no interrupts push/pop. So current->ret_stack[index] keeps
+	 *   its value.
 	 * This next barrier is to ensure that an interrupt coming in
-	 * will not corrupt what we are about to write.
+	 * will not overwrite what we are about to write anymore.
 	 */
 	barrier();
 
-	/* Still keep it reserved even if an interrupt came in */
+	/* Rewrite the entry again in case it was overwritten. */
 	current->ret_stack[index] = val;
 
-	ret_stack->ret = ret;
 	ret_stack->func = func;
 	ret_stack->calltime = calltime;
 #ifdef HAVE_FUNCTION_GRAPH_FP_TEST
@@ -636,6 +688,7 @@ int function_graph_enter_regs(unsigned long ret, unsigned long func,
 	return 0;
  out_ret:
 	current->curr_ret_stack -= FGRAPH_RET_INDEX + 1;
+	current->rsrv_ret_stack = current->curr_ret_stack;
  out:
 	current->curr_ret_depth--;
 	return -EBUSY;
@@ -680,6 +733,7 @@ int function_graph_enter_ops(unsigned long ret, unsigned long func,
 
 	if (type == FGRAPH_TYPE_RESERVED) {
 		current->curr_ret_stack -= FGRAPH_RET_INDEX + 1;
+		current->rsrv_ret_stack = current->curr_ret_stack;
 		current->curr_ret_depth--;
 	}
 	return -EBUSY;
@@ -840,6 +894,7 @@ static unsigned long __ftrace_return_to_handler(struct ftrace_regs *fregs,
 	 */
 	barrier();
 	current->curr_ret_stack = index - FGRAPH_RET_INDEX;
+	current->rsrv_ret_stack = current->curr_ret_stack;
 
 	current->curr_ret_depth--;
 	return ret;
@@ -1031,6 +1086,7 @@ static int alloc_retstack_tasklist(unsigned long **ret_stack_list)
 			atomic_set(&t->trace_overrun, 0);
 			ret_stack_init_task_vars(ret_stack_list[start]);
 			t->curr_ret_stack = 0;
+			t->rsrv_ret_stack = 0;
 			t->curr_ret_depth = -1;
 			/* Make sure the tasks see the 0 first: */
 			smp_wmb();
@@ -1093,6 +1149,7 @@ graph_init_task(struct task_struct *t, unsigned long *ret_stack)
 	ret_stack_init_task_vars(ret_stack);
 	t->ftrace_timestamp = 0;
 	t->curr_ret_stack = 0;
+	t->rsrv_ret_stack = 0;
 	t->curr_ret_depth = -1;
 	/* make curr_ret_stack visible before we add the ret_stack */
 	smp_wmb();
@@ -1106,6 +1163,7 @@ graph_init_task(struct task_struct *t, unsigned long *ret_stack)
 void ftrace_graph_init_idle_task(struct task_struct *t, int cpu)
 {
 	t->curr_ret_stack = 0;
+	t->rsrv_ret_stack = 0;
 	t->curr_ret_depth = -1;
 	/*
 	 * The idle task has no parent, it either has its own
@@ -1134,6 +1192,7 @@ void ftrace_graph_init_task(struct task_struct *t)
 	/* Make sure we do not use the parent ret_stack */
 	t->ret_stack = NULL;
 	t->curr_ret_stack = 0;
+	t->rsrv_ret_stack = 0;
 	t->curr_ret_depth = -1;
 
 	if (ftrace_graph_active) {
-- 
2.43.0.472.g3155946c3a-goog


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

