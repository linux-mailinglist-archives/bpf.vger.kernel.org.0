Return-Path: <bpf+bounces-18188-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 614D181701F
	for <lists+bpf@lfdr.de>; Mon, 18 Dec 2023 14:17:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7967F1C24482
	for <lists+bpf@lfdr.de>; Mon, 18 Dec 2023 13:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 580065BFA2;
	Mon, 18 Dec 2023 13:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jO6YASO5"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEED6129ED2;
	Mon, 18 Dec 2023 13:13:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9AA7C433C8;
	Mon, 18 Dec 2023 13:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702905195;
	bh=DxvrCuVm5CFgY/QPDT747/WL1/q6+2sScxvA4J8z3ws=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jO6YASO5CRxLrGnR0jtjCskBmJ1bcFuCee4XYWpzPi/Bsx8k8S673b80HfGQ6PA4W
	 pXNLu1Tge3K4NG7CB1+6JWdzy3/rPQJSYqqamUymdEM27/NEi89TsKMQTdgup7hcCc
	 ht27oUY108szS1cR6XeX2XBwujtQT4mwyShpT0DAMbXYfQDB+yeuar8lrxUqo7Nurg
	 GeBgcigT6Cax0t1IVp6HJ5NB1Kp2avYmWryHIEZuwC+N0OrcK5SrlOebvoyDJGHSRL
	 PScSb9759R80BPG0YsYE/EVZmRAHajqlLE837BwFxxMmblvAg3TGjOL3J7ou1f3Thv
	 i28AUWAL3QUMA==
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
Subject: [PATCH v5 08/34] ftrace/function_graph: Pass fgraph_ops to function graph callbacks
Date: Mon, 18 Dec 2023 22:13:09 +0900
Message-Id: <170290518871.220107.9663291995069215122.stgit@devnote2>
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

Pass the fgraph_ops structure to the function graph callbacks. This will
allow callbacks to add a descriptor to a fgraph_ops private field that wil
be added in the future and use it for the callbacks. This will be useful
when more than one callback can be registered to the function graph tracer.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 Changes in v2:
  - cleanup to set argument name on function prototype.
---
 include/linux/ftrace.h               |   10 +++++++---
 kernel/trace/fgraph.c                |   16 +++++++++-------
 kernel/trace/ftrace.c                |    6 ++++--
 kernel/trace/trace.h                 |    4 ++--
 kernel/trace/trace_functions_graph.c |   11 +++++++----
 kernel/trace/trace_irqsoff.c         |    6 ++++--
 kernel/trace/trace_sched_wakeup.c    |    6 ++++--
 kernel/trace/trace_selftest.c        |    5 +++--
 8 files changed, 40 insertions(+), 24 deletions(-)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 8b48fc621ea0..bc216cdc742d 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -1055,11 +1055,15 @@ struct ftrace_graph_ret {
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
index 97a9ffb8bb4c..62c35d6d95f9 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -129,13 +129,13 @@ static inline int get_fgraph_array(struct task_struct *t, int offset)
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
 
@@ -199,12 +199,14 @@ int __weak ftrace_disable_ftrace_graph_caller(void)
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
 
@@ -358,7 +360,7 @@ int function_graph_enter(unsigned long ret, unsigned long func,
 			atomic_inc(&current->trace_overrun);
 			break;
 		}
-		if (fgraph_array[i]->entryfunc(&trace)) {
+		if (fgraph_array[i]->entryfunc(&trace, fgraph_array[i])) {
 			offset = current->curr_ret_stack;
 			/* Check the top level stored word */
 			type = get_fgraph_type(current, offset - 1);
@@ -532,7 +534,7 @@ static unsigned long __ftrace_return_to_handler(struct fgraph_ret_regs *ret_regs
 	i = 0;
 	do {
 		idx = get_fgraph_array(current, offset - i);
-		fgraph_array[idx]->retfunc(&trace);
+		fgraph_array[idx]->retfunc(&trace, fgraph_array[idx]);
 		i++;
 	} while (i < index);
 
@@ -674,7 +676,7 @@ void ftrace_graph_sleep_time_control(bool enable)
  * Simply points to ftrace_stub, but with the proper protocol.
  * Defined by the linker script in linux/vmlinux.lds.h
  */
-extern void ftrace_stub_graph(struct ftrace_graph_ret *);
+void ftrace_stub_graph(struct ftrace_graph_ret *trace, struct fgraph_ops *gops);
 
 /* The callbacks that hook a function */
 trace_func_graph_ret_t ftrace_graph_return = ftrace_stub_graph;
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index fd64021ec52f..7ff5c454622a 100644
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
index b7f4ea25a194..d72d5e81f48a 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -675,8 +675,8 @@ void trace_latency_header(struct seq_file *m);
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
index 529590499b1f..914331d8242c 100644
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


