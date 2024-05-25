Return-Path: <bpf+bounces-30560-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E90D88CED8B
	for <lists+bpf@lfdr.de>; Sat, 25 May 2024 04:37:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5ACA81F21C5F
	for <lists+bpf@lfdr.de>; Sat, 25 May 2024 02:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C8B6168A8;
	Sat, 25 May 2024 02:36:54 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD23B65F;
	Sat, 25 May 2024 02:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716604614; cv=none; b=DC4N5WdVOUVWmRVqteKZVR+MAOakI1d4Zju0ENrnOVUZR6SdwbHbyYSreEA3/xGhE6yWei3ceWglNwnaVDu/Lx8CPkVpc7RZDIqvxDPOq4P0nqDLPQVrrzhRQ3aM/Bw5DM7Uul41bRA8kyJeSDvHW+jLVtrS8JwpENpJaCLheUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716604614; c=relaxed/simple;
	bh=z8Zt3hukIiejBXBsnzdc6E+2MvLbmPZ7Yivq3rbLCmY=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=JtJM3sohKhABzH6k+DJt/tZhNObrstJgy0U3++wSohNjGBurxjUFs6pXVRK6tRgSqs/CicYTFpTMCr+CXHb0OVmLxyEOQd8acfNMFMjJThl098NR8sVQuLZ6Xg/XRFs82dZjMwtgp5bYo/4qcMQvGi8USnPM0Tog/UZgGPkwZIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF7DEC4AF66;
	Sat, 25 May 2024 02:36:53 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1sAhHy-00000007DL4-1rk9;
	Fri, 24 May 2024 22:37:42 -0400
Message-ID: <20240525023742.307011974@goodmis.org>
User-Agent: quilt/0.68
Date: Fri, 24 May 2024 22:36:59 -0400
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
Subject: [PATCH 07/20] ftrace/function_graph: Pass fgraph_ops to function graph callbacks
References: <20240525023652.903909489@goodmis.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

Pass the fgraph_ops structure to the function graph callbacks. This will
allow callbacks to add a descriptor to a fgraph_ops private field that wil
be added in the future and use it for the callbacks. This will be useful
when more than one callback can be registered to the function graph tracer.

Co-developed with Masami Hiramatsu:
Link: https://lore.kernel.org/linux-trace-kernel/171509098588.162236.4787930115997357578.stgit@devnote2

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/linux/ftrace.h               | 10 +++++++---
 kernel/trace/fgraph.c                | 16 +++++++++-------
 kernel/trace/ftrace.c                |  6 ++++--
 kernel/trace/trace.h                 |  4 ++--
 kernel/trace/trace_functions_graph.c | 11 +++++++----
 kernel/trace/trace_irqsoff.c         |  6 ++++--
 kernel/trace/trace_sched_wakeup.c    |  6 ++++--
 kernel/trace/trace_selftest.c        |  5 +++--
 8 files changed, 40 insertions(+), 24 deletions(-)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 4d4c146fbfbc..032974f55c5b 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -1026,11 +1026,15 @@ struct ftrace_graph_ret {
 	unsigned long long rettime;
 } __packed;
 
+struct fgraph_ops;
+
 /* Type of the callback handlers for tracing function graph*/
-typedef void (*trace_func_graph_ret_t)(struct ftrace_graph_ret *); /* return */
-typedef int (*trace_func_graph_ent_t)(struct ftrace_graph_ent *); /* entry */
+typedef void (*trace_func_graph_ret_t)(struct ftrace_graph_ret *,
+				       struct fgraph_ops *); /* return */
+typedef int (*trace_func_graph_ent_t)(struct ftrace_graph_ent *,
+				      struct fgraph_ops *); /* entry */
 
-extern int ftrace_graph_entry_stub(struct ftrace_graph_ent *trace);
+extern int ftrace_graph_entry_stub(struct ftrace_graph_ent *trace, struct fgraph_ops *gops);
 
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 
diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index 2b52afa03ab4..54ed2ed2036b 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -164,13 +164,13 @@ set_bitmap(struct task_struct *t, int offset, unsigned long bitmap)
 }
 
 /* ftrace_graph_entry set to this to tell some archs to run function graph */
-static int entry_run(struct ftrace_graph_ent *trace)
+static int entry_run(struct ftrace_graph_ent *trace, struct fgraph_ops *ops)
 {
 	return 0;
 }
 
 /* ftrace_graph_return set to this to tell some archs to run function graph */
