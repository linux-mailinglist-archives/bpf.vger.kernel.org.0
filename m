Return-Path: <bpf+bounces-31114-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6758E8D7349
	for <lists+bpf@lfdr.de>; Sun,  2 Jun 2024 05:37:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EBD8281D2A
	for <lists+bpf@lfdr.de>; Sun,  2 Jun 2024 03:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C4CB1BDD0;
	Sun,  2 Jun 2024 03:37:25 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0726BA4B;
	Sun,  2 Jun 2024 03:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717299445; cv=none; b=VrdGk9/lU053UDI4HSUfZLRJfYI1M4bNSbchCAwmta6Muu8mHHJBriaZZacy6ZavmOS2EQlOpYdfEb7eu2WwVRmFGMJA/lJrzqV9SMZLb3JN4PrwBLq8GXKm0+vA25+UAQiVX9JVFwI+Eujou1zo9D17a7RscjQp2xrW9mVumLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717299445; c=relaxed/simple;
	bh=B2A6aU4rmwmC+Ero07LYCaN7pINgABXeQTRYBKFEMRg=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=GEVjaT1OwOvlKAEkbtELHRkwGx54D1qIjQ1TRMVQl1BjScldcfy+biLcM4VTAJUL9GYyaOHFrInvi7se1rwVRSc8rJHMW0APeglAIXwRTkrmA1a9YqIoMGgSsoSynwcowY0Oc4t/Qgc3eg/+vfuk+rPiQ2jmoM4qAtFyuSJDiyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABE1BC4AF09;
	Sun,  2 Jun 2024 03:37:24 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1sDc3D-000000094Ky-3fAl;
	Sat, 01 Jun 2024 23:38:31 -0400
Message-ID: <20240602033831.735336611@goodmis.org>
User-Agent: quilt/0.68
Date: Sat, 01 Jun 2024 23:37:48 -0400
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
Subject: [PATCH v2 04/27] function_graph: Allow multiple users to attach to function graph
References: <20240602033744.563858532@goodmis.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

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

Co-developed with Masami Hiramatsu:
Link: https://lore.kernel.org/linux-trace-kernel/171509096221.162236.8806372072523195752.stgit@devnote2

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/linux/ftrace.h |   3 +-
 kernel/trace/fgraph.c  | 379 ++++++++++++++++++++++++++++++++---------
 2 files changed, 304 insertions(+), 78 deletions(-)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 800995c425e0..8f00a7415bd5 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -1038,6 +1038,7 @@ extern int ftrace_graph_entry_stub(struct ftrace_graph_ent *trace);
 struct fgraph_ops {
 	trace_func_graph_ent_t		entryfunc;
 	trace_func_graph_ret_t		retfunc;
+	int				idx;
 };
 
 /*
@@ -1072,7 +1073,7 @@ function_graph_enter(unsigned long ret, unsigned long func,
 		     unsigned long frame_pointer, unsigned long *retp);
 
 struct ftrace_ret_stack *
-ftrace_graph_get_ret_stack(struct task_struct *task, int idx);
+ftrace_graph_get_ret_stack(struct task_struct *task, int skip);
 
 unsigned long ftrace_graph_ret_addr(struct task_struct *task, int *idx,
 				    unsigned long ret, unsigned long *retp);
diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index d2ce5d651cf0..aae51f746828 100644
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
@@ -28,35 +29,177 @@
 /*
  * FGRAPH_FRAME_SIZE:	Size in bytes of the meta data on the shadow stack
  * FGRAPH_FRAME_OFFSET:	Size in long words of the meta data frame
- * SHADOW_STACK_SIZE:	The size in bytes of the entire shadow stack
- * SHADOW_STACK_OFFSET:	The size in long words of the shadow stack
- * SHADOW_STACK_MAX_OFFSET: The max offset of the stack for a new frame to be added
  */
 #define FGRAPH_FRAME_SIZE	sizeof(struct ftrace_ret_stack)
 #define FGRAPH_FRAME_OFFSET	DIV_ROUND_UP(FGRAPH_FRAME_SIZE, sizeof(long))
