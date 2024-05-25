Return-Path: <bpf+bounces-30553-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 302C78CED82
	for <lists+bpf@lfdr.de>; Sat, 25 May 2024 04:37:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A6D21F21BB2
	for <lists+bpf@lfdr.de>; Sat, 25 May 2024 02:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C93634A20;
	Sat, 25 May 2024 02:36:53 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7578C10E6;
	Sat, 25 May 2024 02:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716604613; cv=none; b=r8S2375s8tPVwtaHx63ZYJVPt0bNJNxuxNF12iTRewqJsBW2bBqSrnWA8uEyDJMwp1YpQrdd4KYCyReYd/VYXU2aw5TgJps/wAAJFbB/V6myOMqAo3udkbLT3/M7IDnU8yhUPSOtX8+PRno3isix9jF/7ovlmPuyMHRuFKxbe50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716604613; c=relaxed/simple;
	bh=+NgjiboY+/yj8+PchQqM4NmbYfieco8QkZK+Tnf7LvE=;
	h=Message-ID:Date:From:To:Cc:Subject; b=uSykQwN0f64qAu4dgyTHnJqkRHBY7RID/Zb17YUmtzctvDQzVQIU/x0dIpuYpVNhlxc/cIDCHozztTmv/LXVepyS1vmnMtjSpbJ8zEC/op41Vu8B762z2xrrpjIb58nBHLvtcvauXAqN4y/V1Tuz0qZF750rp27/EwXgteSxTUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D212EC2BBFC;
	Sat, 25 May 2024 02:36:52 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1sAhHx-00000007DHe-1PT8;
	Fri, 24 May 2024 22:37:41 -0400
Message-ID: <20240525023652.903909489@goodmis.org>
User-Agent: quilt/0.68
Date: Fri, 24 May 2024 22:36:52 -0400
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
Subject: [PATCH 00/20] function_graph: Allow multiple users for function graph tracing
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

[
  Resend for some of you as I missed a comma in the Cc and
  quilt died sending this out.
]

This is a continuation of the function graph multi user code.
I wrote a proof of concept back in 2019 of this code[1] and
Masami started cleaning it up. I started from Masami's work v10
that can be found here:

 https://lore.kernel.org/linux-trace-kernel/171509088006.162236.7227326999861366050.stgit@devnote2/

This is *only* the code that allows multiple users of function
graph tracing. This is not the fprobe work that Masami is working
to add on top of it. As Masami took my proof of concept, there
was still several things I disliked about that code. Instead of
having Masami clean it up even more, I decided to take over on just
my code and change it up a bit.

The biggest changes from where Masami left off is mostly renaming more
variables, macros, and function names. I fixed up the current comments
and added more to make the code a bit more understandable.

At the end of the series, I added two patches to optimize the entry
and exit. On entry, there was a loop that iterated the 16 elements
of the fgraph_array[] looking for any that may have a gops registered
to it. It's quite a waste to do that loop if there's only one
registered user. To fix that, I added a fgraph_array_bitmask that has
its bits set that correspond to the elements of the array. Then
a simple for_each_set_bit() is used for the iteration. I do the same
thing at the exit callback of the function where it iterates over the
bits of the bitmap saved on the ret_stack.

I also noticed that Masami added code to handle tail calls in the
unwinder and had that in one of my patches. I took that code out
and made it a separate patch with Masami as the author.

The diff between this and Masami's last update is at the end of this email.

Based on Linus commit: 0eb03c7e8e2a4cc3653eb5eeb2d2001182071215

[1] https://lore.kernel.org/all/20190525031633.811342628@goodmis.org/

Masami Hiramatsu (Google) (3):
      function_graph: Handle tail calls for stack unwinding
      function_graph: Use a simple LRU for fgraph_array index number
      ftrace: Add multiple fgraph storage selftest

Steven Rostedt (Google) (2):
      function_graph: Use for_each_set_bit() in __ftrace_return_to_handler()
      function_graph: Use bitmask to loop on fgraph entry

