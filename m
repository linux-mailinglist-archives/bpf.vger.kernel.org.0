Return-Path: <bpf+bounces-28849-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2F788BE557
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 16:11:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A0091F229AC
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 14:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57DCB15E1E3;
	Tue,  7 May 2024 14:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="okt3O5sU"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79B915E7E4;
	Tue,  7 May 2024 14:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715091027; cv=none; b=krJKIds/PqovpTlTFmGeovv48nrEai+HLfObf6IoHJkHXpSLiXOhduYKP1mpsYk+kNjLYBJ4a1gZJBYmqpLQEkLcXcN4foiJ5NvjUNpwKp0q7271sJbk7rpKnSx4w2vtqDOYZVR6ynVa+tZYcXqZ1/7z2PpwCXGmKddUCP+74zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715091027; c=relaxed/simple;
	bh=47JfnNG1AKLO7xtttCIcDq3XSS5EMv0WKspBGJ5K0Jg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aawt6VaaUrMBeN4qcs+YMC9ccg5BW4byawrhKRuNtJ0qPhLhYAvd+ZHrE3LCHwY2teLjVk1wDLTKdnmMkMEmX/80UD46BsJ6n2BNZjZO49AOQAMRbYkuHkHdNOezxtaYVsWHFFoJz6GOFIBPkSiw5BxxushAWhdlCS1OCd1AazI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=okt3O5sU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26EA4C2BBFC;
	Tue,  7 May 2024 14:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715091027;
	bh=47JfnNG1AKLO7xtttCIcDq3XSS5EMv0WKspBGJ5K0Jg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=okt3O5sUwdVtJMnXcsbYaajspD9oH3umRcqSvIxrMCYPsaZegKc7HT2ZzjQMz4Qnk
	 ApO2y9ci0Xa/4Xr66qwB8BV+iaEur4ugkol8bW4TZorkoofXJBL5CydgPHGExSua8L
	 REUmdyefofCGP62pjceBRxegd09Nk/x9SFT1EvZ4Zwf8CT0Y3F1C80i/LxIwF1KpmM
	 fSfOJI8ya5xHIixHB4AUUB2rI6j3P0uJjmJ87TAo23YfNywitWnlGh4zuIL8n/YrKk
	 aYWwNK1HPQQmai8AEdSTkZsHTOjbjgdC+PqyuarMMxofo7wxRaDZQfr98ycrVw5cG6
	 Ysdt/7RAZNWRg==
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
Subject: [PATCH v10 12/36] function_graph: Have the instances use their own ftrace_ops for filtering
Date: Tue,  7 May 2024 23:10:20 +0900
Message-Id: <171509102088.162236.15758883237657317789.stgit@devnote2>
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

Allow for instances to have their own ftrace_ops part of the fgraph_ops
that makes the funtion_graph tracer filter on the set_ftrace_filter file
of the instance and not the top instance.

