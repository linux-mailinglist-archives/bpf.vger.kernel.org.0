Return-Path: <bpf+bounces-19439-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3705D82BE5F
	for <lists+bpf@lfdr.de>; Fri, 12 Jan 2024 11:18:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91295B23698
	for <lists+bpf@lfdr.de>; Fri, 12 Jan 2024 10:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4947D60BB1;
	Fri, 12 Jan 2024 10:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sVs+ZWkM"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB601634EE;
	Fri, 12 Jan 2024 10:15:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05811C433C7;
	Fri, 12 Jan 2024 10:15:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705054517;
	bh=ZExIjzlvIHiWOr1SWHx178nMkcePO/iYDVrSnbmxavo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sVs+ZWkM1z2tZNZ+DnjZcn4KBCmQXe8N3q4G8eQ+q6OdSwvnloEPXyrLXFTIPgN4n
	 8Ri7fORdA5IWI9/KsGqyb6fAvooX1+QJ6ncqYD0a4cm2cs36b1e986EvuCcLO4OaQj
	 lCJcvhjsM9FZVtRPJwt4ucfglRpOnzpt9P49RoF5ZEh3SuEaXQ/0j9hw8XXK2dyyfh
	 PWIyyWI8Gbr7nagl/T8UOdeN/881YeZjANEpPZUY2jGGK9U6oM/sqzpLzzun/4k8Fm
	 MTckFwCwltcO1B9EYotz0ULQBM0sPYA5O0L6vZbolKP9S3M6f+6KcHUCTQY9mDISVL
	 Mc7OLxyF88Hzg==
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
Subject: [PATCH v6 22/36] function_graph: Add a new entry handler with parent_ip and ftrace_regs
Date: Fri, 12 Jan 2024 19:15:11 +0900
Message-Id: <170505451140.459169.10466274060076226583.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <170505424954.459169.10630626365737237288.stgit@devnote2>
References: <170505424954.459169.10630626365737237288.stgit@devnote2>
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

Add a new entry handler to fgraph_ops as 'entryregfunc'  which takes
parent_ip and ftrace_regs. Note that the 'entryfunc' and 'entryregfunc'
are mutual exclusive. You can set only one of them.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 Changes in v3:
  - Update for new multiple fgraph.
---
 arch/arm64/kernel/ftrace.c               |    2 +
 arch/loongarch/kernel/ftrace_dyn.c       |    6 ++++
 arch/powerpc/kernel/trace/ftrace.c       |    2 +
 arch/powerpc/kernel/trace/ftrace_64_pg.c |   10 ++++---
 arch/x86/kernel/ftrace.c                 |   42 ++++++++++++++++--------------
 include/linux/ftrace.h                   |   19 +++++++++++---
 kernel/trace/fgraph.c                    |   30 +++++++++++++++++----
 7 files changed, 76 insertions(+), 35 deletions(-)

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
index 73858c9029cc..39b3f09a5e0c 100644
--- a/arch/loongarch/kernel/ftrace_dyn.c
+++ b/arch/loongarch/kernel/ftrace_dyn.c
@@ -244,7 +244,11 @@ void ftrace_graph_func(unsigned long ip, unsigned long parent_ip,
 	struct pt_regs *regs = &fregs->regs;
 	unsigned long *parent = (unsigned long *)&regs->regs[1];
 
-	prepare_ftrace_return(ip, (unsigned long *)parent);
+	if (unlikely(atomic_read(&current->tracing_graph_pause)))
+		return;
+
+	if (!function_graph_enter_regs(regs->regs[1], ip, 0, parent, fregs))
+		regs->regs[1] = (unsigned long)&return_to_handler;
 }
 #else
 static int ftrace_modify_graph_caller(bool enable)