Steven Rostedt (VMware) (15):
      function_graph: Convert ret_stack to a series of longs
      fgraph: Use BUILD_BUG_ON() to make sure we have structures divisible by long
      function_graph: Add an array structure that will allow multiple callbacks
      function_graph: Allow multiple users to attach to function graph
      function_graph: Remove logic around ftrace_graph_entry and return
      ftrace/function_graph: Pass fgraph_ops to function graph callbacks
      ftrace: Allow function_graph tracer to be enabled in instances
      ftrace: Allow ftrace startup flags to exist without dynamic ftrace
      function_graph: Have the instances use their own ftrace_ops for filtering
      function_graph: Add "task variables" per task for fgraph_ops
      function_graph: Move set_graph_function tests to shadow stack global var
      function_graph: Move graph depth stored data to shadow stack global var
      function_graph: Move graph notrace bit to shadow stack global var
      function_graph: Implement fgraph_reserve_data() and fgraph_retrieve_data()
      function_graph: Add selftest for passing local variables

----
 arch/arm64/kernel/ftrace.c           |  21 +-
 arch/loongarch/kernel/ftrace_dyn.c   |  15 +-
 arch/powerpc/kernel/trace/ftrace.c   |   3 +-
 arch/riscv/kernel/ftrace.c           |  15 +-
 arch/x86/kernel/ftrace.c             |  19 +-
 include/linux/ftrace.h               |  42 +-
 include/linux/sched.h                |   2 +-
 include/linux/trace_recursion.h      |  39 --
 kernel/trace/fgraph.c                | 994 ++++++++++++++++++++++++++++-------
 kernel/trace/ftrace.c                |  11 +-
 kernel/trace/ftrace_internal.h       |   2 -
 kernel/trace/trace.h                 |  94 +++-
 kernel/trace/trace_functions.c       |   8 +
 kernel/trace/trace_functions_graph.c |  96 ++--
 kernel/trace/trace_irqsoff.c         |  10 +-
 kernel/trace/trace_sched_wakeup.c    |  10 +-
 kernel/trace/trace_selftest.c        | 259 ++++++++-
 17 files changed, 1330 insertions(+), 310 deletions(-)


diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index 3313e4b83aa2..1aae521e5997 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -18,29 +18,36 @@
 #include "ftrace_internal.h"
 #include "trace.h"
 
-#define FGRAPH_FRAME_SIZE sizeof(struct ftrace_ret_stack)
-#define FGRAPH_FRAME_OFFSET DIV_ROUND_UP(FGRAPH_FRAME_SIZE, sizeof(long))
 
 /*
- * On entry to a function (via function_graph_enter()), a new ftrace_ret_stack
- * is allocated on the task's ret_stack with bitmap entry, then each
- * fgraph_ops on the fgraph_array[]'s entryfunc is called and if that returns
- * non-zero, the index into the fgraph_array[] for that fgraph_ops is recorded
- * on the bitmap entry as a bit flag.
- *
- * The top of the ret_stack (when not empty) will always have a reference
- * to the last ftrace_ret_stack saved. All references to the
- * ftrace_ret_stack has the format of:
+ * FGRAPH_FRAME_SIZE:	Size in bytes of the meta data on the shadow stack
+ * FGRAPH_FRAME_OFFSET:	Size in long words of the meta data frame
+ */
+#define FGRAPH_FRAME_SIZE	sizeof(struct ftrace_ret_stack)
+#define FGRAPH_FRAME_OFFSET	DIV_ROUND_UP(FGRAPH_FRAME_SIZE, sizeof(long))
+
+/*
+ * On entry to a function (via function_graph_enter()), a new fgraph frame
+ * (ftrace_ret_stack) is pushed onto the stack as well as a word that
+ * holds a bitmask and a type (called "bitmap"). The bitmap is defined as:
  *
  * bits:  0 -  9	offset in words from the previous ftrace_ret_stack
- *			(bitmap type should have FGRAPH_FRAME_OFFSET always)
+ *
  * bits: 10 - 11	Type of storage
  *			  0 - reserved
  *			  1 - bitmap of fgraph_array index
  *			  2 - reserved data
  *
- * For bitmap of fgraph_array index
+ * For type with "bitmap of fgraph_array index" (FGRAPH_TYPE_BITMAP):
  *  bits: 12 - 27	The bitmap of fgraph_ops fgraph_array index
+ *			That is, it's a bitmask of 0-15 (16 bits)
+ *			where if a corresponding ops in the fgraph_array[]
+ *			expects a callback from the return of the function
+ *			it's corresponding bit will be set.
+ *
+ *
+ * The top of the ret_stack (when not empty) will always have a reference
+ * word that points to the last fgraph frame that was saved.
  *
  * For reserved data:
  *  bits: 12 - 17	The size in words that is stored
@@ -52,7 +59,7 @@
  * stored two words of data, this is what will be on the task's shadow
  * ret_stack: (the stack grows upward)
  *
- *  ret_stack[SHADOW_STACK_IN_WORD]
+ *  ret_stack[SHADOW_STACK_OFFSET]
  * | SHADOW_STACK_TASK_VARS(ret_stack)[15]      |
  * ...
  * | SHADOW_STACK_TASK_VARS(ret_stack)[0]       |
@@ -60,6 +67,8 @@
  * ...
  * |                                            | <- task->curr_ret_stack
  * +--------------------------------------------+
+ * | (3 << 12) | (3 << 10) | FGRAPH_FRAME_OFFSET|
+ * |         *or put another way*               |
  * | (3 << FGRAPH_DATA_INDEX_SHIFT)| \          | This is for fgraph_ops[3].
  * | ((2 - 1) << FGRAPH_DATA_SHIFT)| \          | The data size is 2 words.
  * | (FGRAPH_TYPE_DATA << FGRAPH_TYPE_SHIFT)| \ |
@@ -67,7 +76,9 @@
  * +--------------------------------------------+ ( It is 4 words from the ret_stack)
  * |            STORED DATA WORD 2              |
  * |            STORED DATA WORD 1              |
- * +------i-------------------------------------+
+ * +--------------------------------------------+
+ * | (9 << 12) | (1 << 10) | FGRAPH_FRAME_OFFSET|
+ * |         *or put another way*               |
  * | (BIT(3)|BIT(0)) << FGRAPH_INDEX_SHIFT | \  |
  * | FGRAPH_TYPE_BITMAP << FGRAPH_TYPE_SHIFT| \ |
  * | (offset1:FGRAPH_FRAME_OFFSET)              | <- the offset1 is from here
@@ -82,17 +93,24 @@
  *
  * If a backtrace is required, and the real return pointer needs to be
  * fetched, then it looks at the task's curr_ret_stack offset, if it
- * is greater than zero (reserved, or right before poped), it would mask
+ * is greater than zero (reserved, or right before popped), it would mask
  * the value by FGRAPH_FRAME_OFFSET_MASK to get the offset of the
  * ftrace_ret_stack structure stored on the shadow stack.
  */
 
