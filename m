Return-Path: <bpf+bounces-14501-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D3007E58D4
	for <lists+bpf@lfdr.de>; Wed,  8 Nov 2023 15:28:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98CF1B20ECC
	for <lists+bpf@lfdr.de>; Wed,  8 Nov 2023 14:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C14CB1A71E;
	Wed,  8 Nov 2023 14:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nFOZl5L7"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E451A594;
	Wed,  8 Nov 2023 14:28:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E3C7C433C8;
	Wed,  8 Nov 2023 14:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699453686;
	bh=jLMjEjIxNZnCR94VOjsrLUE58v2e4iqVw76XXqL+4Is=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nFOZl5L7vxOmcDA+4PS3zuMng1NRaIxq2qFkKYIxcFGbhl8ZmXYNmtJ1V9tlvGCiC
	 w4ZmK3vuUpMP1lcO7/3FZeJpU8pcqqF2/rHtxk3R1sHmcza68XIwFIQAp7/nqdiKf8
	 P2gSqe4q04WOP6Z5mb18dcg62r5rehPDo47UIiTQ3Dgs5KCcr+UrNUJtOH3fMB3Tny
	 1JOjb6NUQbNj1anE+cRvog0m20xF3fpqLwFPF05PYHgXgSGW/oCfZGSdpXrvcpIolL
	 WyQvcjm35zmZYLGH2WpiZDCznHw+jxNiMdiCNgMK/urr2hVCrtGGaI9X6x87BZArxB
	 uX6D6N3gjFtEA==
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
Subject: [RFC PATCH v2 19/31] function_graph: Add a new entry handler with parent_ip and ftrace_regs
Date: Wed,  8 Nov 2023 23:28:00 +0900
Message-Id: <169945368028.55307.5557441362824802207.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <169945345785.55307.5003201137843449313.stgit@devnote2>
References: <169945345785.55307.5003201137843449313.stgit@devnote2>
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
 arch/arm64/kernel/ftrace.c               |    8 ++++-
 arch/loongarch/kernel/ftrace_dyn.c       |    6 +++-
 arch/powerpc/kernel/trace/ftrace.c       |    2 +
 arch/powerpc/kernel/trace/ftrace_64_pg.c |   10 ++++--
 arch/x86/kernel/ftrace.c                 |   50 ++++++++++++++++++++----------
 include/linux/ftrace.h                   |   17 +++++++++-
 kernel/trace/fgraph.c                    |   27 +++++++++++++---
 7 files changed, 90 insertions(+), 30 deletions(-)