-#define SHADOW_STACK_SIZE (PAGE_SIZE)
-#define SHADOW_STACK_OFFSET			\
-	(ALIGN(SHADOW_STACK_SIZE, sizeof(long)) / sizeof(long))
-/* Leave on a buffer at the end */
-#define SHADOW_STACK_MAX_INDEX (SHADOW_STACK_OFFSET - FGRAPH_FRAME_OFFSET)
 
 /*
- * RET_STACK():		Return the frame from a given @offset from task @t
- * RET_STACK_INC():	Reserve one frame size on the stack.
- * RET_STACK_DEC():	Remove one frame size from the stack.
+ * On entry to a function (via function_graph_enter()), a new fgraph frame
+ * (ftrace_ret_stack) is pushed onto the stack as well as a word that
+ * holds a bitmask and a type (called "bitmap"). The bitmap is defined as:
+ *
+ * bits:  0 -  9	offset in words from the previous ftrace_ret_stack
+ *			Currently, this will always be set to FGRAPH_FRAME_OFFSET
+ *			to get to the fgraph frame.
+ *
+ * bits: 10 - 11	Type of storage
+ *			  0 - reserved
+ *			  1 - bitmap of fgraph_array index
+ *
+ * For type with "bitmap of fgraph_array index" (FGRAPH_TYPE_BITMAP):
+ *  bits: 12 - 27	The bitmap of fgraph_ops fgraph_array index
+ *			That is, it's a bitmask of 0-15 (16 bits)
+ *			where if a corresponding ops in the fgraph_array[]
+ *			expects a callback from the return of the function
+ *			it's corresponding bit will be set.
+ *
+ *
+ * The top of the ret_stack (when not empty) will always have a reference
+ * word that points to the last fgraph frame that was saved.
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
+ * | (9 << 12) | (1 << 10) | FGRAPH_FRAME_OFFSET|
+ * |         *or put another way*               |
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
+ * is greater than zero (reserved, or right before popped), it would mask
+ * the value by FGRAPH_FRAME_OFFSET_MASK to get the offset of the
+ * ftrace_ret_stack structure stored on the shadow stack.
+ */
+
+/*
+ * The following is for the top word on the stack:
+ *
+ *   FGRAPH_FRAME_OFFSET (0-9) holds the offset delta to the fgraph frame
+ *   FGRAPH_TYPE (10-11) holds the type of word this is.
+ *     (RESERVED or BITMAP)
+ */
+#define FGRAPH_FRAME_OFFSET_BITS	10
+#define FGRAPH_FRAME_OFFSET_MASK	GENMASK(FGRAPH_FRAME_OFFSET_BITS - 1, 0)
+
+#define FGRAPH_TYPE_BITS	2
+#define FGRAPH_TYPE_MASK	GENMASK(FGRAPH_TYPE_BITS - 1, 0)
+#define FGRAPH_TYPE_SHIFT	FGRAPH_FRAME_OFFSET_BITS
+
+enum {
+	FGRAPH_TYPE_RESERVED	= 0,
+	FGRAPH_TYPE_BITMAP	= 1,
+};
+
+/*
+ * For BITMAP type:
+ *   FGRAPH_INDEX (12-27) bits holding the gops index wanting return callback called
+ */
+#define FGRAPH_INDEX_BITS	16
+#define FGRAPH_INDEX_MASK	GENMASK(FGRAPH_INDEX_BITS - 1, 0)
+#define FGRAPH_INDEX_SHIFT	(FGRAPH_TYPE_SHIFT + FGRAPH_TYPE_BITS)
+
+#define FGRAPH_ARRAY_SIZE	FGRAPH_INDEX_BITS
+
+/*
+ * SHADOW_STACK_SIZE:	The size in bytes of the entire shadow stack
+ * SHADOW_STACK_OFFSET:	The size in long words of the shadow stack
+ * SHADOW_STACK_MAX_OFFSET: The max offset of the stack for a new frame to be added
  */
-#define RET_STACK(t, index) ((struct ftrace_ret_stack *)(&(t)->ret_stack[index]))
-#define RET_STACK_INC(c) ({ c += FGRAPH_FRAME_OFFSET; })
-#define RET_STACK_DEC(c) ({ c -= FGRAPH_FRAME_OFFSET; })
+#define SHADOW_STACK_SIZE	(PAGE_SIZE)
+#define SHADOW_STACK_OFFSET	(SHADOW_STACK_SIZE / sizeof(long))
+/* Leave on a buffer at the end */
+#define SHADOW_STACK_MAX_OFFSET (SHADOW_STACK_OFFSET - (FGRAPH_FRAME_OFFSET + 1))
+
+/* RET_STACK():		Return the frame from a given @offset from task @t */
+#define RET_STACK(t, offset) ((struct ftrace_ret_stack *)(&(t)->ret_stack[offset]))
 
 DEFINE_STATIC_KEY_FALSE(kill_ftrace_graph);
 int ftrace_graph_active;
 
 static int fgraph_array_cnt;
