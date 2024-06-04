Return-Path: <bpf+bounces-31325-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DF5E08FB5F6
	for <lists+bpf@lfdr.de>; Tue,  4 Jun 2024 16:46:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3C96B28C0B
	for <lists+bpf@lfdr.de>; Tue,  4 Jun 2024 14:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBCB4149DE5;
	Tue,  4 Jun 2024 14:42:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F63D149C53;
	Tue,  4 Jun 2024 14:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717512137; cv=none; b=dBxTiaOD4/8r2qWMdwTG1MDjlPnEJNDFblklV7+EDKNvwF7X+F+2mY4UAOb2wLg6ohKT/VhL37fXfF6AWnvhx+36yBHYt5DrocFKLF5r9XF4mDKrGNIiEySk+f1uvCYSpilfxZ+YH3F5DWjfwa35lKnkdv9Ucx5xGcTonkgjSwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717512137; c=relaxed/simple;
	bh=VOkBqN9ssCbZLRIMRmxIeUPZHCFegRpzd3sUILCk0QY=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=UObFSXCot2IOd60yQIomsrzPnhmPd+e3A3ZwZWQ97Af00PHe6G+RkdP7bBinn4O9ZC9x00k2+GFx1sDkiCF9xZeiuhWGbL66cUzDNj6qb+XJZo5+jXHAXActklMl83cJ5EnsWkPcawUBfxs5Bydc+On6xIaJzRaBdudcAAKWDrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68E95C32786;
	Tue,  4 Jun 2024 14:42:17 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1sEVMe-00000000Z1W-3ZuE;
	Tue, 04 Jun 2024 10:42:16 -0400
Message-ID: <20240604144216.712787030@goodmis.org>
User-Agent: quilt/0.68
Date: Tue, 04 Jun 2024 10:41:20 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
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
Subject: [for-next][PATCH 17/27] function_graph: Move graph depth stored data to shadow stack global
 var
References: <20240604144103.293353991@goodmis.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

The use of the task->trace_recursion for the logic used for the function
graph depth was a bit of an abuse of that variable. Now that there
exists global vars that are per stack for registered graph traces, use that
instead.

Link: https://lore.kernel.org/linux-trace-kernel/171509106728.162236.2398372644430125344.stgit@devnote2
Link: https://lore.kernel.org/linux-trace-kernel/20240603190823.634870264@goodmis.org

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Florent Revest <revest@chromium.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>
Cc: bpf <bpf@vger.kernel.org>
Cc: Sven Schnelle <svens@linux.ibm.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Alan Maguire <alan.maguire@oracle.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Guo Ren <guoren@kernel.org>
Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/linux/trace_recursion.h | 29 ----------------------------
 kernel/trace/trace.h            | 34 +++++++++++++++++++++++++++++++--
 2 files changed, 32 insertions(+), 31 deletions(-)