-#define FGRAPH_FRAME_OFFSET_SIZE	10
-#define FGRAPH_FRAME_OFFSET_MASK	GENMASK(FGRAPH_FRAME_OFFSET_SIZE - 1, 0)
+/*
+ * The following is for the top word on the stack:
+ *
+ *   FGRAPH_FRAME_OFFSET (0-9) holds the offset delta to the fgraph frame
+ *   FGRAPH_TYPE (10-11) holds the type of word this is.
+ *     (RESERVED or BITMAP)
+ */
+#define FGRAPH_FRAME_OFFSET_BITS	10
+#define FGRAPH_FRAME_OFFSET_MASK	GENMASK(FGRAPH_FRAME_OFFSET_BITS - 1, 0)
 
-#define FGRAPH_TYPE_SIZE	2
-#define FGRAPH_TYPE_MASK	GENMASK(FGRAPH_TYPE_SIZE - 1, 0)
-#define FGRAPH_TYPE_SHIFT	FGRAPH_FRAME_OFFSET_SIZE
+#define FGRAPH_TYPE_BITS	2
+#define FGRAPH_TYPE_MASK	GENMASK(FGRAPH_TYPE_BITS - 1, 0)
+#define FGRAPH_TYPE_SHIFT	FGRAPH_FRAME_OFFSET_BITS
 
 enum {
 	FGRAPH_TYPE_RESERVED	= 0,
@@ -100,31 +118,48 @@ enum {
 	FGRAPH_TYPE_DATA	= 2,
 };
 
-#define FGRAPH_INDEX_SIZE	16
-#define FGRAPH_INDEX_MASK	GENMASK(FGRAPH_INDEX_SIZE - 1, 0)
-#define FGRAPH_INDEX_SHIFT	(FGRAPH_TYPE_SHIFT + FGRAPH_TYPE_SIZE)
+/*
+ * For BITMAP type:
+ *   FGRAPH_INDEX (12-27) bits holding the gops index wanting return callback called
+ */
+#define FGRAPH_INDEX_BITS	16
+#define FGRAPH_INDEX_MASK	GENMASK(FGRAPH_INDEX_BITS - 1, 0)
+#define FGRAPH_INDEX_SHIFT	(FGRAPH_TYPE_SHIFT + FGRAPH_TYPE_BITS)
 
-/* The data size == 0 means 1 word, and 31 (=2^5 - 1) means 32 words. */
-#define FGRAPH_DATA_SIZE	5
-#define FGRAPH_DATA_MASK	GENMASK(FGRAPH_DATA_SIZE - 1, 0)
-#define FGRAPH_DATA_SHIFT	(FGRAPH_TYPE_SHIFT + FGRAPH_TYPE_SIZE)
-#define FGRAPH_MAX_DATA_SIZE (sizeof(long) * (1 << FGRAPH_DATA_SIZE))
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
 
-#define FGRAPH_DATA_INDEX_SIZE	4
-#define FGRAPH_DATA_INDEX_MASK	GENMASK(FGRAPH_DATA_INDEX_SIZE - 1, 0)
-#define FGRAPH_DATA_INDEX_SHIFT	(FGRAPH_DATA_SHIFT + FGRAPH_DATA_SIZE)
+#define FGRAPH_DATA_INDEX_BITS	4
+#define FGRAPH_DATA_INDEX_MASK	GENMASK(FGRAPH_DATA_INDEX_BITS - 1, 0)
+#define FGRAPH_DATA_INDEX_SHIFT	(FGRAPH_DATA_SHIFT + FGRAPH_DATA_BITS)
 
 #define FGRAPH_MAX_INDEX	\
-	((FGRAPH_INDEX_SIZE << FGRAPH_DATA_SIZE) + FGRAPH_RET_INDEX)
+	((FGRAPH_INDEX_SIZE << FGRAPH_DATA_BITS) + FGRAPH_RET_INDEX)
 
-#define FGRAPH_ARRAY_SIZE	FGRAPH_INDEX_SIZE
+#define FGRAPH_ARRAY_SIZE	FGRAPH_INDEX_BITS
 
-#define SHADOW_STACK_SIZE (PAGE_SIZE)
-#define SHADOW_STACK_IN_WORD (SHADOW_STACK_SIZE / sizeof(long))
+/*
+ * SHADOW_STACK_SIZE:	The size in bytes of the entire shadow stack
+ * SHADOW_STACK_OFFSET:	The size in long words of the shadow stack
+ * SHADOW_STACK_MAX_OFFSET: The max offset of the stack for a new frame to be added
+ */
+#define SHADOW_STACK_SIZE	(PAGE_SIZE)
+#define SHADOW_STACK_OFFSET	(SHADOW_STACK_SIZE / sizeof(long))
 /* Leave on a buffer at the end */
 #define SHADOW_STACK_MAX_OFFSET				\
-	(SHADOW_STACK_IN_WORD - (FGRAPH_FRAME_OFFSET + 1 + FGRAPH_ARRAY_SIZE))
+	(SHADOW_STACK_OFFSET - (FGRAPH_FRAME_OFFSET + 1 + FGRAPH_ARRAY_SIZE))
 
+/* RET_STACK():		Return the frame from a given @offset from task @t */
 #define RET_STACK(t, offset) ((struct ftrace_ret_stack *)(&(t)->ret_stack[offset]))
 
 /*
@@ -132,12 +167,13 @@ enum {
  * ret_stack to store task specific state.
  */
 #define SHADOW_STACK_TASK_VARS(ret_stack) \
-	((unsigned long *)(&(ret_stack)[SHADOW_STACK_IN_WORD - FGRAPH_ARRAY_SIZE]))
+	((unsigned long *)(&(ret_stack)[SHADOW_STACK_OFFSET - FGRAPH_ARRAY_SIZE]))
 
 DEFINE_STATIC_KEY_FALSE(kill_ftrace_graph);
 int ftrace_graph_active;
 
 static struct fgraph_ops *fgraph_array[FGRAPH_ARRAY_SIZE];
+static unsigned long fgraph_array_bitmask;
 
 /* LRU index table for fgraph_array */
 static int fgraph_lru_table[FGRAPH_ARRAY_SIZE];
@@ -162,6 +198,8 @@ static int fgraph_lru_release_index(int idx)
 
 	fgraph_lru_table[fgraph_lru_last] = idx;
 	fgraph_lru_last = (fgraph_lru_last + 1) % FGRAPH_ARRAY_SIZE;
+
+	clear_bit(idx, &fgraph_array_bitmask);
 	return 0;
 }
 
