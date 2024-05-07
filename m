Return-Path: <bpf+bounces-28873-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 397268BE5B0
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 16:22:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 555DD1C23FAB
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 14:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8123216C6AA;
	Tue,  7 May 2024 14:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="scBCwpI+"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0149D1607AB;
	Tue,  7 May 2024 14:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715091310; cv=none; b=RM73hkEzDdejuQfn3JTRzRIeo6+HvQjasBC6W6+JykZ+z3UwKR7Ws/Rpmh/Rfdfc1hgb/uxUBTVShaCCFLlLy9GqTXID/OuHiFU7+1bTpJXkM10xVdPKN9Da6i0tVbqjMFnahImL8mkdGsvbh4SBbwy+WHJQlPzn901Ferc/KS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715091310; c=relaxed/simple;
	bh=qz9bUI0E+avzydjRe5h6w3UDaf44DOCWwgWc2tfDYyI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qrdUaF2yDjCVbb7nz3OfFK+voxljiDDf5IMTj1CDebn2pEzCg5EN6tjYT6WysT8YawFisoPhGVDF1XCmAd4aRco0/9e5R0eH/gbnRYmBwy7w3w4XFp2IFAnZ7QPMSa0tevigBsYjv/OxYtQYepRgxsNppDV97Ae8/sH8ayNNnHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=scBCwpI+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EF06C2BBFC;
	Tue,  7 May 2024 14:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715091309;
	bh=qz9bUI0E+avzydjRe5h6w3UDaf44DOCWwgWc2tfDYyI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=scBCwpI++kfSsaSK9E+iTNPa3Gn4Kpn7ej+TCsJq9/tvveZnHzDfK4ZdjVpc7TCbs
	 npyUH8SXX+ysW7F18FoSNddiDpTlv86V9nOo+tD4UHZduDuX7vEut+K31++p/Ygi1U
	 /ctNctmqffokczLd7vFi00arorqWT8QYVk/XWTHYe3wY0lAPtALVw6B6XQJvHFdkrJ
	 ZUV4BMK25UOQ/EHs1wvjZ3oYdP52Cx5uxUYNN0z46rnVCVYsgYwGuSLPvlZ9cge6Cw
	 YIsEs2ZSLiPqF0hIoJmgK07+3aaQH1eUK4jmGfJvgfjjYgOGN0bsNweRxA6vpzSI6t
	 ByLq9Ng5RgvUw==
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
Subject: [PATCH v10 36/36] fgraph: Skip recording calltime/rettime if it is not nneeded
Date: Tue,  7 May 2024 23:15:02 +0900
Message-Id: <171509130284.162236.12400830886224359503.stgit@devnote2>
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

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Skip recording calltime and rettime if the fgraph_ops does not need it.
This is a kind of performance optimization for fprobe. Since the fprobe
user does not use these entries, recording timestamp in fgraph is just
a overhead (e.g. eBPF, ftrace). So introduce the skip_timestamp flag,
and all fgraph_ops sets this flag, skip recording calltime and rettime.

Suggested-by: Jiri Olsa <olsajiri@gmail.com>
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 Changes in v10:
  - Add likely() to skipping timestamp.
 Changes in v9:
  - Newly added.
---
 include/linux/ftrace.h |    2 ++
 kernel/trace/fgraph.c  |   51 +++++++++++++++++++++++++++++++++++++++++-------
 kernel/trace/fprobe.c  |    1 +
 3 files changed, 47 insertions(+), 7 deletions(-)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 64ca91d1527f..eb9de9d70829 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -1156,6 +1156,8 @@ struct fgraph_ops {
 	struct ftrace_ops		ops; /* for the hash lists */
 	void				*private;
 	int				idx;
+	/* If skip_timestamp is true, this does not record timestamps. */
+	bool				skip_timestamp;
 };
 
 void *fgraph_reserve_data(int idx, int size_bytes);
diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index 40f47fcbc6c3..13b41485ce49 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -138,6 +138,7 @@ DEFINE_STATIC_KEY_FALSE(kill_ftrace_graph);
 int ftrace_graph_active;
 
 static struct fgraph_ops *fgraph_array[FGRAPH_ARRAY_SIZE];
+static bool fgraph_skip_timestamp;
 
 /* LRU index table for fgraph_array */
 static int fgraph_lru_table[FGRAPH_ARRAY_SIZE];
