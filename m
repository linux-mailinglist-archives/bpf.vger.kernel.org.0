Return-Path: <bpf+bounces-32250-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C23190A1F0
	for <lists+bpf@lfdr.de>; Mon, 17 Jun 2024 03:48:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E6AD28256A
	for <lists+bpf@lfdr.de>; Mon, 17 Jun 2024 01:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EFB4161311;
	Mon, 17 Jun 2024 01:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YBcdJHjs"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B88160885;
	Mon, 17 Jun 2024 01:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718588853; cv=none; b=G9ibBxtpkqxt6mRS4CV6PC1ZMmAMpUiTggiQrV8/HCPRxpuzOXmDt3N1VgAo0nkdIuGWePQvY3RQSnKQjjvZm0t+Ocgu+DnQD+2UwqCNZFVGXJV1cf9zJnRm2/GXFpdd6U2gEXCBrDYbc77oKdxtna/b4URh/aOVR8jBaU6bpho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718588853; c=relaxed/simple;
	bh=W2AlUCQ/NrkkRaXMrBqgK7m9/12G4uUen80+QqTRBjM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ULDLCg2KMtrIJqJDemwCsVU24OTmgmhrhQmrdztNApgSTVz7kIu5ye9sQdZ58yEnvIZTjqE8ddv3xHFkmii4hTj+nYzfzILEeVDwkOOAzfj6+n3ZDSZRp2o9Y3vWNrVlGFJQC55jIJB/TdiwUB0xDKz5tFKPpVcPMhs6UpmWM/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YBcdJHjs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD60CC4AF1C;
	Mon, 17 Jun 2024 01:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718588852;
	bh=W2AlUCQ/NrkkRaXMrBqgK7m9/12G4uUen80+QqTRBjM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YBcdJHjsJ1VmjL3rJQEoE80iaST4IZn23J0uXG/OQ77ZEfyr8Inp3bw7JYslquHyD
	 x+EC4XORoC/qc3hTs/3jPN+Xoukglgmfg9KL1ApOiF4ZzU6vV39VvMT4FODVjBHTIe
	 WfSiKcMfUteoG1wkWt1gQNR2oO6rV2VobGM3PvahovKF3jUCgfJDP6pBHfxQpzMENw
	 vp4vbvoYYyk55VChBbq2/Q9xKgmbFMwSq9b4C1dY86EEeicj6OvHmUyxcC6LwU3HuB
	 tW9feCtJO7O9lr4e/JqWHw+iCzi1pUdS0Tkp2rIb0m1soK/SSiqFa/NXx4wjb1RUh6
	 a7r2ke4R+Cn1w==
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
Subject: [PATCH v11 05/18] function_graph: Pass ftrace_regs to retfunc
Date: Mon, 17 Jun 2024 10:47:26 +0900
Message-Id: <171858884638.288820.16050704329380001528.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <171858878797.288820.237119113242007537.stgit@devnote2>
References: <171858878797.288820.237119113242007537.stgit@devnote2>
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
 kernel/trace/fgraph.c                |   16 +++++++++++-----
 kernel/trace/ftrace.c                |    3 ++-
 kernel/trace/trace.h                 |    3 ++-
 kernel/trace/trace_functions_graph.c |    7 ++++---
 kernel/trace/trace_irqsoff.c         |    3 ++-
 kernel/trace/trace_sched_wakeup.c    |    3 ++-
 kernel/trace/trace_selftest.c        |    3 ++-
 8 files changed, 27 insertions(+), 14 deletions(-)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 9230af20c92e..85394b9fb630 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -1069,7 +1069,8 @@ struct fgraph_ops;
 
 /* Type of the callback handlers for tracing function graph*/
 typedef void (*trace_func_graph_ret_t)(struct ftrace_graph_ret *,
-				       struct fgraph_ops *); /* return */
+				       struct fgraph_ops *,
+				       struct ftrace_regs *); /* return */
 typedef int (*trace_func_graph_ent_t)(struct ftrace_graph_ent *,
 				      struct fgraph_ops *,
 				      struct ftrace_regs *); /* entry */
diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index 709f920da939..d735a8c872bb 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -297,7 +297,8 @@ static int entry_run(struct ftrace_graph_ent *trace, struct fgraph_ops *ops,
 }
 
 /* ftrace_graph_return set to this to tell some archs to run function graph */
-static void return_run(struct ftrace_graph_ret *trace, struct fgraph_ops *ops)
+static void return_run(struct ftrace_graph_ret *trace, struct fgraph_ops *ops,
+		       struct ftrace_regs *fregs)
 {
 }
 
@@ -491,7 +492,8 @@ int ftrace_graph_entry_stub(struct ftrace_graph_ent *trace,
 }
 
 static void ftrace_graph_ret_stub(struct ftrace_graph_ret *trace,
-				  struct fgraph_ops *gops)
+				  struct fgraph_ops *gops,
+				  struct ftrace_regs *fregs)
 {
 }
 
@@ -787,6 +789,9 @@ __ftrace_return_to_handler(struct ftrace_regs *fregs, unsigned long frame_pointe
 	}
 
 	trace.rettime = trace_clock_local();
+	if (fregs)
+		ftrace_regs_set_instruction_pointer(fregs, ret);
+
 #ifdef CONFIG_FUNCTION_GRAPH_RETVAL
 	trace.retval = ftrace_regs_get_return_value(fregs);
 #endif
@@ -796,7 +801,7 @@ __ftrace_return_to_handler(struct ftrace_regs *fregs, unsigned long frame_pointe
 #ifdef CONFIG_HAVE_STATIC_CALL
 	if (static_branch_likely(&fgraph_do_direct)) {
 		if (test_bit(fgraph_direct_gops->idx, &bitmap))
-			static_call(fgraph_retfunc)(&trace, fgraph_direct_gops);
+			static_call(fgraph_retfunc)(&trace, fgraph_direct_gops, fregs);
 	} else
 #endif
 	{
@@ -806,7 +811,7 @@ __ftrace_return_to_handler(struct ftrace_regs *fregs, unsigned long frame_pointe
 			if (gops == &fgraph_stub)
 				continue;
 
-			gops->retfunc(&trace, gops);
+			gops->retfunc(&trace, gops, fregs);
 		}
 	}
 
@@ -956,7 +961,8 @@ void ftrace_graph_sleep_time_control(bool enable)
  * Simply points to ftrace_stub, but with the proper protocol.
  * Defined by the linker script in linux/vmlinux.lds.h
  */
-void ftrace_stub_graph(struct ftrace_graph_ret *trace, struct fgraph_ops *gops);
+void ftrace_stub_graph(struct ftrace_graph_ret *trace, struct fgraph_ops *gops,
+		       struct ftrace_regs *fregs);
 
 /* The callbacks that hook a function */
 trace_func_graph_ret_t ftrace_graph_return = ftrace_stub_graph;
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 64d15428cffc..725a95b161a1 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -840,7 +840,8 @@ static int profile_graph_entry(struct ftrace_graph_ent *trace,
 }
 
 static void profile_graph_return(struct ftrace_graph_ret *trace,
-				 struct fgraph_ops *gops)
+				 struct fgraph_ops *gops,
+				 struct ftrace_regs *fregs)
 {
 	struct ftrace_ret_stack *ret_stack;
 	struct ftrace_profile_stat *stat;
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 2b718e448026..75c97b0515da 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -682,7 +682,8 @@ void trace_latency_header(struct seq_file *m);
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
index 92c16e99d4f2..d3c0c025dc1a 100644
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


