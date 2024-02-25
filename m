Return-Path: <bpf+bounces-22661-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B1D6862B09
	for <lists+bpf@lfdr.de>; Sun, 25 Feb 2024 16:17:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CBBC8B20E1D
	for <lists+bpf@lfdr.de>; Sun, 25 Feb 2024 15:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4D64171B6;
	Sun, 25 Feb 2024 15:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qXGXVpGl"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25573171C8;
	Sun, 25 Feb 2024 15:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708874197; cv=none; b=PLdnTUYZWhUNbx4QawVKYbW9DDKarEDgCwVsZ/ZEHaNF6tZSVi/taP2mgLWLQkL7DTZ37spOUtV8Pg/WG5S6oPkbJ7Vygq+JZJN6P/jkXXrw3pJO2uNG2SKwUQOberLB3FDwtD54WQ1NEy/cLTmq4bk355zOmLfZxaIQzJqScmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708874197; c=relaxed/simple;
	bh=WWUXf+6wuLAeTB0u+5WPCf6XUJQtEct3UDtGyxF5nGA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cbB8EJDE1iads3XfLRPScd/Yz91xF2mXnerJHQCmd1ceIKcD01j18lMuPz+XS0cvS99ooJGtSfjZZI+SyolO/mmdCyrwk6WJ6S8QhrsEIWersEjTzgYq5gEDMZVoC2B7KY1zZwcz1EBKygHkw+M/csdna9JclNgTRfpTKwDrI4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qXGXVpGl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE787C43390;
	Sun, 25 Feb 2024 15:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708874197;
	bh=WWUXf+6wuLAeTB0u+5WPCf6XUJQtEct3UDtGyxF5nGA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qXGXVpGlcTj91ld5XpntSY4IOPaeYk2wlr4ZWDH41q+h1TE0oba8uCuxz4sOoNTR4
	 gCBB2XhF5sx/d1POqDO9jkovCrHUbJk0nuwxnyJDmTt7xzR3zE8ljtH8SadUuXwD89
	 m+u1fWTioKqozyBbBLGHctSWCsNDSD/h9weVc3uGkV3znowg+dZZ+dhcZqUwACezPX
	 NwO9Bi7tn8Sw8+ENvbQ92ZM/Q6w45IZbOchBPzj3BtCjzt9k3+AmCIlQ3ceiRSfKLr
	 zn9GbmhaRNPXmEJoO9awaLEp1uxkH1R8McznJrSreIM54hXg7uYznEAi8AQHdfNPDT
	 2VPmVFdHuSySA==
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
Subject: [PATCH v8 08/35] function_graph: Remove logic around ftrace_graph_entry and return
Date: Mon, 26 Feb 2024 00:16:31 +0900
Message-Id: <170887419128.564249.9971360853259797414.stgit@devnote2>
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

From: Steven Rostedt (VMware) <rostedt@goodmis.org>

The function pointers ftrace_graph_entry and ftrace_graph_return are no
longer called via the function_graph tracer. Instead, an array structure is
now used that will allow for multiple users of the function_graph
infrastructure. The variables are still used by the architecture code for
non dynamic ftrace configs, where a test is made against them to see if
they point to the default stub function or not. This is how the static
function tracing knows to call into the function graph tracer
infrastructure or not.

Two new stub functions are made. entry_run() and return_run(). The
ftrace_graph_entry and ftrace_graph_return are set to them respectively
when the function graph tracer is enabled, and this will trigger the
architecture specific function graph code to be executed.

This also requires checking the global_ops hash for all calls into the
function_graph tracer.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 Changes in v2:
  - Fix typo and make lines shorter than 76 chars in the description.
  - Remove unneeded return from return_run() function.
---
 kernel/trace/fgraph.c          |   67 +++++++++-------------------------------
 kernel/trace/ftrace.c          |    2 -
 kernel/trace/ftrace_internal.h |    2 -
 3 files changed, 15 insertions(+), 56 deletions(-)

diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index b9a2399b75ee..6f3ba8e113c1 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -145,6 +145,17 @@ add_fgraph_index_bitmap(struct task_struct *t, int offset, unsigned long bitmap)
 	t->ret_stack[offset] |= (bitmap << FGRAPH_INDEX_SHIFT);
 }
 
+/* ftrace_graph_entry set to this to tell some archs to run function graph */
+static int entry_run(struct ftrace_graph_ent *trace)
+{
+	return 0;
+}
+
+/* ftrace_graph_return set to this to tell some archs to run function graph */
+static void return_run(struct ftrace_graph_ret *trace)
+{
+}
+
 /*
  * @offset: The index into @t->ret_stack to find the ret_stack entry
  * @index: Where to place the index into @t->ret_stack of that entry
@@ -675,7 +686,6 @@ extern void ftrace_stub_graph(struct ftrace_graph_ret *);
 /* The callbacks that hook a function */
 trace_func_graph_ret_t ftrace_graph_return = ftrace_stub_graph;
 trace_func_graph_ent_t ftrace_graph_entry = ftrace_graph_entry_stub;