@@ -483,7 +484,7 @@ void ftrace_graph_stop(void)
 static int
 ftrace_push_return_trace(unsigned long ret, unsigned long func,
 			 unsigned long frame_pointer, unsigned long *retp,
-			 int fgraph_idx)
+			 int fgraph_idx, bool skip_ts)
 {
 	struct ftrace_ret_stack *ret_stack;
 	unsigned long long calltime;
@@ -506,8 +507,12 @@ ftrace_push_return_trace(unsigned long ret, unsigned long func,
 	ret_stack = get_ret_stack(current, current->curr_ret_stack, &offset);
 	if (ret_stack && ret_stack->func == func &&
 	    get_fgraph_type(current, offset + FGRAPH_FRAME_OFFSET) == FGRAPH_TYPE_BITMAP &&
-	    !is_fgraph_index_set(current, offset + FGRAPH_FRAME_OFFSET, fgraph_idx))
+	    !is_fgraph_index_set(current, offset + FGRAPH_FRAME_OFFSET, fgraph_idx)) {
+		/* If previous one skips calltime, update it. */
+		if (!skip_ts && !ret_stack->calltime)
+			ret_stack->calltime = trace_clock_local();
 		return offset + FGRAPH_FRAME_OFFSET;
+	}
 
 	val = (FGRAPH_TYPE_RESERVED << FGRAPH_TYPE_SHIFT) | FGRAPH_FRAME_OFFSET;
 
@@ -525,7 +530,11 @@ ftrace_push_return_trace(unsigned long ret, unsigned long func,
 		return -EBUSY;
 	}
 
-	calltime = trace_clock_local();
+	/* This is not really 'likely' but for keeping the least path to be faster. */
+	if (likely(skip_ts))
+		calltime = 0LL;
+	else
+		calltime = trace_clock_local();
 
 	offset = READ_ONCE(current->curr_ret_stack);
 	ret_stack = RET_STACK(current, offset);
@@ -609,7 +618,8 @@ int function_graph_enter_regs(unsigned long ret, unsigned long func,
 	trace.func = func;
 	trace.depth = ++current->curr_ret_depth;
 
-	offset = ftrace_push_return_trace(ret, func, frame_pointer, retp, 0);
+	offset = ftrace_push_return_trace(ret, func, frame_pointer, retp, 0,
+					  fgraph_skip_timestamp);
 	if (offset < 0)
 		goto out;
 
@@ -662,7 +672,8 @@ int function_graph_enter_ops(unsigned long ret, unsigned long func,
 		return -ENODEV;
 
 	/* Use start for the distance to ret_stack (skipping over reserve) */
-	offset = ftrace_push_return_trace(ret, func, frame_pointer, retp, gops->idx);
+	offset = ftrace_push_return_trace(ret, func, frame_pointer, retp, gops->idx,
+					  gops->skip_timestamp);
 	if (offset < 0)
 		return offset;
 	type = get_fgraph_type(current, offset);
@@ -740,6 +751,7 @@ ftrace_pop_return_trace(struct ftrace_graph_ret *trace, unsigned long *ret,
 	*ret = ret_stack->ret;
 	trace->func = ret_stack->func;
 	trace->calltime = ret_stack->calltime;
+	trace->rettime = 0;
 	trace->overrun = atomic_read(&current->trace_overrun);
 	trace->depth = current->curr_ret_depth;
 	/*
@@ -800,7 +812,6 @@ __ftrace_return_to_handler(struct ftrace_regs *fregs, unsigned long frame_pointe
 		return (unsigned long)panic;
 	}
 
-	trace.rettime = trace_clock_local();
 	if (fregs)
 		ftrace_regs_set_instruction_pointer(fregs, ret);
 
@@ -816,6 +827,12 @@ __ftrace_return_to_handler(struct ftrace_regs *fregs, unsigned long frame_pointe
 			continue;
 		if (gops == &fgraph_stub)
 			continue;
+		/*
+		 * This is not really 'unlikely' but for keeping the least path
+		 * to be faster.
+		 */
+		if (unlikely(!trace.rettime && !gops->skip_timestamp))
+			trace.rettime = trace_clock_local();
 
 		gops->retfunc(&trace, gops, fregs);
 	}
@@ -1193,6 +1210,24 @@ static void init_task_vars(int idx)
 	read_unlock(&tasklist_lock);
 }
 
+static void update_fgraph_skip_timestamp(void)
+{
+	int i;
+
+	for (i = 0; i < FGRAPH_ARRAY_SIZE; i++) {
+		struct fgraph_ops *gops = fgraph_array[i];
+
+		if (gops == &fgraph_stub)
+			continue;
+
+		if (!gops->skip_timestamp) {
+			fgraph_skip_timestamp = false;
+			return;
+		}
+	}
+	fgraph_skip_timestamp = true;
+}
+
 int register_ftrace_graph(struct fgraph_ops *gops)
 {
 	int command = 0;
@@ -1227,6 +1262,7 @@ int register_ftrace_graph(struct fgraph_ops *gops)
 	gops->idx = i;
 
 	ftrace_graph_active++;
+	update_fgraph_skip_timestamp();
 
 	if (ftrace_graph_active == 1) {
 		register_pm_notifier(&ftrace_suspend_notifier);
@@ -1250,6 +1286,7 @@ int register_ftrace_graph(struct fgraph_ops *gops)
 		fgraph_array[i] = &fgraph_stub;
 		ftrace_graph_active--;
 		fgraph_lru_release_index(i);
+		update_fgraph_skip_timestamp();
 	}
 out:
 	mutex_unlock(&ftrace_lock);
@@ -1273,8 +1310,8 @@ void unregister_ftrace_graph(struct fgraph_ops *gops)
 		goto out;
 
 	fgraph_array[gops->idx] = &fgraph_stub;
-
 	ftrace_graph_active--;
+	update_fgraph_skip_timestamp();
 
 	if (!ftrace_graph_active)
 		command = FTRACE_STOP_FUNC_RET;
diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
index afa52d9816cf..24bb8edec8a3 100644
--- a/kernel/trace/fprobe.c
+++ b/kernel/trace/fprobe.c
@@ -345,6 +345,7 @@ NOKPROBE_SYMBOL(fprobe_return);
 static struct fgraph_ops fprobe_graph_ops = {
 	.entryfunc	= fprobe_entry,
 	.retfunc	= fprobe_return,
+	.skip_timestamp = true,
 };
 static int fprobe_graph_active;
 