diff --git a/arch/arm64/kernel/ftrace.c b/arch/arm64/kernel/ftrace.c
index a650f5e11fc5..e94d9dc13d89 100644
--- a/arch/arm64/kernel/ftrace.c
+++ b/arch/arm64/kernel/ftrace.c
@@ -481,7 +481,13 @@ void prepare_ftrace_return(unsigned long self_addr, unsigned long *parent,
 void ftrace_graph_func(unsigned long ip, unsigned long parent_ip,
 		       struct ftrace_ops *op, struct ftrace_regs *fregs)
 {
-	prepare_ftrace_return(ip, &fregs->lr, fregs->fp);
+	if (unlikely(atomic_read(&current->tracing_graph_pause)))
+		return;
+
+	if (!function_graph_enter_regs(fregs->lr, ip, fregs->fp,
+				       (void *)fregs->fp, fregs)) {
+		fregs->lr = (unsigned long)&return_to_handler;
+	}
 }
 #else
 /*
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
index 12df54ff0e81..85247a8f265b 100644
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
+
+/*
+ * Hook the return address and push it in the stack of return addrs
+ * in current thread info.
+ */
+void prepare_ftrace_return(unsigned long ip, unsigned long *parent,
+			   unsigned long frame_pointer)
+{
+	unsigned long return_hooker = (unsigned long)&return_to_handler;
+	int bit;
 
-	if (unlikely(atomic_read(&current->tracing_graph_pause)))
+	if (unlikely(skip_ftrace_return()))
 		return;
 
 	bit = ftrace_test_recursion_trylock(ip, *parent);
@@ -657,9 +664,20 @@ void ftrace_graph_func(unsigned long ip, unsigned long parent_ip,
 		       struct ftrace_ops *op, struct ftrace_regs *fregs)
 {
 	struct pt_regs *regs = &fregs->regs;
-	unsigned long *stack = (unsigned long *)kernel_stack_pointer(regs);
+	unsigned long *parent = (unsigned long *)kernel_stack_pointer(regs);
+	int bit;
 
-	prepare_ftrace_return(ip, (unsigned long *)stack, 0);
+	if (unlikely(skip_ftrace_return()))
+		return;
+
+	bit = ftrace_test_recursion_trylock(ip, *parent);
+	if (bit < 0)
+		return;
+
+	if (!function_graph_enter_regs(*parent, ip, 0, parent, fregs))
+		*parent = (unsigned long)&return_to_handler;
+
+	ftrace_test_recursion_unlock(bit);
 }
 #endif
 
diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 3bc01329548b..c91b234949d5 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -1062,6 +1062,11 @@ typedef void (*trace_func_graph_ret_t)(struct ftrace_graph_ret *,
 typedef int (*trace_func_graph_ent_t)(struct ftrace_graph_ent *,
 				      struct fgraph_ops *); /* entry */
 
+typedef int (*trace_func_graph_regs_ent_t)(unsigned long func,
+					   unsigned long parent_ip,
+					   struct ftrace_regs *fregs,
+					   struct fgraph_ops *); /* entry w/ regs */
+
 extern int ftrace_graph_entry_stub(struct ftrace_graph_ent *trace, struct fgraph_ops *gops);
 
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
@@ -1069,6 +1074,7 @@ extern int ftrace_graph_entry_stub(struct ftrace_graph_ent *trace, struct fgraph
 struct fgraph_ops {
 	trace_func_graph_ent_t		entryfunc;
 	trace_func_graph_ret_t		retfunc;
+	trace_func_graph_regs_ent_t	entryregfunc;
 	struct ftrace_ops		ops; /* for the hash lists */
 	void				*private;
 	int				idx;
@@ -1105,8 +1111,15 @@ struct ftrace_ret_stack {
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
 
 struct ftrace_ret_stack *
 ftrace_graph_get_ret_stack(struct task_struct *task, int idx);
diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index 4d8664942335..6567b18c6c54 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -511,8 +511,20 @@ ftrace_push_return_trace(unsigned long ret, unsigned long func,
 # define MCOUNT_INSN_SIZE 0
 #endif
 
-int function_graph_enter(unsigned long ret, unsigned long func,
-			 unsigned long frame_pointer, unsigned long *retp)
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
+int function_graph_enter_regs(unsigned long ret, unsigned long func,
+			      unsigned long frame_pointer, unsigned long *retp,
+			      struct ftrace_regs *fregs)
 {
 	struct ftrace_graph_ent trace;
 	int save_curr_ret_stack;
@@ -557,7 +569,7 @@ int function_graph_enter(unsigned long ret, unsigned long func,
 		}
 		save_curr_ret_stack = current->curr_ret_stack;
 		if (ftrace_ops_test(&gops->ops, func, NULL) &&
-		    gops->entryfunc(&trace, gops)) {
+		    call_entry_func(&trace, func, ret, fregs, gops)) {
 			/* Note, curr_ret_stack could change by enryfunc() */
 			offset = current->curr_ret_stack;
 			/* Check the top level stored word */
@@ -875,7 +887,8 @@ void fgraph_init_ops(struct ftrace_ops *dst_ops,
 		     struct ftrace_ops *src_ops)
 {
 	dst_ops->func = ftrace_graph_func;
-	dst_ops->flags = FTRACE_OPS_FL_PID | FTRACE_OPS_GRAPH_STUB;
+	dst_ops->flags = FTRACE_OPS_FL_PID | FTRACE_OPS_GRAPH_STUB |
+			 FTRACE_OPS_FL_SAVE_ARGS;
 
 #ifdef FTRACE_GRAPH_TRAMP_ADDR
 	dst_ops->trampoline = FTRACE_GRAPH_TRAMP_ADDR;
@@ -1118,10 +1131,14 @@ int register_ftrace_graph(struct fgraph_ops *gops)
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


