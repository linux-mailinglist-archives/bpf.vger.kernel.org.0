Return-Path: <bpf+bounces-22674-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 142DE862B23
	for <lists+bpf@lfdr.de>; Sun, 25 Feb 2024 16:20:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37E0A1C20F3F
	for <lists+bpf@lfdr.de>; Sun, 25 Feb 2024 15:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BFD3156C2;
	Sun, 25 Feb 2024 15:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L5oXcZC6"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D3831BC35;
	Sun, 25 Feb 2024 15:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708874338; cv=none; b=W1I1Nej7UoyWjOxcbQFsJArLD0b7s1tWhyFTchBlS8DMhbHkOXcP1YdL88DEnQq8b47/tlpsnE+txELoBDRlpgfjPgXJU3JelQwouywCGj8Q/aOpyl6ieT+J1MpunkXJ2WIKe/ZKZzXXiPq5KlgP9p1Q3FDS40PG3dDA/Djb00o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708874338; c=relaxed/simple;
	bh=dT1Z3V/NtEpkO64m/MKpRVpBJ4zFqQejuDrPApRHRGM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m6edIJ0eqB3kzJSbou3RTzXMARVW0HKRSAl9kdd/p3ypZzlnrceBLbBadDzubd347T6sIsxOWvGyLcJwG+J/AI7X+gB7r/ldCW/TXC2cXmE5P4UHi5g+kAWM0bnUIg9BST0iiLgOzSfhnliJAE6BBnkDUDnsqR0c3ZWNkA6KCaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L5oXcZC6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41522C433F1;
	Sun, 25 Feb 2024 15:18:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708874337;
	bh=dT1Z3V/NtEpkO64m/MKpRVpBJ4zFqQejuDrPApRHRGM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L5oXcZC6Xl3IXC3thXnFLX/hq2eNE+LwZeaq+BnoJ0ON3zu/T/IJ0XJi9bYyeskOh
	 +1QQUZJgSbakbqvqScec8d8Gk/r4C9yNF6C4RNBu5++Etj29+FDBpDNHvQnLyQ0qrz
	 gEoDvhhcR/p3usJ6qsDIKJIbH0CXBEdUzNlsQxZskq0z84iprRGMu1OJjXVVp5lacg
	 bwuOXPHKb3m3ovL9CJwwSLxVCKK0RUaxy+WNO70j7nCWYdyCcqGo1NB2NYe4cVcPLa
	 IFY0+QC/oJa0XhiGbsNDmIGJNI1M9fCtD9HYFbhYsOgPbbRpUYIjMISoRHHqudXuAB
	 UdL3/uwwgPmLg==
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
Subject: [PATCH v8 21/35] function_graph: Pass ftrace_regs to entryfunc
Date: Mon, 26 Feb 2024 00:18:52 +0900
Message-Id: <170887433193.564249.17763519546679566019.stgit@devnote2>
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

Pass ftrace_regs to the fgraph_ops::entryfunc(). If ftrace_regs is not
available, it passes a NULL instead. User callback function can access
some registers (including return address) via this ftrace_regs.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 Changes in v8:
  - Just pass ftrace_regs to the handler instead of adding a new
    entryregfunc.
  - Update riscv ftrace_graph_func().
 Changes in v3:
  - Update for new multiple fgraph.
---
 arch/arm64/kernel/ftrace.c               |    2 +
 arch/loongarch/kernel/ftrace_dyn.c       |    2 +
 arch/powerpc/kernel/trace/ftrace.c       |    2 +
 arch/powerpc/kernel/trace/ftrace_64_pg.c |   10 ++++---
 arch/riscv/kernel/ftrace.c               |    2 +
 arch/x86/kernel/ftrace.c                 |   42 ++++++++++++++++--------------
 include/linux/ftrace.h                   |   20 +++++++++++---
 kernel/trace/fgraph.c                    |   21 +++++++++------
 kernel/trace/ftrace.c                    |    3 +-
 kernel/trace/trace.h                     |    3 +-
 kernel/trace/trace_functions_graph.c     |    3 +-
 kernel/trace/trace_irqsoff.c             |    3 +-
 kernel/trace/trace_sched_wakeup.c        |    3 +-
 kernel/trace/trace_selftest.c            |    8 ++++--
 14 files changed, 76 insertions(+), 48 deletions(-)

