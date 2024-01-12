Return-Path: <bpf+bounces-19430-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5486B82BE49
	for <lists+bpf@lfdr.de>; Fri, 12 Jan 2024 11:15:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CB3C1C256A7
	for <lists+bpf@lfdr.de>; Fri, 12 Jan 2024 10:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 821FD5DF28;
	Fri, 12 Jan 2024 10:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EiNXJFiv"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CFB360EEF;
	Fri, 12 Jan 2024 10:13:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFB89C433C7;
	Fri, 12 Jan 2024 10:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705054411;
	bh=OrVnAsM2Ft1hr9fsr3iyDOaZmzHG5h5KzDx8/E7nXS0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EiNXJFivEfm0EMwHwRf2HXcQevK/J3/Pnii8clax+X8hx2ZtR+5LrGFBYM3Ymz8Wf
	 Ynx2ZbwXaIKEgUn5XD4n9otynw3Mtz4ejdEnVuBpjQDEklp3F1qwQobyJRndHL+0tO
	 gSUj5Crzr6D0YrMArDZslfx+wpJ6HbXVxEYk0fmQJWX/dakrgQlioqTBgnfupPQI30
	 ekOimvXxjg+PmgFcF/li+mWRKhq6q5AXhUi0P1RaCnhLuWFl7xOFIEz4JIyrRavqV0
	 /1m7VN0pjhCRrKKOgAt9Y8kyubYopvwBYkTiXUQSZFQp0Y64Wajm2bNc/pg/v4Sqvz
	 AnnUnReks26LQ==
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
Subject: [PATCH v6 13/36] function_graph: Have the instances use their own ftrace_ops for filtering
Date: Fri, 12 Jan 2024 19:13:25 +0900
Message-Id: <170505440540.459169.9150547754808415151.stgit@devnote2>
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

From: Steven Rostedt (VMware) <rostedt@goodmis.org>

Allow for instances to have their own ftrace_ops part of the fgraph_ops
that makes the funtion_graph tracer filter on the set_ftrace_filter file
of the instance and not the top instance.

This also change how the function_graph handles multiple instances on the
shadow stack. Previously we use ARRAY type entries to record which one
is enabled, and this makes it a bitmap of the fgraph_array's indexes.
Previous function_graph_enter() expects calling back from
prepare_ftrace_return() function which is called back only once if it is
enabled. But this introduces different ftrace_ops for each fgraph
instance and those are called from ftrace_graph_func() one by one. Thus
we can not loop on the fgraph_array(), and need to reuse the ret_stack
pushed by the previous instance. Finding the ret_stack is easy because
we can check the ret_stack->func. But that is not enough for the self-
recursive tail-call case. Thus fgraph uses the bitmap entry to find it
is already set (this means that entry is for previous tail call).

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 Changes in v6:
  - Fix to check whether the fgraph_ops is already unregistered in
    function_graph_enter_ops().
  - Fix stack unwinder error on arm64 because of passing wrong value
    as retp. Thanks Mark!
 Changes in v4:
  - Simplify get_ret_stack() sanity check and use WARN_ON_ONCE() for
    obviously wrong value.
  - Do not check ret == return_to_handler but always read the previous
    ret_stack in ftrace_push_return_trace() to check it is reusable.
  - Set the bit 0 of the bitmap entry always in function_graph_enter()
    because it uses bit 0 to check re-usability.
  - Fix to ensure the ret_stack entry is bitmap type when checking the
    bitmap.
 Changes in v3:
  - Pass current fgraph_ops to the new entry handler
   (function_graph_enter_ops) if fgraph use ftrace.
  - Add fgraph_ops::idx in this patch.
  - Replace the array type with the bitmap type so that it can record
    which fgraph is called.
  - Fix some helper function to use passed task_struct instead of current.
  - Reduce the ret-index size to 1024 words.
  - Make the ret-index directly points the ret_stack.
  - Fix ftrace_graph_ret_addr() to handle tail-call case correctly.
 Changes in v2:
  - Use ftrace_graph_func and FTRACE_OPS_GRAPH_STUB instead of
    ftrace_stub and FTRACE_OPS_FL_STUB for new ftrace based fgraph.
