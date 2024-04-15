Return-Path: <bpf+bounces-26808-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 420EF8A50CA
	for <lists+bpf@lfdr.de>; Mon, 15 Apr 2024 15:17:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 646B81C21DB7
	for <lists+bpf@lfdr.de>; Mon, 15 Apr 2024 13:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4433484FBA;
	Mon, 15 Apr 2024 12:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dqf+26KC"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D3A84E01;
	Mon, 15 Apr 2024 12:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713185765; cv=none; b=fLgWoZ7lQBq2eBYGrs+sHv7iJSAHDq536WqxBS0LaZKSFURNdXBjac5W5SGiVCCwm20bwXirUTP1AAWlirFPnO9aFKdggahOj1aK1G7e6owptrcU4UwMPNhAE1u2gwA9yXR+SvzlRusvu2piIBmxBsH/TnolP4CgbWvT7WSfRwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713185765; c=relaxed/simple;
	bh=VKd/+gaLhPLw3tEEcbp2qb7NtBlpK6nxCWOaeYAPuIc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MWD3V+crPX1Js31Evm8bt5fi8LuF03LynT14KqEK1CClqw+3JXKQJpsiLv+kVjZE9xHfXU2sQIwe2hO9zbO93EkqrQlYuXSKXNhbj3u5CyN/1XAEwOeTsM1/GdS0O7Hfk6mOWAGsyXi/+Dd211WW0uEj12hlnfF4yOosS7WuDmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dqf+26KC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA417C2BD10;
	Mon, 15 Apr 2024 12:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713185765;
	bh=VKd/+gaLhPLw3tEEcbp2qb7NtBlpK6nxCWOaeYAPuIc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Dqf+26KCOyAsB6XydMYp2YHS3cW3J24GfNZvPU6YpaT1see/P/yKSz8dhg6qb5XoZ
	 /L6/bWdSY/+toCc2f5EUkkC9+QUHHpJoRTTWCHDjhGh15Rzp0cMdDf/G+211B9nEed
	 lbG6vzIZViOx/l5DuRwoqZYTRUgfIUfllGIS2oGWVkOplqaYzL2Dbmbbg77XQG/02x
	 uBVog52HPxMNwiu5XefM2NRDNaH7NeeG4tdtxvp0F3gG3RnBrYjBKy5C1OFQb+MlHh
	 MZ4JM/zAoRUj/W3LarQk6Yjv/KTvdnWzdEn2X/V8oNT9VvdZ4M9s7RJ/9XsdMl7ylk
	 lRIag62hxFR0Q==
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
Subject: [PATCH v9 36/36] fgraph: Skip recording calltime/rettime if it is not nneeded
Date: Mon, 15 Apr 2024 21:55:59 +0900
Message-Id: <171318575984.254850.17464878774926779209.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <171318533841.254850.15841395205784342850.stgit@devnote2>
References: <171318533841.254850.15841395205784342850.stgit@devnote2>
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
 Changes in v9:
  - Newly added.
---
 include/linux/ftrace.h |    2 ++
 kernel/trace/fgraph.c  |   46 +++++++++++++++++++++++++++++++++++++++-------
 kernel/trace/fprobe.c  |    1 +
 3 files changed, 42 insertions(+), 7 deletions(-)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index d845a80a3d56..06fc7cbef897 100644
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
index 7556fbbae323..a5722537bb79 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -131,6 +131,7 @@ DEFINE_STATIC_KEY_FALSE(kill_ftrace_graph);
 int ftrace_graph_active;
 
 static struct fgraph_ops *fgraph_array[FGRAPH_ARRAY_SIZE];
+static bool fgraph_skip_timestamp;
 
 /* LRU index table for fgraph_array */
 static int fgraph_lru_table[FGRAPH_ARRAY_SIZE];