-static void return_run(struct ftrace_graph_ret *trace)
+static void return_run(struct ftrace_graph_ret *trace, struct fgraph_ops *ops)
 {
 }
 
@@ -234,12 +234,14 @@ int __weak ftrace_disable_ftrace_graph_caller(void)
 }
 #endif
 
-int ftrace_graph_entry_stub(struct ftrace_graph_ent *trace)
+int ftrace_graph_entry_stub(struct ftrace_graph_ent *trace,
+			    struct fgraph_ops *gops)
 {
 	return 0;
 }
 
-static void ftrace_graph_ret_stub(struct ftrace_graph_ret *trace)
+static void ftrace_graph_ret_stub(struct ftrace_graph_ret *trace,
+				  struct fgraph_ops *gops)
 {
 }
 
@@ -379,7 +381,7 @@ int function_graph_enter(unsigned long ret, unsigned long func,
 		if (gops == &fgraph_stub)
 			continue;
 
-		if (gops->entryfunc(&trace))
+		if (gops->entryfunc(&trace, gops))
 			bitmap |= BIT(i);
 	}
 
@@ -527,7 +529,7 @@ static unsigned long __ftrace_return_to_handler(struct fgraph_ret_regs *ret_regs
 		if (gops == &fgraph_stub)
 			continue;
 
-		gops->retfunc(&trace);
+		gops->retfunc(&trace, gops);
 	}
 
 	/*
@@ -681,7 +683,7 @@ void ftrace_graph_sleep_time_control(bool enable)
  * Simply points to ftrace_stub, but with the proper protocol.
  * Defined by the linker script in linux/vmlinux.lds.h
  */
-extern void ftrace_stub_graph(struct ftrace_graph_ret *);
+void ftrace_stub_graph(struct ftrace_graph_ret *trace, struct fgraph_ops *gops);
 
 /* The callbacks that hook a function */
 trace_func_graph_ret_t ftrace_graph_return = ftrace_stub_graph;
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 789950a4f977..d18387c0642d 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -815,7 +815,8 @@ void ftrace_graph_graph_time_control(bool enable)
 	fgraph_graph_time = enable;
 }
 
-static int profile_graph_entry(struct ftrace_graph_ent *trace)
+static int profile_graph_entry(struct ftrace_graph_ent *trace,
+			       struct fgraph_ops *gops)
 {
 	struct ftrace_ret_stack *ret_stack;
 
@@ -832,7 +833,8 @@ static int profile_graph_entry(struct ftrace_graph_ent *trace)
 	return 1;
 }
 
-static void profile_graph_return(struct ftrace_graph_ret *trace)
+static void profile_graph_return(struct ftrace_graph_ret *trace,
+				 struct fgraph_ops *gops)
 {
 	struct ftrace_ret_stack *ret_stack;
 	struct ftrace_profile_stat *stat;
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 749a182dab48..2575ec243350 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -679,8 +679,8 @@ void trace_latency_header(struct seq_file *m);
 void trace_default_header(struct seq_file *m);
 void print_trace_header(struct seq_file *m, struct trace_iterator *iter);
 
-void trace_graph_return(struct ftrace_graph_ret *trace);
-int trace_graph_entry(struct ftrace_graph_ent *trace);
+void trace_graph_return(struct ftrace_graph_ret *trace, struct fgraph_ops *gops);
+int trace_graph_entry(struct ftrace_graph_ent *trace, struct fgraph_ops *gops);
 void set_graph_array(struct trace_array *tr);
 
 void tracing_start_cmdline_record(void);
diff --git a/kernel/trace/trace_functions_graph.c b/kernel/trace/trace_functions_graph.c
index c35fbaab2a47..b7b142b65299 100644
--- a/kernel/trace/trace_functions_graph.c
+++ b/kernel/trace/trace_functions_graph.c
@@ -129,7 +129,8 @@ static inline int ftrace_graph_ignore_irqs(void)
 	return in_hardirq();
 }
 
