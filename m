Return-Path: <bpf+bounces-28844-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48E498BE54D
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 16:10:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B59D1C23AB4
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 14:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEA0A15FA62;
	Tue,  7 May 2024 14:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MxFprIOe"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E20515F3F7;
	Tue,  7 May 2024 14:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715090969; cv=none; b=OnNG/6G7CtlKfDzT2qjDVjw8sP+wQcZgLUMxFGo93z+SHOXtAafW5FPIybreHxLn75zu7Fo/fOtGk0l9ZHfI3aiBz6gOOh99yjb2TvSjvsupaGnlJbVCDeADT62SpHYAkYozcXUbVvMwk235ikHCofS6S09I/bCUYe46uZ7S43U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715090969; c=relaxed/simple;
	bh=9Sk4nBeDfZzPDhsdlUbbw9Kv2K7QineBYDCSca7Y4BM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JHdEqzvX9cbLvZXgO2WZcto+wwzQ9mDqEoAxOUonelYtzfNFD3/RBpheZTfEbNzRavgS8N7JKzyhts//Vit3W8QDnBJewyZ15g9RX4VET86Jwqjhl6YsSSicDPmUmCi8XkD5csF6b0KFCFmWX2u/ryL4SRR8kPoeqP+Lw+QPDCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MxFprIOe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9AE4C2BBFC;
	Tue,  7 May 2024 14:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715090968;
	bh=9Sk4nBeDfZzPDhsdlUbbw9Kv2K7QineBYDCSca7Y4BM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MxFprIOe6rLTejL91l3diED5D0ze6wHc1BsiAS1Sjx91jhXDwzOK7tEvO2t2E98Fu
	 2kXd/BKXhvAsiyr0LWmNregCjs3EFYWdyNHo6QLlxrV1PAQSeu27zLXp1bUwgCP/TD
	 C7NnrjNaUlmd4XN0yIhVfU9uGPhsBDXqs0LSITXFYeyulWjzSIRMe9B4OUAsj/kbB3
	 nQQdeO5Sx9BxXb9hsQPUKBupWgFwsTZFGsCXMtYLe6MTcMJSt7A1p53i9WzLLuWmr5
	 XUOnI4c7Aa22dVAuhLjObyD5Ck3rEVppMHuNN2IsAuulriZkUf1dlm4wLbpU1W9Y7m
	 7NPPZ6crtLB0A==
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
Subject: [PATCH v10 07/36] function_graph: Allow multiple users to attach to function graph
Date: Tue,  7 May 2024 23:09:22 +0900
Message-Id: <171509096221.162236.8806372072523195752.stgit@devnote2>
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

Allow for multiple users to attach to function graph tracer at the same
time. Only 16 simultaneous users can attach to the tracer. This is because
there's an array that stores the pointers to the attached fgraph_ops. When
a function being traced is entered, each of the ftrace_ops entryfunc is
called and if it returns non zero, its index into the array will be added
to the shadow stack.

On exit of the function being traced, the shadow stack will contain the
indexes of the ftrace_ops on the array that want their retfunc to be
called.

Because a function may sleep for a long time (if a task sleeps itself),
the return of the function may be literally days later. If the ftrace_ops
is removed, its place on the array is replaced with a ftrace_ops that
contains the stub functions and that will be called when the function
finally returns.

If another ftrace_ops is added that happens to get the same index into the
array, its return function may be called. But that's actually the way
things current work with the old function graph tracer. If one tracer is
removed and another is added, the new one will get the return calls of the
function traced by the previous one, thus this is not a regression. This
can be fixed by adding a counter to each time the array item is updated and
save that on the shadow stack as well, such that it won't be called if the
index saved does not match the index on the array.

