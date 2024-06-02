Return-Path: <bpf+bounces-31129-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 817A48D735C
	for <lists+bpf@lfdr.de>; Sun,  2 Jun 2024 05:39:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9219B2156D
	for <lists+bpf@lfdr.de>; Sun,  2 Jun 2024 03:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89B8B3B2A1;
	Sun,  2 Jun 2024 03:37:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B4311712;
	Sun,  2 Jun 2024 03:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717299447; cv=none; b=MI8OSLvP3WrT33uo2mmK0OMRpXSwagLcnn/3Ge/e1VPZzXlcwOUX+vdcRKfNnP7JjYPGV4YOozy5MlKotPhN364oP6A4XSvSDITTWkkjVg7oCSw5rhIbRlvwiXwcmbzTZs8kS2JHVz38xWwm9sc6+YhLGUxEmCMSiadRuiLRm+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717299447; c=relaxed/simple;
	bh=6xxEZTPjtuAvunSxyIUoXlUZBxO25j8sGdXoLzd16gA=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=b/AKg3GQHEBdUv1zA8Zuv2pdqr473Bivkr5pXn9n15pZtsCR50z+Fl6MFyQ9MVmbnLo2v43IcwcnLqnj8NQy1udasczbSvESd+A171HXYsvKiFDnl0xBpyJ06Km8/8yM369iSNKNhQfY43Vkj9n7rXs6ML8e63WribRVYaHd/ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 081E6C4AF0F;
	Sun,  2 Jun 2024 03:37:27 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1sDc3G-000000094SR-1LbW;
	Sat, 01 Jun 2024 23:38:34 -0400
Message-ID: <20240602033834.178311823@goodmis.org>
User-Agent: quilt/0.68
Date: Sat, 01 Jun 2024 23:38:03 -0400
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
Subject: [PATCH v2 19/27] function_graph: Implement fgraph_reserve_data() and
 fgraph_retrieve_data()
References: <20240602033744.563858532@goodmis.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

Added functions that can be called by a fgraph_ops entryfunc and retfunc to
store state between the entry of the function being traced to the exit of
the same function. The fgraph_ops entryfunc() may call
fgraph_reserve_data() to store up to 32 words onto the task's shadow
ret_stack and this then can be retrieved by fgraph_retrieve_data() called
by the corresponding retfunc().

Co-developed with Masami Hiramatsu:
Link: https://lore.kernel.org/linux-trace-kernel/171509109089.162236.11372474169781184034.stgit@devnote2

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/linux/ftrace.h |   3 +
 kernel/trace/fgraph.c  | 191 +++++++++++++++++++++++++++++++++++++++--
 2 files changed, 186 insertions(+), 8 deletions(-)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 82cfc8e09cfd..9f61556a9491 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -1053,6 +1053,9 @@ struct fgraph_ops {
 	int				idx;
 };
 
