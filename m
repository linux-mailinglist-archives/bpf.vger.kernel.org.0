Return-Path: <bpf+bounces-31242-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A36CE8D897C
	for <lists+bpf@lfdr.de>; Mon,  3 Jun 2024 21:09:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E2D0289765
	for <lists+bpf@lfdr.de>; Mon,  3 Jun 2024 19:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FCF813D290;
	Mon,  3 Jun 2024 19:07:14 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6610213CA81;
	Mon,  3 Jun 2024 19:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717441633; cv=none; b=NHJjo6KJK1dvY7zmuIdUoBDV+iBJT6bXOlFYOZrBso0qeuqn6yu3YA+KWvNnGCyaiK+s8wWExuI9mbifPNHosSixaMuzCzDYOWWv6YnjP/Tld9tm6mPPioGmzMYrV0DwxqxNFp/ybCEG99p24SgksTj/o/ufTcN9uCZSD9sbS9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717441633; c=relaxed/simple;
	bh=JE93PlBa3kdyQhPv7TKP6/ed9Zy0l5p2+IbasxlOd1M=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=DKWkfbWk3cf+eRj0YWeqjZR/Bg96FhTKhkND7yu8LbpiCA2enBx+DyPyN8mwsCyIEsQkxQQ4PXP+a/xqx7RlONAyS7D8Mg3nrA+NHdSXEmAoJDEj154feMgJuIQKH4kF60lOSSA+RxHrK0dJy+RZNKE8dNH58RULCPSPbTckYMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5100C4DE09;
	Mon,  3 Jun 2024 19:07:12 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1sED2d-00000009TuR-3G9G;
	Mon, 03 Jun 2024 15:08:23 -0400
Message-ID: <20240603190823.634870264@goodmis.org>
User-Agent: quilt/0.68
Date: Mon, 03 Jun 2024 15:07:21 -0400
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
Subject: [PATCH v3 17/27] function_graph: Move graph depth stored data to shadow stack global
 var
References: <20240603190704.663840775@goodmis.org>
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