@@ -176,70 +214,77 @@ static int fgraph_lru_alloc_index(void)
 
 	fgraph_lru_table[fgraph_lru_next] = -1;
 	fgraph_lru_next = (fgraph_lru_next + 1) % FGRAPH_ARRAY_SIZE;
+
+	set_bit(idx, &fgraph_array_bitmask);
 	return idx;
 }
 
+/* Get the offset to the fgraph frame from a ret_stack value */
 static inline int __get_offset(unsigned long val)
 {
 	return val & FGRAPH_FRAME_OFFSET_MASK;
 }
 
+/* Get the type of word from a ret_stack value */
 static inline int __get_type(unsigned long val)
 {
 	return (val >> FGRAPH_TYPE_SHIFT) & FGRAPH_TYPE_MASK;
 }
 
+/* Get the data_index for a DATA type ret_stack word */
 static inline int __get_data_index(unsigned long val)
 {
 	return (val >> FGRAPH_DATA_INDEX_SHIFT) & FGRAPH_DATA_INDEX_MASK;
 }
 
+/* Get the data_size for a DATA type ret_stack word */
 static inline int __get_data_size(unsigned long val)
 {
 	return ((val >> FGRAPH_DATA_SHIFT) & FGRAPH_DATA_MASK) + 1;
 }
 