---
 arch/arm64/kernel/ftrace.c           |   21 ++
 arch/x86/kernel/ftrace.c             |   19 ++
 include/linux/ftrace.h               |    7 +
 kernel/trace/fgraph.c                |  372 ++++++++++++++++++++--------------
 kernel/trace/ftrace.c                |    6 -
 kernel/trace/trace.h                 |   16 +
 kernel/trace/trace_functions.c       |    2 
 kernel/trace/trace_functions_graph.c |    8 +
 8 files changed, 282 insertions(+), 169 deletions(-)

diff --git a/arch/arm64/kernel/ftrace.c b/arch/arm64/kernel/ftrace.c
index a650f5e11fc5..b96740829798 100644
--- a/arch/arm64/kernel/ftrace.c
+++ b/arch/arm64/kernel/ftrace.c
@@ -481,7 +481,26 @@ void prepare_ftrace_return(unsigned long self_addr, unsigned long *parent,
 void ftrace_graph_func(unsigned long ip, unsigned long parent_ip,
 		       struct ftrace_ops *op, struct ftrace_regs *fregs)
 {
-	prepare_ftrace_return(ip, &fregs->lr, fregs->fp);
+	struct fgraph_ops *gops = container_of(op, struct fgraph_ops, ops);
+	unsigned long frame_pointer = fregs->fp;
+	unsigned long *parent = &fregs->lr;
+	int bit;
+
+	if (unlikely(ftrace_graph_is_dead()))
+		return;
+
+	if (unlikely(atomic_read(&current->tracing_graph_pause)))
+		return;
+
+	bit = ftrace_test_recursion_trylock(ip, *parent);
+	if (bit < 0)
+		return;
+
+	if (!function_graph_enter_ops(*parent, ip, frame_pointer,
+				      (void *)frame_pointer, gops))
+		*parent = (unsigned long)&return_to_handler;
+
+	ftrace_test_recursion_unlock(bit);
 }
 #else
 /*
diff --git a/arch/x86/kernel/ftrace.c b/arch/x86/kernel/ftrace.c
index 12df54ff0e81..845e29b4254f 100644
--- a/arch/x86/kernel/ftrace.c
+++ b/arch/x86/kernel/ftrace.c
@@ -657,9 +657,24 @@ void ftrace_graph_func(unsigned long ip, unsigned long parent_ip,
 		       struct ftrace_ops *op, struct ftrace_regs *fregs)
 {
 	struct pt_regs *regs = &fregs->regs;
-	unsigned long *stack = (unsigned long *)kernel_stack_pointer(regs);
+	unsigned long *parent = (unsigned long *)kernel_stack_pointer(regs);
+	struct fgraph_ops *gops = container_of(op, struct fgraph_ops, ops);
+	int bit;
+
+	if (unlikely(ftrace_graph_is_dead()))
+		return;
+
+	if (unlikely(atomic_read(&current->tracing_graph_pause)))
+		return;
 
-	prepare_ftrace_return(ip, (unsigned long *)stack, 0);
+	bit = ftrace_test_recursion_trylock(ip, *parent);
+	if (bit < 0)
+		return;
+
+	if (!function_graph_enter_ops(*parent, ip, 0, parent, gops))
+		*parent = (unsigned long)&return_to_handler;
+
+	ftrace_test_recursion_unlock(bit);
 }
 #endif
 
diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index c385ded1875f..3d9e74ea6065 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -1070,7 +1070,9 @@ extern int ftrace_graph_entry_stub(struct ftrace_graph_ent *trace, struct fgraph
 struct fgraph_ops {
 	trace_func_graph_ent_t		entryfunc;
 	trace_func_graph_ret_t		retfunc;
+	struct ftrace_ops		ops; /* for the hash lists */
 	void				*private;
+	int				idx;
 };
 
 /*
@@ -1104,6 +1106,11 @@ extern int
 function_graph_enter(unsigned long ret, unsigned long func,
 		     unsigned long frame_pointer, unsigned long *retp);
 
+extern int
+function_graph_enter_ops(unsigned long ret, unsigned long func,
+			 unsigned long frame_pointer, unsigned long *retp,
+			 struct fgraph_ops *gops);
+
 struct ftrace_ret_stack *
 ftrace_graph_get_ret_stack(struct task_struct *task, int idx);
 
diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index 62c35d6d95f9..5724062846f7 100644
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
@@ -17,22 +18,15 @@
 #include "ftrace_internal.h"
 #include "trace.h"
 
-#ifdef CONFIG_DYNAMIC_FTRACE
-#define ASSIGN_OPS_HASH(opsname, val) \
-	.func_hash		= val, \
-	.local_hash.regex_lock	= __MUTEX_INITIALIZER(opsname.local_hash.regex_lock),
-#else
-#define ASSIGN_OPS_HASH(opsname, val)
-#endif
-
 #define FGRAPH_RET_SIZE sizeof(struct ftrace_ret_stack)
 #define FGRAPH_RET_INDEX (FGRAPH_RET_SIZE / sizeof(long))
 
 /*
  * On entry to a function (via function_graph_enter()), a new ftrace_ret_stack
- * is allocated on the task's ret_stack, then each fgraph_ops on the
- * fgraph_array[]'s entryfunc is called and if that returns non-zero, the
- * index into the fgraph_array[] for that fgraph_ops is added to the ret_stack.
+ * is allocated on the task's ret_stack with indexes entry, then each
+ * fgraph_ops on the fgraph_array[]'s entryfunc is called and if that returns
+ * non-zero, the index into the fgraph_array[] for that fgraph_ops is recorded
+ * on the indexes entry as a bit flag.
  * As the associated ftrace_ret_stack saved for those fgraph_ops needs to
  * be found, the index to it is also added to the ret_stack along with the
  * index of the fgraph_array[] to each fgraph_ops that needs their retfunc
@@ -42,61 +36,59 @@
  * to the last ftrace_ret_stack saved. All references to the
  * ftrace_ret_stack has the format of:
  *
- * bits:  0 - 13	Index in words from the previous ftrace_ret_stack
- * bits: 14 - 15	Type of storage
+ * bits:  0 -  9	offset in words from the previous ftrace_ret_stack
+ *			(bitmap type should have FGRAPH_RET_INDEX always)
+ * bits: 10 - 11	Type of storage
  *			  0 - reserved
- *			  1 - fgraph_array index
- * For fgraph_array_index:
- *  bits: 16 - 23	The fgraph_ops fgraph_array index
+ *			  1 - bitmap of fgraph_array index
+ *
+ * For bitmap of fgraph_array index
+ *  bits: 12 - 27	The bitmap of fgraph_ops fgraph_array index
  *
  * That is, at the end of function_graph_enter, if the first and forth
  * fgraph_ops on the fgraph_array[] (index 0 and 3) needs their retfunc called
  * on the return of the function being traced, this is what will be on the
  * task's shadow ret_stack: (the stack grows upward)
  *
- * |                                  | <- task->curr_ret_stack
- * +----------------------------------+
- * | (3 << FGRAPH_ARRAY_SHIFT)|(2)    | ( 3 for index of fourth fgraph_ops)
- * +----------------------------------+
- * | (0 << FGRAPH_ARRAY_SHIFT)|(1)    | ( 0 for index of first fgraph_ops)
- * +----------------------------------+
- * | struct ftrace_ret_stack          |
- * |   (stores the saved ret pointer) |
- * +----------------------------------+
- * |             (X) | (N)            | ( N words away from previous ret_stack)
- * |                                  |
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
  *
  * If a backtrace is required, and the real return pointer needs to be
  * fetched, then it looks at the task's curr_ret_stack index, if it
- * is greater than zero, it would subtact one, and then mask the value
- * on the ret_stack by FGRAPH_RET_INDEX_MASK and subtract FGRAPH_RET_INDEX
- * from that, to get the index of the ftrace_ret_stack structure stored
- * on the shadow stack.
+ * is greater than zero (reserved, or right before poped), it would mask
+ * the value by FGRAPH_RET_INDEX_MASK to get the offset index of the
+ * ftrace_ret_stack structure stored on the shadow stack.
  */
 
