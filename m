Return-Path: <bpf+bounces-28846-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BBCF8BE551
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 16:10:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3E6F2875F0
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 14:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B234615FCFC;
	Tue,  7 May 2024 14:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z8UparKm"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3412715F416;
	Tue,  7 May 2024 14:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715090992; cv=none; b=V2/0DWNv5tGdxi7WnpJEHaFvwhZ6vRy2JiWZ+XR4zLM+Axs6z40Mt3flRwf9uU9Q2Z6I1Gjty5B1uRCcZRu1Psj5sX3BLJW/kf2ldQDuHGHXXuLnqyZ+RztlHl5o+hQcxsyVwqSxPtncWjnRreLd0F6jrCK41rJ4jxcz8/jMPy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715090992; c=relaxed/simple;
	bh=TBCd96HE+Qgj/fAu4lhBPZz6z57jbs8YpIrIBHhPsvE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Oz18eUg2ufYTlBSuI75hPukt2EAfFRWtayPcarFxzyBxkILpkgidmlK/ww2R35D9VOH9/dbWHqbV58GLGk38jbqeOX0P46UsWCWmP3Hi9tUNQs0Y639D1Zp+VfYLQdX2w4SxOZ/Xsbaa2uPuaduKlWGBvfcrBbec70WAfGbobI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z8UparKm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D3CAC2BBFC;
	Tue,  7 May 2024 14:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715090992;
	bh=TBCd96HE+Qgj/fAu4lhBPZz6z57jbs8YpIrIBHhPsvE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z8UparKmEkqz+52hDgK49Q9aqnO5ssfvWftC8iX8OPzlSAY8tvTNxJgaYW4G+n325
	 thLp5Elai14iMgUxigPZKhLXWmPAXoMim6Wb6XuJ9FWWZ/UPDefJA1LdcEYQiy64DH
	 VopzcgwqsVaILU11bFgCIYbf/e/dfOlgjajnKc9ay32YEZydOl1Wf0E8oNSLbyRUfS
	 nqyPc3Pajr87c081JFk5wkhWblVWi5vspIHAi5vXaYMnlrE27N/wsDMcT6AtZoKGVg
	 LRtjydVNKV1jru8OwL8lDYEXEqPDWnnWXu9s8DeRqWlhWXta236luGdjixKGFY47Zy
	 n1VPFIsVbvaog==
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
Subject: [PATCH v10 09/36] ftrace/function_graph: Pass fgraph_ops to function graph callbacks
Date: Tue,  7 May 2024 23:09:45 +0900
Message-Id: <171509098588.162236.4787930115997357578.stgit@devnote2>
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
index 0a1a7316de7b..f9e51cbf9a97 100644
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
index c50edd1344e5..1fcbae5cc6d6 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -144,13 +144,13 @@ add_fgraph_index_bitmap(struct task_struct *t, int offset, unsigned long bitmap)
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
 
@@ -211,12 +211,14 @@ int __weak ftrace_disable_ftrace_graph_caller(void)
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
 
@@ -377,7 +379,7 @@ int function_graph_enter(unsigned long ret, unsigned long func,
 		if (gops == &fgraph_stub)
 			continue;
 
-		if (gops->entryfunc(&trace))
+		if (gops->entryfunc(&trace, gops))
 			bitmap |= BIT(i);
 	}
 
@@ -525,7 +527,7 @@ static unsigned long __ftrace_return_to_handler(struct fgraph_ret_regs *ret_regs
 		if (gops == &fgraph_stub)
 			continue;
 
-		gops->retfunc(&trace);
+		gops->retfunc(&trace, gops);
 	}
 
 	/*
@@ -679,7 +681,7 @@ void ftrace_graph_sleep_time_control(bool enable)
  * Simply points to ftrace_stub, but with the proper protocol.
  * Defined by the linker script in linux/vmlinux.lds.h
  */
-extern void ftrace_stub_graph(struct ftrace_graph_ret *);
+void ftrace_stub_graph(struct ftrace_graph_ret *trace, struct fgraph_ops *gops);
 
 /* The callbacks that hook a function */
 trace_func_graph_ret_t ftrace_graph_return = ftrace_stub_graph;
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index fef833f63647..4b0708106692 100644
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
index 64450615ca0c..55bb9a3bf322 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -678,8 +678,8 @@ void trace_latency_header(struct seq_file *m);
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