+/* Get the word from the ret_stack at @offset */
 static inline unsigned long get_fgraph_entry(struct task_struct *t, int offset)
 {
 	return t->ret_stack[offset];
 }
 
+/* Get the FRAME_OFFSET from the word from the @offset on ret_stack */
 static inline int get_frame_offset(struct task_struct *t, int offset)
 {
 	return __get_offset(t->ret_stack[offset]);
 }
 
+/* Get FGRAPH_TYPE from the word from the @offset at ret_stack */
 static inline int get_fgraph_type(struct task_struct *t, int offset)
 {
 	return __get_type(t->ret_stack[offset]);
 }
 
+/* For BITMAP type: get the bitmask from the @offset at ret_stack */
 static inline unsigned long
-get_fgraph_index_bitmap(struct task_struct *t, int offset)
+get_bitmap_bits(struct task_struct *t, int offset)
 {
 	return (t->ret_stack[offset] >> FGRAPH_INDEX_SHIFT) & FGRAPH_INDEX_MASK;
 }
 
+/* For BITMAP type: set the bits in the bitmap bitmask at @offset on ret_stack */
 static inline void
-set_fgraph_index_bitmap(struct task_struct *t, int offset, unsigned long bitmap)
-{
-	t->ret_stack[offset] = (bitmap << FGRAPH_INDEX_SHIFT) |
-		(FGRAPH_TYPE_BITMAP << FGRAPH_TYPE_SHIFT) | FGRAPH_FRAME_OFFSET;
-}
-
-static inline bool is_fgraph_index_set(struct task_struct *t, int offset, int idx)
+set_bitmap_bits(struct task_struct *t, int offset, unsigned long bitmap)
 {
-	return !!(get_fgraph_index_bitmap(t, offset) & BIT(idx));
+	t->ret_stack[offset] |= (bitmap << FGRAPH_INDEX_SHIFT);
 }
 
+/* Write the bitmap to the ret_stack at @offset (does index, offset and bitmask) */
 static inline void
-add_fgraph_index_bitmap(struct task_struct *t, int offset, unsigned long bitmap)
+set_bitmap(struct task_struct *t, int offset, unsigned long bitmap)
 {
-	t->ret_stack[offset] |= (bitmap << FGRAPH_INDEX_SHIFT);
+	t->ret_stack[offset] = (bitmap << FGRAPH_INDEX_SHIFT) |
+		(FGRAPH_TYPE_BITMAP << FGRAPH_TYPE_SHIFT) | FGRAPH_FRAME_OFFSET;
 }
 
-/* Note: @offset is the offset of FGRAPH_TYPE_DATA entry. */
-static inline void *get_fgraph_data(struct task_struct *t, int offset)
+/* For DATA type: get the data saved under the ret_stack word at @offset */
+static inline void *get_data_type_data(struct task_struct *t, int offset)
 {
 	unsigned long val = t->ret_stack[offset];
 
@@ -249,7 +294,8 @@ static inline void *get_fgraph_data(struct task_struct *t, int offset)
 	return (void *)&t->ret_stack[offset];
 }
 