-#define FGRAPH_RET_INDEX_SIZE	14
-#define FGRAPH_RET_INDEX_MASK	((1 << FGRAPH_RET_INDEX_SIZE) - 1)
-
+#define FGRAPH_RET_INDEX_SIZE	10
+#define FGRAPH_RET_INDEX_MASK	GENMASK(FGRAPH_RET_INDEX_SIZE - 1, 0)
 
 #define FGRAPH_TYPE_SIZE	2
-#define FGRAPH_TYPE_MASK	((1 << FGRAPH_TYPE_SIZE) - 1)
+#define FGRAPH_TYPE_MASK	GENMASK(FGRAPH_TYPE_SIZE - 1, 0)
 #define FGRAPH_TYPE_SHIFT	FGRAPH_RET_INDEX_SIZE
 
 enum {
 	FGRAPH_TYPE_RESERVED	= 0,
-	FGRAPH_TYPE_ARRAY	= 1,
+	FGRAPH_TYPE_BITMAP	= 1,
 };
 
-#define FGRAPH_ARRAY_SIZE	16
-#define FGRAPH_ARRAY_MASK	((1 << FGRAPH_ARRAY_SIZE) - 1)
-#define FGRAPH_ARRAY_SHIFT	(FGRAPH_TYPE_SHIFT + FGRAPH_TYPE_SIZE)
+#define FGRAPH_INDEX_SIZE	16
+#define FGRAPH_INDEX_MASK	GENMASK(FGRAPH_INDEX_SIZE - 1, 0)
+#define FGRAPH_INDEX_SHIFT	(FGRAPH_TYPE_SHIFT + FGRAPH_TYPE_SIZE)
 
 /* Currently the max stack index can't be more than register callers */
