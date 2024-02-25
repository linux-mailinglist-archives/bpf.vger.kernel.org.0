Return-Path: <bpf+bounces-22671-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DE41862B1D
	for <lists+bpf@lfdr.de>; Sun, 25 Feb 2024 16:19:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E88A91F21140
	for <lists+bpf@lfdr.de>; Sun, 25 Feb 2024 15:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 528BA175A1;
	Sun, 25 Feb 2024 15:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hUxNb0VH"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8DDF1B7FC;
	Sun, 25 Feb 2024 15:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708874305; cv=none; b=kYi+Mcgs9GZBZWBs1mgB/bJ23NKQSrWyYzzyZr8MlEjSAjs7NlCXrMjjtLkiFCDF3aSOOaKw22y0qlRFT18tLjrKBcIFr7rGCYwaFDYV3900PGxBlBudQSyWPc4WfKhleNzd/LQpOV5kklwNRysU4zhlcJ2P36bh1AJ4m0CXoUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708874305; c=relaxed/simple;
	bh=/Y6Rr19lm5RDsWlFd7LZ0gC4gAR8Li0fDvhYnmOF7Kc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KghqQCCnLZ05Z67izP3cHKNZuoQDW8YYMXWoFgor0YUkJKan886Rb1oQBgiLV22MvQl3Wr9ZCi1sVUqK6hmbtmwJwPuVzunFC6GW6jNVZ52ZVAuT93MkoUq7F65e3vIZMFqrclcGzY1pvlILE6Weu26ihcnk13IZ3gKcYWqfJ74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hUxNb0VH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D39FC433F1;
	Sun, 25 Feb 2024 15:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708874305;
	bh=/Y6Rr19lm5RDsWlFd7LZ0gC4gAR8Li0fDvhYnmOF7Kc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hUxNb0VHxSV+9kh0volmyv7RFiNE6MdL/je2VDsw+dKRhjMpT7lxykYLhTPxCz7dI
	 bN3dZpaBKUvawtaJphPpaA7vzErdFPVTxYr6X4gggpGH2++DHwVFq8pcjSfao5ahw2
	 Bxsh+7QRo3FKBjDw26DZMWVqCtu064cGmOwzV2uUN8z/UYAJ5kBAQG9RGKaDdcWR9y
	 +t87Rvv4tM5SZKHy1D2nk6w8Uq+Bg1HTRzxv8yNQAKKK/V0+KHFWDI0nv4K/hL+XUD
	 qCuhynj+06M1AFD8PeBlIxij9F7KVbqxrFp9r5E8vDzfA8Alg6ydqyomEbPmvsoVV9
	 nd7zLOsPmYxZg==
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
Subject: [PATCH v8 18/35] function_graph: Implement fgraph_reserve_data() and fgraph_retrieve_data()
Date: Mon, 26 Feb 2024 00:18:20 +0900
Message-Id: <170887430044.564249.12915713205477530976.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <170887410337.564249.6360118840946697039.stgit@devnote2>
References: <170887410337.564249.6360118840946697039.stgit@devnote2>
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
 Changes in v8:
  - Avoid using DIV_ROUND_UP() in the hot path.
 Changes in v3:
  - Store fgraph_array index to the data entry.
  - Both function requires fgraph_array index to store/retrieve data.
  - Reserve correct size of the data.
  - Return correct data area.
 Changes in v2:
  - Retrieve the reserved size by fgraph_retrieve_data().
  - Expand the maximum data size to 32 words.
  - Update stack index with __get_index(val) if FGRAPH_TYPE_ARRAY entry.
  - fix typos and make description lines shorter than 76 chars.
---
 include/linux/ftrace.h |    3 +
 kernel/trace/fgraph.c  |  175 ++++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 170 insertions(+), 8 deletions(-)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 737f84104577..815e865f46c9 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -1075,6 +1075,9 @@ struct fgraph_ops {
 	int				idx;
 };
 