diff --git a/include/linux/trace_recursion.h b/include/linux/trace_recursion.h
index 02e6afc6d7fe..fdfb6f66718a 100644
--- a/include/linux/trace_recursion.h
+++ b/include/linux/trace_recursion.h
@@ -44,25 +44,6 @@ enum {
  */
 	TRACE_IRQ_BIT,
 
-	/*
-	 * In the very unlikely case that an interrupt came in
-	 * at a start of graph tracing, and we want to trace
-	 * the function in that interrupt, the depth can be greater
-	 * than zero, because of the preempted start of a previous
-	 * trace. In an even more unlikely case, depth could be 2
-	 * if a softirq interrupted the start of graph tracing,
-	 * followed by an interrupt preempting a start of graph
-	 * tracing in the softirq, and depth can even be 3
-	 * if an NMI came in at the start of an interrupt function
-	 * that preempted a softirq start of a function that
-	 * preempted normal context!!!! Luckily, it can't be
-	 * greater than 3, so the next two bits are a mask
-	 * of what the depth is when we set TRACE_GRAPH_FL
-	 */
-
-	TRACE_GRAPH_DEPTH_START_BIT,
-	TRACE_GRAPH_DEPTH_END_BIT,
-
 	/*
 	 * To implement set_graph_notrace, if this bit is set, we ignore
 	 * function graph tracing of called functions, until the return
@@ -78,16 +59,6 @@ enum {
 #define trace_recursion_clear(bit)	do { (current)->trace_recursion &= ~(1<<(bit)); } while (0)
 #define trace_recursion_test(bit)	((current)->trace_recursion & (1<<(bit)))
 
-#define trace_recursion_depth() \
-	(((current)->trace_recursion >> TRACE_GRAPH_DEPTH_START_BIT) & 3)
-#define trace_recursion_set_depth(depth) \
-	do {								\
-		current->trace_recursion &=				\
-			~(3 << TRACE_GRAPH_DEPTH_START_BIT);		\
-		current->trace_recursion |=				\
-			((depth) & 3) << TRACE_GRAPH_DEPTH_START_BIT;	\
-	} while (0)
-
 #define TRACE_CONTEXT_BITS	4
 
 #define TRACE_FTRACE_START	TRACE_FTRACE_BIT
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 73919129e57c..82d879dc63ff 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -900,8 +900,38 @@ extern void free_fgraph_ops(struct trace_array *tr);
 
 enum {
 	TRACE_GRAPH_FL		= 1,
+
+	/*
+	 * In the very unlikely case that an interrupt came in
+	 * at a start of graph tracing, and we want to trace
+	 * the function in that interrupt, the depth can be greater
+	 * than zero, because of the preempted start of a previous
+	 * trace. In an even more unlikely case, depth could be 2
+	 * if a softirq interrupted the start of graph tracing,
+	 * followed by an interrupt preempting a start of graph
+	 * tracing in the softirq, and depth can even be 3
+	 * if an NMI came in at the start of an interrupt function
+	 * that preempted a softirq start of a function that
+	 * preempted normal context!!!! Luckily, it can't be
+	 * greater than 3, so the next two bits are a mask
+	 * of what the depth is when we set TRACE_GRAPH_FL
+	 */
+
+	TRACE_GRAPH_DEPTH_START_BIT,
+	TRACE_GRAPH_DEPTH_END_BIT,
 };
 
+static inline unsigned long ftrace_graph_depth(unsigned long *task_var)
+{
+	return (*task_var >> TRACE_GRAPH_DEPTH_START_BIT) & 3;
+}
+
+static inline void ftrace_graph_set_depth(unsigned long *task_var, int depth)
+{
+	*task_var &= ~(3 << TRACE_GRAPH_DEPTH_START_BIT);
+	*task_var |= (depth & 3) << TRACE_GRAPH_DEPTH_START_BIT;
+}
+
 #ifdef CONFIG_DYNAMIC_FTRACE
 extern struct ftrace_hash __rcu *ftrace_graph_hash;
 extern struct ftrace_hash __rcu *ftrace_graph_notrace_hash;
@@ -934,7 +964,7 @@ ftrace_graph_addr(unsigned long *task_var, struct ftrace_graph_ent *trace)
 		 * when the depth is zero.
 		 */
 		*task_var |= TRACE_GRAPH_FL;
-		trace_recursion_set_depth(trace->depth);
+		ftrace_graph_set_depth(task_var, trace->depth);
 
 		/*
 		 * If no irqs are to be traced, but a set_graph_function
@@ -959,7 +989,7 @@ ftrace_graph_addr_finish(struct fgraph_ops *gops, struct ftrace_graph_ret *trace
 	unsigned long *task_var = fgraph_get_task_var(gops);
 
 	if ((*task_var & TRACE_GRAPH_FL) &&
-	    trace->depth == trace_recursion_depth())
+	    trace->depth == ftrace_graph_depth(task_var))
 		*task_var &= ~TRACE_GRAPH_FL;
 }
 
-- 
2.43.0