-int trace_graph_entry(struct ftrace_graph_ent *trace)
+int trace_graph_entry(struct ftrace_graph_ent *trace,
+		      struct fgraph_ops *gops)
 {
 	struct trace_array *tr = graph_array;
 	struct trace_array_cpu *data;
@@ -238,7 +239,8 @@ void __trace_graph_return(struct trace_array *tr,
 		trace_buffer_unlock_commit_nostack(buffer, event);
 }
 
-void trace_graph_return(struct ftrace_graph_ret *trace)
+void trace_graph_return(struct ftrace_graph_ret *trace,
+			struct fgraph_ops *gops)
 {
 	struct trace_array *tr = graph_array;
 	struct trace_array_cpu *data;
@@ -275,7 +277,8 @@ void set_graph_array(struct trace_array *tr)
 	smp_mb();
 }
 
-static void trace_graph_thresh_return(struct ftrace_graph_ret *trace)
+static void trace_graph_thresh_return(struct ftrace_graph_ret *trace,
+				      struct fgraph_ops *gops)
 {
 	ftrace_graph_addr_finish(trace);
 
@@ -288,7 +291,7 @@ static void trace_graph_thresh_return(struct ftrace_graph_ret *trace)
 	    (trace->rettime - trace->calltime < tracing_thresh))
 		return;
 	else
-		trace_graph_return(trace);
+		trace_graph_return(trace, gops);
 }
 
 static struct fgraph_ops funcgraph_thresh_ops = {
diff --git a/kernel/trace/trace_irqsoff.c b/kernel/trace/trace_irqsoff.c
index ba37f768e2f2..5478f4c4f708 100644
--- a/kernel/trace/trace_irqsoff.c
+++ b/kernel/trace/trace_irqsoff.c
@@ -175,7 +175,8 @@ static int irqsoff_display_graph(struct trace_array *tr, int set)
 	return start_irqsoff_tracer(irqsoff_trace, set);
 }
 
-static int irqsoff_graph_entry(struct ftrace_graph_ent *trace)
+static int irqsoff_graph_entry(struct ftrace_graph_ent *trace,
+			       struct fgraph_ops *gops)
 {
 	struct trace_array *tr = irqsoff_trace;
 	struct trace_array_cpu *data;
@@ -205,7 +206,8 @@ static int irqsoff_graph_entry(struct ftrace_graph_ent *trace)
 	return ret;
 }
 
-static void irqsoff_graph_return(struct ftrace_graph_ret *trace)
+static void irqsoff_graph_return(struct ftrace_graph_ret *trace,
+				 struct fgraph_ops *gops)
 {
 	struct trace_array *tr = irqsoff_trace;
 	struct trace_array_cpu *data;
diff --git a/kernel/trace/trace_sched_wakeup.c b/kernel/trace/trace_sched_wakeup.c
index 0469a04a355f..49bcc812652c 100644
--- a/kernel/trace/trace_sched_wakeup.c
+++ b/kernel/trace/trace_sched_wakeup.c
@@ -112,7 +112,8 @@ static int wakeup_display_graph(struct trace_array *tr, int set)
 	return start_func_tracer(tr, set);
 }
 
-static int wakeup_graph_entry(struct ftrace_graph_ent *trace)
+static int wakeup_graph_entry(struct ftrace_graph_ent *trace,
+			      struct fgraph_ops *gops)
 {
 	struct trace_array *tr = wakeup_trace;
 	struct trace_array_cpu *data;
@@ -141,7 +142,8 @@ static int wakeup_graph_entry(struct ftrace_graph_ent *trace)
 	return ret;
 }
 
-static void wakeup_graph_return(struct ftrace_graph_ret *trace)
+static void wakeup_graph_return(struct ftrace_graph_ret *trace,
+				struct fgraph_ops *gops)
 {
 	struct trace_array *tr = wakeup_trace;
 	struct trace_array_cpu *data;
diff --git a/kernel/trace/trace_selftest.c b/kernel/trace/trace_selftest.c
index e9c5058a8efd..56f269c0560a 100644
--- a/kernel/trace/trace_selftest.c
+++ b/kernel/trace/trace_selftest.c
@@ -762,7 +762,8 @@ trace_selftest_startup_function(struct tracer *trace, struct trace_array *tr)
 static unsigned int graph_hang_thresh;
 
 /* Wrap the real function entry probe to avoid possible hanging */
-static int trace_graph_entry_watchdog(struct ftrace_graph_ent *trace)
+static int trace_graph_entry_watchdog(struct ftrace_graph_ent *trace,
+				      struct fgraph_ops *gops)
 {
 	/* This is harmlessly racy, we want to approximately detect a hang */
 	if (unlikely(++graph_hang_thresh > GRAPH_MAX_FUNC_TEST)) {
@@ -776,7 +777,7 @@ static int trace_graph_entry_watchdog(struct ftrace_graph_ent *trace)
 		return 0;
 	}
 
-	return trace_graph_entry(trace);
+	return trace_graph_entry(trace, gops);
 }
 
 static struct fgraph_ops fgraph_ops __initdata  = {
-- 
2.43.0



