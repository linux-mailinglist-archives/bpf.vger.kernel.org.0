Return-Path: <bpf+bounces-31122-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14F8A8D7354
	for <lists+bpf@lfdr.de>; Sun,  2 Jun 2024 05:38:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C45DD281FAC
	for <lists+bpf@lfdr.de>; Sun,  2 Jun 2024 03:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6719376E9;
	Sun,  2 Jun 2024 03:37:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 658F12C1AC;
	Sun,  2 Jun 2024 03:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717299446; cv=none; b=DgagxqGusNrqKXJtH8Qcgqjv7tIt/OxC53QlXhocv8avd8GMyGd7/oqx7is/1GtjFyueuIqaADZqplmF6c/1MY5nzmVcHhSnTjS86KFZWvGbfrkfEMi9vwZPjsnhCBGSjSOm6V3ITkXqzCPzeSFaA+OzoLU0VadZAju30+sWmP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717299446; c=relaxed/simple;
	bh=8/pKcynJXAG5PPsFGs5F3z83pmXsdMHN8whmpWMDH2A=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=AJyUO5DgP0/Fl3pTxBYFPTUhcvsJrY5T/rymP9n2ByJr2l4e0fh4KNQfVvWpXLlzV6Ev9fqXmchmiT0EAmlrNbvyKFa6wPVB7d+WMX0GFj6iymHScF1k0CFEhn3VUzA+T4WG9g5k4jD7pfbDPzwsXwDSLxSh/ye2j4jXrjpZnSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1062DC4AF14;
	Sun,  2 Jun 2024 03:37:26 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1sDc3F-000000094PR-1QNp;
	Sat, 01 Jun 2024 23:38:33 -0400
Message-ID: <20240602033833.192386089@goodmis.org>
User-Agent: quilt/0.68
Date: Sat, 01 Jun 2024 23:37:57 -0400
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
Subject: [PATCH v2 13/27] function_graph: Add pid tracing back to function graph tracer
References: <20240602033744.563858532@goodmis.org>
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
index 3615614bd116..41fabc6d30e4 100644
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



