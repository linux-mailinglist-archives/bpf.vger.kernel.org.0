Return-Path: <bpf+bounces-14499-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C7757E58CC
	for <lists+bpf@lfdr.de>; Wed,  8 Nov 2023 15:27:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D620C2815BA
	for <lists+bpf@lfdr.de>; Wed,  8 Nov 2023 14:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B788199DA;
	Wed,  8 Nov 2023 14:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZbP5Fdsv"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29A91A594;
	Wed,  8 Nov 2023 14:27:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 695B6C433C8;
	Wed,  8 Nov 2023 14:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699453663;
	bh=I8UydbwX5CwVQj9WY1DEcYvDCyrAse7mJMsY4uzWdyg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZbP5Fdsv1d16LPM45rr11gylGYgQcX88GBLE8lzTOcizOUnEIMZIzGXZqh1e5+Eul
	 4jn75DnXOkKOHUfNlC4VHbdA9onvAyL87RkSqMqh5JUEUCSBPov7yA8Y6kncS5TfKa
	 xanY8SIEa97WTqDG+CGmhohQVwXG7GKgXwRqCjXeB3hjsjycIxcATuUrxtNi856vJE
	 8T/kQAXWI38drS+GjrSx1QtwPfnd5GVFUSa+46Rsi/tHoImkKiayUlhOPMm++TNzSN
	 1rySsuu+rG7QBt4Mb3NlSvVMZE4mBA9iHogvLH5wX9WceVGkg7CeeRXkjzmu3QAAHV
	 UNjGm5WTuhxNA==
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
Subject: [RFC PATCH v2 17/31] function_graph: Implement fgraph_reserve_data() and fgraph_retrieve_data()
Date: Wed,  8 Nov 2023 23:27:38 +0900
Message-Id: <169945365765.55307.4129860949245209954.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <169945345785.55307.5003201137843449313.stgit@devnote2>
References: <169945345785.55307.5003201137843449313.stgit@devnote2>
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

Added functions that can be called by a fgraph_ops entryfunc and retfunc to
store state between the entry of the function being traced to the exit of
the same function. The fgraph_ops entryfunc() may call
fgraph_reserve_data() to store up to 32 words onto the task's shadow
ret_stack and this then can be retrieved by fgraph_retrieve_data() called
by the corresponding retfunc().

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 Changes in v2:
  - Retrieve the reserved size by fgraph_retrieve_data().
  - Expand the maximum data size to 32 words.
  - Update stack index with __get_index(val) if FGRAPH_TYPE_ARRAY entry.
  - fix typos and make description lines shorter than 76 chars.
---
 include/linux/ftrace.h |    3 +
 kernel/trace/fgraph.c  |  248 +++++++++++++++++++++++++++++++++++++++++-------
 2 files changed, 217 insertions(+), 34 deletions(-)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 3f9f1f48e8fd..3bc01329548b 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -1074,6 +1074,9 @@ struct fgraph_ops {
 	int				idx;
 };
 