@@ -475,7 +476,7 @@ void ftrace_graph_stop(void)
 static int
 ftrace_push_return_trace(unsigned long ret, unsigned long func,
 			 unsigned long frame_pointer, unsigned long *retp,
-			 int fgraph_idx)
+			 int fgraph_idx, bool skip_ts)
 {
 	struct ftrace_ret_stack *ret_stack;
 	unsigned long long calltime;
@@ -498,8 +499,12 @@ ftrace_push_return_trace(unsigned long ret, unsigned long func,
 	ret_stack = get_ret_stack(current, current->curr_ret_stack, &index);
 	if (ret_stack && ret_stack->func == func &&
 	    get_fgraph_type(current, index + FGRAPH_RET_INDEX) == FGRAPH_TYPE_BITMAP &&
-	    !is_fgraph_index_set(current, index + FGRAPH_RET_INDEX, fgraph_idx))
+	    !is_fgraph_index_set(current, index + FGRAPH_RET_INDEX, fgraph_idx)) {
+		/* If previous one skips calltime, update it. */
+		if (!skip_ts && !ret_stack->calltime)
+			ret_stack->calltime = trace_clock_local();
 		return index + FGRAPH_RET_INDEX;
+	}
 
 	val = (FGRAPH_TYPE_RESERVED << FGRAPH_TYPE_SHIFT) | FGRAPH_RET_INDEX;
 
@@ -517,7 +522,10 @@ ftrace_push_return_trace(unsigned long ret, unsigned long func,
 		return -EBUSY;
 	}
 
-	calltime = trace_clock_local();
+	if (skip_ts)
+		calltime = 0LL;
+	else
+		calltime = trace_clock_local();
 
 	index = READ_ONCE(current->curr_ret_stack);
 	ret_stack = RET_STACK(current, index);
@@ -601,7 +609,8 @@ int function_graph_enter_regs(unsigned long ret, unsigned long func,
 	trace.func = func;
 	trace.depth = ++current->curr_ret_depth;
 
-	index = ftrace_push_return_trace(ret, func, frame_pointer, retp, 0);
+	index = ftrace_push_return_trace(ret, func, frame_pointer, retp, 0,
+					 fgraph_skip_timestamp);
 	if (index < 0)
 		goto out;
 
@@ -654,7 +663,8 @@ int function_graph_enter_ops(unsigned long ret, unsigned long func,
 		return -ENODEV;
 
 	/* Use start for the distance to ret_stack (skipping over reserve) */
-	index = ftrace_push_return_trace(ret, func, frame_pointer, retp, gops->idx);
+	index = ftrace_push_return_trace(ret, func, frame_pointer, retp, gops->idx,
+					 gops->skip_timestamp);
 	if (index < 0)
 		return index;
 	type = get_fgraph_type(current, index);
@@ -732,6 +742,7 @@ ftrace_pop_return_trace(struct ftrace_graph_ret *trace, unsigned long *ret,
 	*ret = ret_stack->ret;
 	trace->func = ret_stack->func;
 	trace->calltime = ret_stack->calltime;
+	trace->rettime = 0;
 	trace->overrun = atomic_read(&current->trace_overrun);
 	trace->depth = current->curr_ret_depth;
 	/*
@@ -792,7 +803,6 @@ __ftrace_return_to_handler(struct ftrace_regs *fregs, unsigned long frame_pointe
 		return (unsigned long)panic;
 	}
 
-	trace.rettime = trace_clock_local();
 	if (fregs)
 		ftrace_regs_set_instruction_pointer(fregs, ret);
 
@@ -808,6 +818,8 @@ __ftrace_return_to_handler(struct ftrace_regs *fregs, unsigned long frame_pointe
 			continue;
 		if (gops == &fgraph_stub)
 			continue;
+		if (!trace.rettime && !gops->skip_timestamp)
+			trace.rettime = trace_clock_local();
 
 		gops->retfunc(&trace, gops, fregs);
 	}
@@ -1185,6 +1197,24 @@ static void init_task_vars(int idx)
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
@@ -1219,6 +1249,7 @@ int register_ftrace_graph(struct fgraph_ops *gops)
 	gops->idx = i;
 
 	ftrace_graph_active++;
+	update_fgraph_skip_timestamp();
 
 	if (ftrace_graph_active == 1) {
 		register_pm_notifier(&ftrace_suspend_notifier);
@@ -1242,6 +1273,7 @@ int register_ftrace_graph(struct fgraph_ops *gops)
 		fgraph_array[i] = &fgraph_stub;
 		ftrace_graph_active--;
 		fgraph_lru_release_index(i);
+		update_fgraph_skip_timestamp();
 	}
 out:
 	mutex_unlock(&ftrace_lock);
@@ -1265,8 +1297,8 @@ void unregister_ftrace_graph(struct fgraph_ops *gops)
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
 