diff --git a/arch/arm64/kernel/ftrace.c b/arch/arm64/kernel/ftrace.c
index b96740829798..779b975f03f5 100644
--- a/arch/arm64/kernel/ftrace.c
+++ b/arch/arm64/kernel/ftrace.c
@@ -497,7 +497,7 @@ void ftrace_graph_func(unsigned long ip, unsigned long parent_ip,
 		return;
 
 	if (!function_graph_enter_ops(*parent, ip, frame_pointer,
-				      (void *)frame_pointer, gops))
+				      (void *)frame_pointer, fregs, gops))
 		*parent = (unsigned long)&return_to_handler;
 
 	ftrace_test_recursion_unlock(bit);
diff --git a/arch/loongarch/kernel/ftrace_dyn.c b/arch/loongarch/kernel/ftrace_dyn.c
index 920eb673b32b..155bdaba2012 100644
--- a/arch/loongarch/kernel/ftrace_dyn.c
+++ b/arch/loongarch/kernel/ftrace_dyn.c
@@ -254,7 +254,7 @@ void ftrace_graph_func(unsigned long ip, unsigned long parent_ip,
 
 	old = *parent;
 
-	if (!function_graph_enter_ops(old, ip, 0, parent, gops))
+	if (!function_graph_enter_ops(old, ip, 0, parent, fregs, gops))
 		*parent = return_hooker;
 }
 #else
