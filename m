Return-Path: <bpf+bounces-21320-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3A4D84B8F0
	for <lists+bpf@lfdr.de>; Tue,  6 Feb 2024 16:11:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFF921F24D6D
	for <lists+bpf@lfdr.de>; Tue,  6 Feb 2024 15:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF8B81350E2;
	Tue,  6 Feb 2024 15:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gso4WZ3t"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E88B1350DE;
	Tue,  6 Feb 2024 15:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707232145; cv=none; b=IwUDE7PWpEXkq8zGBDiuOcLvmB6UeHF6VelZB9QrS3EifIkolEYok2khtzGvct+cbwDQzrATPz7oT4dMFfWBGJxeAylowUDq+qcGSt8hRwpMuOCtTqOuRSODoqW177oTJaEwIbzW8um14uGmS6BqdHNHk5Z1AplY2I6khzv9lBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707232145; c=relaxed/simple;
	bh=JvpjIsFGwi7NsXme8GOIZ24f5xGxw81lrlfjHeVu8uU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hsMeoPwgywOCg17mZ0bHmpcZNGch927ySVd78FHxLgCfgIkoxNdXvOH6FqXXDvSyyq+9RivtOYEjpTbrUnOCJsYH1Iw4r3NXRKGaMgKJiMQ7p+mLgB9NhxzjdorIG0vjyJIDZxCw9oVBqc+/CJEx1Ip4DsXa1Xr1+jC6Oj0bPIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gso4WZ3t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEA29C433F1;
	Tue,  6 Feb 2024 15:09:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707232145;
	bh=JvpjIsFGwi7NsXme8GOIZ24f5xGxw81lrlfjHeVu8uU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gso4WZ3toCiFKX1/hFRhJE3WsAEZfLR266EtfxkW/x1Q2sxGK7sYg89aPcaPKnPG/
	 vfDSB2p2PWkthSXv5n/elBVoyMQS31oMr4boQq5i3XSMbYUg8uoQNpAcUXB7hjoQE4
	 3M8kfOwyff2e9iOt1Vt0UzycJLh5rVRh6dhgX3aygBxhFJEaaF7fZTVhm+5Gj2VtOT
	 wl/WJq/1IP6MJnmy0qGz6puw3gyyuTbPP4GpIjf3zunq4MXnEH6ZSU9iNjNf+DXRJc
	 95fdKPTBWcF38lEe+Yp/5/XgIe0uZzb/n55EYM0AhQ49UEkMlQ9jLr5oe0ro6IHMj3
	 d27zukmbYwLcw==
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
Subject: [PATCH v7 08/36] function_graph: Allow multiple users to attach to function graph
Date: Wed,  7 Feb 2024 00:08:59 +0900
Message-Id: <170723213956.502590.13803494278920984208.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <170723204881.502590.11906735097521170661.stgit@devnote2>
References: <170723204881.502590.11906735097521170661.stgit@devnote2>
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
 include/linux/ftrace.h |    1 
 kernel/trace/fgraph.c  |  360 ++++++++++++++++++++++++++++++++++++++++--------
 2 files changed, 301 insertions(+), 60 deletions(-)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 39ac1f3e8041..b39cc6d9b4a5 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -1066,6 +1066,7 @@ extern int ftrace_graph_entry_stub(struct ftrace_graph_ent *trace);
 struct fgraph_ops {
 	trace_func_graph_ent_t		entryfunc;
 	trace_func_graph_ret_t		retfunc;
+	int				idx;
 };
 
 /*
diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index 3f9dd213e7d8..b9a2399b75ee 100644
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
@@ -27,23 +28,157 @@
 
 #define FGRAPH_RET_SIZE sizeof(struct ftrace_ret_stack)
 #define FGRAPH_RET_INDEX DIV_ROUND_UP(FGRAPH_RET_SIZE, sizeof(long))
+
+/*
+ * On entry to a function (via function_graph_enter()), a new ftrace_ret_stack
+ * is allocated on the task's ret_stack with indexes entry, then each
+ * fgraph_ops on the fgraph_array[]'s entryfunc is called and if that returns
+ * non-zero, the index into the fgraph_array[] for that fgraph_ops is recorded
+ * on the indexes entry as a bit flag.
+ * As the associated ftrace_ret_stack saved for those fgraph_ops needs to
+ * be found, the index to it is also added to the ret_stack along with the
+ * index of the fgraph_array[] to each fgraph_ops that needs their retfunc
+ * called.
+ *
+ * The top of the ret_stack (when not empty) will always have a reference
+ * to the last ftrace_ret_stack saved. All references to the
+ * ftrace_ret_stack has the format of:
+ *
+ * bits:  0 -  9	offset in words from the previous ftrace_ret_stack
+ *			(bitmap type should have FGRAPH_RET_INDEX always)
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
+ * |                                            | <- task->curr_ret_stack
+ * +--------------------------------------------+
+ * | bitmap_type(bitmap:(BIT(3)|BIT(0)),        |
+ * |             offset:FGRAPH_RET_INDEX)       | <- the offset is from here
+ * +--------------------------------------------+
+ * | struct ftrace_ret_stack                    |
+ * |   (stores the saved ret pointer)           | <- the offset points here
+ * +--------------------------------------------+
+ * |                 (X) | (N)                  | ( N words away from
+ * |                                            |   previous ret_stack)
+ *
+ * If a backtrace is required, and the real return pointer needs to be
+ * fetched, then it looks at the task's curr_ret_stack index, if it
+ * is greater than zero (reserved, or right before poped), it would mask
+ * the value by FGRAPH_RET_INDEX_MASK to get the offset index of the
+ * ftrace_ret_stack structure stored on the shadow stack.
+ */
+
+#define FGRAPH_RET_INDEX_SIZE	10
+#define FGRAPH_RET_INDEX_MASK	GENMASK(FGRAPH_RET_INDEX_SIZE - 1, 0)
+
+#define FGRAPH_TYPE_SIZE	2
+#define FGRAPH_TYPE_MASK	GENMASK(FGRAPH_TYPE_SIZE - 1, 0)
+#define FGRAPH_TYPE_SHIFT	FGRAPH_RET_INDEX_SIZE
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
+/* Currently the max stack index can't be more than register callers */
+#define FGRAPH_MAX_INDEX	(FGRAPH_INDEX_SIZE + FGRAPH_RET_INDEX)
+
+#define FGRAPH_ARRAY_SIZE	FGRAPH_INDEX_SIZE
+
 #define SHADOW_STACK_SIZE (PAGE_SIZE)
 #define SHADOW_STACK_INDEX (SHADOW_STACK_SIZE / sizeof(long))
 /* Leave on a buffer at the end */