-static trace_func_graph_ent_t __ftrace_graph_entry = ftrace_graph_entry_stub;
 
 /* Try to assign a return stack array on FTRACE_RETSTACK_ALLOC_SIZE tasks. */
 static int alloc_retstack_tasklist(unsigned long **ret_stack_list)
@@ -758,46 +768,6 @@ ftrace_graph_probe_sched_switch(void *ignore, bool preempt,
 	}
 }
 
-static int ftrace_graph_entry_test(struct ftrace_graph_ent *trace)
-{
-	if (!ftrace_ops_test(&global_ops, trace->func, NULL))
-		return 0;
-	return __ftrace_graph_entry(trace);
-}
-
-/*
- * The function graph tracer should only trace the functions defined
- * by set_ftrace_filter and set_ftrace_notrace. If another function
- * tracer ops is registered, the graph tracer requires testing the
- * function against the global ops, and not just trace any function
- * that any ftrace_ops registered.
- */
-void update_function_graph_func(void)
-{
-	struct ftrace_ops *op;
-	bool do_test = false;
-
-	/*
-	 * The graph and global ops share the same set of functions
-	 * to test. If any other ops is on the list, then
-	 * the graph tracing needs to test if its the function
-	 * it should call.
-	 */
-	do_for_each_ftrace_op(op, ftrace_ops_list) {
-		if (op != &global_ops && op != &graph_ops &&
-		    op != &ftrace_list_end) {
-			do_test = true;
-			/* in double loop, break out with goto */
-			goto out;
-		}
-	} while_for_each_ftrace_op(op);
- out:
-	if (do_test)
-		ftrace_graph_entry = ftrace_graph_entry_test;
-	else
-		ftrace_graph_entry = __ftrace_graph_entry;
-}
-
 static DEFINE_PER_CPU(unsigned long *, idle_ret_stack);
 
 static void
@@ -939,18 +909,12 @@ int register_ftrace_graph(struct fgraph_ops *gops)
 			ftrace_graph_active--;
 			goto out;
 		}
-
-		ftrace_graph_return = gops->retfunc;
-
 		/*
-		 * Update the indirect function to the entryfunc, and the
-		 * function that gets called to the entry_test first. Then
-		 * call the update fgraph entry function to determine if
-		 * the entryfunc should be called directly or not.
+		 * Some archs just test to see if these are not
+		 * the default function
 		 */
-		__ftrace_graph_entry = gops->entryfunc;
-		ftrace_graph_entry = ftrace_graph_entry_test;
-		update_function_graph_func();
+		ftrace_graph_return = return_run;
+		ftrace_graph_entry = entry_run;
 
 		ret = ftrace_startup(&graph_ops, FTRACE_START_FUNC_RET);
 	}
@@ -986,7 +950,6 @@ void unregister_ftrace_graph(struct fgraph_ops *gops)
 	if (!ftrace_graph_active) {
 		ftrace_graph_return = ftrace_stub_graph;
 		ftrace_graph_entry = ftrace_graph_entry_stub;
-		__ftrace_graph_entry = ftrace_graph_entry_stub;
 		ftrace_shutdown(&graph_ops, FTRACE_STOP_FUNC_RET);
 		unregister_pm_notifier(&ftrace_suspend_notifier);
 		unregister_trace_sched_switch(ftrace_graph_probe_sched_switch, NULL);
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index c060d5b47910..11aac697d40f 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -235,8 +235,6 @@ static void update_ftrace_function(void)
 		func = ftrace_ops_list_func;
 	}
 
-	update_function_graph_func();
-
 	/* If there's no change, then do nothing more here */
 	if (ftrace_trace_function == func)
 		return;
diff --git a/kernel/trace/ftrace_internal.h b/kernel/trace/ftrace_internal.h
index 5012c04f92c0..19eddcb91584 100644
--- a/kernel/trace/ftrace_internal.h
+++ b/kernel/trace/ftrace_internal.h
@@ -42,10 +42,8 @@ ftrace_ops_test(struct ftrace_ops *ops, unsigned long ip, void *regs)
 
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 extern int ftrace_graph_active;
-void update_function_graph_func(void);
 #else /* !CONFIG_FUNCTION_GRAPH_TRACER */
 # define ftrace_graph_active 0
-static inline void update_function_graph_func(void) { }
 #endif /* CONFIG_FUNCTION_GRAPH_TRACER */
 
 #else /* !CONFIG_FUNCTION_TRACER */