-#define FGRAPH_ARRAY_SIZE	16
 
 static struct fgraph_ops *fgraph_array[FGRAPH_ARRAY_SIZE];
 
+/* Get the FRAME_OFFSET from the word from the @offset on ret_stack */
+static inline int get_frame_offset(struct task_struct *t, int offset)
+{
+	return t->ret_stack[offset] & FGRAPH_FRAME_OFFSET_MASK;
+}
+
+/* Get FGRAPH_TYPE from the word from the @offset at ret_stack */
+static inline int get_fgraph_type(struct task_struct *t, int offset)
+{
+	return (t->ret_stack[offset] >> FGRAPH_TYPE_SHIFT) & FGRAPH_TYPE_MASK;
+}
+
+/* For BITMAP type: get the bitmask from the @offset at ret_stack */
+static inline unsigned long
+get_bitmap_bits(struct task_struct *t, int offset)
+{
+	return (t->ret_stack[offset] >> FGRAPH_INDEX_SHIFT) & FGRAPH_INDEX_MASK;
+}
+
+/* Write the bitmap to the ret_stack at @offset (does index, offset and bitmask) */
+static inline void
+set_bitmap(struct task_struct *t, int offset, unsigned long bitmap)
+{
+	t->ret_stack[offset] = (bitmap << FGRAPH_INDEX_SHIFT) |
+		(FGRAPH_TYPE_BITMAP << FGRAPH_TYPE_SHIFT) | FGRAPH_FRAME_OFFSET;
+}
+
+/*
+ * @offset: The offset into @t->ret_stack to find the ret_stack entry
+ * @frame_offset: Where to place the offset into @t->ret_stack of that entry
+ *
+ * Returns a pointer to the previous ret_stack below @offset or NULL
+ *   when it reaches the bottom of the stack.
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
 
@@ -110,11 +253,13 @@ void ftrace_graph_stop(void)
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
@@ -124,24 +269,57 @@ ftrace_push_return_trace(unsigned long ret, unsigned long func,
 
 	BUILD_BUG_ON(SHADOW_STACK_SIZE % sizeof(long));
 
+	/* Set val to "reserved" with the delta to the new fgraph frame */
+	val = (FGRAPH_TYPE_RESERVED << FGRAPH_TYPE_SHIFT) | FGRAPH_FRAME_OFFSET;
+
 	/*
 	 * We must make sure the ret_stack is tested before we read
 	 * anything else.
 	 */
 	smp_rmb();
 
-	/* The return trace stack is full */
-	if (current->curr_ret_stack >= SHADOW_STACK_MAX_INDEX) {
+	/*
+	 * Check if there's room on the shadow stack to fit a fraph frame
+	 * and a bitmap word.
+	 */
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
 	barrier();
+	WRITE_ONCE(current->curr_ret_stack, offset + 1);
+	/*
+	 * This next barrier is to ensure that an interrupt coming in
+	 * will not corrupt what we are about to write.
+	 */
+	barrier();
+
+	/* Still keep it reserved even if an interrupt came in */
+	current->ret_stack[offset] = val;
+
 	ret_stack->ret = ret;
 	ret_stack->func = func;
 	ret_stack->calltime = calltime;
@@ -151,7 +329,7 @@ ftrace_push_return_trace(unsigned long ret, unsigned long func,
 #ifdef HAVE_FUNCTION_GRAPH_RET_ADDR_PTR
 	ret_stack->retp = retp;
 #endif
-	return 0;
+	return offset;
 }
 
 /*
@@ -168,49 +346,67 @@ ftrace_push_return_trace(unsigned long ret, unsigned long func,
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
+	set_bitmap(current, offset, bitmap | BIT(0));
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
@@ -230,26 +426,29 @@ ftrace_pop_return_trace(struct ftrace_graph_ret *trace, unsigned long *ret,
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
@@ -287,30 +486,47 @@ struct fgraph_ret_regs;
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
+
+	if (unlikely(!ret_stack)) {
+		ftrace_graph_stop();
+		WARN_ON(1);
+		/* Might as well panic. What else to do? */
+		return (unsigned long)panic;
+	}
 