Note that this also requires to update ftrace_graph_func() to call new
function_graph_enter_ops() instead of function_graph_enter() so that
it avoid pushing on shadow stack multiple times on the same function.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 Changes in v10:
  - Use "offset" for shadow stack instead of "index".
 Changes in v9:
  - Fix to clear fgraph_array correctly when ftrace_startup() fails.
  - Return -ENOSPC if fgraph_array is full.
 Changes in v8:
  - Fix a compilation error in loongarch implementation.
  - Update riscv implementation of ftrace_graph_func().
 Changes in v7:
  - Move FGRAPH_TYPE_BITMAP type implementation to earlier patch (
    which implements FGRAPH_TYPE_ARRAY) so that it does not need to
    replace the FGRAPH_TYPE_ARRAY type.
  - Update loongarch and powerpc implementation of ftrace_graph_func().
  - Update description.
 Changes in v6:
  - Fix to check whether the fgraph_ops is already unregistered in
    function_graph_enter_ops().
  - Fix stack unwinder error on arm64 because of passing wrong value
    as retp. Thanks Mark!
 Changes in v4:
  - Simplify get_ret_stack() sanity check and use WARN_ON_ONCE() for
    obviously wrong value.
  - Do not check ret == return_to_handler but always read the previous
    ret_stack in ftrace_push_return_trace() to check it is reusable.
  - Set the bit 0 of the bitmap entry always in function_graph_enter()
    because it uses bit 0 to check re-usability.
  - Fix to ensure the ret_stack entry is bitmap type when checking the
    bitmap.
 Changes in v3:
  - Pass current fgraph_ops to the new entry handler
   (function_graph_enter_ops) if fgraph use ftrace.
  - Add fgraph_ops::idx in this patch.
  - Replace the array type with the bitmap type so that it can record
    which fgraph is called.
  - Fix some helper function to use passed task_struct instead of current.
  - Reduce the ret-index size to 1024 words.
  - Make the ret-index directly points the ret_stack.
  - Fix ftrace_graph_ret_addr() to handle tail-call case correctly.
 Changes in v2:
  - Use ftrace_graph_func and FTRACE_OPS_GRAPH_STUB instead of
    ftrace_stub and FTRACE_OPS_FL_STUB for new ftrace based fgraph.
---
 arch/arm64/kernel/ftrace.c           |   21 +++++-
 arch/loongarch/kernel/ftrace_dyn.c   |   15 ++++
 arch/powerpc/kernel/trace/ftrace.c   |    3 +
 arch/riscv/kernel/ftrace.c           |   15 ++++
 arch/x86/kernel/ftrace.c             |   19 +++++
 include/linux/ftrace.h               |    6 ++
 kernel/trace/fgraph.c                |  125 +++++++++++++++++++++++++---------
 kernel/trace/ftrace.c                |    4 +
 kernel/trace/trace.h                 |   16 ++--
 kernel/trace/trace_functions.c       |    2 -
 kernel/trace/trace_functions_graph.c |    8 ++
 11 files changed, 183 insertions(+), 51 deletions(-)