+void *fgraph_reserve_data(int idx, int size_bytes);
+void *fgraph_retrieve_data(int idx, int *size_bytes);
+
 /*
  * Stack of return addresses for functions
  * of a thread.
diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index baa08249ffd5..f207b7ae5f46 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -31,12 +31,11 @@
  * holds a bitmask and a type (called "bitmap"). The bitmap is defined as:
  *
  * bits:  0 -  9	offset in words from the previous ftrace_ret_stack
- *			Currently, this will always be set to FGRAPH_FRAME_OFFSET
- *			to get to the fgraph frame.
  *
  * bits: 10 - 11	Type of storage
  *			  0 - reserved
  *			  1 - bitmap of fgraph_array index
+ *			  2 - reserved data
  *
  * For type with "bitmap of fgraph_array index" (FGRAPH_TYPE_BITMAP):
  *  bits: 12 - 27	The bitmap of fgraph_ops fgraph_array index
@@ -49,10 +48,15 @@
  * The top of the ret_stack (when not empty) will always have a reference
  * word that points to the last fgraph frame that was saved.
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
  *  ret_stack[SHADOW_STACK_OFFSET]
  * | SHADOW_STACK_TASK_VARS(ret_stack)[15]      |
@@ -62,11 +66,21 @@
  * ...
  * |                                            | <- task->curr_ret_stack
  * +--------------------------------------------+
+ * | (3 << 12) | (3 << 10) | FGRAPH_FRAME_OFFSET|
+ * |         *or put another way*               |
+ * | (3 << FGRAPH_DATA_INDEX_SHIFT)| \          | This is for fgraph_ops[3].
+ * | ((2 - 1) << FGRAPH_DATA_SHIFT)| \          | The data size is 2 words.
+ * | (FGRAPH_TYPE_DATA << FGRAPH_TYPE_SHIFT)| \ |
+ * | (offset2:FGRAPH_FRAME_OFFSET+3)            | <- the offset2 is from here
+ * +--------------------------------------------+ ( It is 4 words from the ret_stack)
+ * |            STORED DATA WORD 2              |
+ * |            STORED DATA WORD 1              |
+ * +--------------------------------------------+
  * | (9 << 12) | (1 << 10) | FGRAPH_FRAME_OFFSET|
  * |         *or put another way*               |
  * | (BIT(3)|BIT(0)) << FGRAPH_INDEX_SHIFT | \  |
  * | FGRAPH_TYPE_BITMAP << FGRAPH_TYPE_SHIFT| \ |
- * | (offset:FGRAPH_FRAME_OFFSET)               | <- the offset is from here
+ * | (offset1:FGRAPH_FRAME_OFFSET)              | <- the offset1 is from here
  * +--------------------------------------------+
  * | struct ftrace_ret_stack                    |
  * |   (stores the saved ret pointer)           | <- the offset points here
@@ -100,6 +114,7 @@
 enum {
 	FGRAPH_TYPE_RESERVED	= 0,
 	FGRAPH_TYPE_BITMAP	= 1,
+	FGRAPH_TYPE_DATA	= 2,
 };
 
 /*
@@ -110,6 +125,26 @@ enum {
 #define FGRAPH_INDEX_MASK	GENMASK(FGRAPH_INDEX_BITS - 1, 0)
 #define FGRAPH_INDEX_SHIFT	(FGRAPH_TYPE_SHIFT + FGRAPH_TYPE_BITS)
 
+/*
+ * For DATA type:
+ *  FGRAPH_DATA (12-17) bits hold the size of data (in words)
+ *  FGRAPH_INDEX (18-23) bits hold the index for which gops->idx the data is for
+ *
+ * Note:
+ *  data_size == 0 means 1 word, and 31 (=2^5 - 1) means 32 words.
+ */
+#define FGRAPH_DATA_BITS	5
+#define FGRAPH_DATA_MASK	GENMASK(FGRAPH_DATA_BITS - 1, 0)
+#define FGRAPH_DATA_SHIFT	(FGRAPH_TYPE_SHIFT + FGRAPH_TYPE_BITS)
+#define FGRAPH_MAX_DATA_SIZE (sizeof(long) * (1 << FGRAPH_DATA_BITS))
+
+#define FGRAPH_DATA_INDEX_BITS	4
+#define FGRAPH_DATA_INDEX_MASK	GENMASK(FGRAPH_DATA_INDEX_BITS - 1, 0)
+#define FGRAPH_DATA_INDEX_SHIFT	(FGRAPH_DATA_SHIFT + FGRAPH_DATA_BITS)
+
+#define FGRAPH_MAX_INDEX	\
+	((FGRAPH_INDEX_SIZE << FGRAPH_DATA_BITS) + FGRAPH_RET_INDEX)
+
 #define FGRAPH_ARRAY_SIZE	FGRAPH_INDEX_BITS
 
 /*
@@ -178,16 +213,46 @@ static int fgraph_lru_alloc_index(void)
 	return idx;
 }
 
+/* Get the offset to the fgraph frame from a ret_stack value */
+static inline int __get_offset(unsigned long val)
+{
+	return val & FGRAPH_FRAME_OFFSET_MASK;
+}
+
+/* Get the type of word from a ret_stack value */
+static inline int __get_type(unsigned long val)
+{
+	return (val >> FGRAPH_TYPE_SHIFT) & FGRAPH_TYPE_MASK;
+}
+
+/* Get the data_index for a DATA type ret_stack word */
+static inline int __get_data_index(unsigned long val)
+{
+	return (val >> FGRAPH_DATA_INDEX_SHIFT) & FGRAPH_DATA_INDEX_MASK;
+}
+
+/* Get the data_size for a DATA type ret_stack word */
+static inline int __get_data_size(unsigned long val)
+{
+	return ((val >> FGRAPH_DATA_SHIFT) & FGRAPH_DATA_MASK) + 1;
+}
+
+/* Get the word from the ret_stack at @offset */
+static inline unsigned long get_fgraph_entry(struct task_struct *t, int offset)
+{
+	return t->ret_stack[offset];
+}
+
 /* Get the FRAME_OFFSET from the word from the @offset on ret_stack */
 static inline int get_frame_offset(struct task_struct *t, int offset)
 {
-	return t->ret_stack[offset] & FGRAPH_FRAME_OFFSET_MASK;
+	return __get_offset(t->ret_stack[offset]);
 }
 
 /* Get FGRAPH_TYPE from the word from the @offset at ret_stack */
 static inline int get_fgraph_type(struct task_struct *t, int offset)
 {
-	return (t->ret_stack[offset] >> FGRAPH_TYPE_SHIFT) & FGRAPH_TYPE_MASK;
+	return __get_type(t->ret_stack[offset]);
 }
 
 /* For BITMAP type: get the bitmask from the @offset at ret_stack */
