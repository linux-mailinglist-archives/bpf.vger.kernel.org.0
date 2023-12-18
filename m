Return-Path: <bpf+bounces-18195-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D30C81702F
	for <lists+bpf@lfdr.de>; Mon, 18 Dec 2023 14:19:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2679C286365
	for <lists+bpf@lfdr.de>; Mon, 18 Dec 2023 13:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50D7C3A1B1;
	Mon, 18 Dec 2023 13:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B4sPEvqA"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9DF33788B;
	Mon, 18 Dec 2023 13:14:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32BFFC433C7;
	Mon, 18 Dec 2023 13:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702905282;
	bh=4gnOPh72MBp2/UPzOPml+kmyjzVijWhiPGlAlFNB6DE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B4sPEvqAuTYIQkOb5zeeKz5+SdlFP15zfP7e/bSZdETJFyOgtBWZukSgtySAU5GNU
	 jiKbvVZ78ayP158hhw54aIxUqZRkdyRz30BZ1gdeT7Gcu8cVO9hLlFtrW8DER6cmjD
	 VvmpsUyihPLDLWDRIAqoNFq7YiiMmebWxd3OYOAFSVCxqRPkveM308ftCi7VbwizWy
	 3pbB9x6hkMBXjBj5PwU2Kpm4sFxnRXKTmZn4YV9CWQ5O0W2NTSobehlMR+QlR89vMy
	 PGCLHLhzFxuzP0xwRgbageCW8L1ac1o+7/TPn7wenGignM+8WLQ9mx0xOzXl4R+gKO
	 V2XSJuX9iu89g==
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
Subject: [PATCH v5 15/34] function_graph: Move graph depth stored data to shadow stack global var
Date: Mon, 18 Dec 2023 22:14:35 +0900
Message-Id: <170290527470.220107.16894083688641098524.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <170290509018.220107.1347127510564358608.stgit@devnote2>
References: <170290509018.220107.1347127510564358608.stgit@devnote2>
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
graph depth was a bit of an abuse of that variable. Now that there
exists global vars that are per stack for registered graph traces, use that
instead.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 include/linux/trace_recursion.h |   29 -----------------------------
 kernel/trace/trace.h            |   34 ++++++++++++++++++++++++++++++++--
 2 files changed, 32 insertions(+), 31 deletions(-)

diff --git a/include/linux/trace_recursion.h b/include/linux/trace_recursion.h
index 2efd5ec46d7f..00e792bf148d 100644
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
index 3b9266aeb43b..e3f452eda0e3 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -896,8 +896,38 @@ extern void free_fgraph_ops(struct trace_array *tr);
 
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
@@ -930,7 +960,7 @@ ftrace_graph_addr(unsigned long *task_var, struct ftrace_graph_ent *trace)
 		 * when the depth is zero.
 		 */
 		*task_var |= TRACE_GRAPH_FL;
-		trace_recursion_set_depth(trace->depth);
+		ftrace_graph_set_depth(task_var, trace->depth);
 
 		/*
 		 * If no irqs are to be traced, but a set_graph_function
@@ -955,7 +985,7 @@ ftrace_graph_addr_finish(struct fgraph_ops *gops, struct ftrace_graph_ret *trace
 	unsigned long *task_var = fgraph_get_task_var(gops);
 
 	if ((*task_var & TRACE_GRAPH_FL) &&
-	    trace->depth == trace_recursion_depth())
+	    trace->depth == ftrace_graph_depth(task_var))
 		*task_var &= ~TRACE_GRAPH_FL;
 }
 


