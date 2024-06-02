Return-Path: <bpf+bounces-31127-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D87A8D735A
	for <lists+bpf@lfdr.de>; Sun,  2 Jun 2024 05:39:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D1C91F21D8D
	for <lists+bpf@lfdr.de>; Sun,  2 Jun 2024 03:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 807F83B1AC;
	Sun,  2 Jun 2024 03:37:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D18538DC8;
	Sun,  2 Jun 2024 03:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717299447; cv=none; b=ojBWobQmPgGMtZe91cZitjQj2y8T9E2/7zNk1l+9UZnZvNrMC8PVBR8H8Ap95e7/ts14PD48EcVxAgMfNs+pgN/r08Z+gJ4JfQ5n5WCkZ8lF+eMS64+t8tkG8Ps6cwJyHDFN6cnm7eNLn7cEJk7Hkprg8HtJJqovdEAIqvBMPRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717299447; c=relaxed/simple;
	bh=NmE7oZQh9MdS7aKT9pQIniDkO7K+Ej0rPisWKG9X8eA=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=jaghl70mnaENp6xGm4YpX+7ssOrGSNRF361SpRB+6WAv0owG+B7/pSy5S8vmIXRYNWNk+S9rwZPQXcjtdhuisr/6foeveIjLyeBYqHEyaYH0Zw5Geka8VqPVPHL7oH1OUDqWnnkJfnyGuS/vVsc45KmmnYauYlQjkVCKMklN0O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D019BC4AF07;
	Sun,  2 Jun 2024 03:37:26 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1sDc3G-000000094Rw-0eZt;
	Sat, 01 Jun 2024 23:38:34 -0400
Message-ID: <20240602033834.016722869@goodmis.org>
User-Agent: quilt/0.68
Date: Sat, 01 Jun 2024 23:38:02 -0400
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
Subject: [PATCH v2 18/27] function_graph: Move graph notrace bit to shadow stack global var
References: <20240602033744.563858532@goodmis.org>
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