-#define SHADOW_STACK_MAX_INDEX (SHADOW_STACK_INDEX - FGRAPH_RET_INDEX)
+#define SHADOW_STACK_MAX_INDEX (SHADOW_STACK_INDEX - (FGRAPH_RET_INDEX + 1))
 
 #define RET_STACK(t, index) ((struct ftrace_ret_stack *)(&(t)->ret_stack[index]))
-#define RET_STACK_INC(c) ({ c += FGRAPH_RET_INDEX; })
-#define RET_STACK_DEC(c) ({ c -= FGRAPH_RET_INDEX; })
 
 DEFINE_STATIC_KEY_FALSE(kill_ftrace_graph);
 int ftrace_graph_active;
 
 static int fgraph_array_cnt;
-#define FGRAPH_ARRAY_SIZE	16
 
 static struct fgraph_ops *fgraph_array[FGRAPH_ARRAY_SIZE];
 
+static inline int get_ret_stack_index(struct task_struct *t, int offset)
+{
+	return t->ret_stack[offset] & FGRAPH_RET_INDEX_MASK;
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
+		(FGRAPH_TYPE_BITMAP << FGRAPH_TYPE_SHIFT) | FGRAPH_RET_INDEX;
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
+ * @offset: The index into @t->ret_stack to find the ret_stack entry
+ * @index: Where to place the index into @t->ret_stack of that entry
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
+get_ret_stack(struct task_struct *t, int offset, int *index)
+{
+	int idx;
+
+	BUILD_BUG_ON(FGRAPH_RET_SIZE % sizeof(long));
+
+	if (unlikely(offset <= 0))
+		return NULL;
+
+	idx = get_ret_stack_index(t, --offset);
+	if (WARN_ON_ONCE(idx <= 0 || idx > offset))
+		return NULL;
+
+	offset -= idx;
+
+	*index = offset;
+	return RET_STACK(t, offset);
+}
+
 /* Both enabled by default (can be cleared by function_graph tracer flags */
 static bool fgraph_sleep_time = true;
 
@@ -97,10 +232,12 @@ void ftrace_graph_stop(void)
 /* Add a function return address to the trace stack on thread info.*/
 static int
 ftrace_push_return_trace(unsigned long ret, unsigned long func,
-			 unsigned long frame_pointer, unsigned long *retp)
+			 unsigned long frame_pointer, unsigned long *retp,
+			 int fgraph_idx)
 {
 	struct ftrace_ret_stack *ret_stack;
 	unsigned long long calltime;
+	unsigned long val;
 	int index;
 
 	if (unlikely(ftrace_graph_is_dead()))
@@ -109,6 +246,21 @@ ftrace_push_return_trace(unsigned long ret, unsigned long func,
 	if (!current->ret_stack)
 		return -EBUSY;
 
+	/*
+	 * At first, check whether the previous fgraph callback is pushed by
+	 * the fgraph on the same function entry.
+	 * But if @func is the self tail-call function, we also need to ensure
+	 * the ret_stack is not for the previous call by checking whether the
+	 * bit of @fgraph_idx is set or not.
+	 */
+	ret_stack = get_ret_stack(current, current->curr_ret_stack, &index);
+	if (ret_stack && ret_stack->func == func &&
+	    get_fgraph_type(current, index + FGRAPH_RET_INDEX) == FGRAPH_TYPE_BITMAP &&
+	    !is_fgraph_index_set(current, index + FGRAPH_RET_INDEX, fgraph_idx))
+		return index + FGRAPH_RET_INDEX;
+
+	val = (FGRAPH_TYPE_RESERVED << FGRAPH_TYPE_SHIFT) | FGRAPH_RET_INDEX;
+
 	BUILD_BUG_ON(SHADOW_STACK_SIZE % sizeof(long));
 
 	/*
@@ -118,17 +270,44 @@ ftrace_push_return_trace(unsigned long ret, unsigned long func,
 	smp_rmb();
 
 	/* The return trace stack is full */
-	if (current->curr_ret_stack >= SHADOW_STACK_MAX_INDEX) {
+	if (current->curr_ret_stack + FGRAPH_RET_INDEX + 1 >= SHADOW_STACK_MAX_INDEX) {
 		atomic_inc(&current->trace_overrun);
 		return -EBUSY;
 	}
 
 	calltime = trace_clock_local();
 
-	index = current->curr_ret_stack;
-	RET_STACK_INC(current->curr_ret_stack);
+	index = READ_ONCE(current->curr_ret_stack);
 	ret_stack = RET_STACK(current, index);
+	index += FGRAPH_RET_INDEX;
+
+	/* ret offset = FGRAPH_RET_INDEX ; type = reserved */
+	current->ret_stack[index] = val;
+	ret_stack->ret = ret;
+	/*
+	 * The unwinders expect curr_ret_stack to point to either zero
+	 * or an index where to find the next ret_stack. Even though the
+	 * ret stack might be bogus, we want to write the ret and the
+	 * index to find the ret_stack before we increment the stack point.
+	 * If an interrupt comes in now before we increment the curr_ret_stack
+	 * it may blow away what we wrote. But that's fine, because the
+	 * index will still be correct (even though the 'ret' won't be).
+	 * What we worry about is the index being correct after we increment
+	 * the curr_ret_stack and before we update that index, as if an
+	 * interrupt comes in and does an unwind stack dump, it will need
+	 * at least a correct index!
+	 */
+	barrier();
+	current->curr_ret_stack = index + 1;
+	/*
+	 * This next barrier is to ensure that an interrupt coming in
+	 * will not corrupt what we are about to write.
+	 */
 	barrier();
+
+	/* Still keep it reserved even if an interrupt came in */
+	current->ret_stack[index] = val;
+
 	ret_stack->ret = ret;
 	ret_stack->func = func;
 	ret_stack->calltime = calltime;
@@ -138,7 +317,7 @@ ftrace_push_return_trace(unsigned long ret, unsigned long func,
 #ifdef HAVE_FUNCTION_GRAPH_RET_ADDR_PTR
 	ret_stack->retp = retp;
 #endif
-	return 0;
+	return index;
 }
 
 /*
@@ -155,10 +334,14 @@ ftrace_push_return_trace(unsigned long ret, unsigned long func,
 # define MCOUNT_INSN_SIZE 0
 #endif
 
+/* If the caller does not use ftrace, call this function. */
 int function_graph_enter(unsigned long ret, unsigned long func,
 			 unsigned long frame_pointer, unsigned long *retp)
 {
 	struct ftrace_graph_ent trace;
+	unsigned long bitmap = 0;
+	int index;
+	int i;
 
 #ifndef CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS
 	/*
@@ -171,44 +354,59 @@ int function_graph_enter(unsigned long ret, unsigned long func,
 	    ftrace_find_rec_direct(ret - MCOUNT_INSN_SIZE))
 		return -EBUSY;
 #endif
+
 	trace.func = func;
 	trace.depth = ++current->curr_ret_depth;
 
-	if (ftrace_push_return_trace(ret, func, frame_pointer, retp))
+	index = ftrace_push_return_trace(ret, func, frame_pointer, retp, 0);
+	if (index < 0)
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
+	set_fgraph_index_bitmap(current, index, bitmap | BIT(0));
+
 	return 0;
  out_ret:
-	RET_STACK_DEC(current->curr_ret_stack);
+	current->curr_ret_stack -= FGRAPH_RET_INDEX + 1;
  out:
 	current->curr_ret_depth--;
 	return -EBUSY;
 }
 
 /* Retrieve a function return address to the trace stack on thread info.*/
-static void
+static struct ftrace_ret_stack *
 ftrace_pop_return_trace(struct ftrace_graph_ret *trace, unsigned long *ret,
-			unsigned long frame_pointer)
+			unsigned long frame_pointer, int *index)
 {
 	struct ftrace_ret_stack *ret_stack;
-	int index;
 
-	index = current->curr_ret_stack;
-	RET_STACK_DEC(index);
+	ret_stack = get_ret_stack(current, current->curr_ret_stack, index);
 
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
@@ -228,26 +426,29 @@ ftrace_pop_return_trace(struct ftrace_graph_ret *trace, unsigned long *ret,
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
 
+	*index += FGRAPH_RET_INDEX;
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
@@ -285,30 +486,47 @@ struct fgraph_ret_regs;
 static unsigned long __ftrace_return_to_handler(struct fgraph_ret_regs *ret_regs,
 						unsigned long frame_pointer)
 {
+	struct ftrace_ret_stack *ret_stack;
 	struct ftrace_graph_ret trace;
+	unsigned long bitmap;
 	unsigned long ret;
+	int index;
+	int i;
 
-	ftrace_pop_return_trace(&trace, &ret, frame_pointer);
+	ret_stack = ftrace_pop_return_trace(&trace, &ret, frame_pointer, &index);
+
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
+	bitmap = get_fgraph_index_bitmap(current, index);
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
+	current->curr_ret_stack -= FGRAPH_RET_INDEX + 1;
+	current->curr_ret_depth--;
 	return ret;
 }
 
@@ -343,15 +561,17 @@ unsigned long ftrace_return_to_handler(unsigned long frame_pointer)
 struct ftrace_ret_stack *
 ftrace_graph_get_ret_stack(struct task_struct *task, int idx)
 {
+	struct ftrace_ret_stack *ret_stack = NULL;
 	int index = task->curr_ret_stack;
 
-	BUILD_BUG_ON(FGRAPH_RET_SIZE % sizeof(long));
-
-	index -= FGRAPH_RET_INDEX * (idx + 1);
 	if (index < 0)
 		return NULL;
 
-	return RET_STACK(task, index);
+	do {
+		ret_stack = get_ret_stack(task, index, &index);
+	} while (ret_stack && --idx >= 0);
+
+	return ret_stack;
 }
 
 /**
@@ -374,17 +594,26 @@ unsigned long ftrace_graph_ret_addr(struct task_struct *task, int *idx,
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
 
@@ -394,21 +623,29 @@ unsigned long ftrace_graph_ret_addr(struct task_struct *task, int *idx,
 unsigned long ftrace_graph_ret_addr(struct task_struct *task, int *idx,
 				    unsigned long ret, unsigned long *retp)
 {
-	int task_idx;
+	struct ftrace_ret_stack *ret_stack;
+	int task_idx = task->curr_ret_stack;
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
+		ret_stack = get_ret_stack(task, task_idx, &task_idx);
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
 
@@ -514,10 +751,10 @@ ftrace_graph_probe_sched_switch(void *ignore, bool preempt,
 	 */
 	timestamp -= next->ftrace_timestamp;
 
-	for (index = next->curr_ret_stack - FGRAPH_RET_INDEX; index >= 0; ) {
-		ret_stack = RET_STACK(next, index);
-		ret_stack->calltime += timestamp;
-		index -= FGRAPH_RET_INDEX;
+	for (index = next->curr_ret_stack; index > 0; ) {
+		ret_stack = get_ret_stack(next, index, &index);
+		if (ret_stack)
+			ret_stack->calltime += timestamp;
 	}
 }
 
@@ -568,6 +805,8 @@ graph_init_task(struct task_struct *t, unsigned long *ret_stack)
 {
 	atomic_set(&t->trace_overrun, 0);
 	t->ftrace_timestamp = 0;
+	t->curr_ret_stack = 0;
+	t->curr_ret_depth = -1;
 	/* make curr_ret_stack visible before we add the ret_stack */
 	smp_wmb();
 	t->ret_stack = ret_stack;
@@ -689,6 +928,7 @@ int register_ftrace_graph(struct fgraph_ops *gops)
 	fgraph_array[i] = gops;
 	if (i + 1 > fgraph_array_cnt)
 		fgraph_array_cnt = i + 1;
+	gops->idx = i;
 
 	ftrace_graph_active++;
 