-#define FGRAPH_MAX_INDEX	FGRAPH_ARRAY_SIZE
+#define FGRAPH_MAX_INDEX	(FGRAPH_INDEX_SIZE + FGRAPH_RET_INDEX)
+
+#define FGRAPH_ARRAY_SIZE	FGRAPH_INDEX_SIZE
 
-#define FGRAPH_FRAME_SIZE (FGRAPH_RET_SIZE + FGRAPH_ARRAY_SIZE * (sizeof(long)))
-#define FGRAPH_FRAME_INDEX (ALIGN(FGRAPH_FRAME_SIZE,		\
-				  sizeof(long)) / sizeof(long))
 #define SHADOW_STACK_SIZE (PAGE_SIZE)
 #define SHADOW_STACK_INDEX (SHADOW_STACK_SIZE / sizeof(long))
 /* Leave on a buffer at the end */
@@ -113,19 +105,36 @@ static struct fgraph_ops *fgraph_array[FGRAPH_ARRAY_SIZE];
 
 static inline int get_ret_stack_index(struct task_struct *t, int offset)
 {
-	return current->ret_stack[offset] & FGRAPH_RET_INDEX_MASK;
+	return t->ret_stack[offset] & FGRAPH_RET_INDEX_MASK;
 }
 
 static inline int get_fgraph_type(struct task_struct *t, int offset)
 {
-	return (current->ret_stack[offset] >> FGRAPH_TYPE_SHIFT) &
-		FGRAPH_TYPE_MASK;
+	return (t->ret_stack[offset] >> FGRAPH_TYPE_SHIFT) & FGRAPH_TYPE_MASK;
+}
+
+static inline unsigned long
+get_fgraph_index_bitmap(struct task_struct *t, int offset)
+{
+	return (t->ret_stack[offset] >> FGRAPH_INDEX_SHIFT) & FGRAPH_INDEX_MASK;
 }
 
-static inline int get_fgraph_array(struct task_struct *t, int offset)
+static inline void
+set_fgraph_index_bitmap(struct task_struct *t, int offset, unsigned long bitmap)
 {
-	return (current->ret_stack[offset] >> FGRAPH_ARRAY_SHIFT) &
-		FGRAPH_ARRAY_MASK;
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
 }
 
 /* ftrace_graph_entry set to this to tell some archs to run function graph */
@@ -160,17 +169,14 @@ get_ret_stack(struct task_struct *t, int offset, int *index)
 
 	BUILD_BUG_ON(FGRAPH_RET_SIZE % sizeof(long));
 
-	if (offset <= 0)
+	if (unlikely(offset <= 0))
 		return NULL;
 
-	idx = get_ret_stack_index(t, offset - 1);
-
-	if (idx <= 0 || idx > FGRAPH_MAX_INDEX)
+	idx = get_ret_stack_index(t, --offset);
+	if (WARN_ON_ONCE(idx <= 0 || idx > offset))
 		return NULL;
 
-	offset -= idx + FGRAPH_RET_INDEX;
-	if (offset < 0)
-		return NULL;
+	offset -= idx;
 
 	*index = offset;
 	return RET_STACK(t, offset);
