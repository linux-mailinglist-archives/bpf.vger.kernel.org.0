Return-Path: <bpf+bounces-17155-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8170280A0D3
	for <lists+bpf@lfdr.de>; Fri,  8 Dec 2023 11:28:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94CEA1C209D0
	for <lists+bpf@lfdr.de>; Fri,  8 Dec 2023 10:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34F9A18E0E;
	Fri,  8 Dec 2023 10:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LELoD5+M"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C1214ABF;
	Fri,  8 Dec 2023 10:28:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C59A2C433C8;
	Fri,  8 Dec 2023 10:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702031304;
	bh=GdHQ069T+AoIplKcM5E+5FNSoRMc79P1ef7Z465uBBM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LELoD5+MUlDEUFPOclNqC3VO2iP6y2l6DgTsDxhuJNoqcC9EcaUaLGHxHNczuZOoI
	 0ZfINqzzolXAUkwGGMH/v9pel8eUxuQFK2xf7j9jeXt5TR8QSA2hVWTxFh+vXf+YQH
	 Y0TjfcC63w8Qb12D4yR5F/acfcI5IYdlSm+PtpX8sQo+fkNBYXktp6Y4CNOQ1JIaTv
	 D2fvTRKFAk//nb9D8pFlxZw7ZUmJ1RPfnXPhOy28O9ckvc/KbzukOaiyOHN8MMP6Pu
	 v+126y9otuxWsGfg8smt6rcfDmeFGR1X00NFOeZU33LlUZ22IDhWRRjZYfZqEdVYRO
	 dVZJd0pWqKQvg==
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
Subject: [PATCH v4 20/33] function_graph: Add a new exit handler with parent_ip and ftrace_regs
Date: Fri,  8 Dec 2023 19:28:18 +0900
Message-Id: <170203129774.579004.3666795448412962010.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <170203105427.579004.8033550792660734570.stgit@devnote2>
References: <170203105427.579004.8033550792660734570.stgit@devnote2>
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

Add a new return handler to fgraph_ops as 'retregfunc'  which takes
parent_ip and ftrace_regs instead of ftrace_graph_ret. This handler
is available only if the arch support CONFIG_HAVE_FUNCTION_GRAPH_FREGS.
Note that the 'retfunc' and 'reregfunc' are mutual exclusive.
You can set only one of them.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 Changes in v3:
  - Update for new multiple fgraph.
  - Save the return address to instruction pointer in ftrace_regs.
---
 arch/x86/include/asm/ftrace.h |    2 +
 include/linux/ftrace.h        |   10 +++++-
 kernel/trace/Kconfig          |    5 ++-
 kernel/trace/fgraph.c         |   70 ++++++++++++++++++++++++++++-------------
 4 files changed, 63 insertions(+), 24 deletions(-)

diff --git a/arch/x86/include/asm/ftrace.h b/arch/x86/include/asm/ftrace.h
index 415cf7a2ec2c..0b306c82855d 100644
--- a/arch/x86/include/asm/ftrace.h
+++ b/arch/x86/include/asm/ftrace.h
@@ -72,6 +72,8 @@ arch_ftrace_get_regs(struct ftrace_regs *fregs)
 	override_function_with_return(&(fregs)->regs)
 #define ftrace_regs_query_register_offset(name) \
 	regs_query_register_offset(name)
+#define ftrace_regs_get_frame_pointer(fregs) \
+	frame_pointer(&(fregs)->regs)
 
 struct ftrace_ops;
 #define ftrace_graph_func ftrace_graph_func
diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 6da6cc9aaeaf..79875a00c02b 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -43,7 +43,9 @@ struct dyn_ftrace;
 
 char *arch_ftrace_match_adjust(char *str, const char *search);
 
-#ifdef CONFIG_HAVE_FUNCTION_GRAPH_RETVAL
+#ifdef CONFIG_HAVE_FUNCTION_GRAPH_FREGS
+unsigned long ftrace_return_to_handler(struct ftrace_regs *fregs);
+#elif defined(CONFIG_HAVE_FUNCTION_GRAPH_RETVAL)
 struct fgraph_ret_regs;
 unsigned long ftrace_return_to_handler(struct fgraph_ret_regs *ret_regs);
 #else