-static inline unsigned long make_fgraph_data(int idx, int size, int offset)
+/* Create the ret_stack word for a DATA type */
+static inline unsigned long make_data_type_val(int idx, int size, int offset)
 {
 	return (idx << FGRAPH_DATA_INDEX_SHIFT) |
 		((size - 1) << FGRAPH_DATA_SHIFT) |
@@ -326,7 +372,7 @@ void *fgraph_reserve_data(int idx, int size_bytes)
 	if (unlikely(curr_ret_stack >= SHADOW_STACK_MAX_OFFSET))
 		return NULL;
 
-	val = make_fgraph_data(idx, data_size, __get_offset(val) + data_size + 1);
+	val = make_data_type_val(idx, data_size, __get_offset(val) + data_size + 1);
 
 	/* Set the last word to be reserved */
 	current->ret_stack[curr_ret_stack - 1] = val;
@@ -371,7 +417,7 @@ void *fgraph_retrieve_data(int idx, int *size_bytes)
 found:
 	if (size_bytes)
 		*size_bytes = __get_data_size(val) * sizeof(long);
-	return get_fgraph_data(current, offset);
+	return get_data_type_data(current, offset);
 }
 
 /**
@@ -394,6 +440,9 @@ unsigned long *fgraph_get_task_var(struct fgraph_ops *gops)
  * @offset: The offset into @t->ret_stack to find the ret_stack entry
  * @frame_offset: Where to place the offset into @t->ret_stack of that entry
  *
+ * Returns a pointer to the previous ret_stack below @offset or NULL
+ *   when it reaches the bottom of the stack.
+ *
  * Calling this with:
  *
  *   offset = task->curr_ret_stack;
@@ -493,30 +542,21 @@ ftrace_push_return_trace(unsigned long ret, unsigned long func,
 	if (!current->ret_stack)
 		return -EBUSY;
 
-	/*
-	 * At first, check whether the previous fgraph callback is pushed by
-	 * the fgraph on the same function entry.
-	 * But if @func is the self tail-call function, we also need to ensure
-	 * the ret_stack is not for the previous call by checking whether the
-	 * bit of @fgraph_idx is set or not.
-	 */
-	ret_stack = get_ret_stack(current, current->curr_ret_stack, &offset);
-	if (ret_stack && ret_stack->func == func &&
-	    get_fgraph_type(current, offset + FGRAPH_FRAME_OFFSET) == FGRAPH_TYPE_BITMAP &&
-	    !is_fgraph_index_set(current, offset + FGRAPH_FRAME_OFFSET, fgraph_idx))
-		return offset + FGRAPH_FRAME_OFFSET;
+	BUILD_BUG_ON(SHADOW_STACK_SIZE % sizeof(long));
 
+	/* Set val to "reserved" with the delta to the new fgraph frame */
 	val = (FGRAPH_TYPE_RESERVED << FGRAPH_TYPE_SHIFT) | FGRAPH_FRAME_OFFSET;
 
-	BUILD_BUG_ON(SHADOW_STACK_SIZE % sizeof(long));
-
 	/*
 	 * We must make sure the ret_stack is tested before we read
 	 * anything else.
 	 */
 	smp_rmb();
 
