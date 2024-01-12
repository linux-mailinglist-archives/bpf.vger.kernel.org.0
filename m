Return-Path: <bpf+bounces-19437-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 192A282BE5B
	for <lists+bpf@lfdr.de>; Fri, 12 Jan 2024 11:18:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B0761C2531E
	for <lists+bpf@lfdr.de>; Fri, 12 Jan 2024 10:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA3C160B93;
	Fri, 12 Jan 2024 10:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fLN2UMo8"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476C75D916;
	Fri, 12 Jan 2024 10:14:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13F5FC433C7;
	Fri, 12 Jan 2024 10:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705054493;
	bh=3y7/UQ9jP1JyrMUIVzw+uMu03u1MVFX8UqCJ0lQhJRQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fLN2UMo84x0dByeQY4WvElW6LNqj/zvsBLTqfBmr5YzTqVPKh7vDNesPKROHdXsUD
	 Lc+Cy3de01SJ/jjkTU3nAq71yQt1Lc/5CRv6F6OfI4G9KuQY8mF8j6ZMwcVY7/FsXI
	 kQiFQONf5WJ8IO33LaPo8TtwMB3AzFvO7nVXRO7KsdTzFl8TZ8SF+eR+iRlten9ebq
	 R3kynMsL+DSQpPu2N7NhQJXC62usaFubh4OG3jpYG8VFXBpy3GTZBcnDiImjJkqmFu
	 ywq5gj/cCMI5kz+PhvbujOfxF/Wc98dJ9925yE0DwUfMKZd6ipV1TsjrATuRTZI//2
	 wcwzBW89z5V2A==
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
Subject: [PATCH v6 20/36] function_graph: Improve push operation for several interrupts
Date: Fri, 12 Jan 2024 19:14:47 +0900
Message-Id: <170505448743.459169.5432129428639964197.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <170505424954.459169.10630626365737237288.stgit@devnote2>
References: <170505424954.459169.10630626365737237288.stgit@devnote2>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

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
 Changes in v6:
  - Newly added.
---
 include/linux/sched.h |    1 
 kernel/trace/fgraph.c |  135 +++++++++++++++++++++++++++++++++++--------------
 2 files changed, 98 insertions(+), 38 deletions(-)

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
index a0eb7077b853..6a9206ebc6a2 100644
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
@@ -481,18 +506,38 @@ ftrace_push_return_trace(unsigned long ret, unsigned long func,
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
-	    get_fgraph_type(current, index + FGRAPH_RET_INDEX) == FGRAPH_TYPE_BITMAP &&
-	    !is_fgraph_index_set(current, index + FGRAPH_RET_INDEX, fgraph_idx))
-		return index + FGRAPH_RET_INDEX;
+	index = READ_ONCE(current->curr_ret_stack);
+	rindex = READ_ONCE(current->rsrv_ret_stack);
+	if (unlikely(index != rindex)) {
+		/*
+		 * This interrupts the push operation. Commit previous push
+		 * temporarily with reserved entry.
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
+		 * Check whether the previous fgraph callback is pushed by the fgraph
+		 * on the same function entry.
+		 * But if @func is the self tail-call function, we also need to ensure
+		 * the ret_stack is not for the previous call by checking whether the
+		 * bit of @fgraph_idx is set or not.
+		 */
+		ret_stack = get_ret_stack(current, index, &index);
+		if (ret_stack && ret_stack->func == func &&
+		    get_fgraph_type(current, index + FGRAPH_RET_INDEX) == FGRAPH_TYPE_BITMAP &&
+		    !is_fgraph_index_set(current, index + FGRAPH_RET_INDEX, fgraph_idx))
+			return index + FGRAPH_RET_INDEX;
+		/* Since get_ret_stack() overwrites 'index', recover it. */
+		index = rindex;
+	}
 
 	val = (FGRAPH_TYPE_RESERVED << FGRAPH_TYPE_SHIFT) | FGRAPH_RET_INDEX;
 
@@ -512,38 +557,45 @@ ftrace_push_return_trace(unsigned long ret, unsigned long func,
 
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
@@ -625,6 +677,7 @@ int function_graph_enter(unsigned long ret, unsigned long func,
 	return 0;
  out_ret:
 	current->curr_ret_stack -= FGRAPH_RET_INDEX + 1;
+	current->rsrv_ret_stack = current->curr_ret_stack;
  out:
 	current->curr_ret_depth--;
 	return -EBUSY;
@@ -668,6 +721,7 @@ int function_graph_enter_ops(unsigned long ret, unsigned long func,
 
 	if (type == FGRAPH_TYPE_RESERVED) {
 		current->curr_ret_stack -= FGRAPH_RET_INDEX + 1;
+		current->rsrv_ret_stack = current->curr_ret_stack;
 		current->curr_ret_depth--;
 	}
 	return -EBUSY;
@@ -810,6 +864,7 @@ static unsigned long __ftrace_return_to_handler(struct fgraph_ret_regs *ret_regs
 	 */
 	barrier();
 	current->curr_ret_stack = index - FGRAPH_RET_INDEX;
+	current->rsrv_ret_stack = current->curr_ret_stack;
 
 	current->curr_ret_depth--;
 	return ret;
@@ -998,6 +1053,7 @@ static int alloc_retstack_tasklist(unsigned long **ret_stack_list)
 			atomic_set(&t->trace_overrun, 0);
 			ret_stack_init_task_vars(ret_stack_list[start]);
 			t->curr_ret_stack = 0;
+			t->rsrv_ret_stack = 0;
 			t->curr_ret_depth = -1;
 			/* Make sure the tasks see the 0 first: */
 			smp_wmb();
@@ -1060,6 +1116,7 @@ graph_init_task(struct task_struct *t, unsigned long *ret_stack)
 	ret_stack_init_task_vars(ret_stack);
 	t->ftrace_timestamp = 0;
 	t->curr_ret_stack = 0;
+	t->rsrv_ret_stack = 0;
 	t->curr_ret_depth = -1;
 	/* make curr_ret_stack visible before we add the ret_stack */
 	smp_wmb();
@@ -1073,6 +1130,7 @@ graph_init_task(struct task_struct *t, unsigned long *ret_stack)
 void ftrace_graph_init_idle_task(struct task_struct *t, int cpu)
 {
 	t->curr_ret_stack = 0;
+	t->rsrv_ret_stack = 0;
 	t->curr_ret_depth = -1;
 	/*
 	 * The idle task has no parent, it either has its own
@@ -1101,6 +1159,7 @@ void ftrace_graph_init_task(struct task_struct *t)
 	/* Make sure we do not use the parent ret_stack */
 	t->ret_stack = NULL;
 	t->curr_ret_stack = 0;
+	t->rsrv_ret_stack = 0;
 	t->curr_ret_depth = -1;
 
 	if (ftrace_graph_active) {