@@ -157,6 +159,7 @@ struct ftrace_regs {
 #define ftrace_regs_set_instruction_pointer(fregs, ip) do { } while (0)
 #endif /* CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS */
 
+
 static __always_inline struct pt_regs *ftrace_get_regs(struct ftrace_regs *fregs)
 {
 	if (!fregs)
@@ -1067,6 +1070,10 @@ typedef int (*trace_func_graph_regs_ent_t)(unsigned long func,
 					   unsigned long parent_ip,
 					   struct ftrace_regs *fregs,
 					   struct fgraph_ops *); /* entry w/ regs */
+typedef void (*trace_func_graph_regs_ret_t)(unsigned long func,
+					    unsigned long parent_ip,
+					    struct ftrace_regs *,
+					    struct fgraph_ops *); /* return w/ regs */
 
 extern int ftrace_graph_entry_stub(struct ftrace_graph_ent *trace, struct fgraph_ops *gops);
 
@@ -1076,6 +1083,7 @@ struct fgraph_ops {
 	trace_func_graph_ent_t		entryfunc;
 	trace_func_graph_ret_t		retfunc;
 	trace_func_graph_regs_ent_t	entryregfunc;
+	trace_func_graph_regs_ret_t	retregfunc;
 	struct ftrace_ops		ops; /* for the hash lists */
 	void				*private;
 	int				idx;
diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index 61c541c36596..308b3bec01b1 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -34,6 +34,9 @@ config HAVE_FUNCTION_GRAPH_TRACER
 config HAVE_FUNCTION_GRAPH_RETVAL
 	bool
 
+config HAVE_FUNCTION_GRAPH_FREGS
+	bool
+
 config HAVE_DYNAMIC_FTRACE
 	bool
 	help
@@ -232,7 +235,7 @@ config FUNCTION_GRAPH_TRACER
 
 config FUNCTION_GRAPH_RETVAL
 	bool "Kernel Function Graph Return Value"
-	depends on HAVE_FUNCTION_GRAPH_RETVAL
+	depends on HAVE_FUNCTION_GRAPH_RETVAL || HAVE_FUNCTION_GRAPH_FREGS
 	depends on FUNCTION_GRAPH_TRACER
 	default n
 	help
diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index 95b3eb4e8e23..0ac242d22724 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -685,8 +685,8 @@ int function_graph_enter_ops(unsigned long ret, unsigned long func,
 
 /* Retrieve a function return address to the trace stack on thread info.*/
 static struct ftrace_ret_stack *
-ftrace_pop_return_trace(struct ftrace_graph_ret *trace, unsigned long *ret,
-			unsigned long frame_pointer, int *index)
+ftrace_pop_return_trace(unsigned long *ret, unsigned long frame_pointer,
+			int *index)
 {
 	struct ftrace_ret_stack *ret_stack;
 
@@ -731,10 +731,6 @@ ftrace_pop_return_trace(struct ftrace_graph_ret *trace, unsigned long *ret,
 
 	*index += FGRAPH_RET_INDEX;
 	*ret = ret_stack->ret;
-	trace->func = ret_stack->func;
-	trace->calltime = ret_stack->calltime;
-	trace->overrun = atomic_read(&current->trace_overrun);
-	trace->depth = current->curr_ret_depth;
 	/*
 	 * We still want to trace interrupts coming in if
 	 * max_depth is set to 1. Make sure the decrement is
@@ -773,21 +769,42 @@ static struct notifier_block ftrace_suspend_notifier = {
 /* fgraph_ret_regs is not defined without CONFIG_FUNCTION_GRAPH_RETVAL */
 struct fgraph_ret_regs;
 
+static void fgraph_call_retfunc(struct ftrace_regs *fregs,
+				struct fgraph_ret_regs *ret_regs,
+				struct ftrace_ret_stack *ret_stack,
+				struct fgraph_ops *gops)
+{
+	struct ftrace_graph_ret trace;
+
+	trace.func = ret_stack->func;
+	trace.calltime = ret_stack->calltime;
+	trace.overrun = atomic_read(&current->trace_overrun);
+	trace.depth = current->curr_ret_depth;
+	trace.rettime = trace_clock_local();
+#ifdef CONFIG_FUNCTION_GRAPH_RETVAL
+	if (fregs)
+		trace.retval = ftrace_regs_return_value(fregs);
+	else
+		trace.retval = fgraph_ret_regs_return_value(ret_regs);
+#endif
+	gops->retfunc(&trace, gops);
+}
+
 /*
  * Send the trace to the ring-buffer.
  * @return the original return address.
  */
-static unsigned long __ftrace_return_to_handler(struct fgraph_ret_regs *ret_regs,
+static unsigned long __ftrace_return_to_handler(struct ftrace_regs *fregs,
+						struct fgraph_ret_regs *ret_regs,
 						unsigned long frame_pointer)
 {
 	struct ftrace_ret_stack *ret_stack;
-	struct ftrace_graph_ret trace;
 	unsigned long bitmap;
 	unsigned long ret;
 	int index;
 	int i;
 
-	ret_stack = ftrace_pop_return_trace(&trace, &ret, frame_pointer, &index);
+	ret_stack = ftrace_pop_return_trace(&ret, frame_pointer, &index);
 
 	if (unlikely(!ret_stack)) {
 		ftrace_graph_stop();
@@ -796,10 +813,8 @@ static unsigned long __ftrace_return_to_handler(struct fgraph_ret_regs *ret_regs
 		return (unsigned long)panic;
 	}
 
-	trace.rettime = trace_clock_local();
-#ifdef CONFIG_FUNCTION_GRAPH_RETVAL
-	trace.retval = fgraph_ret_regs_return_value(ret_regs);
-#endif
+	if (fregs)
+		ftrace_regs_set_instruction_pointer(fregs, ret);
 
 	bitmap = get_fgraph_index_bitmap(current, index);
 	for (i = 0; i < FGRAPH_ARRAY_SIZE; i++) {
@@ -810,7 +825,10 @@ static unsigned long __ftrace_return_to_handler(struct fgraph_ret_regs *ret_regs
 		if (gops == &fgraph_stub)
 			continue;
 
-		gops->retfunc(&trace, gops);
+		if (gops->retregfunc)
+			gops->retregfunc(ret_stack->func, ret, fregs, gops);
+		else
+			fgraph_call_retfunc(fregs, ret_regs, ret_stack, gops);
 	}
 
 	/*
@@ -825,20 +843,22 @@ static unsigned long __ftrace_return_to_handler(struct fgraph_ret_regs *ret_regs
 	return ret;
 }
 
-/*
- * After all architecures have selected HAVE_FUNCTION_GRAPH_RETVAL, we can
- * leave only ftrace_return_to_handler(ret_regs).
- */
-#ifdef CONFIG_HAVE_FUNCTION_GRAPH_RETVAL
+#ifdef CONFIG_HAVE_FUNCTION_GRAPH_FREGS
+unsigned long ftrace_return_to_handler(struct ftrace_regs *fregs)
+{
+	return __ftrace_return_to_handler(fregs, NULL,
+				ftrace_regs_get_frame_pointer(fregs));
+}
+#elif defined(CONFIG_HAVE_FUNCTION_GRAPH_RETVAL)
 unsigned long ftrace_return_to_handler(struct fgraph_ret_regs *ret_regs)
 {
-	return __ftrace_return_to_handler(ret_regs,
+	return __ftrace_return_to_handler(NULL, ret_regs,
 				fgraph_ret_regs_frame_pointer(ret_regs));
 }
 #else
 unsigned long ftrace_return_to_handler(unsigned long frame_pointer)
 {
-	return __ftrace_return_to_handler(NULL, frame_pointer);
+	return __ftrace_return_to_handler(NULL, NULL, frame_pointer);
 }
 #endif
 
@@ -1191,9 +1211,15 @@ int register_ftrace_graph(struct fgraph_ops *gops)
 	int ret = 0;
 	int i;
 
-	if (gops->entryfunc && gops->entryregfunc)
+	if ((gops->entryfunc && gops->entryregfunc) ||
+	    (gops->retfunc && gops->retregfunc))
 		return -EINVAL;
 
+#ifndef CONFIG_HAVE_FUNCTION_GRAPH_FREGS
+	if (gops->retregfunc)
+		return -EOPNOTSUPP;
+#endif
+
 	mutex_lock(&ftrace_lock);
 
 	if (!gops->ops.func) {


