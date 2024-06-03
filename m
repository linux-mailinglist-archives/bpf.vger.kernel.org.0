Return-Path: <bpf+bounces-31241-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B98FA8D897B
	for <lists+bpf@lfdr.de>; Mon,  3 Jun 2024 21:09:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56419B24D73
	for <lists+bpf@lfdr.de>; Mon,  3 Jun 2024 19:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B5DB13D287;
	Mon,  3 Jun 2024 19:07:14 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74F5913CAA4;
	Mon,  3 Jun 2024 19:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717441633; cv=none; b=p9At9TtebbcqUTCxYUcPbCHiJeay3+TTg7e5ZhXgEmoS8WnM+RO4tgDfT9AajZMjubWdnfoo6VYR0CZDjIs2+pF/gsiZO7JGzKQF175DjtlMsjEJRhqv5OVY0SV+Ew0Xt50bC+ur5iE3D0xW9WgvbSOS8gVWEI/JPLclsiL5vK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717441633; c=relaxed/simple;
	bh=NmE7oZQh9MdS7aKT9pQIniDkO7K+Ej0rPisWKG9X8eA=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=O8NFc9XtelDaJvlswbxYbLSLbUQkJdJ1Po78qU5MIYPT35qCjITkUSCuPo94YIb9gkXQQDR63XPgh3MBSnoEkd7PJo99GYty5vmkB+a8hwup9lCb+VSWFB1D9ILJflt78WKg1yukYoMvM9nZ6GipNjFSWu4Z2LeZD6BSJtUDFyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E80DDC4DE0A;
	Mon,  3 Jun 2024 19:07:12 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1sED2d-00000009Tuw-3wUs;
	Mon, 03 Jun 2024 15:08:23 -0400
Message-ID: <20240603190823.796709456@goodmis.org>
User-Agent: quilt/0.68
Date: Mon, 03 Jun 2024 15:07:22 -0400
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
Subject: [PATCH v3 18/27] function_graph: Move graph notrace bit to shadow stack global var
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
graph no-trace was a bit of an abuse of that variable. Now that there
exists global vars that are per stack for registered graph traces, use
that instead.

Link: https://lore.kernel.org/linux-trace-kernel/171509107907.162236.6564679266777519065.stgit@devnote2

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/linux/trace_recursion.h      |  7 -------
 kernel/trace/trace.h                 |  9 +++++++++
 kernel/trace/trace_functions_graph.c | 10 ++++++----
 3 files changed, 15 insertions(+), 11 deletions(-)

diff --git a/include/linux/trace_recursion.h b/include/linux/trace_recursion.h
index fdfb6f66718a..ae04054a1be3 100644
--- a/include/linux/trace_recursion.h
+++ b/include/linux/trace_recursion.h
@@ -44,13 +44,6 @@ enum {
  */
 	TRACE_IRQ_BIT,
 
-	/*
-	 * To implement set_graph_notrace, if this bit is set, we ignore
-	 * function graph tracing of called functions, until the return
-	 * function is called to clear it.
-	 */
-	TRACE_GRAPH_NOTRACE_BIT,
-
 	/* Used to prevent recursion recording from recursing. */
 	TRACE_RECORD_RECURSION_BIT,
 };
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 82d879dc63ff..b37402e3f0c9 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -919,8 +919,17 @@ enum {
 
 	TRACE_GRAPH_DEPTH_START_BIT,
 	TRACE_GRAPH_DEPTH_END_BIT,
+
+	/*
+	 * To implement set_graph_notrace, if this bit is set, we ignore
+	 * function graph tracing of called functions, until the return
+	 * function is called to clear it.
+	 */
+	TRACE_GRAPH_NOTRACE_BIT,
 };
 
+#define TRACE_GRAPH_NOTRACE		(1 << TRACE_GRAPH_NOTRACE_BIT)
+
 static inline unsigned long ftrace_graph_depth(unsigned long *task_var)
 {
 	return (*task_var >> TRACE_GRAPH_DEPTH_START_BIT) & 3;
diff --git a/kernel/trace/trace_functions_graph.c b/kernel/trace/trace_functions_graph.c
index 66cce73e94f8..13d0387ac6a6 100644
--- a/kernel/trace/trace_functions_graph.c
+++ b/kernel/trace/trace_functions_graph.c
@@ -130,6 +130,7 @@ static inline int ftrace_graph_ignore_irqs(void)
 int trace_graph_entry(struct ftrace_graph_ent *trace,
 		      struct fgraph_ops *gops)
 {
+	unsigned long *task_var = fgraph_get_task_var(gops);
 	struct trace_array *tr = gops->private;
 	struct trace_array_cpu *data;
 	unsigned long flags;
@@ -138,7 +139,7 @@ int trace_graph_entry(struct ftrace_graph_ent *trace,
 	int ret;
 	int cpu;
 
-	if (trace_recursion_test(TRACE_GRAPH_NOTRACE_BIT))
+	if (*task_var & TRACE_GRAPH_NOTRACE)
 		return 0;
 
 	/*
@@ -149,7 +150,7 @@ int trace_graph_entry(struct ftrace_graph_ent *trace,
 	 * returning from the function.
 	 */
 	if (ftrace_graph_notrace_addr(trace->func)) {
-		trace_recursion_set(TRACE_GRAPH_NOTRACE_BIT);
+		*task_var |= TRACE_GRAPH_NOTRACE_BIT;
 		/*
 		 * Need to return 1 to have the return called
 		 * that will clear the NOTRACE bit.
@@ -240,6 +241,7 @@ void __trace_graph_return(struct trace_array *tr,
 void trace_graph_return(struct ftrace_graph_ret *trace,
 			struct fgraph_ops *gops)
 {
+	unsigned long *task_var = fgraph_get_task_var(gops);
 	struct trace_array *tr = gops->private;
 	struct trace_array_cpu *data;
 	unsigned long flags;
@@ -249,8 +251,8 @@ void trace_graph_return(struct ftrace_graph_ret *trace,
 
 	ftrace_graph_addr_finish(gops, trace);
 
-	if (trace_recursion_test(TRACE_GRAPH_NOTRACE_BIT)) {
-		trace_recursion_clear(TRACE_GRAPH_NOTRACE_BIT);
+	if (*task_var & TRACE_GRAPH_NOTRACE) {
+		*task_var &= ~TRACE_GRAPH_NOTRACE;
 		return;
 	}
 
-- 
2.43.0



