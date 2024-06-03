Return-Path: <bpf+bounces-31234-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 798578D8970
	for <lists+bpf@lfdr.de>; Mon,  3 Jun 2024 21:08:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E69741F25099
	for <lists+bpf@lfdr.de>; Mon,  3 Jun 2024 19:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B81713CA89;
	Mon,  3 Jun 2024 19:07:13 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1B013C90E;
	Mon,  3 Jun 2024 19:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717441633; cv=none; b=kJWskCobuGYC20Z6YSEFTVE+mCOo6M33+53QltX7qX+pcAKQaGENK35IXWb74gz25hVBn7o2C6hCrsyAmh9965hl+FAF1fVRFL0rBC9auu/x0Xjdhetv8CHSIlWsHmB07xE8gfTI6db4VfRO5tJ/PBEaMHa9BYfsN5sUVV5xWic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717441633; c=relaxed/simple;
	bh=ALL5BqhhQlUiOxD8vovKUC+mjaCtK7pnO3aAlaRI9eE=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=It0JD8RTYtZlxbip1WLsA5cUfCO7QTW5fzNY7qRWRikPFVFcP3ih8PDUEzeClH3LUiOIlElLLmm7DejPX+hHemgziNIZLsCl9wo6G4u1AWUhzVhQq6vf1XlBnyRz3S0+QQqf79jioGLoHA7tkh+85wmkXXbebrRQI7n4dU+TCrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E8E1C4E673;
	Mon,  3 Jun 2024 19:07:12 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1sED2d-00000009TsS-0Whs;
	Mon, 03 Jun 2024 15:08:23 -0400
Message-ID: <20240603190822.991720703@goodmis.org>
User-Agent: quilt/0.68
Date: Mon, 03 Jun 2024 15:07:17 -0400
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
Subject: [PATCH v3 13/27] function_graph: Add pid tracing back to function graph tracer
References: <20240603190704.663840775@goodmis.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

Now that the function_graph has a main callback that handles the function
graph subops tracing, it no longer honors the pid filtering of ftrace. Add
back this logic in the function_graph code to update the gops callback for
the entry function to test if it should trace the current task or not.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/linux/ftrace.h         |  2 ++
 kernel/trace/fgraph.c          | 40 ++++++++++++++++++++++++++++++++++
 kernel/trace/ftrace.c          |  5 +++--
 kernel/trace/ftrace_internal.h |  2 ++
 4 files changed, 47 insertions(+), 2 deletions(-)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 8f865689e868..e31ec8516de1 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -1040,6 +1040,7 @@ typedef int (*trace_func_graph_ent_t)(struct ftrace_graph_ent *,
 				      struct fgraph_ops *); /* entry */
 
 extern int ftrace_graph_entry_stub(struct ftrace_graph_ent *trace, struct fgraph_ops *gops);
+bool ftrace_pids_enabled(struct ftrace_ops *ops);
 
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 
@@ -1048,6 +1049,7 @@ struct fgraph_ops {
 	trace_func_graph_ret_t		retfunc;
 	struct ftrace_ops		ops; /* for the hash lists */
 	void				*private;
+	trace_func_graph_ent_t		saved_func;
 	int				idx;
 };
 
diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index 3ef6db53c0bf..30bed20c655f 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -854,6 +854,41 @@ void ftrace_graph_exit_task(struct task_struct *t)
 	kfree(ret_stack);
 }
 
+static int fgraph_pid_func(struct ftrace_graph_ent *trace,
+			   struct fgraph_ops *gops)
+{
+	struct trace_array *tr = gops->ops.private;
+	int pid;
+
+	if (tr) {
+		pid = this_cpu_read(tr->array_buffer.data->ftrace_ignore_pid);
+		if (pid == FTRACE_PID_IGNORE)
+			return 0;
+		if (pid != FTRACE_PID_TRACE &&
+		    pid != current->pid)
+			return 0;
+	}
+
+	return gops->saved_func(trace, gops);
+}
+
+void fgraph_update_pid_func(void)
+{
+	struct fgraph_ops *gops;
+	struct ftrace_ops *op;
+
+	if (!(graph_ops.flags & FTRACE_OPS_FL_INITIALIZED))
+		return;
+
+	list_for_each_entry(op, &graph_ops.subop_list, list) {
+		if (op->flags & FTRACE_OPS_FL_PID) {
+			gops = container_of(op, struct fgraph_ops, ops);
+			gops->entryfunc = ftrace_pids_enabled(op) ?
+				fgraph_pid_func : gops->saved_func;
+		}
+	}
+}
+
 /* Allocate a return stack for each task */
 static int start_graph_tracing(void)
 {
@@ -931,11 +966,15 @@ int register_ftrace_graph(struct fgraph_ops *gops)
 		command = FTRACE_START_FUNC_RET;
 	}
 
+	/* Always save the function, and reset at unregistering */
+	gops->saved_func = gops->entryfunc;
+
 	ret = ftrace_startup_subops(&graph_ops, &gops->ops, command);
 error:
 	if (ret) {
 		fgraph_array[i] = &fgraph_stub;
 		ftrace_graph_active--;
+		gops->saved_func = NULL;
 	}
 out:
 	mutex_unlock(&ftrace_lock);
@@ -979,5 +1018,6 @@ void unregister_ftrace_graph(struct fgraph_ops *gops)
 		unregister_trace_sched_switch(ftrace_graph_probe_sched_switch, NULL);
 	}
  out:
+	gops->saved_func = NULL;
 	mutex_unlock(&ftrace_lock);
 }
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 58e0f4bc0241..da7e6abf48b4 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -100,7 +100,7 @@ struct ftrace_ops *function_trace_op __read_mostly = &ftrace_list_end;
 /* What to set function_trace_op to */
 static struct ftrace_ops *set_function_trace_op;
 
-static bool ftrace_pids_enabled(struct ftrace_ops *ops)
+bool ftrace_pids_enabled(struct ftrace_ops *ops)
 {
 	struct trace_array *tr;
 
@@ -402,10 +402,11 @@ static void ftrace_update_pid_func(void)
 		if (op->flags & FTRACE_OPS_FL_PID) {
 			op->func = ftrace_pids_enabled(op) ?
 				ftrace_pid_func : op->saved_func;
-			ftrace_update_trampoline(op);
 		}
 	} while_for_each_ftrace_op(op);
 
+	fgraph_update_pid_func();
+
 	update_ftrace_function();
 }
 
diff --git a/kernel/trace/ftrace_internal.h b/kernel/trace/ftrace_internal.h
index cdfd12c44ab4..bfba10c2fcf1 100644
--- a/kernel/trace/ftrace_internal.h
+++ b/kernel/trace/ftrace_internal.h
@@ -43,8 +43,10 @@ ftrace_ops_test(struct ftrace_ops *ops, unsigned long ip, void *regs)
 
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 extern int ftrace_graph_active;
+extern void fgraph_update_pid_func(void);
 #else /* !CONFIG_FUNCTION_GRAPH_TRACER */
 # define ftrace_graph_active 0
+static inline void fgraph_update_pid_func(void) {}
 #endif /* CONFIG_FUNCTION_GRAPH_TRACER */
 
 #else /* !CONFIG_FUNCTION_TRACER */
-- 
2.43.0