diff --git a/arch/arm64/kernel/ftrace.c b/arch/arm64/kernel/ftrace.c
index a650f5e11fc5..b96740829798 100644
--- a/arch/arm64/kernel/ftrace.c
+++ b/arch/arm64/kernel/ftrace.c
@@ -481,7 +481,26 @@ void prepare_ftrace_return(unsigned long self_addr, unsigned long *parent,
 void ftrace_graph_func(unsigned long ip, unsigned long parent_ip,
 		       struct ftrace_ops *op, struct ftrace_regs *fregs)
 {
-	prepare_ftrace_return(ip, &fregs->lr, fregs->fp);
+	struct fgraph_ops *gops = container_of(op, struct fgraph_ops, ops);
+	unsigned long frame_pointer = fregs->fp;
+	unsigned long *parent = &fregs->lr;
+	int bit;
+
+	if (unlikely(ftrace_graph_is_dead()))
+		return;
+
+	if (unlikely(atomic_read(&current->tracing_graph_pause)))
+		return;
+
+	bit = ftrace_test_recursion_trylock(ip, *parent);
+	if (bit < 0)
+		return;
+
+	if (!function_graph_enter_ops(*parent, ip, frame_pointer,
+				      (void *)frame_pointer, gops))
+		*parent = (unsigned long)&return_to_handler;
+
+	ftrace_test_recursion_unlock(bit);
 }
 #else
 /*
diff --git a/arch/loongarch/kernel/ftrace_dyn.c b/arch/loongarch/kernel/ftrace_dyn.c
index 73858c9029cc..920eb673b32b 100644
--- a/arch/loongarch/kernel/ftrace_dyn.c
+++ b/arch/loongarch/kernel/ftrace_dyn.c
@@ -241,10 +241,21 @@ void prepare_ftrace_return(unsigned long self_addr, unsigned long *parent)
 void ftrace_graph_func(unsigned long ip, unsigned long parent_ip,
 		       struct ftrace_ops *op, struct ftrace_regs *fregs)
 {
+	struct fgraph_ops *gops = container_of(op, struct fgraph_ops, ops);
+	unsigned long return_hooker = (unsigned long)&return_to_handler;
 	struct pt_regs *regs = &fregs->regs;
-	unsigned long *parent = (unsigned long *)&regs->regs[1];
+	unsigned long *parent;
+	unsigned long old;
+
+	parent = (unsigned long *)&regs->regs[1];
 
-	prepare_ftrace_return(ip, (unsigned long *)parent);
+	if (unlikely(atomic_read(&current->tracing_graph_pause)))
+		return;
+
+	old = *parent;
+
+	if (!function_graph_enter_ops(old, ip, 0, parent, gops))
+		*parent = return_hooker;
 }
 #else
 static int ftrace_modify_graph_caller(bool enable)
diff --git a/arch/powerpc/kernel/trace/ftrace.c b/arch/powerpc/kernel/trace/ftrace.c
index d8d6b4fd9a14..4a9294821c0d 100644
--- a/arch/powerpc/kernel/trace/ftrace.c
+++ b/arch/powerpc/kernel/trace/ftrace.c
@@ -421,6 +421,7 @@ int __init ftrace_dyn_arch_init(void)
 void ftrace_graph_func(unsigned long ip, unsigned long parent_ip,
 		       struct ftrace_ops *op, struct ftrace_regs *fregs)
 {
+	struct fgraph_ops *gops = container_of(op, struct fgraph_ops, ops);
 	unsigned long sp = fregs->regs.gpr[1];
 	int bit;
 
@@ -434,7 +435,7 @@ void ftrace_graph_func(unsigned long ip, unsigned long parent_ip,
 	if (bit < 0)
 		goto out;
 
-	if (!function_graph_enter(parent_ip, ip, 0, (unsigned long *)sp))
+	if (!function_graph_enter_ops(parent_ip, ip, 0, (unsigned long *)sp, gops))
 		parent_ip = ppc_function_entry(return_to_handler);
 
 	ftrace_test_recursion_unlock(bit);
diff --git a/arch/riscv/kernel/ftrace.c b/arch/riscv/kernel/ftrace.c
index f5aa24d9e1c1..eb86fb005f34 100644
--- a/arch/riscv/kernel/ftrace.c
+++ b/arch/riscv/kernel/ftrace.c
@@ -182,10 +182,23 @@ void prepare_ftrace_return(unsigned long *parent, unsigned long self_addr,
 void ftrace_graph_func(unsigned long ip, unsigned long parent_ip,
 		       struct ftrace_ops *op, struct ftrace_regs *fregs)
 {
+	struct fgraph_ops *gops = container_of(op, struct fgraph_ops, ops);
+	unsigned long return_hooker = (unsigned long)&return_to_handler;
 	struct pt_regs *regs = arch_ftrace_get_regs(fregs);
 	unsigned long *parent = (unsigned long *)&regs->ra;
+	unsigned long old;
+
+	if (unlikely(atomic_read(&current->tracing_graph_pause)))
+		return;
+
+	/*
+	 * We don't suffer access faults, so no extra fault-recovery assembly
+	 * is needed here.
+	 */
+	old = *parent;
 
-	prepare_ftrace_return(parent, ip, frame_pointer(regs));
+	if (!function_graph_enter_ops(old, ip, frame_pointer(regs), parent, gops))
+		*parent = return_hooker;
 }
 #else /* CONFIG_DYNAMIC_FTRACE_WITH_REGS */
 extern void ftrace_graph_call(void);
