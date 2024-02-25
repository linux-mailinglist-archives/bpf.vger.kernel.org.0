Return-Path: <bpf+bounces-22676-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EBCC862B28
	for <lists+bpf@lfdr.de>; Sun, 25 Feb 2024 16:21:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05E5FB20DB4
	for <lists+bpf@lfdr.de>; Sun, 25 Feb 2024 15:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6BC21A587;
	Sun, 25 Feb 2024 15:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pntm6RAp"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2913F17BD4;
	Sun, 25 Feb 2024 15:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708874360; cv=none; b=WWlceyeTLuGwZqrXtWH91oxHFrjFvcqEPIvNjnZT0QjRBzStiafx7togPO2/3IkrTMZGr8GGX9VYphXtpiR6DsKdMcx04J/5bnl/VBLwMgT5SSwMHFIAaQvRG9bg0JVhTm3wrPTmuhORl+W5nAklDH0nYRI2HgL3uXN/hEnfHog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708874360; c=relaxed/simple;
	bh=Vs5ha6/FQRmqGITqkK2r2pg1Erw0yvsoxnQTmhestPw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e22jHFagylQ//gt7EPMp2QMNtX7OppMrvgUzVqmbFUK+Km8DOjfN1e0/PsModBoQS4l1InL1Mzrc2VYl0W6bvmwn0Eo4hKkrrRqzeeK/q5Iex79SrJcdmQNcr5T4nQHHTBouoi6iKupnI5KCc6H4/BIhEIxql8wdjkd/kKPWJZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pntm6RAp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E536C433C7;
	Sun, 25 Feb 2024 15:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708874359;
	bh=Vs5ha6/FQRmqGITqkK2r2pg1Erw0yvsoxnQTmhestPw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Pntm6RApWfppEiT7sgXT1sdaxqMIa5ntI68qq/GPaHsi5wcVNd5glDgt8G0nh68jI
	 GgOkVnNYL2Yd+/FUJGlEIN8ClyMUCunwmRvkXgTwHIVzFlfGX2ekLE9ktLJZ495Y9U
	 EgiEyct1JnMFy+WCDIuog2BSN83IGWvnlLCyL/lA3yxwRjemXT0o9Le9GLY5rW/BNj
	 SsQx6pwimX4umy591eTyi8so82MV1zSAYTDJ634T82CQo5F3rRIig+hcl47Ma5A4op
	 9HjgQlnmIWBURjdz263JHdyZWw052zc+g7coUeTFomjEBsWV/JfNVsi/S56tMqgpM2
	 fMDm/1Ai7No9A==
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
Subject: [PATCH v8 23/35] function_graph: Pass ftrace_regs to retfunc
Date: Mon, 26 Feb 2024 00:19:14 +0900
Message-Id: <170887435413.564249.10700909639313327357.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <170887410337.564249.6360118840946697039.stgit@devnote2>
References: <170887410337.564249.6360118840946697039.stgit@devnote2>
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

Pass ftrace_regs to the fgraph_ops::retfunc(). If ftrace_regs is not
available, it passes a NULL instead. User callback function can access
some registers (including return address) via this ftrace_regs.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 Changes in v8:
  - Pass ftrace_regs to retfunc, instead of adding retregfunc.
 Changes in v6:
  - update to use ftrace_regs_get_return_value() because of reordering
    patches.
 Changes in v3:
  - Update for new multiple fgraph.
  - Save the return address to instruction pointer in ftrace_regs.
