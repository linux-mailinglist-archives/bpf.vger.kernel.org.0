Return-Path: <bpf+bounces-14240-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D2BD7E145F
	for <lists+bpf@lfdr.de>; Sun,  5 Nov 2023 17:09:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 902C21C20A0C
	for <lists+bpf@lfdr.de>; Sun,  5 Nov 2023 16:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA85013ACF;
	Sun,  5 Nov 2023 16:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hzsj6qVn"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A4BAF9DA;
	Sun,  5 Nov 2023 16:09:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E758DC433C7;
	Sun,  5 Nov 2023 16:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699200567;
	bh=yEhjs0R0Qef2/83fXa4qLGdcMfbIL29IAkz328qo8AA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hzsj6qVnQRs/v+v15sUROz1C+2AWBJYj5dYYAzCNaDUDke8KQ8Anv4ESb9v0XeTyK
	 dvtK9bMb7OvyK06lzfrQDZuhtFghRP2nct9W7yiSmaSfIBdf8s8JeThxQPqd4LpS2O
	 eQS1zMDhzSy7NPdcaCzAQzBFU/Vd9UT+TwUrAQPjdgeAlJy8vXiqU6u2Ht58qYNMYk
	 +hQkAYZQtaycBwQtr3SwW6g7j18R+e+iWqdFcIgTIY6DLMLUF95M4Vhc419VV8aREF
	 JU9gO5G/mnl4hjWzLIC+efxxmdPaVxqYGTxxLkOsrhLQyxYt3A2rhQV66+THSQJdZZ
	 avnpAvBjktNXg==
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
Subject: [RFC PATCH 14/32] function_graph: Move graph notrace bit to shadow stack global var
Date: Mon,  6 Nov 2023 01:09:21 +0900
Message-Id: <169920056100.482486.10749804996506200504.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <169920038849.482486.15796387219966662967.stgit@devnote2>
References: <169920038849.482486.15796387219966662967.stgit@devnote2>
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

The use of the task->trace_recursion for the logic used for the function
graph no-trace was a bit of an abuse of that variable. Now that there exists
global vars that are per stack for registered graph traces, use that instead.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 include/linux/trace_recursion.h      |    7 -------
 kernel/trace/trace.h                 |    9 +++++++++
 kernel/trace/trace_functions_graph.c |   10 ++++++----
 3 files changed, 15 insertions(+), 11 deletions(-)

diff --git a/include/linux/trace_recursion.h b/include/linux/trace_recursion.h
index 00e792bf148d..cc11b0e9d220 100644
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
index 8e5943d3d25c..350c889c2f1e 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -911,8 +911,17 @@ enum {
 
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
 