diff --git a/arch/powerpc/kernel/trace/ftrace.c b/arch/powerpc/kernel/trace/ftrace.c
index 4ef8bf480279..eeaaa798f4f9 100644
--- a/arch/powerpc/kernel/trace/ftrace.c
+++ b/arch/powerpc/kernel/trace/ftrace.c
@@ -423,7 +423,7 @@ void ftrace_graph_func(unsigned long ip, unsigned long parent_ip,
 	if (bit < 0)
 		goto out;
 
-	if (!function_graph_enter_ops(parent_ip, ip, 0, (unsigned long *)sp, gops))
+	if (!function_graph_enter_ops(parent_ip, ip, 0, (unsigned long *)sp, fregs, gops))
 		parent_ip = ppc_function_entry(return_to_handler);
 
 	ftrace_test_recursion_unlock(bit);
diff --git a/arch/powerpc/kernel/trace/ftrace_64_pg.c b/arch/powerpc/kernel/trace/ftrace_64_pg.c
index 7b85c3b460a3..43f6cfaaf7db 100644
--- a/arch/powerpc/kernel/trace/ftrace_64_pg.c
+++ b/arch/powerpc/kernel/trace/ftrace_64_pg.c
@@ -795,7 +795,8 @@ int ftrace_disable_ftrace_graph_caller(void)
  * in current thread info. Return the address we want to divert to.
  */
 static unsigned long
-__prepare_ftrace_return(unsigned long parent, unsigned long ip, unsigned long sp)
+__prepare_ftrace_return(unsigned long parent, unsigned long ip, unsigned long sp,
+			struct ftrace_regs *fregs)
 {
 	unsigned long return_hooker;
 	int bit;
@@ -812,7 +813,7 @@ __prepare_ftrace_return(unsigned long parent, unsigned long ip, unsigned long sp
 
 	return_hooker = ppc_function_entry(return_to_handler);
 
-	if (!function_graph_enter(parent, ip, 0, (unsigned long *)sp))
+	if (!function_graph_enter_regs(parent, ip, 0, (unsigned long *)sp, fregs))
 		parent = return_hooker;
 
 	ftrace_test_recursion_unlock(bit);
@@ -824,13 +825,14 @@ __prepare_ftrace_return(unsigned long parent, unsigned long ip, unsigned long sp
 void ftrace_graph_func(unsigned long ip, unsigned long parent_ip,
 		       struct ftrace_ops *op, struct ftrace_regs *fregs)
 {
-	fregs->regs.link = __prepare_ftrace_return(parent_ip, ip, fregs->regs.gpr[1]);
+	fregs->regs.link = __prepare_ftrace_return(parent_ip, ip,
+						   fregs->regs.gpr[1], fregs);
 }
 #else
 unsigned long prepare_ftrace_return(unsigned long parent, unsigned long ip,
 				    unsigned long sp)
 {
-	return __prepare_ftrace_return(parent, ip, sp);
+	return __prepare_ftrace_return(parent, ip, sp, NULL);
 }
 #endif
 #endif /* CONFIG_FUNCTION_GRAPH_TRACER */
diff --git a/arch/riscv/kernel/ftrace.c b/arch/riscv/kernel/ftrace.c
index eb86fb005f34..59c2824e2aaf 100644
--- a/arch/riscv/kernel/ftrace.c
+++ b/arch/riscv/kernel/ftrace.c
@@ -197,7 +197,7 @@ void ftrace_graph_func(unsigned long ip, unsigned long parent_ip,
 	 */
 	old = *parent;
 
-	if (!function_graph_enter_ops(old, ip, frame_pointer(regs), parent, gops))
+	if (!function_graph_enter_ops(old, ip, frame_pointer(regs), parent, fregs, gops))
 		*parent = return_hooker;
 }
 #else /* CONFIG_DYNAMIC_FTRACE_WITH_REGS */
diff --git a/arch/x86/kernel/ftrace.c b/arch/x86/kernel/ftrace.c
index 845e29b4254f..0f757e399a96 100644
--- a/arch/x86/kernel/ftrace.c
+++ b/arch/x86/kernel/ftrace.c
@@ -614,16 +614,8 @@ int ftrace_disable_ftrace_graph_caller(void)
 }
 #endif /* CONFIG_DYNAMIC_FTRACE && !CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS */
 
-/*
- * Hook the return address and push it in the stack of return addrs
- * in current thread info.
- */
-void prepare_ftrace_return(unsigned long ip, unsigned long *parent,
-			   unsigned long frame_pointer)
+static inline bool skip_ftrace_return(void)
 {
-	unsigned long return_hooker = (unsigned long)&return_to_handler;
-	int bit;
-
 	/*
 	 * When resuming from suspend-to-ram, this function can be indirectly
 	 * called from early CPU startup code while the CPU is in real mode,
@@ -633,13 +625,28 @@ void prepare_ftrace_return(unsigned long ip, unsigned long *parent,
 	 * This check isn't as accurate as virt_addr_valid(), but it should be
 	 * good enough for this purpose, and it's fast.
 	 */
-	if (unlikely((long)__builtin_frame_address(0) >= 0))
-		return;
+	if ((long)__builtin_frame_address(0) >= 0)
+		return true;
 
-	if (unlikely(ftrace_graph_is_dead()))
-		return;
+	if (ftrace_graph_is_dead())
+		return true;
+
+	if (atomic_read(&current->tracing_graph_pause))
+		return true;
+	return false;
+}
 
-	if (unlikely(atomic_read(&current->tracing_graph_pause)))
+/*
+ * Hook the return address and push it in the stack of return addrs
+ * in current thread info.
+ */
+void prepare_ftrace_return(unsigned long ip, unsigned long *parent,
+			   unsigned long frame_pointer)
+{
+	unsigned long return_hooker = (unsigned long)&return_to_handler;
+	int bit;
+
+	if (unlikely(skip_ftrace_return()))
 		return;
 
 	bit = ftrace_test_recursion_trylock(ip, *parent);
@@ -661,17 +668,14 @@ void ftrace_graph_func(unsigned long ip, unsigned long parent_ip,
 	struct fgraph_ops *gops = container_of(op, struct fgraph_ops, ops);
 	int bit;
 
-	if (unlikely(ftrace_graph_is_dead()))
-		return;
-
-	if (unlikely(atomic_read(&current->tracing_graph_pause)))
+	if (unlikely(skip_ftrace_return()))
 		return;
 
 	bit = ftrace_test_recursion_trylock(ip, *parent);
 	if (bit < 0)
 		return;
 
-	if (!function_graph_enter_ops(*parent, ip, 0, parent, gops))
+	if (!function_graph_enter_ops(*parent, ip, 0, parent, fregs, gops))
 		*parent = (unsigned long)&return_to_handler;
 
 	ftrace_test_recursion_unlock(bit);
diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 815e865f46c9..d0b1077dcf64 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -1061,9 +1061,12 @@ struct fgraph_ops;
 typedef void (*trace_func_graph_ret_t)(struct ftrace_graph_ret *,
 				       struct fgraph_ops *); /* return */
 typedef int (*trace_func_graph_ent_t)(struct ftrace_graph_ent *,
-				      struct fgraph_ops *); /* entry */
+				      struct fgraph_ops *,
+				      struct ftrace_regs *); /* entry */
 
-extern int ftrace_graph_entry_stub(struct ftrace_graph_ent *trace, struct fgraph_ops *gops);
+extern int ftrace_graph_entry_stub(struct ftrace_graph_ent *trace,
+				   struct fgraph_ops *gops,
+				   struct ftrace_regs *fregs);
 
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 
@@ -1106,13 +1109,20 @@ struct ftrace_ret_stack {
 extern void return_to_handler(void);
 
 extern int
-function_graph_enter(unsigned long ret, unsigned long func,
-		     unsigned long frame_pointer, unsigned long *retp);
+function_graph_enter_regs(unsigned long ret, unsigned long func,
+			  unsigned long frame_pointer, unsigned long *retp,
+			  struct ftrace_regs *fregs);
+
+static inline int function_graph_enter(unsigned long ret, unsigned long func,
+				       unsigned long fp, unsigned long *retp)
+{
+	return function_graph_enter_regs(ret, func, fp, retp, NULL);
+}
 
 extern int
 function_graph_enter_ops(unsigned long ret, unsigned long func,
 			 unsigned long frame_pointer, unsigned long *retp,
-			 struct fgraph_ops *gops);
+			 struct ftrace_regs *fregs, struct fgraph_ops *gops);
 
 struct ftrace_ret_stack *
 ftrace_graph_get_ret_stack(struct task_struct *task, int idx);
diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index 66d9ce78b292..ea5b0338e254 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -248,7 +248,8 @@ static inline unsigned long make_fgraph_data(int idx, int size, int offset)
 }
 
 /* ftrace_graph_entry set to this to tell some archs to run function graph */
-static int entry_run(struct ftrace_graph_ent *trace, struct fgraph_ops *ops)
+static int entry_run(struct ftrace_graph_ent *trace, struct fgraph_ops *ops,
+		     struct ftrace_regs *fregs)
 {
 	return 0;
 }
@@ -440,7 +441,7 @@ int __weak ftrace_disable_ftrace_graph_caller(void)
 #endif
 
 int ftrace_graph_entry_stub(struct ftrace_graph_ent *trace,
-			    struct fgraph_ops *gops)
+			    struct fgraph_ops *gops, struct ftrace_regs *fregs)
 {
 	return 0;
 }
@@ -574,8 +575,9 @@ ftrace_push_return_trace(unsigned long ret, unsigned long func,
 #endif
 
 /* If the caller does not use ftrace, call this function. */
-int function_graph_enter(unsigned long ret, unsigned long func,
-			 unsigned long frame_pointer, unsigned long *retp)
+int function_graph_enter_regs(unsigned long ret, unsigned long func,
+			      unsigned long frame_pointer, unsigned long *retp,
+			      struct ftrace_regs *fregs)
 {
 	struct ftrace_graph_ent trace;
 	unsigned long bitmap = 0;
@@ -610,7 +612,7 @@ int function_graph_enter(unsigned long ret, unsigned long func,
 
 		save_curr_ret_stack = current->curr_ret_stack;
 		if (ftrace_ops_test(&gops->ops, func, NULL) &&
-		    gops->entryfunc(&trace, gops))
+		    gops->entryfunc(&trace, gops, fregs))
 			bitmap |= BIT(i);
 		else
 			/* Clear out any saved storage */
@@ -637,6 +639,7 @@ int function_graph_enter(unsigned long ret, unsigned long func,
 /* This is called from ftrace_graph_func() via ftrace */
 int function_graph_enter_ops(unsigned long ret, unsigned long func,
 			     unsigned long frame_pointer, unsigned long *retp,
+			     struct ftrace_regs *fregs,
 			     struct fgraph_ops *gops)
 {
 	struct ftrace_graph_ent trace;
@@ -661,7 +664,7 @@ int function_graph_enter_ops(unsigned long ret, unsigned long func,
 	trace.func = func;
 	trace.depth = current->curr_ret_depth;
 	save_curr_ret_stack = current->curr_ret_stack;
-	if (gops->entryfunc(&trace, gops)) {
+	if (gops->entryfunc(&trace, gops, fregs)) {
 		if (type == FGRAPH_TYPE_RESERVED)
 			set_fgraph_index_bitmap(current, index, BIT(gops->idx));
 		else
@@ -942,7 +945,8 @@ void fgraph_init_ops(struct ftrace_ops *dst_ops,
 		     struct ftrace_ops *src_ops)
 {
 	dst_ops->func = ftrace_graph_func;
-	dst_ops->flags = FTRACE_OPS_FL_PID | FTRACE_OPS_GRAPH_STUB;
+	dst_ops->flags = FTRACE_OPS_FL_PID | FTRACE_OPS_GRAPH_STUB |
+			 FTRACE_OPS_FL_SAVE_ARGS;
 
 #ifdef FTRACE_GRAPH_TRAMP_ADDR
 	dst_ops->trampoline = FTRACE_GRAPH_TRAMP_ADDR;
@@ -1187,7 +1191,8 @@ int register_ftrace_graph(struct fgraph_ops *gops)
 	mutex_lock(&ftrace_lock);
 
 	if (!gops->ops.func) {
-		gops->ops.flags |= FTRACE_OPS_GRAPH_STUB;
+		gops->ops.flags |= FTRACE_OPS_GRAPH_STUB |
+				   FTRACE_OPS_FL_SAVE_ARGS;
 		gops->ops.func = ftrace_graph_func;
 #ifdef FTRACE_GRAPH_TRAMP_ADDR
 		gops->ops.trampoline = FTRACE_GRAPH_TRAMP_ADDR;
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index eeb736582e46..162ece7a39b4 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -816,7 +816,8 @@ void ftrace_graph_graph_time_control(bool enable)
 }
 
 static int profile_graph_entry(struct ftrace_graph_ent *trace,
-			       struct fgraph_ops *gops)
+			       struct fgraph_ops *gops,
+			       struct ftrace_regs *fregs)
 {
 	struct ftrace_ret_stack *ret_stack;
 
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 029a80a38c23..53adc73c460b 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -682,7 +682,8 @@ void trace_default_header(struct seq_file *m);
 void print_trace_header(struct seq_file *m, struct trace_iterator *iter);
 
 void trace_graph_return(struct ftrace_graph_ret *trace, struct fgraph_ops *gops);
-int trace_graph_entry(struct ftrace_graph_ent *trace, struct fgraph_ops *gops);
+int trace_graph_entry(struct ftrace_graph_ent *trace, struct fgraph_ops *gops,
+		      struct ftrace_regs *fregs);
 
 void tracing_start_cmdline_record(void);
 void tracing_stop_cmdline_record(void);
diff --git a/kernel/trace/trace_functions_graph.c b/kernel/trace/trace_functions_graph.c
index 13d0387ac6a6..b9785fc919c9 100644
--- a/kernel/trace/trace_functions_graph.c
+++ b/kernel/trace/trace_functions_graph.c
@@ -128,7 +128,8 @@ static inline int ftrace_graph_ignore_irqs(void)
 }
 
 int trace_graph_entry(struct ftrace_graph_ent *trace,
-		      struct fgraph_ops *gops)
+		      struct fgraph_ops *gops,
+		      struct ftrace_regs *fregs)
 {
 	unsigned long *task_var = fgraph_get_task_var(gops);
 	struct trace_array *tr = gops->private;
diff --git a/kernel/trace/trace_irqsoff.c b/kernel/trace/trace_irqsoff.c
index fce064e20570..ad739d76fc86 100644
--- a/kernel/trace/trace_irqsoff.c
+++ b/kernel/trace/trace_irqsoff.c
@@ -176,7 +176,8 @@ static int irqsoff_display_graph(struct trace_array *tr, int set)
 }
 
 static int irqsoff_graph_entry(struct ftrace_graph_ent *trace,
-			       struct fgraph_ops *gops)
+			       struct fgraph_ops *gops,
+			       struct ftrace_regs *fregs)
 {
 	struct trace_array *tr = irqsoff_trace;
 	struct trace_array_cpu *data;
diff --git a/kernel/trace/trace_sched_wakeup.c b/kernel/trace/trace_sched_wakeup.c
index 130ca7e7787e..23360a2700de 100644
--- a/kernel/trace/trace_sched_wakeup.c
+++ b/kernel/trace/trace_sched_wakeup.c
@@ -113,7 +113,8 @@ static int wakeup_display_graph(struct trace_array *tr, int set)
 }
 
 static int wakeup_graph_entry(struct ftrace_graph_ent *trace,
-			      struct fgraph_ops *gops)
+			      struct fgraph_ops *gops,
+			      struct ftrace_regs *fregs)
 {
 	struct trace_array *tr = wakeup_trace;
 	struct trace_array_cpu *data;
diff --git a/kernel/trace/trace_selftest.c b/kernel/trace/trace_selftest.c
index ca1687b274bc..1c3faaeae979 100644
--- a/kernel/trace/trace_selftest.c
+++ b/kernel/trace/trace_selftest.c
@@ -773,7 +773,8 @@ struct fgraph_fixture {
 };
 
 static __init int store_entry(struct ftrace_graph_ent *trace,
-			      struct fgraph_ops *gops)
+			      struct fgraph_ops *gops,
+			      struct ftrace_regs *fregs)
 {
 	struct fgraph_fixture *fixture = container_of(gops, struct fgraph_fixture, gops);
 	const char *type = fixture->store_type_name;
@@ -1011,7 +1012,8 @@ static unsigned int graph_hang_thresh;
 
 /* Wrap the real function entry probe to avoid possible hanging */
 static int trace_graph_entry_watchdog(struct ftrace_graph_ent *trace,
-				      struct fgraph_ops *gops)
+				      struct fgraph_ops *gops,
+				      struct ftrace_regs *fregs)
 {
 	/* This is harmlessly racy, we want to approximately detect a hang */
 	if (unlikely(++graph_hang_thresh > GRAPH_MAX_FUNC_TEST)) {
@@ -1025,7 +1027,7 @@ static int trace_graph_entry_watchdog(struct ftrace_graph_ent *trace,
 		return 0;
 	}
 
-	return trace_graph_entry(trace, gops);
+	return trace_graph_entry(trace, gops, fregs);
 }
 
 static struct fgraph_ops fgraph_ops __initdata  = {