Note, being able to filter functions when both are called is not completely
handled yet, but that shouldn't be too hard to manage.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 Changes in v10:
  - Rephrase all "index" on shadow stack to "offset" and some "ret_stack" to
   "frame".
  - Macros are renamed;
    FGRAPH_RET_SIZE to FGRAPH_FRAME_SIZE
    FGRAPH_RET_INDEX to FGRAPH_FRAME_OFFSET
    FGRAPH_RET_INDEX_SIZE to FGRAPH_FRAME_OFFSET_SIZE
    FGRAPH_RET_INDEX_MASK to FGRAPH_FRAME_OFFSET_MASK
    SHADOW_STACK_INDEX to SHADOW_STACK_IN_WORD
    SHADOW_STACK_MAX_INDEX to SHADOW_STACK_MAX_OFFSET
  - Remove unused FGRAPH_MAX_INDEX macro.
  - Fix wrong explanation of the shadow stack entry.
 Changes in v7:
  - Fix max limitation check in ftrace_graph_push_return().
  - Rewrite the shadow stack implementation using bitmap entry. This allows
    us to detect recursive call/tail call easier. (this implementation is
    moved from later patch in the series.
 Changes in v2:
  - Check return value of the ftrace_pop_return_trace() instead of 'ret'
    since 'ret' is set to the address of panic().
  - Fix typo and make lines shorter than 76 chars in description.
---
 include/linux/ftrace.h |    3 
 kernel/trace/fgraph.c  |  378 +++++++++++++++++++++++++++++++++++++++---------
 2 files changed, 310 insertions(+), 71 deletions(-)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index d5df5f8fc35a..0a1a7316de7b 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -1066,6 +1066,7 @@ extern int ftrace_graph_entry_stub(struct ftrace_graph_ent *trace);
 struct fgraph_ops {
 	trace_func_graph_ent_t		entryfunc;
 	trace_func_graph_ret_t		retfunc;
+	int				idx;
 };
 
 /*
@@ -1100,7 +1101,7 @@ function_graph_enter(unsigned long ret, unsigned long func,
 		     unsigned long frame_pointer, unsigned long *retp);
 
 struct ftrace_ret_stack *
-ftrace_graph_get_ret_stack(struct task_struct *task, int idx);
+ftrace_graph_get_ret_stack(struct task_struct *task, int skip);
 
 unsigned long ftrace_graph_ret_addr(struct task_struct *task, int *idx,
 				    unsigned long ret, unsigned long *retp);
diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index 3f9dd213e7d8..6b06962657fe 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -7,6 +7,7 @@
  *
  * Highly modified by Steven Rostedt (VMware).
  */
+#include <linux/bits.h>
 #include <linux/jump_label.h>
 #include <linux/suspend.h>
 #include <linux/ftrace.h>
@@ -25,25 +26,157 @@
 #define ASSIGN_OPS_HASH(opsname, val)
 #endif
 
-#define FGRAPH_RET_SIZE sizeof(struct ftrace_ret_stack)
-#define FGRAPH_RET_INDEX DIV_ROUND_UP(FGRAPH_RET_SIZE, sizeof(long))
+#define FGRAPH_FRAME_SIZE sizeof(struct ftrace_ret_stack)
+#define FGRAPH_FRAME_OFFSET DIV_ROUND_UP(FGRAPH_FRAME_SIZE, sizeof(long))
+
+/*
+ * On entry to a function (via function_graph_enter()), a new ftrace_ret_stack
+ * is allocated on the task's ret_stack with bitmap entry, then each
+ * fgraph_ops on the fgraph_array[]'s entryfunc is called and if that returns
+ * non-zero, the index into the fgraph_array[] for that fgraph_ops is recorded
+ * on the bitmap entry as a bit flag.
+ *
+ * The top of the ret_stack (when not empty) will always have a reference
+ * to the last ftrace_ret_stack saved. All references to the
+ * ftrace_ret_stack has the format of:
+ *
+ * bits:  0 -  9	offset in words from the previous ftrace_ret_stack
+ *			(bitmap type should have FGRAPH_FRAME_OFFSET always)
+ * bits: 10 - 11	Type of storage
+ *			  0 - reserved
+ *			  1 - bitmap of fgraph_array index
+ *
+ * For bitmap of fgraph_array index
+ *  bits: 12 - 27	The bitmap of fgraph_ops fgraph_array index
+ *
+ * That is, at the end of function_graph_enter, if the first and forth
+ * fgraph_ops on the fgraph_array[] (index 0 and 3) needs their retfunc called
+ * on the return of the function being traced, this is what will be on the
+ * task's shadow ret_stack: (the stack grows upward)
+ *
+ *  ret_stack[SHADOW_STACK_MAX_OFFSET]
+ * ...
+ * |                                            | <- task->curr_ret_stack
+ * +--------------------------------------------+
+ * | (BIT(3)|BIT(0)) << FGRAPH_INDEX_SHIFT | \  |
+ * | FGRAPH_TYPE_BITMAP << FGRAPH_TYPE_SHIFT| \ |
+ * | (offset:FGRAPH_FRAME_OFFSET)               | <- the offset is from here
+ * +--------------------------------------------+
+ * | struct ftrace_ret_stack                    |
+ * |   (stores the saved ret pointer)           | <- the offset points here
+ * +--------------------------------------------+
+ * |                 (X) | (N)                  | ( N words away from
+ * |                                            |   previous ret_stack)
+ * ...
+ * ret_stack[0]
+ *
+ * If a backtrace is required, and the real return pointer needs to be
+ * fetched, then it looks at the task's curr_ret_stack offset, if it
+ * is greater than zero (reserved, or right before poped), it would mask
+ * the value by FGRAPH_FRAME_OFFSET_MASK to get the offset of the
+ * ftrace_ret_stack structure stored on the shadow stack.
+ */
+
+#define FGRAPH_FRAME_OFFSET_SIZE	10
+#define FGRAPH_FRAME_OFFSET_MASK	GENMASK(FGRAPH_FRAME_OFFSET_SIZE - 1, 0)
+
+#define FGRAPH_TYPE_SIZE	2
+#define FGRAPH_TYPE_MASK	GENMASK(FGRAPH_TYPE_SIZE - 1, 0)
+#define FGRAPH_TYPE_SHIFT	FGRAPH_FRAME_OFFSET_SIZE
+
+enum {
+	FGRAPH_TYPE_RESERVED	= 0,
+	FGRAPH_TYPE_BITMAP	= 1,
+};
+
+#define FGRAPH_INDEX_SIZE	16
+#define FGRAPH_INDEX_MASK	GENMASK(FGRAPH_INDEX_SIZE - 1, 0)
+#define FGRAPH_INDEX_SHIFT	(FGRAPH_TYPE_SHIFT + FGRAPH_TYPE_SIZE)
+
+#define FGRAPH_ARRAY_SIZE	FGRAPH_INDEX_SIZE
+
 #define SHADOW_STACK_SIZE (PAGE_SIZE)
-#define SHADOW_STACK_INDEX (SHADOW_STACK_SIZE / sizeof(long))
+#define SHADOW_STACK_IN_WORD (SHADOW_STACK_SIZE / sizeof(long))
 /* Leave on a buffer at the end */
-#define SHADOW_STACK_MAX_INDEX (SHADOW_STACK_INDEX - FGRAPH_RET_INDEX)
+#define SHADOW_STACK_MAX_OFFSET (SHADOW_STACK_IN_WORD - (FGRAPH_FRAME_OFFSET + 1))
 
-#define RET_STACK(t, index) ((struct ftrace_ret_stack *)(&(t)->ret_stack[index]))
-#define RET_STACK_INC(c) ({ c += FGRAPH_RET_INDEX; })
-#define RET_STACK_DEC(c) ({ c -= FGRAPH_RET_INDEX; })
+#define RET_STACK(t, offset) ((struct ftrace_ret_stack *)(&(t)->ret_stack[offset]))
 
 DEFINE_STATIC_KEY_FALSE(kill_ftrace_graph);
 int ftrace_graph_active;
 
 static int fgraph_array_cnt;
-#define FGRAPH_ARRAY_SIZE	16
 
 static struct fgraph_ops *fgraph_array[FGRAPH_ARRAY_SIZE];
 
+static inline int get_frame_offset(struct task_struct *t, int offset)
+{
+	return t->ret_stack[offset] & FGRAPH_FRAME_OFFSET_MASK;
+}
+
+static inline int get_fgraph_type(struct task_struct *t, int offset)
+{
+	return (t->ret_stack[offset] >> FGRAPH_TYPE_SHIFT) & FGRAPH_TYPE_MASK;
+}
+
+static inline unsigned long
+get_fgraph_index_bitmap(struct task_struct *t, int offset)
+{
+	return (t->ret_stack[offset] >> FGRAPH_INDEX_SHIFT) & FGRAPH_INDEX_MASK;
+}
+
+static inline void
+set_fgraph_index_bitmap(struct task_struct *t, int offset, unsigned long bitmap)
+{
+	t->ret_stack[offset] = (bitmap << FGRAPH_INDEX_SHIFT) |
+		(FGRAPH_TYPE_BITMAP << FGRAPH_TYPE_SHIFT) | FGRAPH_FRAME_OFFSET;
+}
+
+static inline bool is_fgraph_index_set(struct task_struct *t, int offset, int idx)
+{
+	return !!(get_fgraph_index_bitmap(t, offset) & BIT(idx));
+}
+
+static inline void
+add_fgraph_index_bitmap(struct task_struct *t, int offset, unsigned long bitmap)
+{
+	t->ret_stack[offset] |= (bitmap << FGRAPH_INDEX_SHIFT);
+}
+
+/*
+ * @offset: The offset into @t->ret_stack to find the ret_stack entry
+ * @frame_offset: Where to place the offset into @t->ret_stack of that entry
+ *
+ * Calling this with:
+ *
+ *   offset = task->curr_ret_stack;
+ *   do {
+ *	ret_stack = get_ret_stack(task, offset, &offset);
+ *   } while (ret_stack);
+ *
+ * Will iterate through all the ret_stack entries from curr_ret_stack
+ * down to the first one.
+ */
+static inline struct ftrace_ret_stack *
+get_ret_stack(struct task_struct *t, int offset, int *frame_offset)
+{
+	int offs;
+
+	BUILD_BUG_ON(FGRAPH_FRAME_SIZE % sizeof(long));
+
+	if (unlikely(offset <= 0))
+		return NULL;
+
+	offs = get_frame_offset(t, --offset);
+	if (WARN_ON_ONCE(offs <= 0 || offs > offset))
+		return NULL;
+
+	offset -= offs;
+
+	*frame_offset = offset;
+	return RET_STACK(t, offset);
+}
+
 /* Both enabled by default (can be cleared by function_graph tracer flags */
 static bool fgraph_sleep_time = true;
 
@@ -97,11 +230,13 @@ void ftrace_graph_stop(void)
 /* Add a function return address to the trace stack on thread info.*/
 static int
 ftrace_push_return_trace(unsigned long ret, unsigned long func,
-			 unsigned long frame_pointer, unsigned long *retp)
+			 unsigned long frame_pointer, unsigned long *retp,
+			 int fgraph_idx)
 {
 	struct ftrace_ret_stack *ret_stack;
 	unsigned long long calltime;
-	int index;
+	unsigned long val;
+	int offset;
 
 	if (unlikely(ftrace_graph_is_dead()))
 		return -EBUSY;
@@ -109,6 +244,21 @@ ftrace_push_return_trace(unsigned long ret, unsigned long func,
 	if (!current->ret_stack)
 		return -EBUSY;
 
+	/*
+	 * At first, check whether the previous fgraph callback is pushed by
+	 * the fgraph on the same function entry.
+	 * But if @func is the self tail-call function, we also need to ensure
+	 * the ret_stack is not for the previous call by checking whether the
+	 * bit of @fgraph_idx is set or not.
+	 */
+	ret_stack = get_ret_stack(current, current->curr_ret_stack, &offset);
+	if (ret_stack && ret_stack->func == func &&
+	    get_fgraph_type(current, offset + FGRAPH_FRAME_OFFSET) == FGRAPH_TYPE_BITMAP &&
+	    !is_fgraph_index_set(current, offset + FGRAPH_FRAME_OFFSET, fgraph_idx))
+		return offset + FGRAPH_FRAME_OFFSET;
+
+	val = (FGRAPH_TYPE_RESERVED << FGRAPH_TYPE_SHIFT) | FGRAPH_FRAME_OFFSET;
+
 	BUILD_BUG_ON(SHADOW_STACK_SIZE % sizeof(long));
 
 	/*
@@ -118,17 +268,44 @@ ftrace_push_return_trace(unsigned long ret, unsigned long func,
 	smp_rmb();
 
 	/* The return trace stack is full */
-	if (current->curr_ret_stack >= SHADOW_STACK_MAX_INDEX) {
+	if (current->curr_ret_stack + FGRAPH_FRAME_OFFSET + 1 >= SHADOW_STACK_MAX_OFFSET) {
 		atomic_inc(&current->trace_overrun);
 		return -EBUSY;
 	}
 
 	calltime = trace_clock_local();
 
-	index = current->curr_ret_stack;
-	RET_STACK_INC(current->curr_ret_stack);
-	ret_stack = RET_STACK(current, index);
+	offset = READ_ONCE(current->curr_ret_stack);
+	ret_stack = RET_STACK(current, offset);
+	offset += FGRAPH_FRAME_OFFSET;
+
+	/* ret offset = FGRAPH_FRAME_OFFSET ; type = reserved */
+	current->ret_stack[offset] = val;
+	ret_stack->ret = ret;
+	/*
+	 * The unwinders expect curr_ret_stack to point to either zero
+	 * or an offset where to find the next ret_stack. Even though the
+	 * ret stack might be bogus, we want to write the ret and the
+	 * offset to find the ret_stack before we increment the stack point.
+	 * If an interrupt comes in now before we increment the curr_ret_stack
+	 * it may blow away what we wrote. But that's fine, because the
+	 * offset will still be correct (even though the 'ret' won't be).
+	 * What we worry about is the offset being correct after we increment
+	 * the curr_ret_stack and before we update that offset, as if an
+	 * interrupt comes in and does an unwind stack dump, it will need
+	 * at least a correct offset!
+	 */
+	barrier();
+	current->curr_ret_stack = offset + 1;
+	/*
+	 * This next barrier is to ensure that an interrupt coming in
+	 * will not corrupt what we are about to write.
+	 */
 	barrier();
+
+	/* Still keep it reserved even if an interrupt came in */
+	current->ret_stack[offset] = val;
+
 	ret_stack->ret = ret;
 	ret_stack->func = func;
 	ret_stack->calltime = calltime;
@@ -138,7 +315,7 @@ ftrace_push_return_trace(unsigned long ret, unsigned long func,
 #ifdef HAVE_FUNCTION_GRAPH_RET_ADDR_PTR
 	ret_stack->retp = retp;
 #endif
-	return 0;
+	return offset;
 }
 
 /*
@@ -155,10 +332,14 @@ ftrace_push_return_trace(unsigned long ret, unsigned long func,
 # define MCOUNT_INSN_SIZE 0
 #endif
 
+/* If the caller does not use ftrace, call this function. */
 int function_graph_enter(unsigned long ret, unsigned long func,
 			 unsigned long frame_pointer, unsigned long *retp)
 {
 	struct ftrace_graph_ent trace;
+	unsigned long bitmap = 0;
+	int offset;
+	int i;
 
 #ifndef CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS
 	/*
@@ -171,44 +352,59 @@ int function_graph_enter(unsigned long ret, unsigned long func,
 	    ftrace_find_rec_direct(ret - MCOUNT_INSN_SIZE))
 		return -EBUSY;
 #endif
+
 	trace.func = func;
 	trace.depth = ++current->curr_ret_depth;
 
-	if (ftrace_push_return_trace(ret, func, frame_pointer, retp))
+	offset = ftrace_push_return_trace(ret, func, frame_pointer, retp, 0);
+	if (offset < 0)
 		goto out;
 
-	/* Only trace if the calling function expects to */
-	if (!fgraph_array[0]->entryfunc(&trace))
+	for (i = 0; i < fgraph_array_cnt; i++) {
+		struct fgraph_ops *gops = fgraph_array[i];
+
+		if (gops == &fgraph_stub)
+			continue;
+
+		if (gops->entryfunc(&trace))
+			bitmap |= BIT(i);
+	}
+
+	if (!bitmap)
 		goto out_ret;
 
+	/*
+	 * Since this function uses fgraph_idx = 0 as a tail-call checking
+	 * flag, set that bit always.
+	 */
+	set_fgraph_index_bitmap(current, offset, bitmap | BIT(0));
+
 	return 0;
  out_ret:
-	RET_STACK_DEC(current->curr_ret_stack);
+	current->curr_ret_stack -= FGRAPH_FRAME_OFFSET + 1;
  out:
 	current->curr_ret_depth--;
 	return -EBUSY;
 }
 
 /* Retrieve a function return address to the trace stack on thread info.*/
-static void
+static struct ftrace_ret_stack *
 ftrace_pop_return_trace(struct ftrace_graph_ret *trace, unsigned long *ret,
-			unsigned long frame_pointer)
+			unsigned long frame_pointer, int *offset)
 {
 	struct ftrace_ret_stack *ret_stack;
-	int index;
 
-	index = current->curr_ret_stack;
-	RET_STACK_DEC(index);
+	ret_stack = get_ret_stack(current, current->curr_ret_stack, offset);
 
-	if (unlikely(index < 0 || index > SHADOW_STACK_MAX_INDEX)) {
+	if (unlikely(!ret_stack)) {
 		ftrace_graph_stop();
-		WARN_ON(1);
+		WARN(1, "Bad function graph ret_stack pointer: %d",
+		     current->curr_ret_stack);
 		/* Might as well panic, otherwise we have no where to go */
 		*ret = (unsigned long)panic;
-		return;
+		return NULL;
 	}
 
-	ret_stack = RET_STACK(current, index);
 #ifdef HAVE_FUNCTION_GRAPH_FP_TEST
 	/*
 	 * The arch may choose to record the frame pointer used
@@ -228,26 +424,29 @@ ftrace_pop_return_trace(struct ftrace_graph_ret *trace, unsigned long *ret,
 		ftrace_graph_stop();
 		WARN(1, "Bad frame pointer: expected %lx, received %lx\n"
 		     "  from func %ps return to %lx\n",
-		     current->ret_stack[index].fp,
+		     ret_stack->fp,
 		     frame_pointer,
 		     (void *)ret_stack->func,
 		     ret_stack->ret);
 		*ret = (unsigned long)panic;
-		return;
+		return NULL;
 	}
 #endif
 
+	*offset += FGRAPH_FRAME_OFFSET;
 	*ret = ret_stack->ret;
 	trace->func = ret_stack->func;
 	trace->calltime = ret_stack->calltime;
 	trace->overrun = atomic_read(&current->trace_overrun);
-	trace->depth = current->curr_ret_depth--;
+	trace->depth = current->curr_ret_depth;
 	/*
 	 * We still want to trace interrupts coming in if
 	 * max_depth is set to 1. Make sure the decrement is
 	 * seen before ftrace_graph_return.
 	 */
 	barrier();
+
+	return ret_stack;
 }
 
 /*
@@ -285,30 +484,47 @@ struct fgraph_ret_regs;
 static unsigned long __ftrace_return_to_handler(struct fgraph_ret_regs *ret_regs,
 						unsigned long frame_pointer)
 {
+	struct ftrace_ret_stack *ret_stack;
 	struct ftrace_graph_ret trace;
+	unsigned long bitmap;
 	unsigned long ret;
+	int offset;
+	int i;
+
+	ret_stack = ftrace_pop_return_trace(&trace, &ret, frame_pointer, &offset);
 
-	ftrace_pop_return_trace(&trace, &ret, frame_pointer);
+	if (unlikely(!ret_stack)) {
+		ftrace_graph_stop();
+		WARN_ON(1);
+		/* Might as well panic. What else to do? */
+		return (unsigned long)panic;
+	}
+
+	trace.rettime = trace_clock_local();
 #ifdef CONFIG_FUNCTION_GRAPH_RETVAL
 	trace.retval = fgraph_ret_regs_return_value(ret_regs);
 #endif
-	trace.rettime = trace_clock_local();
-	fgraph_array[0]->retfunc(&trace);
+
+	bitmap = get_fgraph_index_bitmap(current, offset);
+	for (i = 0; i < FGRAPH_ARRAY_SIZE; i++) {
+		struct fgraph_ops *gops = fgraph_array[i];
+
+		if (!(bitmap & BIT(i)))
+			continue;
+		if (gops == &fgraph_stub)
+			continue;
+
+		gops->retfunc(&trace);
+	}
+
 	/*
 	 * The ftrace_graph_return() may still access the current
 	 * ret_stack structure, we need to make sure the update of
 	 * curr_ret_stack is after that.
 	 */
 	barrier();
-	RET_STACK_DEC(current->curr_ret_stack);
-
-	if (unlikely(!ret)) {
-		ftrace_graph_stop();
-		WARN_ON(1);
-		/* Might as well panic. What else to do? */
-		ret = (unsigned long)panic;
-	}
-
+	current->curr_ret_stack -= FGRAPH_FRAME_OFFSET + 1;
+	current->curr_ret_depth--;
 	return ret;
 }
 
@@ -331,7 +547,7 @@ unsigned long ftrace_return_to_handler(unsigned long frame_pointer)
 
 /**
  * ftrace_graph_get_ret_stack - return the entry of the shadow stack
- * @task: The task to read the shadow stack from
+ * @task: The task to read the shadow stack from.
  * @idx: Index down the shadow stack
  *
  * Return the ret_struct on the shadow stack of the @task at the
@@ -343,15 +559,17 @@ unsigned long ftrace_return_to_handler(unsigned long frame_pointer)
 struct ftrace_ret_stack *
 ftrace_graph_get_ret_stack(struct task_struct *task, int idx)
 {
-	int index = task->curr_ret_stack;
-
-	BUILD_BUG_ON(FGRAPH_RET_SIZE % sizeof(long));
+	struct ftrace_ret_stack *ret_stack = NULL;
+	int offset = task->curr_ret_stack;
 
-	index -= FGRAPH_RET_INDEX * (idx + 1);
-	if (index < 0)
+	if (offset < 0)
 		return NULL;
 
-	return RET_STACK(task, index);
+	do {
+		ret_stack = get_ret_stack(task, offset, &offset);
+	} while (ret_stack && --idx >= 0);
+
+	return ret_stack;
 }
 
 /**
@@ -374,17 +592,26 @@ unsigned long ftrace_graph_ret_addr(struct task_struct *task, int *idx,
 				    unsigned long ret, unsigned long *retp)
 {
 	struct ftrace_ret_stack *ret_stack;
-	int index = task->curr_ret_stack;
-	int i;
+	int i = task->curr_ret_stack;
 
 	if (ret != (unsigned long)dereference_kernel_function_descriptor(return_to_handler))
 		return ret;
 
-	RET_STACK_DEC(index);
-
-	for (i = index; i >= 0; RET_STACK_DEC(i)) {
-		ret_stack = RET_STACK(task, i);
-		if (ret_stack->retp == retp)
+	while (i > 0) {
+		ret_stack = get_ret_stack(current, i, &i);
+		if (!ret_stack)
+			break;
+		/*
+		 * For the tail-call, there would be 2 or more ftrace_ret_stacks on
+		 * the ret_stack, which records "return_to_handler" as the return
+		 * address excpt for the last one.
+		 * But on the real stack, there should be 1 entry because tail-call
+		 * reuses the return address on the stack and jump to the next function.
+		 * Thus we will continue to find real return address.
+		 */
+		if (ret_stack->retp == retp &&
+		    ret_stack->ret !=
+		    (unsigned long)dereference_kernel_function_descriptor(return_to_handler))
 			return ret_stack->ret;
 	}
 