---
 include/linux/ftrace.h               |    3 ++-
 kernel/trace/fgraph.c                |   14 ++++++++++----
 kernel/trace/ftrace.c                |    3 ++-
 kernel/trace/trace.h                 |    3 ++-
 kernel/trace/trace_functions_graph.c |    7 ++++---
 kernel/trace/trace_irqsoff.c         |    3 ++-
 kernel/trace/trace_sched_wakeup.c    |    3 ++-
 kernel/trace/trace_selftest.c        |    3 ++-
 8 files changed, 26 insertions(+), 13 deletions(-)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index c2456f8ede0f..96b42f994c2f 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -1067,7 +1067,8 @@ struct fgraph_ops;
 
 /* Type of the callback handlers for tracing function graph*/
 typedef void (*trace_func_graph_ret_t)(struct ftrace_graph_ret *,
-				       struct fgraph_ops *); /* return */
+				       struct fgraph_ops *,
+				       struct ftrace_regs *); /* return */
 typedef int (*trace_func_graph_ent_t)(struct ftrace_graph_ent *,
 				      struct fgraph_ops *,
 				      struct ftrace_regs *); /* entry */
diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index 7462307c0459..d90d8da20d08 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -255,7 +255,8 @@ static int entry_run(struct ftrace_graph_ent *trace, struct fgraph_ops *ops,
 }
 
 /* ftrace_graph_return set to this to tell some archs to run function graph */
-static void return_run(struct ftrace_graph_ret *trace, struct fgraph_ops *ops)
+static void return_run(struct ftrace_graph_ret *trace, struct fgraph_ops *ops,
+		       struct ftrace_regs *fregs)
 {
 }
 
@@ -447,7 +448,8 @@ int ftrace_graph_entry_stub(struct ftrace_graph_ent *trace,
 }
 
 static void ftrace_graph_ret_stub(struct ftrace_graph_ret *trace,
-				  struct fgraph_ops *gops)
+				  struct fgraph_ops *gops,
+				  struct ftrace_regs *fregs)
 {
 }
 
@@ -791,6 +793,9 @@ __ftrace_return_to_handler(struct ftrace_regs *fregs, unsigned long frame_pointe
 	}
 
 	trace.rettime = trace_clock_local();
+	if (fregs)
+		ftrace_regs_set_instruction_pointer(fregs, ret);
+
 #ifdef CONFIG_FUNCTION_GRAPH_RETVAL
 	trace.retval = ftrace_regs_get_return_value(fregs);
 #endif
@@ -804,7 +809,7 @@ __ftrace_return_to_handler(struct ftrace_regs *fregs, unsigned long frame_pointe
 		if (gops == &fgraph_stub)
 			continue;
 
-		gops->retfunc(&trace, gops);
+		gops->retfunc(&trace, gops, fregs);
 	}
 
 	/*
@@ -968,7 +973,8 @@ void ftrace_graph_sleep_time_control(bool enable)
  * Simply points to ftrace_stub, but with the proper protocol.
  * Defined by the linker script in linux/vmlinux.lds.h
  */
