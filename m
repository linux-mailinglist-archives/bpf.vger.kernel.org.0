Return-Path: <bpf+bounces-28855-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F71F8BE561
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 16:13:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B17D71C241AD
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 14:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63F2E16132B;
	Tue,  7 May 2024 14:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uCZ//Ijd"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D703E15FA63;
	Tue,  7 May 2024 14:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715091098; cv=none; b=PhY1LhSu0lMvd9kzyxz9FXNjsfAR7UDd1OGjWiHh92kcLbp5wSLpPYTANYpUttxIy7RSFcXIb4Bdr5oTrHrWmUrO3yaGnfRfBS9nikSFAb5nxRGe8sRduHR7NIjAyURmHjMA+SUj9fz7lasAZRUiWPzI8xzVz2XvqIL4nITVRpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715091098; c=relaxed/simple;
	bh=fBr1WfIOGOaHVB2WiabWCgbEBdHrCrcl+ohvPjGEA/g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pTNqttrEmaptK8GD6MreYj6QLn2DBQM/qvDvVgEXjfhEbjcuWBZFrEKBSMx3ss+4g/GiVsV44Dt/gysfSu5fFQJ2JqFuJvEM/f4u4gonXif67E5MNHXZdLzRK3V8oM+YRKxjt1DRQlKO5ij62nHcD0+lOlqIsPEFuDGqx64+CxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uCZ//Ijd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34DBEC2BBFC;
	Tue,  7 May 2024 14:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715091097;
	bh=fBr1WfIOGOaHVB2WiabWCgbEBdHrCrcl+ohvPjGEA/g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uCZ//IjdHjWYeSpvaJqGaBltwDkTJqqqVj3IxbyLtSp4IBRB+mmkXkqaxalVZv+xn
	 hn3dgkgT/b3CKjNJ7oXSZmxUHdh03adAe1WmtZ0tAQlwsvkSKMSPSQvQ+bTX1kq5qF
	 9A2yqwQoTUa6Exj9C22q8zHdIsgvhEzkl7dR+ftXiLg8VRFe5+j+TZ2YFOz8q81Bby
	 WzbdlXxRz31Zt1xmGWciWDTe/XPt55+gezr66F5oUGgbDE9bdPnyiIbNI9gAdaHXiS
	 IlhD2rgww9xlp3OdYMKwzsSMT2KYDWTLxQ60WQ0D1QEySTmkBsSNf6uU1gjXcCxggN
	 ilDqRwL0Zvd4g==
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
Subject: [PATCH v10 18/36] function_graph: Implement fgraph_reserve_data() and fgraph_retrieve_data()
Date: Tue,  7 May 2024 23:11:30 +0900
Message-Id: <171509109089.162236.11372474169781184034.stgit@devnote2>
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

Added functions that can be called by a fgraph_ops entryfunc and retfunc to
store state between the entry of the function being traced to the exit of
the same function. The fgraph_ops entryfunc() may call
fgraph_reserve_data() to store up to 32 words onto the task's shadow
ret_stack and this then can be retrieved by fgraph_retrieve_data() called
by the corresponding retfunc().

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 Changes in v10:
  - Fix to support data size up to 32 words (previously it only support up to
    31 words but the max size check missed to check it is 32 words)
  - Use "offset" instead of "index".
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
 kernel/trace/fgraph.c  |  179 ++++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 175 insertions(+), 7 deletions(-)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 97f7d1cf4f8f..1eee028b9a75 100644
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
index 3498e8fd8e53..4f62e82448f6 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -37,14 +37,20 @@
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
  *  ret_stack[SHADOW_STACK_IN_WORD]
  * | SHADOW_STACK_TASK_VARS(ret_stack)[15]      |
@@ -54,9 +60,17 @@
  * ...
  * |                                            | <- task->curr_ret_stack
  * +--------------------------------------------+