diff --git a/arch/powerpc/kernel/trace/ftrace.c b/arch/powerpc/kernel/trace/ftrace.c
index 82010629cf88..9bf1b6912116 100644
--- a/arch/powerpc/kernel/trace/ftrace.c
+++ b/arch/powerpc/kernel/trace/ftrace.c
@@ -422,7 +422,7 @@ void ftrace_graph_func(unsigned long ip, unsigned long parent_ip,
 	if (bit < 0)
 		goto out;
 
-	if (!function_graph_enter(parent_ip, ip, 0, (unsigned long *)sp))
+	if (!function_graph_enter_regs(parent_ip, ip, 0, (unsigned long *)sp, fregs))
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
index 815e865f46c9..65d4d4b68768 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -1063,6 +1063,11 @@ typedef void (*trace_func_graph_ret_t)(struct ftrace_graph_ret *,
 typedef int (*trace_func_graph_ent_t)(struct ftrace_graph_ent *,
 				      struct fgraph_ops *); /* entry */
 
+typedef int (*trace_func_graph_regs_ent_t)(unsigned long func,
+					   unsigned long parent_ip,
+					   struct ftrace_regs *fregs,
+					   struct fgraph_ops *); /* entry w/ regs */
+
 extern int ftrace_graph_entry_stub(struct ftrace_graph_ent *trace, struct fgraph_ops *gops);
 
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
@@ -1070,6 +1075,7 @@ extern int ftrace_graph_entry_stub(struct ftrace_graph_ent *trace, struct fgraph
 struct fgraph_ops {
 	trace_func_graph_ent_t		entryfunc;
 	trace_func_graph_ret_t		retfunc;
+	trace_func_graph_regs_ent_t	entryregfunc;
 	struct ftrace_ops		ops; /* for the hash lists */
 	void				*private;
 	int				idx;
@@ -1106,13 +1112,20 @@ struct ftrace_ret_stack {
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
index 6a9206ebc6a2..0cb02de2db70 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -621,9 +621,21 @@ ftrace_push_return_trace(unsigned long ret, unsigned long func,
 # define MCOUNT_INSN_SIZE 0
 #endif
 
+static inline int call_entry_func(struct ftrace_graph_ent *trace,
+				  unsigned long func, unsigned long ret,
+				  struct ftrace_regs *fregs,
+				  struct fgraph_ops *gops)
+{
+	if (gops->entryregfunc)
+		return gops->entryregfunc(func, ret, fregs, gops);
+
+	return gops->entryfunc(trace, gops);
+}
+
 /* If the caller does not use ftrace, call this function. */
-int function_graph_enter(unsigned long ret, unsigned long func,
-			 unsigned long frame_pointer, unsigned long *retp)
+int function_graph_enter_regs(unsigned long ret, unsigned long func,
+			      unsigned long frame_pointer, unsigned long *retp,
+			      struct ftrace_regs *fregs)
 {
 	struct ftrace_graph_ent trace;
 	unsigned long bitmap = 0;
@@ -658,7 +670,7 @@ int function_graph_enter(unsigned long ret, unsigned long func,
 
 		save_curr_ret_stack = current->curr_ret_stack;
 		if (ftrace_ops_test(&gops->ops, func, NULL) &&
-		    gops->entryfunc(&trace, gops))
+		    call_entry_func(&trace, func, ret, fregs, gops))
 			bitmap |= BIT(i);
 		else
 			/* Clear out any saved storage */
@@ -686,6 +698,7 @@ int function_graph_enter(unsigned long ret, unsigned long func,
 /* This is called from ftrace_graph_func() via ftrace */
 int function_graph_enter_ops(unsigned long ret, unsigned long func,
 			     unsigned long frame_pointer, unsigned long *retp,
+			     struct ftrace_regs *fregs,
 			     struct fgraph_ops *gops)
 {
 	struct ftrace_graph_ent trace;
@@ -710,7 +723,7 @@ int function_graph_enter_ops(unsigned long ret, unsigned long func,
 	trace.func = func;
 	trace.depth = current->curr_ret_depth;
 	save_curr_ret_stack = current->curr_ret_stack;
-	if (gops->entryfunc(&trace, gops)) {
+	if (call_entry_func(&trace, func, ret, fregs, gops)) {
 		if (type == FGRAPH_TYPE_RESERVED)
 			set_fgraph_index_bitmap(current, index, BIT(gops->idx));
 		else
@@ -993,7 +1006,8 @@ void fgraph_init_ops(struct ftrace_ops *dst_ops,
 		     struct ftrace_ops *src_ops)
 {
 	dst_ops->func = ftrace_graph_func;
-	dst_ops->flags = FTRACE_OPS_FL_PID | FTRACE_OPS_GRAPH_STUB;
+	dst_ops->flags = FTRACE_OPS_FL_PID | FTRACE_OPS_GRAPH_STUB |
+			 FTRACE_OPS_FL_SAVE_ARGS;
 
 #ifdef FTRACE_GRAPH_TRAMP_ADDR
 	dst_ops->trampoline = FTRACE_GRAPH_TRAMP_ADDR;
@@ -1239,10 +1253,14 @@ int register_ftrace_graph(struct fgraph_ops *gops)
 	int ret = 0;
 	int i;
 
+	if (gops->entryfunc && gops->entryregfunc)
+		return -EINVAL;
+
 	mutex_lock(&ftrace_lock);
 
 	if (!gops->ops.func) {
-		gops->ops.flags |= FTRACE_OPS_GRAPH_STUB;
+		gops->ops.flags |= FTRACE_OPS_GRAPH_STUB |
+				   FTRACE_OPS_FL_SAVE_ARGS;
 		gops->ops.func = ftrace_graph_func;
 #ifdef FTRACE_GRAPH_TRAMP_ADDR
 		gops->ops.trampoline = FTRACE_GRAPH_TRAMP_ADDR;