-void ftrace_stub_graph(struct ftrace_graph_ret *trace, struct fgraph_ops *gops);
+void ftrace_stub_graph(struct ftrace_graph_ret *trace, struct fgraph_ops *gops,
+		       struct ftrace_regs *fregs);
 
 /* The callbacks that hook a function */
 trace_func_graph_ret_t ftrace_graph_return = ftrace_stub_graph;
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 162ece7a39b4..08decd56a7b9 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -835,7 +835,8 @@ static int profile_graph_entry(struct ftrace_graph_ent *trace,
 }
 
 static void profile_graph_return(struct ftrace_graph_ret *trace,
-				 struct fgraph_ops *gops)
+				 struct fgraph_ops *gops,
+				 struct ftrace_regs *fregs)
 {
 	struct ftrace_ret_stack *ret_stack;
 	struct ftrace_profile_stat *stat;
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 53adc73c460b..3106b54c555f 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -681,7 +681,8 @@ void trace_latency_header(struct seq_file *m);
 void trace_default_header(struct seq_file *m);
 void print_trace_header(struct seq_file *m, struct trace_iterator *iter);
 
-void trace_graph_return(struct ftrace_graph_ret *trace, struct fgraph_ops *gops);
+void trace_graph_return(struct ftrace_graph_ret *trace, struct fgraph_ops *gops,
+			struct ftrace_regs *fregs);
 int trace_graph_entry(struct ftrace_graph_ent *trace, struct fgraph_ops *gops,
 		      struct ftrace_regs *fregs);
 
diff --git a/kernel/trace/trace_functions_graph.c b/kernel/trace/trace_functions_graph.c
index b9785fc919c9..241407000109 100644
--- a/kernel/trace/trace_functions_graph.c
+++ b/kernel/trace/trace_functions_graph.c
@@ -240,7 +240,7 @@ void __trace_graph_return(struct trace_array *tr,
 }
 
 void trace_graph_return(struct ftrace_graph_ret *trace,
-			struct fgraph_ops *gops)
+			struct fgraph_ops *gops, struct ftrace_regs *fregs)
 {
 	unsigned long *task_var = fgraph_get_task_var(gops);
 	struct trace_array *tr = gops->private;
@@ -270,7 +270,8 @@ void trace_graph_return(struct ftrace_graph_ret *trace,
 }
 
 static void trace_graph_thresh_return(struct ftrace_graph_ret *trace,
-				      struct fgraph_ops *gops)
+				      struct fgraph_ops *gops,
+				      struct ftrace_regs *fregs)
 {
 	ftrace_graph_addr_finish(gops, trace);
 
@@ -283,7 +284,7 @@ static void trace_graph_thresh_return(struct ftrace_graph_ret *trace,
 	    (trace->rettime - trace->calltime < tracing_thresh))
 		return;
 	else
-		trace_graph_return(trace, gops);
+		trace_graph_return(trace, gops, fregs);
 }
 
 static struct fgraph_ops funcgraph_ops = {
diff --git a/kernel/trace/trace_irqsoff.c b/kernel/trace/trace_irqsoff.c
index ad739d76fc86..504de7a05498 100644
--- a/kernel/trace/trace_irqsoff.c
+++ b/kernel/trace/trace_irqsoff.c
@@ -208,7 +208,8 @@ static int irqsoff_graph_entry(struct ftrace_graph_ent *trace,
 }
 
 static void irqsoff_graph_return(struct ftrace_graph_ret *trace,
-				 struct fgraph_ops *gops)
+				 struct fgraph_ops *gops,
+				 struct ftrace_regs *fregs)
 {
 	struct trace_array *tr = irqsoff_trace;
 	struct trace_array_cpu *data;
diff --git a/kernel/trace/trace_sched_wakeup.c b/kernel/trace/trace_sched_wakeup.c
index 23360a2700de..9ffbd9326898 100644
--- a/kernel/trace/trace_sched_wakeup.c
+++ b/kernel/trace/trace_sched_wakeup.c
@@ -144,7 +144,8 @@ static int wakeup_graph_entry(struct ftrace_graph_ent *trace,
 }
 
 static void wakeup_graph_return(struct ftrace_graph_ret *trace,
-				struct fgraph_ops *gops)
+				struct fgraph_ops *gops,
+				struct ftrace_regs *fregs)
 {
 	struct trace_array *tr = wakeup_trace;
 	struct trace_array_cpu *data;
diff --git a/kernel/trace/trace_selftest.c b/kernel/trace/trace_selftest.c
index 1c3faaeae979..5959c6d262ba 100644
--- a/kernel/trace/trace_selftest.c
+++ b/kernel/trace/trace_selftest.c
@@ -807,7 +807,8 @@ static __init int store_entry(struct ftrace_graph_ent *trace,
 }
 
 static __init void store_return(struct ftrace_graph_ret *trace,
-				struct fgraph_ops *gops)
+				struct fgraph_ops *gops,
+				struct ftrace_regs *fregs)
 {
 	struct fgraph_fixture *fixture = container_of(gops, struct fgraph_fixture, gops);
 	const char *type = fixture->store_type_name;