+ * | (3 << FGRAPH_DATA_INDEX_SHIFT)| \          | This is for fgraph_ops[3].
+ * | ((2 - 1) << FGRAPH_DATA_SHIFT)| \          | The data size is 2 words.
+ * | (FGRAPH_TYPE_DATA << FGRAPH_TYPE_SHIFT)| \ |
+ * | (offset2:FGRAPH_FRAME_OFFSET+3)            | <- the offset2 is from here
+ * +--------------------------------------------+ ( It is 4 words from the ret_stack)
+ * |            STORED DATA WORD 2              |
+ * |            STORED DATA WORD 1              |
+ * +------i-------------------------------------+
  * | (BIT(3)|BIT(0)) << FGRAPH_INDEX_SHIFT | \  |
  * | FGRAPH_TYPE_BITMAP << FGRAPH_TYPE_SHIFT| \ |
- * | (offset:FGRAPH_FRAME_OFFSET)               | <- the offset is from here
+ * | (offset1:FGRAPH_FRAME_OFFSET)              | <- the offset1 is from here
  * +--------------------------------------------+
  * | struct ftrace_ret_stack                    |
  * |   (stores the saved ret pointer)           | <- the offset points here
@@ -83,12 +97,26 @@
 enum {
 	FGRAPH_TYPE_RESERVED	= 0,
 	FGRAPH_TYPE_BITMAP	= 1,
+	FGRAPH_TYPE_DATA	= 2,
 };
 
 #define FGRAPH_INDEX_SIZE	16
 #define FGRAPH_INDEX_MASK	GENMASK(FGRAPH_INDEX_SIZE - 1, 0)
 #define FGRAPH_INDEX_SHIFT	(FGRAPH_TYPE_SHIFT + FGRAPH_TYPE_SIZE)
 
+/* The data size == 0 means 1 word, and 31 (=2^5 - 1) means 32 words. */
+#define FGRAPH_DATA_SIZE	5
+#define FGRAPH_DATA_MASK	GENMASK(FGRAPH_DATA_SIZE - 1, 0)
+#define FGRAPH_DATA_SHIFT	(FGRAPH_TYPE_SHIFT + FGRAPH_TYPE_SIZE)
+#define FGRAPH_MAX_DATA_SIZE (sizeof(long) * (1 << FGRAPH_DATA_SIZE))
+
+#define FGRAPH_DATA_INDEX_SIZE	4
+#define FGRAPH_DATA_INDEX_MASK	GENMASK(FGRAPH_DATA_INDEX_SIZE - 1, 0)
+#define FGRAPH_DATA_INDEX_SHIFT	(FGRAPH_DATA_SHIFT + FGRAPH_DATA_SIZE)
+
+#define FGRAPH_MAX_INDEX	\
+	((FGRAPH_INDEX_SIZE << FGRAPH_DATA_SIZE) + FGRAPH_RET_INDEX)
+
 #define FGRAPH_ARRAY_SIZE	FGRAPH_INDEX_SIZE
 
 #define SHADOW_STACK_SIZE (PAGE_SIZE)
@@ -151,14 +179,39 @@ static int fgraph_lru_alloc_index(void)
 	return idx;
 }
 
+static inline int __get_offset(unsigned long val)
+{
+	return val & FGRAPH_FRAME_OFFSET_MASK;
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
+	return ((val >> FGRAPH_DATA_SHIFT) & FGRAPH_DATA_MASK) + 1;
+}
+
+static inline unsigned long get_fgraph_entry(struct task_struct *t, int offset)
+{
+	return t->ret_stack[offset];
+}
+
 static inline int get_frame_offset(struct task_struct *t, int offset)
 {
-	return t->ret_stack[offset] & FGRAPH_FRAME_OFFSET_MASK;
+	return __get_offset(t->ret_stack[offset]);
 }
 
 static inline int get_fgraph_type(struct task_struct *t, int offset)
 {
-	return (t->ret_stack[offset] >> FGRAPH_TYPE_SHIFT) & FGRAPH_TYPE_MASK;
+	return __get_type(t->ret_stack[offset]);
 }
 
 static inline unsigned long
@@ -185,6 +238,24 @@ add_fgraph_index_bitmap(struct task_struct *t, int offset, unsigned long bitmap)
 	t->ret_stack[offset] |= (bitmap << FGRAPH_INDEX_SHIFT);
 }
 