+void *fgraph_reserve_data(int idx, int size_bytes);
+void *fgraph_retrieve_data(int idx, int *size_bytes);
+
 /*
  * Stack of return addresses for functions
  * of a thread.
diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index 780976088587..66d9ce78b292 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -41,17 +41,29 @@
  * bits: 10 - 11	Type of storage
  *			  0 - reserved
  *			  1 - bitmap of fgraph_array index
+ *			  2 - reserved data
  *
  * For bitmap of fgraph_array index
  *  bits: 12 - 27	The bitmap of fgraph_ops fgraph_array index
  *
+ * For reserved data:
+ *  bits: 12 - 17	The size in words that is stored
+ *  bits: 18 - 23	The index of fgraph_array, which shows who is stored
+ *
  * That is, at the end of function_graph_enter, if the first and forth
  * fgraph_ops on the fgraph_array[] (index 0 and 3) needs their retfunc called
- * on the return of the function being traced, this is what will be on the
- * task's shadow ret_stack: (the stack grows upward)
+ * on the return of the function being traced, and the forth fgraph_ops
+ * stored two words of data, this is what will be on the task's shadow
+ * ret_stack: (the stack grows upward)
  *
  * |                                            | <- task->curr_ret_stack
  * +--------------------------------------------+
+ * | data_type(idx:3, size:2,                   |
+ * |           offset:FGRAPH_RET_INDEX+3)       | ( Data with size of 2 words)
+ * +--------------------------------------------+ ( It is 4 words from the ret_stack)
+ * |            STORED DATA WORD 2              |
+ * |            STORED DATA WORD 1              |
+ * +------i-------------------------------------+
  * | bitmap_type(bitmap:(BIT(3)|BIT(0)),        |
  * |             offset:FGRAPH_RET_INDEX)       | <- the offset is from here
  * +--------------------------------------------+
@@ -78,14 +90,23 @@
 enum {
 	FGRAPH_TYPE_RESERVED	= 0,
 	FGRAPH_TYPE_BITMAP	= 1,
+	FGRAPH_TYPE_DATA	= 2,
 };
 
 #define FGRAPH_INDEX_SIZE	16
 #define FGRAPH_INDEX_MASK	GENMASK(FGRAPH_INDEX_SIZE - 1, 0)
 #define FGRAPH_INDEX_SHIFT	(FGRAPH_TYPE_SHIFT + FGRAPH_TYPE_SIZE)
 
-/* Currently the max stack index can't be more than register callers */
-#define FGRAPH_MAX_INDEX	(FGRAPH_INDEX_SIZE + FGRAPH_RET_INDEX)
+#define FGRAPH_DATA_SIZE	5
+#define FGRAPH_DATA_MASK	((1 << FGRAPH_DATA_SIZE) - 1)
+#define FGRAPH_DATA_SHIFT	(FGRAPH_TYPE_SHIFT + FGRAPH_TYPE_SIZE)
+
+#define FGRAPH_DATA_INDEX_SIZE	4
+#define FGRAPH_DATA_INDEX_MASK	((1 << FGRAPH_DATA_INDEX_SIZE) - 1)
+#define FGRAPH_DATA_INDEX_SHIFT	(FGRAPH_DATA_SHIFT + FGRAPH_DATA_SIZE)
+
+#define FGRAPH_MAX_INDEX	\
+	((FGRAPH_INDEX_SIZE << FGRAPH_DATA_SIZE) + FGRAPH_RET_INDEX)
 
 #define FGRAPH_ARRAY_SIZE	FGRAPH_INDEX_SIZE
 