-	ftrace_pop_return_trace(&trace, &ret, frame_pointer);
+	trace.rettime = trace_clock_local();
 #ifdef CONFIG_FUNCTION_GRAPH_RETVAL
 	trace.retval = fgraph_ret_regs_return_value(ret_regs);
 #endif
-	trace.rettime = trace_clock_local();
-	fgraph_array[0]->retfunc(&trace);
+
+	bitmap = get_bitmap_bits(current, offset);
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
 
@@ -333,7 +549,7 @@ unsigned long ftrace_return_to_handler(unsigned long frame_pointer)
 
 /**
  * ftrace_graph_get_ret_stack - return the entry of the shadow stack
- * @task: The task to read the shadow stack from
+ * @task: The task to read the shadow stack from.
  * @idx: Index down the shadow stack
  *
  * Return the ret_struct on the shadow stack of the @task at the
@@ -345,15 +561,17 @@ unsigned long ftrace_return_to_handler(unsigned long frame_pointer)
 struct ftrace_ret_stack *
 ftrace_graph_get_ret_stack(struct task_struct *task, int idx)
 {
-	int index = task->curr_ret_stack;
+	struct ftrace_ret_stack *ret_stack = NULL;
+	int offset = task->curr_ret_stack;
 
-	BUILD_BUG_ON(FGRAPH_FRAME_SIZE % sizeof(long));
-
-	index -= FGRAPH_FRAME_OFFSET * (idx + 1);
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
@@ -376,16 +594,15 @@ unsigned long ftrace_graph_ret_addr(struct task_struct *task, int *idx,
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
+	while (i > 0) {
+		ret_stack = get_ret_stack(current, i, &i);
+		if (!ret_stack)
+			break;
 		if (ret_stack->retp == retp)
 			return ret_stack->ret;
 	}
@@ -396,21 +613,26 @@ unsigned long ftrace_graph_ret_addr(struct task_struct *task, int *idx,
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
+		i--;
+	} while (i >= 0 && ret_stack);
+
+	if (ret_stack)
+		return ret_stack->ret;
 
-	return RET_STACK(task, task_idx);
+	return ret;
 }
 #endif /* HAVE_FUNCTION_GRAPH_RET_ADDR_PTR */
 
@@ -493,7 +715,7 @@ ftrace_graph_probe_sched_switch(void *ignore, bool preempt,
 {
 	struct ftrace_ret_stack *ret_stack;
 	unsigned long long timestamp;
-	int index;
+	int offset;
 
 	/*
 	 * Does the user want to count the time a function was asleep.
@@ -516,10 +738,10 @@ ftrace_graph_probe_sched_switch(void *ignore, bool preempt,
 	 */
 	timestamp -= next->ftrace_timestamp;
 
-	for (index = next->curr_ret_stack - FGRAPH_FRAME_OFFSET; index >= 0; ) {
-		ret_stack = RET_STACK(next, index);
-		ret_stack->calltime += timestamp;
-		index -= FGRAPH_FRAME_OFFSET;
+	for (offset = next->curr_ret_stack; offset > 0; ) {
+		ret_stack = get_ret_stack(next, offset, &offset);
+		if (ret_stack)
+			ret_stack->calltime += timestamp;
 	}
 }
 
@@ -570,6 +792,8 @@ graph_init_task(struct task_struct *t, unsigned long *ret_stack)
 {
 	atomic_set(&t->trace_overrun, 0);
 	t->ftrace_timestamp = 0;
+	t->curr_ret_stack = 0;
+	t->curr_ret_depth = -1;
 	/* make curr_ret_stack visible before we add the ret_stack */
 	smp_wmb();
 	t->ret_stack = ret_stack;
@@ -691,6 +915,7 @@ int register_ftrace_graph(struct fgraph_ops *gops)
 	fgraph_array[i] = gops;
 	if (i + 1 > fgraph_array_cnt)
 		fgraph_array_cnt = i + 1;
+	gops->idx = i;
 
 	ftrace_graph_active++;
 
-- 
2.43.0