+/* Note: @offset is the offset of FGRAPH_TYPE_DATA entry. */
+static inline void *get_fgraph_data(struct task_struct *t, int offset)
+{
+	unsigned long val = t->ret_stack[offset];
+
+	if (__get_type(val) != FGRAPH_TYPE_DATA)
+		return NULL;
+	offset -= __get_data_size(val);
+	return (void *)&t->ret_stack[offset];
+}
+
+static inline unsigned long make_fgraph_data(int idx, int size, int offset)
+{
+	return (idx << FGRAPH_DATA_INDEX_SHIFT) |
+		((size - 1) << FGRAPH_DATA_SHIFT) |
+		(FGRAPH_TYPE_DATA << FGRAPH_TYPE_SHIFT) | offset;
+}
+
 /* ftrace_graph_entry set to this to tell some archs to run function graph */
 static int entry_run(struct ftrace_graph_ent *trace, struct fgraph_ops *ops)
 {
@@ -218,6 +289,91 @@ static void ret_stack_init_task_vars(unsigned long *ret_stack)
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
+	/* Convert the data size to number of longs. */
+	data_size = (size_bytes + sizeof(long) - 1) >> (sizeof(long) == 4 ? 2 : 3);
+
+	val = get_fgraph_entry(current, curr_ret_stack - 1);
+	data = &current->ret_stack[curr_ret_stack];
+
+	curr_ret_stack += data_size + 1;
+	if (unlikely(curr_ret_stack >= SHADOW_STACK_MAX_OFFSET))
+		return NULL;
+
+	val = make_fgraph_data(idx, data_size, __get_offset(val) + data_size + 1);
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
+	int offset = current->curr_ret_stack - 1;
+	unsigned long val;
+
+	val = get_fgraph_entry(current, offset);
+	while (__get_type(val) == FGRAPH_TYPE_DATA) {
+		if (__get_data_index(val) == idx)
+			goto found;
+		offset -= __get_data_size(val) + 1;
+		val = get_fgraph_entry(current, offset);
+	}
+	return NULL;
+found:
+	if (size_bytes)
+		*size_bytes = __get_data_size(val) * sizeof(long);
+	return get_fgraph_data(current, offset);
+}
+
 /**
  * fgraph_get_task_var - retrieve a task specific state variable
  * @gops: The ftrace_ops that owns the task specific variable
@@ -455,13 +611,18 @@ int function_graph_enter(unsigned long ret, unsigned long func,
 
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
@@ -487,6 +648,7 @@ int function_graph_enter_ops(unsigned long ret, unsigned long func,
 			     struct fgraph_ops *gops)
 {
 	struct ftrace_graph_ent trace;
+	int save_curr_ret_stack;
 	int offset;
 	int type;
 
@@ -506,13 +668,15 @@ int function_graph_enter_ops(unsigned long ret, unsigned long func,
 
 	trace.func = func;
 	trace.depth = current->curr_ret_depth;
+	save_curr_ret_stack = current->curr_ret_stack;
 	if (gops->entryfunc(&trace, gops)) {
 		if (type == FGRAPH_TYPE_RESERVED)
 			set_fgraph_index_bitmap(current, offset, BIT(gops->idx));
 		else
 			add_fgraph_index_bitmap(current, offset, BIT(gops->idx));
 		return 0;
-	}
+	} else
+		current->curr_ret_stack = save_curr_ret_stack;
 
 	if (type == FGRAPH_TYPE_RESERVED) {
 		current->curr_ret_stack -= FGRAPH_FRAME_OFFSET + 1;
@@ -657,7 +821,8 @@ static unsigned long __ftrace_return_to_handler(struct fgraph_ret_regs *ret_regs
 	 * curr_ret_stack is after that.
 	 */
 	barrier();
-	current->curr_ret_stack -= FGRAPH_FRAME_OFFSET + 1;
+	current->curr_ret_stack = offset - FGRAPH_FRAME_OFFSET;
+
 	current->curr_ret_depth--;
 	return ret;
 }