@@ -97,6 +118,8 @@ enum {
 
 #define RET_STACK(t, index) ((struct ftrace_ret_stack *)(&(t)->ret_stack[index]))
 
+#define FGRAPH_MAX_DATA_SIZE (sizeof(long) * (1 << FGRAPH_DATA_SIZE))
+
 /*
  * Each fgraph_ops has a reservered unsigned long at the end (top) of the
  * ret_stack to store task specific state.
@@ -149,14 +172,39 @@ static int fgraph_lru_alloc_index(void)
 	return idx;
 }
 
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
+static inline int __get_data_index(unsigned long val)
+{
+	return (val >> FGRAPH_DATA_INDEX_SHIFT) & FGRAPH_DATA_INDEX_MASK;
+}
+
+static inline int __get_data_size(unsigned long val)
+{
+	return (val >> FGRAPH_DATA_SHIFT) & FGRAPH_DATA_MASK;
+}
+
+static inline unsigned long get_fgraph_entry(struct task_struct *t, int index)
+{
+	return t->ret_stack[index];
+}
+
 static inline int get_ret_stack_index(struct task_struct *t, int offset)
 {
-	return t->ret_stack[offset] & FGRAPH_RET_INDEX_MASK;
+	return __get_index(t->ret_stack[offset]);
 }
 
 static inline int get_fgraph_type(struct task_struct *t, int offset)
 {
-	return (t->ret_stack[offset] >> FGRAPH_TYPE_SHIFT) & FGRAPH_TYPE_MASK;
+	return __get_type(t->ret_stack[offset]);
 }
 
 static inline unsigned long
@@ -183,6 +231,22 @@ add_fgraph_index_bitmap(struct task_struct *t, int offset, unsigned long bitmap)
 	t->ret_stack[offset] |= (bitmap << FGRAPH_INDEX_SHIFT);
 }
 
+static inline void *get_fgraph_data(struct task_struct *t, int index)
+{
+	unsigned long val = t->ret_stack[index];
+
+	if (__get_type(val) != FGRAPH_TYPE_DATA)
+		return NULL;
+	index -= __get_data_size(val);
+	return (void *)&t->ret_stack[index];
+}
+
+static inline unsigned long make_fgraph_data(int idx, int size, int offset)
+{
+	return (idx << FGRAPH_DATA_INDEX_SHIFT) | (size << FGRAPH_DATA_SHIFT) |
+		(FGRAPH_TYPE_DATA << FGRAPH_TYPE_SHIFT) | offset;
+}
+
 /* ftrace_graph_entry set to this to tell some archs to run function graph */
 static int entry_run(struct ftrace_graph_ent *trace, struct fgraph_ops *ops)
 {
@@ -216,6 +280,92 @@ static void ret_stack_init_task_vars(unsigned long *ret_stack)
 	memset(gvals, 0, sizeof(*gvals) * FGRAPH_ARRAY_SIZE);
 }
 
+/**
+ * fgraph_reserve_data - Reserve storage on the task's ret_stack
+ * @idx:	The index of fgraph_array
+ * @size_bytes: The size in bytes to reserve
+ *
+ * Reserves space of up to FGRAPH_MAX_DATA_SIZE bytes on the
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
+void *fgraph_reserve_data(int idx, int size_bytes)
+{
+	unsigned long val;
+	void *data;
+	int curr_ret_stack = current->curr_ret_stack;
+	int data_size;
+
+	if (size_bytes > FGRAPH_MAX_DATA_SIZE)
+		return NULL;
+
+	/* Convert to number of longs + data word */
+	data_size = (size_bytes + sizeof(long) - 1) >> (sizeof(long) == 4 ? 2 : 3);
+
+	val = get_fgraph_entry(current, curr_ret_stack - 1);
+	data = &current->ret_stack[curr_ret_stack];
+
+	curr_ret_stack += data_size + 1;
+	if (unlikely(curr_ret_stack >= SHADOW_STACK_MAX_INDEX))
+		return NULL;
+
+	val = make_fgraph_data(idx, data_size, __get_index(val) + data_size + 1);
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
+	return data;
+}
+
+/**
+ * fgraph_retrieve_data - Retrieve stored data from fgraph_reserve_data()
+ * @idx:	the index of fgraph_array (fgraph_ops::idx)
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
+void *fgraph_retrieve_data(int idx, int *size_bytes)
+{
+	int index = current->curr_ret_stack - 1;
+	unsigned long val;
+
+	val = get_fgraph_entry(current, index);
+	while (__get_type(val) == FGRAPH_TYPE_DATA) {
+		if (__get_data_index(val) == idx)
+			goto found;
+		index -= __get_data_size(val) + 1;
+		val = get_fgraph_entry(current, index);
+	}
+	return NULL;
+found:
+	if (size_bytes)
+		*size_bytes = __get_data_size(val) *
+			      sizeof(long);
+	return get_fgraph_data(current, index);
+}
+
 /**
  * fgraph_get_task_var - retrieve a task specific state variable
  * @gops: The ftrace_ops that owns the task specific variable
@@ -453,13 +603,18 @@ int function_graph_enter(unsigned long ret, unsigned long func,
 
 	for (i = 0; i < FGRAPH_ARRAY_SIZE; i++) {
 		struct fgraph_ops *gops = fgraph_array[i];
+		int save_curr_ret_stack;
 
 		if (gops == &fgraph_stub)
 			continue;
 
+		save_curr_ret_stack = current->curr_ret_stack;
 		if (ftrace_ops_test(&gops->ops, func, NULL) &&
 		    gops->entryfunc(&trace, gops))
 			bitmap |= BIT(i);
+		else
+			/* Clear out any saved storage */
+			current->curr_ret_stack = save_curr_ret_stack;
 	}
 
 	if (!bitmap)
@@ -485,6 +640,7 @@ int function_graph_enter_ops(unsigned long ret, unsigned long func,
 			     struct fgraph_ops *gops)
 {
 	struct ftrace_graph_ent trace;
+	int save_curr_ret_stack;
 	int index;
 	int type;
 
@@ -504,13 +660,15 @@ int function_graph_enter_ops(unsigned long ret, unsigned long func,
 
 	trace.func = func;
 	trace.depth = current->curr_ret_depth;
+	save_curr_ret_stack = current->curr_ret_stack;
 	if (gops->entryfunc(&trace, gops)) {
 		if (type == FGRAPH_TYPE_RESERVED)
 			set_fgraph_index_bitmap(current, index, BIT(gops->idx));
 		else
 			add_fgraph_index_bitmap(current, index, BIT(gops->idx));
 		return 0;
-	}
+	} else
+		current->curr_ret_stack = save_curr_ret_stack;
 
 	if (type == FGRAPH_TYPE_RESERVED) {
 		current->curr_ret_stack -= FGRAPH_RET_INDEX + 1;
@@ -655,7 +813,8 @@ static unsigned long __ftrace_return_to_handler(struct fgraph_ret_regs *ret_regs
 	 * curr_ret_stack is after that.
 	 */
 	barrier();
-	current->curr_ret_stack -= FGRAPH_RET_INDEX + 1;
+	current->curr_ret_stack = index - FGRAPH_RET_INDEX;
+
 	current->curr_ret_depth--;
 	return ret;
 }