@@ -394,21 +621,29 @@ unsigned long ftrace_graph_ret_addr(struct task_struct *task, int *idx,
 unsigned long ftrace_graph_ret_addr(struct task_struct *task, int *idx,
 				    unsigned long ret, unsigned long *retp)
 {
-	int task_idx;
+	struct ftrace_ret_stack *ret_stack;
+	int offset = task->curr_ret_stack;
+	int i;
 
 	if (ret != (unsigned long)dereference_kernel_function_descriptor(return_to_handler))
 		return ret;
 
-	task_idx = task->curr_ret_stack;
-	RET_STACK_DEC(task_idx);
-
-	if (!task->ret_stack || task_idx < *idx)
+	if (!idx)
 		return ret;
 
-	task_idx -= *idx;
-	RET_STACK_INC(*idx);
+	i = *idx;
+	do {
+		ret_stack = get_ret_stack(task, offset, &offset);
+		if (ret_stack && ret_stack->ret ==
+		    (unsigned long)dereference_kernel_function_descriptor(return_to_handler))
+			continue;
+		i--;
+	} while (i >= 0 && ret_stack);
+
+	if (ret_stack)
+		return ret_stack->ret;
 
-	return RET_STACK(task, task_idx);
+	return ret;
 }
 #endif /* HAVE_FUNCTION_GRAPH_RET_ADDR_PTR */
 
@@ -491,7 +726,7 @@ ftrace_graph_probe_sched_switch(void *ignore, bool preempt,
 {
 	struct ftrace_ret_stack *ret_stack;
 	unsigned long long timestamp;
-	int index;
+	int offset;
 
 	/*
 	 * Does the user want to count the time a function was asleep.
@@ -514,10 +749,10 @@ ftrace_graph_probe_sched_switch(void *ignore, bool preempt,
 	 */
 	timestamp -= next->ftrace_timestamp;
 
-	for (index = next->curr_ret_stack - FGRAPH_RET_INDEX; index >= 0; ) {
-		ret_stack = RET_STACK(next, index);
-		ret_stack->calltime += timestamp;
-		index -= FGRAPH_RET_INDEX;
+	for (offset = next->curr_ret_stack; offset > 0; ) {
+		ret_stack = get_ret_stack(next, offset, &offset);
+		if (ret_stack)
+			ret_stack->calltime += timestamp;
 	}
 }
 
@@ -568,6 +803,8 @@ graph_init_task(struct task_struct *t, unsigned long *ret_stack)
 {
 	atomic_set(&t->trace_overrun, 0);
 	t->ftrace_timestamp = 0;
+	t->curr_ret_stack = 0;
+	t->curr_ret_depth = -1;
 	/* make curr_ret_stack visible before we add the ret_stack */
 	smp_wmb();
 	t->ret_stack = ret_stack;
@@ -689,6 +926,7 @@ int register_ftrace_graph(struct fgraph_ops *gops)
 	fgraph_array[i] = gops;
 	if (i + 1 > fgraph_array_cnt)
 		fgraph_array_cnt = i + 1;
+	gops->idx = i;
 
 	ftrace_graph_active++;
 