+void *fgraph_reserve_data(int size_bytes);
+void *fgraph_retrieve_data(int *size_bytes);
+
 /*
  * Stack of return addresses for functions
  * of a thread.
diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index 79bdd3c775dd..4d8664942335 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -38,25 +38,36 @@
  * bits: 14 - 15	Type of storage
  *			  0 - reserved
  *			  1 - fgraph_array index
+ *			  2 - reservered data
  * For fgraph_array_index:
  *  bits: 16 - 23	The fgraph_ops fgraph_array index
  *
+ * For reserved data:
+ *  bits: 16 - 17	The size in words that is stored
+ *
  * That is, at the end of function_graph_enter, if the first and forth
  * fgraph_ops on the fgraph_array[] (index 0 and 3) needs their retfunc called
- * on the return of the function being traced, this is what will be on the
- * task's shadow ret_stack: (the stack grows upward)
+ * on the return of the function being traced, and the forth fgraph_ops
+ * stored two words of data, this is what will be on the task's shadow
+ * ret_stack: (the stack grows upward)
+ *
+ * |                                     | <- task->curr_ret_stack
+ * +-------------------------------------+
+ * | (3 << FGRAPH_ARRAY_SHIFT)|type:1|(5)| ( 3 for index of fourth fgraph_ops)
+ * +-------------------------------------+
+ * | (3 << FGRAPH_DATA_SHIFT)|type:2|(4) | ( Data with size of 2 words)
+ * +-------------------------------------+ ( It is 4 words from the ret_stack)
+ * |         STORED DATA WORD 2          |
+ * |         STORED DATA WORD 1          |
+ * +-------------------------------------+
+ * | (0 << FGRAPH_ARRAY_SHIFT)|type:1|(1)| ( 0 for index of first fgraph_ops)
+ * +-------------------------------------+
+ * | struct ftrace_ret_stack             |
+ * |   (stores the saved ret pointer)    |
+ * +-------------------------------------+
+ * |             (X) | (N)               | ( N words away from last ret_stack)
+ * |                                     |
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
  *
  * If a backtrace is required, and the real return pointer needs to be
  * fetched, then it looks at the task's curr_ret_stack index, if it
@@ -77,12 +88,17 @@
 enum {
 	FGRAPH_TYPE_RESERVED	= 0,
 	FGRAPH_TYPE_ARRAY	= 1,
+	FGRAPH_TYPE_DATA	= 2,
 };
 
 #define FGRAPH_ARRAY_SIZE	16
 #define FGRAPH_ARRAY_MASK	((1 << FGRAPH_ARRAY_SIZE) - 1)
 #define FGRAPH_ARRAY_SHIFT	(FGRAPH_TYPE_SHIFT + FGRAPH_TYPE_SIZE)
 
+#define FGRAPH_DATA_SIZE	5
+#define FGRAPH_DATA_MASK	((1 << FGRAPH_DATA_SIZE) - 1)
+#define FGRAPH_DATA_SHIFT	(FGRAPH_TYPE_SHIFT + FGRAPH_TYPE_SIZE)
+
 /* Currently the max stack index can't be more than register callers */
 #define FGRAPH_MAX_INDEX	FGRAPH_ARRAY_SIZE
 
@@ -97,6 +113,8 @@ enum {
 
 #define RET_STACK(t, index) ((struct ftrace_ret_stack *)(&(t)->ret_stack[index]))
 
+#define FGRAPH_MAX_DATA_SIZE (sizeof(long) * (1 << FGRAPH_DATA_SIZE))
+
 /*
  * Each fgraph_ops has a reservered unsigned long at the end (top) of the
  * ret_stack to store task specific state.
@@ -111,21 +129,44 @@ static int fgraph_array_cnt;
 
 static struct fgraph_ops *fgraph_array[FGRAPH_ARRAY_SIZE];
 
+static inline int __get_index(unsigned long val)
+{
+	return val & FGRAPH_RET_INDEX_MASK;
+}
+
+static inline int __get_type(unsigned long val)
+{
+	return (val >> FGRAPH_TYPE_SHIFT) & FGRAPH_TYPE_MASK;
+}
+
+static inline int __get_array(unsigned long val)
+{
+	return (val >> FGRAPH_ARRAY_SHIFT) & FGRAPH_ARRAY_MASK;
+}
+
+static inline int __get_data(unsigned long val)
+{
+	return (val >> FGRAPH_DATA_SHIFT) & FGRAPH_DATA_MASK;
+}
+
 static inline int get_ret_stack_index(struct task_struct *t, int offset)
 {
-	return current->ret_stack[offset] & FGRAPH_RET_INDEX_MASK;
+	return __get_index(current->ret_stack[offset]);
 }
 
 static inline int get_fgraph_type(struct task_struct *t, int offset)
 {
-	return (current->ret_stack[offset] >> FGRAPH_TYPE_SHIFT) &
-		FGRAPH_TYPE_MASK;
+	return __get_type(current->ret_stack[offset]);
 }
 
 static inline int get_fgraph_array(struct task_struct *t, int offset)
 {
-	return (current->ret_stack[offset] >> FGRAPH_ARRAY_SHIFT) &
-		FGRAPH_ARRAY_MASK;
+	return __get_array(current->ret_stack[offset]);
+}
+
+static inline int get_data_idx(struct task_struct *t, int offset)
+{
+	return __get_data(current->ret_stack[offset]);
 }
 
 /* ftrace_graph_entry set to this to tell some archs to run function graph */
@@ -161,6 +202,124 @@ static void ret_stack_init_task_vars(unsigned long *ret_stack)
 	memset(gvals, 0, sizeof(*gvals) * FGRAPH_ARRAY_SIZE);
 }
 