@@ -212,6 +277,25 @@ set_bitmap(struct task_struct *t, int offset, unsigned long bitmap)
 		(FGRAPH_TYPE_BITMAP << FGRAPH_TYPE_SHIFT) | FGRAPH_FRAME_OFFSET;
 }
 
+/* For DATA type: get the data saved under the ret_stack word at @offset */
+static inline void *get_data_type_data(struct task_struct *t, int offset)
+{
+	unsigned long val = t->ret_stack[offset];
+
+	if (__get_type(val) != FGRAPH_TYPE_DATA)
+		return NULL;
+	offset -= __get_data_size(val);
+	return (void *)&t->ret_stack[offset];
+}
+
+/* Create the ret_stack word for a DATA type */
+static inline unsigned long make_data_type_val(int idx, int size, int offset)
+{
+	return (idx << FGRAPH_DATA_INDEX_SHIFT) |
+		((size - 1) << FGRAPH_DATA_SHIFT) |
+		(FGRAPH_TYPE_DATA << FGRAPH_TYPE_SHIFT) | offset;
+}
+
 /* ftrace_graph_entry set to this to tell some archs to run function graph */
 static int entry_run(struct ftrace_graph_ent *trace, struct fgraph_ops *ops)
 {
@@ -245,6 +329,91 @@ static void ret_stack_init_task_vars(unsigned long *ret_stack)
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
+	val = make_data_type_val(idx, data_size, __get_offset(val) + data_size + 1);
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
+	return get_data_type_data(current, offset);
+}
+
 /**
  * fgraph_get_task_var - retrieve a task specific state variable
  * @gops: The ftrace_ops that owns the task specific variable
@@ -464,13 +633,18 @@ int function_graph_enter(unsigned long ret, unsigned long func,
 
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
@@ -626,7 +800,8 @@ static unsigned long __ftrace_return_to_handler(struct fgraph_ret_regs *ret_regs
 	 * curr_ret_stack is after that.
 	 */
 	barrier();
-	current->curr_ret_stack -= FGRAPH_FRAME_OFFSET + 1;
+	current->curr_ret_stack = offset - FGRAPH_FRAME_OFFSET;
+
 	current->curr_ret_depth--;
 	return ret;
 }
-- 
2.43.0