@@ -231,10 +237,12 @@ void ftrace_graph_stop(void)
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
@@ -243,6 +251,21 @@ ftrace_push_return_trace(unsigned long ret, unsigned long func,
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
@@ -252,17 +275,19 @@ ftrace_push_return_trace(unsigned long ret, unsigned long func,
 	smp_rmb();
 
 	/* The return trace stack is full */
-	if (current->curr_ret_stack >= SHADOW_STACK_MAX_INDEX) {
+	if (current->curr_ret_stack + FGRAPH_RET_INDEX >= SHADOW_STACK_MAX_INDEX) {
 		atomic_inc(&current->trace_overrun);
 		return -EBUSY;
 	}
 
 	calltime = trace_clock_local();
 
-	index = current->curr_ret_stack;
-	/* ret offset = 1 ; type = reserved */
-	current->ret_stack[index + FGRAPH_RET_INDEX] = 1;
+	index = READ_ONCE(current->curr_ret_stack);
 	ret_stack = RET_STACK(current, index);
+	index += FGRAPH_RET_INDEX;
+
+	/* ret offset = FGRAPH_RET_INDEX ; type = reserved */
+	current->ret_stack[index] = val;
 	ret_stack->ret = ret;
 	/*
 	 * The unwinders expect curr_ret_stack to point to either zero
@@ -278,7 +303,7 @@ ftrace_push_return_trace(unsigned long ret, unsigned long func,
 	 * at least a correct index!
 	 */
 	barrier();
-	current->curr_ret_stack += FGRAPH_RET_INDEX + 1;
+	current->curr_ret_stack = index + 1;
 	/*
 	 * This next barrier is to ensure that an interrupt coming in
 	 * will not corrupt what we are about to write.
@@ -286,7 +311,7 @@ ftrace_push_return_trace(unsigned long ret, unsigned long func,
 	barrier();
 
 	/* Still keep it reserved even if an interrupt came in */
-	current->ret_stack[index + FGRAPH_RET_INDEX] = 1;
+	current->ret_stack[index] = val;
 
 	ret_stack->ret = ret;
 	ret_stack->func = func;
@@ -297,7 +322,7 @@ ftrace_push_return_trace(unsigned long ret, unsigned long func,
 #ifdef HAVE_FUNCTION_GRAPH_RET_ADDR_PTR
 	ret_stack->retp = retp;
 #endif
-	return 0;
+	return index;
 }
 
 /*
@@ -314,15 +339,13 @@ ftrace_push_return_trace(unsigned long ret, unsigned long func,
 # define MCOUNT_INSN_SIZE 0
 #endif
 
+/* If the caller does not use ftrace, call this function. */
 int function_graph_enter(unsigned long ret, unsigned long func,
 			 unsigned long frame_pointer, unsigned long *retp)
 {
 	struct ftrace_graph_ent trace;
-	int offset;
-	int start;
-	int type;
-	int val;
-	int cnt = 0;
+	unsigned long bitmap = 0;
+	int index;
 	int i;
 
 #ifndef CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS
@@ -337,69 +360,33 @@ int function_graph_enter(unsigned long ret, unsigned long func,
 		return -EBUSY;
 #endif
 
-	if (!ftrace_ops_test(&global_ops, func, NULL))
-		return -EBUSY;
-
 	trace.func = func;
 	trace.depth = ++current->curr_ret_depth;
 
-	if (ftrace_push_return_trace(ret, func, frame_pointer, retp))
+	index = ftrace_push_return_trace(ret, func, frame_pointer, retp, 0);
+	if (index < 0)
 		goto out;
 
-	/* Use start for the distance to ret_stack (skipping over reserve) */
-	start = offset = current->curr_ret_stack - 2;
-
 	for (i = 0; i < fgraph_array_cnt; i++) {
 		struct fgraph_ops *gops = fgraph_array[i];
 
 		if (gops == &fgraph_stub)
 			continue;
 
-		if ((offset == start) &&
-		    (current->curr_ret_stack >= SHADOW_STACK_INDEX - 1)) {
-			atomic_inc(&current->trace_overrun);
-			break;
-		}
-		if (fgraph_array[i]->entryfunc(&trace, fgraph_array[i])) {
-			offset = current->curr_ret_stack;
-			/* Check the top level stored word */
-			type = get_fgraph_type(current, offset - 1);
-
-			val = (i << FGRAPH_ARRAY_SHIFT) |
-				(FGRAPH_TYPE_ARRAY << FGRAPH_TYPE_SHIFT) |
-				((offset - start) - 1);
-
-			/* We can reuse the top word if it is reserved */
-			if (type == FGRAPH_TYPE_RESERVED) {
-				current->ret_stack[offset - 1] = val;
-				cnt++;
-				continue;
-			}
-			val++;
-
-			current->ret_stack[offset] = val;
-			/*
-			 * Write the value before we increment, so that
-			 * if an interrupt comes in after we increment
-			 * it will still see the value and skip over
-			 * this.
-			 */
-			barrier();
-			current->curr_ret_stack++;
-			/*
-			 * Have to write again, in case an interrupt
-			 * came in before the increment and after we
-			 * wrote the value.
-			 */
-			barrier();
-			current->ret_stack[offset] = val;
-			cnt++;
-		}
+		if (ftrace_ops_test(&gops->ops, func, NULL) &&
+		    gops->entryfunc(&trace, gops))
+			bitmap |= BIT(i);
 	}
 
-	if (!cnt)
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
 	current->curr_ret_stack -= FGRAPH_RET_INDEX + 1;
@@ -408,15 +395,54 @@ int function_graph_enter(unsigned long ret, unsigned long func,
 	return -EBUSY;
 }
 
+/* This is called from ftrace_graph_func() via ftrace */
+int function_graph_enter_ops(unsigned long ret, unsigned long func,
+			     unsigned long frame_pointer, unsigned long *retp,
+			     struct fgraph_ops *gops)
+{
+	struct ftrace_graph_ent trace;
+	int index;
+	int type;
+
+	/* Check whether the fgraph_ops is unregistered. */
+	if (unlikely(fgraph_array[gops->idx] == &fgraph_stub))
+		return -ENODEV;
+
+	/* Use start for the distance to ret_stack (skipping over reserve) */
+	index = ftrace_push_return_trace(ret, func, frame_pointer, retp, gops->idx);
+	if (index < 0)
+		return index;
+	type = get_fgraph_type(current, index);
+
+	/* This is the first ret_stack for this fentry */
+	if (type == FGRAPH_TYPE_RESERVED)
+		++current->curr_ret_depth;
+
+	trace.func = func;
+	trace.depth = current->curr_ret_depth;
+	if (gops->entryfunc(&trace, gops)) {
+		if (type == FGRAPH_TYPE_RESERVED)
+			set_fgraph_index_bitmap(current, index, BIT(gops->idx));
+		else
+			add_fgraph_index_bitmap(current, index, BIT(gops->idx));
+		return 0;
+	}
+
+	if (type == FGRAPH_TYPE_RESERVED) {
+		current->curr_ret_stack -= FGRAPH_RET_INDEX + 1;
+		current->curr_ret_depth--;
+	}
+	return -EBUSY;
+}
+
 /* Retrieve a function return address to the trace stack on thread info.*/
 static struct ftrace_ret_stack *
 ftrace_pop_return_trace(struct ftrace_graph_ret *trace, unsigned long *ret,
-			unsigned long frame_pointer)
+			unsigned long frame_pointer, int *index)
 {
 	struct ftrace_ret_stack *ret_stack;
-	int index;
 
-	ret_stack = get_ret_stack(current, current->curr_ret_stack, &index);
+	ret_stack = get_ret_stack(current, current->curr_ret_stack, index);
 
 	if (unlikely(!ret_stack)) {
 		ftrace_graph_stop();
@@ -455,6 +481,7 @@ ftrace_pop_return_trace(struct ftrace_graph_ret *trace, unsigned long *ret,
 	}
 #endif
 
+	*index += FGRAPH_RET_INDEX;
 	*ret = ret_stack->ret;
 	trace->func = ret_stack->func;
 	trace->calltime = ret_stack->calltime;
@@ -507,13 +534,12 @@ static unsigned long __ftrace_return_to_handler(struct fgraph_ret_regs *ret_regs
 {
 	struct ftrace_ret_stack *ret_stack;
 	struct ftrace_graph_ret trace;
+	unsigned long bitmap;
 	unsigned long ret;
-	int offset;
 	int index;
-	int idx;
 	int i;
 
-	ret_stack = ftrace_pop_return_trace(&trace, &ret, frame_pointer);
+	ret_stack = ftrace_pop_return_trace(&trace, &ret, frame_pointer, &index);
 
 	if (unlikely(!ret_stack)) {
 		ftrace_graph_stop();
@@ -527,16 +553,17 @@ static unsigned long __ftrace_return_to_handler(struct fgraph_ret_regs *ret_regs
 	trace.retval = fgraph_ret_regs_return_value(ret_regs);
 #endif
 
-	offset = current->curr_ret_stack - 1;
-	index = get_ret_stack_index(current, offset);
+	bitmap = get_fgraph_index_bitmap(current, index);
+	for (i = 0; i < FGRAPH_ARRAY_SIZE; i++) {
+		struct fgraph_ops *gops = fgraph_array[i];
 
-	/* index has to be at least one! Optimize for it */
-	i = 0;
-	do {
-		idx = get_fgraph_array(current, offset - i);
-		fgraph_array[idx]->retfunc(&trace, fgraph_array[idx]);
-		i++;
-	} while (i < index);
+		if (!(bitmap & BIT(i)))
+			continue;
+		if (gops == &fgraph_stub)
+			continue;
+
+		gops->retfunc(&trace, gops);
+	}
 
 	/*
 	 * The ftrace_graph_return() may still access the current
@@ -544,7 +571,7 @@ static unsigned long __ftrace_return_to_handler(struct fgraph_ret_regs *ret_regs
 	 * curr_ret_stack is after that.
 	 */
 	barrier();
-	current->curr_ret_stack -= index + FGRAPH_RET_INDEX;
+	current->curr_ret_stack -= FGRAPH_RET_INDEX + 1;
 	current->curr_ret_depth--;
 	return ret;
 }
@@ -622,7 +649,17 @@ unsigned long ftrace_graph_ret_addr(struct task_struct *task, int *idx,
 		ret_stack = get_ret_stack(current, i, &i);
 		if (!ret_stack)
 			break;
-		if (ret_stack->retp == retp)
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
 
@@ -645,6 +682,9 @@ unsigned long ftrace_graph_ret_addr(struct task_struct *task, int *idx,
 	i = *idx;
 	do {
 		ret_stack = get_ret_stack(task, task_idx, &task_idx);
+		if (ret_stack && ret_stack->ret ==
+		    (unsigned long)dereference_kernel_function_descriptor(return_to_handler))
+			continue;
 		i--;
 	} while (i >= 0 && ret_stack);
 
@@ -655,17 +695,25 @@ unsigned long ftrace_graph_ret_addr(struct task_struct *task, int *idx,
 }
 #endif /* HAVE_FUNCTION_GRAPH_RET_ADDR_PTR */
 
-static struct ftrace_ops graph_ops = {
-	.func			= ftrace_graph_func,
-	.flags			= FTRACE_OPS_FL_INITIALIZED |
-				   FTRACE_OPS_FL_PID |
-				   FTRACE_OPS_GRAPH_STUB,
+void fgraph_init_ops(struct ftrace_ops *dst_ops,
+		     struct ftrace_ops *src_ops)
+{
+	dst_ops->func = ftrace_graph_func;
+	dst_ops->flags = FTRACE_OPS_FL_PID | FTRACE_OPS_GRAPH_STUB;
+
 #ifdef FTRACE_GRAPH_TRAMP_ADDR
-	.trampoline		= FTRACE_GRAPH_TRAMP_ADDR,
+	dst_ops->trampoline = FTRACE_GRAPH_TRAMP_ADDR;
 	/* trampoline_size is only needed for dynamically allocated tramps */
 #endif
-	ASSIGN_OPS_HASH(graph_ops, &global_ops.local_hash)
-};
+
+#ifdef CONFIG_DYNAMIC_FTRACE
+	if (src_ops) {
+		dst_ops->func_hash = &src_ops->local_hash;
+		mutex_init(&dst_ops->local_hash.regex_lock);
+		dst_ops->flags |= FTRACE_OPS_FL_INITIALIZED;
+	}
+#endif
+}
 
 void ftrace_graph_sleep_time_control(bool enable)
 {
@@ -869,11 +917,20 @@ static int start_graph_tracing(void)
 
 int register_ftrace_graph(struct fgraph_ops *gops)
 {
+	int command = 0;
 	int ret = 0;
 	int i;
 
 	mutex_lock(&ftrace_lock);
 
+	if (!gops->ops.func) {
+		gops->ops.flags |= FTRACE_OPS_GRAPH_STUB;
+		gops->ops.func = ftrace_graph_func;
+#ifdef FTRACE_GRAPH_TRAMP_ADDR
+		gops->ops.trampoline = FTRACE_GRAPH_TRAMP_ADDR;
+#endif
+	}
+
 	if (!fgraph_array[0]) {
 		/* The array must always have real data on it */
 		for (i = 0; i < FGRAPH_ARRAY_SIZE; i++)
@@ -893,6 +950,7 @@ int register_ftrace_graph(struct fgraph_ops *gops)
 	fgraph_array[i] = gops;
 	if (i + 1 > fgraph_array_cnt)
 		fgraph_array_cnt = i + 1;
+	gops->idx = i;
 
 	ftrace_graph_active++;
 
@@ -909,9 +967,10 @@ int register_ftrace_graph(struct fgraph_ops *gops)
 		 */
 		ftrace_graph_return = return_run;
 		ftrace_graph_entry = entry_run;
-
-		ret = ftrace_startup(&graph_ops, FTRACE_START_FUNC_RET);
+		command = FTRACE_START_FUNC_RET;
 	}
+
+	ret = ftrace_startup(&gops->ops, command);
 out:
 	mutex_unlock(&ftrace_lock);
 	return ret;
@@ -919,6 +978,7 @@ int register_ftrace_graph(struct fgraph_ops *gops)
 
 void unregister_ftrace_graph(struct fgraph_ops *gops)
 {
+	int command = 0;
 	int i;
 
 	mutex_lock(&ftrace_lock);
@@ -926,25 +986,29 @@ void unregister_ftrace_graph(struct fgraph_ops *gops)
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
+	ftrace_shutdown(&gops->ops, command);
+
 	if (!ftrace_graph_active) {
 		ftrace_graph_return = ftrace_stub_graph;
 		ftrace_graph_entry = ftrace_graph_entry_stub;
-		ftrace_shutdown(&graph_ops, FTRACE_STOP_FUNC_RET);
 		unregister_pm_notifier(&ftrace_suspend_notifier);
 		unregister_trace_sched_switch(ftrace_graph_probe_sched_switch, NULL);
 	}
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index a720dd7cf290..bff6c04d5201 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -3016,6 +3016,8 @@ int ftrace_startup(struct ftrace_ops *ops, int command)
 	if (unlikely(ftrace_disabled))
 		return -ENODEV;
 
+	ftrace_ops_init(ops);
+
 	ret = __register_ftrace_function(ops);
 	if (ret)
 		return ret;
@@ -7323,7 +7325,7 @@ __init void ftrace_init_global_array_ops(struct trace_array *tr)
 	tr->ops = &global_ops;
 	tr->ops->private = tr;
 	ftrace_init_trace_array(tr);
-	init_array_fgraph_ops(tr);
+	init_array_fgraph_ops(tr, tr->ops);
 }
 
 void ftrace_init_array_ops(struct trace_array *tr, ftrace_func_t func)
@@ -8055,7 +8057,7 @@ static int register_ftrace_function_nolock(struct ftrace_ops *ops)
  */
 int register_ftrace_function(struct ftrace_ops *ops)
 {
-	int ret;
+	int ret = -1;
 
 	lock_direct_mutex();
 	ret = prepare_direct_functions_for_ipmodify(ops);
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index b11e4cf4f72e..3176f8dcaf94 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -891,8 +891,8 @@ extern int __trace_graph_entry(struct trace_array *tr,
 extern void __trace_graph_return(struct trace_array *tr,
 				 struct ftrace_graph_ret *trace,
 				 unsigned int trace_ctx);
-extern void init_array_fgraph_ops(struct trace_array *tr);
-extern int allocate_fgraph_ops(struct trace_array *tr);
+extern void init_array_fgraph_ops(struct trace_array *tr, struct ftrace_ops *ops);
+extern int allocate_fgraph_ops(struct trace_array *tr, struct ftrace_ops *ops);
 extern void free_fgraph_ops(struct trace_array *tr);
 
 #ifdef CONFIG_DYNAMIC_FTRACE
@@ -975,6 +975,7 @@ static inline int ftrace_graph_notrace_addr(unsigned long addr)
 	preempt_enable_notrace();
 	return ret;
 }
+
 #else
 static inline int ftrace_graph_addr(struct ftrace_graph_ent *trace)
 {
@@ -1000,18 +1001,19 @@ static inline bool ftrace_graph_ignore_func(struct ftrace_graph_ent *trace)
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