+/**
+ * fgraph_reserve_data - Reserve storage on the task's ret_stack
+ * @size_bytes: The size in bytes to reserve (max of 4 words in size)
+ *
+ * Reserves space of up to 4 words (in word increments) on the
+ * task's ret_stack shadow stack, for a given fgraph_ops during
+ * the entryfunc() call. If entryfunc() returns zero, the storage
+ * is discarded. An entryfunc() can only call this once per iteration.
+ * The fgraph_ops retfunc() can retrieve this stored data with
+ * fgraph_retrieve_data().
+ *
+ * Returns: On success, a pointer to the data on the stack.
+ *   Otherwise, NULL if there's not enough space left on the
+ *   ret_stack for the data, or if fgraph_reserve_data() was called
+ *   more than once for a single entryfunc() call.
+ */
+void *fgraph_reserve_data(int size_bytes)
+{
+	unsigned long val;
+	void *data;
+	int curr_ret_stack = current->curr_ret_stack;
+	int data_size;
+	int size;
+
+	if (size_bytes > FGRAPH_MAX_DATA_SIZE)
+		return NULL;
+
+	/* Convert to number of longs + data word */
+	data_size = ALIGN(size_bytes, sizeof(long)) / sizeof(long) + 1;
+
+	/* The size to add to ret_stack (including the reserve word) */
+	size = data_size + 1;
+
+	val = current->ret_stack[curr_ret_stack - 1];
+
+	switch (__get_type(val)) {
+	case FGRAPH_TYPE_RESERVED:
+		/*
+		 * A reserve word is only saved after the ret_stack
+		 * or after a data storage, not after an fgraph_array
+		 * entry. It's OK if its after the ret_stack in which
+		 * case the index will be one, but if the index is
+		 * greater than 1 it means it's a double call to
+		 * fgraph_reserve_data()
+		 */
+		if (__get_index(val) > 1)
+			return NULL;
+		/*
+		 * Leave the reserve in case the entryfunc() doesn't
+		 * want to be recorded.
+		 */
+		break;
+	case FGRAPH_TYPE_ARRAY:
+		break;
+	default:
+		return NULL;
+	}
+	data = &current->ret_stack[curr_ret_stack];
+
+	curr_ret_stack += size;
+	if (unlikely(curr_ret_stack >= SHADOW_STACK_MAX_INDEX))
+		return NULL;
+
+	val = __get_index(val) + size;
+
+	/* Set the last word to be reserved */
+	current->ret_stack[curr_ret_stack - 1] = val;
+
+	/* Make sure interrupts see this */
+	barrier();
+	current->curr_ret_stack = curr_ret_stack;
+	/* Again sync with interrupts, and reset reserve */
+	current->ret_stack[curr_ret_stack - 1] = val;
+
+	val = (data_size << FGRAPH_DATA_SHIFT) |
+		(FGRAPH_TYPE_DATA << FGRAPH_TYPE_SHIFT) |
+		(val - 1);
+
+	/* Save the data header */
+	current->ret_stack[curr_ret_stack - 2] = val;
+
+	return data;
+}
+
+/**
+ * fgraph_retrieve_data - Retrieve stored data from fgraph_reserve_data()
+ * @size_bytes: pointer to retrieved data size.
+ *
+ * This is to be called by a fgraph_ops retfunc(), to retrieve data that
+ * was stored by the fgraph_ops entryfunc() on the function entry.
+ * That is, this will retrieve the data that was reserved on the
+ * entry of the function that corresponds to the exit of the function
+ * that the fgraph_ops retfunc() is called on.
+ *
+ * Returns: The stored data from fgraph_reserve_data() called by the
+ *    matching entryfunc() for the retfunc() this is called from.
+ *   Or NULL if there was nothing stored.
+ */
+void *fgraph_retrieve_data(int *size_bytes)
+{
+	unsigned long val;
+	int curr_ret_stack = current->curr_ret_stack;
+
+	/* Top of stack is the fgraph_ops */
+	val = current->ret_stack[curr_ret_stack - 1];
+	/* Check if there's nothing between the fgraph_ops and ret_stack */
+	if (__get_index(val) == 1)
+		return NULL;
+	val = current->ret_stack[curr_ret_stack - 2];
+	if (__get_type(val) != FGRAPH_TYPE_DATA)
+		return NULL;
+	if (size_bytes)
+		*size_bytes = (__get_data(val) - 1) * sizeof(long);
+
+	return &current->ret_stack[curr_ret_stack -
+				   (__get_data(val) + 1)];
+}
+
 /**
  * fgraph_get_task_var - retrieve a task specific state variable
  * @gops: The ftrace_ops that owns the task specific variable
@@ -356,6 +515,7 @@ int function_graph_enter(unsigned long ret, unsigned long func,
 			 unsigned long frame_pointer, unsigned long *retp)
 {
 	struct ftrace_graph_ent trace;
+	int save_curr_ret_stack;
 	int offset;
 	int start;
 	int type;
@@ -395,8 +555,10 @@ int function_graph_enter(unsigned long ret, unsigned long func,
 			atomic_inc(&current->trace_overrun);
 			break;
 		}
+		save_curr_ret_stack = current->curr_ret_stack;
 		if (ftrace_ops_test(&gops->ops, func, NULL) &&
 		    gops->entryfunc(&trace, gops)) {
+			/* Note, curr_ret_stack could change by enryfunc() */
 			offset = current->curr_ret_stack;
 			/* Check the top level stored word */
 			type = get_fgraph_type(current, offset - 1);