-	/* The return trace stack is full */
+	/*
+	 * Check if there's room on the shadow stack to fit a fraph frame
+	 * and a bitmap word.
+	 */
 	if (current->curr_ret_stack + FGRAPH_FRAME_OFFSET + 1 >= SHADOW_STACK_MAX_OFFSET) {
 		atomic_inc(&current->trace_overrun);
 		return -EBUSY;
@@ -545,7 +585,7 @@ ftrace_push_return_trace(unsigned long ret, unsigned long func,
 	 * at least a correct offset!
 	 */
 	barrier();
-	current->curr_ret_stack = offset + 1;
+	WRITE_ONCE(current->curr_ret_stack, offset + 1);
 	/*
 	 * This next barrier is to ensure that an interrupt coming in
 	 * will not corrupt what we are about to write.
@@ -597,7 +637,8 @@ int function_graph_enter(unsigned long ret, unsigned long func,
 	if (offset < 0)
 		goto out;
 
-	for (i = 0; i < FGRAPH_ARRAY_SIZE; i++) {
+	for_each_set_bit(i, &fgraph_array_bitmask,
+			 sizeof(fgraph_array_bitmask) * BITS_PER_BYTE) {
 		struct fgraph_ops *gops = fgraph_array[i];
 		int save_curr_ret_stack;
 
@@ -620,7 +661,7 @@ int function_graph_enter(unsigned long ret, unsigned long func,
 	 * Since this function uses fgraph_idx = 0 as a tail-call checking
 	 * flag, set that bit always.
 	 */
-	set_fgraph_index_bitmap(current, offset, bitmap | BIT(0));
+	set_bitmap(current, offset, bitmap | BIT(0));
 
 	return 0;
  out_ret:
@@ -659,9 +700,9 @@ int function_graph_enter_ops(unsigned long ret, unsigned long func,
 	save_curr_ret_stack = current->curr_ret_stack;
 	if (gops->entryfunc(&trace, gops)) {
 		if (type == FGRAPH_TYPE_RESERVED)
-			set_fgraph_index_bitmap(current, offset, BIT(gops->idx));
+			set_bitmap(current, offset, BIT(gops->idx));
 		else
-			add_fgraph_index_bitmap(current, offset, BIT(gops->idx));
+			set_bitmap_bits(current, offset, BIT(gops->idx));
 		return 0;
 	} else
 		current->curr_ret_stack = save_curr_ret_stack;
@@ -791,12 +832,11 @@ static unsigned long __ftrace_return_to_handler(struct fgraph_ret_regs *ret_regs
 	trace.retval = fgraph_ret_regs_return_value(ret_regs);
 #endif
 
-	bitmap = get_fgraph_index_bitmap(current, offset);
-	for (i = 0; i < FGRAPH_ARRAY_SIZE; i++) {
+	bitmap = get_bitmap_bits(current, offset);
+
+	for_each_set_bit(i, &bitmap, sizeof(bitmap) * BITS_PER_BYTE) {
 		struct fgraph_ops *gops = fgraph_array[i];
 
-		if (!(bitmap & BIT(i)))
-			continue;
 		if (gops == &fgraph_stub)
 			continue;
 
@@ -879,9 +919,10 @@ unsigned long ftrace_graph_ret_addr(struct task_struct *task, int *idx,
 				    unsigned long ret, unsigned long *retp)
 {
 	struct ftrace_ret_stack *ret_stack;
+	unsigned long return_handler = (unsigned long)dereference_kernel_function_descriptor(return_to_handler);
 	int i = task->curr_ret_stack;
 
-	if (ret != (unsigned long)dereference_kernel_function_descriptor(return_to_handler))
+	if (ret != return_handler)
 		return ret;
 
 	while (i > 0) {
@@ -891,14 +932,13 @@ unsigned long ftrace_graph_ret_addr(struct task_struct *task, int *idx,
 		/*
 		 * For the tail-call, there would be 2 or more ftrace_ret_stacks on
 		 * the ret_stack, which records "return_to_handler" as the return
-		 * address excpt for the last one.
+		 * address except for the last one.
 		 * But on the real stack, there should be 1 entry because tail-call
 		 * reuses the return address on the stack and jump to the next function.
 		 * Thus we will continue to find real return address.
 		 */
 		if (ret_stack->retp == retp &&
-		    ret_stack->ret !=
-		    (unsigned long)dereference_kernel_function_descriptor(return_to_handler))
+		    ret_stack->ret != return_handler)
 			return ret_stack->ret;
 	}
 
@@ -909,10 +949,11 @@ unsigned long ftrace_graph_ret_addr(struct task_struct *task, int *idx,
 				    unsigned long ret, unsigned long *retp)
 {
 	struct ftrace_ret_stack *ret_stack;
+	unsigned long return_handler = (unsigned long)dereference_kernel_function_descriptor(return_to_handler);
 	int offset = task->curr_ret_stack;
 	int i;
 
-	if (ret != (unsigned long)dereference_kernel_function_descriptor(return_to_handler))
+	if (ret != return_handler)
 		return ret;
 
 	if (!idx)
@@ -921,8 +962,7 @@ unsigned long ftrace_graph_ret_addr(struct task_struct *task, int *idx,
 	i = *idx;
 	do {
 		ret_stack = get_ret_stack(task, offset, &offset);
-		if (ret_stack && ret_stack->ret ==
-		    (unsigned long)dereference_kernel_function_descriptor(return_to_handler))
+		if (ret_stack && ret_stack->ret == return_handler)
 			continue;
 		i--;
 	} while (i >= 0 && ret_stack);