diff --git a/arch/x86/kernel/ftrace.c b/arch/x86/kernel/ftrace.c
index 70139d9d2e01..5e30cd69b8ab 100644
--- a/arch/x86/kernel/ftrace.c
+++ b/arch/x86/kernel/ftrace.c
@@ -658,9 +658,24 @@ void ftrace_graph_func(unsigned long ip, unsigned long parent_ip,
 		       struct ftrace_ops *op, struct ftrace_regs *fregs)
 {
 	struct pt_regs *regs = &fregs->regs;
-	unsigned long *stack = (unsigned long *)kernel_stack_pointer(regs);
+	unsigned long *parent = (unsigned long *)kernel_stack_pointer(regs);
+	struct fgraph_ops *gops = container_of(op, struct fgraph_ops, ops);
+	int bit;
+
+	if (unlikely(ftrace_graph_is_dead()))
+		return;
+
+	if (unlikely(atomic_read(&current->tracing_graph_pause)))
+		return;
 
-	prepare_ftrace_return(ip, (unsigned long *)stack, 0);
+	bit = ftrace_test_recursion_trylock(ip, *parent);
+	if (bit < 0)
+		return;
+
+	if (!function_graph_enter_ops(*parent, ip, 0, parent, gops))
+		*parent = (unsigned long)&return_to_handler;
+
+	ftrace_test_recursion_unlock(bit);
 }
 #endif
 
diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index c4d81e0ec862..b11af9d88438 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -1070,6 +1070,7 @@ extern int ftrace_graph_entry_stub(struct ftrace_graph_ent *trace, struct fgraph
 struct fgraph_ops {
 	trace_func_graph_ent_t		entryfunc;
 	trace_func_graph_ret_t		retfunc;
+	struct ftrace_ops		ops; /* for the hash lists */
 	void				*private;
 	int				idx;
 };
@@ -1105,6 +1106,11 @@ extern int
 function_graph_enter(unsigned long ret, unsigned long func,
 		     unsigned long frame_pointer, unsigned long *retp);
 
+extern int
+function_graph_enter_ops(unsigned long ret, unsigned long func,
+			 unsigned long frame_pointer, unsigned long *retp,
+			 struct fgraph_ops *gops);
+
 struct ftrace_ret_stack *
 ftrace_graph_get_ret_stack(struct task_struct *task, int skip);
 
diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index 1fcbae5cc6d6..b6949e4fda79 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -18,14 +18,6 @@
 #include "ftrace_internal.h"
 #include "trace.h"
 
-#ifdef CONFIG_DYNAMIC_FTRACE
-#define ASSIGN_OPS_HASH(opsname, val) \
-	.func_hash		= val, \
-	.local_hash.regex_lock	= __MUTEX_INITIALIZER(opsname.local_hash.regex_lock),
-#else
-#define ASSIGN_OPS_HASH(opsname, val)
-#endif
-
 #define FGRAPH_FRAME_SIZE sizeof(struct ftrace_ret_stack)
 #define FGRAPH_FRAME_OFFSET DIV_ROUND_UP(FGRAPH_FRAME_SIZE, sizeof(long))
 
@@ -379,7 +371,8 @@ int function_graph_enter(unsigned long ret, unsigned long func,
 		if (gops == &fgraph_stub)
 			continue;
 
-		if (gops->entryfunc(&trace, gops))
+		if (ftrace_ops_test(&gops->ops, func, NULL) &&
+		    gops->entryfunc(&trace, gops))
 			bitmap |= BIT(i);
 	}
 
@@ -400,6 +393,46 @@ int function_graph_enter(unsigned long ret, unsigned long func,
 	return -EBUSY;
 }
 
+/* This is called from ftrace_graph_func() via ftrace */
+int function_graph_enter_ops(unsigned long ret, unsigned long func,
+			     unsigned long frame_pointer, unsigned long *retp,
+			     struct fgraph_ops *gops)
+{
+	struct ftrace_graph_ent trace;
+	int offset;
+	int type;
+
+	/* Check whether the fgraph_ops is unregistered. */
+	if (unlikely(fgraph_array[gops->idx] == &fgraph_stub))
+		return -ENODEV;
+
+	/* Use start for the distance to ret_stack (skipping over reserve) */
+	offset = ftrace_push_return_trace(ret, func, frame_pointer, retp, gops->idx);
+	if (offset < 0)
+		return offset;
+	type = get_fgraph_type(current, offset);
+
+	/* This is the first ret_stack for this fentry */
+	if (type == FGRAPH_TYPE_RESERVED)
+		++current->curr_ret_depth;
+
+	trace.func = func;
+	trace.depth = current->curr_ret_depth;
+	if (gops->entryfunc(&trace, gops)) {
+		if (type == FGRAPH_TYPE_RESERVED)
+			set_fgraph_index_bitmap(current, offset, BIT(gops->idx));
+		else
+			add_fgraph_index_bitmap(current, offset, BIT(gops->idx));
+		return 0;
+	}
+
+	if (type == FGRAPH_TYPE_RESERVED) {
+		current->curr_ret_stack -= FGRAPH_FRAME_OFFSET + 1;
+		current->curr_ret_depth--;
+	}
+	return -EBUSY;
+}
+
 /* Retrieve a function return address to the trace stack on thread info.*/
 static struct ftrace_ret_stack *
 ftrace_pop_return_trace(struct ftrace_graph_ret *trace, unsigned long *ret,
@@ -660,17 +693,25 @@ unsigned long ftrace_graph_ret_addr(struct task_struct *task, int *idx,
 }
 #endif /* HAVE_FUNCTION_GRAPH_RET_ADDR_PTR */
 
-static struct ftrace_ops graph_ops = {
-	.func			= ftrace_graph_func,
-	.flags			= FTRACE_OPS_FL_INITIALIZED |
-				   FTRACE_OPS_FL_PID |
-				   FTRACE_OPS_GRAPH_STUB,
+void fgraph_init_ops(struct ftrace_ops *dst_ops,
+		     struct ftrace_ops *src_ops)
+{
+	dst_ops->func = ftrace_graph_func;
+	dst_ops->flags = FTRACE_OPS_FL_PID | FTRACE_OPS_GRAPH_STUB;
+
 #ifdef FTRACE_GRAPH_TRAMP_ADDR
-	.trampoline		= FTRACE_GRAPH_TRAMP_ADDR,
+	dst_ops->trampoline = FTRACE_GRAPH_TRAMP_ADDR;
 	/* trampoline_size is only needed for dynamically allocated tramps */
 #endif
-	ASSIGN_OPS_HASH(graph_ops, &global_ops.local_hash)
-};
+
+#ifdef CONFIG_DYNAMIC_FTRACE
+	if (src_ops) {
+		dst_ops->func_hash = &src_ops->local_hash;
+		mutex_init(&dst_ops->local_hash.regex_lock);
+		dst_ops->flags |= FTRACE_OPS_FL_INITIALIZED;
+	}
+#endif
+}
 
 void ftrace_graph_sleep_time_control(bool enable)
 {
@@ -874,11 +915,20 @@ static int start_graph_tracing(void)
 
 int register_ftrace_graph(struct fgraph_ops *gops)
 {
+	int command = 0;
 	int ret = 0;
 	int i;
 
 	mutex_lock(&ftrace_lock);
 
+	if (!gops->ops.func) {
+		gops->ops.flags |= FTRACE_OPS_GRAPH_STUB;
+		gops->ops.func = ftrace_graph_func;
+#ifdef FTRACE_GRAPH_TRAMP_ADDR
+		gops->ops.trampoline = FTRACE_GRAPH_TRAMP_ADDR;
+#endif
+	}
+
 	if (!fgraph_array[0]) {
 		/* The array must always have real data on it */
 		for (i = 0; i < FGRAPH_ARRAY_SIZE; i++)
@@ -891,7 +941,7 @@ int register_ftrace_graph(struct fgraph_ops *gops)
 			break;
 	}
 	if (i >= FGRAPH_ARRAY_SIZE) {
-		ret = -EBUSY;
+		ret = -ENOSPC;
 		goto out;
 	}
 
@@ -905,18 +955,22 @@ int register_ftrace_graph(struct fgraph_ops *gops)
 	if (ftrace_graph_active == 1) {
 		register_pm_notifier(&ftrace_suspend_notifier);
 		ret = start_graph_tracing();
-		if (ret) {
-			ftrace_graph_active--;
-			goto out;
-		}
+		if (ret)
+			goto error;
 		/*
 		 * Some archs just test to see if these are not
 		 * the default function
 		 */
 		ftrace_graph_return = return_run;
 		ftrace_graph_entry = entry_run;
+		command = FTRACE_START_FUNC_RET;
+	}
 
-		ret = ftrace_startup(&graph_ops, FTRACE_START_FUNC_RET);
+	ret = ftrace_startup(&gops->ops, command);
+error:
+	if (ret) {
+		fgraph_array[i] = &fgraph_stub;
+		ftrace_graph_active--;
 	}
 out:
 	mutex_unlock(&ftrace_lock);
@@ -925,6 +979,7 @@ int register_ftrace_graph(struct fgraph_ops *gops)
 
 void unregister_ftrace_graph(struct fgraph_ops *gops)
 {
+	int command = 0;
 	int i;
 
 	mutex_lock(&ftrace_lock);
@@ -932,25 +987,29 @@ void unregister_ftrace_graph(struct fgraph_ops *gops)
 	if (unlikely(!ftrace_graph_active))
 		goto out;
 
-	for (i = 0; i < fgraph_array_cnt; i++)
-		if (gops == fgraph_array[i])
-			break;
-	if (i >= fgraph_array_cnt)
+	if (unlikely(gops->idx < 0 || gops->idx >= fgraph_array_cnt))
 		goto out;
 
-	fgraph_array[i] = &fgraph_stub;
-	if (i + 1 == fgraph_array_cnt) {
-		for (; i >= 0; i--)
-			if (fgraph_array[i] != &fgraph_stub)
-				break;
+	WARN_ON_ONCE(fgraph_array[gops->idx] != gops);
+
+	fgraph_array[gops->idx] = &fgraph_stub;
+	if (gops->idx + 1 == fgraph_array_cnt) {
+		i = gops->idx;
+		while (i >= 0 && fgraph_array[i] == &fgraph_stub)
+			i--;
 		fgraph_array_cnt = i + 1;
 	}
 
 	ftrace_graph_active--;
+
+	if (!ftrace_graph_active)
+		command = FTRACE_STOP_FUNC_RET;
+
+	ftrace_shutdown(&gops->ops, command);
+
 	if (!ftrace_graph_active) {
 		ftrace_graph_return = ftrace_stub_graph;
 		ftrace_graph_entry = ftrace_graph_entry_stub;
-		ftrace_shutdown(&graph_ops, FTRACE_STOP_FUNC_RET);
 		unregister_pm_notifier(&ftrace_suspend_notifier);
 		unregister_trace_sched_switch(ftrace_graph_probe_sched_switch, NULL);
 	}
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 92abb9869198..45fd2710f81b 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -3017,6 +3017,8 @@ int ftrace_startup(struct ftrace_ops *ops, int command)
 	if (unlikely(ftrace_disabled))
 		return -ENODEV;
 
+	ftrace_ops_init(ops);
+
 	ret = __register_ftrace_function(ops);
 	if (ret)
 		return ret;
@@ -7326,7 +7328,7 @@ __init void ftrace_init_global_array_ops(struct trace_array *tr)
 	tr->ops = &global_ops;
 	tr->ops->private = tr;
 	ftrace_init_trace_array(tr);
-	init_array_fgraph_ops(tr);
+	init_array_fgraph_ops(tr, tr->ops);
 }
 
 void ftrace_init_array_ops(struct trace_array *tr, ftrace_func_t func)
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 114b120afd2a..9995d6b00a93 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -893,8 +893,8 @@ extern int __trace_graph_entry(struct trace_array *tr,
 extern void __trace_graph_return(struct trace_array *tr,
 				 struct ftrace_graph_ret *trace,
 				 unsigned int trace_ctx);
-extern void init_array_fgraph_ops(struct trace_array *tr);
-extern int allocate_fgraph_ops(struct trace_array *tr);
+extern void init_array_fgraph_ops(struct trace_array *tr, struct ftrace_ops *ops);
+extern int allocate_fgraph_ops(struct trace_array *tr, struct ftrace_ops *ops);
 extern void free_fgraph_ops(struct trace_array *tr);
 
 #ifdef CONFIG_DYNAMIC_FTRACE
@@ -977,6 +977,7 @@ static inline int ftrace_graph_notrace_addr(unsigned long addr)
 	preempt_enable_notrace();
 	return ret;
 }
+
 #else
 static inline int ftrace_graph_addr(struct ftrace_graph_ent *trace)
 {
@@ -1002,18 +1003,19 @@ static inline bool ftrace_graph_ignore_func(struct ftrace_graph_ent *trace)
 		(fgraph_max_depth && trace->depth >= fgraph_max_depth);
 }
 
+void fgraph_init_ops(struct ftrace_ops *dst_ops,
+		     struct ftrace_ops *src_ops);
+
 #else /* CONFIG_FUNCTION_GRAPH_TRACER */
 static inline enum print_line_t
 print_graph_function_flags(struct trace_iterator *iter, u32 flags)
 {
 	return TRACE_TYPE_UNHANDLED;
 }
-static inline void init_array_fgraph_ops(struct trace_array *tr) { }
-static inline int allocate_fgraph_ops(struct trace_array *tr)
-{
-	return 0;
-}
 static inline void free_fgraph_ops(struct trace_array *tr) { }
+/* ftrace_ops may not be defined */
+#define init_array_fgraph_ops(tr, ops) do { } while (0)
+#define allocate_fgraph_ops(tr, ops) ({ 0; })
 #endif /* CONFIG_FUNCTION_GRAPH_TRACER */
 
 extern struct list_head ftrace_pids;
diff --git a/kernel/trace/trace_functions.c b/kernel/trace/trace_functions.c
index 8e8da0d0ee52..13bf2415245d 100644
--- a/kernel/trace/trace_functions.c
+++ b/kernel/trace/trace_functions.c
@@ -91,7 +91,7 @@ int ftrace_create_function_files(struct trace_array *tr,
 	if (!tr->ops)
 		return -EINVAL;
 
-	ret = allocate_fgraph_ops(tr);
+	ret = allocate_fgraph_ops(tr, tr->ops);
 	if (ret) {
 		kfree(tr->ops);
 		return ret;
diff --git a/kernel/trace/trace_functions_graph.c b/kernel/trace/trace_functions_graph.c
index 9ccc904a7703..7f30652f0e97 100644
--- a/kernel/trace/trace_functions_graph.c
+++ b/kernel/trace/trace_functions_graph.c
@@ -288,7 +288,7 @@ static struct fgraph_ops funcgraph_ops = {
 	.retfunc = &trace_graph_return,
 };
 
-int allocate_fgraph_ops(struct trace_array *tr)
+int allocate_fgraph_ops(struct trace_array *tr, struct ftrace_ops *ops)
 {
 	struct fgraph_ops *gops;
 
@@ -301,6 +301,9 @@ int allocate_fgraph_ops(struct trace_array *tr)
 
 	tr->gops = gops;
 	gops->private = tr;
+
+	fgraph_init_ops(&gops->ops, ops);
+
 	return 0;
 }
 
@@ -309,10 +312,11 @@ void free_fgraph_ops(struct trace_array *tr)
 	kfree(tr->gops);
 }
 
-__init void init_array_fgraph_ops(struct trace_array *tr)
+__init void init_array_fgraph_ops(struct trace_array *tr, struct ftrace_ops *ops)
 {
 	tr->gops = &funcgraph_ops;
 	funcgraph_ops.private = tr;
+	fgraph_init_ops(&tr->gops->ops, ops);
 }
 
 static int graph_trace_init(struct trace_array *tr)