@@ -430,6 +592,9 @@ int function_graph_enter(unsigned long ret, unsigned long func,
 			barrier();
 			current->ret_stack[offset] = val;
 			cnt++;
+		} else {
+			/* Clear out any saved storage */
+			current->curr_ret_stack = save_curr_ret_stack;
 		}
 	}
 
@@ -544,10 +709,10 @@ static unsigned long __ftrace_return_to_handler(struct fgraph_ret_regs *ret_regs
 	struct ftrace_ret_stack *ret_stack;
 	struct ftrace_graph_ret trace;
 	unsigned long ret;
-	int offset;
+	int curr_ret_stack;
+	int stop_at;
 	int index;
 	int idx;
-	int i;
 
 	ret_stack = ftrace_pop_return_trace(&trace, &ret, frame_pointer);
 
@@ -563,24 +728,39 @@ static unsigned long __ftrace_return_to_handler(struct fgraph_ret_regs *ret_regs
 	trace.retval = fgraph_ret_regs_return_value(ret_regs);
 #endif
 
-	offset = current->curr_ret_stack - 1;
-	index = get_ret_stack_index(current, offset);
+	curr_ret_stack = current->curr_ret_stack;
+	index = get_ret_stack_index(current, curr_ret_stack - 1);
+
+	stop_at = curr_ret_stack - index;
 
 	/* index has to be at least one! Optimize for it */
-	i = 0;
 	do {
-		idx = get_fgraph_array(current, offset - i);
-		fgraph_array[idx]->retfunc(&trace, fgraph_array[idx]);
-		i++;
-	} while (i < index);
+		unsigned long val;
+
+		val = current->ret_stack[curr_ret_stack - 1];
+		switch (__get_type(val)) {
+		case FGRAPH_TYPE_ARRAY:
+			idx = __get_array(val);
+			fgraph_array[idx]->retfunc(&trace, fgraph_array[idx]);
+			curr_ret_stack -= __get_index(val);
+			break;
+		case FGRAPH_TYPE_RESERVED:
+			curr_ret_stack--;
+			break;
+		case FGRAPH_TYPE_DATA:
+			curr_ret_stack -= __get_data(val);
+			break;
+		default:
+			WARN_ONCE(1, "Bad fgraph ret_stack data type %d",
+				  __get_type(val));
+			curr_ret_stack--;
+		}
+		/* Make sure interrupts see the update after the above */
+		barrier();
+		current->curr_ret_stack = curr_ret_stack;
+	} while (curr_ret_stack > stop_at);
 
-	/*
-	 * The ftrace_graph_return() may still access the current
-	 * ret_stack structure, we need to make sure the update of
-	 * curr_ret_stack is after that.
-	 */
-	barrier();
-	current->curr_ret_stack -= index + FGRAPH_RET_INDEX;
+	current->curr_ret_stack -= FGRAPH_RET_INDEX;
 	current->curr_ret_depth--;
 	return ret;
 }


